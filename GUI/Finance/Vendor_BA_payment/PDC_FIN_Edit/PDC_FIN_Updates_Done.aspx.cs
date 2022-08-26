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

public partial class GUI_Finance_Vendor_BA_payment_PDC_FIN_Edit_PDC_FIN_Updates_Done : System.Web.UI.Page
{
    string thcno, voucherNo, DocumentPrint;
    protected void Page_Load(object sender, EventArgs e)
    {
        DocumentPrint = Request.QueryString["DocumentPrint"].ToString();
        voucherNo = Request.QueryString["voucherNo"].ToString();
        lblTHCNo.Text = DocumentPrint;
       // lblVoucherNo.Text = voucherNo;
    }
}
