using System;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_VendorPaymentBillApprovalDone : System.Web.UI.Page
{
    public string BillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BillNo = Request.QueryString["DocumentNo"].ToString();
            lblBillNo.Text = BillNo;
        }
    }
}