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

public partial class GUI_Operations_LS_ver2_MFCreateMain_FromLS : System.Web.UI.Page
{
    public string strDocumentLS { get { return (ViewState["strDocumentLS"] != null) ? ViewState["strDocumentLS"].ToString() : ""; } set { ViewState["strDocumentLS"] = value; } }
    public string strDocumentDKT { get { return (ViewState["strDocumentDKT"] != null) ? ViewState["strDocumentDKT"].ToString() : ""; } set { ViewState["strDocumentDKT"] = value; } }
    public string strDocumentMF { get { return (ViewState["strDocumentMF"] != null) ? ViewState["strDocumentMF"].ToString() : ""; } set { ViewState["strDocumentMF"] = value; } }
    public DateTime dt1 { get { return (ViewState["dt1"] != null) ? Convert.ToDateTime(ViewState["dt1"]) : DateTime.MinValue; } set { ViewState["dt1"] = value; } }
    public DateTime dt2 { get { return (ViewState["dt2"] != null) ? Convert.ToDateTime(ViewState["dt2"]) : DateTime.MinValue; } set { ViewState["dt2"] = value; } }

    public string xmlTCHDR { get { return (ViewState["xmlTCHDR"] != null) ? ViewState["xmlTCHDR"].ToString() : ""; } set { ViewState["xmlTCHDR"] = value; } }
    public string xmlTCTRN { get { return (ViewState["xmlTCTRN"] != null) ? ViewState["xmlTCTRN"].ToString() : ""; } set { ViewState["xmlTCTRN"] = value; } }
    public string xmlWTDS { get { return (ViewState["xmlWTDS"] != null) ? ViewState["xmlWTDS"].ToString() : ""; } set { ViewState["xmlWTDS"] = value; } }
    public string xmlNonSelDKT { get { return (ViewState["xmlNonSelDKT"] != null) ? ViewState["xmlNonSelDKT"].ToString() : ""; } set { ViewState["xmlNonSelDKT"] = value; } }

    public string NextLOC { get { return (ViewState["NextLOC"] != null) ? ViewState["NextLOC"].ToString() : ""; } set { ViewState["NextLOC"] = value; } }
    public string LSNO { get { return (ViewState["LSNO"] != null) ? ViewState["LSNO"].ToString() : ""; } set { ViewState["LSNO"] = value; } }

