using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebX.Controllers;

public partial class Issue_New_TripSheet_Validation_TripSheetApprovalSubmission_TripsheetFinClosureMain : BasePage
{
    string TripsheetNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {
            var obj = new TripApprovalController();
            DataTable dt = new DataTable();
            dt = obj.GetTripsheetForApprovalAndFinacialClosure(Request.QueryString["VSlipNo"].ToString(), "T", System.DateTime.Now, System.DateTime.Now, "", "F");

            lblVehicleNo.Text = dt.Rows[0]["VehicleNo"].ToString();
            lblTripsheetNo.Text = dt.Rows[0]["VSlipNo"].ToString();
            lblRouteType.Text = dt.Rows[0]["route"].ToString();


            var objFin = new TripSubmissionOperationFinancialClosureController();
            DataTable dtVehicleDetails = objFin.GetTripsheetVehicleDetails(Request.QueryString["VSlipNo"].ToString());

            if (dtVehicleDetails.Rows.Count > 0)
            {
                // Fuel Id
                lblTotalFuel_A.Text = dtVehicleDetails.Rows[0]["Fuel_Total"].ToString();
                txtTotalFuel_A.Text = dtVehicleDetails.Rows[0]["Fuel_Total"].ToString();
                lblFixedPerKMTotal_Type.Text = (dtVehicleDetails.Rows[0]["ApprovedFixedPerKM_Type"].ToString() == "F" ? "Fixed" : "Per KM");
                txtAmtRateTotal.Text = dtVehicleDetails.Rows[0]["ApprovedFixedPerKM_Value"].ToString();
                lblTotal_CF.Text = dtVehicleDetails.Rows[0]["ApprovedFuel_CF"].ToString();
                txtTotal_CF.Text = dtVehicleDetails.Rows[0]["ApprovedFuel_CF"].ToString();
                lblFuelEconomy.Text = dtVehicleDetails.Rows[0]["FuelEconomy"].ToString();
                lblStanderdFuel.Text = "0";
                txtProposedFuel.Text = dtVehicleDetails.Rows[0]["Fuel_Proposed"].ToString();
                txtTotalFuelRemark.Text = dtVehicleDetails.Rows[0]["Fuel_Remark"].ToString();
                txtApprovedProposedFuel.Text = dtVehicleDetails.Rows[0]["ApprovedFuel_Proposed"].ToString();
                txtApprovedTotalFuelRemark.Text = dtVehicleDetails.Rows[0]["ApprovedFuel_Remark"].ToString();

                //Add Blue
                lblTotalAddBlue_A.Text = dtVehicleDetails.Rows[0]["AddBlue_Total"].ToString();
                txtTotalAddBlue_A.Text = dtVehicleDetails.Rows[0]["AddBlue_Total"].ToString();
                lblAddBlueFixedPerKMTotal_Type.Text = (dtVehicleDetails.Rows[0]["AddBlueFixedPerKM_Type"].ToString() == "F" ? "Fixed" : "Per KM");
                txtAddBlueAmtRateTotal.Text = dtVehicleDetails.Rows[0]["AddBlueFixedPerKM_Value"].ToString();
                lblAddBlueTotal_CF.Text = dtVehicleDetails.Rows[0]["AddBlue_CF"].ToString();
                txtAddBlueTotal_CF.Text = dtVehicleDetails.Rows[0]["AddBlue_CF"].ToString();
                lblStanderdAddBlue.Text = "0";
                txtProposedAddBlue.Text = dtVehicleDetails.Rows[0]["AddBlue_Proposed"].ToString();
                txtTotalAddBlueRemark.Text = dtVehicleDetails.Rows[0]["AddBlue_Remark"].ToString();
                txtApprovedProposedAddBlue.Text = dtVehicleDetails.Rows[0]["AddBlue_Proposed"].ToString();
                txtApprovedTotalAddBlueRemark.Text = dtVehicleDetails.Rows[0]["AddBlue_Remark"].ToString();


                hdnDistance.Value = dtVehicleDetails.Rows[0]["Distance"].ToString();

                hdnDriverAdvance.Value = dtVehicleDetails.Rows[0]["DriverAdvance"].ToString();

                hdnAddBlueSlipLtrs.Value = dtVehicleDetails.Rows[0]["AddBlueSlipLtr"].ToString();
                hdnAddBlueCardLtrs.Value = dtVehicleDetails.Rows[0]["AddBlueCardLtr"].ToString();
                hdnAddBlueCashLtrs.Value = dtVehicleDetails.Rows[0]["AddblueCashLtr"].ToString();

                hdnAddBlueSlipAmt.Value = dtVehicleDetails.Rows[0]["AddBlueSlipAmount"].ToString();
                hdnAddBlueCardAmt.Value = dtVehicleDetails.Rows[0]["AddBlueCardAmount"].ToString();
                hdnAddBlueCashAmt.Value = dtVehicleDetails.Rows[0]["AddblueCashAmt"].ToString();

                hdnFuelSlipAmount.Value = dtVehicleDetails.Rows[0]["FuelSlipAmount"].ToString();
                hdnFuelCardAmout.Value = dtVehicleDetails.Rows[0]["FuelCardAmount"].ToString();
                hdnFuelCashAmount.Value = dtVehicleDetails.Rows[0]["FuelCashAmt"].ToString();

                hdnFuelSlipLtr.Value = dtVehicleDetails.Rows[0]["FuelSlipLtr"].ToString();
                hdnFuelCardLtr.Value = dtVehicleDetails.Rows[0]["FuelCardLtr"].ToString();
                hdnFuelCashLtr.Value = dtVehicleDetails.Rows[0]["FuelCashLtr"].ToString();

                hdnTollAmtByCard.Value = dtVehicleDetails.Rows[0]["TollAmountByCard"].ToString();
            }

            DataTable dtCF = new DataTable();
            dtCF = objFin.GetPreviouseCarryForwardDetails(lblTripsheetNo.Text);

            if (dtCF.Rows.Count > 0)
            {
                hdnPreviouseFuelCF_Ltr.Value = dtCF.Rows[0]["PreviousFuleCF_Ltr"].ToString();
                hdnPreviouseFuelCF_amount.Value = dtCF.Rows[0]["PreviousFuleCF_Amount"].ToString();
                hdnPreviouseDriverAdvanceCF_amount.Value = dtCF.Rows[0]["PreviousDriverBalanceAmount"].ToString();
            }

            DataTable dtEnroute = obj.GetTripsheetEnRouteExpenseDetails(lblTripsheetNo.Text, lblRouteType.Text, lblVehicleNo.Text);
            if (dtEnroute.Rows.Count > 0)
            {
                DataView dataViewEnroute = dtEnroute.DefaultView;
                dataViewEnroute.RowFilter = "Expense  NOT IN ('Toll', 'CashFuel', 'CashAddBlue')";
                gvEnroute.DataSource = dataViewEnroute;
                gvEnroute.DataBind();

                DataView dataViewEnrouteExtra = dtEnroute.DefaultView;
                dataViewEnrouteExtra.RowFilter = "Expense IN ('Toll', 'CashFuel', 'CashAddBlue')";
                gvEnrouteExtra.DataSource = dataViewEnroute;
                gvEnrouteExtra.DataBind();
            }


            DataSet dsExtraExpense = new DataSet();
            dsExtraExpense = obj.GetTripsheetExtraExpenseDetails(lblTripsheetNo.Text);

            grdFule.DataSource = dsExtraExpense.Tables[0];
            grdFule.DataBind();

            grdAddBlue.DataSource = dsExtraExpense.Tables[1];
            grdAddBlue.DataBind();

            grdDetention.DataSource = dsExtraExpense.Tables[3];
            grdDetention.DataBind();

            grdFuelSlip.DataSource = dsExtraExpense.Tables[4];
            grdFuelSlip.DataBind();

            grdProtsahanRashi.DataSource = dsExtraExpense.Tables[5];
            grdProtsahanRashi.DataBind();

            DataTable dtToll = dsExtraExpense.Tables[2];

            if (dtToll.Rows.Count > 0)
            {
                txtCardNo_Toll.Text = dtToll.Rows[0]["CardNo"].ToString();
                txtThisDate_Toll.Text = dtToll.Rows[0]["ThisDate"].ToString();
                txtThisRefNo_Toll.Text = dtToll.Rows[0]["ThisRefNo"].ToString();
                txtByCard_Toll.Text = dtToll.Rows[0]["ByCard"].ToString();
                txtByCash_Toll.Text = dtToll.Rows[0]["ByCash"].ToString();
                txtTotal_Toll.Text = dtToll.Rows[0]["Total"].ToString();
            }

        }
    }

    public double totProposedAmt = 0, totExpenseAmt = 0, totApprovalAmt = 0;
    //protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    //{

    //    if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
    //    {
    //        Label lblNExpense = (Label)e.Row.FindControl("lblNExpense");
    //        Label txtEAmt = (Label)e.Row.FindControl("txtEAmt");
    //        HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
    //        HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
    //        TextBox txtProposedAmount = (TextBox)e.Row.FindControl("txtProposedAmount");
    //        //TextBox txtProposedRemark = (TextBox)e.Row.FindControl("txtProposedRemark");


    //        if (lblNExpense.Text == "Toll")
    //        {
    //            lblNExpense.Attributes.Add("onClick", "javascript:ViewTollPopup();");
    //            lblNExpense.Style.Add("text-decoration", "underline");
    //        }
    //        if (lblNExpense.Text == "Fuel")
    //        {
    //            lblNExpense.Attributes.Add("onClick", "javascript:ViewFuelPopup();");
    //            lblNExpense.Style.Add("text-decoration", "underline");
    //        }
    //        if (lblNExpense.Text == "AddBlue")
    //        {
    //            lblNExpense.Attributes.Add("onClick", "javascript:ViewAddBluePopup();");
    //            lblNExpense.Style.Add("text-decoration", "underline");
    //        }

    //        totProposedAmt = totProposedAmt + Convert.ToDouble(txtProposedAmount.Text);
    //        totExpenseAmt = totExpenseAmt + Convert.ToDouble(txtEAmt.Text);
    //    }
    //    if (e.Row.RowType == DataControlRowType.Footer)
    //    {
    //        Label txtETotalAmt = (Label)e.Row.FindControl("txtETotalAmt");
    //        Label txtProposedAmountTotal = (Label)e.Row.FindControl("txtProposedAmountTotal");
    //        Label txtApprovalTotal = (Label)e.Row.FindControl("txtApprovalTotal");

    //        txtETotalAmt.Text = Convert.ToString(totExpenseAmt);
    //        txtProposedAmountTotal.Text = Convert.ToString(totProposedAmt);
    //        txtApprovalTotal.Text = Convert.ToString(totProposedAmt);
    //    }
    //}

    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label lblNExpense = (Label)e.Row.FindControl("lblNExpense");
            Label txtEAmt = (Label)e.Row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
            Label txtProposedAmount = (Label)e.Row.FindControl("txtProposedAmount");
            Label txtApprovalAmount = (Label)e.Row.FindControl("txtApprovalAmount");
            //TextBox txtProposedRemark = (TextBox)e.Row.FindControl("txtProposedRemark");


            Label lblFixedPerKM = (Label)e.Row.FindControl("lblFixedPerKM");
            Label txtAmtRate = (Label)e.Row.FindControl("txtAmtRate");
            Label lblDistance = (Label)e.Row.FindControl("lblDistance");

            HiddenField hdnddlFixedPerKM = (HiddenField)e.Row.FindControl("hdnddlFixedPerKM");
            if (lblNExpense.Text.ToUpper() == "PROTSAHANRASHI")
            {
                lblNExpense.Attributes.Add("onClick", "javascript:OpenProtsahanRashiPopup('" + lblNExpense.ClientID + "');");
                lblNExpense.Style.Add("text-decoration", "underline");
            }
            if (lblNExpense.Text.ToString().ToUpper() != "INCENTIVE" && lblNExpense.Text.ToString().ToUpper() != "ENROUTEEXPENSE")
            {
                lblFixedPerKM.Attributes.Add("style", "display:none;");
                txtAmtRate.Attributes.Add("style", "display:none;");
                lblDistance.Attributes.Add("style", "display:none;");
            }
            else
            {
                lblFixedPerKM.Text = (hdnddlFixedPerKM.Value == "F" ? "Fixed" : "Per KM");
                lblDistance.Text = "Distance : " + hdnDistance.Value;
            }

            if (hfPolarity.Value == "+")
            {
                totProposedAmt = totProposedAmt + Convert.ToDouble(txtProposedAmount.Text);
                totExpenseAmt = totExpenseAmt + Convert.ToDouble(txtEAmt.Text);
                totApprovalAmt = totApprovalAmt + Convert.ToDouble(txtApprovalAmount.Text);
            }
            else if (hfPolarity.Value == "-")
            {
                totProposedAmt = totProposedAmt - Convert.ToDouble(txtProposedAmount.Text);
                totExpenseAmt = totExpenseAmt - Convert.ToDouble(txtEAmt.Text);
                totApprovalAmt = totApprovalAmt - Convert.ToDouble(txtApprovalAmount.Text);
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtETotalAmt = (Label)e.Row.FindControl("txtETotalAmt");
            Label txtProposedAmountTotal = (Label)e.Row.FindControl("txtProposedAmountTotal");
            Label txtApprovalTotal = (Label)e.Row.FindControl("txtApprovalTotal");

            txtETotalAmt.Text = Convert.ToString(totExpenseAmt);
            txtProposedAmountTotal.Text = Convert.ToString(totProposedAmt);
            txtApprovalTotal.Text = Convert.ToString(totApprovalAmt);
            
        }
    }

    protected void gvEnrouteExtra_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label lblNExpense = (Label)e.Row.FindControl("lblNExpense");
            Label txtEAmt = (Label)e.Row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
            Label txtProposedAmount = (Label)e.Row.FindControl("txtProposedAmount");
            Label txtApprovalAmount = (Label)e.Row.FindControl("txtApprovalAmount");
            //TextBox txtProposedRemark = (TextBox)e.Row.FindControl("txtProposedRemark");
            Label lblDisplay = (Label)e.Row.FindControl("lblDisplay");

            if (lblNExpense.Text.ToUpper() == "TOLL")
            {
                lblNExpense.Attributes.Add("onClick", "javascript:ViewTollPopup();");
                lblNExpense.Style.Add("text-decoration", "underline");
            }
            if (lblNExpense.Text.ToUpper() == "CASHFUEL")
            {
                txtEAmt.Text = "0";
                lblNExpense.Attributes.Add("onClick", "javascript:ViewFuelPopup();");
                lblNExpense.Style.Add("text-decoration", "underline");
                lblDisplay.Text = "Fuel Slip";
                lblDisplay.Visible = true;
                lblDisplay.Style.Add("text-decoration", "underline");
                lblDisplay.Attributes.Add("onClick", "javascript:ViewFuelSlipPopup('" + lblNExpense.ClientID + "');");
                lblStanderdFuel.Text = hfEAmt.Value;
            }
            if (lblNExpense.Text.ToUpper() == "CASHADDBLUE")
            {
                txtEAmt.Text = "0";
                lblNExpense.Attributes.Add("onClick", "javascript:ViewAddBluePopup();");
                lblNExpense.Style.Add("text-decoration", "underline");
                lblDisplay.Text = "TotalAddBlue";
                lblDisplay.Visible = true;
                lblDisplay.Style.Add("text-decoration", "underline");
                lblDisplay.Attributes.Add("onClick", "javascript:ViewTotalAddBluePopup('" + lblNExpense.ClientID + "');");
            }

            totProposedAmt = totProposedAmt + Convert.ToDouble(txtProposedAmount.Text);
            totExpenseAmt = totExpenseAmt + Convert.ToDouble(txtEAmt.Text);
            totApprovalAmt = totApprovalAmt + Convert.ToDouble(txtApprovalAmount.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtETotalAmt = (Label)e.Row.FindControl("txtETotalAmt");
            Label txtProposedAmountTotal = (Label)e.Row.FindControl("txtProposedAmountTotal");
            Label txtApprovalTotal = (Label)e.Row.FindControl("txtApprovalTotal");

            txtETotalAmt.Text = Convert.ToString(totExpenseAmt);
            txtProposedAmountTotal.Text = Convert.ToString(totProposedAmt);
            txtApprovalTotal.Text = Convert.ToString(totApprovalAmt);
        }
    }
    protected void btnfinclose_Click(object sender, EventArgs e)
    {
        try
        {
            var obj = new TripApprovalController();
            obj.TripsheetFinancialClosureEntry(lblTripsheetNo.Text);
            Response.Redirect("TripsheetFinClosureDone.aspx?Type=F&TripSheetNo=" + lblTripsheetNo.Text, false);
        }
        catch (Exception ex)
        {
            // btnApproved.Visible = true;
            throw ex;
        }
    }
    protected void btnReconsideration_Click(object sender, EventArgs e)
    {
        //btnApproved.Visible = false;
        try
        {
            var obj = new TripApprovalController();
            obj.TripsheetReconsiderationEntry(lblTripsheetNo.Text, txtReconsiderationRemark.Text);
            Response.Redirect("TripsheetApprovalDone.aspx?Type=R&TripSheetNo=" + lblTripsheetNo.Text, false);
        }
        catch (Exception ex)
        {
            // btnApproved.Visible = true;
            throw ex;
        }
    }
}
