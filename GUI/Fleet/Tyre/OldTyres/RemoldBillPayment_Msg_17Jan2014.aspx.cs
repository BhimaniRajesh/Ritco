using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Tyre_OldTyres_RemoldBillPayment_Msg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblVoucherno.Text = Request.QueryString["VOUCHER_NO"].Trim();
    }
    protected void lnkClaim_Click(object sender, EventArgs e)
    {
        Response.Redirect("OldTyreStock_Query.aspx");
    }
    protected void lnkUpdateClaim_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClaimQuery.aspx");
    }
    protected void lnkUpdateRemold_Click(object sender, EventArgs e)
    {
        Response.Redirect("RemoldQuery.aspx");
    }
}