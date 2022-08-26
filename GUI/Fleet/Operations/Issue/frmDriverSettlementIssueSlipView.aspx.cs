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

public partial class GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlipView : System.Web.UI.Page
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



        //string vv = "javascript:return validcheck()";
        //cmdSubmit.Attributes.Add("onClick", vv);


        if (!IsPostBack)
        {
            Session["ActBalToDriverLedger"] = null;
            conn.Open();
            stVSlipId = Request.QueryString["id"];


            Session["Tripsheet"] = null;

            Session["Tripsheet"] = stVSlipId;

            string sql = "select V.VSlipNo,Convert(varchar,VSlipDt,103) VSlipDt,Convert(varchar,V.End_dt_tm,103) as FinCloseDt,V.Vehicleno as vehno,f_issue_startkm as Start_km,f_issue_fill "
                     + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "
                     + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                     + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt,v.driver1,v.CustCode,v.Category,v.Market_Own ,Tripsheet_StartLoc,Tripsheet_EndLoc ,(Select custnm  from webx_CUSTHDR  where custcd=v.CustCode) as Custname,Convert(varchar,DriverSettleDt,103) as DriverSettleDt,AmtPaidToDriver,AmtRecvdFromDriver,BalanceToDriverLedger,Paymode,CashAmt,ChequeAmt,CashAccCode=(select acccode + ' : ' + accdesc from webx_acctinfo where acccode=CashAccCode),BankAccCode=(select acccode + ' : ' + accdesc from webx_acctinfo where acccode=BankAccCode),ChequeNo,Convert(varchar,ChequeDate,103) as ChequeDate,BankName,ActBalanceToDriverLedger "
                     + " from WEBX_FLEET_VEHICLE_ISSUE v,Webx_Fleet_DriverSettlement r "
                     + " where 1=1 and V.VSlipNo=r.tripsheetno"
                     + " and V.VSlipNo='" + stVSlipId + "'";


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
                LblSettleDate.Text = dataReadVI["DriverSettleDt"].ToString();
                LblAmtPaidToDriver.Text = dataReadVI["AmtPaidToDriver"].ToString();
                LblAmtRecvdFromDriver.Text = dataReadVI["AmtRecvdFromDriver"].ToString();

                double AmtPaidToDriver=0;
                double AmtRecvdFromDriver=0;
                AmtPaidToDriver=Convert.ToDouble(dataReadVI["AmtPaidToDriver"].ToString());
                AmtRecvdFromDriver=Convert.ToDouble(dataReadVI["AmtRecvdFromDriver"].ToString());

                LblBalToDriverLedger.Text = dataReadVI["BalanceToDriverLedger"].ToString();
                LblNetBalance.Text = dataReadVI["ActBalanceToDriverLedger"].ToString();
                string accdesc = "";
                string amt = "";
                if(AmtPaidToDriver>0)
                {
                    LblPayRecHead.Text = "Payment";
                    LblPayRecAcc.Text = "Payment";
                    amt = AmtPaidToDriver.ToString();
                }
                else
                {
                    LblPayRecHead.Text = "Receipt";
                    LblPayRecAcc.Text = "Receipt";
                    amt = AmtRecvdFromDriver.ToString();
                }
                

                //Paymode,CashAmt,ChequeAmt,CashAccCode,BankAccCode,ChequeNo,ChequeDate,BankName
                lblMode.Text = dataReadVI["Paymode"].ToString();
                if (lblMode.Text.Trim() == "Cash")
                {
                    accdesc = dataReadVI["CashAccCode"].ToString();
                }
                else
                {
                    accdesc = dataReadVI["BankAccCode"].ToString();
                }
                lblPaymentAcc.Text = accdesc;
                lblPaymentAmt.Text = amt;


                lblChequeNo.Text = dataReadVI["ChequeNo"].ToString();
                lblChequeDt.Text = dataReadVI["ChequeDate"].ToString();

                NumberToText m = new NumberToText();
                lblWords.Text = m.numberToText(amt);
                //AmtPaidToDriver,AmtRecvdFromDriver,BalanceToDriverLedger,Paymode,CashAmt,ChequeAmt,CashAccCode,BankAccCode,ChequeNo,ChequeDate,BankName,ActBalanceToDriverLedger


            }
            dataReadVI.Close();

            RetrieveExpense();
        }
    }

    public void RetrieveExpense()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string Amt = "", ExeAmt = "";
        string sqlstr = "";

        LblTotAdvancePaid.Text = "0.00";
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
        sqlstr = "select  ISNULL(Sum(Convert(numeric(18,2),Amount_Spent)),0) as Amount_Spent,ISNULL(Sum(Convert(numeric(18,2),Exe_Appr_Amt)),0) as Exe_Appr_Amt   from WEBX_FLEET_ENROUTE_EXP  where TripsheetNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
        cmd = new SqlCommand(sqlstr, conn);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Amt = Convert.ToString(dr["Amount_Spent"]);
                ExeAmt = Convert.ToString(dr["Exe_Appr_Amt"]);

                TotExpAmt = TotExpAmt + Convert.ToDouble(Amt.ToString());
                TotExpAmtAppr = TotExpAmtAppr + Convert.ToDouble(ExeAmt.ToString());
            }
        }
        dr.Close();
        LblTotEnrouteExp.Text = Amt;
        LblTotEnrouteExpAppr.Text = ExeAmt;

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
}
