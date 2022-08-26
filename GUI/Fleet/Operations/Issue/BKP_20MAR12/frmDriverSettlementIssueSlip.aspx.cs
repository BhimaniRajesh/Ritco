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

public partial class GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlip : System.Web.UI.Page
{
    private double sum = 0;
    
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;

    
    string stVSlipId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        

        string vv = "javascript:return validcheck()";
        cmdSubmit.Attributes.Add("onClick", vv);


        if (!IsPostBack)
        {
            Session["ActBalToDriverLedger"] = null;
            conn.Open();
            stVSlipId = Request.QueryString["id"];


            Session["Tripsheet"] = null;

            Session["Tripsheet"] = stVSlipId;

            //string sql = "select V.VSlipNo,Convert(varchar,VSlipDt,103) VSlipDt,Convert(varchar,V.End_dt_tm,103) as FinCloseDt,V.Vehicleno as vehno,f_issue_startkm as Start_km,f_issue_fill "
            //         + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "
            //         + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
            //         + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt,v.driver1,v.CustCode,v.Category,v.Market_Own ,Tripsheet_StartLoc,Tripsheet_EndLoc ,(Select custnm  from webx_CUSTHDR  where custcd=v.CustCode) as Custname "
            //         + " from WEBX_FLEET_VEHICLE_ISSUE v,webx_fleet_vehicle_request r "
            //         + " where 1=1 and V.VSlipNo*=r.VSlipId"
            //         + " and V.VSlipNo='" + stVSlipId + "'";
            string sql = "SELECT v.VSlipNo, CONVERT(varchar, v.VSlipDt, 103) AS VSlipDt, CONVERT(varchar, v.End_dt_tm, 103) AS FinCloseDt, v.VehicleNo AS vehno, v.f_issue_startkm AS Start_km, v.f_issue_fill,"
                         + " (SELECT Driver_Name FROM WEBX_FLEET_DRIVERMST WHERE (Driver_Id = v.Driver1)) AS driver_name,"
                         + " (SELECT License_No FROM WEBX_FLEET_DRIVERMST WHERE (Driver_Id = v.Driver1)) AS License_no,"
                         + " (SELECT CONVERT(varchar, Valdity_dt, 106) AS valdity_dt FROM WEBX_FLEET_DRIVERMST WHERE (Driver_Id = v.Driver1)) AS valdity_dt, v.Driver1, v.Custcode, v.Category, v.Market_Own, v.TripSheet_StartLoc, v.TripSheet_EndLoc,"
                         + " (SELECT CUSTNM FROM webx_CUSTHDR WHERE (CUSTCD = v.Custcode)) AS Custname,"
                         + " (Select Top 1 Convert(VarChar,AdvDate,103) from WEBX_TRIPSHEET_ADVEXP Where TripSheetNo = '" + stVSlipId + "' Order By EntryDt Desc) As AdvDate "
						 + " FROM WEBX_FLEET_VEHICLE_ISSUE AS v LEFT OUTER JOIN	WEBX_FLEET_VEHICLE_REQUEST AS r ON v.VSlipNo = r.VSlipId"
                         + " WHERE (1 = 1) AND (v.VSlipNo = '" + stVSlipId + "')";


            SqlCommand cmdVI = new SqlCommand(sql, conn);
            cmdVI.CommandType = CommandType.Text;
            SqlDataReader dataReadVI = cmdVI.ExecuteReader();
            while (dataReadVI.Read())
            {
                lblIssueNo.Text = dataReadVI["VSlipNo"].ToString();
                lblIssueDt.Text = dataReadVI["VSlipDt"].ToString();
                lblVehno.Text = dataReadVI["Vehno"].ToString();
                lblDriverName.Text = dataReadVI["driver_name"].ToString();
                Session["strDriverCode"] = dataReadVI["driver1"].ToString();

                lblLicno.Text = dataReadVI["License_no"].ToString();
                lblValidDt.Text = dataReadVI["valdity_dt"].ToString();
                //   lblStartKm.Text = dataReadVI["Start_km"].ToString();
                // lblFuelFilled.Text = dataReadVI["f_issue_fill"].ToString();

                lblStartLoc.Text = dataReadVI["Tripsheet_StartLoc"].ToString();

                lblEndLoc.Text = dataReadVI["Tripsheet_EndLoc"].ToString();

                lblCategory.Text = dataReadVI["Category"].ToString();
                if (dataReadVI["Category"].ToString().Trim() == "External Usage")
                {
                    lblCustCodeHead.Visible = true;

                    lblCustcodeMarket.Text = dataReadVI["CustCode"].ToString() + "/" + dataReadVI["Custname"].ToString();
                }

                if (dataReadVI["Category"].ToString().Trim() == "Internal Usage")
                {
                    lblMarketHead.Visible = true;
                    lblCustcodeMarket.Text = dataReadVI["Market_Own"].ToString();
                }

                lblFinCloseDt.Text = dataReadVI["FinCloseDt"].ToString();
                hfAdvDate.Value = dataReadVI["AdvDate"].ToString();
            }
            dataReadVI.Close();

            RetrieveExpense();
             //onblur="javascript:"
            TripSheet objTs = new TripSheet(Session["SqlProvider"].ToString());
            objTs.CheckTripRule();
            if (objTs.DriverSettlmt_DateRule_2Days == "Y")
            {
                txtSettleDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'03','../../../images/Fleet_Date_Control_Rule_Check.aspx')");
            }
            else
            {
                txtSettleDate.Attributes.Add("onblur", "javascript:ValidateDate(this);");
            }
            if (objTs.DriverSettlmt_DateRule_Equals_CloseDate == "Y")
            {
                txtSettleDate.Attributes.Add("onblur", "javascript:ValidateDate(this);CheckDsDateGreaterCloseDate();");

                //txtSettleDate.Text = lblFinCloseDt.Text;
                //txtSettleDate.ReadOnly = true;
            }
            if (objTs.DriverSettlmt_DateRule_Equals_LastAdvanceDate == "Y")
            {
                txtSettleDate.Attributes.Add("onblur", "javascript:ValidateDate(this);CheckDsDateGreaterLastAdvDate();");
                //txtSettleDate.Text = hfAdvDate.Value;
                //txtSettleDate.ReadOnly = true;
            }
        }
    }

    public void RetrieveExpense()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string Amt = "", ExeAmt = "";
        string sqlstr = "";

        LblTotAdvancePaid.Text="0.00";
        LblTotAdvancePaidAppr.Text = "0.00";

        LblTotDieselCashExp.Text = "0.00";
        LblTotDieselCashExpAppr.Text = "0.00";
        LblTotDieselCardExp.Text = "0.00";
        LblTotDieselCardExpAppr.Text = "0.00";
        LblTotDieselCreditExp.Text = "0.00";
        LblTotDieselCreditExpAppr.Text = "0.00";


        LblTotRepairExp.Text = "0.00";
        LblTotRepairExpAppr.Text = "0.00";

        LblTotSpareExp.Text = "0.00";
        LblTotSpareExpAppr.Text = "0.00";

        LblTotIncDedExp.Text = "0.00";
        LblTotIncDedExpAppr.Text = "0.00";

        LblTotClaimExp.Text = "0.00";
        LblTotClaimExpAppr.Text = "0.00";

        LblTotEnrouteExp.Text = "0.00";
        LblTotEnrouteExpAppr.Text = "0.00";

        double TotAdvAmt = 0;
        double TotAdvAmtAppr = 0;
        double TotExpAmt = 0;
        double TotExpAmtAppr = 0;
        double TotNetExpAmt = 0;
        double TotNetExpAmtAppr = 0;

        //Advance Expense
        sqlstr = "select  ISNULL(sum(Convert(numeric(18,2),AdvAmt)),0) as AdvAmt  from WEBX_TRIPSHEET_ADVEXP  where TripsheetNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["AdvAmt"]);
                ExeAmt = Amt;
                TotAdvAmt = Convert.ToDouble(Amt.ToString());
                TotAdvAmtAppr = Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotAdvancePaid.Text = Amt;
        LblTotAdvancePaidAppr.Text = ExeAmt;



        //Fuel Expense
        string Card_Cash = "";
        sqlstr = "select  Card_Cash,Sum(Convert(numeric(18,2),Amount)) as Amount,Sum(Convert(numeric(18,2),EXE_AMT)) as EXE_AMT  from WEBX_TRIPSHEET_OILEXPDET  where TripsheetNo='" + Session["Tripsheet"].ToString().Trim() + "' group by TripSheetNo,Card_Cash";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Card_Cash = dr["Card_Cash"].ToString();
                Amt = Convert.ToString(dr["Amount"]);
                ExeAmt = Convert.ToString(dr["EXE_AMT"]);
                if (Card_Cash == "Cash")
                {
                    LblTotDieselCashExp.Text = Amt;
                    LblTotDieselCashExpAppr.Text = ExeAmt;

                    TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                    TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());

                }
                else if (Card_Cash == "Diesel Card")
                {
                    LblTotDieselCardExp.Text = Amt;
                    LblTotDieselCardExpAppr.Text = ExeAmt;
                }
                else if (Card_Cash == "Credit Card" || Card_Cash == "Credit")
                {
                    LblTotDieselCreditExp.Text = Amt;
                    LblTotDieselCreditExpAppr.Text = ExeAmt;
                }
            }
        }
        dr.Close();


        //Repair Expense
        sqlstr = "select  ISNULL(Sum(Convert(numeric(18,2),Amt)),0) as Amt   from WEBX_TRIPSHEET_REPAIREXP  where TripsheetNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["Amt"]);
                ExeAmt = Amt;
                TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotRepairExp.Text = Amt;
        LblTotRepairExpAppr.Text = ExeAmt;




        //Spare Expense
        sqlstr = "select  ISNULL(Sum(Convert(numeric(18,2),Amt)),0) as Amt   from WEBX_FLEET_VEHICLE_ISSUE_PARTDET  where VSlipNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["Amt"]);
                ExeAmt = Amt;

                TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotSpareExp.Text = Amt;
        LblTotSpareExpAppr.Text = ExeAmt;



        //Incidental Expense
        sqlstr = "select  ISNULL(Sum(Convert(numeric(18,2),Amt)),0) as Amt   from WEBX_TRIPSHEET_INCDED  where TripSheetNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["Amt"]);
                ExeAmt = Amt;
                TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotIncDedExp.Text = Amt;
        LblTotIncDedExpAppr.Text = ExeAmt;



        //Claims Expense
        sqlstr = "select  ISNULL(Sum(Convert(numeric(18,2),Approx_Value)),0) as Approx_Value   from WEBX_TRIPSHEET_CLAIMS  where TripsheetId='" + Session["Tripsheet"].ToString().Trim() + "' ";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["Approx_Value"]);
                ExeAmt = Amt;

                TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotClaimExp.Text = Amt;
        LblTotClaimExpAppr.Text = ExeAmt;



        //Enroute Expense
        sqlstr = "select  isnull(sum(convert(numeric(18,2),isnull(polarity,'+')  +  convert(varchar,Amount_Spent))),0) as Amount_Spent,isnull(sum(convert(numeric(18,2),isnull(polarity,'+')  +  convert(varchar,Exe_Appr_Amt))),0) as Exe_Appr_Amt  from WEBX_FLEET_ENROUTE_EXP  where TripsheetNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["Amount_Spent"]);
                ExeAmt = Amt;// Convert.ToString(dr["Exe_Appr_Amt"]);

                TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotEnrouteExp.Text = Amt;
        LblTotEnrouteExpAppr.Text = "(" +  ExeAmt + ")";
        LblTotEnrouteExpAppr.ForeColor = System.Drawing.Color.Red;

        LblTotExpense.Text = TotExpAmt.ToString();
        LblTotExpenseAppr.Text = TotExpAmtAppr.ToString();

        /*LblTotDieselCardExp.Text = Amt;
        LblTotDieselCardExpAppr.Text = ExeAmt;
        LblTotDieselCreditExp.Text = Amt;
        LblTotDieselCreditExpAppr.Text = ExeAmt;*/



        TotNetExpAmt = TotAdvAmt - TotExpAmt;// +(Convert.ToDouble(LblTotDieselCardExp.Text) + Convert.ToDouble(LblTotDieselCreditExp.Text));
        TotNetExpAmtAppr = TotAdvAmtAppr - TotExpAmtAppr;// +(Convert.ToDouble(LblTotDieselCardExpAppr.Text) + Convert.ToDouble(LblTotDieselCreditExpAppr.Text));

        LblNetExpAmt.Text = TotNetExpAmt.ToString();
        LblNetExpAmtAppr.Text = TotNetExpAmtAppr.ToString();


        
        string AmtPaidToDriver = "";
        string AmtRecvdFromDriver = "";
       
        

        AmtPaidToDriver = txtAmtPaidToDriver.Text;
        if (AmtPaidToDriver == "")
        {
            AmtPaidToDriver = "0";
        }

        AmtRecvdFromDriver = txtAmtRecvdFromDriver.Text;
        if (AmtRecvdFromDriver == "")
        {
            AmtRecvdFromDriver = "0";
        }

        if (TotNetExpAmt == 0)
        {
            //txtAmtPaidToDriver.BackColor = System.Drawing.Color.LightSkyBlue;
            txtAmtRecvdFromDriver.ReadOnly = true;
            txtAmtRecvdFromDriver.Text = "0";
            UpdatePanePayment.Visible = false;
            UpdatePaneReceipt.Visible = false;
        }
        else if (TotNetExpAmt < 0)
        {
            txtAmtPaidToDriver.BackColor = System.Drawing.Color.LightSkyBlue;
            txtAmtRecvdFromDriver.ReadOnly = true;
            UpdatePanePayment.Visible = true;
            UpdatePaneReceipt.Visible = false;

            //UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
            //DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
            //TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
            //TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
            //TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
            //string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ")";
            //cmdSubmit.Attributes.Add("onClick", aa);
            //NetBalance = TotAdvAmtAppr - (TotExpAmt - Convert.ToDouble(AmtRecvdFromDriver) + Convert.ToDouble(BalToDriverLedger) - (Convert.ToDouble(LblTotDieselCardExp.Text) + Convert.ToDouble(LblTotDieselCreditExp.Text)));
        }

        if (TotNetExpAmt == 0)
        {
            //txtAmtRecvdFromDriver.BackColor = System.Drawing.Color.LightSkyBlue;
            txtAmtPaidToDriver.ReadOnly = true;
            txtAmtPaidToDriver.Text = "0";
            UpdatePanePayment.Visible = false;
            UpdatePaneReceipt.Visible = false;
        }
        else if (TotNetExpAmt > 0)
        {
            txtAmtRecvdFromDriver.BackColor = System.Drawing.Color.LightSkyBlue;
            txtAmtPaidToDriver.ReadOnly = true;
            UpdatePanePayment.Visible = false;
            UpdatePaneReceipt.Visible = true;


            //UserControls_ReceiptControl receipt = (UserControls_ReceiptControl)UCReceipt;
            //DropDownList dlsttranstype = (DropDownList)receipt.FindControl("dlstTransType");
            //TextBox txtChqNo = (TextBox)receipt.FindControl("txtChqNo");
            //TextBox txtChqDate = (TextBox)receipt.FindControl("txtChqDate");
            //TextBox txtAmount = (TextBox)receipt.FindControl("txtAmount");
            //string aa = "javascript:return validrec(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ")";
            //cmdSubmit.Attributes.Add("onClick", aa);
            //NetBalance = TotAdvAmtAppr - (TotExpAmt + Convert.ToDouble(AmtRecvdFromDriver) + Convert.ToDouble(BalToDriverLedger) - (Convert.ToDouble(LblTotDieselCardExp.Text) + Convert.ToDouble(LblTotDieselCreditExp.Text)));

        }

	if (txtAmtPaidToDriver.Text == "0" && txtAmtRecvdFromDriver.Text == "0")
        {
            txtBalToDriverLedger.Text = "0";
			LblNetBalance.Text ="0";
			Session["ActBalToDriverLedger"] = "0";
        }

        //LblNetBalance.Text = Convert.ToString(NetBalance);
        conn.Close();



    
    
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }
    
    protected void Payment_Receipt(object sender, EventArgs e)
    {
        //UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        //TextBox txtPayAmount = (TextBox)paymen.FindControl("txtAmount");

        //UserControls_ReceiptControl receipt = (UserControls_ReceiptControl)UCReceipt;
        //TextBox txtRecAmount = (TextBox)receipt.FindControl("txtAmount");

        double BalToDriverLedger = 0;
        double NetBalance = 0;
        string NetExpAmtAppr = "";
        string AmtPaidToDriver = "";
        string AmtRecvdFromDriver = "";
        string BalToDriverLedgerVal = "";
        NetExpAmtAppr = LblNetExpAmtAppr.Text;

        AmtPaidToDriver = txtAmtPaidToDriver.Text;
        if (AmtPaidToDriver == "")
        {
            AmtPaidToDriver = "0";
        }

        AmtRecvdFromDriver = txtAmtRecvdFromDriver.Text;
        if (AmtRecvdFromDriver == "")
        {
            AmtRecvdFromDriver = "0";
        }

        BalToDriverLedger = Convert.ToDouble(NetExpAmtAppr) + Convert.ToDouble(AmtPaidToDriver) - Convert.ToDouble(AmtRecvdFromDriver);
        if (BalToDriverLedger < 0)
        {
            LblDriverLedger.Text = "Trip Sheet balance to driver ledger (CR)";
        }
        else
        {
            LblDriverLedger.Text = "Trip Sheet balance to driver ledger (DR)";
        }

        Session["ActBalToDriverLedger"] = BalToDriverLedger;

        txtBalToDriverLedger.Text = Convert.ToString(Math.Abs(BalToDriverLedger));
        BalToDriverLedgerVal = BalToDriverLedger.ToString();
        if (Convert.ToDouble(AmtRecvdFromDriver) == 0 || Convert.ToDouble(AmtPaidToDriver) == 0)
        {
            UpdatePaneReceipt.Visible = false;
            UpdatePanePayment.Visible = false;
        }


        lblError.Text = "";
        if (Convert.ToDouble(AmtPaidToDriver) < 0)
        {
            lblError.Text = "Amount paid to driver can not be negative !!!";
        }


        if (Convert.ToDouble(AmtRecvdFromDriver) < 0)
        {
            lblError.Text = "Amount received from driver can not be negative !!!";
        }

        if (Convert.ToDouble(AmtPaidToDriver) > 0)
        {
            UpdatePanePayment.Visible = true;
            UpdatePaneReceipt.Visible = false;
            //txtPayAmount.Text = AmtPaidToDriver;// txtBalToDriverLedger.Text;
        }
        if (Convert.ToDouble(AmtRecvdFromDriver) > 0)
        {
            UpdatePaneReceipt.Visible = true;
            UpdatePanePayment.Visible = false;
            //txtRecAmount.Text = AmtRecvdFromDriver;// txtBalToDriverLedger.Text;
        }


        
        //BalToDriverLedgerVal = txtBalToDriverLedger.Text;
        if (BalToDriverLedgerVal == "")
        {
            BalToDriverLedgerVal = "0";
        }

        if (Convert.ToDouble(LblNetExpAmtAppr.Text) < 0)
        {
            //NetBalance = Convert.ToDouble(LblTotAdvancePaidAppr.Text) - (Convert.ToDouble(LblTotExpenseAppr.Text) - Convert.ToDouble(AmtPaidToDriver) + Convert.ToDouble(BalToDriverLedgerVal)) ;//- (Convert.ToDouble(LblTotDieselCardExpAppr.Text) + Convert.ToDouble(LblTotDieselCreditExpAppr.Text)));
            NetBalance = System.Math.Round(Convert.ToDouble(LblTotAdvancePaidAppr.Text),2) - System.Math.Round(Convert.ToDouble(LblTotExpenseAppr.Text) - Convert.ToDouble(AmtPaidToDriver) + Convert.ToDouble(BalToDriverLedgerVal),2);
            
        }
        if (Convert.ToDouble(LblNetExpAmtAppr.Text) > 0)
        {
            //NetBalance = Convert.ToDouble(LblTotAdvancePaidAppr.Text) - (Convert.ToDouble(LblTotExpenseAppr.Text) + Convert.ToDouble(AmtRecvdFromDriver) + Convert.ToDouble(BalToDriverLedgerVal));// - (Convert.ToDouble(LblTotDieselCardExpAppr.Text) + Convert.ToDouble(LblTotDieselCreditExpAppr.Text)));
            NetBalance = System.Math.Round(Convert.ToDouble(LblTotAdvancePaidAppr.Text),2) - System.Math.Round(Convert.ToDouble(LblTotExpenseAppr.Text) + Convert.ToDouble(AmtRecvdFromDriver) + Convert.ToDouble(BalToDriverLedgerVal),2);
        }
        NetBalance = Math.Round(NetBalance, 2);
        LblNetBalance.Text = Convert.ToString(NetBalance);



        if (txtAmtPaidToDriver.Text != "")
        {
            UserControls_MyPaymentControlEXP paymen = (UserControls_MyPaymentControlEXP)UCMyPaymentControl1;
            TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
            TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");
            txtAmtApplA.Text = txtAmtPaidToDriver.Text;
            txtNetPay.Text = txtAmtPaidToDriver.Text;
        }
        if (txtAmtRecvdFromDriver.Text != "")
        {
            UserControls_MyReceiptControlDS receipt = (UserControls_MyReceiptControlDS)UCMyReceiptControl1;
            TextBox txtAmtApplA = (TextBox)receipt.FindControl("txtAmtApplA");
            TextBox txtNetPay = (TextBox)receipt.FindControl("txtNetPay");
            txtAmtApplA.Text = txtAmtRecvdFromDriver.Text;
            txtNetPay.Text = txtAmtRecvdFromDriver.Text;
        }
       
        
    }


    protected void cmdSubmit_Click(object sender, EventArgs e)
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
        string ctr = "select  DriverSettleDt from WEBX_FLEET_VEHICLE_ISSUE where VslipNo='" + lblIssueNo.Text + "'";
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





        //if (txtDateFrom.CalendarDate.Trim() == "")
        if (txtSettleDate.Text == "")
        
        {
            if (lblError.Text == "")
            {
                  lblError.Text = "Driver settlement date should not be empty !!!";
            }
        }

        if (lblError.Text == "")
        {
            mDrvierSettlementDt = Convert.ToDateTime(txtSettleDate.Text.ToString(), dtfi);
        }


        DateTime mServerDt = DateTime.Now;


        DateTime mFinCloseDt = new DateTime();
        mFinCloseDt = Convert.ToDateTime(lblFinCloseDt.Text.ToString(), dtfi);

        DateTime mCutOffDt = new DateTime();
        //mCutOffDt = Convert.ToDateTime("26 Aug 2009", dtfi);
        //mCutOffDt = Convert.ToDateTime("25 Sep 2009", dtfi);

        DataTable dtDriverSettlementDate = new DataTable();
        cls_DriverSettlementDate objDsdt = new cls_DriverSettlementDate(Session["SqlProvider"].ToString().Trim());
        dtDriverSettlementDate = objDsdt.GetDriverSettlemnetDate();

        mCutOffDt = Convert.ToDateTime(dtDriverSettlementDate.Rows[0][0].ToString(), dtfi);
        

        if (lblError.Text == "")
        {
            //if (Session["FinYear_Change"] != null)
            {
                DateTime dtFrom = new DateTime();
                DateTime dtTo = new DateTime();

                string From = "", To = "";

                From = "01/04/" + SessionUtilities.FinYear.ToString().Trim();
                To = "31/03/" + Convert.ToDouble(Convert.ToDouble(SessionUtilities.FinYear.ToString().Trim()) + 1);

                dtFrom = Convert.ToDateTime(From, dtfi);
                dtTo = Convert.ToDateTime(To, dtfi);

                if (mDrvierSettlementDt >= dtFrom && mDrvierSettlementDt <= dtTo)
                {
                    // lblError.Visible = false;
                    lblError.Text = "";
                }
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

                //lblError.Text = "Driver settlement date cannot be greater than/equals to Cut off Date i.e. 26-Aug-2009 !";
                lblError.Text = "Driver settlement date cannot be less than/equals to Cut off Date i.e. " + dtDriverSettlementDate.Rows[0][0].ToString() + " !";

            }
        }


        AmtPaidToDriver = txtAmtPaidToDriver.Text;
        if (AmtPaidToDriver == "")
        {
            AmtPaidToDriver = "0";
        }

        AmtRecvdFromDriver = txtAmtRecvdFromDriver.Text;
        if (AmtRecvdFromDriver == "")
        {
            AmtRecvdFromDriver = "0";
        }




        if (txtAmtPaidToDriver.ReadOnly == false)
        {
            if (lblError.Text == "")
            {
                if (txtAmtPaidToDriver.Text == "")
                {
                    lblError.Text = "Amount paid to driver can not be empty !!!";
                }
            }
            if (lblError.Text == "")
            {
                if(Math.Abs(Convert.ToDouble(AmtPaidToDriver))>Math.Abs(Convert.ToDouble(LblNetExpAmtAppr.Text)))
                //if (Convert.ToDouble(Math.Abs(AmtPaidToDriver)) > Convert.ToDouble(Math.Abs(LblNetExpAmtAppr.Text)))
                {
                    lblError.Text = "Amount paid to driver can not be more than Net approved amount !!!";
                }
            
            }

        }

        if (lblError.Text == "")
        {
            if (txtAmtRecvdFromDriver.ReadOnly == false)
            {
                if (txtAmtRecvdFromDriver.Text == "")
                {
                    lblError.Text = "Amount received from driver can not be empty !!!";
                }

                if (lblError.Text == "")
                {
                    if (Math.Abs(Convert.ToDouble(AmtRecvdFromDriver)) > Math.Abs(Convert.ToDouble(LblNetExpAmtAppr.Text)))
                    {
                        lblError.Text = "Amount received from driver can not be more than Net approved amount !!!";
                    }
                    
                }
            }
        }

        if (lblError.Text == "")
        {
            if (Convert.ToDouble(LblNetBalance.Text) != 0)
            {
                lblError.Text = "Trip Sheet net balance should be always ZERO !!!";
            }
        }


       if (lblError.Text == "")
         {


             string mTripSheetNo = "";
             
             mTripSheetNo = lblIssueNo.Text;
             //mDrvierSettlementDt
            // LblTotAdvancePaidAppr
            //LblTotExpense
           //LblTotDieselCardExp
           //LblTotDieselCreditExp
           //LblNetExpAmt
           //txtAmtPaidToDriver
           //txtAmtRecvdFromDriver
           //txtBalToDriverLedger

             
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

          

             if (txtAmtPaidToDriver.Text != "" && AmtPaidToDriver!="0")
             {
                 //UserControls_MyPaymentControl paymen = (UserControls_MyPaymentControl)UCMyPayment;

                 //UserControls_MyPaymentControl paymen = (UserControls_MyPaymentControl)UCMyPaymentControl1;
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
                 {
                     mdlsttranstype = "NULL";
                 }
                 else
                 {
                     mdlsttranstype = "'" + mdlsttranstype + "'";
                 }
                 mddrCashcode = ddrCashcode.SelectedValue;
                 if (mddrCashcode == "" || mddrCashcode == null)
                 {
                     mddrCashcode = "NULL";
                 }
                 else
                 {
                     mddrCashcode = "'" + mddrCashcode + "'";
                 }
                 mddrBankaccode = ddrBankaccode.SelectedValue;
                 if (mddrBankaccode == "" || mddrBankaccode == null)
                 {
                     mddrBankaccode = "NULL";
                 }
                 else
                 {
                     mddrBankaccode = "'" + mddrBankaccode + "'";
                 }

                 if (dlsttranstype.SelectedValue == "Cash")
                 {
                     mtxtCashAmt = txtAmtPaidToDriver.Text;// txtCashAmt.Text;
                 }
                 else if (dlsttranstype.SelectedValue == "Both")
                 {
                     mtxtCashAmt = txtCashAmt.Text;// txtCashAmt.Text;
                 }
                 else
                 {
                     mtxtCashAmt = "";
                 }

                 if (mtxtCashAmt == "" || mtxtCashAmt == null)
                 {
                     mtxtCashAmt = "NULL";
                 }
                 

                 //mtxtChqAmt = txtChqAmt.Text;
                 if (dlsttranstype.SelectedValue == "Bank")
                 {
                     mtxtChqAmt = txtAmtPaidToDriver.Text;
                 }
                 else if (dlsttranstype.SelectedValue == "Both")
                 {
                     mtxtChqAmt = txtChqAmt.Text;
                 }
                 else
                 {
                     mtxtChqAmt = "";
                 }
                 if (mtxtChqAmt == "" || mtxtChqAmt == null)
                 {
                     mtxtChqAmt = "NULL";
                 }
                 mtxtChqNo = txtChqNo.Text;
                 if (mtxtChqNo == "" || mtxtChqNo == null)
                 {
                     mtxtChqNo = "NULL";
                 }
                 else
                 {
                     mtxtChqNo = "'" + mtxtChqNo + "'";
                 }
                 
                 mtxtChqDate = txtChqDate.Text;
                 if (mtxtChqDate == "" || mtxtChqDate == null)
                 {
                      mtxtChqDate="NULL";
                 }
                 else
                 {
                 mtxtChqDate="'" + mtxtChqDate + "'";
                 }
                 mtxtAmtApplA = txtAmtApplA.Text;
                 if(mtxtAmtApplA=="" || mtxtAmtApplA==null)
                 {
                 mtxtAmtApplA="NULL";
                 }
                 mtxtNetPay = txtNetPay.Text;
                 if(mtxtNetPay=="" || mtxtNetPay==null)
                 {
                     mtxtNetPay = "NULL";
                 }

                 if (mtxtRecBank == "" || mtxtRecBank == null)
                 {
                     mtxtRecBank = "NULL";
                 }
                 else
                 {
                     mtxtRecBank = "'" + mtxtRecBank + "'";
                 }

                 if (mrdDiposited == "" || mrdDiposited == null)
                 {
                     mrdDiposited = "NULL";
                 }
                 else
                 {
                     mrdDiposited = "'" + mrdDiposited + "'";
                 }
             }
             if (txtAmtRecvdFromDriver.Text != "" && AmtRecvdFromDriver!="0")
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
                 {
                     mdlsttranstype = "NULL";
                 }
                 else
                 {
                     mdlsttranstype = "'" + mdlsttranstype + "'";
                 }

                
                 mddrCashcode = ddrCashcode.SelectedValue;
                 if (mddrCashcode == "" || mddrCashcode == null)
                 {
                     mddrCashcode = "NULL";
                 }
                
                 else
                 {
                     mddrCashcode = "'" + mddrCashcode + "'";
                 }
                 mddrBankaccode = ddrBankaccode.SelectedValue;
                 if (mddrBankaccode == "" || mddrBankaccode == null)
                 {
                     mddrBankaccode = "NULL";
                 }
                 else
                 {
                     mddrBankaccode = "'" + mddrBankaccode + "'";
                 }

                  
                 //mtxtCashAmt = txtCashAmt.Text;
                 if (dlsttranstype.SelectedValue == "Cash")
                 {
                     mtxtCashAmt = txtAmtRecvdFromDriver.Text;
                 }
                 else if (dlsttranstype.SelectedValue == "Both")
                 {
                     mtxtCashAmt = txtCashAmt.Text;
                 }
                 else
                 {
                     mtxtCashAmt = "";
                 }

                 if (mtxtCashAmt == "" || mtxtCashAmt == null)
                 {
                     mtxtCashAmt = "NULL";
                 }


                 //mtxtChqAmt = txtChqAmt.Text;
                 if (dlsttranstype.SelectedValue == "Bank")
                 {
                     mtxtChqAmt = txtAmtRecvdFromDriver.Text;
                 }
                 else if (dlsttranstype.SelectedValue == "Both")
                 {
                     mtxtChqAmt = txtChqAmt.Text;
                 }
                 else
                 {
                     mtxtChqAmt = "";
                 }

                 if (mtxtChqAmt == "" || mtxtChqAmt == null)
                 {
                     mtxtChqAmt = "NULL";
                 }
                 mtxtChqNo = txtChqNo.Text;
                 if (mtxtChqNo == "" || mtxtChqNo == null)
                 {
                     mtxtChqNo = "NULL";
                 }
                 else
                 {
                     mtxtChqNo = "'" + mtxtChqNo + "'";
                 }

                 mtxtChqDate = txtChqDate.Text;
                 if (mtxtChqDate == "" || mtxtChqDate == null)
                 {
                     mtxtChqDate = "NULL";
                 }
                 else
                 {
                     mtxtChqDate = "'" + mtxtChqDate + "'";
                 }

                 

                 mtxtAmtApplA = txtAmtApplA.Text;
                 if (mtxtAmtApplA == "" || mtxtAmtApplA == null)
                 {
                     mtxtAmtApplA = "NULL";
                 }
                 mtxtNetPay = txtNetPay.Text;
                 if (mtxtNetPay == "" || mtxtNetPay == null)
                 {
                     mtxtNetPay = "NULL";
                 }


                 
                 mtxtRecBank = txtRecBank.Text;
                 if (mtxtRecBank == "" || mtxtRecBank == null)
                 {
                     mtxtRecBank = "NULL";
                 }
                 else
                 {
                     mtxtRecBank = "'" + mtxtRecBank + "'";
                 }

                 mrdDiposited=rdDiposited.SelectedValue;
                 if (mrdDiposited == "" || mrdDiposited == null)
                 {
                     mrdDiposited = "NULL";
                 }
                 else
                 {
                     mrdDiposited = "'" + mrdDiposited + "'";
                 }

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
             sqlstr = "Insert into Webx_Fleet_DriverSettlement (TripSheetNo,SettleDate,TotAdvPaid,TotExpense,DieselExp_Card,DieselExp_Credit,NetAmount,AmtPaidToDriver,AmtRecvdFromDriver,BalanceToDriverLedger,Paymode,CashAccCode,BankAccCode,CashAmt,ChequeAmt,ChequeNo,ChequeDate,BankName,Deposit_YN,EntryBy,ActBalanceToDriverLedger) values ("
                     + "'" + mTripSheetNo + "','" + mDrvierSettlementDt + "'," + LblTotAdvancePaidAppr.Text + "," + LblTotExpense.Text + "," + LblTotDieselCardExp.Text + "," + LblTotDieselCreditExp.Text + "," + LblNetExpAmt.Text + "," + AmtPaidToDriver + "," + AmtRecvdFromDriver + "," + txtBalToDriverLedger.Text + ","
                     + mdlsttranstype + "," + mddrCashcode + "," + mddrBankaccode + "," + mtxtCashAmt + "," + mtxtChqAmt + "," + mtxtChqNo + "," + mtxtChqDate + "," + mtxtRecBank + "," + mrdDiposited + "," + mEntryby + "," + Session["ActBalToDriverLedger"] + ")";

             SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
             bool success = false;
             SqlTransaction trans;
             conn.Open();
             trans = conn.BeginTransaction();
             try
             {

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


                 string expacc_entry = "";
                 string Str = "select ISNULL(expacc_entry,'Y')expacc_entry from WEBX_FLEET_VEHICLE_ISSUE where VSlipNo ='" + mTripSheetNo + "' ";
                 SqlCommand cd = new SqlCommand(Str, conn, trans);
                 SqlDataReader cdr = cd.ExecuteReader();
                 if (cdr.HasRows)
                 {
                     while (cdr.Read())
                     {
                         expacc_entry = Convert.ToString(cdr["expacc_entry"]);

                     }
                 }
                 cdr.Close();


                 if (expacc_entry == "N")
                 {
                     //------- Trip sheet Financially Close a/c effect ----------------
                     string sqlAcc2 = "usp_FleetTransaction";
                     SqlCommand sqlcmdAcc2 = new SqlCommand(sqlAcc2, conn, trans);
                     sqlcmdAcc2.CommandType = CommandType.StoredProcedure;
                     sqlcmdAcc2.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = lblEndLoc.Text;
                     sqlcmdAcc2.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "4";
                     sqlcmdAcc2.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                     sqlcmdAcc2.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                     sqlcmdAcc2.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                     sqlcmdAcc2.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10

                     sqlcmdAcc2.ExecuteNonQuery();

                     string sqlAcc3 = "usp_FleetTransaction";
                     SqlCommand sqlcmdAcc3 = new SqlCommand(sqlAcc3, conn, trans);
                     sqlcmdAcc3.CommandType = CommandType.StoredProcedure;
                     sqlcmdAcc3.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
                     sqlcmdAcc3.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "5";
                     sqlcmdAcc3.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                     sqlcmdAcc3.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                     sqlcmdAcc3.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                     sqlcmdAcc3.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                     sqlcmdAcc3.ExecuteNonQuery();

                     //-------------------------------------------------------------
                 }


                 //--------------Trip(Driver) settlement-------------------------
                 string sqlAcc = "usp_FleetTransaction";
                 SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                 sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                 sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = lblEndLoc.Text;
                 sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "6";
                 sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                 sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                 sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                 sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                 sqlcmdAcc.ExecuteNonQuery();


                 string sqlAatlas = "usp_FleetTransaction";
                 SqlCommand sqlcmdAatlas = new SqlCommand(sqlAatlas, conn, trans);
                 sqlcmdAatlas.CommandType = CommandType.StoredProcedure;
                 sqlcmdAatlas.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = lblEndLoc.Text;
                 sqlcmdAatlas.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "7";
                 sqlcmdAatlas.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                 sqlcmdAatlas.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                 sqlcmdAatlas.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                 sqlcmdAatlas.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                 sqlcmdAatlas.ExecuteNonQuery();
                 //----------------------------------------------------------------


                 //string sqlDKT = "usp_VHC_Tripsheet_Dockno_Transaction";
                 //SqlCommand sqlcmdDKT = new SqlCommand(sqlDKT, conn, trans);
                 //sqlcmdDKT.CommandType = CommandType.StoredProcedure;
                 //sqlcmdDKT.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;

                 //mFinYear = "20" + mFinYear;

                 //sqlcmdDKT.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                 //sqlcmdDKT.Parameters.Add("@DocType", SqlDbType.VarChar).Value = "TS";
                 //sqlcmdDKT.ExecuteNonQuery();


                 //////------------------------------------------------------------------------


                trans.Commit();
                //trans.Rollback();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
                trans.Rollback();
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
}
