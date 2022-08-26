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
using WebX.Controllers;

public partial class GUI_Operation_Singlescreen_docketentry_Docket_submit_done : System.Web.UI.Page
{
    protected string dkt_call = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        LblGatepassno.Text = Request.QueryString["GATEPASSNO"].ToString();
        hdngatepassno.Value = Request.QueryString["GATEPASSNO"].ToString();
        hdn_psp_url.Value = ViewPrintController.GetNavigationURL("PSP_GP");
    }
}
