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

public partial class GUI_Operations_LS_ver2_LSList_For_Update : System.Web.UI.Page
{
    public static string strDocumentLS = "", strDocumentDKT = "";
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
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql_st = "exec WebxNet_List_LS_For_MF '" + Session["brcd"].ToString() + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgLS.DataSource = ds;
        dgLS.DataBind();
        // lblflow.Text = dkt_call;
        dgLS.Visible = true;
        conn.Close();
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
}
