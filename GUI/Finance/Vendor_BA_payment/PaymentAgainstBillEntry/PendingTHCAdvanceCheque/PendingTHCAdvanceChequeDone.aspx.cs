using System;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_PendingTHCAdvanceChequeDone : System.Web.UI.Page
{
    public string VoucherNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        VoucherNo = Request.QueryString["VoucherNo"].ToString();
        lblVoucherNo.Text = VoucherNo;
    }
}