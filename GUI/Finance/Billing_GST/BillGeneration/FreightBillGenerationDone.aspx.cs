using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_Billing_GST_BillGeneration_FreightBillGenerationDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string billtype= Convert.ToString(Request.QueryString["BillType"]);
            lblBillNo.Text = Request.QueryString["BillNo"];

            if (billtype == "General")
                lblTitle.Text = "General Bill";
            else
                lblTitle.Text = "Freight Bill";
        }
    }
}