using System;

public partial class GUI_Finance_Billing_GST_BillGeneration_SupplementaryBillGenerationDone : System.Web.UI.Page
{
    public string billnos = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        billnos = Convert.ToString(Request.QueryString["Billno"]);
        lblbillno.Text = billnos;
        
    }
}
