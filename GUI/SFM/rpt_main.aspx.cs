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

public partial class GUI_SFM_rpt_main : System.Web.UI.Page
{
    public string callvisit;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string client = Session["Client"].ToString();
        if (client == "Varuna" || client == "VARUNA")
        {
            callvisit = "Visit";
        }
        else
        {
            callvisit = "Call";
        }
    }
}
