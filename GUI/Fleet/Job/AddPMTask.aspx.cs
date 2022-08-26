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
public partial class GUI_Fleet_Job_AddPMTask : System.Web.UI.Page
{
    string W_Grpcd = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        W_Grpcd = Request.QueryString["id"];

        if (!IsPostBack)
        {

            //Do Work

            BindGrid();

        }
    }



    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_ViewTaskList";

        SqlCommand sqlcmd = new SqlCommand(str, conn);


        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        sqlcmd.Parameters.Add("@W_Grpcd", SqlDbType.VarChar).Value = W_Grpcd.ToString().Trim();


        DataSet ds = new DataSet();
        da.Fill(ds);

        DataGrid1.DataSource = ds;
        DataGrid1.DataBind();

        conn.Close();
        if (DataGrid1.Rows.Count != 0)
        {

            btnSubmit.Visible = false;
        }

        else
        {
            btnSubmit.Visible = true;

        }








    }


}
