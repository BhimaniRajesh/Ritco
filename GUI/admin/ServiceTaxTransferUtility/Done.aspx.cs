using System;

public partial class GUI_admin_ServiceTaxTransferUtility_Done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["TransactionAction"] != null)
            lblResult.Text = Request.QueryString["TransactionAction"].ToString();
    }
}