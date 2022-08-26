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

public partial class GUI_popups_vehno : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        if(!IsPostBack)
        {
            hPatCode.Value = Request.QueryString["TyrePatCode"].ToString();
            //hID.Value = Request.QueryString["vehid"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "usp_TyrePat_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@PatId", SqlDbType.VarChar, 10).Value = "";
        if (txtPatCode.Text != "")
        {
            da.SelectCommand.Parameters.Add("@TyrePatId", SqlDbType.VarChar).Value = txtPatCode.Text;
        }
        else
        {
            da.SelectCommand.Parameters.Add("@TyrePatId", SqlDbType.VarChar).Value = "";
        }

        da.SelectCommand.Parameters.Add("@POSITION", SqlDbType.VarChar).Value = "0";

        DataSet ds = new DataSet();
        da.Fill(ds);

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();
    }
}
