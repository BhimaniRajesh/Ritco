using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Issue_New_TripSheet_Validation_TripSheetApprovalFinClosure_TripsheetApprovalDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            string TripsheetNo;
            TripsheetNo = Request.QueryString["TripSheetNo"].ToString().Trim();
            if (Request.QueryString["Type"] != null)
            {
                if (Request.QueryString["Type"].ToString() == "Reject")
                {
                    lblHeader.Text = "Trip Submission Cancellation is Done Successfully..…";
                    lblmsg.Text = "This Tripsheet " + TripsheetNo + " Send for Trip Submission !!!";
                }
                else {
                    lblHeader.Text = "Trip Reconsideration is Done Successfully..…";
                    lblmsg.Text = "This Tripsheet " + TripsheetNo + " Send for Reconsideration !!!";
                }
                
            }
            else {
                lblmsg.Text = "This Tripsheet " + TripsheetNo + " is Approved !!!";
            }
            
        }
    }
}