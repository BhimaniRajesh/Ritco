using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_PendingPaymentFuelBills_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var VoucherNo = Request.QueryString["VoucherNo"].ToString();
        var VoucherDate = Request.QueryString["VoucherDate"].ToString();
        var Amount = Request.QueryString["Amount"].ToString();

        lblVoucherNo.Text = VoucherNo;
        lblVoucherDate.Text = VoucherDate;
        lblVoucherAmt.Text = Amount;
    }   
}