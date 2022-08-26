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

public partial class GUI_admin_SetDelyProc : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataSet ds2 = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        //MySQLDataSource_ShowDelyProc.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_BizType.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_ServiceType.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_DelyProc.ConnectionString = Session["SqlProvider"].ToString().Trim();

        //BindGrid();    
    }

    protected void SetDelyProc(object sender, EventArgs e){

        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_SetDelyProc";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        sqlCmd.Parameters.AddWithValue("@bizType", cboBizType.SelectedValue);
        sqlCmd.Parameters.AddWithValue("@servType", cboServiceType.SelectedValue);
        sqlCmd.Parameters.AddWithValue("@delyProc", cboDlyProc.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        //DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Close Connection
        sqlCon.Close();
        sqlCon = null;

        Response.Redirect("~/GUI/Admin/Rules/ShowDelyProcRules.aspx");
        //BindGrid();
        //--------------------------------
    }

    //protected void BindGrid()
    //{
    //    //Make & Open Connection
    //    SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    sqlCon.Open();
    //    //--------------------------------

    //    string sql = "usp_ShowDelyProc";
    //    SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
    //    sqlCmd.CommandType = CommandType.StoredProcedure;

    //    SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
    //    da.Fill(ds2);
    //    da.Dispose();

    //    dgDelyProc.DataSource = ds2;
    //    dgDelyProc.DataBind();
    //    //Close Connection
    //    sqlCon.Close();
    //    sqlCon = null;
    //}
}
