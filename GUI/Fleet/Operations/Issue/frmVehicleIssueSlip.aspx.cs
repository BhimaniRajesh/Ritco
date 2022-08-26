using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Issue_frmVehicleIssueSlip : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {
        string strval = "";
        string mTripSheetType="";
        mTripSheetType = radTripSheetType.SelectedValue;
        strval = "TripSheetType=" + mTripSheetType;
        if (mTripSheetType == "R")
        {
            Response.Redirect("frmVehicleIssueSlipQuery.aspx?" + strval);
        }
        else
        {
            Response.Redirect("frmVehicleIssueSlipNewWORequest.aspx");
        }

    }
}
