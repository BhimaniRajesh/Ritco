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

public partial class GUI_Operation_DocketEntry_DocketPrint_AutoPrint_Step1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        optnumber.Text = "GatePass No[Separated by Comma(,)]";
        optrange.Text = "GatePass Range";
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string dockstring = "";
        
        string url = "";
        if (optnumber.Checked == true)
            url = "tp=0&gatepassnos=" + txtdockno.Text;
        else
            url = "tp=1&start=" + txtstart.Text + "&end=" + txtend.Text;

        if (Session["client"].ToString().ToUpper().CompareTo("RITCO") == 0)
            Response.Redirect("GatePassPrint_RITCO.aspx?" + url);
        else 
            Response.Redirect("GatePassPrint_CHAWLA.aspx?" + url);


    }
}
