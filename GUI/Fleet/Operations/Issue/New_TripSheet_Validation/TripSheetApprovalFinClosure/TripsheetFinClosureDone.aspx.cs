using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;

public partial class Issue_New_TripSheet_Validation_TripSheetApproval_TripsheetFinClosureDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string TripsheetNo;
            TripsheetNo = Request.QueryString["TripSheetNo"].ToString().Trim();
            lblmsg.Text = "This Tripsheet " + TripsheetNo + " is Financially closed  !!!";
            var obj = new TripApprovalController();
            grdResult.DataSource = obj.TripsheetFinancialClosureResultData(TripsheetNo);
            grdResult.DataBind();
        }
    }

    protected void lnkDriverSettlement_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/GUI/Fleet/Operations/Issue/frmDriverSettlementIssueSlipVer1.aspx?VSlipNo=" + Request.QueryString["TripSheetNo"].ToString().Trim(), false);
    }
}