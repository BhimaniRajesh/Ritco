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

public partial class GUI_admin_Accounts_masters_Acctgroup_View_acctGroups_step_2 : System.Web.UI.Page
{
    SqlConnection conn;
    string Acccode = "", Main_category = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Acccode = Request.QueryString["AccCode"].ToString();
        Main_category = Request.QueryString["Main_category"].ToString();
        conn.Open();
        if (!IsPostBack)
        {
            DipsplayReport(Acccode, Main_category);
        }
        conn.Close();
    }
    
    public void DipsplayReport(string Acccode, string Main_category)
    {
        string sql = "";
        if (Acccode != "")
            sql = "select Acccode,Company_Acccode,Accdesc,Groupcode from webx_acctinfo where Activeflag='Y' and Acccode='" + Acccode + "'";
        else if(Main_category != "")
            sql = "select Acccode,Company_Acccode,Accdesc,Groupcode from webx_acctinfo where Activeflag='Y' and Groupcode in(select Groupcode from webx_groups where main_category='" + Main_category + "')";
        else
            sql = "select Acccode,Company_Acccode,Accdesc,Groupcode from webx_acctinfo where 1=2";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        grvcontrols.DataSource = ds;
        grvcontrols.DataBind();

        conn.Close();
    }
}
