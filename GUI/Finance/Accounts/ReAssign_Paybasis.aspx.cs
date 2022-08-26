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

public partial class octroi_octCustBillStep1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["brcd"] = "PRHO";
        //Session["empcd"] = "p1438";
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
       // Response.Redirect("OctCustBillStep2.aspx?Party_detail=" + Party_code.Text.ToString() + ",&custis=" + Billto.SelectedValue.ToString());
    }
    protected void Billto_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
