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

public partial class GUI_finance_voucher_voucher_done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string VoucherNo = Request.QueryString["VoucherNo"];
            string VoucherType = Request.QueryString["VoucherType"];
            switch (VoucherType)
            {
                case "Journal(O)":
                    lblDocNameVal.Text = "Journal Voucher";
                    lblDocNoVal.Text = VoucherNo;
                    break;

                case "Journal":
                    lblDocNameVal.Text = "Journal Voucher";
                    lblDocNoVal.Text = VoucherNo;
                    break;
                case "Debit":
                    lblDocNameVal.Text = "Debit Voucher";
                    lblDocNoVal.Text = VoucherNo;
                    break;
                case "Credit":
                    lblDocNameVal.Text = "Credit Voucher";
                    lblDocNoVal.Text = VoucherNo;
                    break;
                case "Contra":
                    lblDocNameVal.Text = "Contra Voucher";
                    lblDocNoVal.Text = VoucherNo;
                    break;
            }
        }
    }
}
