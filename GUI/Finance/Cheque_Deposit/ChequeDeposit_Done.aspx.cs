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

public partial class GUI_Finance_Cheque_Deposit_ChequeDeposit_Done : System.Web.UI.Page
{
    string VoucherNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        VoucherNo = Request.QueryString["VoucherNo"];
        string VoucherType = Request.QueryString["VoucherType"];

        lblDocNameVal.Text = VoucherType.ToString() + " Deposit";
        lblDocNoVal.Text = VoucherNo.ToString();
    }
}
