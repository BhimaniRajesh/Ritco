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

public partial class GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlipVer1 : BasePage
{
    string TripsheetNo = "";
    public double totApprovedAmt = 0, totDriverAdvance = 0;

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
            btnSubmit.Visible = false;
            var obj1 = new TripSubmissionOperationFinancialClosureController();
            var dt1 = obj1.GetTripSubmissionValidation(Request.QueryString["VSlipNo"].ToString());
            if (Convert.ToInt16(dt1.Rows[0]["PendingTripsheetCount"]) > 0)
            {
                btnSubmit.Visible = false;
                return;
            }

            if (Convert.ToInt16(dt1.Rows[0]["PendingDriverSettlementCount"]) > 0)
            {
                btnSubmit.Visible = false;
                return;
            }

            var obj = new DriverSettlementController();
            DataTable dt = new DataTable();
            dt = obj.GetDriverSettlementTripsheetDetails(Request.QueryString["VSlipNo"].ToString());

            lblVehicleNo.Text = dt.Rows[0]["VehicleNo"].ToString();
            lblTripsheetNo.Text = dt.Rows[0]["VSlipNo"].ToString();
            lblDriverAdvance.Text = dt.Rows[0]["DriverAdvance"].ToString();
            lblDriverName.Text = dt.Rows[0]["DriverName"].ToString();
            lblTripsheetDate.Text = dt.Rows[0]["VSlipDt"].ToString();
            lblSubmissionDate.Text = dt.Rows[0]["TripSubmissionDate"].ToString();
            lblApprovedDate.Text = dt.Rows[0]["ApprovalDate"].ToString();
            lblFinancialClosureDate.Text = dt.Rows[0]["FinacialClosureDate"].ToString();
            hidStartLoc.Value = dt.Rows[0]["TripSheet_StartLoc"].ToString();
            hidEndLoc.Value = dt.Rows[0]["TripSheet_EndLoc"].ToString();


            var dtFuel = obj.GetDriverSettlementDetailsViewPrint(Request.QueryString["VSlipNo"].ToString()).Tables[0];
            if (dtFuel.Rows.Count > 0)
            {
                lblDistanceKM.Text = dtFuel.Rows[0]["Distance"].ToString();
                lblTotalFuelLtrs.Text = dtFuel.Rows[0]["ApprovedFuel_Proposed"].ToString();
                lblFuelEconomy_KMPL.Text = dtFuel.Rows[0]["FuelEconomy"].ToString();
                lblAddBlueRatio.Text = dtFuel.Rows[0]["AddBlueRatio"].ToString();
                lblPerKMExpense.Text = dtFuel.Rows[0]["PerKMExpense"].ToString();

                lblSlipFuel.Text = dtFuel.Rows[0]["SlipFuelLtr"].ToString();
                lblCardFuel.Text = dtFuel.Rows[0]["CardFuelLtr"].ToString();
                lblCashFuel.Text = dtFuel.Rows[0]["CashFuelLtr"].ToString();
                lblTotalFuel.Text = dtFuel.Rows[0]["Fuel_Total"].ToString();
                lblBalanceCF.Text = dtFuel.Rows[0]["ApprovedFuel_CF"].ToString();
            }


            gvEnroute.DataSource = obj.GetTripsheetEnRouteExpenseDetails(lblTripsheetNo.Text);
            gvEnroute.DataBind();

            lblApprovedAmount.Text = totApprovedAmt.ToString();
            double totPaidRecievedAmt = Convert.ToDouble(lblDriverAdvance.Text) - Convert.ToDouble(lblApprovedAmount.Text);

            txtPaidAmt.Text = "0.00";
            txtReceivedAmt.Text = "0.00";

            if (totPaidRecievedAmt > 0)
            {
                txtPaidAmt.Enabled = false;
                txtBalanceAmount_CrDr.Text = Convert.ToString(totPaidRecievedAmt);
                lblBalanceAmount_CrDr.Text = "Balance Amt (DR)";
            }
            if (totPaidRecievedAmt < 0)
            {
                txtReceivedAmt.Enabled = false;
                txtBalanceAmount_CrDr.Text = Convert.ToString(Math.Abs(totPaidRecievedAmt));
                lblBalanceAmount_CrDr.Text = "Balance Amt (CR)";

            }

