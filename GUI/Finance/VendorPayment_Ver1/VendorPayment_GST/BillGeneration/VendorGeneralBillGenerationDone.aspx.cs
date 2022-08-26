using System;

public partial class GUI_Finance_VendorPayment_GST_BillGeneration_VendorGeneralBillGenerationDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string billtype = Convert.ToString(Request.QueryString["BillType"]);
            lblBillNo.Text = Request.QueryString["BillNo"];

            if (billtype == "General")
                lblTitle.Text = "Vendor General Bill";
            else
                lblTitle.Text = "Freight Bill";
        }
    }
}
