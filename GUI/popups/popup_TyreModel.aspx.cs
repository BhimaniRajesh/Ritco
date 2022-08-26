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
            hModelNo.Value = Request.QueryString["ModNo"].ToString();
            //hID.Value = Request.QueryString["vehid"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "usp_TyreModel_list";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@TYRE_MODEL_ID", SqlDbType.VarChar).Value = "";
        if (txtModelNO.Text != "")
        {
            da.SelectCommand.Parameters.Add("@TYRE_MODELNO", SqlDbType.VarChar).Value = txtModelNO.Text;
        }
        else
        {
            da.SelectCommand.Parameters.Add("@TYRE_MODELNO", SqlDbType.VarChar).Value = "";
        }

        
        da.SelectCommand.Parameters.Add("@TYRE_MFG", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_PAT_CATEGORY", SqlDbType.VarChar).Value = "All";
        da.SelectCommand.Parameters.Add("@TYRE_SIZE", SqlDbType.VarChar).Value = "";

        DataSet ds = new DataSet();
        da.Fill(ds);

        GridView1.DataSource = ds;
        GridView1.DataBind();

        conn.Close();
    }
}
