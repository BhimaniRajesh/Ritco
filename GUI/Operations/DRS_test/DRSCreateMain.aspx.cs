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

public partial class GUI_Operations_DRS_DRSCreateMain : System.Web.UI.Page
{
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static DateTime dt1, dt2;
    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();
    DataSet ds = new DataSet();

    public static string xmlDRS = "";
    public static string xmlDocketSummary = "";
    public static string xmlDockets = "";


    DateTime docDate;
    DateTime vehRegDate;
    DateTime insuraceDate;
    DateTime fitnessCertDate;

    public static string mBrCd = "";
    public static string DocDateRange = "";
    public string YearVal = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        dtToday = DateTime.Now.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();
        mBrCd = Session["brcd"].ToString().Trim();

        MySQLDataSource_VendorTypes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vendors.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicles.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicle_Types.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_TranMode.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (!IsPostBack)
        {
            hBrCd.Value = Session["brcd"].ToString().Trim();
        }
        hSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
        DocDateRangeProc();
    }

    protected void OnVendorTypeChange(object sender, EventArgs e)
    {
        ////tblDocketList.Visible = false;

        //DropDownList dl = (DropDownList)sender;
        //txtMarketVendor.Text = dl.Items[dl.SelectedIndex].Text;
        //txtMarketVendor.Visible = false;
        //txtVehicle.Visible = false;
        //if (dl.Items[dl.SelectedIndex].Value == "XX")
        //{
        //    txtMarketVendor.Text = "";
        //    txtMarketVendor.Visible = true;
        //}

        cboVehicles.Visible = true;
        txtVehicle.Visible = false;

        //ListVehicles();
        DropDownList dl = (DropDownList)sender;
        txtMarketVendor.Text = dl.Items[dl.SelectedIndex].Value;
        txtMarketVendor.Visible = false;
        if (dl.Items[dl.SelectedIndex].Value == "XX")
        {
            txtMarketVendor.Text = "";
            txtMarketVendor.Visible = true;
            txtVehicle.Visible = true;
            cboVehicles.Visible = false;
        }
    }

    protected void OnVendorChange(object sender, EventArgs e)
    {
        txtVehicle.Visible = false;
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

    protected void OnVehicleChange(object sender, EventArgs e)
    {
        //DropDownList dl = (DropDownList)sender;
        //txtVehicle.Text = dl.Items[dl.SelectedIndex].Value;
        //txtVehicle.Visible = false;
        //if (dl.Items[dl.SelectedIndex].Value == "O")
        //{
        //    txtVehicle.Text = "";
        //    txtVehicle.Visible = true;
        //}

        SqlConnection con;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        txtVehicle.Visible = false;

        if (cboVehicles.Items[cboVehicles.SelectedIndex].Value == "O")
        {
            txtVehicle.Text = "";
            txtVehicle.Visible = true;
        }
        else
        {
            txtVehicle.Text = cboVehicles.Items[cboVehicles.SelectedIndex].Value;
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


    protected void DocDateRangeProc()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();


        //DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
        if (Session["FinYear_Change"] != null)
        {
            YearVal = Session["FinYear_Change"].ToString().Trim();
        }

        string sql = "usp_DateRange";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@finval", SqlDbType.VarChar).Value = YearVal;


        SqlDataReader dr = sqlCmd.ExecuteReader();

        while (dr.Read())
        {
            DocDateRange = dr[0].ToString().Trim();
        }

        sqlCon.Close();
    }


    protected void ShowDocketsForDRS(object sender, EventArgs e)
    {
        btnShowDockets.Enabled = false;
        tblNote.Visible = true;
        tblDRSHeader.Visible = true;
        BindGrid();
    }

    protected void BindGrid()
    {

        SetDataSet();
        dgDRS.DataSource = ds;
        dgDRS.DataBind();
    }

    protected void SetDataSet()
    {
        int RecFound = 0;

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        FromToDateProc();


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        string sql = "usp_DocketList_For_DRS_Generation";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);

        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@docklist", SqlDbType.VarChar).Value = txtDocketList.Text;
        sqlCmd.Parameters.Add("@from_bkg_arrv_date", SqlDbType.DateTime).Value = dtFrom;
        sqlCmd.Parameters.Add("@to_bkg_arrv_date", SqlDbType.DateTime).Value = dtTo;
        sqlCmd.Parameters.Add("@dt_flag", SqlDbType.Char).Value = cboDocketDate.Items[cboDocketDate.SelectedIndex].Value;
        sqlCmd.Parameters.Add("@drs_date", SqlDbType.DateTime).Value = DateTime.Now; //Convert.ToDateTime(txtDate.Text, dtfi);
        sqlCmd.Parameters.Add("@trn_mode ", SqlDbType.VarChar).Value = cboTranMode.Items[cboTranMode.SelectedIndex].Value; 

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;

        tblDocketList.Visible = true;
        //tblSubmitBtn.Visible = true;
        if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
        {
            //tblSubmitBtn.Visible = false;
        }

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------
    }

    protected void FromToDateProc()
    {
        //int RecFound = 0;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        //From - To Date Range
        if (hDateRange.Value == "0")
        {
            try
            {
                dtFrom = Convert.ToDateTime(txtFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtTo.Text, dtfi);
            }
            catch (Exception ex)
            {
                //radToday.Checked = true;
                dtFrom = Convert.ToDateTime(dtToday, dtfi);
                dtTo = Convert.ToDateTime(dtToday, dtfi);

            }
        }
        //--------------------------------

        //Today Date
        if (hDateRange.Value == "1")
        {
            dtFrom = Convert.ToDateTime(dtToday, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Last Week Date
        if (hDateRange.Value == "2")
        {
            string dt2Str;

            dt2 = DateTime.Now.AddDays(-6);
            dt2Str = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();

            dtFrom = Convert.ToDateTime(dt2Str, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Till Date
        if (hDateRange.Value == "3")
        {
            dtFrom = Convert.ToDateTime("01/01/2000");
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------
    }

    //protected void GenerateDRS(object sender, EventArgs e) { }
    protected void GenerateDRS(object sender, EventArgs e)
    {
        btnCreateDRS.Enabled = false;
        int retGenXML = GenerateXML();

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_DRS_Generate2";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = hBrCd.Value; //Session["brcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@EmpCode", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@DRSDT", SqlDbType.DateTime).Value = docDate;
        sqlCmd.Parameters.Add("@XMLDRS", SqlDbType.Text).Value = xmlDRS.Trim();
        sqlCmd.Parameters.Add("@XMLDockets", SqlDbType.Text).Value = xmlDockets.Trim();
        sqlCmd.Parameters.Add("@xmlDocketSummary", SqlDbType.Text).Value = xmlDocketSummary.Trim();
        sqlCmd.Parameters.Add("@FinYear", SqlDbType.Text).Value = Session["FinYear"].ToString().Trim();


        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        string DRSCodeGenerated = "";
        string Tranzaction = "";

        DRSCodeGenerated = ds.Tables[0].Rows[0]["DRSNo"].ToString();
        Tranzaction = ds.Tables[0].Rows[0]["TranXaction"].ToString().Trim();

        Response.Redirect("GenerateDRSResult.aspx?DRSCode=" + DRSCodeGenerated + "&ManDRSNo=" + txtManCode.Text.Trim() + "&Tranzaction=" + Tranzaction);
    }

    protected int GenerateXML()
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        DateTime nowDt;

        nowDt = DateTime.Now;
        string nowDtStr = nowDt.ToString("dd MMMM yyyy");

        docDate = Convert.ToDateTime(txtDate.Text, dtfi);
        string docDateStr = docDate.ToString("dd MMMM yyyy");

        string vehRegDateStr = "01 January 1900";
        string insuraceDateStr = "01 January 1900";
        string fitnessCertDateStr = "01 January 1900";
        //string licenceValDate1Str = "01 January 1900";
        //string licenceValDate2Str = "01 January 1900";
        try
        {
            vehRegDate = Convert.ToDateTime(txtVRDate.Text, dtfi);
            vehRegDateStr = vehRegDate.ToString("dd MMMM yyyy");

            insuraceDate = Convert.ToDateTime(txtIPDate.Text, dtfi);
            insuraceDateStr = insuraceDate.ToString("dd MMMM yyyy");

            fitnessCertDate = Convert.ToDateTime(txtFCDate.Text, dtfi);
            fitnessCertDateStr = fitnessCertDate.ToString("dd MMMM yyyy");
        }
        catch (Exception ex)
        {
        }

        int TotalDkts  = 0;
        int TotalPkgs  = 0;
        int TotalPkgsArrv  = 0;
        int TotalPkgsPend  = 0;
        int TotalActWt  = 0;
        int TotalActWtArrv  = 0;
        int TotalChargeWt  = 0;
        int TotalFreight  = 0;
        int TotalST  = 0;
        int TotalDKTTOT = 0;

        string[] tmpString = cboVendors.Items[cboVendors.SelectedIndex].Text.Split(':');
        string VendorCode = tmpString[0].Trim().Replace("-", "");
        string VendorName = tmpString[1].Trim();

        string IsMarketVeh_YN = (txtVehicle.Visible == true ? "Y" : "N");
        VendorName = (txtVehicle.Visible == true && txtMarketVendor.Visible==true ? txtMarketVendor.Text.Trim() : VendorName);

        xmlDRS = "<root><DRS>";
        xmlDRS = xmlDRS + "<ManualDRSNO>" + txtManCode.Text.Replace("'", "").Trim() + "</ManualDRSNO>";
        xmlDRS = xmlDRS + "<DRSDT>" + docDateStr.Trim() + "</DRSDT>";
        xmlDRS = xmlDRS + "<DRSTime>" + txtHHMM.Text.Trim() + "</DRSTime>";
        xmlDRS = xmlDRS + "<DRSBR>" + hBrCd.Value.Trim() + "</DRSBR>";
        xmlDRS = xmlDRS + "<VendorType>" + cboVendorType.Items[cboVendorType.SelectedIndex].Text.Trim() + "</VendorType>";
        xmlDRS = xmlDRS + "<VendorCode>" + VendorCode + "</VendorCode>";
        xmlDRS = xmlDRS + "<VendorName>" + VendorName + "</VendorName>";

        xmlDRS = xmlDRS + "<VehicleNo>" + txtVehicle.Text.Trim() + "</VehicleNo>";
        xmlDRS = xmlDRS + "<VehicleType>" + cboVehicleTypes.Items[cboVehicleTypes.SelectedIndex].Value.Trim() + "</VehicleType>";
        xmlDRS = xmlDRS + "<MarketVeh>" + IsMarketVeh_YN + "</MarketVeh>";

        xmlDRS = xmlDRS + "<EngineNo>" + txtEngineNo.Text.Trim() + "</EngineNo>";
        xmlDRS = xmlDRS + "<ChasisNo>" + txtChasisNo.Text.Trim() + "</ChasisNo>";
        xmlDRS = xmlDRS + "<RCBookNo>" + txtRCBookNo.Text.Trim() + "</RCBookNo>";

        xmlDRS = xmlDRS + "<VehicleRegDt>" + vehRegDateStr + "</VehicleRegDt>";
        xmlDRS = xmlDRS + "<InsuranceDt>" + insuraceDateStr + "</InsuranceDt>";
        xmlDRS = xmlDRS + "<FitnessCertDt>" + fitnessCertDateStr + "</FitnessCertDt>";

        xmlDRS = xmlDRS + "<Driver>" + txtDriver.Text.Trim() + "</Driver>";
        xmlDRS = xmlDRS + "<STARTKM>" + txtStartKM.Text.Trim() + "</STARTKM>";

        xmlDRS = xmlDRS + "<DRS_ENTRYDT>" + nowDtStr + "</DRS_ENTRYDT>";
        xmlDRS = xmlDRS + "<DRS_ENTRYBY>" + Session["empcd"].ToString().Trim() + "</DRS_ENTRYBY>";

        xmlDRS = xmlDRS + "<TOT_DKT></TOT_DKT>" +
                              "<TOT_LOAD_PKGS></TOT_LOAD_PKGS>" +
                              "<TOT_ARRV_PKGS></TOT_ARRV_PKGS>" +
                              "<TOT_PEND_PKGS></TOT_PEND_PKGS>" +
                              "<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>" +
                              "<TOT_ARRV_ACTWT></TOT_ARRV_ACTWT>" +
                              "<TOT_CHARGE_WT></TOT_CHARGE_WT>" +
                              "<TOT_FREIGHT></TOT_FREIGHT>" +
                              "<TOT_SVCTAX></TOT_SVCTAX>" +
                              "<TOT_DKTTOT></TOT_DKTTOT>";
        xmlDRS = xmlDRS + "</DRS></root>";
        //---------------------------------------------------------------


        //---------------------------------------------------------------
        xmlDocketSummary = "<root><dkt_summary>";
        xmlDocketSummary = xmlDocketSummary + "<TOT_DKT></TOT_DKT>" +
                              "<TOT_LOAD_PKGS></TOT_LOAD_PKGS>" +
                              "<TOT_ARRV_PKGS></TOT_ARRV_PKGS>" +
                              "<TOT_PEND_PKGS></TOT_PEND_PKGS>" +
                              "<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>" +
                              "<TOT_ARRV_ACTWT></TOT_ARRV_ACTWT>" +
                              "<TOT_CHARGE_WT></TOT_CHARGE_WT>" +
                              "<TOT_FREIGHT></TOT_FREIGHT>" +
                              "<TOT_SVCTAX></TOT_SVCTAX>" +
                              "<TOT_DKTTOT></TOT_DKTTOT>";
        xmlDocketSummary = xmlDocketSummary + "</dkt_summary></root>";
        //---------------------------------------------------------------

        //---------------------------------------------------------------
        xmlDockets = "<root>";
        for (int index = 0; index < dgDRS.Rows.Count; index++)
        {
            CheckBox chkDocket = (CheckBox)dgDRS.Rows[index].FindControl("chkDocket");

            if (chkDocket.Checked == true)
            {
                //DOCKNO,DOCKSF,PKGSNO,ArrPkgQty,PendPkgQty,ACTUWT,ArrWeightQty,CHRGWT,Freight,SVCTAX,DKTTOT,PayBas,TRN_MOD,DockDT
                xmlDockets = xmlDockets + "<DOCKETS>" +
                                      "<DOCKETNO>" + dgDRS.DataKeys[index].Values[0].ToString().Trim() + "</DOCKETNO>" +
                                      "<DOCKETSF>" + dgDRS.DataKeys[index].Values[1].ToString().Trim() + "</DOCKETSF>" +
                                      "<PKGSNO>" + dgDRS.DataKeys[index].Values[2].ToString().Trim() + "</PKGSNO>" +
                                      "<ARRVPKGSNO>" + dgDRS.DataKeys[index].Values[3].ToString().Trim() + "</ARRVPKGSNO>" +
                                      "<PENDPKGSNO>" + dgDRS.DataKeys[index].Values[4].ToString().Trim() + "</PENDPKGSNO>" +
                                      "<ACTUALWT>" + dgDRS.DataKeys[index].Values[5].ToString().Trim() + "</ACTUALWT>" +
                                      "<ARRVACTUALWT>" + dgDRS.DataKeys[index].Values[6].ToString().Trim() + "</ARRVACTUALWT>" +
                                      "<CHRGWT>" + dgDRS.DataKeys[index].Values[7].ToString().Trim() + "</CHRGWT>" +
                                      "<FREIGHT>" + dgDRS.DataKeys[index].Values[8].ToString().Trim() + "</FREIGHT>" +
                                      "<SVCTAX>" + dgDRS.DataKeys[index].Values[9].ToString().Trim() + "</SVCTAX>" +
                                      "<DKTTOT>" + dgDRS.DataKeys[index].Values[10].ToString().Trim() + "</DKTTOT>" +
                                      "<PAYBAS>" + dgDRS.DataKeys[index].Values[11].ToString().Trim() + "</PAYBAS>" +
                                      "<TRN_MOD>" + dgDRS.DataKeys[index].Values[12].ToString().Trim() + "</TRN_MOD>" +
                                      "<DOCKETDT>" + dgDRS.DataKeys[index].Values[13].ToString().Trim() + "</DOCKETDT>" +
                                      "<ORGNCD>" + dgDRS.DataKeys[index].Values[14].ToString().Trim() + "</ORGNCD>" +
                                      "<DESTCD>" + dgDRS.DataKeys[index].Values[15].ToString().Trim() + "</DESTCD>" +
                "</DOCKETS>";
                TotalDkts += 1;
                TotalPkgs += Convert.ToInt32(dgDRS.DataKeys[index].Values[2]);
                TotalPkgsArrv += Convert.ToInt32(dgDRS.DataKeys[index].Values[3]);
                TotalPkgsPend += Convert.ToInt32(dgDRS.DataKeys[index].Values[4]);
                TotalActWt += Convert.ToInt32(dgDRS.DataKeys[index].Values[5]);
                TotalActWtArrv += Convert.ToInt32(dgDRS.DataKeys[index].Values[6]);
                TotalChargeWt += Convert.ToInt32(dgDRS.DataKeys[index].Values[7]);
                TotalFreight += Convert.ToInt32(dgDRS.DataKeys[index].Values[8]);
                TotalST += Convert.ToInt32(dgDRS.DataKeys[index].Values[9]);
                TotalDKTTOT += Convert.ToInt32(dgDRS.DataKeys[index].Values[10]);
            }
        }

        if (TotalDkts > 0)
        {
            xmlDRS = xmlDRS.Replace("<TOT_DKT></TOT_DKT>", "<TOT_DKT>" + TotalDkts.ToString().Trim() + "</TOT_DKT>");
            xmlDRS = xmlDRS.Replace("<TOT_LOAD_PKGS></TOT_LOAD_PKGS>", "<TOT_LOAD_PKGS>" + TotalPkgs.ToString().Trim() + "</TOT_LOAD_PKGS>");
            xmlDRS = xmlDRS.Replace("<TOT_ARRV_PKGS></TOT_ARRV_PKGS>", "<TOT_ARRV_PKGS>" + TotalPkgsArrv.ToString().Trim() + "</TOT_ARRV_PKGS>");
            xmlDRS = xmlDRS.Replace("<TOT_PEND_PKGS></TOT_PEND_PKGS>", "<TOT_PEND_PKGS>" + TotalPkgsPend.ToString().Trim() + "</TOT_PEND_PKGS>");
            xmlDRS = xmlDRS.Replace("<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>", "<TOT_LOAD_ACTWT>" + TotalActWt.ToString().Trim() + "</TOT_LOAD_ACTWT>");
            xmlDRS = xmlDRS.Replace("<TOT_ARRV_ACTWT></TOT_ARRV_ACTWT>", "<TOT_ARRV_ACTWT>" + TotalActWtArrv.ToString().Trim() + "</TOT_ARRV_ACTWT>");
            xmlDRS = xmlDRS.Replace("<TOT_CHARGE_WT></TOT_CHARGE_WT>", "<TOT_CHARGE_WT>" + TotalChargeWt.ToString().Trim() + "</TOT_CHARGE_WT>");
            xmlDRS = xmlDRS.Replace("<TOT_FREIGHT></TOT_FREIGHT>", "<TOT_FREIGHT>" + TotalFreight.ToString().Trim() + "</TOT_FREIGHT>");
            xmlDRS = xmlDRS.Replace("<TOT_SVCTAX></TOT_SVCTAX>", "<TOT_SVCTAX>" + TotalST.ToString().Trim() + "</TOT_SVCTAX>");
            xmlDRS = xmlDRS.Replace("<TOT_DKTTOT></TOT_DKTTOT>", "<TOT_DKTTOT>" + TotalDKTTOT.ToString().Trim() + "</TOT_DKTTOT>");
            
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_DKT></TOT_DKT>", "<TOT_DKT>" + TotalDkts.ToString().Trim() + "</TOT_DKT>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_LOAD_PKGS></TOT_LOAD_PKGS>", "<TOT_LOAD_PKGS>" + TotalPkgs.ToString().Trim() + "</TOT_LOAD_PKGS>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_ARRV_PKGS></TOT_ARRV_PKGS>", "<TOT_ARRV_PKGS>" + TotalPkgsArrv.ToString().Trim() + "</TOT_ARRV_PKGS>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_PEND_PKGS></TOT_PEND_PKGS>", "<TOT_PEND_PKGS>" + TotalPkgsPend.ToString().Trim() + "</TOT_PEND_PKGS>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>", "<TOT_LOAD_ACTWT>" + TotalActWt.ToString().Trim() + "</TOT_LOAD_ACTWT>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_ARRV_ACTWT></TOT_ARRV_ACTWT>", "<TOT_ARRV_ACTWT>" + TotalActWtArrv.ToString().Trim() + "</TOT_ARRV_ACTWT>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_CHARGE_WT></TOT_CHARGE_WT>", "<TOT_CHARGE_WT>" + TotalChargeWt.ToString().Trim() + "</TOT_CHARGE_WT>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_FREIGHT></TOT_FREIGHT>", "<TOT_FREIGHT>" + TotalFreight.ToString().Trim() + "</TOT_FREIGHT>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_SVCTAX></TOT_SVCTAX>", "<TOT_SVCTAX>" + TotalST.ToString().Trim() + "</TOT_SVCTAX>");
            xmlDocketSummary = xmlDocketSummary.Replace("<TOT_DKTTOT></TOT_DKTTOT>", "<TOT_DKTTOT>" + TotalDKTTOT.ToString().Trim() + "</TOT_DKTTOT>");
            
            xmlDockets = xmlDockets + "</root>";
        }
        else
        {
            //xmlDocketSummary = "<root><dkt_summary><TOT_DKT>0</TOT_DKT><TOT_LOAD_PKGS>0</TOT_LOAD_PKGS><TOT_LOAD_ACTUWT>0</TOT_LOAD_ACTUWT><TOT_LOAD_CFTWT>0</TOT_LOAD_CFTWT></dkt_summary></root>";
            //xmlDockets = "<root><DOCKETS><TOTAL_DOCKETS>0</TOTAL_DOCKETS><LOADPKGSNO>0</LOADPKGSNO><LOADACTUWT>0</LOADACTUWT><LOADCFTWT>0</LOADCFTWT><DRSDT>01 January 1900</DRSDT></DOCKETS></root>";
        }
        //---------------------------------------------------------------

        return TotalDkts;
    }

}
