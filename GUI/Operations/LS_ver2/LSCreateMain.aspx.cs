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
using System.Text;


public partial class GUI_Operations_LS_ver2_LSCreateMain : System.Web.UI.Page
{
    
    public static string dtToday = "";
    public static string dtLastWeek = "";
    public static string mBrCd = "";
    public static string DocDateRange = "";
    public static string strRegion = "";

    public static string strDocumentLS = "", strDocumentDKT = "";

    public static DateTime dt1, dt2;

    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();

    DataSet ds = new DataSet();

    public static string xmlTCHDR = "";
    public static string xmlTCTRN = "";
    public static string xmlWTDS = "";

    DateTime docDate;
    protected void Page_Load(object sender, EventArgs e)
    {
        MySQLDataSource_TransModes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Cities.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Regions.ConnectionString = Session["SqlProvider"].ToString().Trim();

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        dtToday = DateTime.Now.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.ToString("dd/MM/yyyy");// dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        hdtToday.Value = dtToday;
        hdt2.Value = dt2.ToString("dd/MM/yyyy");
        hdt1.Value = dt1.ToString("dd/MM/yyyy");
        hdt.Value = "01/01/2000";

        txtDocumentDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        txtDocumentDate.Enabled = false;

        ClientDocumentNomenclature();
        btnPrepareManifest.Text = "Prepare " + strDocumentLS;
        lblTblHeader.Text = "Select " + strDocumentDKT+" Criteria";
        lblDate.Text = strDocumentDKT + " Date";
        if (!IsPostBack)
        {
            txtPreparedBy.Text = Session["empcd"].ToString().Trim();
        }
    }

    protected void ClientDocumentNomenclature()
    {
        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_GetDocumentName";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@doc_code", SqlDbType.VarChar).Value = "LS";
        sqlCmd.Parameters.Add("@doc_default_name", SqlDbType.VarChar).Value = "LoadingSheet";
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        
        DataSet dsDocName = new DataSet();
        da.Fill(dsDocName);
        da.Dispose();

        strDocumentLS = dsDocName.Tables[0].Rows[0]["DocumentName"].ToString();

         sql = "usp_GetDocumentName";
         sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@doc_code", SqlDbType.VarChar).Value = "DKT";
        sqlCmd.Parameters.Add("@doc_default_name", SqlDbType.VarChar).Value = "Docket";
         da = new SqlDataAdapter(sqlCmd);
        
