using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_VendorCPKMBilling_BillGeneration_Done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblTitle.Text = "Bill Payment Successfully";
            lblVendorName.Text = Convert.ToString(Request.QueryString.Get("VendorName"));
            lblMonth.Text = Convert.ToString(Request.QueryString.Get("FleetCenter"));
            lblBillNo.Text = Convert.ToString(Request.QueryString.Get("VoucherNo"));
            lblBillDate.Text = Convert.ToString(Request.QueryString.Get("VoucherDate"));
            lblNoVehicle.Text = Convert.ToString(Request.QueryString.Get("Vehicle"));
            lblBillAmount.Text = Convert.ToString(Request.QueryString.Get("BillAmount"));
        }
    }
}