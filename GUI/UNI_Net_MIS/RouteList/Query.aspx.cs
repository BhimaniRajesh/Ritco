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

public partial class GUI_UNI_MIS_RouteList_Query : System.Web.UI.Page
{
    SqlConnection conn;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (!IsPostBack)
        {



        }
        conn.Close();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {


        string startLoc = txtstartBranch.Text;
        string endLoc = txtEndBranch.Text;
        string enroute = txtEnrouteBranch.Text;
        string rmd = rptmd.SelectedValue.ToString();
        string final;
        final = "?startLoc=" + startLoc;
        final += "&endLoc=" + endLoc;
        final += "&enroute=" + enroute;
       
        final += "&RMD=" + rmd;

        Response.Redirect("RouteList.aspx" + final);

    }
}
