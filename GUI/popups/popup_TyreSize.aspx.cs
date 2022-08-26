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
            hSizeNm.Value = Request.QueryString["SizeNm"].ToString();
            //hID.Value = Request.QueryString["vehid"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "usp_TyreSizeData_List";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        if (txtSizeName.Text != "")
        {
            da.SelectCommand.Parameters.Add("@SizeName", SqlDbType.VarChar).Value = txtSizeName.Text;
        }
        else
        {
            da.SelectCommand.Parameters.Add("@SizeName", SqlDbType.VarChar).Value = "";
        }
        
        da.SelectCommand.Parameters.Add("@TyreTypeCat", SqlDbType.VarChar).Value = "0";

        DataSet ds = new DataSet();
        da.Fill(ds);

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();
    }
}
