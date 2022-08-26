using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

public partial class GUI_Operations_DocketNonDeliveryUpdate_DocketNonDeliveryCriteria : System.Web.UI.Page
{
    SqlConnection conn;
    string FromDate="",ToDate="";
    MyFunctions fn = new MyFunctions();
    SqlConnection con;
    
    //public string GenXml
    //{
    //    get
    //    {
    //        if (ViewState["Xml_MR_Wise_Det"] != null)
    //            return ViewState["Xml_MR_Wise_Det"] as string;
    //        else
    //            return "";
    //    }
    //    set
    //    {
    //        ViewState["Xml_MR_Wise_Det"] = value;
    //    }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        MySQLDataSource_Vendors.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_VendorTypes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        hBrCd.Value = Session["brcd"].ToString().Trim();
        string GridData = "USP_GET_DeliveryMR_Details";
        FromDate = Request.QueryString.Get("fromdt");
        ToDate = Request.QueryString.Get("todt");
        SqlParameter[] arParms = new SqlParameter[4];
        arParms[0] = ControllersHelper.GetSqlParameter("@FromDt", FromDate.ToString().Trim(), SqlDbType.Text);
        arParms[1] = ControllersHelper.GetSqlParameter("@ToDt", ToDate.ToString().Trim(), SqlDbType.Text);
        arParms[2] = ControllersHelper.GetSqlParameter("@DockNo", Request.QueryString["DocketNo"].ToString().Trim(), SqlDbType.Text);
        arParms[3] = ControllersHelper.GetSqlParameter("@Brcd", Session["brcd"].ToString().Trim(), SqlDbType.Text);
        DataTable Dt_GridData = new DataTable();
        try
        {
            if (!IsPostBack && !IsCallback)
            {
                DataSet ds_GridData = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, GridData,arParms);
                if (ds_GridData.Tables.Count > 0)
                {
                    GV_DDMRList.DataSource = ds_GridData.Tables[0];
                    GV_DDMRList.DataBind();
                }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    private void popVendor()
    {
        string sql = "Select Vendor_Type_Code='',Vendor_Type='--Select--' Union select codeid,codedesc  from webx_master_general  where codetype='VENDTY' and statuscode='Y' Union Select Vendor_Type_Code='XX',Vendor_Type='Market'";
        DataTable Dt_VendorType = new DataTable();
        try
        {
            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql);
            if (ds.Tables.Count > 0)
            {
                cboVendorType.DataSource = ds.Tables[0];
                cboVendorType.DataBind();
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        cboVendorType.CssClass = "blackfnt";
        cboVendorType.Items.Add(new ListItem("Select", ""));
        cboVendorType.SelectedValue = "";
    }
    
    protected void OnVendorChange(object sender, EventArgs e)
    {
        con.Open();
        string sql = "";
        if (cboVendors.SelectedIndex < 0)
        {
            sql = "Exec usp_Vendor_Vehicles '','" + cboVendorType.Items[cboVendorType.SelectedIndex].Value + "'";
        }
        else
        {
            sql = "Exec usp_Vendor_Vehicles '" + cboVendors.Items[cboVendors.SelectedIndex].Value + "','" + cboVendorType.Items[cboVendorType.SelectedIndex].Value + "'";
        }
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds= new DataSet();
        da.Fill(ds);

        cboVehicles.DataSource = ds;
        cboVehicles.DataValueField = ds.Tables[0].Columns[0].ColumnName;
        cboVehicles.DataTextField = ds.Tables[0].Columns[1].ColumnName;
        cboVehicles.DataBind();

        con.Close();
    }
    protected void OnVehicleChange(object sender, EventArgs e)
    {
        con.Open();
        string sql_Type = "Select TypeCode='',Type_Name='--Select--' Union Select TypeCode=Convert(Varchar,Type_Code), [Type_Name] From WebX_Vehicle_Type Where ActiveFlag='Y' and Type_Code in (Select Vehicle_Type From WebX_Vehicle_Hdr Where Vehno=ltrim(rtrim('" + cboVehicles.SelectedValue + "'))) ";
        SqlCommand cmd_Type = new SqlCommand(sql_Type, con);
        SqlDataAdapter da_Type = new SqlDataAdapter(cmd_Type);
        DataSet ds_Type = new DataSet();
        da_Type.Fill(ds_Type);
        cboVehicleTypes.DataSource = ds_Type;
        cboVehicleTypes.DataBind();

        string sql_FTL = "Select CodeID='',CodeDesc='--Select--' Union SELECT CodeID,CodeDesc=codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y' and  codeid in (Select FTLTYPE From WebX_Vehicle_Hdr Where Vehno=ltrim(rtrim('" + cboVehicles.SelectedValue + "')))";
        SqlCommand cmd_FTL = new SqlCommand(sql_FTL, con);
        SqlDataAdapter da_FTL = new SqlDataAdapter(cmd_FTL);
        DataSet ds_FTL = new DataSet();
        da_FTL.Fill(ds_FTL);
        cboFTLTypes.DataSource = ds_FTL;
        cboFTLTypes.DataBind();

        string sql_Trip = "Select CodeSlipNo='',VSlipNo='--Select--',Manual_TripSheetNo='' Union (select CodeSlipNo=VSlipNo,VSlipNo,Manual_TripSheetNo from WEBX_FLEET_VEHICLE_ISSUE I,webx_vehicle_hdr V where vehno=VehicleNo and isnull(cancel_status,'N')='N' and VehicleNo='" + cboVehicles.SelectedValue + "' and f_closure_closekm is null )";
        SqlCommand cmd_Trip = new SqlCommand(sql_Trip, con);
        SqlDataAdapter da_Trip = new SqlDataAdapter(cmd_Trip);
        DataSet ds_Trip = new DataSet();
        da_Trip.Fill(ds_Trip);
        cboTripSheet.DataSource = ds_Trip;
        cboTripSheet.DataBind();
        
        con.Close();
    }
    protected void OnVendorTypeChange(object sender, EventArgs e)
    {
        string VendorType = cboVendorType.SelectedValue.ToString();
        if (VendorType == "XX")
        {
            txtMarketVendor.Visible = true;
            txtMktVeh.Visible = true;
            txtMarketVendor.Text = "";
            txtMktVeh.Text = "";
            cboVendors.Visible = false;
            cboVehicles.Visible = false;
        }
        else
        {
            cboVendors.Visible = true;
            cboVehicles.Visible = true;
            txtMarketVendor.Visible = false;
            txtMktVeh.Visible = false;
        }
        if (VendorType == "05")
        {
            cboTripSheet.Enabled = true;
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            string Xml_MR_Det = "<root>";
            foreach (GridViewRow gridrow in GV_DDMRList.Rows)
            {
                Label Lbl_Dockno = (Label)gridrow.FindControl("LblDOCKNO");
                Label LblMRSNO = (Label)gridrow.FindControl("LblMRSNO");
                Label LblDOCKETDT = (Label)gridrow.FindControl("LblDOCKETDT");
                Label LblConsignee = (Label)gridrow.FindControl("LblConsignee");
                Label LblDDLCharge = (Label)gridrow.FindControl("LblDDLCharge");
                Label LblPrivate = (Label)gridrow.FindControl("LblPrivate");

                TextBox TxtBookedPkt = (TextBox)gridrow.FindControl("TxtBookedPkt");
                TextBox TxtGievnPkt = (TextBox)gridrow.FindControl("TxtGievnPkt");
                TextBox TxtPendPkt = (TextBox)gridrow.FindControl("TxtPendPkt");
                Label LblCHRGWT = (Label)gridrow.FindControl("LblCHRGWT");

                CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");
                Xml_MR_Det = Xml_MR_Det + "<MR_Det>";
                if (Chk_Docno.Checked == true)
                {
                    string Update_Str = "UPDATE Webx_DDMR_DET SET PendPkt=0 WHERE PendPkt>0 AND DOCKNO='" + Lbl_Dockno.Text.ToString() + "'";
                    SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, Update_Str);
                    
                    Xml_MR_Det = Xml_MR_Det + "<Dockno>" + Lbl_Dockno.Text.ToString() + "</Dockno>";
                    Xml_MR_Det = Xml_MR_Det + "<DockDt>" + LblDOCKETDT.Text.ToString() + "</DockDt>";
                    Xml_MR_Det = Xml_MR_Det + "<MRNo>" + LblMRSNO.Text.ToString() + "</MRNo>";
                    Xml_MR_Det = Xml_MR_Det + "<Consignee>" + LblConsignee.Text.ToString() + "</Consignee>";
                    if (LblDDLCharge.Text.ToString() == "0.00 (FOC)")
                    {
                        Xml_MR_Det = Xml_MR_Det + "<Charge>0.00</Charge>";
                    }
                    else
                    {
                        Xml_MR_Det = Xml_MR_Det + "<Charge>" + LblDDLCharge.Text.ToString() + "</Charge>";
                    }
                    Xml_MR_Det = Xml_MR_Det + "<PrivateMr>" + LblPrivate.Text.ToString() + "</PrivateMr>";
                    Xml_MR_Det = Xml_MR_Det + "<BookedPkt>" + Convert.ToDouble(TxtBookedPkt.Text.ToString()) + "</BookedPkt>";
                    Xml_MR_Det = Xml_MR_Det + "<GivenPkt>" + Convert.ToDouble(TxtGievnPkt.Text.ToString()) + "</GivenPkt>";
                    Xml_MR_Det = Xml_MR_Det + "<PendPkt>" + Convert.ToDouble(TxtPendPkt.Text.ToString()) + "</PendPkt>";
                    Xml_MR_Det = Xml_MR_Det + "<ChargeWeight>" + Convert.ToDouble(LblCHRGWT.Text.ToString()) + "</ChargeWeight>";
                }
                Xml_MR_Det = Xml_MR_Det + "</MR_Det>";
            }
            Xml_MR_Det = Xml_MR_Det + "</root>";

            string Xml_MR_HDR = "<root><MR_HDR>";
            string Vendor_Detail = "", VendorCode = "", VendorName = "";
            string[] VendorCls;
            string VendorType = cboVendorType.SelectedValue.ToString();
            if (VendorType != "XX")
            {
                Vendor_Detail = cboVendors.SelectedItem.ToString();
                VendorCls = Vendor_Detail.Split(':');
                VendorCode = VendorCls[0].ToString();
                VendorName = VendorCls[1].ToString();
            }
            Xml_MR_HDR = Xml_MR_HDR + "<ManualMRNo>" + TxtManualDDMRNo.Text.ToString() + "</ManualMRNo>";
            Xml_MR_HDR = Xml_MR_HDR + "<DDMRDt>" + fn.Mydate1(TxtDDMRDate.Text.ToString()) + "</DDMRDt>";
            Xml_MR_HDR = Xml_MR_HDR + "<Brcd>" + Session["brcd"].ToString() + "</Brcd>";
            Xml_MR_HDR = Xml_MR_HDR + "<FromLoc>" + TxtFromLoc.Text.ToString() + "</FromLoc>";
            Xml_MR_HDR = Xml_MR_HDR + "<ToLoc>" + TxtToLoc.Text.ToString() + "</ToLoc>";
            Xml_MR_HDR = Xml_MR_HDR + "<VendType>" + cboVendorType.SelectedValue.ToString() + "</VendType>";
            
            if (VendorType == "XX")
            {
                Xml_MR_HDR = Xml_MR_HDR + "<VendorCode>8888</VendorCode>";
                Xml_MR_HDR = Xml_MR_HDR + "<VendorName>" + txtMarketVendor.Text.ToString() + "</VendorName>";
                Xml_MR_HDR = Xml_MR_HDR + "<Vehicle>" + txtMktVeh.Text.ToString() + "</Vehicle>";
            }
            else
            {
                Xml_MR_HDR = Xml_MR_HDR + "<VendorCode>" + VendorCode + "</VendorCode>";
                Xml_MR_HDR = Xml_MR_HDR + "<VendorName>" + VendorName + "</VendorName>";
                Xml_MR_HDR = Xml_MR_HDR + "<Vehicle>" + cboVehicles.SelectedValue.ToString() + "</Vehicle>";
            }
            Xml_MR_HDR = Xml_MR_HDR + "<VehicleType>" + cboVehicleTypes.SelectedValue.ToString() + "</VehicleType>";
            Xml_MR_HDR = Xml_MR_HDR + "<FTLType>" + cboFTLTypes.SelectedValue.ToString() + "</FTLType>";
            if (VendorType == "05")
            {
                Xml_MR_HDR = Xml_MR_HDR + "<TripSheetNo>" + cboTripSheet.SelectedValue.ToString() + "</TripSheetNo>";
            }
            else
            {
                Xml_MR_HDR = Xml_MR_HDR + "<TripSheetNo></TripSheetNo>";
            }            
            Xml_MR_HDR = Xml_MR_HDR + "<Remarks>" + TxtRemarks.Text.ToString() + "</Remarks>";
            Xml_MR_HDR = Xml_MR_HDR + "<DriverNm>" + TxtDriverName.Text.ToString() + "</DriverNm>";
            Xml_MR_HDR = Xml_MR_HDR + "<DriverMobileNo>" + TxtMobNo.Text.ToString() + "</DriverMobileNo>";
            Xml_MR_HDR = Xml_MR_HDR + "<LicenceNo>" + TxtLicenseNo.Text.ToString() + "</LicenceNo>";
            Xml_MR_HDR = Xml_MR_HDR + "<RTO>" + TxtRTO.Text.ToString() + "</RTO>";
            Xml_MR_HDR = Xml_MR_HDR + "<LicenceDate>" + fn.Mydate1(TxtValDate.Text.ToString()) + "</LicenceDate>";

            Xml_MR_HDR = Xml_MR_HDR + "<ContractAmt>" + Convert.ToDouble(TxtContrctAmt.Text.ToString()) + "</ContractAmt>";
            Xml_MR_HDR = Xml_MR_HDR + "<BalanceAmt>" + Convert.ToDouble(TxtBalAmt.Text.ToString()) + "</BalanceAmt>";
            Xml_MR_HDR = Xml_MR_HDR + "<BalanceLoc>" + TxtBalLoc.Text.ToString() + "</BalanceLoc>";
            Xml_MR_HDR = Xml_MR_HDR + "<AdvanceAmt>" + Convert.ToDouble(TxtAdvAmt.Text.ToString()) + "</AdvanceAmt>";
            Xml_MR_HDR = Xml_MR_HDR + "<AdvanceLoc>" + TxtAdvLoc.Text.ToString() + "</AdvanceLoc>";

            Xml_MR_HDR = Xml_MR_HDR + "</MR_HDR></root>";

            string DDMRSNO = "", TranXaction = "";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            SqlTransaction trans = conn.BeginTransaction();
            try
            {
                string sql = "Usp_DDMR_Generate";

                SqlParameter[] prm = new SqlParameter[5];
                prm[0] = new SqlParameter("@MR_Location", SqlDbType.VarChar);
                prm[0].Value = Session["brcd"].ToString();
                prm[1] = new SqlParameter("@Xml_DDMR_HDR", SqlDbType.Text);
                prm[1].Value = Xml_MR_HDR.Replace("&", "&amp;").Replace("–", "-").Trim();
                prm[2] = new SqlParameter("@Xml_DDMR_DET", SqlDbType.Text);
                prm[2].Value = Xml_MR_Det.Replace("&", "&amp;").Replace("–", "-").Trim();
                prm[3] = new SqlParameter("@FinYear", SqlDbType.Text);
                prm[3].Value = Session["FinYear"].ToString().Substring(2, 2).Trim();
                prm[4] = new SqlParameter("@EntryBy", SqlDbType.Text);
                prm[4].Value = Session["empcd"].ToString();

                DataTable ResultDtl = SqlHelper.ExecuteDataset(trans, CommandType.StoredProcedure, sql, prm).Tables[0];
                if (ResultDtl.Rows.Count > 0)
                {
                    DataRow ResultDtlRow = ResultDtl.Rows[0];
                    if (ResultDtlRow["Status"] != DBNull.Value)
                    {
                        int status = Convert.ToInt32(ResultDtlRow["Status"]);
                        TranXaction = ResultDtlRow["Message"].ToString();

                        if (status == 0 && TranXaction != "Done")
                            throw new Exception(ResultDtlRow["Message"].ToString());
                        if (status == 1)
                        {
                            DDMRSNO = ResultDtlRow["MRSNO"].ToString();
                        }
                    }
                    else
                        throw new Exception("Unknown Exception");
                }
                trans.Commit();
            }
            catch (Exception exp)
            {
                trans.Rollback();
                throw exp;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            Response.Redirect("DDMR_Done.aspx?DDMRSNO=" + DDMRSNO + "&TranXaction=" + TranXaction);
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }
    protected void ButStep1_Click(object sender, EventArgs e)
    {
        ButStep1.Enabled = false;
        btnFromLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtFromLoc.ClientID.ToString() + "','none')");
        btnToLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtToLoc.ClientID.ToString() + "','none')");
        ButAdvLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtAdvLoc.ClientID.ToString() + "','none')");
        ButBalLoc.Attributes.Add("onclick", "popuplist('LocCode','" + TxtBalLoc.ClientID.ToString() + "','none')");

        TxtToLoc.Attributes.Add("onblur", "LocBlur('" + TxtToLoc.ClientID.ToString() + "')");
        TxtAdvLoc.Attributes.Add("onblur", "LocBlur('" + TxtAdvLoc.ClientID.ToString() + "')");
        TxtBalLoc.Attributes.Add("onblur", "LocBlur('" + TxtBalLoc.ClientID.ToString() + "')");

        TxtDDMRDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        TxtValDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        TxtFromLoc.Text = Session["brcd"].ToString();
        TxtToLoc.Text = Session["brcd"].ToString();
        TxtAdvLoc.Text = Session["brcd"].ToString();
        TxtBalLoc.Text = Session["brcd"].ToString();
        //Step1.Visible = false;
        //gridview.Visible = false;
        GV_DDMRList.Enabled = false;
        DDMRProcess.Visible = true;
        submit.Visible = true;
        TxtManualDDMRNo.Focus();
        //popVendor();
        con.Open();

        string sql_Type = "Select TypeCode='',Type_Name='--Select--' Union Select TypeCode=Convert(Varchar,Type_Code), [Type_Name] From WebX_Vehicle_Type Where ActiveFlag='Y' ";
        SqlCommand cmd_Type = new SqlCommand(sql_Type, con);
        SqlDataAdapter da_Type = new SqlDataAdapter(cmd_Type);
        DataSet ds_Type = new DataSet();
        da_Type.Fill(ds_Type);
        cboVehicleTypes.DataSource = ds_Type;
        cboVehicleTypes.DataBind();

        string sql_FTL = "Select CodeID='',CodeDesc='--Select--' Union SELECT CodeID,CodeDesc=codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y'";
        SqlCommand cmd_FTL = new SqlCommand(sql_FTL, con);
        SqlDataAdapter da_FTL = new SqlDataAdapter(cmd_FTL);
        DataSet ds_FTL = new DataSet();
        da_FTL.Fill(ds_FTL);
        cboFTLTypes.DataSource = ds_FTL;
        cboFTLTypes.DataBind();

        con.Close();

        //foreach (GridViewRow gridrow in GV_DDMRList.Rows)
        //{
        //    Label Lbl_Dockno = (Label)gridrow.FindControl("LblDOCKNO");
        //    Label LblMRSNO = (Label)gridrow.FindControl("LblMRSNO");
        //    Label LblDOCKETDT = (Label)gridrow.FindControl("LblDOCKETDT");
        //    Label LblConsignee = (Label)gridrow.FindControl("LblConsignee");
        //    Label LblDDLCharge = (Label)gridrow.FindControl("LblDDLCharge");
        //    Label LblPrivate = (Label)gridrow.FindControl("LblPrivate");
            
        //    TextBox TxtBookedPkt = (TextBox)gridrow.FindControl("TxtBookedPkt");
        //    TextBox TxtGievnPkt = (TextBox)gridrow.FindControl("TxtGievnPkt");
        //    TextBox TxtPendPkt = (TextBox)gridrow.FindControl("TxtPendPkt");

        //    CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");
        //    Xml_MR_Det = Xml_MR_Det + "<MR_Det>";
        //    if (Chk_Docno.Checked==true)
        //    {
        //        Xml_MR_Det = Xml_MR_Det + "<Dockno>" + Lbl_Dockno.Text.ToString() + "</Dockno>";
        //        Xml_MR_Det = Xml_MR_Det + "<DockDt>" + LblDOCKETDT.Text.ToString() + "</DockDt>";
        //        Xml_MR_Det = Xml_MR_Det + "<MRNo>" + LblMRSNO.Text.ToString() + "</DockMRNono>";
        //        Xml_MR_Det = Xml_MR_Det + "<Consignee>" + LblConsignee.Text.ToString() + "</Consignee>";
        //        Xml_MR_Det = Xml_MR_Det + "<Charge>" + LblDDLCharge.Text.ToString() + "</Charge>";
        //        Xml_MR_Det = Xml_MR_Det + "<PrivateMr>" + LblPrivate.Text.ToString() + "</PrivateMr>";
        //        Xml_MR_Det = Xml_MR_Det + "<BookedPkt>" + TxtBookedPkt.Text.ToString() + "</BookedPkt>";
        //        Xml_MR_Det = Xml_MR_Det + "<GivenPkt>" + TxtGievnPkt.Text.ToString() + "</GivenPkt>";
        //        Xml_MR_Det = Xml_MR_Det + "<PendPkt>" + TxtPendPkt.Text.ToString() + "</PendPkt>";
        //    }
        //    Xml_MR_Det = Xml_MR_Det + "</MR_Det>";
        //}

    }
}
