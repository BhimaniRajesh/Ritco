using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_TyreIssueModule_TyreIssueMsg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblDocName.Text = "The Tyre has been Issued to vehicle Successfully.";
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Response.Redirect("TyreIssueMaster.aspx");
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("TyreRemovalMaster.aspx");
    }
}