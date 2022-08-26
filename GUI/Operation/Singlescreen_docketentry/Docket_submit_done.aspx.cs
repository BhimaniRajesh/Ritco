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

public partial class GUI_Operation_Singlescreen_docketentry_Docket_submit_done : System.Web.UI.Page
{
    protected static string dockno = "",mrno="";
    protected string dkt_call = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cnno.Text=Request.QueryString["Dockno"].ToString(); 
        dockno = Request.QueryString["Dockno"].ToString(); 
        mrsno.Text = Request.QueryString["Mrsno"].ToString(); 
        mrno = Request.QueryString["Mrsno"].ToString();
        dkt_call = Session["DocketCalledAs"].ToString();
        if(mrno.CompareTo("NA")==0)
            trmr.Visible = false;
    }
}
