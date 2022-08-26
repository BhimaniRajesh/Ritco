using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripSubmission_Operational_Close_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string TripsheetNo;
        TripsheetNo = Request.QueryString["TripSheetNo"].ToString().Trim();
        lblmsg.Text = "This Tripsheet " + TripsheetNo + " Send for Approval Successfully!!!";
        if (Request.QueryString["Type"] != null ) {
            if (Request.QueryString["Type"].ToString() == "OperationClose")
            {
                lblHeader.Text = "TripSubmission Done";
                lblmsg.Text = "This Tripsheet " + TripsheetNo + " is Operationally Close Successfully!!!";
            }
            if (Request.QueryString["Type"].ToString() == "Submission")
            {
                lblHeader.Text="TripSubmission Done";
                lblmsg.Text = "This Tripsheet " + TripsheetNo + " is Submitted Successfully!!!";
            }
            
        }
        
    }
}