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

public partial class GUI_Finance_voucher_FrmVoucherCriteria : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
       
            string documenttype, docno1, vendortype, vendor;
           
            string final = "";
            if (cboDocType.SelectedValue.ToString() == "T")
            {
                if (cboPaymentType.SelectedValue.ToString() == "A")
                {
                    final = "?documentType=" + cboDocType.SelectedValue.ToString();
                    final += "&VoucherNo=" + txtVoucherNo.Text.Trim().Replace("'", "''");
                    final += "&PaymentType=" + cboPaymentType.SelectedValue.ToString();
                    Response.Redirect("FrmVoucherTHCVoucher.aspx" + final);
                }
                else if (cboPaymentType.SelectedValue.ToString() == "B")
                {
                    final = "?documentType=" + cboDocType.SelectedValue.ToString();
                    final += "&VoucherNo=" + txtVoucherNo.Text.Trim().Replace("'", "''");
                    final += "&PaymentType=" + cboPaymentType.SelectedValue.ToString();
                    Response.Redirect("FrmVoucherTHCVoucher.aspx" + final);
                }
            }
            else if (cboDocType.SelectedValue.ToString() == "P")
            {
                if (cboPaymentType.SelectedValue.ToString() == "A")
                {
                    final = "?documentType=" + cboDocType.SelectedValue.ToString();
                    final += "&VoucherNo=" + txtVoucherNo.Text.Trim().Replace("'", "''");
                    final += "&PaymentType=" + cboPaymentType.SelectedValue.ToString();
                    Response.Redirect("FrmVoucherPDCVoucher.aspx" + final);
                }
                else if (cboPaymentType.SelectedValue.ToString() == "B")
                {
                    final = "?documentType=" + cboDocType.SelectedValue.ToString();
                    final += "&VoucherNo=" + txtVoucherNo.Text.Trim().Replace("'", "''");
                    final += "&PaymentType=" + cboPaymentType.SelectedValue.ToString();
                    Response.Redirect("FrmVoucherPDCVoucher.aspx" + final);
                }
            }
       
    }
}
