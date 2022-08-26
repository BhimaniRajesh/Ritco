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

public partial class GUI_Finance_Billing_Supplementar_Bill_CheckDockThcExist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "";
        if (mode.CompareTo("Docket") == 0)
            qry = "select DOCKNO from webx_trans_docket_status WITH(NOLOCK) where cancelled <> 'Y' and dockno='" + code + "'";
        else if (mode.CompareTo("Thc") == 0)
            qry = "select thcno from webx_thc_summary WITH(NOLOCK) where cancelled <> 'Y' and thcno='" + code + "'";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            if (dr[0].ToString().CompareTo(code) == 0)
            {
                i = 1;
                break;
            }
        }
        dr.Close();

        if (i == 0)
            Response.Write("false|" + mode + "|");
        else if (i == 1)
            Response.Write("true|" + mode + "|");

        con.Close();
    }
}