    DateTime docDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        ClientDocumentNomenclature();
        btnPrepareManifest.Text = "Prepare " + strDocumentMF + ">>";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
         LSNO = Request.QueryString["strDckNo"].ToString();
         lblllsno.Text = LSNO;
        NextLOC = Request.QueryString["NextLOC"].ToString();
        if (!IsPostBack)
        {
            int RecFound = 0;
            

            string sql_st = "exec WebxNet_DocketList_LS_For_MF '" + LSNO + "'";
            //Response.Write("<br>sql_st : " + sql_st);
            SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            DataSet ds = new DataSet();
            da.Fill(ds);

            RecFound = ds.Tables[0].Rows.Count;

            tblSubmitBtn.Visible = true;
            if (RecFound == 0)  //If RecCount is 0 then Display No Records Found
            {
                tblSubmitBtn.Visible = false;
            }

            dgLS.DataSource = ds;
            dgLS.DataBind();
            // lblflow.Text = dkt_call;
            dgLS.Visible = true;
        }
        conn.Close();
    }

    protected void dgLS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                //Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = strDocumentDKT + " No.";
                //lblColDockdt.Text = dkt_call + " Date";
            }

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

        sql = "usp_GetDocumentName";
        sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@doc_code", SqlDbType.VarChar).Value = "MF";
        sqlCmd.Parameters.Add("@doc_default_name", SqlDbType.VarChar).Value = "Manifest ";
        da = new SqlDataAdapter(sqlCmd);

        dsDocName = new DataSet();
        da.Fill(dsDocName);
        da.Dispose();
        strDocumentMF = dsDocName.Tables[0].Rows[0]["DocumentName"].ToString();
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
            SqlTransaction trans;

            trans = sqlCon.BeginTransaction();
            try
            {
                //string SQL_NONSELDKT = "exec WebxNet_NonSelDKT_UpdateLS_Status '" + xmlNonSelDKT.Trim() + "' ,'" + LSNO + "'";
                //SqlCommand sqlCmd1 = new SqlCommand(SQL_NONSELDKT, sqlCon);
                //sqlCmd1.Transaction = trans;
                //sqlCmd1.ExecuteNonQuery();

                SqlParameter[] parameters = new SqlParameter[2];
                parameters[0] = new SqlParameter("@strXML", xmlNonSelDKT.Trim());
                parameters[1] = new SqlParameter("@LS", LSNO);
                SqlHelper.ExecuteNonQuery(trans, CommandType.StoredProcedure, "WebxNet_NonSelDKT_UpdateLS_Status", parameters);

                //string MF_SQL = "exec usp_Manifest_Generate '" + Session["brcd"].ToString().Trim() + "','" + docDate.ToString() + "','" + xmlTCHDR.Trim() + "''" + xmlTCTRN.Trim() + "''" + xmlWTDS.Trim() + "','" + YearVal.Substring(0, 4) + "'";
                //string sql = "usp_Manifest_Generate";
                //SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
                //sqlCmd.Transaction = trans;
                //sqlCmd.CommandType = CommandType.StoredProcedure;
                //sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
                //sqlCmd.Parameters.Add("@mfdt", SqlDbType.DateTime).Value = docDate.ToString();
                //sqlCmd.Parameters.Add("@xmlTCHDR", SqlDbType.VarChar).Value = xmlTCHDR.Trim();
                //sqlCmd.Parameters.Add("@xmlTCTRN", SqlDbType.VarChar).Value = xmlTCTRN.Trim();
                //sqlCmd.Parameters.Add("@xmlWTDS", SqlDbType.VarChar).Value = xmlWTDS.Trim();
                //sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 4);

                //SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                //DataSet ds = new DataSet();
                //da.Fill(ds);
                //da.Dispose();


                DataSet ds = new DataSet();
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@brcd", Session["brcd"].ToString().Trim());
                param[1] = new SqlParameter("@mfdt", docDate.ToString("dd MMM yyyy"));
                param[2] = new SqlParameter("@xmlTCHDR", xmlTCHDR.Trim());
                param[3] = new SqlParameter("@xmlTCTRN", xmlTCTRN.Trim());
                param[4] = new SqlParameter("@xmlWTDS", xmlWTDS.Trim());
                param[5] = new SqlParameter("@FinYear", YearVal.Substring(0, 4));
                ds = SqlHelper.ExecuteDataset(trans, CommandType.StoredProcedure, "usp_Manifest_Generate", param);


                string MFCodeGenerated = "";
                MFCodeGenerated = ds.Tables[0].Rows[0]["MF"].ToString();

                trans.Commit();
                Response.Redirect("../Manifest/DisplayMFResult.aspx?MFNo=" + MFCodeGenerated + "&ManMFNo=",false);

            }
            catch (Exception e1)
            {
                trans.Rollback();

                iblError.Visible = true;
                lblerr.Text = e1.Message;

                Response.End();
            }
            finally
            {
                sqlCon.Close();

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

        docDate = System.DateTime.Today;
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
                              "<TOBH_CODE>" + NextLOC.ToString().Trim().ToUpper() + "</TOBH_CODE>" +
                              "<TOT_DKT></TOT_DKT>" +
                              "<TOT_PKGS></TOT_PKGS>" +
                              "<TOT_ACTUWT></TOT_ACTUWT>" +
                              "<TOT_CFTWT></TOT_CFTWT>" +
                              "<TOT_LOAD_PKGS></TOT_LOAD_PKGS>" +
                              "<TOT_LOAD_ACTWT></TOT_LOAD_ACTWT>" +
                              "<TOT_LOAD_CFTWT></TOT_LOAD_CFTWT>" +
                              "<TCHDRFLAG>Y</TCHDRFLAG>" +
                              "<TFLAG_YN>N</TFLAG_YN>" +
                              "<MANUAL_TCNO>NA</MANUAL_TCNO>" +
                              "<PREPAREDBY></PREPAREDBY>" +
                              "<FROMCITY></FROMCITY>" +
                              "<TOCITY></TOCITY>" +
                              "<ENTRYBY>" + Session["empcd"].ToString().Trim() + "</ENTRYBY>" +
                              "<ROUTE_CODE>-</ROUTE_CODE>"+
                              "<WTADJ_PM></WTADJ_PM>"+
                              "<WTADJ></WTADJ>";
        xmlTCHDR = xmlTCHDR + "</tchdr></root>";

        xmlTCTRN = "<root>";
        xmlWTDS = "<root>";
        xmlNonSelDKT = "<root>";
        for (int index = 0; index < dgLS.Rows.Count; index++)
        {
            CheckBox chkDocket = (CheckBox)dgLS.Rows[index].FindControl("chkDocket");
            TextBox txtPkgs = (TextBox)dgLS.Rows[index].FindControl("txtPkgs");
            TextBox txtWt = (TextBox)dgLS.Rows[index].FindControl("txtWt");

            if (chkDocket.Checked == true)
            {
                xmlWTDS = xmlWTDS + "<wtds>" +
                                    "<DOCKNO>" + dgLS.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                    "<DOCKSF>" + dgLS.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                    "<TCDT>" + docDateStr.Trim() + "</TCDT>" +
                                    "</wtds>";

                xmlTCTRN = xmlTCTRN + "<tctrn>" +
                                      "<TCNO></TCNO>" +
                                      "<TCSF>.</TCSF>" +
                                      "<DOCKNO>" + dgLS.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                      "<DOCKSF>" + dgLS.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                      "<LOADPKGSNO>" + txtPkgs.Text.Trim() + "</LOADPKGSNO>" +
                                      "<LOADACTUWT>" + txtWt.Text.Trim() + "</LOADACTUWT>" +
                                      "<LOADCFTWT>" + txtWt.Text.Trim() + "</LOADCFTWT>" +
                                      "</tctrn>";

                DktCount += 1;
                TotalPkgs += Convert.ToInt32(dgLS.DataKeys[index].Values[2]);
                TotalWt += Convert.ToInt32(dgLS.DataKeys[index].Values[3]);

                LoadedPkgs += Convert.ToInt32(txtPkgs.Text.Trim());
                LoadedWt += Convert.ToInt32(txtWt.Text.Trim());
            }
            else
            {
                xmlNonSelDKT = xmlNonSelDKT + "<NonSelDKT>" +
                                    "<DOCKNO>" + dgLS.DataKeys[index].Values[0].ToString().Trim() + "</DOCKNO>" +
                                    "<DOCKSF>" + dgLS.DataKeys[index].Values[1].ToString().Trim() + "</DOCKSF>" +
                                    "</NonSelDKT>";
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
            xmlNonSelDKT = xmlNonSelDKT + "</root>";
        }

        return DktCount;
    }

}
