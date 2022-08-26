using System;
using System.Data;
using System.Linq;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;

using System.Xml;

using System.Text.RegularExpressions;


public partial class GUI_Operations_THCGeneration_THCGeneration : BasePage
{
    private string DOCNO { get { return (ViewState["DOCNO"] != null) ? ViewState["DOCNO"].ToString() : ""; } set { ViewState["DOCNO"] = value; } }
    private string DOC_TYP { get { return (ViewState["DOC_TYP"] != null) ? ViewState["DOC_TYP"].ToString() : ""; } set { ViewState["DOC_TYP"] = value; } }
    private string TranXaction { get { return (ViewState["TranXaction"] != null) ? ViewState["TranXaction"].ToString() : ""; } set { ViewState["TranXaction"] = value; } }
    private bool IsError { get { return (ViewState["IsError"] != null) ? Convert.ToBoolean(ViewState["IsError"]) : false; } set { ViewState["IsError"] = value; } }


    public string xmlTCHDR { get { return (ViewState["xmlTCHDR"] != null) ? ViewState["xmlTCHDR"].ToString() : ""; } set { ViewState["xmlTCHDR"] = value; } }
    public string xmlTCTRN { get { return (ViewState["xmlTCTRN"] != null) ? ViewState["xmlTCTRN"].ToString() : ""; } set { ViewState["xmlTCTRN"] = value; } }
    public string xmlWTDS { get { return (ViewState["xmlWTDS"] != null) ? ViewState["xmlWTDS"].ToString() : ""; } set { ViewState["xmlWTDS"] = value; } }
    public string xmlTHCSummary { get { return (ViewState["xmlTHCSummary"] != null) ? ViewState["xmlTHCSummary"].ToString() : ""; } set { ViewState["xmlTHCSummary"] = value; } }
    public string xmlTCSummary { get { return (ViewState["xmlTCSummary"] != null) ? ViewState["xmlTCSummary"].ToString() : ""; } set { ViewState["xmlTCSummary"] = value; } }
    private bool Allow_TAM
    {
        get { return (ViewState["Allow_TAM"] != null) ? Convert.ToBoolean(ViewState["Allow_TAM"]) : false; }
        set { ViewState["Allow_TAM"] = value; }
    }
    public string IsTAM_Mandetory
    {
        get { return (ViewState["IsTAM_Mandetory"] != null) ? ViewState["IsTAM_Mandetory"].ToString() : "N"; }
        set { ViewState["IsTAM_Mandetory"] = value; }
    }
    private bool Allow_Adhoc
    {
        get { return (ViewState["Allow_Adhoc"] != null) ? Convert.ToBoolean(ViewState["Allow_Adhoc"]) : false; }
        set { ViewState["Allow_Adhoc"] = value; }
    }
	
