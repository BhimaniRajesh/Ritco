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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_Manifest_MFCreateMain : System.Web.UI.Page
{
    public string dtToday { get { return (ViewState["dtToday"] != null) ? ViewState["dtToday"].ToString() : ""; } set { ViewState["dtToday"] = value; } }
    public string dtLastWeek { get { return (ViewState["dtLastWeek"] != null) ? ViewState["dtLastWeek"].ToString() : ""; } set { ViewState["dtLastWeek"] = value; } }
    public string mBrCd { get { return (ViewState["mBrCd"] != null) ? ViewState["mBrCd"].ToString() : ""; } set { ViewState["mBrCd"] = value; } }
    public string DocDateRange { get { return (ViewState["DocDateRange"] != null) ? ViewState["DocDateRange"].ToString() : ""; } set { ViewState["DocDateRange"] = value; } }
    public string strRegion { get { return (ViewState["strRegion"] != null) ? ViewState["strRegion"].ToString() : ""; } set { ViewState["strRegion"] = value; } }
    public string strDocumentDKT { get { return (ViewState["strDocumentDKT"] != null) ? ViewState["strDocumentDKT"].ToString() : ""; } set { ViewState["strDocumentDKT"] = value; } }
    public string strDocumentMF { get { return (ViewState["strDocumentMF"] != null) ? ViewState["strDocumentMF"].ToString() : ""; } set { ViewState["strDocumentMF"] = value; } }
    public DateTime dt1 { get { return (ViewState["dt1"] != null) ? Convert.ToDateTime(ViewState["dt1"]) : DateTime.MinValue; } set { ViewState["dt1"] = value; } }
    public DateTime dt2 { get { return (ViewState["dt2"] != null) ? Convert.ToDateTime(ViewState["dt2"]) : DateTime.MinValue; } set { ViewState["dt2"] = value; } }

    public string xmlTCHDR { get { return (ViewState["xmlTCHDR"] != null) ? ViewState["xmlTCHDR"].ToString() : ""; } set { ViewState["xmlTCHDR"] = value; } }
    public string xmlTCTRN { get { return (ViewState["xmlTCTRN"] != null) ? ViewState["xmlTCTRN"].ToString() : ""; } set { ViewState["xmlTCTRN"] = value; } }
    public string xmlWTDS { get { return (ViewState["xmlWTDS"] != null) ? ViewState["xmlWTDS"].ToString() : ""; } set { ViewState["xmlWTDS"] = value; } }

    DateTime dtFrom = new DateTime();
    DateTime dtTo = new DateTime();

    DataSet ds = new DataSet();

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
        lblError.Text = "";
        dtToday = DateTime.Now.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();

        dt1 = DateTime.Now;
        dt2 = dt1.AddDays(-6);

        dtLastWeek = dt2.ToString("dd/MM/yyyy");// dt2.Day.ToString() + '/' + dt2.Month.ToString() + '/' + dt2.Year.ToString();
        dtLastWeek = dtLastWeek + " - " + dt1.ToString("dd/MM/yyyy");//.Day.ToString() + '/' + dt1.Month.ToString() + '/' + dt1.Year.ToString();

        btnPrepareManifest.Text = "Prepare " + strDocumentMF;
        DT.EnableTillDate = true;
        if (!IsPostBack && !IsCallback)
        {
            ClientDocumentNomenclature();
            txtPreparedBy.Text = Session["empcd"].ToString().Trim();
            txtDocumentDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        }

        btnSubmit.Text = "Show " + strDocumentDKT + " List";
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
        sqlCmd.Parameters.Add("@doc_code", SqlDbType.VarChar).Value = "MF";
        sqlCmd.Parameters.Add("@doc_default_name", SqlDbType.VarChar).Value = "Manifest ";
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet dsDocName = new DataSet();
        da.Fill(dsDocName);
        da.Dispose();

        strDocumentMF = dsDocName.Tables[0].Rows[0]["DocumentName"].ToString();

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


    protected void SetDataSet()
    {
        int RecFound = 0;

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Tilldate";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");



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
        bool isValid = true;
        tblNoDocketsSelected.Visible = false;
        if (GenerateXML() > 0)
        {
            if (Session["FinYear"] != null)
            {
                YearVal = Session["FinYear"].ToString().Trim();
            }

            #region Commented_code
            ////Make & Open Connection
            //SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //sqlCon.Open();
            ////--------------------------------

            //string sql = "usp_Manifest_Generate";
            //SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
            //sqlCmd.CommandType = CommandType.StoredProcedure;
            //sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
            //sqlCmd.Parameters.Add("@mfdt", SqlDbType.DateTime).Value = docDate;
            //sqlCmd.Parameters.Add("@xmlTCHDR", SqlDbType.VarChar).Value = xmlTCHDR.Trim();
            //sqlCmd.Parameters.Add("@xmlTCTRN", SqlDbType.VarChar).Value = xmlTCTRN.Trim();
            //sqlCmd.Parameters.Add("@xmlWTDS", SqlDbType.VarChar).Value = xmlWTDS.Trim();
            //sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0,4);

            //SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

            ////DataSet ds = new DataSet();
            //da.Fill(ds);
            //da.Dispose();

            //string MFCodeGenerated = "";
            //MFCodeGenerated = ds.Tables[0].Rows[0]["MF"].ToString();

            //Response.Redirect("DisplayMFResult.aspx?MFNo=" + MFCodeGenerated + "&ManMFNo=" + txtManualNo.Text.Trim());
            #endregion

            //Make & Open Connection
            using (var sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim()))
            {
                sqlCon.Open();
                var trans = sqlCon.BeginTransaction();
                try
                {
                    var sql = "usp_Manifest_Generate";
                    var sqlCmd = new SqlCommand(sql, sqlCon, trans) { CommandType = CommandType.StoredProcedure };

                    sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
                    sqlCmd.Parameters.Add("@mfdt", SqlDbType.DateTime).Value = docDate;
                    sqlCmd.Parameters.Add("@xmlTCHDR", SqlDbType.VarChar).Value = xmlTCHDR.Trim();
                    sqlCmd.Parameters.Add("@xmlTCTRN", SqlDbType.VarChar).Value = xmlTCTRN.Trim();
                    sqlCmd.Parameters.Add("@xmlWTDS", SqlDbType.VarChar).Value = xmlWTDS.Trim();
                    sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 4);

                    using (var da = new SqlDataAdapter(sqlCmd))
                    {
                        da.Fill(ds);
                    }
                    trans.Commit();
                }
                catch (Exception ex)
                {
                    isValid = false;
                    trans.Rollback();
                    lblError.Text = ex.Message;
                }
                finally
                {
                    sqlCon.Close();
                }
            }
            if (ds.Tables.Count > 0 && isValid)
            {
                var mfCodeGenerated = ds.Tables[0].Rows[0]["MF"].ToString();
                if (!string.IsNullOrEmpty(mfCodeGenerated))
                    Response.Redirect("DisplayMFResult.aspx?MFNo=" + mfCodeGenerated + "&ManMFNo=" +
                                      txtManualNo.Text.Trim());
                else
                    lblError.Text = "Blank MF Generated";
            }

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
                              "<TFLAG_YN>N</TFLAG_YN>";
        if (txtManualNo.Text.Trim() == "")
            xmlTCHDR = xmlTCHDR + "<MANUAL_TCNO>NA</MANUAL_TCNO>";
        else
            xmlTCHDR = xmlTCHDR + "<MANUAL_TCNO>" + txtManualNo.Text.Trim() + "</MANUAL_TCNO>";

        xmlTCHDR = xmlTCHDR + "<PREPAREDBY></PREPAREDBY>" +
                              "<FROMCITY></FROMCITY>" +
                              "<TOCITY></TOCITY>" +
                              "<ENTRYBY>" + Session["empcd"].ToString().Trim() + "</ENTRYBY>" +
                              "<ROUTE_CODE>-</ROUTE_CODE>";
        xmlTCHDR = xmlTCHDR + "<WTADJ_PM></WTADJ_PM>";
        xmlTCHDR = xmlTCHDR + "<WTADJ></WTADJ>";
        xmlTCHDR = xmlTCHDR + "</tchdr></root>";

        xmlTCTRN = "<root>";
        xmlWTDS = "<root>";

        for (int index = 0; index < dgDockets.Rows.Count; index++)
        {
            CheckBox chkDocket = (CheckBox)dgDockets.Rows[index].FindControl("chkDocket");
            TextBox txtPkgs = (TextBox)dgDockets.Rows[index].FindControl("txtPkgs");
            TextBox txtWt = (TextBox)dgDockets.Rows[index].FindControl("txtWt");

            if (chkDocket.Checked == true)
            {
                xmlWTDS = xmlWTDS + "<wtds>" +
                                        "<DOCKNO>" + dgDockets.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                        "<DOCKSF>" + dgDockets.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                        "<LOADPKGSNO>" + txtPkgs.Text.Trim() + "</LOADPKGSNO>" +
                                        "<LOADACTUWT>" + txtWt.Text.Trim() + "</LOADACTUWT>" +
                                        "<TCDT>" + docDateStr.Trim() + "</TCDT>" +
                                        "<NEXTLOC>" + txtNextStop.Text.Trim().ToUpper() + "</NEXTLOC>" +
                                    "</wtds>";

                xmlTCTRN = xmlTCTRN + "<tctrn>" +
                                          "<TCNO></TCNO>" +
                                          "<TCSF>.</TCSF>" +
                                          "<DOCKNO>" + dgDockets.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                          "<DOCKSF>" + dgDockets.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                          "<LOADPKGSNO>" + txtPkgs.Text.Trim() + "</LOADPKGSNO>" +
                                          "<LOADACTUWT>" + txtWt.Text.Trim() + "</LOADACTUWT>" +
                                          "<LOADCFTWT>" + txtWt.Text.Trim() + "</LOADCFTWT>" +
                                      "</tctrn>";

                DktCount += 1;
                TotalPkgs += Convert.ToInt32(dgDockets.DataKeys[index].Values[2]);
                TotalWt += Convert.ToInt32(dgDockets.DataKeys[index].Values[3]);

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

            xmlTCHDR = xmlTCHDR.Replace("<WTADJ_PM></WTADJ_PM>", "<WTADJ_PM>" + DDLWTADJ.SelectedValue + "</WTADJ_PM>");
            xmlTCHDR = xmlTCHDR.Replace("<WTADJ></WTADJ>", "<WTADJ>" + txtWtAdj.Text.Trim() + "</WTADJ>");

            xmlTCTRN = xmlTCTRN + "</root>";
            xmlWTDS = xmlWTDS + "</root>";
        }

        return DktCount;
    }



    protected void ShowDocketsForMF(object sender, EventArgs e)
    {
        if (IsNextStopValid())
        {
            tblDocketList.Visible = true;
            txtDocumentDate.Enabled = false;
            txtDocumentDate.ForeColor = System.Drawing.Color.Blue;
            txtNextStop.Enabled = false;
            txtNextStop.ForeColor = System.Drawing.Color.Blue;

            TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
            TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

            RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
            txtDateFrom.Enabled = false;
            txtDateFrom.ForeColor = System.Drawing.Color.Blue;
            txtDateTo.Enabled = false;
            txtDateTo.ForeColor = System.Drawing.Color.Blue;
            radDate.Enabled = false;
            radDate.ForeColor = System.Drawing.Color.Blue;

            txtPreparedBy.Enabled = false;
            txtPreparedBy.ForeColor = System.Drawing.Color.Blue;
            btnSubmit.Enabled = false;
            btnSubmit.ForeColor = System.Drawing.Color.Blue;

            ListDocketsForMFGeneration();
        }

    }

    protected bool IsNextStopValid()
    {
        if (txtNextStop.Text.Trim() == "")
        {
            lblError1.Text = "Please Enter Valid Next Location";
            lblError1.Visible = true;
           //lblError1a.Text = "Please Enter Valid Next Location";
            //lblError1a.Visible = true;

        }
        return !(lblError1.Visible);
    }
    public class ManifestUtilityError
    {
        public string Key;
        public string Message;
    }
    public static bool GetLocExistorNot(string strLoCode)
    {
        string sql = "SELECT COUNT(*) FROM WEBX_LOCATION WHERE ";
        sql = sql + " LOCCODE='" + strLoCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sql)) == 0)
            return false;
        else
            return true;
    }
    private ManifestUtilityError Validation()
    {
        ManifestUtilityError werr = new ManifestUtilityError();
        werr.Key = "";
        try
        {
            if (!GetLocExistorNot(txtNextStop.Text.Trim()))
            {
                werr.Message = "Entered Location is Not Exist, Please Enter Valid Location...";
                werr.Key = "NotExist";
                return werr;
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
        return werr;
    }
}
