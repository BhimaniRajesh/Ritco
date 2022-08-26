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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using WebX.Controllers;

public partial class GUI_Operation_Singlescreen_docketentry_Docket_submit_done : System.Web.UI.Page
{

    protected string dkt_call = "", dockno = "", mrno = "", billno = "";
    public static string ToolTip_Str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string flag_edit = "ENTRY";
        dkt_call = Session["DocketCalledAs"].ToString();
        lbldockno.Text = Request.QueryString["dockno"].ToString();
        hdndockno.Value = Request.QueryString["dockno"].ToString();
    }    
   
}
