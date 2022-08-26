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
public partial class GUI_HR_Payroll_Master_Leave_master_Leave_Master_Step3 : System.Web.UI.Page
{
    SqlConnection conn;
    public static string LeaveCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        LeaveCode = Request.QueryString["LeaveCode"].ToString();
        BindData();
    }

    private void BindData()
    {
        conn.Open();
        string SQL_Sql = "exec Webx_LeaveMaster_List '" + LeaveCode + "'";
        SqlCommand sqlcmd12 = new SqlCommand(SQL_Sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;
        conn.Close();
    }
}
