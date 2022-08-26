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
        string flag_edit = "ENTRY";
        try
        {
            flag_edit = Request.QueryString["editflag"].ToString();
        }
        catch (Exception ex) 
        { 
        }


        mrsno.Text = Request.QueryString["Mrno"].ToString();
        hdngatepassno.Value = Request.QueryString["mrno"].ToString();
        hdnbillno.Value = Request.QueryString["billno"].ToString();
        lblbillno.Text = Request.QueryString["billno"].ToString();
        HdnLocation.Value = Request.QueryString["Location"].ToString();

        if (hdnbillno.Value.CompareTo("NA") == 0)
            trbill.Style["display"] = "none";

        hdn_psp_url.Value = ViewPrintController.GetNavigationURL("PSP_GP");
        hdn_psp_url.Value = hdn_psp_url.Value.Replace("GatePassPrint_RITCO.aspx", "GatePassPrintVer1_RITCO.aspx");

    }
}
