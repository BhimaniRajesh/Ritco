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

public partial class GUI_Tracking_ver1_Docket_FinLifeCycle : System.Web.UI.Page
{
    public static string call_dkt;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        call_dkt = Session["DocketCalledAs"].ToString();
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        string SQL_Time = "select * from  VwNe_FinLifeCycle where dockno='" + str_dockno + "' order by  D,docdt";

        SqlCommand sqlcmd12 = new SqlCommand(SQL_Time, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;

        conn.Close();
    }
}
