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
using System.Text;
using System.IO;


public partial class GUI_Fleet_Job_ViewPendingTask : System.Web.UI.Page
{
    string cols = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        // Session["Main"] = null;
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            //  Session["Type_Code"] = null;


            ViewPendingTask();


        }
    }

    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {

        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.CssClass = "blackfnt";
        row.Cells[0].Font.Bold = true;
        row.BackColor = System.Drawing.Color.FromName("#FFFFFF");

        row.Cells[0].Text = "Job Order No:" + row.Cells[0].Text;//.Replace("-",":"); // +"&nbsp;&nbsp;" + "VehicleNo:";

    }


    public void ViewPendingTask()
    {
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_ViewPendingTask";

        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.CommandType = CommandType.StoredProcedure;


        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        
        da.Fill(ds);
        
        GridViewHelper helper = new GridViewHelper(this.GridView1);

        cols = "Job_Order_No";
    //    cols[1] = "Job_";
        
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);


        GridView1.DataSource = ds;

        GridView1.DataBind();

        conn.Close();

     


    }


}
