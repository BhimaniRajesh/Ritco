using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Operations_THC_THCCreateMain : BasePage
{
    public static string xmlTC = "";
    public static string xmlTC_Summary = "";
    public static string xmlTHC = "";
    string TripSheetNo = "";

    DateTime docDate;
    DateTime vehRegDate;
    DateTime insuraceDate;
    DateTime fitnessCertDate;
    DateTime licenceValDate1;
    DateTime licenceValDate2;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        MySQLDataSource_Routes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_RouteNames.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_VendorTypes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vendors.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicle_Types.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicles.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_MFAvailable.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_TS.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_TDSAccCode.ConnectionString = Session["SqlProvider"].ToString().Trim();

	

        if (IsPostBack)
        {
            tblMFList.Visible = true;
        }
        else
        {
	    CreateToken();
            txtMktVeh.Visible = false;
            cboVehicles.Visible = true;

            hBrCd.Value = Session["brcd"].ToString().Trim();
            txtTHCDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtHHMM.Text = DateTime.Now.ToString("HH:mm");
            txtLoadSupCode.Text = Session["empcd"].ToString().Trim();
            balamtbr.Text = Session["brcd"].ToString().Trim();
            txtOutRemarks.Text = "okay";
        }
        hSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
    }

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
            VendorCode = cboVendors.Items[cboVendors.SelectedIndex].Value.Trim();
            Vehicle = cboVehicleTypes.SelectedValue.ToString();//txtMktVeh.Text.Trim();
            tmpString = cboRouteName.Items[cboRouteName.SelectedIndex].Text.Split(':');
            RouteCode = tmpString[0];
        }
        catch (Exception ex)
        {
        }
        
        int TotalWt = 0;
        for (int index = 0; index < dgMFs.Rows.Count; index++)
        {
            CheckBox chkMFs = (CheckBox)dgMFs.Rows[index].FindControl("chkMF");

            if (chkMFs.Checked == true)
            {
                TotalWt += Convert.ToInt32(dgMFs.DataKeys[index].Values[3]);
            }
        }

        string sql = "Exec Webx_COntAmt_THCGen '" + VendorCode +  "','" + Vehicle + "','" + RouteCode + "'," + TotalWt;
        
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

        contractamt.Focus() ;
    }

    protected void GetPANNumber()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();
        string strSQL = "Select PAN_NO From WebX_Vendor_Hdr Where VendorCode='" + cboVendors.Items[cboVendors.SelectedIndex].Value.ToString().Trim() + "'";
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        sqlCommand.CommandType = CommandType.Text;
        SqlDataReader dr = sqlCommand.ExecuteReader();
        while (dr.Read())
        {
            pan_no.Text = dr["pan_no"].ToString();
        }
        dr.Close();
    }

    protected void OnTSChange(object sender, EventArgs e)
    {
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sql = "Exec usp_TS_DriverInfo '" + cboTripSheet.Items[cboTripSheet.SelectedIndex].Value + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        EnableDisableDriverInfo(true);
        while (dr.Read())
        {
            txtDriver1.Text = dr["Driver1"].ToString();
            txtLicence1.Text = dr["Licno1"].ToString();
            txtIssuedBy1.Text = dr["RTO1"].ToString();
            txtLVDate1.Text = dr["Validity_Date1"].ToString();

            txtDriver2.Text = dr["Driver2"].ToString();
            txtLicence2.Text = dr["Licno2"].ToString();
            txtIssuedBy2.Text = dr["RTO2"].ToString();
            txtLVDate2.Text = dr["Validity_Date2"].ToString();

            EnableDisableDriverInfo(false);
        }

        dr.Close();
        con.Close();
    }

    protected void OnVehicleChange(object sender, EventArgs e)
    {
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        txtMktVeh.Visible = false;

        if (cboVehicles.Items[cboVehicles.SelectedIndex].Value == "O")
        {
            txtMktVeh.Text = "";
            txtMktVeh.Visible = true;
        }
        else
        {
            txtMktVeh.Text = cboVehicles.Items[cboVehicles.SelectedIndex].Value;
        }

        string sql = "Exec usp_Vehicles '" + cboVehicles.Items[cboVehicles.SelectedIndex].Value + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        EnableDisableVehInfo(true);
        while (dr.Read())
        {
            txtChasisNo.Text = dr["ChasisNo"].ToString();
            txtEngineNo.Text = dr["EngineNo"].ToString();
            txtRCBookNo.Text = dr["RCBookNo"].ToString();

            txtVRDate.Text = dr["RegistrationDt"].ToString();
            txtIPDate.Text = dr["InsuranceValDt"].ToString();
            txtFCDate.Text = dr["FitnessValDt"].ToString();
            EnableDisableVehInfo(false);
        }

        dr.Close();
        con.Close();
    }

    protected void EnableDisableDriverInfo(bool boo)
    {
        txtDriver1.Enabled = boo;
        txtLicence1.Enabled = boo;
        txtIssuedBy1.Enabled = boo;
        txtLVDate1.Enabled = boo;

        txtDriver2.Enabled = boo;
        txtLicence2.Enabled = boo;
        txtIssuedBy2.Enabled = boo;
        txtLVDate2.Enabled = boo;
    }

    protected void EnableDisableVehInfo(bool boo)
    {
        txtChasisNo.Enabled = boo;
        txtEngineNo.Enabled = boo;
        txtRCBookNo.Enabled = boo;

        txtVRDate.Enabled = boo;
        txtIPDate.Enabled = boo;
        txtFCDate.Enabled = boo;
    }

    protected void OnTHCDateChange(object sender, EventArgs e)
    {
        tblMFList.Visible = false;
        trPaymentDetails.Visible = false;
    }

    protected void OnRouteNameChange(object sender, EventArgs e)
    {
        tblMFList.Visible = false;
        trPaymentDetails.Visible = false;
        DropDownList dl = (DropDownList)sender;
        if (dl.Items[dl.SelectedIndex].Value != "")
        {
            ShowScheduletDeptTime();
            //Commented 30 March 2008
            //trPaymentDetails.Visible = true;
            tblMFList.Visible = true;
        }
    }

    protected void ShowScheduletDeptTime()
    {
        //lblSchdDeptTime
        string[] tmpString = cboRouteName.Items[cboRouteName.SelectedIndex].Text.Split(':');
        string RouteCode = tmpString[0];
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sql = "";
        sql = "Exec WebX_SP_GetScheduledDateTimeForRouteCode '" + RouteCode + "'";// cboRouteName.Items[cboRouteName.SelectedIndex].Text + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        lblSchdDeptTime.Text = "";
        hSchdDeptTime.Value = "";
        while (dr.Read())
        {
            lblSchdDeptTime.Text = dr["SchTime"].ToString();
            hSchdDeptTime.Value = dr["SchTime"].ToString();
        }

        if (lblSchdDeptTime.Text.Trim() == "")
        {
            lblSchdDeptTime.Text = DateTime.Now.ToString("HH:mm");
            hSchdDeptTime.Value = DateTime.Now.ToString("HH:mm");
        }

        dr.Close();
        con.Close();
    }

    protected void ConfirmOpData(object sender, EventArgs e)
    {
        BlockCriteriaDivision(true);
        BlockMFSelection(true);
        dgMFs.Enabled = false;
        btnConfirmOpData.Enabled = false;

        if (cboVendorType.Items[cboVendorType.SelectedIndex].Value == "05" || cboVendorType.Items[cboVendorType.SelectedIndex].Value == "ZZ")
        {
            trPaymentDetails_Own.Visible = true;
            trPaymentDetails.Visible = false;
        }
        else
        {
            trPaymentDetails_Own.Visible = false;
            trPaymentDetails.Visible = true;
        }
        trSubmit.Visible = true;
        PopulateContractAmt();
        //Response.End();
    }

    protected void GenerateTHC(object sender, EventArgs e)
    {
	if (IsTokenValid())
        {
            try
            {    
		ConsumeToken();
        	int retGenXML = GenerateXML();

        	//Make & Open Connection
        	SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
	        sqlCon.Open();
	        //--------------------------------
	        xmlTHC = xmlTHC.Replace("&", " and ");
	
	        xmlTC = xmlTC.Replace("&", " and ");
	
	        xmlTC_Summary = xmlTC_Summary.Replace("&", " and ");
	
	
        	string sql = "usp_THC_Generate";
	        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
	        sqlCmd.CommandType = CommandType.StoredProcedure;
	        sqlCmd.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = hBrCd.Value; //Session["brcd"].ToString().Trim();
	        sqlCmd.Parameters.Add("@EmpCode", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
	        sqlCmd.Parameters.Add("@THCDT", SqlDbType.DateTime).Value = docDate;
	        sqlCmd.Parameters.Add("@XMLTHC", SqlDbType.Text).Value = xmlTHC.Replace("&", "&amp").Trim();//xmlTHC.Trim();
	        sqlCmd.Parameters.Add("@XMLTC", SqlDbType.Text).Value = xmlTC.Trim();
	        sqlCmd.Parameters.Add("@XMLTC_Summary", SqlDbType.Text).Value = xmlTC_Summary.Trim();
	        sqlCmd.Parameters.Add("@TripSheetNo", SqlDbType.Text).Value = TripSheetNo;
        	sqlCmd.Parameters.Add("@FinYear", SqlDbType.Text).Value = Session["FinYear"].ToString().Trim();
	
	
	        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
	
	        DataSet ds = new DataSet();
	        da.Fill(ds);
		
	        da.Dispose();
	
	        string THCCodeGenerated = "";
	        string Tranzaction = "";
	
	        THCCodeGenerated = ds.Tables[0].Rows[0]["THCNo"].ToString();
        	Tranzaction = ds.Tables[0].Rows[0]["TranXaction"].ToString().Trim();
	
        	Response.Redirect("DisplayTHCResult.aspx?THCNo=" + THCCodeGenerated + "&ManTHCNo=" + txtManualTHCNo.Text.Trim() + "&Tranzaction=" + Tranzaction);
	    }
            catch (Exception ex)
            {
				ExceptionUtility.LogException(ex, "THCCreateMain.aspx->Thc Generate");
                MsgBox.Show(ex.Message);
            }
        }
    }

    protected int GenerateXML()
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        DateTime nowDt;

        nowDt = DateTime.Now;
        string nowDtStr = nowDt.ToString("dd MMMM yyyy");

        docDate = Convert.ToDateTime(txtTHCDate.Text, dtfi);
        string docDateStr = docDate.ToString("dd MMMM yyyy");

        string vehRegDateStr = "01 January 1900";
        string insuraceDateStr = "01 January 1900";
        string fitnessCertDateStr = "01 January 1900";
        string licenceValDate1Str = "01 January 1900";
        string licenceValDate2Str = "01 January 1900";
        try
        {
            vehRegDate = Convert.ToDateTime(txtVRDate.Text, dtfi);
            vehRegDateStr = vehRegDate.ToString("dd MMMM yyyy");

            insuraceDate = Convert.ToDateTime(txtIPDate.Text, dtfi);
            insuraceDateStr = insuraceDate.ToString("dd MMMM yyyy");

            fitnessCertDate = Convert.ToDateTime(txtFCDate.Text, dtfi);
            fitnessCertDateStr = fitnessCertDate.ToString("dd MMMM yyyy");

            licenceValDate1 = Convert.ToDateTime(txtLVDate1.Text, dtfi);
            licenceValDate1Str = licenceValDate1.ToString("dd MMMM yyyy");

            licenceValDate2 = Convert.ToDateTime(txtLVDate2.Text, dtfi);
            licenceValDate2Str = licenceValDate2.ToString("dd MMMM yyyy");
        }
        catch(Exception ex){
        }

        //if (txtLVDate1.Text.Trim() != "")
        //{
        //    licenceValDate1 = Convert.ToDateTime(txtLVDate1.Text, dtfi);
        //    licenceValDate1Str = licenceValDate1.ToString("dd MMMM yyyy");
        //}

        //if (txtLVDate2.Text.Trim() != "")
        //{
        //    licenceValDate2 = Convert.ToDateTime(txtLVDate2.Text, dtfi);
        //    licenceValDate2Str = licenceValDate2.ToString("dd MMMM yyyy");
        //}

        int TCCount = 0;
        int TotalDkts = 0;
        int TotalPkgs = 0;
        int TotalWt = 0;

        string[] tmpString = cboRouteName.Items[cboRouteName.SelectedIndex].Text.Split(':');
        string RouteCode = tmpString[0].Trim();
        string RouteName = tmpString[1].Trim();
        string[] tmpString2 = RouteName.Split('-');

        string ToHubNext = tmpString2[1].Trim();
        string ToHubLast = tmpString2[tmpString2.Length - 1].Trim();

        string[] tmpString3 = cboVendors.Items[cboVendors.SelectedIndex].Text.Split(':');
        string VendorCode = tmpString3[0].Trim().Replace("-","");
        string VendorName = tmpString3[1].Trim();

        string IsMarketVeh_YN = (txtMktVeh.Visible == true ? "Y" : "N");
        VendorName = (txtMktVeh.Visible == true ? txtMarketVendor.Text.Trim() : VendorName);

        string AirTrainName = "";
        string FlightTrainName = "";
        string AirWayBillRRNo = "";

        string LateDeptReason = cboLateDeptReason.Items[cboLateDeptReason.SelectedIndex].Value.Trim();
        TripSheetNo = "";
        if (cboTripSheet.SelectedIndex > -1)
        {
            TripSheetNo = cboTripSheet.Items[cboTripSheet.SelectedIndex].Value.Trim();
        }
        if (cboRouteMode.Items[cboRouteMode.SelectedIndex].Value != "S")
        {
            AirTrainName = (cboRouteMode.Items[cboRouteMode.SelectedIndex].Value == "A" ? txtAirlineName.Text.Trim() : txtTrainName.Text.Trim());
            FlightTrainName = (cboRouteMode.Items[cboRouteMode.SelectedIndex].Value == "A" ? txtFlightNo.Text.Trim() : txtTrainNo.Text.Trim());
            AirWayBillRRNo = (cboRouteMode.Items[cboRouteMode.SelectedIndex].Value == "A" ? txtAirwayBillNo.Text.Trim() : txtRRNo.Text.Trim());
        }

        //----------------------------------------------------
        xmlTHC = "<root><THC>";
        xmlTHC = xmlTHC + "<ManualTHCNO>" + txtManualTHCNo.Text.Replace("'","").Trim() + "</ManualTHCNO>";
        xmlTHC = xmlTHC + "<THCDT>" + docDateStr.Trim() + "</THCDT>";
        xmlTHC = xmlTHC + "<THCBR>" + hBrCd.Value.Trim() + "</THCBR>";

        xmlTHC = xmlTHC + "<Loader>" + txtLoadSupCode.Text.Trim() + "</Loader>";

        xmlTHC = xmlTHC + "<ActualDeptDate>" + docDateStr.Trim() + "</ActualDeptDate>";
        xmlTHC = xmlTHC + "<ActualDeptTime>" + txtHHMM.Text.Trim() + "</ActualDeptTime>";
        xmlTHC = xmlTHC + "<ScheduleDeptDate>" + nowDtStr + "</ScheduleDeptDate>";
        xmlTHC = xmlTHC + "<ScheduleDeptTime>" + hSchdDeptTime.Value.Trim() + "</ScheduleDeptTime>";

        xmlTHC = xmlTHC + "<SourceHub>" + hBrCd.Value.Trim() + "</SourceHub>";
        xmlTHC = xmlTHC + "<ToHubNext>" + ToHubNext + "</ToHubNext>";
        xmlTHC = xmlTHC + "<ToHubLast>" + ToHubLast + "</ToHubLast>";
        xmlTHC = xmlTHC + "<RouteMode>" + cboRouteMode.Items[cboRouteMode.SelectedIndex].Value.Trim() + "</RouteMode>";
        xmlTHC = xmlTHC + "<RouteCode>" + RouteCode + "</RouteCode>";
        xmlTHC = xmlTHC + "<RouteName>" + RouteName + "</RouteName>";
        xmlTHC = xmlTHC + "<VendorCode>" + VendorCode + "</VendorCode>";
        xmlTHC = xmlTHC + "<VendorName>" + VendorName + "</VendorName>";

        if (cboRouteMode.Items[cboRouteMode.SelectedIndex].Value != "S") //If Not Road 
        {
            xmlTHC = xmlTHC + "<VehicleNo></VehicleNo>" +
                              "<VehicleType></VehicleType>" +
                              "<VehicleTons>0</VehicleTons>" +
                              "<MarketVeh></MarketVeh>" +
                              "<EngineNo></EngineNo>" +
                              "<ChasisNo></ChasisNo>" +
                              "<RCBookNo></RCBookNo>" +
                              "<VehicleRegDt></VehicleRegDt>" +
                              "<InsuranceDt></InsuranceDt>" +
                              "<FitnessCertDt></FitnessCertDt>" +
                              "<Driver1></Driver1>" +
                              "<Licence1></Licence1>" +
                              "<RTO1></RTO1>" +
                              "<ValidityDt1></ValidityDt1>" +
                              "<Driver2></Driver2>" +
                              "<Licence2></Licence2>" +
                              "<RTO2></RTO2>" +
                              "<ValidityDt2></ValidityDt2>"+
                              "<FreeSpace>0</FreeSpace>";

            xmlTHC = xmlTHC + "<AirTrainName>" + AirTrainName + "</AirTrainName>";
            xmlTHC = xmlTHC + "<FlightTrainNo>" + FlightTrainName + "</FlightTrainNo>";
            xmlTHC = xmlTHC + "<AirWayBillRRNo>" + AirWayBillRRNo + "</AirWayBillRRNo>";
        }
        else //If Road
        {
            xmlTHC = xmlTHC + "<VehicleNo>" + txtMktVeh.Text.Trim() + "</VehicleNo>";
            xmlTHC = xmlTHC + "<VehicleType>" + cboVehicleTypes.Items[cboVehicleTypes.SelectedIndex].Value.Trim() + "</VehicleType>";
            xmlTHC = xmlTHC + "<VehicleTons>0</VehicleTons>";
            xmlTHC = xmlTHC + "<MarketVeh>" + IsMarketVeh_YN + "</MarketVeh>";

            xmlTHC = xmlTHC + "<EngineNo>" + txtEngineNo.Text.Trim() + "</EngineNo>";
            xmlTHC = xmlTHC + "<ChasisNo>" + txtChasisNo.Text.Trim() + "</ChasisNo>";
            xmlTHC = xmlTHC + "<RCBookNo>" + txtRCBookNo.Text.Trim() + "</RCBookNo>";

            xmlTHC = xmlTHC + "<VehicleRegDt>" + vehRegDateStr + "</VehicleRegDt>";
            xmlTHC = xmlTHC + "<InsuranceDt>" + insuraceDateStr + "</InsuranceDt>";
            xmlTHC = xmlTHC + "<FitnessCertDt>" + fitnessCertDateStr + "</FitnessCertDt>";

            xmlTHC = xmlTHC + "<Driver1>" + txtDriver1.Text.Trim() + "</Driver1>";
            xmlTHC = xmlTHC + "<Licence1>" + txtLicence1.Text.Trim() + "</Licence1>";
            xmlTHC = xmlTHC + "<RTO1>" + txtIssuedBy1.Text.Trim() + "</RTO1>";
            xmlTHC = xmlTHC + "<ValidityDt1>" + licenceValDate1Str + "</ValidityDt1>";

            xmlTHC = xmlTHC + "<Driver2>" + txtDriver2.Text.Trim() + "</Driver2>";
            xmlTHC = xmlTHC + "<Licence2>" + txtLicence2.Text.Trim() + "</Licence2>";
            xmlTHC = xmlTHC + "<RTO2>" + txtIssuedBy1.Text.Trim() + "</RTO2>";
            xmlTHC = xmlTHC + "<ValidityDt2>" + licenceValDate2Str + "</ValidityDt2>";
            xmlTHC = xmlTHC + "<FreeSpace>" + ((txtOVFS.Text.ToString() != "") ? txtOVFS.Text.ToString() : "0") + "</FreeSpace>";

            xmlTHC = xmlTHC + "<AirTrainName></AirTrainName>";
            xmlTHC = xmlTHC + "<FlightTrainNo></FlightTrainNo>";
            xmlTHC = xmlTHC + "<AirWayBillRRNo></AirWayBillRRNo>";
        }

        xmlTHC = xmlTHC + "<Seal>" + txtSealNo.Text.Trim() + "</Seal>";
        xmlTHC = xmlTHC + "<OutRemark>" + txtOutRemarks.Text.Trim() + "</OutRemark>";

        xmlTHC = xmlTHC + "<LateDeptReason>" + LateDeptReason + "</LateDeptReason>";
        xmlTHC = xmlTHC + "<TSNO>" + TripSheetNo + "</TSNO>";

        xmlTHC = xmlTHC + "<THC_OPERATION>N</THC_OPERATION>";
        xmlTHC = xmlTHC + "<THC_Finance>N</THC_Finance>";
        xmlTHC = xmlTHC + "<THC_Close>N</THC_Close>";
        xmlTHC = xmlTHC + "<THCNEW_MODE>F</THCNEW_MODE>";

        xmlTHC = xmlTHC + "<THCNEW_ENTRYDT>" + nowDtStr + "</THCNEW_ENTRYDT>";
        xmlTHC = xmlTHC + "<THCNEW_ENTRYBY>" + Session["empcd"].ToString().Trim() + "</THCNEW_ENTRYBY>";

        if (cboVendorType.Items[cboVendorType.SelectedIndex].Value == "05" || cboVendorType.Items[cboVendorType.SelectedIndex].Value == "ZZ")
        {
            xmlTHC = xmlTHC + "<LOADOPERTYPE></LOADOPERTYPE>";
            xmlTHC = xmlTHC + "<ADVAMT>0</ADVAMT>";
            xmlTHC = xmlTHC + "<ADVPAIDBY></ADVPAIDBY>";
            xmlTHC = xmlTHC + "<ADVPAIDDATE></ADVPAIDDATE>";
            xmlTHC = xmlTHC + "<CONTRACTAMT>" + txtContractAmountOWN.Text + "</CONTRACTAMT>";
            xmlTHC = xmlTHC + "<TEL_CHRG>0</TEL_CHRG>";
            xmlTHC = xmlTHC + "<MAMUL_CHRG>0</MAMUL_CHRG>";
            xmlTHC = xmlTHC + "<LOAD_CHRG>0</LOAD_CHRG>";

            //xmlTHC = xmlTHC + "<TDS_ACCCODE>" + nowDtStr + "</TDS_ACCCODE>";
            //xmlTHC = xmlTHC + "<TDS_ACCDESC>" + nowDtStr + "</TDS_ACCDESC>";
            //xmlTHC = xmlTHC + "<TDS_GRPCODE>" + nowDtStr + "</TDS_GRPCODE>";
            //xmlTHC = xmlTHC + "<TDS_GRPDESC>" + nowDtStr + "</TDS_GRPDESC>";
            xmlTHC = xmlTHC + "<TDS_FOR>-</TDS_FOR>";


            xmlTHC = xmlTHC + "<SERVICE_RATE>0</SERVICE_RATE>";
            xmlTHC = xmlTHC + "<SERVICE_AMT>0</SERVICE_AMT>";
            xmlTHC = xmlTHC + "<CESS_AMT>0</CESS_AMT>";
            xmlTHC = xmlTHC + "<HEDU_CESS_AMT>0</HEDU_CESS_AMT>";

            xmlTHC = xmlTHC + "<NET_BALANCE_AMT>0</NET_BALANCE_AMT>";
            xmlTHC = xmlTHC + "<ADV_AMT_LAST_PAID>0</ADV_AMT_LAST_PAID>";

            xmlTHC = xmlTHC + "<THCNEW_MODE></THCNEW_MODE>";
            xmlTHC = xmlTHC + "<ADV_PAID></ADV_PAID>";
            xmlTHC = xmlTHC + "<ROUTE_CAT>" + cboRouteMode.Items[cboRouteMode.SelectedIndex].Value.Trim() + "</ROUTE_CAT>";
            xmlTHC = xmlTHC + "<TDS_RATE>0</TDS_RATE>";
            xmlTHC = xmlTHC + "<TDS_CHG>0</TDS_CHG>";
            xmlTHC = xmlTHC + "<PANNO>-</PANNO>";
            xmlTHC = xmlTHC + "<BALAMTBRCD>" + balamtbr.Text + "</BALAMTBRCD>";
        }
        else
        {
            xmlTHC = xmlTHC + "<LOADOPERTYPE>" + loadOpertype.Text + "</LOADOPERTYPE>";
            xmlTHC = xmlTHC + "<ADVAMT>" + advanceamt.Text + "</ADVAMT>";
            xmlTHC = xmlTHC + "<ADVPAIDBY>" + advpaidby.Text + "</ADVPAIDBY>";
            xmlTHC = xmlTHC + "<ADVPAIDDATE>" + nowDtStr + "</ADVPAIDDATE>";
            xmlTHC = xmlTHC + "<CONTRACTAMT>" + contractamt.Text + "</CONTRACTAMT>";
            xmlTHC = xmlTHC + "<TEL_CHRG>" + tel_chrg.Text + "</TEL_CHRG>";
            xmlTHC = xmlTHC + "<MAMUL_CHRG>" + mamul_chrg.Text + "</MAMUL_CHRG>";
            xmlTHC = xmlTHC + "<LOAD_CHRG>" + load_chrg.Text + "</LOAD_CHRG>";

            //xmlTHC = xmlTHC + "<TDS_ACCCODE>" + nowDtStr + "</TDS_ACCCODE>";
            //xmlTHC = xmlTHC + "<TDS_ACCDESC>" + nowDtStr + "</TDS_ACCDESC>";
            //xmlTHC = xmlTHC + "<TDS_GRPCODE>" + nowDtStr + "</TDS_GRPCODE>";
            //xmlTHC = xmlTHC + "<TDS_GRPDESC>" + nowDtStr + "</TDS_GRPDESC>";
            xmlTHC = xmlTHC + "<TDS_FOR>-</TDS_FOR>";


            xmlTHC = xmlTHC + "<SERVICE_RATE>" + svtax_rate.Text + "</SERVICE_RATE>";
            xmlTHC = xmlTHC + "<SERVICE_AMT>" + svrcamt.Text + "</SERVICE_AMT>";
            xmlTHC = xmlTHC + "<CESS_AMT>" + cessamt.Text + "</CESS_AMT>";
            xmlTHC = xmlTHC + "<HEDU_CESS_AMT>" + hcessamt.Text + "</HEDU_CESS_AMT>";

            if (balamt.Text.Trim() != "")
            {
                xmlTHC = xmlTHC + "<NET_BALANCE_AMT>" + balamt.Text + "</NET_BALANCE_AMT>";
            }
            else
            {
                xmlTHC = xmlTHC + "<NET_BALANCE_AMT>0</NET_BALANCE_AMT>";
            }


            
            xmlTHC = xmlTHC + "<ADV_AMT_LAST_PAID>" + advanceamt.Text + "</ADV_AMT_LAST_PAID>";

            xmlTHC = xmlTHC + "<THCNEW_MODE>F</THCNEW_MODE>";
            xmlTHC = xmlTHC + "<ADV_PAID>F</ADV_PAID>";
            xmlTHC = xmlTHC + "<ROUTE_CAT>" + cboRouteMode.Items[cboRouteMode.SelectedIndex].Value.Trim() + "</ROUTE_CAT>";
            xmlTHC = xmlTHC + "<TDS_RATE>" + tds_rate.Text.Trim() + "</TDS_RATE>";
            xmlTHC = xmlTHC + "<TDS_CHG>" + tds_chrg.Text.Trim() + "</TDS_CHG>";
            xmlTHC = xmlTHC + "<PANNO>" + pan_no.Text.Trim() + "</PANNO>";
            xmlTHC = xmlTHC + "<BALAMTBRCD>" + balamtbr.Text + "</BALAMTBRCD>";

            
        }
        xmlTHC = xmlTHC + "<STKM>" + txtStartKM.Text + "</STKM>";
        xmlTHC = xmlTHC + "</THC></root>";
        //---------------------------------------------------------------


        //---------------------------------------------------------------
        xmlTC_Summary = "<root><tc_summary>";
        xmlTC_Summary = xmlTC_Summary + "<TCCount></TCCount>" +
                              "<TOT_DKT></TOT_DKT>" +
                              "<TOT_LOAD_PKGS></TOT_LOAD_PKGS>" +
                              "<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>" +
                              "<TOT_LOAD_CFTWT></TOT_LOAD_CFTWT>";
        xmlTC_Summary = xmlTC_Summary + "</tc_summary></root>";
        //---------------------------------------------------------------

        //---------------------------------------------------------------
        xmlTC = "<root>";
        for (int index = 0; index < dgMFs.Rows.Count; index++)
        {
            CheckBox chkMFs = (CheckBox)dgMFs.Rows[index].FindControl("chkMF");

            if (chkMFs.Checked == true)
            {
                xmlTC = xmlTC + "<TC>" +
                                      "<TCNO>" + dgMFs.DataKeys[index].Values[0].ToString().Trim() + "</TCNO>" +
                                      "<TOTAL_DOCKETS>" + dgMFs.DataKeys[index].Values[1].ToString().Trim() + "</TOTAL_DOCKETS>" +
                                      "<LOADPKGSNO>" + dgMFs.DataKeys[index].Values[2].ToString().Trim() + "</LOADPKGSNO>" +
                                      "<LOADACTUWT>" + dgMFs.DataKeys[index].Values[3].ToString().Trim() + "</LOADACTUWT>" +
                                      "<LOADCFTWT>" + dgMFs.DataKeys[index].Values[3].ToString().Trim() + "</LOADCFTWT>" +
                                      "<SourceHub>" + hBrCd.Value.Trim() + "</SourceHub>" +
                                      "<ToHubNext>" + ToHubNext + "</ToHubNext>" +
                                      "<THCDT>" + docDateStr.Trim() + "</THCDT>" +
                                      "<RouteCode>" + RouteCode + "</RouteCode>" +
                                      "<RouteName>" + RouteName + "</RouteName>" +
                                      "<VehicleNo>" + txtMktVeh.Text.Trim() + "</VehicleNo>" +
                                        "<ActualDeptDate>" + docDateStr.Trim() + "</ActualDeptDate>" +
                                      "<ActualDeptTime>" + txtHHMM.Text.Trim() + "</ActualDeptTime>" +
                "</TC>";
                TCCount += 1;
                TotalDkts += Convert.ToInt32(dgMFs.DataKeys[index].Values[1]);
                TotalPkgs += Convert.ToInt32(dgMFs.DataKeys[index].Values[2]);
                TotalWt += Convert.ToInt32(dgMFs.DataKeys[index].Values[3]);
                //xmlTHC = xmlTHC + "<ActualDeptDate>" + docDateStr.Trim() + "</ActualDeptDate>";
                //xmlTHC = xmlTHC + "<ActualDeptTime>" + txtHHMM.Text.Trim() + "</ActualDeptTime>";
            }
        }

        if (TCCount > 0)
        {
            xmlTC_Summary = xmlTC_Summary.Replace("<TCCount></TCCount>", "<TCCount>" + TCCount.ToString().Trim() + "</TCCount>");
            xmlTC_Summary = xmlTC_Summary.Replace("<TOT_DKT></TOT_DKT>", "<TOT_DKT>" + TotalDkts.ToString().Trim() + "</TOT_DKT>");
            xmlTC_Summary = xmlTC_Summary.Replace("<TOT_LOAD_PKGS></TOT_LOAD_PKGS>", "<TOT_LOAD_PKGS>" + TotalPkgs.ToString().Trim() + "</TOT_LOAD_PKGS>");
            xmlTC_Summary = xmlTC_Summary.Replace("<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>", "<TOT_LOAD_ACTWT>" + TotalWt.ToString().Trim() + "</TOT_LOAD_ACTWT>");
            xmlTC_Summary = xmlTC_Summary.Replace("<TOT_LOAD_CFTWT></TOT_LOAD_CFTWT>", "<TOT_LOAD_CFTWT>" + TotalWt.ToString().Trim() + "</TOT_LOAD_CFTWT>");
            xmlTC = xmlTC + "</root>";
        }
        else
        {
            xmlTC_Summary = "<root><tc_summary><TCCount>0</TCCount><TOT_DKT>0</TOT_DKT><TOT_LOAD_PKGS>0</TOT_LOAD_PKGS><TOT_LOAD_ACTUWT>0</TOT_LOAD_ACTUWT><TOT_LOAD_CFTWT>0</TOT_LOAD_CFTWT></tc_summary></root>";
            xmlTC = "<root><TC><TCNO>-</TCNO><TOTAL_DOCKETS>0</TOTAL_DOCKETS><LOADPKGSNO>0</LOADPKGSNO><LOADACTUWT>0</LOADACTUWT><LOADCFTWT>0</LOADCFTWT></TC></root>";
        }
        //---------------------------------------------------------------

        return TCCount;
    }


    //protected void ShowMFListForNewTHC(object sender, EventArgs e)
    //{
    //    //txtTHCDate.Enabled = false;
    //    //tblMFList.Visible = false;
    //    //trPaymentDetails.Visible = false;
    //    ////DropDownList dl = (DropDownList)sender;
    //    ////if (dl.Items[dl.SelectedIndex].Value != "")
    //    //if (cboRouteName.Items[cboRouteName.SelectedIndex].Value != "")
    //    //{
    //    trPaymentDetails.Visible = true;
    //    tblMFList.Visible = true;
    //    //}
    //}

    protected void ListVehicles()
    {
        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
        SqlDataAdapter da;
        DataSet ds;
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();
        da.Fill(ds);

        cboVehicles.DataSource = ds;
        cboVehicles.DataValueField = ds.Tables[0].Columns[0].ColumnName;
        cboVehicles.DataTextField = ds.Tables[0].Columns[1].ColumnName;
        cboVehicles.DataBind();

        con.Close();
    }

    protected void OnVendorChange(object sender, EventArgs e)
    {
        ListVehicles();
        GetPANNumber();
    }

    protected void OnVendorTypeChange(object sender, EventArgs e)
    {
        trTS.Visible = false;
        cboVehicles.Visible = true;
        txtMktVeh.Visible = false;
        EnableDisableVehInfo(true);
        EnableDisableDriverInfo(true);

        ListVehicles();
        DropDownList dl = (DropDownList)sender;
        txtMarketVendor.Text = dl.Items[dl.SelectedIndex].Value;
        txtMarketVendor.Visible = false;
        //Commented 30 March 2008
        //trPaymentDetails.Visible = true;
        if (dl.Items[dl.SelectedIndex].Value == "XX")
        {
            txtMarketVendor.Text = "";
            txtMarketVendor.Visible = true;
            txtMktVeh.Visible = true;
            cboVehicles.Visible = false;
        }
        if (dl.Items[dl.SelectedIndex].Value == "05" || dl.Items[dl.SelectedIndex].Value == "ZZ")
        {
            trTS.Visible = true;
            trPaymentDetails.Visible = false;
        }

    }

    protected void BlockCriteriaDivision(bool boo)
    {
        txtManualTHCNo.Enabled = !boo;
        txtTHCDate.Enabled = !boo;
        cboRouteMode.Enabled = !boo;
        cboRouteName.Enabled = !boo;
        cboVendorType.Enabled = !boo;
        cboVendors.Enabled = !boo;
        txtCities.Enabled = !boo;
    }

    protected void BlockMFSelection(bool boo)
    {
        //SelectAllCheckBox.Enabled = !boo;    
        for (int index = 0; index < dgMFs.Rows.Count; index++)
        {
            CheckBox chkMFs = (CheckBox)dgMFs.Rows[index].FindControl("chkMF");
            chkMFs.Enabled = !boo;
        }
    }

    //protected void BlockFlightDivision(bool boo)
    //{
    //    txtAirlineName.Enabled = boo;
    //    txtFlightNo.Enabled = boo;
    //    txtAirwayBillNo.Enabled = boo;
    //}

    //protected void BlockTrainDivision(bool boo)
    //{
    //    txtTrainName.Enabled = boo;
    //    txtTrainNo.Enabled = boo;
    //    txtRRNo.Enabled = boo;
    //}

    //protected void BlockVehicleDivision(bool boo)
    //{
    //    cboVehicles.Enabled = boo;
    //    txtMktVeh.Enabled = boo;
    //    cboVehicleTypes.Enabled = boo;
    //    cboTripSheet.Enabled = boo;
    //    txtEngineNo.Enabled = boo;
    //    txtChasisNo.Enabled = boo;
    //    txtRCBookNo.Enabled = boo;
    //    txtVRDate.Enabled = boo;
    //    txtIPDate.Enabled = boo;
    //    txtFCDate.Enabled = boo;
    //}

    protected void OnRouteModeChange(object sender, EventArgs e)
    {
        tblMFList.Visible = false;
        trPaymentDetails.Visible = false;
        DropDownList dl = (DropDownList)sender;
        if (dl.Items[dl.SelectedIndex].Value == "S")
        {
            trForRouteModeS.Visible = true;
            trForRouteModeR.Visible = false;
            trForRouteModeA.Visible = false;
        }

        if (dl.Items[dl.SelectedIndex].Value == "R")
        {
            trForRouteModeS.Visible = false;
            trForRouteModeR.Visible = true;
            trForRouteModeA.Visible = false;
        }

        if (dl.Items[dl.SelectedIndex].Value == "A")
        {
            trForRouteModeS.Visible = false;
            trForRouteModeR.Visible = false;
            trForRouteModeA.Visible = true;
        }
        tblTHCwoMF.Visible = true;
    }

}
