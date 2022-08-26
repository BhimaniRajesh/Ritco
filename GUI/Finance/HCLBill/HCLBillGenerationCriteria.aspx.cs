using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_HCLBill_HCLBillGenerationCriteria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if (!IsPostBack)
        {
            lblBranch.Text=SessionUtilities.CurrentBranchCode;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            string strFinalQS = "?Fromdt=" + dtBookingDate.FromDate;
            strFinalQS = strFinalQS + "&Todt=" + dtBookingDate.ToDate;

            Response.Redirect("HCLBillGeneration.aspx" + strFinalQS, false);
        }
        catch (Exception Ex)
        {
            UserMessage.Show("Error Messege : " + Ex.Message);
        }
    }
}