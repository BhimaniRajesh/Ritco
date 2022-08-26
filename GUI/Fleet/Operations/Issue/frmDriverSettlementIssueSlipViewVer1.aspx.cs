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
using System.Data.SqlClient;
using WebX.Controllers;

public partial class GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlipViewVer1 : System.Web.UI.Page
{

    string stVSlipId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        // Response.Cache.SetCacheability(HttpCacheability.NoCache);
        // Response.Cache.SetNoStore();
        // Response.Cache.SetExpires(DateTime.MinValue);

        // Common objCommon = new Common();
        // objCommon.doCacheRoutine();
        this.Title = pagetitle;


        if (!IsPostBack)
        {

            stVSlipId = Request.QueryString["id"];
            DriverSettlementController obj = new DriverSettlementController();
            gvEnroute.DataSource = obj.GetTripsheetEnRouteExpenseDetails(stVSlipId);
            gvEnroute.DataBind();

            DataSet ds = obj.GetDriverSettlementDetailsViewPrint(stVSlipId);
            DataTable dt = ds.Tables[0];
            DataTable dtSettlement = ds.Tables[3];
            if (dt.Rows.Count > 0)
            {
                lblVehicleNo.Text = dt.Rows[0]["VehicleNo"].ToString();
                lblTripsheetNo.Text = dt.Rows[0]["VSlipNo"].ToString();
                lblDriverName.Text = dt.Rows[0]["DriverName"].ToString();
                lblTripsheetDate.Text = dt.Rows[0]["VSlipDt"].ToString();
                lblSubmissionDate.Text = dt.Rows[0]["TripSubmissionDate"].ToString();
                lblApprovedDate.Text = dt.Rows[0]["ApprovalDate"].ToString();
                lblFinancialClosureDate.Text = dt.Rows[0]["FinacialClosureDate"].ToString();

                lblDistanceKM.Text = dt.Rows[0]["Distance"].ToString();
                lblTotalFuelLtrs.Text = dt.Rows[0]["ApprovedFuel_Proposed"].ToString();
                lblFuelEconomy_KMPL.Text = dt.Rows[0]["FuelEconomy"].ToString();
                lblAddBlueRatio.Text = dt.Rows[0]["AddBlueRatio"].ToString();
                lblPerKMExpense.Text = dt.Rows[0]["PerKMExpense"].ToString();
            }
            if (dtSettlement.Rows.Count > 0)
            {
                lblSettlementDate.Text = dtSettlement.Rows[0]["SettleDate"].ToString();
                lblDriverAdvance.Text = dtSettlement.Rows[0]["TotAdvPaid"].ToString();
                lblApprovedAmount.Text = dtSettlement.Rows[0]["TotExpense"].ToString();
                txtPaidAmt.Text = dtSettlement.Rows[0]["AmtPaidToDriver"].ToString();
                txtReceivedAmt.Text = dtSettlement.Rows[0]["AmtRecvdFromDriver"].ToString();
                txtBalanceAmount_CrDr.Text = dtSettlement.Rows[0]["NetAmount"].ToString();
                txtBalToDriverLedger.Text = dtSettlement.Rows[0]["BalanceToDriverLedger"].ToString();
            }

            grdFuel.DataSource = ds.Tables[1];
            grdFuel.DataBind();

            grdAdvance.DataSource = ds.Tables[2];
            grdAdvance.DataBind();

            grdProtsahanRashi.DataSource = obj.GetProtsahanRashiPopUpGridDetails(lblTripsheetNo.Text); ;
            grdProtsahanRashi.DataBind();
        }
    }

    double totApprovedAmt = 0;
    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label lblNExpense = (Label)e.Row.FindControl("lblNExpense");
            Label txtApprovalAmount = (Label)e.Row.FindControl("txtApprovalAmount");
            HiddenField hidNExpenseTitle = (HiddenField)e.Row.FindControl("hidNExpenseTitle");

            if (hidNExpenseTitle.Value == "Penalty(-)")
            {
                totApprovedAmt = totApprovedAmt - Convert.ToDouble(txtApprovalAmount.Text);
            }
            else
            {
                totApprovedAmt = totApprovedAmt + Convert.ToDouble(txtApprovalAmount.Text);
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtApprovalTotal = (Label)e.Row.FindControl("txtApprovalTotal");
            txtApprovalTotal.Text = Convert.ToString(totApprovedAmt);
            lblApprovedAmount.Text = Convert.ToString(totApprovedAmt);

        }
    }


}