	public void OnChkIsTransshipmentChangeCodeBehind()
    {

        if (chkIsTransshipment.Checked == false)
        {
            txtTransitLocation.Text = "";
            txtTransitTentativeFreight.Text = "0";
            txtTransitRemark.Text = "";
            txtTransitTentativeFreight.Enabled = false;
            txtTransitLocation.Enabled = false;
            txtTransitRemark.Enabled = false;
        }

    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMainHdr.Text = "Prepare New " + Session["THCCalledAs"].ToString();
        lblManualTHCNo.Text = "Manual " + Session["THCCalledAs"].ToString() + " No";
        lblTHCDate.Text = Session["THCCalledAs"].ToString() + " Date ";
        lblTHCTime.Text = Session["THCCalledAs"].ToString() + " Time ";
        hdnTHCCalledAs.Value = Session["THCCalledAs"].ToString();
        hdnDKTCalleAs.Value = Session["DocketCalledAs"].ToString();
        DataSet ds = THCController.GetStep1Details();
        GetRuleDetails();
		OnChkIsTransshipmentChangeCodeBehind();

        //MySQLDataSource_TS.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_TDSAccCode.ConnectionString = Session["SqlProvider"].ToString().Trim();

        string THCType = Request.QueryString["THCType"].ToString();
        hdnTHCType.Value = THCType;
        hdnSystemDate.Value = DateTime.Now.ToString("dd/MM/yyyy");

        txtLoadSupCode.Text = Session["empcd"].ToString().Trim();
        balamtbr.Text = Session["brcd"].ToString().Trim();


        if (THCType == "2")
        {
            chkIsEmptyVehicle.Visible = false;
            lblRouteName.Text = "Enter Destination (BTH)";
            dllRouteName.Visible = false;
            txtTHCDestination.Visible = true;

        }
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            string BasePath = Server.MapPath("~/UploadedImages/THC");

            string UserName = SessionUtilities.CurrentEmployeeID.ToString();

            if (Directory.Exists(BasePath + @"\" + UserName))
            {
                Directory.Delete(BasePath + @"\" + UserName, true);
            }


            Allow_Adhoc = IsAdhocAllowed("THC");
            if (THCType == "2")
            {
                int dkts = BindDocketsForTHC();

            }
            dllRouteMode.DataSource = ds.Tables[0];
            dllRouteMode.DataBind();

            if (dllRouteMode.Items.Count == 2)
            {
                dllRouteMode.Items.Remove(new ListItem("--Select--", ""));
                RouteModeChange();
            }

            dllRouteMode.SelectedValue = "S";
            RouteModeChange();

            dllLateDeptReason.DataSource = ds.Tables[1];
            dllLateDeptReason.DataBind();

            txtTHCDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtTHCTime.Text = DateTime.Now.ToString("HH:mm");
            txtActDeptTime.Text = DateTime.Now.ToString("HH:mm");
        }
    }
    private bool IsAdhocAllowed(string DocType)
    {
        bool bRet = false;
        string RULE_VALUE = "";

        string strQuery = "SELECT TOP 1 ISNULL(RULE_VALUE,'') AS RULE_VALUE FROM dbo.Webx_Modules_Rules WHERE RULEID='THC_ADHOC_CONTRACT' AND ISNULL(RULE_Y_N,'')='Y'";
        object objO = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strQuery);
        if (objO != null)
        {
            RULE_VALUE = objO.ToString();
        }
        bRet = (RULE_VALUE.ToUpper() == "Y");
        return bRet;

    }
    protected void GetRuleDetails()
    {
        //THC Date Disabled/enabled
        DataTable dtTHC_DATE_ENABLED = THCController.GetTHCGenerationRule().Tables[0];
        DataRow drTHC_DATE_ENABLED;
        if (dtTHC_DATE_ENABLED.Rows.Count > 0)
        {
            drTHC_DATE_ENABLED = dtTHC_DATE_ENABLED.Rows[0];
            if (drTHC_DATE_ENABLED["Rule_Y_N"].ToString() == "N")
                txtTHCDate.Enabled = false;
        }

        //Empty Vehicle Enabled
        DataTable dtTHC_IsEmptyVehicle = THCController.GetTHCGenerationRule().Tables[1];
        DataRow drTHC_IsEmptyVehicle;
        if (dtTHC_IsEmptyVehicle.Rows.Count > 0)
        {
            drTHC_IsEmptyVehicle = dtTHC_IsEmptyVehicle.Rows[0];
            if (drTHC_IsEmptyVehicle["Rule_Y_N"].ToString() == "N")
                chkIsEmptyVehicle.Enabled = false;
        }

        //Route Display For THC (THC From Docket)
        DataTable dtTHC_RouteDisplay = THCController.GetTHCGenerationRule().Tables[2];
        DataRow drTHC_RouteDisplay;
        if (dtTHC_RouteDisplay.Rows.Count > 0)
        {
            drTHC_RouteDisplay = dtTHC_RouteDisplay.Rows[0];
            if (drTHC_RouteDisplay["Rule_Y_N"].ToString() == "N")
                trRouteDetails.Style["display"] = "none";
        }

        //Select City
        DataTable dtTHC_CITY_ALLOWED = THCController.GetTHCGenerationRule().Tables[3];
        DataRow drTHC_CITY_ALLOWED;
        if (dtTHC_CITY_ALLOWED.Rows.Count > 0)
        {
            drTHC_CITY_ALLOWED = dtTHC_CITY_ALLOWED.Rows[0];
            if (drTHC_CITY_ALLOWED["Rule_Y_N"].ToString() == "N")
                chkCity.Enabled = false;
        }

        //Route Display For THC (THC From Docket)
        DataTable dtUSE_SCHEDULE_ROUTE = THCController.GetTHCGenerationRule().Tables[4];
        DataRow drUSE_SCHEDULE_ROUTE;
        if (dtUSE_SCHEDULE_ROUTE.Rows.Count > 0)
        {
            drUSE_SCHEDULE_ROUTE = dtUSE_SCHEDULE_ROUTE.Rows[0];
            if (drUSE_SCHEDULE_ROUTE["Rule_Y_N"].ToString() == "N")
                trSchedule.Style["display"] = "none";
        }

        //Contract Enabled
        DataTable dtTHC_ContractDisplay = THCController.GetTHCGenerationRule().Tables[5];
        DataRow drTHC_ContractDisplay;
        if (dtTHC_ContractDisplay.Rows.Count > 0)
        {
            // trContractDetails.Style["display"] = "block";
            drTHC_ContractDisplay = dtTHC_ContractDisplay.Rows[0];
            if (drTHC_ContractDisplay["Rule_Y_N"].ToString() == "N")
                trContractDetails.Style["display"] = "none";

        }

        //Ad-hoc Contract Yes/No
        DataTable dtTHC_ADHOC_CONTRACT = THCController.GetTHCGenerationRule().Tables[6];
        DataRow drTHC_ADHOC_CONTRACT;
        if (dtTHC_ADHOC_CONTRACT.Rows.Count > 0)
        {
            drTHC_ADHOC_CONTRACT = dtTHC_ADHOC_CONTRACT.Rows[0];
            if (drTHC_ADHOC_CONTRACT["Rule_Y_N"].ToString() == "N")
                chkAdHocContract.Enabled = false;
        }

        //TAM Enabled  
        DataTable dtTAM_Enabled = THCController.GetTHCGenerationRule().Tables[6];
        DataRow drTAM_Enabled;
        if (dtTAM_Enabled.Rows.Count > 0)
        {
            drTAM_Enabled = dtTAM_Enabled.Rows[0];
            if (drTAM_Enabled["Rule_Y_N"].ToString() == "N")
                Allow_TAM = false;
            else
                Allow_TAM = false;
        }

        //Mandetory TAM Yes/No 
        DataTable dtMandetory_TAM = THCController.GetTHCGenerationRule().Tables[6];
        DataRow drMandetory_TAM;
        if (dtMandetory_TAM.Rows.Count > 0)
        {
            drMandetory_TAM = dtMandetory_TAM.Rows[0];
            IsTAM_Mandetory = drMandetory_TAM["Rule_Y_N"].ToString();
        }

        //No  Connection of Vendor & Vehicle    
        DataTable dtNoConnectionVendorvehicle = THCController.GetTHCGenerationRule().Tables[6];
        DataRow drNoConnectionVendorvehicle;
        if (dtNoConnectionVendorvehicle.Rows.Count > 0)
        {
            drNoConnectionVendorvehicle = dtNoConnectionVendorvehicle.Rows[0];
            hdnNoConnectionVendorvehicle.Value = "Y";//drNoConnectionVendorvehicle["Rule_Y_N"].ToString();
        }


    }

    protected void RouteModeChange()
    {
        DataTable dsRoutes = THCController.GetRouteFromRouteMode(SessionUtilities.CurrentBranchCode, dllRouteMode.SelectedValue.ToString(), chkIsEmptyVehicle.Checked);

        dllRouteName.DataSource = dsRoutes;
        dllRouteName.DataBind();

        DataTable dsVendorTypes = THCController.GetVendorTypesRouteMode(dllRouteMode.SelectedValue.ToString());

        DataView dataMarketOwnVendorType = dsVendorTypes.DefaultView;
        dataMarketOwnVendorType.RowFilter = "Vendor_Type_Code IN ('','XX', '05')";
        dllVendorType.DataSource = dataMarketOwnVendorType;
        dllVendorType.DataBind();

        //dllVendorType.DataSource = dsVendorTypes;
        //dllVendorType.DataBind();


        if (dllRouteMode.SelectedValue.ToString() == "A")
        {
            trRouteModeAir1.Visible = true;
            trRouteModeRoad.Visible = false;
            trRouteModeTrain1.Visible = false;

            DataSet dsAirPort = THCController.GetAirPortDetail();
            DataSet dsAirline = THCController.GetAirLineDetail(SessionUtilities.CurrentBranchCode.ToString());
            dllAirport.DataSource = dsAirPort.Tables[0];
            dllAirport.DataBind();

            dllAirline.DataSource = dsAirline.Tables[0];
            dllAirline.DataBind();
        }
        else if (dllRouteMode.SelectedValue.ToString() == "R")
        {

            trRouteModeTrain1.Visible = true;
            trRouteModeRoad.Visible = false;
            trRouteModeAir1.Visible = false;
        }
        else if (dllRouteMode.SelectedValue.ToString() == "S")
        {
            trRouteModeRoad.Visible = true;
            trRouteModeTrain1.Visible = false;
            trRouteModeAir1.Visible = false;

            DataTable dsVehicle = THCController.GetVehivleFromVendor(dllVendorType.SelectedValue.ToString(), dllVendors.SelectedValue.ToString());

            dllVehicle.DataSource = dsVehicle;
            dllVehicle.DataBind();
        }
    }
    protected void btnAddAttachments_Click(object sender, EventArgs e)
    {
        ImageButton btn = sender as ImageButton;
        try
        {
            string BasePath = Server.MapPath("~/UploadedImages/THC");
            if (!Directory.Exists(Server.MapPath("~/UploadedImages")))
                Directory.CreateDirectory(Server.MapPath("~/UploadedImages"));
            string UserName = SessionUtilities.CurrentEmployeeID.ToString();
            if (!Directory.Exists(BasePath + @"\" + UserName))
                Directory.CreateDirectory(BasePath + @"\" + UserName);

            if (btn.CommandName == "VEHICLEPHOTO")
            {
                string FileName = GetFileName(uplfMarketVehicle.PostedFile.FileName, "VehiclePhoto");

                uplfMarketVehicle.SaveAs(BasePath + @"\" + UserName + @"\" + FileName);

                uplfMarketVehicle.Visible = false;
                btnMarketVehicleAttch.Visible = false;
                lblMarketVehicleFileStatus.Text = FileName + " Uploaded ";
                lbl_Error.Text = "";
            }
            else if (btn.CommandName == "DRIVERPHOTO")
            {

                string FileName = GetFileName(uplfDriverPhoto.PostedFile.FileName, "DriverPhoto");

                uplfDriverPhoto.SaveAs(BasePath + @"\" + UserName + @"\" + FileName);

                uplfDriverPhoto.Visible = false;
                btnDriverAttch.Visible = false;
                lblDriverAttchStatus.Text = FileName + " Uploaded ";
                lbl_Error.Text = "";
            }
            else if (btn.CommandName == "BrockrMemo")
            {
                if (chkBrockrMemo.Checked == true)
                    txtBrockrMemo.Text = "YES";

                string FileName = GetFileName(uplfBrockrMemo.PostedFile.FileName, "BrockerMemo");

                uplfBrockrMemo.SaveAs(BasePath + @"\" + UserName + @"\" + FileName);

                uplfBrockrMemo.Visible = false;
                btnBrockrMemoAttch.Visible = false;
                lblBrockrMemoStatus.Text = FileName + " Uploaded ";
                lbl_Error.Text = "";
            }
        }
        catch (Exception ex)
        {
            lbl_Error.Visible = true;
            lbl_Error.Text = ex.Message;
        }
    }
    private string GetFileName(string fileName, string Prefix)
    {
        string strRet = fileName;

        string pat = @"(?:.+)(.+)\.(.+)";
        Regex r = new Regex(pat);
        //run
        Match m = r.Match(fileName);
        string file_ext = m.Groups[2].Captures[0].ToString();
        string filename = m.Groups[1].Captures[0].ToString();
        // docno = docno.Replace("/", "$");

        strRet = Prefix + "." + file_ext;

        return strRet;
    }
    protected void OnRouteModeChange(object sender, EventArgs e)
    {
        RouteModeChange();
    }
    protected void OnRouteNameChange(object sender, EventArgs e)
    {

    }
    protected void OnAirLineChange(object sender, EventArgs e)
    {
        DataSet dsFlight = THCController.GetFlightDetail(dllAirport.SelectedValue.ToString(), dllAirline.SelectedValue.ToString());
        dllFilghtNo.DataSource = dsFlight.Tables[0];
        dllFilghtNo.DataBind();
    }
    protected void OnVendorTypeChange(object sender, EventArgs e)
    {

        DataTable dsVendors = THCController.GetVendorFromVendorTypes(SessionUtilities.CurrentBranchCode, dllVendorType.SelectedValue.ToString());

        dllVendors.DataSource = dsVendors;
        dllVendors.DataBind();

        DataSet dsVehicle = THCController.GetVehivleDetails("O");
        dllVehicleTypes.DataSource = dsVehicle.Tables[1];
        dllVehicleTypes.DataBind();

        dllFTLType.DataSource = dsVehicle.Tables[2];
        dllFTLType.DataBind();

        if (dllVendorType.SelectedValue == "05")
        {
            lblTripsheet.Visible = true;
            cboTripSheet.Visible = true;
            EnableDisableMKTVehInfo(false);
            txtMarketVehicle.Visible = false;
            dllVehicle.Visible = true;
        }
        else if (dllVendorType.SelectedValue == "XX")
        {
            EnableDisableMKTVehInfo(true);
            txtMarketVehicle.Visible = true;
            dllVehicle.Visible = false;
        }
        else
        {
            EnableDisableMKTVehInfo(false);
            txtMarketVehicle.Visible = false;
            dllVehicle.Visible = true;
        }
		
		Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "OnChkIsTransshipmentChange();", true);
    }
    protected void OnTSChange(object sender, EventArgs e)
    {
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sql = "Exec usp_TS_DriverInfo '" + cboTripSheet.Items[cboTripSheet.SelectedIndex].Value + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            txtDriver1.Text = dr["Driver1"].ToString();
            txtLicence1.Text = dr["Licno1"].ToString();
            txtIssuedBy1.Text = dr["RTO1"].ToString();
            lblLicDate.Text = dr["Validity_Date1"].ToString();

            txtDriver2.Text = dr["Driver2"].ToString();
            txtLicence2.Text = dr["Licno2"].ToString();
            txtIssuedBy2.Text = dr["RTO2"].ToString();
            txtLicVDate1.Text = dr["Validity_Date2"].ToString();


        }

        dr.Close();
        con.Close();
    }

    protected void chkIsEmptyVehicleCheckedChanged(object sender, EventArgs e)
    {
        DataTable dsRoutes = THCController.GetRouteFromRouteMode(SessionUtilities.CurrentBranchCode, dllRouteMode.SelectedValue.ToString(), chkIsEmptyVehicle.Checked);

        dllRouteName.DataSource = dsRoutes;
        dllRouteName.DataBind();
    }

    protected void chkCityCheckedChanged(object sender, EventArgs e)
    {
        trCity.Visible = chkCity.Checked;
    }




    protected void ActDeptTimeTextChanged(object sender, EventArgs e)
    {

    }
    protected void onRadioScheduleChange(object sender, EventArgs e)
    {

    }
    protected void OnVendorChange(object sender, EventArgs e)
    {

        //if (hdnNoConnectionVendorvehicle.Value == "Y")
        //{
            DataTable dsVehicle = THCController.GetVehivleFromVendor(dllVendorType.SelectedValue.ToString(), dllVendors.SelectedValue.ToString());
            dllVehicle.DataSource = dsVehicle;
            dllVehicle.DataBind();
        //}
    }
    protected void OnFlightChange(object sender, EventArgs e)
    {
        DataSet dsTM = THCController.GetFlightTimeDetail(dllAirport.SelectedValue.ToString(), dllFilghtNo.SelectedValue.ToString());
        lblFlgSchDeptTime.Text = dsTM.Tables[0].Rows[0][0].ToString();
    }
    protected void EnableDisableMKTVehInfo(bool boo)
    {
        txtMarketVendor.Visible = boo;
        // uplfMarketVehicle.Visible = boo;
        //   lblmktVehicle.Visible = boo;
        txtSupplierNM.Visible = boo;
        txtSupplierMOB.Visible = boo;
        lblSplNameCP.Visible = boo;
    }
    protected void EnableDisableVehInfo(bool boo)
    {
        dllVehicleTypes.Enabled = boo;
        dllFTLType.Enabled = boo;
        txtChasisNo.Enabled = boo;
        txtEngineNo.Enabled = boo;
        txtRCBookNo.Enabled = boo;
        txtVehPermitDT.Enabled = boo;
        txtVehicleRegdate.Enabled = boo;
        txtInsDT.Enabled = boo;
        txFitnessDT.Enabled = boo;

        txtCertificateNo.Enabled = boo;
        txtInsuranceNo.Enabled = boo;
        txtRTONo.Enabled = boo;
    }
    protected void OnVehicleChange(object sender, EventArgs e)
    {
        DataTable dtVehicle = THCController.GetVehivleDetails(dllVehicle.SelectedValue.ToString()).Tables[0];
        DataSet dsVehicle = THCController.GetVehivleDetails(dllVehicle.SelectedValue.ToString());
        dllVehicleTypes.DataSource = dsVehicle.Tables[1];
        dllVehicleTypes.DataBind();

        dllFTLType.DataSource = dsVehicle.Tables[2];
        dllFTLType.DataBind();

        txtMarketVehicle.Visible = false;
        EnableDisableVehInfo(false);
        EnableDisableMKTVehInfo(false);
        if (dllVehicle.SelectedValue == "O" || dllVehicle.SelectedValue == "")
        {
            EnableDisableMKTVehInfo(true);
            EnableDisableVehInfo(true);
            txtMarketVehicle.Visible = true;
        }
        else
        {
            txtMarketVehicle.Text = dllVehicle.SelectedValue.ToString();
        }

		ListTripsheet();
		
        DataRow drVehicleInfo;
        if (dtVehicle.Rows.Count > 0)
        {
            drVehicleInfo = dtVehicle.Rows[0];
            txtEngineNo.Text = drVehicleInfo["EngineNo"].ToString();
            txtChasisNo.Text = drVehicleInfo["ChasisNo"].ToString();
            txtRCBookNo.Text = drVehicleInfo["RCBookNo"].ToString();

            //txtCertificateNo.Text = drVehicleInfo["CertificateNo"].ToString();
            //txtInsuranceNo.Text = drVehicleInfo["InsuranceNo"].ToString();
            //txtRTONo.Text = drVehicleInfo["RTONo"].ToString();

            txtVehicleRegdate.Text = drVehicleInfo["RegistrationDt"].ToString();
            txtVehPermitDT.Text = drVehicleInfo["VEHPRMDT"].ToString();
            txtInsDT.Text = drVehicleInfo["InsuranceValDt"].ToString();
            txFitnessDT.Text = drVehicleInfo["FitnessValDt"].ToString();

            Double Cap_In_KG = 0.00;
            if (drVehicleInfo["Capacity"] != DBNull.Value)
            {
                Cap_In_KG = Convert.ToDouble(drVehicleInfo["Capacity"]);
                if (Cap_In_KG > 0)
                    Cap_In_KG = Cap_In_KG * 1000;
            }
            txtVehicleCAP.Text = Cap_In_KG.ToString("0.00");
        }
		
		
    }
	
	 protected void ListTripsheet()
    {
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        
        string sql = "Exec usp_TripSheetListForTHC '" + dllVehicle.SelectedValue.ToString() + "'";
        
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataAdapter da;
        DataSet ds;
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);

        cboTripSheet.DataSource = ds;
        cboTripSheet.DataValueField = "CodeSlipNo";
        cboTripSheet.DataTextField = "VSlipNo";
        cboTripSheet.DataBind();

        con.Close();
    }
	
    protected void OnVehicleTypesChanged(object sender, EventArgs e)
    {

        if (dllVehicle.SelectedValue == "O" || dllVehicle.SelectedValue == "")
        {
            Double Cap = 0.00, Cap_In_KG = 0.00;
            Cap = GetCapacityForMarketVeh();
            if (Cap > 0)
            {
                Cap_In_KG = Cap * 1000;
            }
            txtVehicleCAP.Text = Cap_In_KG.ToString("0.00");
        }
    }

    private Double GetCapacityForMarketVeh()
    {
        Double dCap = 0.00;
        try
        {

            DataSet dsTM = THCController.GetVehivleTypeDetails(dllVehicleTypes.SelectedValue.ToString());
            dCap = Convert.ToDouble(dsTM.Tables[0].Rows[0][0].ToString());

        }
        catch (Exception ex)
        {
        }
        return dCap;
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            dkt_colname.Text = Session["DocketCalledAs"].ToString() + " No.";
        }

    }

    protected int BindDocketsForTHC()
    {
        int DktCount = 0;

        lblForMFDockets.Text = Session["DocketCalledAs"].ToString() + " Available For " + Session["THCCalledAs"].ToString();

        string Destintion = Request.QueryString["Destintion"].ToString();
        string LocType = Request.QueryString["LocationType"].ToString();
        string DateType = Request.QueryString["DateType"].ToString();
        string FromDate = Request.QueryString["FromDate"].ToString();
        string ToDate = Request.QueryString["ToDate"].ToString();
        string PayBasis = Request.QueryString["PayBasis"].ToString();
        string TrnMode = Request.QueryString["TrnMode"].ToString();
        string BookingType = Request.QueryString["BookingType"].ToString();
        string BusinessType = Request.QueryString["BusinessType"].ToString();
        DataTable dtDocketDetails = THCController.GetDocketdetails(SessionUtilities.CurrentBranchCode, Destintion, LocType, DateType, FromDate, ToDate, PayBasis, TrnMode, BookingType, BusinessType);



        dgDockets.DataSource = dtDocketDetails;
        dgDockets.DataBind();

        lblCount.Text = "There are " + dgDockets.Rows.Count.ToString() + " " + Session["DocketCalledAs"] + "(s) Available for " + Session["THCCalledAs"];


        if (dgDockets.Rows.Count > 0)
        {
            btnStep1.Enabled = true;
            tblBsicDetails.Enabled = true;
            lblCount.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            tblBsicDetails.Enabled = false;
            lblCount.ForeColor = System.Drawing.Color.Red;
            btnStep1.Enabled = false;
        }
        DktCount = dgDockets.Rows.Count;
        return DktCount;
    }
    protected void btnStep1_Click(object sender, EventArgs e)
    {
        if (!DataValidations.IsActiveLocation(txtTHCDestination.Text))
        {
            err1.Text = "Plz Enter Validate Location";
            err1.Visible = true;
            txtTHCDestination.Text = "";
        }
        else
        {
            err1.Visible = false;

            if (BindDocketsForTHC() > 0)
            {
                tblBsicDetails.Enabled = false;
                trDocketdetails.Visible = true;
            }
        }

    }

    protected void WTADJ_Contamt(object sender, EventArgs e)
    {
        PopulateContractAmt();
    }




    protected int GenerateXMLForMF()
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        DateTime docDate = Convert.ToDateTime(txtTHCDate.Text, dtfi);
        string docDateStr = docDate.ToString("dd MMMM yyyy");

        int DktCount = 0, TotalPkgs = 0, TotalWt = 0, LoadedPkgs = 0, LoadedWt = 0;
        string Nextstop = "";

        Nextstop = txtTHCDestination.Text.Trim().ToUpper();

        XmlDocument XDocTCHDR = new XmlDocument();
        XmlElement Root = XDocTCHDR.CreateElement("root");
        XmlElement MFGenerate = XDocTCHDR.CreateElement("tchdr");
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TCNO", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TCSF", "."));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TCDT", docDateStr));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TCBR", SessionUtilities.CurrentBranchCode));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOBH_CODE", Nextstop));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_DKT", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_PKGS", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_ACTUWT", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_CFTWT", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_LOAD_PKGS", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_LOAD_ACTWT", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOT_LOAD_CFTWT", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TCHDRFLAG", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TFLAG_YN", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "MANUAL_TCNO", "NA"));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "PREPAREDBY", SessionUtilities.CurrentEmployeeID));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "FROMCITY", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "TOCITY", ""));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "ENTRYBY", SessionUtilities.CurrentEmployeeID));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "ROUTE_CODE", "-"));
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "IsBCProcess", "N"));
        //Add for changes of project P005871
        MFGenerate.AppendChild(CreateElement(XDocTCHDR, "CEWBNo", txtCEWBNo.Text));
        //--
        Root.AppendChild(MFGenerate);
        XDocTCHDR.AppendChild(Root);

        xmlTCHDR = XDocTCHDR.InnerXml.ToString();
        XmlDocument XDocTCTRN = new XmlDocument();
        XmlElement RootTCTRN = XDocTCTRN.CreateElement("root");

        XmlDocument XDocStatus = new XmlDocument();
        XmlElement RootStatus = XDocStatus.CreateElement("root");
        for (int index = 0; index < dgDockets.Rows.Count; index++)
        {
            CheckBox chkDocket = (CheckBox)dgDockets.Rows[index].FindControl("chkDocket");
            TextBox txtPkgs = (TextBox)dgDockets.Rows[index].FindControl("txtPkgs");
            TextBox txtWt = (TextBox)dgDockets.Rows[index].FindControl("txtWt");
            HiddenField hdnDktNo = (HiddenField)dgDockets.Rows[index].FindControl("hdnDktNo");
            HiddenField hdnDktSF = (HiddenField)dgDockets.Rows[index].FindControl("hdnDktSF");
            HiddenField hdnDktPkg = (HiddenField)dgDockets.Rows[index].FindControl("hdnDktPkg");
            HiddenField hdnDktWt = (HiddenField)dgDockets.Rows[index].FindControl("hdnDktWt");


            if (chkDocket.Checked == true)
            {
                XmlElement StrTCTRN = XDocTCTRN.CreateElement("tctrn");
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "TCSF", "."));
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "DOCKNO", hdnDktNo.Value));
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "DOCKSF", hdnDktSF.Value));
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "LOADPKGSNO", txtPkgs.Text.Trim()));
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "LOADACTUWT", txtWt.Text.Trim()));
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "LOADCFTWT", txtWt.Text.Trim()));

                //Add for changes of project P005871
                StrTCTRN.AppendChild(CreateElement(XDocTCTRN, "CEWBNo", txtCEWBNo.Text.Trim()));
                //--
                RootTCTRN.AppendChild(StrTCTRN);

                XmlElement StrStatus = XDocStatus.CreateElement("wtds");
                StrStatus.AppendChild(CreateElement(XDocStatus, "DOCKNO", hdnDktNo.Value));
                StrStatus.AppendChild(CreateElement(XDocStatus, "DOCKSF", hdnDktSF.Value));
                StrStatus.AppendChild(CreateElement(XDocStatus, "LOADPKGSNO", txtPkgs.Text.Trim()));
                StrStatus.AppendChild(CreateElement(XDocStatus, "LOADACTUWT", txtWt.Text.Trim()));
                StrStatus.AppendChild(CreateElement(XDocStatus, "LOADCFTWT", txtWt.Text.Trim()));
                StrStatus.AppendChild(CreateElement(XDocStatus, "TOBH_CODE", txtTHCDestination.Text.ToString().Trim()));
                StrStatus.AppendChild(CreateElement(XDocStatus, "TCDT", docDateStr.Trim()));
                StrStatus.AppendChild(CreateElement(XDocStatus, "NEXTLOC", txtTHCDestination.Text.ToString().Trim()));
                //Add for changes of project P005871
                StrStatus.AppendChild(CreateElement(XDocStatus, "CEWBNo", txtCEWBNo.Text.ToString().Trim()));
                //--
                RootStatus.AppendChild(StrStatus);

                DktCount += 1;
                TotalPkgs += Convert.ToInt32(hdnDktPkg.Value.ToString().Trim());
                TotalWt += Convert.ToInt32(Math.Round(Convert.ToDecimal(hdnDktWt.Value.ToString().Trim())));

                LoadedPkgs += Convert.ToInt32(txtPkgs.Text.Trim());
                LoadedWt += Convert.ToInt32(Math.Round(Convert.ToDecimal(txtWt.Text.Trim()), 0));
            }
            XDocTCTRN.AppendChild(RootTCTRN);
            XDocStatus.AppendChild(RootStatus);
        }

        hdnTHCTotCnote.Value = DktCount.ToString().Trim();
        hdnTHCTotPkg.Value = LoadedPkgs.ToString().Trim();
        hdnTHCTotWt.Value = LoadedWt.ToString().Trim();

        if (DktCount > 0)
        {
            xmlTCHDR = xmlTCHDR.Replace("<TOT_DKT></TOT_DKT>", "<TOT_DKT>" + DktCount.ToString().Trim() + "</TOT_DKT>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_PKGS></TOT_PKGS>", "<TOT_PKGS>" + TotalPkgs.ToString().Trim() + "</TOT_PKGS>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_ACTUWT></TOT_ACTUWT>", "<TOT_ACTUWT>" + TotalWt.ToString().Trim() + "</TOT_ACTUWT>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_CFTWT></TOT_CFTWT>", "<TOT_CFTWT>" + TotalWt.ToString().Trim() + "</TOT_CFTWT>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_LOAD_PKGS></TOT_LOAD_PKGS>", "<TOT_LOAD_PKGS>" + LoadedPkgs.ToString().Trim() + "</TOT_LOAD_PKGS>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>", "<TOT_LOAD_ACTWT>" + LoadedWt.ToString().Trim() + "</TOT_LOAD_ACTWT>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_LOAD_CFTWT></TOT_LOAD_CFTWT>", "<TOT_LOAD_CFTWT>" + LoadedWt.ToString().Trim() + "</TOT_LOAD_CFTWT>");

        }
        xmlTCTRN = XDocTCTRN.InnerXml.ToString();
        xmlWTDS = XDocStatus.InnerXml.ToString();
        return DktCount;
    }


    private XmlElement CreateElement(XmlDocument XDoc, string name, string value)
    {
        XmlElement xa = XDoc.CreateElement(name);
        xa.InnerText = value;
        return xa;
    }

    protected void btnStep2_Click(object sender, EventArgs e)
    {
        /*Removed*/
        //txtContamt.Text = "0.00";
        //txtAdvamt.Text = "0.00";
        //txtContamt.Attributes.Add("onkeypress", "javascript:return validFloat(event,'" + txtContamt.ClientID + "');");
        //txtAdvamt.Attributes.Add("onkeypress", "javascript:return validFloat(event,'" + txtAdvamt.ClientID + "');");

        //trPaymentdetails.Visible = true;
        //DataTable PaymentDetails = THCController.GetPaymentDetails("GE");

        //reptHeader.DataSource = PaymentDetails;
        //reptHeader.DataBind();

        //reptItemDet.DataSource = PaymentDetails;
        //reptItemDet.DataBind();
        //trDocketdetails.Enabled = false;

        //PopulateContractAmt();


        // New change
        //BlockCriteriaDivision(true);
        //BlockMFSelection(true);
        //dgMFs.Enabled = false;
        //btnConfirmOpData.Enabled = false;

        btnStep2.Enabled = false;

        if (dllVendorType.Items[dllVendorType.SelectedIndex].Value == "05" || dllVendorType.Items[dllVendorType.SelectedIndex].Value == "ZZ")
        //if (cboVendorType.Items[cboVendorType.SelectedIndex].Value == "05" || cboVendorType.Items[cboVendorType.SelectedIndex].Value == "ZZ")
        {
            trPaymentDetails_Own.Visible = true;
            trPaymentDetails.Visible = false;
        }
        else
        {
            trPaymentDetails_Own.Visible = false;
            trPaymentDetails.Visible = true;
            hdnBalamtbr.Value = txtTHCDestination.Text;
            balamtbr.Text = txtTHCDestination.Text;
            balamtbr.ReadOnly = true;
        }

        trSubmit.Visible = true;
        PopulateContractAmt();

        ScriptManager.RegisterStartupScript(upTHCCreate, this.GetType(), "autocomplete", "InitAutoComplete();", true);

    }
    private Double GetTAMContactAmt(string TAMNO)
    {
        double d = 0.00;
        string strQ = "SELECT TOP 1 ISNULL(Costing_Amt,0.00) FROM WebX_TAM_Request WHERE TAMNo='" + TAMNO + "'";
        object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strQ);
        if (obj != null)
        {
            d = Convert.ToDouble(obj);
        }
        return d;
    }


    /*Removed*/
    /*
     
    protected void PopulateContractAmt()
    {
        //stdpcamt.Text = "567";
        //stdpcamt,contractamt
        string Doc_Type = "THC"; //Request.QueryString["DOCTYP"].ToString().Trim();
        string VendorCode = "", VendorContID = "", MAtrix = "", FTL_Type = "";
        string Vehicle = "", IsMarketVeh_YN = "N";
        string[] tmpString;
        string RouteCode = "";
        string RouteMODE = "";
        string From_City = "", To_City = "";

        try
        {
            VendorCode = dllVendors.SelectedValue.Trim();
            FTL_Type = dllFTLType.SelectedValue.ToString();
            IsMarketVeh_YN = (txtMarketVehicle.Visible == true ? "Y" : "N");

            if (IsMarketVeh_YN == "N")
                Vehicle = dllVehicle.SelectedValue;
            else
                Vehicle = "";
            tmpString = dllRouteName.SelectedItem.Text.Split(':');
            RouteCode = tmpString[0];
            RouteMODE = dllRouteMode.SelectedValue.ToString();
            From_City = txtFromCity.Text.Trim();
            To_City = txtToCity.Text.Trim();
        }
        catch (Exception ex)
        {

        }

        if (Allow_Adhoc && chkAdHocContract.Checked)
        {

            hdnContTyp.Value = "ADH";
            txtContamt.Text = "0.00";
            txtContamt.Enabled = true;
        }
        else if (Allow_TAM)
        {
            double ContractAMT = 0;// GetTAMContactAmt(txtTAMNo.Text.Trim());
            hdnContTyp.Value = "TAM";
            txtContamt.Text = ContractAMT.ToString("0.00");
            txtContamt.Enabled = false;
        }
        else
        {
            string sql1 = "Exec dbo.usp_Get_Vendor_Contract_Charge_Detail '" + VendorCode + "','','','','" + RouteMODE + "','" + RouteCode + "','" + FTL_Type + "','" + Vehicle + "','THC','" + From_City + "','" + To_City + "'";
            bool hasContract = false;

            DataSet dsCNT = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql1);
            double dCntAMT = 0.00;
            double totwt = 0.00;

            if (lblTotWt.Text == "")
                lblTotWt.Text = "0";

            if (txtWtAdj.Text == "")
                txtWtAdj.Text = "0";

            totwt = Convert.ToDouble(lblTotWt.Text) + Convert.ToDouble(txtWtAdj.Text);

            if (dsCNT.Tables.Count > 0)
            {
                DataTable dtCNT = dsCNT.Tables[0];
                if (dtCNT.Rows.Count > 0)
                {
                    DataRow drCNT = dtCNT.Rows[0];
                    hasContract = true;
                    VendorContID = drCNT["CONTRACTCD"].ToString();
                    MAtrix = drCNT["MatrixType"].ToString().Trim();
                    hdnContTyp.Value = MAtrix;
                    hdnContTypSystem.Value = MAtrix;

                    #region Route Based
                    if ((MAtrix == "01" || MAtrix == "02" || MAtrix == "03") && Doc_Type == "THC")
                    {
                        double dRate = 0.00, dMinChg = 0.00, dMaxChg = 0.00;

                        if (drCNT["Chg_Rate"] != DBNull.Value)
                            dRate = Convert.ToDouble(drCNT["Chg_Rate"]);
                        if (drCNT["Min_Charge"] != DBNull.Value)
                            dMinChg = Convert.ToDouble(drCNT["Min_Charge"]);
                        if (drCNT["Max_Charge"] != DBNull.Value)
                            dMaxChg = Convert.ToDouble(drCNT["Max_Charge"]);

                        if (totwt > 0 && dRate > 0)
                            dCntAMT = dRate * totwt;

                        //if (dCntAMT > 0)
                        //{
                        if (dCntAMT > dMaxChg)
                            dCntAMT = dMaxChg;
                        else if (dCntAMT < dMinChg)
                            dCntAMT = dMinChg;
                        //}
                        txtContamt.Text = dCntAMT.ToString("0.00");
                        //if (dCntAMT > 0)
                        txtContamt.Enabled = false;

                        string SQL_STDAMT = "select top 1 STDAMT=isnull(std_contamt,0.00) from webx_rutmas With(NOLOCK) where rutcd='" + RouteCode + "'";
                        object objSTDAMT = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, SQL_STDAMT);
                        if (objSTDAMT != null)
                        {
                            lblStdContAmt.Text = Convert.ToDouble(objSTDAMT).ToString("0.00");
                        }
                    }
                    #endregion

                    #region Distance Based
                    if (
                        ((MAtrix == "01" || MAtrix == "02" || MAtrix == "03" || MAtrix == "09" || MAtrix == "10" || MAtrix == "11") && (Doc_Type == "PRS" || Doc_Type == "DRS")) ||
                        ((MAtrix == "04" || MAtrix == "05" || MAtrix == "06") && (Doc_Type == "PRS" || Doc_Type == "DRS" || Doc_Type == "THC"))
                      )
                    {
                        double Min_Amt_Committed = 0.00, Committed_Km = 0.00, Chg_Per_Add_Km = 0.00, Max_Amt_Committed = 0.00;
                        int Trips_PM = 0;

                        if (drCNT["Min_Amt_Committed"] != DBNull.Value)
                            Min_Amt_Committed = Convert.ToDouble(drCNT["Min_Amt_Committed"]);
                        if (drCNT["Committed_Km"] != DBNull.Value)
                            Committed_Km = Convert.ToDouble(drCNT["Committed_Km"]);
                        if (drCNT["Chg_Per_Add_Km"] != DBNull.Value)
                            Chg_Per_Add_Km = Convert.ToDouble(drCNT["Chg_Per_Add_Km"]);
                        if (drCNT["Max_Amt_Committed"] != DBNull.Value)
                            Max_Amt_Committed = Convert.ToDouble(drCNT["Max_Amt_Committed"]);
                        if (drCNT["Trips_PM"] != DBNull.Value)
                            Trips_PM = Convert.ToInt32(drCNT["Trips_PM"]);

                        txtContamt.Text = "0.00";
                        txtContamt.Enabled = false;
                        lblStdContAmt.Text = "0.00";
                    }
                    #endregion

                    #region City Based
                    if ((MAtrix == "09" || MAtrix == "10" || MAtrix == "11") && Doc_Type == "THC")
                    {
                        double dRate = 0.00, dMinChg = 0.00, dMaxChg = 0.00;

                        if (drCNT["Chg_Rate"] != DBNull.Value)
                            dRate = Convert.ToDouble(drCNT["Chg_Rate"]);
                        if (drCNT["Min_Charge"] != DBNull.Value)
                            dMinChg = Convert.ToDouble(drCNT["Min_Charge"]);
                        if (drCNT["Max_Charge"] != DBNull.Value)
                            dMaxChg = Convert.ToDouble(drCNT["Max_Charge"]);

                        if (totwt > 0 && dRate > 0)
                            dCntAMT = dRate * totwt;

                        //if (dCntAMT > 0)
                        //{
                        if (dCntAMT > dMaxChg)
                            dCntAMT = dMaxChg;
                        else if (dCntAMT < dMinChg)
                            dCntAMT = dMinChg;
                        //}

                        txtContamt.Text = dCntAMT.ToString("0.00");
                        //if (dCntAMT > 0)
                        txtContamt.Enabled = false;

                        lblStdContAmt.Text = "0.00";
                    }
                    txtAdvamt.Focus();
                    #endregion
                }
            }
            if (!hasContract)
            {

                chkAdHocContract.Checked = true;
                hdnContTyp.Value = "ADH";
                txtContamt.Text = "0.00";
                txtContamt.Enabled = true;
                txtContamt.Focus();
            }
        }

        
    }
     
*/


    protected void PopulateContractAmt()
    {
        //stdpcamt.Text = "567";
        //stdpcamt,contractamt
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string VendorCode = "";
        string Vehicle = "";
        string[] tmpString;
        string RouteCode = "";


        try
        {
            //VendorCode = cboVendors.Items[cboVendors.SelectedIndex].Value.Trim();
            //Vehicle = cboVehicleTypes.SelectedValue.ToString();//txtMktVeh.Text.Trim();
            //tmpString = cboRouteName.Items[cboRouteName.SelectedIndex].Text.Split(':');
            //RouteCode = tmpString[0];

            VendorCode = dllVendors.Items[dllVendors.SelectedIndex].Value.Trim();
            Vehicle = dllVendorType.SelectedValue.ToString();//txtMktVeh.Text.Trim();
            tmpString = dllRouteName.Items[dllRouteName.SelectedIndex].Text.Split(':');
            RouteCode = tmpString[0];
        }
        catch (Exception ex)
        {
        }

        int TotalWt = 0;

        //for (int index = 0; index < dgMFs.Rows.Count; index++)
        //{
        //    CheckBox chkMFs = (CheckBox)dgMFs.Rows[index].FindControl("chkMF");

        //    if (chkMFs.Checked == true)
        //    {
        //        TotalWt += Convert.ToInt32(dgMFs.DataKeys[index].Values[3]);
        //    }
        //}
        for (int index = 0; index < dgDockets.Rows.Count; index++)
        {
            CheckBox chkDocket = (CheckBox)dgDockets.Rows[index].FindControl("chkDocket");

            if (chkDocket.Checked == true)
            {
                Label lblBookedWt = (Label)dgDockets.Rows[index].FindControl("lblBookedWt");
                TotalWt += Convert.ToInt32(lblBookedWt.Text);
                //TotalWt += Convert.ToInt32(dgDockets.DataKeys[index].Values[3]);
                //TotalWt += Convert.ToInt32(dgDockets.DataKeys[index].Values[3]);
            }
        }


        string sql = "Exec Webx_COntAmt_THCGen '" + VendorCode + "','" + Vehicle + "','" + RouteCode + "'," + TotalWt;

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            stdpcamt.Text = dr[0].ToString();
            lblStdContractAmountOWN.Text = dr[0].ToString();

            contractamt.Text = dr[1].ToString();
            txtContractAmountOWN.Text = dr[1].ToString();
        }

        dr.Close();
        con.Close();

        contractamt.Focus();
    }

    protected void btnSubmitDir_Click(object sender, EventArgs e)
    {
        string BasePath = Server.MapPath("~/UploadedImages/THC");
        if (!Directory.Exists(Server.MapPath("~/UploadedImages")))
            Directory.CreateDirectory(Server.MapPath("~/UploadedImages"));
        string UserName = SessionUtilities.CurrentEmployeeID.ToString();
        if (!Directory.Exists(BasePath + @"\" + UserName))
            Directory.CreateDirectory(BasePath + @"\" + UserName);


        THCCreateProcess();
        trDocketdetails.Enabled = false;
        tblDocketdetails.Enabled = false;
    }
    protected void btnStep3_Click(object sender, EventArgs e)
    {
        THCCreateProcess();
        // trDocketdetails.Enabled = false;
        // trPaymentdetails.Enabled = false;


    }
    //THC Create Process For THC From Dockets
    protected void THCCreateProcess()
    {
        try
        {
            if (IsTokenValid())
            {
                System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
                dtfi.ShortDatePattern = "dd/MM/yyyy";
                dtfi.DateSeparator = "/";
                DateTime docDate = Convert.ToDateTime(txtTHCDate.Text, dtfi);
                string docDateStr = docDate.ToString("dd MMM yyyy");

                if (chkIsTransshipment.Checked == true)
                {
                    string sqlNew = "Select * from Webx_Location where Loccode= '" + txtTransitLocation.Text + "'";
                    DataSet Ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlNew);

                    if (Ds.Tables[0].Rows.Count == 0)
                    {
                        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Transhipment Location" + "&ErrorMsg=Please Valid Transipment Location ", false);
                        return;
                    }
                }
				
				string sqlfromCity = "Select * from webx_citymaster where Location= '" + txtFromCity.Text + "'";
                DataSet DsFromCity = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlfromCity);

                if (DsFromCity.Tables[0].Rows.Count == 0)
                {
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Invalid From CIty " + "&ErrorMsg=Please Enter Valid FromCity From Master ", false);
                    return;
                }

                string sqlToCity = "Select * from webx_citymaster where Location= '" + txtToCity.Text + "'";
                DataSet DsToCity = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlToCity);

                if (DsToCity.Tables[0].Rows.Count == 0)
                {
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Invalid To CIty " + "&ErrorMsg=Please Enter Valid ToCity From Master ", false);
                    return;
                }

                if (GenerateXMLForMF() > 0)
                {
                    GenerateXMLForTHC();
                    

                    string ContractAmount = "0", AdvanceAmount = "0", MamulCharge = "0", BalanceAmount = "0";
                    if (contractamt.Text != "") { ContractAmount = contractamt.Text; }
                    if (advanceamt.Text != "") { AdvanceAmount = advanceamt.Text; }
                    if (mamul_chrg.Text != "") { MamulCharge = mamul_chrg.Text; }
                    if (balamt.Text != "") { BalanceAmount = balamt.Text; }

                    if ((Convert.ToDecimal(ContractAmount) - (Convert.ToDecimal(AdvanceAmount) + Convert.ToDecimal(MamulCharge))) != Convert.ToDecimal(BalanceAmount))
                    {
                        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Balance Amount" + "&ErrorMsg=Invalid Net Balance Amount", false);
                        return;
                    }
                   
                    
                    string findetval = "";
                    string[] columnnm_STR = hdnChargeCodeAll.Value.ToString().Split(',');

                    int cnt = 1;

                    /*Removed*/
                    /*
                    foreach (RepeaterItem rd in reptItemDet.Items)
                    {
                        TextBox txtCharge = ((TextBox)rd.FindControl("txtCharge"));
                        string chrgval = txtCharge.Text.ToString();

                        if (txtCharge.Text.ToString() == "")
                            chrgval = "0";

                        if (findetval == "")
                            findetval = columnnm_STR[cnt].ToString() + "=" + chrgval.ToString();
                        else
                            findetval = findetval + "," + columnnm_STR[cnt].ToString() + "=" + chrgval.ToString();
                        cnt++;
                    }
                     */
                    DataTable THCGenerate = THCController.THCGenerate(SessionUtilities.CurrentBranchCode, docDateStr, xmlTCHDR, xmlTCTRN, xmlWTDS, xmlTHCSummary, xmlTCSummary, findetval, hdnTHCType.Value);
                    ConsumeToken();

                    DataRow drTHCGenerate;
                    if (THCGenerate.Rows.Count > 0)
                    {
                        drTHCGenerate = THCGenerate.Rows[0];

                        DOCNO = drTHCGenerate["DocNo"].ToString();
                        DOC_TYP = drTHCGenerate["DOCTYP"].ToString();
                        TranXaction = drTHCGenerate["TranXaction"].ToString();
                        IsError = Convert.ToBoolean(drTHCGenerate["IsError"]);

                        if (drTHCGenerate["DocNo"].ToString() != "")
                        {
                            string BasePath = Server.MapPath("~/UploadedImages/THC");
                            string UserName = SessionUtilities.CurrentEmployeeID.ToString();

                            if (Directory.Exists(BasePath + @"\" + drTHCGenerate["DocNo"].ToString()))
                            {
                                Directory.Delete(BasePath + @"\" + drTHCGenerate["DocNo"].ToString(), true);
                            }

                            DirectoryInfo dirNew = Directory.CreateDirectory(BasePath + @"\" + drTHCGenerate["DocNo"].ToString().Replace("/", "_"));
                            if (Directory.Exists(BasePath + @"\" + UserName))
                            {
                                DirectoryInfo dir = new DirectoryInfo(BasePath + @"\" + UserName);
                                FileInfo[] fiArr = dir.GetFiles();
                                foreach (FileInfo fi in fiArr)
                                {
                                    fi.MoveTo(dirNew.FullName + @"\" + fi.Name);

                                }
                                dir.Delete();
                            }

                        }

                        //Response.Redirect("THCGenerationDone.aspx?DOCNO=" + drTHCGenerate["DocNo"].ToString() + "&DOCTYP=" + drTHCGenerate["DOCTYP"].ToString() + "&MANDOCNO=" + txtManualTHCNo.Text.Trim() + "&TranXaction=" + drTHCGenerate["TranXaction"].ToString(), false);

                    }
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "THC From Cnote->Final Submit");
        }
        if (IsError)
            Response.Redirect("~/GUI/Operations/ErrorPage.aspx?heading=Error in " + DOC_TYP + " Generation&detail1=" + TranXaction);
        else
            Response.Redirect("THCGenerationDone.aspx?DOCNO=" + DOCNO + "&DOCTYP=" + DOC_TYP + "&MANDOCNO=" + txtManualTHCNo.Text.Trim() + "&TranXaction=" + TranXaction, false);


    }

    protected void GenerateXMLForTHC()
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        DateTime docDate, vehRegDate, vehPRMDate, insuraceDate, fitnessCertDate, licenceValDate1, licenceValDate2;

        DateTime nowDt;

        nowDt = DateTime.Now;
        string nowDtStr = nowDt.ToString("dd MMMM yyyy");

        docDate = Convert.ToDateTime(txtTHCDate.Text, dtfi);
        string docDateStr = docDate.ToString("dd MMMM yyyy");

        DateTime SchdocDate;
        string SchdocDateStr = "", SchdocTimeStr;
        if (lblSchdDeptDate.Text != "")
        {
            SchdocDate = Convert.ToDateTime(lblSchdDeptDate.Text, dtfi);
            SchdocDateStr = docDate.ToString("dd MMMM yyyy");
        }
        else
            SchdocDateStr = docDateStr;

        if (lblSchdDeptTime.Text.ToString() == "")
            SchdocTimeStr = txtTHCTime.Text.ToString();
        else
            SchdocTimeStr = lblSchdDeptTime.Text.ToString();


        string vehRegDateStr = "01 January 1900";
        string vehPRMDateStr = "01 January 1900";
        string insuraceDateStr = "01 January 1900";
        string fitnessCertDateStr = "01 January 1900";
        string licenceValDate1Str = "01 January 1900";
        string licenceValDate2Str = "01 January 1900";
        try
        {
            vehRegDate = Convert.ToDateTime(txtVehicleRegdate.Text, dtfi);
            vehRegDateStr = vehRegDate.ToString("dd MMMM yyyy");

            vehPRMDate = Convert.ToDateTime(txtVehPermitDT.Text, dtfi);
            vehPRMDateStr = vehPRMDate.ToString("dd MMMM yyyy");

            insuraceDate = Convert.ToDateTime(txtInsDT.Text, dtfi);
            insuraceDateStr = insuraceDate.ToString("dd MMMM yyyy");

            fitnessCertDate = Convert.ToDateTime(txFitnessDT.Text, dtfi);
            fitnessCertDateStr = fitnessCertDate.ToString("dd MMMM yyyy");

            //licenceValDate1 = Convert.ToDateTime(txtLicence1.Text, dtfi);
            licenceValDate1 = Convert.ToDateTime(txtLicVDate1.Text, dtfi);
            licenceValDate1Str = licenceValDate1.ToString("dd MMMM yyyy");

            //licenceValDate2 = Convert.ToDateTime(txtLicence2.Text, dtfi);
            licenceValDate2 = Convert.ToDateTime(txtLicVDate2.Text, dtfi);
            licenceValDate2Str = licenceValDate2.ToString("dd MMMM yyyy");
        }
        catch (Exception ex)
        {
        }

        int TCCount = 0, TotalDkts = 0, TotalPkgs = 0, TotalWt = 0, TotalPkgsArrv = 0, TotalPkgsPend = 0;
        int TotalActWt = 0, TotalActWtArrv = 0, TotalChargeWt = 0, TotalFreight = 0, TotalST = 0, TotalDKTTOT = 0;

        string RouteCode = "", RouteName = "", ToHubNext = "", ToHubLast = "", LateDeptReason = "";
        string AirTrainName = "", FlightTrainName = "", AirWayBillRRNo = "", Airport = "", AIRSCH_TM = "";
        string TripSheetNo = "", CHKOVLD = "N";

        if (hdnTHCType.Value == "1")
        {
            string[] tmpString = dllRouteName.Items[dllRouteName.SelectedIndex].Text.Split(':');
            RouteCode = tmpString[0].Trim();
            RouteName = tmpString[1].Trim();
            string[] tmpString2 = RouteName.Split('-');
            ToHubNext = tmpString2[1].Trim();
            ToHubLast = tmpString2[tmpString2.Length - 1].Trim();
        }
        else
        {
            RouteCode = "9888";
            RouteName = SessionUtilities.CurrentBranchCode + "-" + txtTHCDestination.Text.ToString();
            ToHubNext = txtTHCDestination.Text.ToString();
            ToHubLast = txtTHCDestination.Text.ToString();
        }



        LateDeptReason = dllLateDeptReason.Items[dllLateDeptReason.SelectedIndex].Value.Trim();

        string[] tmpString3 = dllVendors.SelectedItem.Text.Split(':');
        string VendorCode = dllVendors.SelectedValue.ToString();
        string VendorName = tmpString3[1].Trim();

        string IsMarketVeh_YN = (txtMarketVehicle.Visible == true ? "Y" : "N");
        //VendorName = (txtMktVeh.Visible == true ? txtMarketVendor.Text.Trim() : VendorName);
        if (dllVendorType.SelectedValue.ToUpper() == "XX")
        {
            VendorCode = "9888";
            VendorName = txtMarketVendor.Text.Trim();
        }

        string SPLRNM = "", SPLRMOBNO = "";
        if (IsMarketVeh_YN == "Y")
        {
            SPLRNM = txtSupplierNM.Text.ToString();
            SPLRMOBNO = txtSupplierMOB.Text.ToString();
        }

        double fintotwt = 0.00;
        /*Removed*/
        /*
        if (chkWtAdjCP.Checked == true)
        {

            if (lblTotWt.Text == "")
                lblTotWt.Text = "0";

            if (txtWtAdj.Text == "")
                txtWtAdj.Text = "0";
            fintotwt = Convert.ToDouble(lblTotWt.Text) + Convert.ToDouble(txtWtAdj.Text);
        }
        */

        if (cboTripSheet.SelectedIndex > -1)
        {
            TripSheetNo = cboTripSheet.Items[cboTripSheet.SelectedIndex].Value.Trim();
        }


        if (dllRouteMode.Items[dllRouteMode.SelectedIndex].Value != "S")
        {
            AirTrainName = (dllRouteMode.Items[dllRouteMode.SelectedIndex].Value == "A" ? dllAirline.SelectedValue.ToString() : txtTrainName.Text.Trim());
            FlightTrainName = (dllRouteMode.Items[dllRouteMode.SelectedIndex].Value == "A" ? dllFilghtNo.SelectedValue.ToString() : txtTrainNo.Text.Trim());
            Airport = (dllRouteMode.Items[dllRouteMode.SelectedIndex].Value == "A" ? dllAirport.SelectedValue.ToString() : "");
            AIRSCH_TM = (dllRouteMode.Items[dllRouteMode.SelectedIndex].Value == "A" ? lblFlgSchDeptTime.Text.ToString() : "");

        }

        XmlDocument XDocTHCSummary = new XmlDocument();
        XmlElement Root = XDocTHCSummary.CreateElement("root");
        XmlElement THCGenerate = XDocTHCSummary.CreateElement("DOCHDR");

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MANDOCNO", txtManualTHCNo.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "DOCDT", docDateStr.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "DOCDTTM", txtTHCTime.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ACTDEPTTM", txtActDeptTime.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SCHDEPTTM", SchdocTimeStr.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SCHDEPTDT", SchdocDateStr.ToString()));

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ToHubLast", ToHubLast));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ToHubNext", ToHubNext));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Loader", txtLoadSupCode.Text.Trim()));

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RouteMode", dllRouteMode.SelectedValue.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RouteCode", RouteCode));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RouteName", RouteName));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Seal", txtSealNo.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OutRemark", txtOutRemarks.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LateDeptReason", dllLateDeptReason.SelectedValue.ToString()));

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TSNO", TripSheetNo.ToString()));
        // THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TAMNO", RouteCode));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ROUTE_CAT", dllRouteMode.SelectedValue.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VendorCode", VendorCode));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VendorName", VendorName));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BrokerMemo_YN", txtBrockrMemo.Text.ToString()));
        //Add for changes of project P005871
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CEWBNo", txtCEWBNo.Text.ToString()));

        if (chkIsTransshipment.Checked == true) {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "IsTransshipment", "Y"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TransitLocation", txtTransitLocation.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TransitRemark", txtTransitRemark.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TransitTentativeFreight", txtTransitTentativeFreight.Text.ToString()));
        } else {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "IsTransshipment", "N"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TransitLocation", txtTransitLocation.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TransitRemark", txtTransitRemark.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TransitTentativeFreight", txtTransitTentativeFreight.Text.ToString()));
        }
        // if (chkCity.Checked == true)
        // {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FROMCITY", txtFromCity.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOCITY", txtToCity.Text.ToString()));
        // }
        // else
        // {
            // THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FROMCITY", ""));
            // THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOCITY", ""));
        // }


        //--
        //THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LateDeptReason", dllLateDeptReason.SelectedValue.ToString()));

        // string newFName = GetFileName(uplfMarketVehicle.PostedFile.FileName, "", "");
        // THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehFileName", newFName));

        // uplfMarketVehicle.SaveAs(@"\images\vehiclephoto\" + newFName);

        if (dllRouteMode.SelectedValue.ToString() != "S") //If Not Road 
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleType", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleTons", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MarketVeh", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MarketVehImage", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "EngineNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ChasisNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RCBookNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CertificateNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "InsuranceNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VEHRTONo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleRegDt", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "InsuranceDt", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FitnessCertDt", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver1", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Licence1", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RTO1", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ValidityDt1", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver1MOB", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver2", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Licence2", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RTO2", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ValidityDt2", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver2MOB", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AirTrainName", AirTrainName));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FlightTrainNo", FlightTrainName));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AirWayBillRRNo", AirWayBillRRNo));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Airport", Airport));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AIRSCH_TM", AIRSCH_TM));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AWBNO", txtAWBNo.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SPLRMOBNO", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SPLRNM", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VEH_CAP", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "WTLOADED", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CAPUTI", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OVLED_YN", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OVLED_REASON", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FreeSpace", "0"));

        }
        else
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleNo", txtMarketVehicle.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleType", dllVehicleTypes.SelectedValue.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FTLType", dllFTLType.SelectedValue.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleTons", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MarketVeh", IsMarketVeh_YN));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MarketVehImage", "0"));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "EngineNo", txtEngineNo.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ChasisNo", txtChasisNo.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RCBookNo", txtRCBookNo.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CertificateNo", txtCertificateNo.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "InsuranceNo", txtInsuranceNo.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VEHRTONo", txtRTONo.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VehicleRegDt", vehRegDateStr));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "InsuranceDt", vehPRMDateStr));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FitnessCertDt", fitnessCertDateStr));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver1", txtDriver1.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Licence1", txtLicence1.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RTO1", txtIssuedBy1.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ValidityDt1", licenceValDate1Str));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver1MOB", txtDriver1MOB.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver2", txtDriver2.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Licence2", txtLicence2.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "RTO2", txtIssuedBy2.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ValidityDt2", licenceValDate2Str));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Driver2MOB", txtDriver2MOB.Text.Trim()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AirTrainName", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FlightTrainNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AirWayBillRRNo", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "Airport", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AIRSCH_TM", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AWBNO", ""));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SPLRMOBNO", txtSupplierMOB.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SPLRNM", txtSupplierNM.Text.ToString()));
            if (txtVehicleCAP.Text == "")
                THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VEH_CAP", "0"));
            else
                THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "VEH_CAP", txtVehicleCAP.Text.ToString()));

            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "WTLOADED", txtWtLoaded.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CAPUTI", txtVehicleCapUti.Text.ToString()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OVLED_YN", txtOVLoadYN.Text.ToString().ToUpper()));
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OVLED_REASON", dllOverloadreasn.SelectedValue.ToString()));

            if (txtOVFS.Text == "")
                THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FreeSpace", "0"));
            else
                THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "FreeSpace", txtOVFS.Text.ToString()));

        }




        if (txtStartKM.Text == "")
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "STKM", "0"));
        else
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "STKM", txtStartKM.Text.ToString()));


        ///*New Added*/

        //if (dllVendorType.Items[dllVendorType.SelectedIndex].Value == "05" || dllVendorType.Items[dllVendorType.SelectedIndex].Value == "ZZ")
        //{

        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LOADOPERTYPE", ""));
        //    //xmlTHC = xmlTHC + "<LOADOPERTYPE></LOADOPERTYPE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVAMT", "0"));
        //    //xmlTHC = xmlTHC + "<ADVAMT>0</ADVAMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVPAIDBY", ""));
        //    //xmlTHC = xmlTHC + "<ADVPAIDBY></ADVPAIDBY>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVPAIDDATE", ""));
        //    //xmlTHC = xmlTHC + "<ADVPAIDDATE></ADVPAIDDATE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTRACTAMT", txtContractAmountOWN.Text.ToString()));
        //    //xmlTHC = xmlTHC + "<CONTRACTAMT>" + txtContractAmountOWN.Text + "</CONTRACTAMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TEL_CHRG", "0"));
        //    //xmlTHC = xmlTHC + "<TEL_CHRG>0</TEL_CHRG>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MAMUL_CHRG", "0"));
        //    //xmlTHC = xmlTHC + "<MAMUL_CHRG>0</MAMUL_CHRG>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LOAD_CHRG", "0"));
        //    //xmlTHC = xmlTHC + "<LOAD_CHRG>0</LOAD_CHRG>";

        //    //xmlTHC = xmlTHC + "<TDS_ACCCODE>" + nowDtStr + "</TDS_ACCCODE>";
        //    //xmlTHC = xmlTHC + "<TDS_ACCDESC>" + nowDtStr + "</TDS_ACCDESC>";
        //    //xmlTHC = xmlTHC + "<TDS_GRPCODE>" + nowDtStr + "</TDS_GRPCODE>";
        //    //xmlTHC = xmlTHC + "<TDS_GRPDESC>" + nowDtStr + "</TDS_GRPDESC>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_FOR", "-"));
        //    //xmlTHC = xmlTHC + "<TDS_FOR>-</TDS_FOR>";


        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SERVICE_RATE", "0"));
        //    //xmlTHC = xmlTHC + "<SERVICE_RATE>0</SERVICE_RATE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SERVICE_AMT", "0"));
        //    //xmlTHC = xmlTHC + "<SERVICE_AMT>0</SERVICE_AMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CESS_AMT", "0"));
        //    //xmlTHC = xmlTHC + "<CESS_AMT>0</CESS_AMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "HEDU_CESS_AMT", "0"));
        //    //xmlTHC = xmlTHC + "<HEDU_CESS_AMT>0</HEDU_CESS_AMT>";

        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "NET_BALANCE_AMT", "0"));
        //    //xmlTHC = xmlTHC + "<NET_BALANCE_AMT>0</NET_BALANCE_AMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADV_AMT_LAST_PAID", "0"));
        //    //xmlTHC = xmlTHC + "<ADV_AMT_LAST_PAID>0</ADV_AMT_LAST_PAID>";

        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "THCNEW_MODE", ""));
        //    //xmlTHC = xmlTHC + "<THCNEW_MODE></THCNEW_MODE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADV_PAID", ""));
        //    //xmlTHC = xmlTHC + "<ADV_PAID></ADV_PAID>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ROUTE_CAT", dllRouteMode.Items[dllRouteMode.SelectedIndex].Value.Trim()));
        //    //xmlTHC = xmlTHC + "<ROUTE_CAT>" + cboRouteMode.Items[cboRouteMode.SelectedIndex].Value.Trim() + "</ROUTE_CAT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_RATE", "0"));
        //    //xmlTHC = xmlTHC + "<TDS_RATE>0</TDS_RATE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_CHG", "0"));
        //    //xmlTHC = xmlTHC + "<TDS_CHG>0</TDS_CHG>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "PANNO", "-"));
        //    //xmlTHC = xmlTHC + "<PANNO>-</PANNO>";
        //    if (hdnBalamtbr.Value != "")
        //    {
        //        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", hdnBalamtbr.Value));
        //    }
        //    else
        //    {
        //        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", balamtbr.Text));
        //    }

        //    //xmlTHC = xmlTHC + "<BALAMTBRCD>" + balamtbr.Text + "</BALAMTBRCD>";

        //}
        //else
        //{
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LOADOPERTYPE", loadOpertype.Text));
        //    //xmlTHC = xmlTHC + "<LOADOPERTYPE>" + loadOpertype.Text + "</LOADOPERTYPE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVAMT", advanceamt.Text));
        //    //xmlTHC = xmlTHC + "<ADVAMT>" + advanceamt.Text + "</ADVAMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVPAIDBY", advpaidby.Text));
        //    //xmlTHC = xmlTHC + "<ADVPAIDBY>" + advpaidby.Text + "</ADVPAIDBY>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVPAIDDATE", nowDtStr));
        //    //xmlTHC = xmlTHC + "<ADVPAIDDATE>" + nowDtStr + "</ADVPAIDDATE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTRACTAMT", contractamt.Text.ToString()));
        //    //xmlTHC = xmlTHC + "<CONTRACTAMT>" + contractamt.Text + "</CONTRACTAMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TEL_CHRG", tel_chrg.Text));
        //    //xmlTHC = xmlTHC + "<TEL_CHRG>" + tel_chrg.Text + "</TEL_CHRG>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MAMUL_CHRG", mamul_chrg.Text));
        //    //xmlTHC = xmlTHC + "<MAMUL_CHRG>" + mamul_chrg.Text + "</MAMUL_CHRG>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LOAD_CHRG", load_chrg.Text));
        //    //xmlTHC = xmlTHC + "<LOAD_CHRG>" + load_chrg.Text + "</LOAD_CHRG>";

        //    //xmlTHC = xmlTHC + "<TDS_ACCCODE>" + nowDtStr + "</TDS_ACCCODE>";
        //    //xmlTHC = xmlTHC + "<TDS_ACCDESC>" + nowDtStr + "</TDS_ACCDESC>";
        //    //xmlTHC = xmlTHC + "<TDS_GRPCODE>" + nowDtStr + "</TDS_GRPCODE>";
        //    //xmlTHC = xmlTHC + "<TDS_GRPDESC>" + nowDtStr + "</TDS_GRPDESC>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_FOR", "-"));
        //    //xmlTHC = xmlTHC + "<TDS_FOR>-</TDS_FOR>";

        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SERVICE_RATE", svtax_rate.Text));
        //    //xmlTHC = xmlTHC + "<SERVICE_RATE>" + svtax_rate.Text + "</SERVICE_RATE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SERVICE_AMT", svrcamt.Text));
        //    //xmlTHC = xmlTHC + "<SERVICE_AMT>" + svrcamt.Text + "</SERVICE_AMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CESS_AMT", cessamt.Text));
        //    //xmlTHC = xmlTHC + "<CESS_AMT>" + cessamt.Text + "</CESS_AMT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "HEDU_CESS_AMT", hcessamt.Text));
        //    //xmlTHC = xmlTHC + "<HEDU_CESS_AMT>" + hcessamt.Text + "</HEDU_CESS_AMT>";

        //    if (balamt.Text.Trim() != "")
        //    {
        //        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "NET_BALANCE_AMT", balamt.Text));
        //        //xmlTHC = xmlTHC + "<NET_BALANCE_AMT>" + balamt.Text + "</NET_BALANCE_AMT>";
        //    }
        //    else
        //    {
        //        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "NET_BALANCE_AMT", "0"));
        //        //xmlTHC = xmlTHC + "<NET_BALANCE_AMT>0</NET_BALANCE_AMT>";
        //    }


        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADV_AMT_LAST_PAID", advanceamt.Text));
        //    //xmlTHC = xmlTHC + "<ADV_AMT_LAST_PAID>" + advanceamt.Text + "</ADV_AMT_LAST_PAID>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "THCNEW_MODE", "F"));
        //    //xmlTHC = xmlTHC + "<THCNEW_MODE>F</THCNEW_MODE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADV_PAID", "F"));
        //    //xmlTHC = xmlTHC + "<ADV_PAID>F</ADV_PAID>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ROUTE_CAT", dllRouteMode.Items[dllRouteMode.SelectedIndex].Value.Trim()));
        //    //xmlTHC = xmlTHC + "<ROUTE_CAT>" + cboRouteMode.Items[cboRouteMode.SelectedIndex].Value.Trim() + "</ROUTE_CAT>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_RATE", tds_rate.Text.Trim()));
        //    //xmlTHC = xmlTHC + "<TDS_RATE>" + tds_rate.Text.Trim() + "</TDS_RATE>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_CHG", tds_chrg.Text.Trim()));
        //    //xmlTHC = xmlTHC + "<TDS_CHG>" + tds_chrg.Text.Trim() + "</TDS_CHG>";
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "PANNO", pan_no.Text.Trim()));
        //    //xmlTHC = xmlTHC + "<PANNO>" + pan_no.Text.Trim() + "</PANNO>";

        //    if (hdnBalamtbr.Value != "")
        //    {
        //        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", hdnBalamtbr.Value));
        //    }
        //    else
        //    {
        //        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", balamtbr.Text));
        //    }

        //    //xmlTHC = xmlTHC + "<BALAMTBRCD>" + balamtbr.Text + "</BALAMTBRCD>";


        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AdvanceCash", txtAdvanceCash.Text));
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AdvanceCheque", txtAdvanceCheque.Text));
        //    THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OtherAdvance", txtOtherAdvance.Text));


        //}

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LOADOPERTYPE", loadOpertype.Text));
        //xmlTHC = xmlTHC + "<LOADOPERTYPE>" + loadOpertype.Text + "</LOADOPERTYPE>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVAMT", advanceamt.Text));
        //xmlTHC = xmlTHC + "<ADVAMT>" + advanceamt.Text + "</ADVAMT>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVPAIDBY", advpaidby.Text));
        //xmlTHC = xmlTHC + "<ADVPAIDBY>" + advpaidby.Text + "</ADVPAIDBY>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVPAIDDATE", nowDtStr));
        //xmlTHC = xmlTHC + "<ADVPAIDDATE>" + nowDtStr + "</ADVPAIDDATE>";
        //THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTRACTAMT", contractamt.Text.ToString()));
		if (dllVendorType.Items[dllVendorType.SelectedIndex].Value == "05")
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTRACTAMT", txtContractAmountOWN.Text.ToString()));
        }
        else
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTRACTAMT", contractamt.Text.ToString()));
        }
        //xmlTHC = xmlTHC + "<CONTRACTAMT>" + contractamt.Text + "</CONTRACTAMT>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TEL_CHRG", tel_chrg.Text));
        //xmlTHC = xmlTHC + "<TEL_CHRG>" + tel_chrg.Text + "</TEL_CHRG>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "MAMUL_CHRG", mamul_chrg.Text));
        //xmlTHC = xmlTHC + "<MAMUL_CHRG>" + mamul_chrg.Text + "</MAMUL_CHRG>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "LOAD_CHRG", load_chrg.Text));
        //xmlTHC = xmlTHC + "<LOAD_CHRG>" + load_chrg.Text + "</LOAD_CHRG>";

        //xmlTHC = xmlTHC + "<TDS_ACCCODE>" + nowDtStr + "</TDS_ACCCODE>";
        //xmlTHC = xmlTHC + "<TDS_ACCDESC>" + nowDtStr + "</TDS_ACCDESC>";
        //xmlTHC = xmlTHC + "<TDS_GRPCODE>" + nowDtStr + "</TDS_GRPCODE>";
        //xmlTHC = xmlTHC + "<TDS_GRPDESC>" + nowDtStr + "</TDS_GRPDESC>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_FOR", "-"));
        //xmlTHC = xmlTHC + "<TDS_FOR>-</TDS_FOR>";

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SERVICE_RATE", svtax_rate.Text));
        //xmlTHC = xmlTHC + "<SERVICE_RATE>" + svtax_rate.Text + "</SERVICE_RATE>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "SERVICE_AMT", svrcamt.Text));
        //xmlTHC = xmlTHC + "<SERVICE_AMT>" + svrcamt.Text + "</SERVICE_AMT>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CESS_AMT", cessamt.Text));
        //xmlTHC = xmlTHC + "<CESS_AMT>" + cessamt.Text + "</CESS_AMT>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "HEDU_CESS_AMT", hcessamt.Text));
        //xmlTHC = xmlTHC + "<HEDU_CESS_AMT>" + hcessamt.Text + "</HEDU_CESS_AMT>";

        if (balamt.Text.Trim() != "")
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "NET_BALANCE_AMT", balamt.Text));
            //xmlTHC = xmlTHC + "<NET_BALANCE_AMT>" + balamt.Text + "</NET_BALANCE_AMT>";
        }
        else
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "NET_BALANCE_AMT", "0"));
            //xmlTHC = xmlTHC + "<NET_BALANCE_AMT>0</NET_BALANCE_AMT>";
        }


        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADV_AMT_LAST_PAID", advanceamt.Text));
        //xmlTHC = xmlTHC + "<ADV_AMT_LAST_PAID>" + advanceamt.Text + "</ADV_AMT_LAST_PAID>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "THCNEW_MODE", "F"));
        //xmlTHC = xmlTHC + "<THCNEW_MODE>F</THCNEW_MODE>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADV_PAID", "F"));
        //xmlTHC = xmlTHC + "<ADV_PAID>F</ADV_PAID>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ROUTE_CAT", dllRouteMode.Items[dllRouteMode.SelectedIndex].Value.Trim()));
        //xmlTHC = xmlTHC + "<ROUTE_CAT>" + cboRouteMode.Items[cboRouteMode.SelectedIndex].Value.Trim() + "</ROUTE_CAT>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_RATE", tds_rate.Text.Trim()));
        //xmlTHC = xmlTHC + "<TDS_RATE>" + tds_rate.Text.Trim() + "</TDS_RATE>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TDS_CHG", tds_chrg.Text.Trim()));
        //xmlTHC = xmlTHC + "<TDS_CHG>" + tds_chrg.Text.Trim() + "</TDS_CHG>";
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "PANNO", pan_no.Text.Trim()));
        //xmlTHC = xmlTHC + "<PANNO>" + pan_no.Text.Trim() + "</PANNO>";

        if (hdnBalamtbr.Value != "")
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", hdnBalamtbr.Value));
        }
        else
        {
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", balamtbr.Text));
        }

        //xmlTHC = xmlTHC + "<BALAMTBRCD>" + balamtbr.Text + "</BALAMTBRCD>";


        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AdvanceCash", txtAdvanceCash.Text));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "AdvanceCheque", txtAdvanceCheque.Text));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "OtherAdvance", txtOtherAdvance.Text));

        /*New Added*/

        /*Removed*/
        /*
        if (txtAdvamt.Text == "")
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVAMT", "0"));
        else
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVAMT", txtAdvamt.Text.ToString()));
         
        
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ADVLOC", txtAdvPaidAt.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "BALAMTBRCD", txtBalPaidAt.Text.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTTYP", hdnContTyp.Value.ToString()));

        if (txtAdvamt.Text == "")
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTAMT", "0"));
        else
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CONTAMT", txtContamt.Text.ToString()));
        if (txtWtAdj.Text == "")
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "WTADJ", "0"));
        else
            THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "WTADJ", txtWtAdj.Text.ToString()));

        

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "WTADJ_PM", dllWtAdj.SelectedValue.ToString()));
         */
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOTWT_ADJ", fintotwt.ToString()));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "ENTRYBY", SessionUtilities.CurrentEmployeeID));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TCCount", hdnTHCTotCnote.Value));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOT_LOAD_PKGS", hdnTHCTotPkg.Value));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOT_ARRV_PKGS", hdnTHCTotPkg.Value));

        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOT_ARRV_ACTWT", hdnTHCTotWt.Value));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOT_PEND_PKGS", hdnTHCTotPkg.Value));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOT_CHARGE_WT", hdnTHCTotWt.Value));
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "TOT_LOAD_ACTWT", hdnTHCTotPkg.Value));
        // Add for changes of project P005871
        THCGenerate.AppendChild(CreateElement(XDocTHCSummary, "CEWBNo", txtCEWBNo.Text));
        //--

        Root.AppendChild(THCGenerate);
        XDocTHCSummary.AppendChild(Root);
        xmlTHCSummary = XDocTHCSummary.InnerXml.ToString();

        XmlDocument XDocTCSummary = new XmlDocument();
        XmlElement TCRoot = XDocTCSummary.CreateElement("root");
        XmlElement TCGenerate = XDocTCSummary.CreateElement("TC");

        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "TCNO", ""));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "TOTAL_DOCKETS", hdnTHCTotCnote.Value));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "LOADPKGSNO", hdnTHCTotPkg.Value));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "LOADACTUWT", hdnTHCTotWt.Value));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "LOADCFTWT", hdnTHCTotWt.Value));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "SourceHub", SessionUtilities.CurrentBranchCode));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "ToHubNext", txtTHCDestination.Text.ToString()));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "THCDT", docDateStr));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "RouteCode", RouteCode));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "RouteName", RouteName));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "VehicleNo", txtMarketVehicle.Text.ToString()));

        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "ActualDeptDate", docDateStr));
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "ActualDeptTime", txtTHCTime.Text.ToString()));
        // Add for changes of project P005871
        TCGenerate.AppendChild(CreateElement(XDocTCSummary, "CEWBNo", txtCEWBNo.Text.ToString()));
        //--
        TCRoot.AppendChild(TCGenerate);
        XDocTCSummary.AppendChild(TCRoot);
        xmlTCSummary = XDocTCSummary.InnerXml.ToString();

    }

    protected void reptHeader_OnItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRow dr = ((DataRowView)e.Item.DataItem).Row as DataRow;
            Label lblHead = e.Item.FindControl("lblTitle") as Label;
            HiddenField hidChargeCode = e.Item.FindControl("hidChargeCode") as HiddenField;
            lblHead.Text = dr["chargename"].ToString();
            lblHead.Font.Bold = true;
            hidChargeCode.Value = dr["chargecode"].ToString();

            if (hidChargeCode.Value == "")
                hdnChargeCodeAll.Value = Convert.ToString(hidChargeCode.Value);
            else
                hdnChargeCodeAll.Value = hdnChargeCodeAll.Value + "," + Convert.ToString(hidChargeCode.Value);
        }


    }

    protected void reptItemDet_OnItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRow dr = ((DataRowView)e.Item.DataItem).Row as DataRow;
            TextBox txtCharge = e.Item.FindControl("txtCharge") as TextBox;
            txtCharge.Attributes.Add("onkeypress", "javascript:return validFloat(event,'" + txtCharge.ClientID + "');");
            // txtCharge.Text = GetChargeAMT(crrDocket, dr["ChargeCode"].ToString());
            txtCharge.Text = "0.00";

        }
    }

}