            if ((Convert.ToDouble(lblDriverAdvance.Text) - Convert.ToDouble(lblApprovedAmount.Text)) == 0)
            {
                btnAutoSettlement.Visible = true;
            }

            grdProtsahanRashi.DataSource = obj.GetProtsahanRashiPopUpGridDetails(lblTripsheetNo.Text); ;
            grdProtsahanRashi.DataBind();
        }
    }


    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label txtApprovalAmount = (Label)e.Row.FindControl("txtApprovalAmount");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");

            if (hfPolarity.Value == "+")
            {
                totApprovedAmt = totApprovedAmt + Convert.ToDouble(txtApprovalAmount.Text);
            }
            else
            {
                totApprovedAmt = totApprovedAmt - Convert.ToDouble(txtApprovalAmount.Text);
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtApprovalTotal = (Label)e.Row.FindControl("txtApprovalTotal");
            txtApprovalTotal.Text = Convert.ToString(totApprovedAmt);

        }
    }



    protected void Payment_Receipt(object sender, EventArgs e)
    {
        double BalToDriverLedger = 0;
        string AmtPaidToDriver = "";
        string AmtRecvdFromDriver = "";
        string BalToDriverLedgerVal = "";

        AmtPaidToDriver = txtPaidAmt.Text;
        if (AmtPaidToDriver == "")
            AmtPaidToDriver = "0";
        AmtRecvdFromDriver = txtReceivedAmt.Text;
        if (AmtRecvdFromDriver == "")
            AmtRecvdFromDriver = "0";


        //BalToDriverLedger = Convert.ToString((totDriverAdvance - totApprovedAmt + Convert.ToDouble(AmtPaidToDriver) - Convert.ToDouble(AmtRecvdFromDriver)));
        BalToDriverLedger = (Convert.ToDouble(lblDriverAdvance.Text) - Convert.ToDouble(lblApprovedAmount.Text) + Convert.ToDouble(AmtPaidToDriver) - Convert.ToDouble(AmtRecvdFromDriver));

        Session["ActBalToDriverLedger"] = BalToDriverLedger;
        if (BalToDriverLedger < 0)
        {
            LblDriverLedger.Text = "Balance Amt (CR)";
        }
        else
        {
            LblDriverLedger.Text = "Balance Amt (DR)";
        }

        txtBalToDriverLedger.Text = Convert.ToString(Math.Abs(BalToDriverLedger));

        if (Convert.ToDouble(AmtRecvdFromDriver) == 0 && Convert.ToDouble(AmtPaidToDriver) == 0)
        {
            UpdatePaneReceipt.Visible = false;
            UpdatePanePayment.Visible = false;

        }
        lblError.Text = "";

        if (Convert.ToDouble(AmtPaidToDriver) < 0)
            lblError.Text = "Amount paid to driver can not be negative !!!";
        if (Convert.ToDouble(AmtRecvdFromDriver) < 0)
            lblError.Text = "Amount received from driver can not be negative !!!";
        if (Convert.ToDouble(AmtPaidToDriver) > 0)
        {
            UpdatePanePayment.Visible = true;
            UpdatePaneReceipt.Visible = false;
            btnSubmit.Visible = true;
        }
        if (Convert.ToDouble(AmtRecvdFromDriver) > 0)
        {
            UpdatePaneReceipt.Visible = true;
            UpdatePanePayment.Visible = false;
            btnSubmit.Visible = true;
        }
        if (BalToDriverLedgerVal == "")
            BalToDriverLedgerVal = "0";

        //if (Convert.ToDouble(totApprovedAmt) < 0)
        //    NetBalance = System.Math.Round(Convert.ToDouble(lblDriverAdvance.Text), 2) - System.Math.Round(Convert.ToDouble(totApprovedAmt) - Convert.ToDouble(AmtPaidToDriver) + Convert.ToDouble(BalToDriverLedgerVal), 2);
        //if (Convert.ToDouble(totApprovedAmt) > 0)
        //    NetBalance = System.Math.Round(Convert.ToDouble(lblDriverAdvance.Text), 2) - System.Math.Round(Convert.ToDouble(totApprovedAmt) + Convert.ToDouble(AmtRecvdFromDriver) + Convert.ToDouble(BalToDriverLedgerVal), 2);


        //NetBalance = Math.Round(NetBalance, 2);



        if (txtPaidAmt.Text != "")
        {
            if (Convert.ToDouble(txtPaidAmt.Text) > 0)
            {
                UserControls_MyPaymentControlEXP paymen = (UserControls_MyPaymentControlEXP)UCMyPaymentControl1;
                TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
                TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");
                txtAmtApplA.Text = txtPaidAmt.Text;
                txtNetPay.Text = txtPaidAmt.Text;
            }
        }
        if (txtReceivedAmt.Text != "")
        {
            if (Convert.ToDouble(txtReceivedAmt.Text) > 0)
            {
                UserControls_MyReceiptControlDS receipt = (UserControls_MyReceiptControlDS)UCMyReceiptControl1;
                TextBox txtAmtApplA = (TextBox)receipt.FindControl("txtAmtApplA");
                TextBox txtNetPay = (TextBox)receipt.FindControl("txtNetPay");
                txtAmtApplA.Text = txtReceivedAmt.Text;
                txtNetPay.Text = txtReceivedAmt.Text;
            }
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        string AmtPaidToDriver = "";
        string AmtRecvdFromDriver = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime mDrvierSettlementDt = new DateTime();
        string strDriverSettleDt = "";
        SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn1.Open();
        string ctr = "select  DriverSettleDt from WEBX_FLEET_VEHICLE_ISSUE where VslipNo='" + lblTripsheetNo.Text + "'";
        SqlCommand cdR = new SqlCommand(ctr, conn1);
        SqlDataReader cdDR = cdR.ExecuteReader();
        if (cdDR.HasRows)
        {
            while (cdDR.Read())
            {
                strDriverSettleDt = Convert.ToString(cdDR["DriverSettleDt"]);
            }
        }
        cdDR.Close();
        conn1.Close();
        if (strDriverSettleDt != "" && strDriverSettleDt != null)
        {
            lblError.Visible = true;
            lblError.Text = "Sorry!!! You have already submitted the data for this tripsheet.\n\nRe-submisssion is not allowed.";
        }
        if (txtSettlementDate.Text == "")
        {
            if (lblError.Text == "")
                lblError.Text = "Driver settlement date should not be empty !!!";
        }
        if (lblError.Text == "")
            mDrvierSettlementDt = Convert.ToDateTime(txtSettlementDate.Text.ToString(), dtfi);
        DateTime mServerDt = DateTime.Now;
        DateTime mFinCloseDt = new DateTime();
        //mFinCloseDt = Convert.ToDateTime(lblFinancialClosureDate.Text.ToString(), dtfi);
        mFinCloseDt = Convert.ToDateTime(lblFinancialClosureDate.Text.ToString());
        DateTime mCutOffDt = new DateTime();
        DataTable dtDriverSettlementDate = new DataTable();
        cls_DriverSettlementDate objDsdt = new cls_DriverSettlementDate(Session["SqlProvider"].ToString().Trim());
        //dtDriverSettlementDate = objDsdt.GetDriverSettlemnetDate();
        //mCutOffDt = Convert.ToDateTime(dtDriverSettlementDate.Rows[0][0].ToString(), dtfi);
        if (lblError.Text == "")
        {
            {
                DateTime dtFrom = new DateTime();
                DateTime dtTo = new DateTime();
                string From = "", To = "";
                From = "01/04/" + SessionUtilities.FinYear.ToString().Trim();
                To = "31/03/" + Convert.ToDouble(Convert.ToDouble(SessionUtilities.FinYear.ToString().Trim()) + 1);
                dtFrom = Convert.ToDateTime(From, dtfi);
                dtTo = Convert.ToDateTime(To, dtfi);
                if (mDrvierSettlementDt >= dtFrom && mDrvierSettlementDt <= dtTo)
                    lblError.Text = "";
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Driver settlement date  should be  in the  range of selected  financial year!";
                }
            }
        }

        if (lblError.Text.Trim() == "")
        {
            if (mDrvierSettlementDt < mFinCloseDt)
            {
                lblError.Visible = true;
                lblError.Text = "Driver settlement date cannot be less than Financial close Date !";
            }
            if (mDrvierSettlementDt > mServerDt)
            {
                lblError.Visible = true;
                lblError.Text = "Driver settlement date cannot be greater than today's Date !";
            }

            if (mDrvierSettlementDt <= mCutOffDt)
            {
                lblError.Visible = true;
                lblError.Text = "Driver settlement date cannot be less than/equals to Cut off Date i.e. " + dtDriverSettlementDate.Rows[0][0].ToString() + " !";
            }
        }
        AmtPaidToDriver = txtPaidAmt.Text;
        if (AmtPaidToDriver == "")
            AmtPaidToDriver = "0";
        AmtRecvdFromDriver = txtReceivedAmt.Text;
        if (AmtRecvdFromDriver == "")
            AmtRecvdFromDriver = "0";
        if (txtPaidAmt.Enabled == false)
        {
            if (lblError.Text == "")
            {
                if (txtPaidAmt.Text == "")
                    lblError.Text = "Amount paid to driver can not be empty !!!";
            }
            if (lblError.Text == "")
            {
                if (Math.Abs(Convert.ToDouble(AmtPaidToDriver)) > Math.Abs(Convert.ToDouble(lblApprovedAmount.Text)))
                    lblError.Text = "Amount paid to driver can not be more than Net approved amount !!!";
            }
        }
        if (lblError.Text == "")
        {
            if (txtReceivedAmt.Enabled == false)
            {
                if (txtReceivedAmt.Text == "")
                    lblError.Text = "Amount received from driver can not be empty !!!";
                if (lblError.Text == "")
                {
                    if (Math.Abs(Convert.ToDouble(AmtRecvdFromDriver)) > Math.Abs(Convert.ToDouble(lblApprovedAmount.Text)))
                        lblError.Text = "Amount received from driver can not be more than Net approved amount !!!";
                }
            }
        }

        if (txtPaidAmt.Text != "" && Convert.ToDouble(AmtPaidToDriver) != 0)
        {
            UserControls_MyPaymentControlEXP paymen = (UserControls_MyPaymentControlEXP)UCMyPaymentControl1;
            DropDownList dlsttranstype = (DropDownList)paymen.FindControl("ddlPayMode");
            DropDownList ddrCashcode = (DropDownList)paymen.FindControl("ddrCashcode");
            DropDownList ddrBankaccode = (DropDownList)paymen.FindControl("ddrBankaccode");
            TextBox txtCashAmt = (TextBox)paymen.FindControl("txtCashAmt");
            TextBox txtChqAmt = (TextBox)paymen.FindControl("txtChqAmt");
            TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
            TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
            TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
            TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");

            if (dlsttranstype.SelectedValue.ToUpper() != "CASH" && dlsttranstype.SelectedValue.ToUpper() != "BANK")
                lblError.Text = "Please select Pay Mode !!!";

            if (dlsttranstype.SelectedValue.ToUpper() == "CASH")
            {
                if (ddrCashcode.SelectedValue == "" || ddrCashcode.SelectedValue == null)
                {
                    lblError.Text = "Please select Cash Code !!!";
                }
                if (txtCashAmt.Text == "")
                {
                    lblError.Text = "Please enter cash amount !!!";
                }

            }

            if (dlsttranstype.SelectedValue.ToUpper() == "BANK")
            {
                if (ddrBankaccode.SelectedValue == "" || ddrBankaccode.SelectedValue == null)
                {
                    lblError.Text = "Please select Bank Code !!!";
                }
                if (txtChqAmt.Text == "")
                {
                    lblError.Text = "Please enter cheque amount !!!";
                }
                if (txtChqDate.Text == "")
                {
                    lblError.Text = "Please enter cheque date !!!";
                }
            }


        }
        if (txtReceivedAmt.Text != "" && Convert.ToDouble(AmtRecvdFromDriver) != 0)
        {
            UserControls_MyReceiptControlDS receipt = (UserControls_MyReceiptControlDS)UCMyReceiptControl1;
            DropDownList dlsttranstype = (DropDownList)receipt.FindControl("ddlPayMode");
            DropDownList ddrCashcode = (DropDownList)receipt.FindControl("ddrCashcode");
            DropDownList ddrBankaccode = (DropDownList)receipt.FindControl("ddrBankaccode");
            TextBox txtCashAmt = (TextBox)receipt.FindControl("txtCashAmt");
            TextBox txtChqAmt = (TextBox)receipt.FindControl("txtChqAmt");
            TextBox txtChqNo = (TextBox)receipt.FindControl("txtChqNo");
            TextBox txtChqDate = (TextBox)receipt.FindControl("txtChqDate");
            TextBox txtAmtApplA = (TextBox)receipt.FindControl("txtAmtApplA");
            TextBox txtNetPay = (TextBox)receipt.FindControl("txtNetPay");


            if (dlsttranstype.SelectedValue.ToUpper() != "CASH" && dlsttranstype.SelectedValue.ToUpper() != "BANK")
                lblError.Text = "Please select Pay Mode !!!";

            if (dlsttranstype.SelectedValue.ToUpper() == "CASH")
            {
                if (ddrCashcode.SelectedValue == "" || ddrCashcode.SelectedValue == null)
                {
                    lblError.Text = "Please select Cash Code !!!";
                }
                if (txtCashAmt.Text == "")
                {
                    lblError.Text = "Please enter cash amount !!!";
                }

            }

            if (dlsttranstype.SelectedValue.ToUpper() == "BANK")
            {
                if (ddrBankaccode.SelectedValue == "" || ddrBankaccode.SelectedValue == null)
                {
                    lblError.Text = "Please select Bank Code !!!";
                }
                if (txtChqAmt.Text == "")
                {
                    lblError.Text = "Please enter cheque amount !!!";
                }
                if (txtChqDate.Text == "")
                {
                    lblError.Text = "Please enter cheque date !!!";
                }
            }

        }

        //if (lblError.Text == "")
        //{
        //    if (Convert.ToDouble(LblNetBalance.Text) != 0)
        //        lblError.Text = "Trip Sheet net balance should be always ZERO !!!";
        //}
        if (lblError.Text == "")
        {
            string mTripSheetNo = "";
            mTripSheetNo = lblTripsheetNo.Text;
            string mdlsttranstype = "";
            string mddrCashcode = "";
            string mddrBankaccode = "";
            string mtxtCashAmt = "";
            string mtxtChqAmt = "";
            string mtxtChqNo = "";
            string mtxtChqDate = "";
            string mtxtAmtApplA = "";
            string mtxtNetPay = "";
            string mtxtRecBank = "";
            string mrdDiposited = "";
            if (txtPaidAmt.Text != "" && Convert.ToDouble(AmtPaidToDriver) != 0)
            {
                UserControls_MyPaymentControlEXP paymen = (UserControls_MyPaymentControlEXP)UCMyPaymentControl1;
                DropDownList dlsttranstype = (DropDownList)paymen.FindControl("ddlPayMode");
                DropDownList ddrCashcode = (DropDownList)paymen.FindControl("ddrCashcode");
                DropDownList ddrBankaccode = (DropDownList)paymen.FindControl("ddrBankaccode");
                TextBox txtCashAmt = (TextBox)paymen.FindControl("txtCashAmt");
                TextBox txtChqAmt = (TextBox)paymen.FindControl("txtChqAmt");
                TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
                TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
                TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");
                mdlsttranstype = dlsttranstype.SelectedValue;
                if (mdlsttranstype == "" || mdlsttranstype == null)
                    mdlsttranstype = "NULL";
                else
                    mdlsttranstype = "'" + mdlsttranstype + "'";
                mddrCashcode = ddrCashcode.SelectedValue;
                if (mddrCashcode == "" || mddrCashcode == null)
                    mddrCashcode = "NULL";
                else
                    mddrCashcode = "'" + mddrCashcode + "'";
                mddrBankaccode = ddrBankaccode.SelectedValue;
                if (mddrBankaccode == "" || mddrBankaccode == null)
                    mddrBankaccode = "NULL";
                else
                    mddrBankaccode = "'" + mddrBankaccode + "'";
                if (dlsttranstype.SelectedValue == "Cash")
                    mtxtCashAmt = txtPaidAmt.Text;// txtCashAmt.Text;
                else if (dlsttranstype.SelectedValue == "Both")
                    mtxtCashAmt = txtCashAmt.Text;// txtCashAmt.Text;
                else
                    mtxtCashAmt = "";
                if (mtxtCashAmt == "" || mtxtCashAmt == null)
                    mtxtCashAmt = "NULL";
                if (dlsttranstype.SelectedValue == "Bank")
                    mtxtChqAmt = txtPaidAmt.Text;
                else if (dlsttranstype.SelectedValue == "Both")
                    mtxtChqAmt = txtChqAmt.Text;
                else
                    mtxtChqAmt = "";
                if (mtxtChqAmt == "" || mtxtChqAmt == null)
                    mtxtChqAmt = "NULL";
                mtxtChqNo = txtChqNo.Text;
                if (mtxtChqNo == "" || mtxtChqNo == null)
                    mtxtChqNo = "NULL";
                else
                    mtxtChqNo = "'" + mtxtChqNo + "'";
                mtxtChqDate = txtChqDate.Text;
                if (mtxtChqDate == "" || mtxtChqDate == null)
                    mtxtChqDate = "NULL";
                else
                    mtxtChqDate = "'" + mtxtChqDate + "'";
                mtxtAmtApplA = txtAmtApplA.Text;
                if (mtxtAmtApplA == "" || mtxtAmtApplA == null)
                    mtxtAmtApplA = "NULL";
                mtxtNetPay = txtNetPay.Text;
                if (mtxtNetPay == "" || mtxtNetPay == null)
                    mtxtNetPay = "NULL";
                if (mtxtRecBank == "" || mtxtRecBank == null)
                    mtxtRecBank = "NULL";
                else
                    mtxtRecBank = "'" + mtxtRecBank + "'";
                if (mrdDiposited == "" || mrdDiposited == null)
                    mrdDiposited = "NULL";
                else
                    mrdDiposited = "'" + mrdDiposited + "'";
            }
            if (txtReceivedAmt.Text != "" && Convert.ToDouble(AmtRecvdFromDriver) != 0)
            {
                UserControls_MyReceiptControlDS receipt = (UserControls_MyReceiptControlDS)UCMyReceiptControl1;
                DropDownList dlsttranstype = (DropDownList)receipt.FindControl("ddlPayMode");
                DropDownList ddrCashcode = (DropDownList)receipt.FindControl("ddrCashcode");
                DropDownList ddrBankaccode = (DropDownList)receipt.FindControl("ddrBankaccode");
                TextBox txtCashAmt = (TextBox)receipt.FindControl("txtCashAmt");
                TextBox txtChqAmt = (TextBox)receipt.FindControl("txtChqAmt");
                TextBox txtChqNo = (TextBox)receipt.FindControl("txtChqNo");
                TextBox txtChqDate = (TextBox)receipt.FindControl("txtChqDate");
                TextBox txtAmtApplA = (TextBox)receipt.FindControl("txtAmtApplA");
                TextBox txtNetPay = (TextBox)receipt.FindControl("txtNetPay");
                TextBox txtRecBank = (TextBox)receipt.FindControl("txtRecBank");
                RadioButtonList rdDiposited = (RadioButtonList)receipt.FindControl("rdDiposited");
                mdlsttranstype = dlsttranstype.SelectedValue;
                if (mdlsttranstype == "" || mdlsttranstype == null)
                    mdlsttranstype = "NULL";
                else
                    mdlsttranstype = "'" + mdlsttranstype + "'";
                mddrCashcode = ddrCashcode.SelectedValue;
                if (mddrCashcode == "" || mddrCashcode == null)
                    mddrCashcode = "NULL";
                else
                    mddrCashcode = "'" + mddrCashcode + "'";
                mddrBankaccode = ddrBankaccode.SelectedValue;
                if (mddrBankaccode == "" || mddrBankaccode == null)
                    mddrBankaccode = "NULL";
                else
                    mddrBankaccode = "'" + mddrBankaccode + "'";
                if (dlsttranstype.SelectedValue == "Cash")
                    mtxtCashAmt = txtReceivedAmt.Text;
                else if (dlsttranstype.SelectedValue == "Both")
                    mtxtCashAmt = txtCashAmt.Text;
                else
                    mtxtCashAmt = "";
                if (mtxtCashAmt == "" || mtxtCashAmt == null)
                    mtxtCashAmt = "NULL";
                if (dlsttranstype.SelectedValue == "Bank")
                    mtxtChqAmt = txtReceivedAmt.Text;
                else if (dlsttranstype.SelectedValue == "Both")
                    mtxtChqAmt = txtChqAmt.Text;
                else
                    mtxtChqAmt = "";
                if (mtxtChqAmt == "" || mtxtChqAmt == null)
                    mtxtChqAmt = "NULL";
                mtxtChqNo = txtChqNo.Text;
                if (mtxtChqNo == "" || mtxtChqNo == null)
                    mtxtChqNo = "NULL";
                else
                    mtxtChqNo = "'" + mtxtChqNo + "'";
                mtxtChqDate = txtChqDate.Text;
                if (mtxtChqDate == "" || mtxtChqDate == null)
                    mtxtChqDate = "NULL";
                else
                    mtxtChqDate = "'" + mtxtChqDate + "'";
                mtxtAmtApplA = txtAmtApplA.Text;
                if (mtxtAmtApplA == "" || mtxtAmtApplA == null)
                    mtxtAmtApplA = "NULL";
                mtxtNetPay = txtNetPay.Text;
                if (mtxtNetPay == "" || mtxtNetPay == null)
                    mtxtNetPay = "NULL";
                mtxtRecBank = txtRecBank.Text;
                if (mtxtRecBank == "" || mtxtRecBank == null)
                    mtxtRecBank = "NULL";
                else
                    mtxtRecBank = "'" + mtxtRecBank + "'";
                mrdDiposited = rdDiposited.SelectedValue;
                if (mrdDiposited == "" || mrdDiposited == null)
                    mrdDiposited = "NULL";
                else
                    mrdDiposited = "'" + mrdDiposited + "'";
            }
            if (AmtPaidToDriver == "0" && AmtRecvdFromDriver == "0")
            {
                mdlsttranstype = "NULL";
                mddrCashcode = "NULL";
                mddrBankaccode = "NULL";
                mtxtCashAmt = "NULL";
                mtxtChqAmt = "NULL";
                mtxtChqNo = "NULL";
                mtxtChqDate = "NULL";
                mtxtAmtApplA = "NULL";
                mtxtNetPay = "NULL";
                mtxtRecBank = "NULL";
                mrdDiposited = "NULL";
            }
            string mEntryby = "'" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "'";
            string sqlstr = "";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {
                sqlstr = "Insert into Webx_Fleet_DriverSettlement (TripSheetNo,SettleDate,TotAdvPaid,TotExpense,DieselExp_Card,DieselExp_Credit,NetAmount,AmtPaidToDriver,AmtRecvdFromDriver,BalanceToDriverLedger,Paymode,CashAccCode,BankAccCode,CashAmt,ChequeAmt,ChequeNo,ChequeDate,BankName,Deposit_YN,EntryBy,ActBalanceToDriverLedger) values ("
                    + "'" + mTripSheetNo + "','" + mDrvierSettlementDt + "'," + lblDriverAdvance.Text + "," + lblApprovedAmount.Text + ",0,0," + Math.Abs(Convert.ToDouble(lblDriverAdvance.Text) - Convert.ToDouble(lblApprovedAmount.Text)).ToString() + "," + AmtPaidToDriver + "," + AmtRecvdFromDriver + "," + txtBalToDriverLedger.Text + ","
                    + mdlsttranstype + "," + mddrCashcode + "," + mddrBankaccode + "," + mtxtCashAmt + "," + mtxtChqAmt + "," + mtxtChqNo + "," + mtxtChqDate + "," + mtxtRecBank + "," + mrdDiposited + "," + mEntryby + "," + Session["ActBalToDriverLedger"] + ")";
                SqlCommand DScmd = new SqlCommand(sqlstr, conn, trans);
                DScmd.CommandType = CommandType.Text;
                DScmd.ExecuteNonQuery();
                string sql = "Update webx_fleet_vehicle_issue set DriverSettleDt ='" + mDrvierSettlementDt + "' Where VSlipNo='" + mTripSheetNo + "'";
                SqlCommand cmd = new SqlCommand(sql, conn, trans);
                cmd.CommandType = CommandType.Text;
                cmd.ExecuteNonQuery();
                //////----------------- FLEET TRANSACTION -----------------------------------
                string mFinYear = "";
                string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
                SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, conn, trans);
                sqlcmdFinYear.CommandType = CommandType.Text;
                SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
                if (drFinYear.Read())
                {
                    mFinYear = drFinYear["YearVal"].ToString().Trim();
                }
                drFinYear.Close();
                string mYearVal = "";
                GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                mYearVal = objFinYear.FinancialYear();
                string expacc_entry = "N";
                //--------------Trip(Driver) settlement-------------------------
                string sqlAcc = "usp_FleetTransaction";
                SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = hidEndLoc.Value;
                sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "6";
                sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                sqlcmdAcc.ExecuteNonQuery();
                //----------------------------------------------------------------
                trans.Commit();
                //trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                trans.Rollback();
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                Response.End();
            }
            finally
            {
                conn.Close();
                Session["ActBalToDriverLedger"] = null;
            }
            if (success)
            {
                conn.Close();
                Session["ActBalToDriverLedger"] = null;
                Response.Redirect("frmDriverSettlement_result.aspx?VSlipId=" + mTripSheetNo.ToString(), true);
            }
        }
    }


    protected void btnAutoSettlement_Click(object sender, EventArgs e)
    {
        lblError.Text = "";

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime mDrvierSettlementDt = new DateTime();
        string strDriverSettleDt = "";
        SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn1.Open();
        string ctr = "select  DriverSettleDt from WEBX_FLEET_VEHICLE_ISSUE where VslipNo='" + lblTripsheetNo.Text + "'";
        SqlCommand cdR = new SqlCommand(ctr, conn1);
        SqlDataReader cdDR = cdR.ExecuteReader();
        if (cdDR.HasRows)
        {
            while (cdDR.Read())
            {
                strDriverSettleDt = Convert.ToString(cdDR["DriverSettleDt"]);
            }
        }
        cdDR.Close();
        conn1.Close();
        if (strDriverSettleDt != "" && strDriverSettleDt != null)
        {
            lblError.Visible = true;
            lblError.Text = "Sorry!!! You have already submitted the data for this tripsheet.\n\nRe-submisssion is not allowed.";
        }
        if (txtSettlementDate.Text == "")
        {
            if (lblError.Text == "")
                lblError.Text = "Driver settlement date should not be empty !!!";
        }
        if (lblError.Text == "")
            mDrvierSettlementDt = Convert.ToDateTime(txtSettlementDate.Text.ToString(), dtfi);
        DateTime mServerDt = DateTime.Now;
        DateTime mFinCloseDt = new DateTime();
        mFinCloseDt = Convert.ToDateTime(lblFinancialClosureDate.Text.ToString());
        DateTime mCutOffDt = new DateTime();
        DataTable dtDriverSettlementDate = new DataTable();
        cls_DriverSettlementDate objDsdt = new cls_DriverSettlementDate(Session["SqlProvider"].ToString().Trim());

        if (lblError.Text == "")
        {
            {
                DateTime dtFrom = new DateTime();
                DateTime dtTo = new DateTime();
                string From = "", To = "";
                From = "01/04/" + SessionUtilities.FinYear.ToString().Trim();
                To = "31/03/" + Convert.ToDouble(Convert.ToDouble(SessionUtilities.FinYear.ToString().Trim()) + 1);
                dtFrom = Convert.ToDateTime(From, dtfi);
                dtTo = Convert.ToDateTime(To, dtfi);
                if (mDrvierSettlementDt >= dtFrom && mDrvierSettlementDt <= dtTo)
                    lblError.Text = "";
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Driver settlement date  should be  in the  range of selected  financial year!";
                }
            }
        }

        if (lblError.Text.Trim() == "")
        {
            if (mDrvierSettlementDt < mFinCloseDt)
            {
                lblError.Visible = true;
                lblError.Text = "Driver settlement date cannot be less than Financial close Date !";
            }
            if (mDrvierSettlementDt > mServerDt)
            {
                lblError.Visible = true;
                lblError.Text = "Driver settlement date cannot be greater than today's Date !";
            }

            if (mDrvierSettlementDt <= mCutOffDt)
            {
                lblError.Visible = true;
                lblError.Text = "Driver settlement date cannot be less than/equals to Cut off Date i.e. " + dtDriverSettlementDate.Rows[0][0].ToString() + " !";
            }
        }

        try
        {
            var obj = new DriverSettlementController();
            obj.AutoDriverSettlement(lblTripsheetNo.Text, mDrvierSettlementDt);
            Response.Redirect("frmDriverSettlement_result.aspx?VSlipId=" + lblTripsheetNo.Text, true);
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + ex.Message.Replace('\n', '_'));
        }


    }
}
