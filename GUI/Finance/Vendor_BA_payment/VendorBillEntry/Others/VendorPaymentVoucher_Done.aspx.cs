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
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_VendorPaymentVoucher_Done : System.Web.UI.Page
{
    public string VoucherNo;

    protected void Page_Load(object sender, EventArgs e)
    {
        VoucherNo = Request.QueryString["VoucherNo"].ToString();
        lblVoucherNo.Text = VoucherNo;
    }
}