         dsDocName = new DataSet();
        da.Fill(dsDocName);
        da.Dispose();
        strDocumentDKT = dsDocName.Tables[0].Rows[0]["DocumentName"].ToString();
    }


    protected void ListDocketsForMFGeneration()
    {
        //tblResult.Visible = false;
        tblNoDocketsSelected.Visible = false;
        tblDocketList.Visible = true;
        getSelectedRegionLocations();
        strRegion = strRegion.Replace("'", "").Replace(" ", "").Trim();
        BindGrid();
    }

    private void getSelectedRegionLocations()
    {
        strRegion = "";

        for (int intLoopCounter = 0; intLoopCounter < lstRegion.Items.Count; intLoopCounter++)
        {
            if (lstRegion.Items[intLoopCounter].Selected == true && lstRegion.Items[intLoopCounter].Value != "-1")
            {
                strRegion = (strRegion == "" ? lstRegion.Items[intLoopCounter].Value : strRegion + "," + lstRegion.Items[intLoopCounter].Value);
            }
        }
    }


    protected void BindGrid()
    {

        SetDataSet();
        dgDockets.DataSource = ds;
        dgDockets.DataBind();
    }

    protected void FromToDateProc()
    {
        //int RecFound = 0;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        //From - To Date Range
        if (radFromToDate.Checked)
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
        if (radToday.Checked)
        {
            dtFrom = Convert.ToDateTime(dtToday, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Last Week Date
        if (radLastWeek.Checked)
        {
            string dt2Str;

            dt2 = DateTime.Now.AddDays(-6);
            dt2Str = dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();

            dtFrom = Convert.ToDateTime(dt2Str, dtfi);
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------


        //Till Date
        if (radTillDate.Checked)
        {
            dtFrom = Convert.ToDateTime("01/01/2000");
            dtTo = Convert.ToDateTime(dtToday, dtfi);
        }
        //--------------------------------
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

        string sql = "usp_DocketList_For_MF_Generation";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@nextstop", SqlDbType.VarChar).Value = txtNextStop.Text.Trim();
        sqlCmd.Parameters.Add("@trnmod", SqlDbType.Char).Value = cboTransMode.Items[cboTransMode.SelectedIndex].Value.Trim();
        sqlCmd.Parameters.Add("@dockdatefrom", SqlDbType.DateTime).Value = dtFrom;
        sqlCmd.Parameters.Add("@dockdateto", SqlDbType.DateTime).Value = dtTo;
        sqlCmd.Parameters.Add("@destlist", SqlDbType.Char).Value = txtDestination.Text.Trim();
        sqlCmd.Parameters.Add("@regionlist", SqlDbType.VarChar).Value = strRegion;
        sqlCmd.Parameters.Add("@city_from", SqlDbType.VarChar).Value = cboCityFrom.Items[cboCityFrom.SelectedIndex].Value.Trim();
        sqlCmd.Parameters.Add("@city_to", SqlDbType.VarChar).Value = cboCityTo.Items[cboCityTo.SelectedIndex].Value.Trim();
        sqlCmd.Parameters.Add("@docketlist", SqlDbType.Char).Value = txtDocketList.Text.Trim();
        sqlCmd.Parameters.Add("@mfdate", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDocumentDate.Text, dtfi);


        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Find RecCount From Dataset
        RecFound = ds.Tables[0].Rows.Count;

        tblSubmitBtn.Visible = true;
        if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
        {
            tblSubmitBtn.Visible = false;
        }

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------
    }

    protected void PrepareManifest(object sender, EventArgs e)
    {
        string YearVal = "";
        tblNoDocketsSelected.Visible = false;
        if (GenerateXML() > 0)
        {
            if (Session["FinYear"] != null)
            {
                YearVal = Session["FinYear"].ToString().Trim();
            }

            //Make & Open Connection
            SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            sqlCon.Open();
            //--------------------------------
            string SQLStr = "exec usp_LoadingSheet_Generate '" + Session["brcd"].ToString().Trim() + "','" + docDate + "','" + xmlTCHDR.Trim() + "','" + xmlTCTRN.Trim() + "','" + xmlWTDS.Trim() + "','" + YearVal.Substring(0, 4) + "'";
            string sql = "usp_LoadingSheet_Generate";
            SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
            sqlCmd.Parameters.Add("@mfdt", SqlDbType.DateTime).Value = docDate;
            sqlCmd.Parameters.Add("@xmlTCHDR", SqlDbType.VarChar).Value = xmlTCHDR.Trim();
            sqlCmd.Parameters.Add("@xmlTCTRN", SqlDbType.VarChar).Value = xmlTCTRN.Trim();
            sqlCmd.Parameters.Add("@xmlWTDS", SqlDbType.VarChar).Value = xmlWTDS.Trim();
            sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0,4);

            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

            //DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();
           
            string LSCodeGenerated = "";
            LSCodeGenerated = ds.Tables[0].Rows[0]["LS"].ToString();

            Response.Redirect("DiplayLSResult.aspx?LSNo=" + LSCodeGenerated + "&ManLSNo=" + txtManualNo.Text.Trim());
        }
        else
        {
            tblNoDocketsSelected.Visible = true;
        }
    }


    protected int GenerateXML()
    {
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        
        docDate = Convert.ToDateTime(txtDocumentDate.Text, dtfi);
        string docDateStr = docDate.ToString("dd MMMM yyyy");

        int DktCount = 0;

        int TotalPkgs = 0;
        int TotalWt = 0;

        int LoadedPkgs = 0;
        int LoadedWt = 0;

        xmlTCHDR = "<root><tchdr>";
        xmlTCHDR = xmlTCHDR + "<TCNO></TCNO>" +
                              "<TCSF>.</TCSF>" +
                              "<TCDT>" + docDateStr.Trim() + "</TCDT>" +
                              "<TCBR>" + Session["brcd"].ToString().Trim() + "</TCBR>" +
                              "<TOBH_CODE>" + txtNextStop.Text.Trim().ToUpper() + "</TOBH_CODE>" +
                              "<TOT_DKT></TOT_DKT>" +
                              "<TOT_PKGS></TOT_PKGS>" +
                              "<TOT_ACTUWT></TOT_ACTUWT>" +
                              "<TOT_CFTWT></TOT_CFTWT>" +
                              "<TOT_LOAD_PKGS></TOT_LOAD_PKGS>" +
                              "<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>" +
                              "<TOT_LOAD_CFTWT></TOT_LOAD_CFTWT>" +
                              "<TCHDRFLAG>Y</TCHDRFLAG>" +
                              "<TFLAG_YN>N</TFLAG_YN>" +
                              "<MANUALLSNO>" +txtManualNo.Text.Trim().ToUpper() + "</MANUALLSNO>" +
                              "<PREPAREDBY>"+ Session["empcd"].ToString().Trim() +"</PREPAREDBY>" +
                              "<FROMCITY></FROMCITY>" +
                              "<TOCITY></TOCITY>" +
                              "<ENTRYBY>" + Session["empcd"].ToString().Trim() + "</ENTRYBY>" +
                              "<ROUTE_CODE>-</ROUTE_CODE>" +
                              "<LOADING_STATUS>-</LOADING_STATUS>" +
                               "<TOT_FRTAMT>00</TOT_FRTAMT>" +
                              "<MODVATCOVER>0</MODVATCOVER>" +
                              "<INTCOVER>0</INTCOVER>" +
                                  "<FINAL_TC>N</FINAL_TC>";
        xmlTCHDR = xmlTCHDR + "</tchdr></root>";
        
        xmlTCTRN = "<root>";
        xmlWTDS = "<root>";

        for (int index = 0; index < dgDockets.Rows.Count; index++)
        {
            CheckBox chkDocket = (CheckBox)dgDockets.Rows[index].FindControl("chkDocket");
            //TextBox txtPkgs = (TextBox)dgDockets.Rows[index].FindControl("txtPkgs");
            //TextBox txtWt = (TextBox)dgDockets.Rows[index].FindControl("txtWt");

            Label txtPkgs = (Label)dgDockets.Rows[index].FindControl("txtPkgs");
            Label txtWt = (Label)dgDockets.Rows[index].FindControl("txtWt");
            Label lblOrigin = (Label)dgDockets.Rows[index].FindControl("lnk3");
            Label lbldest = (Label)dgDockets.Rows[index].FindControl("lnk");
            Label lbldockdt = (Label)dgDockets.Rows[index].FindControl("lnk4");

            if (chkDocket.Checked == true)
            {
                xmlWTDS = xmlWTDS + "<wtds>" +
                                    "<DOCKNO>" + dgDockets.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                    "<DOCKSF>" + dgDockets.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                    "<TCDT>" + docDateStr.Trim() + "</TCDT>" +
                                    "</wtds>";

                xmlTCTRN = xmlTCTRN + "<tctrn>" +
                                      "<TCNO></TCNO>" +
                                      "<TCSF>.</TCSF>" +
                                      "<DOCKNO>" + dgDockets.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                      "<DOCKSF>" + dgDockets.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                      "<LOADPKGSNO>" + txtPkgs.Text.Trim() + "</LOADPKGSNO>" +
                                      "<LOADACTUWT>" + txtWt.Text.Trim() + "</LOADACTUWT>" +
                                      "<LOADCFTWT>" + txtWt.Text.Trim() + "</LOADCFTWT>" +
                                      "<ORGNCD>" + lblOrigin.Text.Trim() + "</ORGNCD>" +
                                      "<DESTCD>" + lbldest.Text.Trim() + "</DESTCD>" +
                                      "<DOCKCLS>X</DOCKCLS>" +
                                      "<DOCKDT>" + lbldockdt.Text.Trim() + "</DOCKDT>" +
                                      "<NOPKGS>" + txtPkgs.Text.Trim() + "</NOPKGS>" +
                                       "<CFTWT>" + txtWt.Text.Trim() + "</CFTWT>" +
                                       "<ACTUWT>" + txtWt.Text.Trim() + "</ACTUWT>" +
                                       "<DKTAMT>0</DKTAMT>" +
                                      "</tctrn>";

                DktCount += 1;
                TotalPkgs += Convert.ToInt32(dgDockets.DataKeys[index].Values[2]);
                TotalWt +=  Convert.ToInt32(dgDockets.DataKeys[index].Values[3]);

                LoadedPkgs += Convert.ToInt32(txtPkgs.Text.Trim());
                LoadedWt += Convert.ToInt32(txtWt.Text.Trim());
            }
        }

        if (DktCount > 0)
        {
            xmlTCHDR = xmlTCHDR.Replace("<TOT_DKT></TOT_DKT>", "<TOT_DKT>" + DktCount.ToString().Trim() + "</TOT_DKT>");

            xmlTCHDR = xmlTCHDR.Replace("<TOT_PKGS></TOT_PKGS>", "<TOT_PKGS>" + TotalPkgs.ToString().Trim() + "</TOT_PKGS>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_ACTUWT></TOT_ACTUWT>", "<TOT_ACTUWT>" + TotalWt.ToString().Trim() + "</TOT_ACTUWT>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_CFTWT></TOT_CFTWT>", "<TOT_CFTWT>" + TotalWt.ToString().Trim() + "</TOT_CFTWT>");

            xmlTCHDR = xmlTCHDR.Replace("<TOT_LOAD_PKGS></TOT_LOAD_PKGS>", "<TOT_LOAD_PKGS>" + LoadedPkgs.ToString().Trim() + "</TOT_LOAD_PKGS>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>", "<TOT_LOAD_ACTWT>" + LoadedWt.ToString().Trim() + "</TOT_LOAD_ACTWT>");
            xmlTCHDR = xmlTCHDR.Replace("<TOT_LOAD_CFTWT></TOT_LOAD_CFTWT>", "<TOT_LOAD_CFTWT>" + LoadedWt.ToString().Trim() + "</TOT_LOAD_CFTWT>");

            xmlTCTRN = xmlTCTRN + "</root>";
            xmlWTDS = xmlWTDS + "</root>";
        }

        return DktCount;
    }


    protected void NextStop_TextChanged(object sender, EventArgs e)
    {
        bool boo;
        boo = IsNextStopValid();
    }

    protected void PreparedBy_TextChanged(object sender, EventArgs e)
    {
        bool boo;
        boo = IsUserCodeValid();
    }

    protected void ShowDocketsForMF(object sender, EventArgs e)
    {
        if (IsNextStopValid() && IsUserCodeValid())
        {
            tblDocketList.Visible = true;
            txtDocumentDate.Enabled = false;
            txtDocumentDate.ForeColor = System.Drawing.Color.Blue;
            txtNextStop.Enabled = false;
            txtNextStop.ForeColor = System.Drawing.Color.Blue;
            ListDocketsForMFGeneration();
        }
    }

    protected bool IsUserCodeValid()
    {
        lblError2.Visible = false;
        //trSubmit.Visible = true;
        btnSubmit.Enabled = true;
        if (txtPreparedBy.Text.Trim() != "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            SqlCommand cmd = new SqlCommand("usp_ValidUserCode", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@usercode", SqlDbType.VarChar).Value = txtPreparedBy.Text.Trim();
            cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
            cmd.Parameters.Add("@mainbrcd", SqlDbType.VarChar).Value = Session["mainbrcd"].ToString().Trim();

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds2 = new DataSet();

            da.Fill(ds2);

            //Raise Error if No Records Found for given Next Stop Code
            lblError2.Visible = (ds2.Tables[0].Rows.Count > 0 ? false : true);
            btnSubmit.Enabled = (ds2.Tables[0].Rows.Count > 0 ? true : false);

            //Focus Control on Error
            if (lblError2.Visible)
            {
                txtPreparedBy.Focus();
            }
        }

        return !(lblError2.Visible);
    }

    protected bool IsNextStopValid()
    {
        lblError1.Visible = false;
        //trSubmit.Visible = true;
        btnSubmit.Enabled = true;
        tblDocketList.Visible = false;
        if (txtNextStop.Text.Trim() != "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            SqlCommand cmd = new SqlCommand("usp_ValidLocationCode", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = txtNextStop.Text.Trim();

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds2 = new DataSet();

            da.Fill(ds2);

            //Raise Error if No Records Found for given Next Stop Code
            lblError1.Visible = (ds2.Tables[0].Rows.Count > 0 ? false : true);
            btnSubmit.Enabled = (ds2.Tables[0].Rows.Count > 0 ? true : false);
            tblDocketList.Visible = (ds2.Tables[0].Rows.Count > 0 ? true : false);
            //Focus Control on Error
            if (lblError1.Visible)
            {
                txtNextStop.Focus();
            }
        }

        return !(lblError1.Visible);
    }
}
