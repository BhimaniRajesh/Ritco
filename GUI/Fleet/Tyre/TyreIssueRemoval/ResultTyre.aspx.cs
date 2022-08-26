using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Tyre_TyreIssueRemoval_ResultTyre : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblMsg.Text = "Tyre Interchanged successfully between Vehicle No." + Request.QueryString["VEHNO_1"].ToString() + " and " + Request.QueryString["VEHNO_2"].ToString();
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("TyreInterchange.aspx");
    }
}