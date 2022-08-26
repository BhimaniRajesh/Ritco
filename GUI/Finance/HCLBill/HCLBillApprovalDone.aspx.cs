using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_HCLBillApprovalDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblBillno.Text = Convert.ToString(Request.QueryString["BillNo"]);
        string flag = Convert.ToString(Request.QueryString["Flag"]);
        if(flag== "Approve")
        {
            lblstatus.Text = "Bill Successfully Approved.";
        }
        else if(flag == "Reject")
        {
            lblstatus.Text = "Bill Successfully Rejected.";
        }
    }
}