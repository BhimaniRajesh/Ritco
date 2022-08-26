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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_RunSheet_RunSheetBalancePaymentDone : System.Web.UI.Page
{
    string thcno, voucherNo, DocumentPrint;

    protected void Page_Load(object sender, EventArgs e)
    {
        voucherNo = Request.QueryString["VoucherNo"].ToString();
        lblVoucherNo.Text = voucherNo;
    }
}
