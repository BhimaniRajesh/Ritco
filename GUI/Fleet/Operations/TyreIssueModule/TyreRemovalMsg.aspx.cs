using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_TyreIssueModule_TyreRemovalMsg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["Flag"] == "I")
            {
                lblDocName.Text = "The Tyre has been  attached to Vehicle Successfully.";
            }
            if (Request.QueryString["Flag"] == "R")
            {
                lblDocName.Text = "The Tyre has been removed from vehicle Successfully.";
            }
            if (Request.QueryString["Flag"] == "U")
            {
                lblDocName.Text = "The Tyre has been updated Successfully.";
            }
        }
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