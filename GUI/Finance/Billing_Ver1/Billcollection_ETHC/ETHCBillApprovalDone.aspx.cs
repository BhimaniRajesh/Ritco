using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_Billing_Ver1_Billcollection_ETHC_ETHCBillApprovalDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblVoucherNo.Text = Convert.ToString(Request.QueryString["vouchernos"]);
        string flag = Convert.ToString(Request.QueryString["Flag"]);
        if(flag== "Approve")
        {
            lblstatus.Text = "MR Successfully Approved.";
        }
        else if(flag == "Reject")
        {
            lblstatus.Text = "MR Successfully Rejected.";
        }
    }
}