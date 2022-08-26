using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_HCLBillPaymentDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblVoucherNo.Text = Convert.ToString(Request.QueryString["VoucherNo"]);
            var dt = new DataTable();
            var objHCLMasterController = new HCLMasterController();
            dt = objHCLMasterController.getdonepagedetails(lblVoucherNo.Text);
            gv1.DataSource=dt;
            gv1.DataBind();

            if (dt.Rows.Count > 0)
            {
                lblVoucherDate.Text= dt.Rows[0]["PaymentDate"].ToString();
            }
            
        }
    }
}