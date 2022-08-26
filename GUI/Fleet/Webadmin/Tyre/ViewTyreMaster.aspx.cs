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

public partial class TyreSizeView : System.Web.UI.Page
{

  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
            if (Request.QueryString["print"] != null)
            {
                string script;
                script = @"<SCRIPT language='javascript'> func();" + "</SCRIPT>";
                this.RegisterStartupScript("MyAlert", script);
            }
        }
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "usp_Tyre_List";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@Tyre_Id", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_NO", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@MODEL_NO", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@MFG_NAME", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_CATEGORY", SqlDbType.VarChar).Value = "All";
        da.SelectCommand.Parameters.Add("@SIZE_NAME", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_TYPEID", SqlDbType.VarChar).Value = "All";
        da.SelectCommand.Parameters.Add("@VEHNO", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@PATCODE", SqlDbType.VarChar).Value = "0";
        da.SelectCommand.Parameters.Add("@TYREPOSCAT", SqlDbType.VarChar).Value = "0";
        da.SelectCommand.Parameters.Add("@TYREPOS", SqlDbType.VarChar).Value = "0";
        da.SelectCommand.Parameters.Add("@TYRESTATUS", SqlDbType.VarChar).Value = "0";
        da.SelectCommand.Parameters.Add("@ACTIVEFLAG", SqlDbType.VarChar).Value = "0";

        DataSet ds = new DataSet();
        da.Fill(ds);

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();
    }

}
