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
using System.Web.SessionState;
using System.Data.SqlClient;

public partial class octroi_octCustBillStep1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["brcd"] = "PRHO";
        //Session["empcd"] = "p1438";
        getstring();
    }
    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "Select custcd from webx_CUSTHDR";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["custcd"] + "'"));
        }
        dr_Location.Close();
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
        Response.Redirect("OctCustBillStep2.aspx?Party_detail=" + Party_code.Text.ToString() + "&custis=" + Billto.SelectedValue.ToString());
        //Response.Redirect("Query.aspx?Party_detail=" + Party_code.Text.ToString() + ",&custis=" + Billto.SelectedValue.ToString());
    }
    protected void Billto_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
