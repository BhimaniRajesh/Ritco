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

public partial class Issue_frmCloseVehicleIssueSlip : System.Web.UI.Page
{
  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    private double sum = 0;
    static string str_Connection_String = "";

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.SparePartRow datarow_Spare;
    MyFleetDataSet.ClaimsRow datarow_Claims;
    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;

    MyFleetDataSet.EnExpenseRow datarow_EnExp;

    MyFleetDataSet.HSD_OIL_EXPRow datarow_HSDOIL;
    MyFleetDataSet.Repair_ExpenseRow datarow_Repair;
    MyFleetDataSet.Incidental_DedRow datarow_IncDed;
    MyFleetDataSet.THCContractRow datarow_THCContract;


    //public MyFleetDataSet _dataSet = new MyFleetDataSet();


    MyFleetDataSet.EnExpenseRouteDataTable dtEnExpense = new MyFleetDataSet.EnExpenseRouteDataTable();
    MyFleetDataSet.EnExpenseRouteRow datarow_Enroute; 
    int i = 0;

    int m = 0;
    string mKM_Reading = "";

    string temp = "";
    string temp1 = "";
    Double current_km = 0;
    Double first_km = 0;
    string stVSlipId = "";

    string Category = "", CustCode = "", Market_Own = "",StartLoc="",EndLoc="";
    public string modeval = "";
    SqlConnection conn;
    
    //public string strDriverCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        modeval = Request.QueryString["mode"];
        if (!IsPostBack)
        {
            try 
            {
                
                if (Session["SqlProvider"] != null)
                {
                    str_Connection_String = Session["SqlProvider"].ToString();
                    conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    conn.Open();
                }
                else
                {
                    Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
                }
            }
            catch (Exception Ex)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
            }

            txtTotalKms.Attributes.Add("OnFocus","javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtApprKMPL.Attributes.Add("OnFocus","javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtApprovedDiesel.Attributes.Add("OnFocus","javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtApprovedFuelAmt.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtKMPL.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtFuelFilled.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtFuelFilledEnroute.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");

            txtCloseKM.Attributes.Add("OnBlur", "javascript:CheckClosingKM();");
            stVSlipId = Request.QueryString["id"];
            //modeval = Request.QueryString["mode"];
            if (modeval == "FE")
            {
                lblPageHead.Text = "Vehicle Issue Slip - Financial Edit";
                lblHeader.Text = "Financial Edit - Vehicle Issue Slip";
            }
            Session["Tripsheet"] = null;
            Session["Tripsheet"] = stVSlipId;
            System.DateTime righnow = System.DateTime.Today;

            try
            {
                TripSheet objTripSheet = new TripSheet(str_Connection_String);
                DataTable dtVI = new DataTable();
                dtVI = objTripSheet.ExecuteSql("SELECT *from vw_TripSheetClose where VSlipNo= '" + stVSlipId + "'");

                string strrightnow = righnow.ToString("dd/MM/yyyy");
                txtDateFrom.CalendarDate = strrightnow;
            
                if (dtVI.Rows.Count > 0 )
                {
                    lblIssueNo.Text = dtVI.Rows[0]["VSlipNo"].ToString();
                    lblIssueDt.Text = dtVI.Rows[0]["VSlipDt"].ToString();
                    lblVehno.Text = dtVI.Rows[0]["Vehno"].ToString();
                    lblDriverName.Text = dtVI.Rows[0]["driver_name"].ToString();
                    Session["strDriverCode"] = dtVI.Rows[0]["driver1"].ToString();
                    hfRouteCode.Value = dtVI.Rows[0]["rut_code"].ToString();
                    hfRouteDesc.Value = dtVI.Rows[0]["rutdesc"].ToString();
                    lblLicno.Text = dtVI.Rows[0]["License_no"].ToString();
                    lblValidDt.Text = dtVI.Rows[0]["valdity_dt"].ToString();
                    lblStartKm.Text = dtVI.Rows[0]["Start_km"].ToString();
                    txtFuelFilled.Text = dtVI.Rows[0]["f_issue_fill"].ToString();
                    lblManualNo.Text = dtVI.Rows[0]["Manual_Tripsheetno"].ToString();
                    lblStartLoc.Text = dtVI.Rows[0]["Tripsheet_StartLoc"].ToString();
                    lblEndLoc.Text = dtVI.Rows[0]["Tripsheet_EndLoc"].ToString();
                    lblCategory.Text = dtVI.Rows[0]["Category"].ToString();
                    txtApprovedBy.Text = dtVI.Rows[0]["ApprovedBy"].ToString();
                    txtPreparedBy.Text = dtVI.Rows[0]["PreparedBy"].ToString();
                    txtCheckedBy.Text = dtVI.Rows[0]["CheckedBy"].ToString();
                    txtAuditedBy.Text = dtVI.Rows[0]["AuditedBy"].ToString();
                    txtCloseKM.Text = dtVI.Rows[0]["f_closure_closekm"].ToString();
                    lblRoute.Text = dtVI.Rows[0]["rut_code"].ToString() + " : " + dtVI.Rows[0]["rutdesc"].ToString();
                    lblFTLType.Text = dtVI.Rows[0]["VehicleType"].ToString();
                    hfKMPL.Value = dtVI.Rows[0]["KMPL"].ToString();
                    lblAverageDieselRate.Text = dtVI.Rows[0]["AvgDieselRate"].ToString();

                    if (txtCloseKM.Text != "")
                    {
                        string StartKm = lblStartKm.Text.ToString();
                        string CloseKM = txtCloseKM.Text.ToString();
                        double TotalKms = 0;
                        TotalKms = Convert.ToDouble(CloseKM) - Convert.ToDouble(StartKm);
                        txtTotalKms.Text = TotalKms.ToString();
                    }

                    txtFuelFilledEnroute.Text = dtVI.Rows[0]["f_closure_fill"].ToString();
                    //lblKMPL.Text = dataReadVI["Actual_KMPL"].ToString();
                    txtKMPL.Text = dtVI.Rows[0]["Actual_KMPL"].ToString();
                    //txtApprKMPL.Text = dtVI.Rows[0]["Approved_KMPL"].ToString();
                    txtApprKMPL.Text = dtVI.Rows[0]["KMPL"].ToString();
                    //Approved_KMPL,Actual_KMPL
                    if (dtVI.Rows[0]["Category"].ToString().Trim() == "External Usage")
                    {
                        lblCustCodeHead.Visible = true;
                        lblCustcodeMarket.Text = dtVI.Rows[0]["CustCode"].ToString();
                    }
                    if (dtVI.Rows[0]["Category"].ToString().Trim() == "Internal Usage")
                    {
                        lblMarketHead.Visible = true;
                        lblCustcodeMarket.Text = dtVI.Rows[0]["Market_Own"].ToString();
                    }
                }
                dtEnExpense.AddEnExpenseRouteRow("", "", "", "", "", "", "");
                BindGridEnExpense();
                
                //new change
                mDataCount = 0;
                if (mDataCount == 0) { BindGrid(); }
                txtAddRowOilExp.Text = mDataCount.ToString();
                mDataCount = 0;
                if (mDataCount == 0) { BindGrid(); }
                txtAddTHCrow.Text = mDataCount.ToString();
                mDataCount = 0;
                if (mDataCount == 0) { BindGrid(); }
                //txtAddRowRepairExp.Text = mDataCount.ToString();
                mDataCount = 0;
                if (mDataCount == 0) { BindGrid(); }
                //txtAddRowIncidental.Text = mDataCount.ToString();
                if (mDataCount == 0) { BindGrid(); }
                //txtCAddRow.Text = mDataCount.ToString();

                Previous_advance();
                InetializEnrouteExpense();
                Previous_THCContractDetail();
                Previous_HSD_OIL_EXP();
                Previous_Claim();
                Previous_INCDED();
                Previous_SPARE();
                Previous_Repair();

                conn.Close();
            }
            catch (Exception Exc)
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
            }
        }
        else
        {
            ReverseBind();
        }
        
    }
   
    public void InetializEnrouteExpense()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        string str = "SELECT G.CodeDesc, E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt, E.Remarks"
        + " FROM Webx_Master_General AS G LEFT OUTER JOIN"
        + " WEBX_FLEET_ENROUTE_EXP AS E ON G.CodeId = E.id AND (E.TripsheetNo = '" + Session["Tripsheet"].ToString().Trim() + "')"
        + " WHERE (G.CodeType = 'FULEXP') "
        + " ORDER BY G.CodeId";
        DataTable dtDR = new DataTable();
        dtDR = objTripSheet.ExecuteSql(str);
        Double mAmt = 0, mEAmt = 0;
        if (dtDR.Rows.Count > 0)
        {
            foreach(DataRow dr in dtDR.Rows)
            {
                string mCodeDesc = Convert.ToString(dr["codedesc"]);
                string id = Convert.ToString(dr["id"]);
                string Amount = Convert.ToString(dr["Amount_spent"]);
                string BillNo = Convert.ToString(dr["BillNo"]);
                string BillDt = Convert.ToString(dr["dt"]);
                string Exe_amt = Convert.ToString(dr["exe_appr_amt"]);
                if (Amount == "")
                {
                    Amount = "0";
                }
                if (Exe_amt == "")
                {
                    Exe_amt = "0";
                }
                mAmt = mAmt + Convert.ToDouble(Amount);
                mEAmt = mEAmt + Convert.ToDouble(Exe_amt);
                if (Amount == "0")
                {
                    Amount = "";
                }
                if (Exe_amt == "0")
                {
                    Exe_amt = "";
                }
                string Remarks = Convert.ToString(dr["Remarks"]);
                _dataSet.EnExpense.AddEnExpenseRow(mCodeDesc, Amount, BillNo, BillDt, Exe_amt, Remarks);
            }
        }
        BindGrid();
    }
    public void Previous_Repair()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        string mSTR = "  select convert(varchar,BillDt,103) as BillDt1, * from WEBX_TRIPSHEET_REPAIREXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count>0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;

                string Supllier = Convert.ToString(dr["Supplier"]);
                string BillDt = Convert.ToString(dr["BillDt1"]);
                string Supdesc = Convert.ToString(dr["SuppDesc"]);

                string Qty = Convert.ToString(dr["Qtn"]);
                string Rate_Unit = Convert.ToString(dr["Rate_Unit"]);
                string BillNo = Convert.ToString(dr["BillNo"]);
                string Amt = Convert.ToString(dr["Amt"]);

                _dataSet.Repair_Expense.AddRepair_ExpenseRow(Supllier, Supdesc, Qty, Rate_Unit, BillNo, BillDt, Amt);
            }
        }
        BindGrid();
    }
    public void Previous_THCContractDetail()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        string str = "select  *  from   WEBX_FLEET_TRIPTHCDET  where tripsheetno='" + Session["Tripsheet"].ToString().Trim() + "'  ";
        Double mAmt = 0, mEAmt = 0;
        int count = 0;
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(str);
        if (dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows)
            {
                count = count + 1;
                string From = Convert.ToString(dr["FromCity"]);
                string To = Convert.ToString(dr["ToCity"]);
                string ThcNo = Convert.ToString(dr["THCNo"]);
                string ThcDate = Convert.ToString(dr["THCDt"]);
                string Freight = Convert.ToString(dr["FreightAmt"]);
                string Lab = Convert.ToString(dr["LabourAmt"]);
                string Other = Convert.ToString(dr["OtherAmt"]);

                string Total = Convert.ToString(dr["TotalAmt"]);

                _dataSet.THCContract.AddTHCContractRow(From, To, ThcNo, ThcDate, Freight, Lab, Other, Total, "", "", "");
            }
        }
        BindGrid();

        txtAddTHCrow.Text = count.ToString();

        string mFreightAmt = "0";
        string mLabourChrg = "0";
        string mOtherChrg = "0";
        double mTotalAmt = 0;

        double mTotFreightAmt = 0;
        double mTotLabourChrg = 0;
        double mTotOtherChrg = 0;
        double mTotTotalAmt = 0;

        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            mFreightAmt = "0";
            mLabourChrg = "0";
            mOtherChrg = "0";
            mTotalAmt = 0;

            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "")
            {
                {
                    mFreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
                    mTotFreightAmt = mTotFreightAmt + Convert.ToDouble(mFreightAmt);
                }
            }

            if (((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "")
            {
                {
                    mLabourChrg = ((TextBox)gridrow.FindControl("txtLabourChrg")).Text;
                    mTotLabourChrg = mTotLabourChrg + Convert.ToDouble(mLabourChrg);
                }
            }
            if (((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                {
                    mOtherChrg = ((TextBox)gridrow.FindControl("txtOtherChrg")).Text;
                    mTotOtherChrg = mTotOtherChrg + Convert.ToDouble(mOtherChrg);
                }
            }
            mTotalAmt = Convert.ToDouble(mFreightAmt) + Convert.ToDouble(mLabourChrg) + Convert.ToDouble(mOtherChrg);
            mTotTotalAmt = mTotTotalAmt + mTotalAmt;
            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "" || ((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "" || ((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text = mTotalAmt.ToString();
            }
        }
        TotFreightChrg.Text = mTotFreightAmt.ToString();
        TotLabourChrg.Text = mTotLabourChrg.ToString();
        TotOtherChrg.Text = mTotOtherChrg.ToString();
        TotChrg.Text = mTotTotalAmt.ToString();
    }
    public void Previous_advance()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        string mSTR = "  select convert(varchar,AdvDate,103) as ADate, * from WEBX_TRIPSHEET_ADVEXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR); 
        if (dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows) 
            {
                count = count + 1;
                string place = Convert.ToString(dr["AdvLoc"]);
                string advdt = Convert.ToString(dr["ADate"]);
                string amt = Convert.ToString(dr["AdvAmt"]);
                string brnch = Convert.ToString(dr["BranchCode"]);
                string advpaidby = Convert.ToString(dr["Signature"]);
                _dataSet.AdvanceTaken.AddAdvanceTakenRow(place, advdt, amt, "", brnch, advpaidby);
            }
        }
        BindGrid();
        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {
            int i = 0;
            if (i < count)
            {
                ((TextBox)gridrow.FindControl("txtAdvPlace")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvDt")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtAdvAmt")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtBranchCode")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtSignature")).ReadOnly = true;
                i = i + 1;
            }
            else
            {
                ((TextBox)gridrow.FindControl("txtAdvPlace")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvDt")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtAdvAmt")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtBranchCode")).ReadOnly = false;
                ((TextBox)gridrow.FindControl("txtSignature")).ReadOnly = false;
            }
        }
    }
    public void Previous_INCDED()
    {
        string mSTR = "  select convert(varchar,Voucherdt,103) as Voucherdt1,convert(varchar,Voucherdt,103) as Voucherdt1, convert(varchar,TripFromDt,103) as FromDT,convert(varchar,TripTodt,103) as ToDt,  * from  WEBX_TRIPSHEET_INCDED where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows)
            {
                count = count + 1;

                string IncDt = Convert.ToString(dr["InCdt"]);
                string FromDt = Convert.ToString(dr["FromDt"]);
                string ToDt = Convert.ToString(dr["ToDt"]);
                string VoucherNo = Convert.ToString(dr["VoucherNo"]);
                string Voucherdt = Convert.ToString(dr["Voucherdt1"]);
                string RecvdDt = Convert.ToString(dr["REcdDt"]);
                string Amt = Convert.ToString(dr["Amt"]);
                _dataSet.Incidental_Ded.AddIncidental_DedRow(IncDt, FromDt, ToDt, VoucherNo, Voucherdt, RecvdDt, Amt);
            }
        }
        BindGrid();
    }
    public void Previous_SPARE()
    {
        string mSTR = "  select   * from  WEBX_FLEET_VEHICLE_ISSUE_PARTDET where VslipNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;
                string PartId = Convert.ToString(dr["PartId"]);
                string Qty = Convert.ToString(dr["Qty"]);

                string Rate = Convert.ToString(dr["rate"]);
                string Amt = Convert.ToString(dr["Amt"]);
                string Remark = Convert.ToString(dr["remark"]);
                _dataSet.SparePart.AddSparePartRow(PartId, Qty, Rate, Amt, Remark);
            }
        }
        BindGrid();
    }


    public void Previous_Claim()
    {
        string mSTR = "  select   * from  WEBX_TRIPSHEET_CLAIMS where tripsheetid ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;
                string Nature = Convert.ToString(dr["Nature"]);
                string NoOfPacks = Convert.ToString(dr["No_Of_Packs"]);
                string Weight = Convert.ToString(dr["Weight"]);
                string ApproxValue = Convert.ToString(dr["Approx_Value"]);
                _dataSet.Claims.AddClaimsRow(Nature, NoOfPacks, Weight, ApproxValue);
            }
        }
        BindGrid();
    }
    public void Previous_HSD_OIL_EXP()
    {
        string mSTR = "  select convert(varchar,BillDt,103) as BillDt1,(select top 1 vendorname from webx_vendor_hdr where vendorcode=PetrolPName or VendorName=PetrolPName) as PPName,(select Fuel_Brand_Name from WEBX_FLEET_FUELBRAND where convert(varchar(3),Fuel_Brand_ID)=Brand or Fuel_Brand_Name=Brand) BrandName,(select CodeDesc from Webx_Master_General where CodeType='FUELTY' and (CodeId=FuelType or CodeDesc=FuelType)) FuelTypeName, * from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        double TotDisesel_Ltr = 0;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                count = count + 1;

                string place = Convert.ToString(dr["place"]);
                string ppname = Convert.ToString(dr["PPName"]);//PetrolPNAme
                string FuelType = Convert.ToString(dr["FuelTypeName"]);//FuelType

                string Remark = Convert.ToString(dr["Remark"]);
                string Exe_amt = Convert.ToString(dr["Exe_amt"]);

                string Last_Km_read = Convert.ToString(dr["Last_Km_read"]);
                string KMRead = Convert.ToString(dr["KM_Reading"]);
                string BillNo = Convert.ToString(dr["BillNo"]);
                string BillDt = Convert.ToString(dr["BillDt1"]);
                string Disesel_Ltr = Convert.ToString(dr["Diesel_Ltr"]);

                TotDisesel_Ltr = TotDisesel_Ltr + Convert.ToDouble(Disesel_Ltr.ToString());
                string Oil_Ltr = Convert.ToString(dr["Oil_Ltr"]);
                string Dsl_rate = Convert.ToString(dr["Diesel_rate"]);
                string Oil_Rate = Convert.ToString(dr["Oil_Rate"]);

                string Amount = Convert.ToString(dr["Amount"]);
                string Brand = Convert.ToString(dr["BrandName"]);//Brand

                string Category = Convert.ToString(dr["Category"]);

                string Card_Cash = Convert.ToString(dr["Card_Cash"]);
                if (Card_Cash == "Credit")
                {
                    mcount = mcount + 1;
                }
                _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow(place, ppname, Brand, FuelType, Last_Km_read, KMRead, BillNo, BillDt, Disesel_Ltr, Oil_Ltr, Amount, Exe_amt, Card_Cash, Remark, Dsl_rate, Oil_Rate);
            }
        }
        BindGrid();

        Session["dbOilRow"] = mcount;
        txtFuelFilledEnroute.Text = TotDisesel_Ltr.ToString();

        txtAddRowOilExp.Text = count.ToString();
    }
    protected void CalcTHCContractAmt(object sender, EventArgs e)
    {
        string mFreightAmt = "0";
        string mLabourChrg = "0";
        string mOtherChrg = "0";
        double mTotalAmt = 0;

        double mTotFreightAmt = 0;
        double mTotLabourChrg = 0;
        double mTotOtherChrg = 0;
        double mTotTotalAmt = 0;

        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            mFreightAmt = "0";
            mLabourChrg = "0";
            mOtherChrg = "0";
            mTotalAmt = 0;
            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "")
            {
                {
                    mFreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
                    mTotFreightAmt = mTotFreightAmt + Convert.ToDouble(mFreightAmt);
                }
            }

            if (((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "")
            {
                {
                    mLabourChrg = ((TextBox)gridrow.FindControl("txtLabourChrg")).Text;
                    mTotLabourChrg = mTotLabourChrg + Convert.ToDouble(mLabourChrg);
                }
            }

            if (((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                {
                    mOtherChrg = ((TextBox)gridrow.FindControl("txtOtherChrg")).Text;
                    mTotOtherChrg = mTotOtherChrg + Convert.ToDouble(mOtherChrg);
                }
            }

            mTotalAmt = Convert.ToDouble(mFreightAmt) + Convert.ToDouble(mLabourChrg) + Convert.ToDouble(mOtherChrg);
            mTotTotalAmt = mTotTotalAmt + mTotalAmt;
            if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "" || ((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "" || ((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
            {
                ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text = mTotalAmt.ToString();
            }


        }
        TotFreightChrg.Text = mTotFreightAmt.ToString();
        TotLabourChrg.Text = mTotLabourChrg.ToString();
        TotOtherChrg.Text = mTotOtherChrg.ToString();
        TotChrg.Text = mTotTotalAmt.ToString();

    }
    public void Inetialized_AdvanceTaken()
    {
        _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
    }

    public void Inetialized_HSD_OIL_EXP()
    {
        _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("","","","","", "", "", "", "0", "0","", "","","","0","0");
    }

    public void Inetialized_Repair_Expense()
    {
        _dataSet.Repair_Expense.AddRepair_ExpenseRow("", "", "0", "0", "", "", "");
    }

    public void Inetialized_Incidental_Ded()
    {
        _dataSet.Incidental_Ded.AddIncidental_DedRow("", "", "", "", "", "", "");
    }
    protected void add_rowOil(object sender, EventArgs e)
    {
        lblError.Text = "";
        int count = Convert.ToInt32(Session["dbOilRow"].ToString());
        string rowno;
        rowno = txtAddRowOilExp.Text;
        int mroww = 0;
        mroww = Convert.ToInt16(rowno) ;

        if (mroww >= count)
        {
            int miroww = 0;
            int i;
            int iroww = 0;
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                iroww = iroww + 1;
            }
            miroww = iroww;
            if (mroww < miroww)
            {
                miroww = mroww;
            }
            if (iroww >= 0)
            {
                for (i = iroww - 1; i > -1 + miroww; i--)
                {
                    _dataSet.HSD_OIL_EXP.RemoveHSD_OIL_EXPRow(_dataSet.HSD_OIL_EXP[i]);
                }
            }
            for (i = 0 + miroww; i < Int16.Parse(txtAddRowOilExp.Text); i++)
            {
                Double LastKm1 = 0;
                string LastKm2 = lblStartKm.Text;
                LastKm1 = Convert.ToDouble(lblStartKm.Text);
                int LastKm = Convert.ToInt32(LastKm1);
                // LastKm=LastKm+
                if (i == 0)
                {
                    _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", LastKm2, "", "", "", "0", "0", "", "", "", "", "0", "0");
                }
                else
                {
                    _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "", "", "", "0", "0");
                }
            }
            BindGrid();
            int k = 0;

            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                string cash_card = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Value;
                if (k < count && cash_card=="Credit")
                {
                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = false;

                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = false;

                    k = k + 1;
                }
                else
                {

                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;

                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                    //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;

                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                    //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = true;
                }
            }
        }
        else
        {
            lblError.Text = "Sorry, HSD/OIL Expenses row can not be less than " + Session["dbOilRow"].ToString() + " !!!";
        }
    }
 
    protected void add_rowTHC(object sender, EventArgs e)
    {
        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtAddTHCrow.Text;
        mroww = Convert.ToInt16(rowno);
        int i;
        int iroww = 0;
        foreach (DataGridItem gridrow in dgTHC.Items)
        {
            iroww = iroww + 1;
        }
        miroww = iroww;
        if (mroww < miroww)
        {
            miroww = mroww;
        }
        if (iroww >= 0)
        {
            for (i = iroww - 1; i > -1 + miroww; i--)
            {
                _dataSet.THCContract.RemoveTHCContractRow(_dataSet.THCContract[i]);
            }
        }
        for (i = 0 + miroww; i < Int16.Parse(txtAddTHCrow.Text); i++)
        {
            _dataSet.THCContract.AddTHCContractRow("", "", "", "", "", "", "", "", "", "", "");
        }
        BindGrid();
    }
    protected void dgAdvanceDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            //TextBox txtExeAmt = (TextBox)e.Item.FindControl("txtExeAmt");
            //txtExeAmt.Attributes.Add("OnBlur", "return CheckApprovedAmt(this)");
            
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Adv = ((MyFleetDataSet.AdvanceTakenRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtAdvPlace")).Text = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtAdvDt")).Text = datarow_Adv.AdvDt;
            ((TextBox)e.Item.FindControl("txtAdvAmt")).Text = datarow_Adv.AdvAmt;
            
            //TextBox txtAdvAmt = (TextBox)e.Item.FindControl("txtAdvAmt");
            //tb_KMPL.Text = datarow_Adv.AdvAmt;

            
            ((TextBox)e.Item.FindControl("txtBranchCode")).Text = datarow_Adv.BranchCode;
            ((TextBox)e.Item.FindControl("txtSignature")).Text = datarow_Adv.Signature;

            
        }
    }
    protected void dgTHCDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_THCContract = ((MyFleetDataSet.THCContractRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtFrom")).Text = datarow_THCContract.FromCity;
            ((TextBox)e.Item.FindControl("txtTo")).Text = datarow_THCContract.ToCity;
            ((TextBox)e.Item.FindControl("txtTHCNo")).Text = datarow_THCContract.THCNo;
            ((TextBox)e.Item.FindControl("txtTHCDt")).Text = datarow_THCContract.THCDt;
            ((TextBox)e.Item.FindControl("txtFreightAmt")).Text = datarow_THCContract.FreightAmt;
            ((TextBox)e.Item.FindControl("txtFreightAmt")).Text = datarow_THCContract.FreightAmt;

            ((TextBox)e.Item.FindControl("txtLabourChrg")).Text = datarow_THCContract.LabourChrg;
            ((TextBox)e.Item.FindControl("txtOtherChrg")).Text = datarow_THCContract.OtherChrg;
            ((TextBox)e.Item.FindControl("txtTHCTotalAmt")).Text = datarow_THCContract.TotalChrg;
        }

    }
    protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct VENDORNAME,VENDORCODE from webx_VENDOR_HDR where VENDORTYPE='12' Order By VENDORNAME", conn);
        conn.Close();
        da1.Fill(ds1, "webx_VENDOR_HDR");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlPPName = ((DropDownList)e.Item.FindControl("ddlPPName"));
            ddlPPName.DataTextField = "VENDORNAME";
            ddlPPName.DataValueField = "VENDORCODE";
            ddlPPName.DataSource = ds1.Tables["webx_VENDOR_HDR"];
            ddlPPName.DataBind();
            ddlPPName.Items.Insert(0, "");
            TextBox txtKM_Reading = (TextBox)e.Item.FindControl("txtKM_Reading");
            TextBox txtLKmRead = (TextBox)e.Item.FindControl("txtLKmRead");
            
            TextBox txtExeAmt = (TextBox)e.Item.FindControl("txtExeAmt");
            txtLKmRead.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtKM_Reading.ClientID.ToString() + "').focus();");
            txtExeAmt.Attributes.Add("OnBlur", "return CheckApprovedAmt(" + e.Item.ItemIndex + ",this)");
            txtKM_Reading.Attributes.Add("OnBlur", "return CheckKM(" + e.Item.ItemIndex + ",this," + txtLKmRead.ClientID.ToString().Trim() + ")");

            
        }


        DataSet ds2 = new DataSet();
        SqlDataAdapter da2 = new SqlDataAdapter("select distinct Fuel_Brand_ID,Fuel_Brand_Name from WEBX_FLEET_FUELBRAND where Active_Flag='Y' order By Fuel_Brand_Name", conn);
        conn.Close();
        da2.Fill(ds2, "WEBX_FLEET_FUELBRAND");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlBrand = ((DropDownList)e.Item.FindControl("ddlBrand"));
            ddlBrand.DataTextField = "Fuel_Brand_Name";
            ddlBrand.DataValueField = "Fuel_Brand_ID";
            ddlBrand.DataSource = ds2.Tables["WEBX_FLEET_FUELBRAND"];
            ddlBrand.DataBind();
            ddlBrand.Items.Insert(0, "");
        }
        DataSet ds3 = new DataSet();
        SqlDataAdapter da3 = new SqlDataAdapter("select distinct CodeId,CodeDesc from Webx_Master_General where CodeType='FUELTY' Order By CodeDesc", conn);
        conn.Close();
        da3.Fill(ds3, "Webx_Master_General");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList ddlFuelType = ((DropDownList)e.Item.FindControl("ddlFuelType"));
            ddlFuelType.DataTextField = "CodeDesc";
            ddlFuelType.DataValueField = "CodeId";
            ddlFuelType.DataSource = ds3.Tables["Webx_Master_General"];
            ddlFuelType.DataBind();
            ddlFuelType.Items.Insert(0, "");
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_HSDOIL = ((MyFleetDataSet.HSD_OIL_EXPRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtOilPlace")).Text = datarow_HSDOIL.OilPlace;

            ((DropDownList)e.Item.FindControl("ddlPPName")).SelectedItem.Text = datarow_HSDOIL.PPName;
            ((DropDownList)e.Item.FindControl("ddlBrand")).SelectedItem.Text = datarow_HSDOIL.Brand;
            ((DropDownList)e.Item.FindControl("ddlFuelType")).SelectedItem.Text = datarow_HSDOIL.FuelType;
            ((TextBox)e.Item.FindControl("txtLKMRead")).Text = datarow_HSDOIL.Last_Km_Read;

            ((TextBox)e.Item.FindControl("txtKM_Reading")).Text = datarow_HSDOIL.KM_Reading;
            ((TextBox)e.Item.FindControl("txtBillno")).Text = datarow_HSDOIL.Billno;
            ((TextBox)e.Item.FindControl("txtBilldt")).Text = datarow_HSDOIL.Billdt;
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Text = datarow_HSDOIL.Diesel_Ltr;
            //((TextBox)e.Item.FindControl("txtOil_Ltr")).Text = datarow_HSDOIL.Oil_Ltr;
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_HSDOIL.Amt;

            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_HSDOIL.Exe_Amt;
            ((DropDownList)e.Item.FindControl("ddlPayment")).SelectedItem.Text = datarow_HSDOIL.Payment;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_HSDOIL.Remarks;

            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Text = datarow_HSDOIL.Diesel_Rate;
            //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Text = datarow_HSDOIL.Oil_Rate;

            ((TextBox)e.Item.FindControl("txtBilldt")).Attributes.Add("OnBlur", "javascript:ValidDateHSD(" + ((TextBox)e.Item.FindControl("txtBilldt")).ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Attributes.Add("OnBlur", "javascript:CalculateDiesel()");

            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Attributes.Add("OnBlur", "javascript:CalculateDieselLiters(" + ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).ClientID.ToString() + "," + ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).ClientID.ToString() + "," + ((TextBox)e.Item.FindControl("txtAmt")).ClientID.ToString() + ")");

            ((TextBox)e.Item.FindControl("txtAmt")).Attributes.Add("OnFocus", "javascript:document.getElementById('" + ((TextBox)e.Item.FindControl("txtExeAmt")).ClientID.ToString() + "').focus();");
            
            if (datarow_HSDOIL.Payment == "Credit")
            {
                ((TextBox)e.Item.FindControl("txtOilPlace")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlPPName")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlBrand")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlFuelType")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtKM_Reading")).Enabled = false;

                ((TextBox)e.Item.FindControl("txtBillno")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtBilldt")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtOil_Ltr")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = false;

                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Enabled = false;
            }
            else
            {
                ((TextBox)e.Item.FindControl("txtOilPlace")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlPPName")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlBrand")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlFuelType")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtKM_Reading")).Enabled = true;

                ((TextBox)e.Item.FindControl("txtBillno")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtBilldt")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Enabled = true;
                //((TextBox)e.Item.FindControl("txtOil_Ltr")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = true;

                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = true;
                //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Enabled = true;
            }
        }
    }
    protected void dgRepairExp_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Repair = ((MyFleetDataSet.Repair_ExpenseRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtSupplier")).Text = datarow_Repair.Supplier;
            ((TextBox)e.Item.FindControl("txtDesc")).Text = datarow_Repair.Desc;
            ((TextBox)e.Item.FindControl("txtQtn")).Text = datarow_Repair.Qtn;
            ((TextBox)e.Item.FindControl("txtRate_Unit")).Text = datarow_Repair.Rate_Unit;
            ((TextBox)e.Item.FindControl("txtRepairBillno")).Text = datarow_Repair.Billno;
            ((TextBox)e.Item.FindControl("txtRepairBilldt")).Text = datarow_Repair.Billdt;
            ((TextBox)e.Item.FindControl("txtRepairAmt")).Text = datarow_Repair.Amt;
        }
    }
    protected void dgClaim_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Claims = ((MyFleetDataSet.ClaimsRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtNature")).Text = datarow_Claims.Nature;
            ((TextBox)e.Item.FindControl("txtNoPacks")).Text = datarow_Claims.Packs;
            ((TextBox)e.Item.FindControl("txtWeight")).Text = datarow_Claims.Weight;
            ((TextBox)e.Item.FindControl("txtApprValue")).Text = datarow_Claims.ApproxValue;
        }
    }
    protected void dgIncidental_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_IncDed = ((MyFleetDataSet.Incidental_DedRow)((DataRowView)e.Item.DataItem).Row);

            //((TextBox)e.Item.FindControl("txtIncdt")).Text = datarow_IncDed.Dt;
            //((TextBox)e.Item.FindControl("txtIncTripFrom")).Text = datarow_IncDed.TripPeriod_From;
            // ((TextBox)e.Item.FindControl("txtIncTripTo")).Text = datarow_IncDed.TripPeriod_To;
            ((TextBox)e.Item.FindControl("txtVoucherNo")).Text = datarow_IncDed.VoucherNo;
            ((TextBox)e.Item.FindControl("txtVoucherDt")).Text = datarow_IncDed.VoucherDt;
            //((TextBox)e.Item.FindControl("txtRecvDt")).Text = datarow_IncDed.RecvDt;
            ((TextBox)e.Item.FindControl("txtIncAmt")).Text = datarow_IncDed.Amt;
        }
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
  
    protected void DataGrid2_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct PartName,PartId from WEBX_FLEET_PARTMST where ActiveFlag='Y' Order By PartName", conn);
        conn.Close();
        da1.Fill(ds1, "WEBX_FLEET_PARTMST");

        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            DropDownList cboPartName = ((DropDownList)e.Item.FindControl("cboPartName"));
            cboPartName.DataTextField = "PartName";
            cboPartName.DataValueField = "PartId";
            cboPartName.DataSource = ds1.Tables["WEBX_FLEET_PARTMST"];
            cboPartName.DataBind();
            cboPartName.Items.Insert(0, "");
        }
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Spare = ((MyFleetDataSet.SparePartRow)((DataRowView)e.Item.DataItem).Row);
            ((DropDownList)e.Item.FindControl("cboPartName")).SelectedValue = datarow_Spare.Partno;
            ((TextBox)e.Item.FindControl("txtQty")).Text = datarow_Spare.Qty;
            ((TextBox)e.Item.FindControl("txtRate")).Text = datarow_Spare.Rate;
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_Spare.Amt;
            ((TextBox)e.Item.FindControl("txtRemark")).Text = datarow_Spare.Remark;

            //double value = double.Parse(DataBinder.Eval(e.Item.DataItem, "Amt").ToString());
            //sum += value;
        }
        else if (e.Item.ItemType == ListItemType.Footer)
        {
            //e.Item.Cells[0].Text = "<b>Total </b>";
            //((TextBox)e.Item.FindControl("txtTotalAmt")).Text = sum.ToString();
        }
    }
    private void ReverseBind()
    {
        MyFleetDataSet.SparePartRow datarow_Spare;
     
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
            datarow_HSDOIL.OilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
            datarow_HSDOIL.PPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Value;
            datarow_HSDOIL.Brand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Value;
            datarow_HSDOIL.FuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Value;
            datarow_HSDOIL.Last_Km_Read = ((TextBox)gridrow.FindControl("txtLKMRead")).Text;
            datarow_HSDOIL.KM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
            datarow_HSDOIL.Billno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
            datarow_HSDOIL.Billdt = ((TextBox)gridrow.FindControl("txtBilldt")).Text;
            datarow_HSDOIL.Diesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
            datarow_HSDOIL.Oil_Ltr = "";
            //datarow_HSDOIL.Oil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
            datarow_HSDOIL.Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
            datarow_HSDOIL.Exe_Amt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
            datarow_HSDOIL.Payment = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Value;
            datarow_HSDOIL.Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
            datarow_HSDOIL.Diesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
            //datarow_HSDOIL.Oil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
            datarow_HSDOIL.Oil_Rate = "";
        }
    }
    
    public void BindGrid()
    {
        dgTHC.DataSource = _dataSet.THCContract;
        dgTHC.DataBind();
        _lastEditedPage = dgTHC.CurrentPageIndex;

        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;

        dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
        dgHSD_OIL_EXP.DataBind();
        _lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;


    }
    public void Inetialized()
    {
        _dataSet.SparePart.AddSparePartRow("", "0", "0", "0", "");
    }

 
    
    protected void CalcAmt(object sender, EventArgs e)
    {
        
    }
   
    protected void CardNo_Dispaly(object sender, EventArgs e)
    {
        lblError.Text = "";
        MyFleetDataSet.HSD_OIL_EXPRow datarow_OilExp;
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                string FCCardNo = "";
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                string msql = "select Manual_Fuel_Card_No  from WEBX_FLEET_FUELCARD where Vehicle_No='" + lblVehno.Text + "'";
                SqlCommand cdR = new SqlCommand(msql, conn);
                SqlDataReader cdDR = cdR.ExecuteReader();
                if (cdDR.HasRows)
                {
                    while (cdDR.Read())
                    {
                        FCCardNo = Convert.ToString(cdDR["Manual_Fuel_Card_No"]);
                    }
                }
                cdDR.Close();
                conn.Close();
                if (tbddlPayment.SelectedValue == "Diesel Card")
                {
                    tbFCCard.Text = FCCardNo.ToString();
                    if (lblError.Text == "")
                    {
                        if (tbFCCard.Text == "")
                        {
                            lblError.Visible = true;
                            lblError.Text = "FO ledger is not activated for this vehicle FC card !!! Please check";
                        }
                    }
                }
                else
                {
                    tbFCCard.Text = "";
                }
            }
        }
    }

    //protected void Diesel_Oil_Calc(object sender, EventArgs e)
    //{
        //double mDieselQty, mDieselRate,mOilQty,mOilRate, mAmt, mTotAmt;
        //mTotAmt = 0;
        //Double tot_diesel = 0;
        //MyFleetDataSet.HSD_OIL_EXPRow datarow_OilExp;
        //foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        //{
        //    datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
        //    if (gridrow.ItemIndex != -1)
        //    {
        //        TextBox tbDieselQty = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtDiesel_Ltr");
        //        TextBox tbDieselRate = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtDieselRate_Ltr");
        //        //TextBox tbOilQty = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtOil_Ltr");
        //        //TextBox tbOilRate = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtOilRate_Ltr");
        //        TextBox tbAmt = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtAmt");
        //        mDieselQty = Convert.ToDouble(tbDieselQty.Text.ToString());
        //        mDieselRate = Convert.ToDouble(tbDieselRate.Text.ToString());
        //        mOilQty = Convert.ToDouble("0.0");
        //        mOilRate = Convert.ToDouble("0.0");
        //        mAmt = (mDieselQty * mDieselRate) + (mOilQty * mOilRate);
        //        mTotAmt = Convert.ToDouble(mTotAmt) + Convert.ToDouble(mAmt);
        //        tbAmt.Text = mAmt.ToString();
        //        _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_OilExp.ItemArray;
        //    }
        //}
        //foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        //{
        //   string   mDiesel=   ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
        //   if (mDiesel != "")
        //   {
        //       tot_diesel = tot_diesel + Convert.ToDouble(mDiesel);
        //   }
        //}
        //txtFuelFilledEnroute.Text = tot_diesel.ToString();
        //Double Total = 0, TotalFuel = 0, IntFuelFilled = 0, KMPL=0;
        //if (txtFuelFilledEnroute.Text != "" && txtFuelFilled.Text != "" && txtTotalKms.Text!="")
        //{
        //    Total = Convert.ToDouble(txtFuelFilledEnroute.Text);
        //    IntFuelFilled = Convert.ToDouble(txtFuelFilled.Text);
        //    TotalFuel = Total + IntFuelFilled;
        //    if (TotalFuel != 0)
        //    {
        //        KMPL = (Convert.ToDouble(txtTotalKms.Text) / TotalFuel);
        //    }
        //    //lblKMPL.Text = KMPL.ToString("0.00");
        //    txtKMPL.Text = KMPL.ToString("0.00");
        //}
    //}
    protected void SubmitData(object sender, EventArgs e)
    {
        //try
        {
            TripSheet objTripSheet = new TripSheet(str_Connection_String);
            double mTotAdvExp = 0, mTotOilExp = 0, mTotRepairExp = 0, mTotIncDedExp = 0, mTotEnrouteExp = 0, mTotClaimsExp = 0, mTotSpareExp = 0;

            string mTripSheetNo = "";
            string sql = "";
            string sqlDEL = "";
            SqlCommand cmdDEL = new SqlCommand();

            lblError.Text = "";
            lblError1.Text = "";
            string StartKM, CloseKM;
            double mStartKM, mCloseKM;
            //string mReqId = "";
            //txtCloseKM
            //txtCloseKM.Text = "0.0";
            
            if (txtCloseKM.Text == "")
            {
                lblError.Text = "Enter Closing KM";
                return;
            }
            else
            {
                StartKM = lblStartKm.Text;
                CloseKM = txtCloseKM.Text;

                mStartKM = Convert.ToDouble(StartKM.ToString());
                mCloseKM = Convert.ToDouble(CloseKM.ToString());
                if (mCloseKM < mStartKM)
                {
                    lblError.Text = "Closing KM should be greater than Starting KM.";
                }
            }
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            //DateTime mServerDt = new DateTime;
            DateTime mServerDt = DateTime.Now;
            //sResponse.Write("###mServerDt : " + mServerDt);
            DateTime mIssueDt = new DateTime();
            mIssueDt = Convert.ToDateTime(lblIssueDt.Text.ToString(), dtfi);
            DateTime mCloseDt = new DateTime();
            mCloseDt = Convert.ToDateTime(txtDateFrom.CalendarDate.ToString(), dtfi);

            //if (Session["FinYear_Change"] != null)
            {
                DateTime dtFrom = new DateTime();
                DateTime dtTo = new DateTime();
                string From = "", To = "";
                From = "01/04/" + SessionUtilities.FinYear.ToString().Trim();
                To = "31/03/" + Convert.ToDouble(Convert.ToDouble(SessionUtilities.FinYear.ToString().Trim()) + 1);
                dtFrom = Convert.ToDateTime(From, dtfi);
                dtTo = Convert.ToDateTime(To, dtfi);
                if (mCloseDt >= dtFrom && mCloseDt <= dtTo)
                {
                    lblError.Visible = false;
                    lblError.Text = "";
                }
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Close date  should be  in the  range of selected  financial year!";
                }
            }

            if (lblError.Text.Trim() == "")
            {
                if (mCloseDt < mIssueDt)
                {
                    lblError.Visible = true;
                    lblError.Text = "Close Date cannot be less than Issue Slip Date !";
                }
                if (mCloseDt > mServerDt)
                {
                    lblError.Visible = true;
                    lblError.Text = "Close Date cannot be greater than today's Date !";
                }
            }
            #region dgAdvanceDet
            foreach (DataGridItem gridrow in dgAdvanceDet.Items)
            {
                DateTime mAdvDt = new DateTime();
                mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);
                if (lblError.Text.Trim() == "")
                {
                    if (mAdvDt > mServerDt)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Advance Date should not be greater than today's date!";
                    }
                    if (mAdvDt < mIssueDt)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Advance Date should not be less than Issue Slip Date!";
                    }
                }
            }
            #endregion
            #region dgHSD_OIL_EXP
            
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                Double LKmRead = 0, currKm = 0;
                if (((TextBox)gridrow.FindControl("txtLKmRead")).Text != "")
                {
                    LKmRead = Convert.ToDouble(((TextBox)gridrow.FindControl("txtLKmRead")).Text);
                }
                if (((TextBox)gridrow.FindControl("txtKM_Reading")).Text != "")
                {
                    currKm = Convert.ToDouble(((TextBox)gridrow.FindControl("txtKM_Reading")).Text);
                }
                if (lblError.Text.Trim() == "")
                {
                    if (LKmRead > currKm)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Current Km Reading should always be greater than last Km Reading";
                    }
                }
            }
            #endregion
            #region dgHSD_OIL_EXP
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                DateTime mBilldt = new DateTime();
                mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);
                if (lblError.Text.Trim() == "")
                {
                    if (mBilldt > mServerDt)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Bill Date should not be greater than today's date for HSD/OIL Expenses!";
                    }
                    if (mBilldt < mIssueDt)
                    {
                        lblError.Visible = true;
                        lblError.Text = "Bill Date should not be less than Issue Slip Date for HSD/OIL Expenses!";
                    }
                }
            }
            #endregion
            #region dgHSD_OIL_EXP
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                if (gridrow.ItemIndex != -1)
                {
                    Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                    DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                    string FCCardNo = "";
                    //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    //conn.Open();
                    DataTable dtFuelCard = new DataTable();
                    string msql = "select Manual_Fuel_Card_No from WEBX_FLEET_FUELCARD where Vehicle_No='" + lblVehno.Text + "'";
                    //SqlCommand cdR = new SqlCommand(msql, conn);
                    //SqlDataReader cdDR = cdR.ExecuteReader();
                    dtFuelCard = objTripSheet.ExecuteSql(msql);
                    if (dtFuelCard.Rows.Count>0)
                    {
                        //while (cdDR.Read())
                        {
                            FCCardNo = Convert.ToString(dtFuelCard.Rows[0]["Manual_Fuel_Card_No"]);
                        }
                    }
                    //cdDR.Close();
                    //conn.Close();
                    if (tbddlPayment.SelectedValue == "Diesel Card")
                    {
                        tbFCCard.Text = FCCardNo.ToString();
                        if (lblError.Text == "")
                        {
                            if (tbFCCard.Text == "")
                            {
                                lblError.Visible = true;
                                lblError.Text = "*FO ledger is not activated for this vehicle FC card !!! Please check";
                            }
                        }
                    }
                    else
                    {
                        tbFCCard.Text = "";
                    }
                }
            }
            #endregion
     

            string strEnd_dt_tm = "";
            string THC_Attached_YN = "", mEndLoc = "";
            DataTable dt = new DataTable();
            string ctr = "select  THC_ATTACHED_YN ,Tripsheet_EndLoc,End_dt_tm from WEBX_FLEET_VEHICLE_ISSUE where VslipNo='" + Session["Tripsheet"].ToString() + "'";
            dt = objTripSheet.ExecuteSql(ctr);
            if (dt.Rows.Count>0)
            {
                THC_Attached_YN = Convert.ToString(dt.Rows[0]["THC_ATTACHED_YN"]);
                mEndLoc = Convert.ToString(dt.Rows[0]["Tripsheet_EndLoc"]);
                strEnd_dt_tm = Convert.ToString(dt.Rows[0]["End_dt_tm"]);
            }
            if (lblError.Text == "")
            {
                if (mEndLoc.Trim() != SessionUtilities.CurrentBranchCode.ToString().Trim())
                {
                    lblError.Visible = true;
                    lblError.Text = "Tripsheet is not allowed to close  at this location!";
                }
            }
            if (lblError.Text == "")
            {
                //if (THC_Attached_YN == "")
                //{
                //    lblError.Visible = true;
                //    lblError.Text = "No THCs are Attached ,Hence Tripsheet cannot be closed!";
                //}
                //if (THC_Attached_YN == "Y")
                //{
                //    lblError.Visible = true;
                //    lblError.Text = "THC is already attached with this Tripsheet,So Tripsheet cannot be Closed!";
                //}
                //if (THC_Attached_YN == "N")
                //{
                //    lblError.Text = "";
                //}
                //conn.Close();
            }
            if (lblError.Text == "" && lblError1.Text == "")
            {
                mTripSheetNo = lblIssueNo.Text.ToString();
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                bool success = false;
                SqlTransaction trans;
                conn.Open();
                trans = conn.BeginTransaction();
                try
                {
                    SqlCommand cmd = new SqlCommand("usp_CloseVehicleIssue", conn, trans);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
                    cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = Session["strDriverCode"].ToString();
                    cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.ToString();
                    if (txtCloseKM.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = txtCloseKM.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = "0";
                    }
                    if (txtFuelFilledEnroute.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@f_closure_fill", SqlDbType.Float).Value = txtFuelFilledEnroute.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@f_closure_fill", SqlDbType.Float).Value = "0";
                    }
                    //cmd.Parameters.Add("@AKMPL ", SqlDbType.Float).Value = lblKMPL.Text.ToString();
                    if (txtKMPL.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@AKMPL ", SqlDbType.Float).Value = txtKMPL.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@AKMPL ", SqlDbType.Float).Value = "0";
                    }
                    
                    if (txtApprKMPL.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@APPKMPL", SqlDbType.Float).Value = txtApprKMPL.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@APPKMPL", SqlDbType.Float).Value = "0";
                    }
                    cmd.Parameters.Add("@Contractamt", SqlDbType.Float).Value = "0";// txtContractAmt.Text.ToString();
                    cmd.Parameters.Add("@c_Othercharg", SqlDbType.Float).Value = "0";// txtOtherCharge.Text.ToString();
                    cmd.Parameters.Add("@c_TDSrate", SqlDbType.Float).Value = "0";// txtTDSRate.Text.ToString();
                    cmd.Parameters.Add("@c_TDSamt", SqlDbType.Float).Value = "0";//txtTDSAmt.Text.ToString();
                    cmd.Parameters.Add("@c_TDStype", SqlDbType.VarChar).Value = "0";// txtTDSType.Text.ToString();
                    cmd.Parameters.Add("@c_Advamt_paid", SqlDbType.Float).Value = "0";// txtAdvancePaid.Text.ToString();
                    cmd.Parameters.Add("@c_issue_tot", SqlDbType.Float).Value = "0";//lblCustIssueTot.Text.ToString();
                    cmd.Parameters.Add("@c_dedamt", SqlDbType.Float).Value = "0";//txtContractDed.Text.ToString();
                    cmd.Parameters.Add("@c_Balamt_paid", SqlDbType.Float).Value = "0";// txtBalPaid.Text.ToString();
                    cmd.Parameters.Add("@c_closure_tot", SqlDbType.Float).Value = "0";// lblCustIssueTot.Text.ToString();
                    cmd.Parameters.Add("@c_net_amt", SqlDbType.Float).Value = "0";// lblCustNet.Text.ToString();

                    cmd.Parameters.Add("@e_issue_advamt", SqlDbType.Float).Value = "0";// txtAdvDriver.Text.ToString();
                    cmd.Parameters.Add("@e_issue_spare", SqlDbType.Float).Value = "0";// txtExpSpares.Text.ToString();
                    cmd.Parameters.Add("@e_issue_fuel", SqlDbType.Float).Value = "0";// txtExpFuel.Text.ToString();
                    cmd.Parameters.Add("@e_issue_comm", SqlDbType.Float).Value = "0";// txtComm.Text.ToString();
                    cmd.Parameters.Add("@e_closure_balamt", SqlDbType.Float).Value = "0";// txtBalDriver.Text.ToString();
                    cmd.Parameters.Add("@e_closure_incentive", SqlDbType.Float).Value = "0";//txtIncentive.Text.ToString();
                    cmd.Parameters.Add("@e_closure_deposit", SqlDbType.Float).Value = "0";// txtDeposit.Text.ToString();
                    cmd.Parameters.Add("@e_closure_dedamt", SqlDbType.Float).Value = "0";// txtExpenseDed.Text.ToString();
                    cmd.Parameters.Add("@e_issue_totamt", SqlDbType.Float).Value = "0";// lblExpIssueTot.Text.ToString();
                    cmd.Parameters.Add("@e_closure_totamt", SqlDbType.Float).Value = "0";// lblExpCloseTot.Text.ToString();
                    cmd.Parameters.Add("@e_net_amt", SqlDbType.Float).Value = "0";// lblExpTot.Text.ToString();
                    cmd.Parameters.Add("@Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDateFrom.CalendarDate.Trim(), dtfi);// lblExpTot.Text.ToString();
                    cmd.ExecuteNonQuery();

                    //Session["strDriverCode"] = null;
                    sqlDEL = "Delete from WEBX_FLEET_VEHICLE_ISSUE_PARTDET where VSlipNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    //cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();
                 
                    #region dgHSD_OIL_EXP
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;

                        ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                        ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                        ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

                        ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                        //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;

                        ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                        ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                        ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;

                        ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                        //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = true;
                    }
                    #endregion
                    string strFuelPayType = " and Card_Cash not in ('Credit Card','Credit')";
                    sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'" + strFuelPayType;
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();
                    #region dgHSD_OIL_EXP
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                        string mPPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Text;
                        string mBrand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Text;
                        string mFuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Text;
                        string mLastKm = ((TextBox)gridrow.FindControl("txtLKmRead")).Text;
                        string mCard_Cash = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Text;
                        string mRemark = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
                        string mKM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
                        string mBillno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
                        DateTime mBilldt = new DateTime();
                        mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);
                        string mDiesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
                        //string mOil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
                        string mOil_Ltr = "0.0";
                        string mDiesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
                        //string mOil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
                        string mOil_Rate = "0.0";
                        string mAmt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                        string mExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                        mTotOilExp = mTotOilExp + Convert.ToDouble(mExeAmt);
                        if (mCard_Cash != "Credit" && mCard_Cash != "Credit Card")
                        {
                            sql = " Insert into WEBX_TRIPSHEET_OILEXPDET (TripSheetNo,Place,KM_Reading,BillNo,BillDt,Diesel_Ltr,Oil_Ltr,Amount,Diesel_Rate,Oil_Rate,PetrolPName,Brand,FuelType,Last_Km_Read,Card_Cash,Remark,Exe_Amt) values ( "
                                 + "'" + mTripSheetNo + "', '" + mOilPlace + "','" + mKM_Reading + "','" + mBillno + "','" + mBilldt + "','" + mDiesel_Ltr + "','" + mOil_Ltr + "','" + mAmt + "'," + mDiesel_Rate + "," + mOil_Rate + ",'" + mPPName + "','" + mBrand + "','" + mFuelType + "','" + mLastKm + "','" + mCard_Cash + "','" + mRemark + "','" + mExeAmt + "') ";
                            SqlCommand HSDOilDetail = new SqlCommand(sql, conn, trans);
                            HSDOilDetail.CommandType = CommandType.Text;

                            //datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
                            //_dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;
                            HSDOilDetail.ExecuteNonQuery();
                        }
                        datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
                        _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;
                    }
                    #endregion

                    string mActual_KMPL = "0";
                    string mActual_Approved = "0";
                    string mApproved_Ltr = "0";
                    string mApproved_Rate = "0";
                    string mApproved_Amt = "0";
                    string mAmount = mTotOilExp.ToString();

                    sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPHDR where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();


                    sql = " Insert into WEBX_TRIPSHEET_OILEXPHDR (TripSheetNo,Actual_KMPL,Actual_Approved,Approved_Ltr,Approved_Rate,Approved_Amt,Amount) values ( "
                            + "'" + mTripSheetNo + "','" + mActual_KMPL + "','" + mActual_Approved + "','" + mApproved_Ltr + "','" + mApproved_Rate + "','" + mApproved_Amt + "','" + mAmount + "') ";
                    SqlCommand HSDOilHeader = new SqlCommand(sql, conn, trans);
                    HSDOilHeader.CommandType = CommandType.Text;
                    HSDOilHeader.ExecuteNonQuery();

                    sqlDEL = "Delete from WEBX_TRIPSHEET_REPAIREXP where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                 

                    sqlDEL = "Delete from WEBX_TRIPSHEET_INCDED where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();
               

                  

                    if (lblCategory.Text == "External Usage")
                    {
                        sqlDEL = "Delete from WEBX_FLEET_TRIPTHCDET where TripSheetNo='" + mTripSheetNo + "'";
                        cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                        cmdDEL.ExecuteNonQuery();
                        cmdDEL.Dispose();
                        foreach (DataGridItem gridrow in dgTHC.Items)
                        {
                            string sqlContract = "usp_TripTHCDetailInsert";
                            SqlCommand sqlcmdContract = new SqlCommand(sqlContract, conn, trans);
                            sqlcmdContract.CommandType = CommandType.StoredProcedure;
                            sqlcmdContract.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
                            sqlcmdContract.Parameters.Add("@Custcode", SqlDbType.VarChar).Value = lblCustcodeMarket.Text.ToString();
                            sqlcmdContract.Parameters.Add("@FromCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtFrom")).Text;
                            sqlcmdContract.Parameters.Add("@ToCity", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtTo")).Text;
                            sqlcmdContract.Parameters.Add("@THCNo", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtTHCNo")).Text;
                            sqlcmdContract.Parameters.Add("@THCDt", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtTHCDt")).Text;
                            sqlcmdContract.Parameters.Add("@FreightAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtFreightAmt")).Text);
                            sqlcmdContract.Parameters.Add("@LabourCharges", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtLabourChrg")).Text);
                            sqlcmdContract.Parameters.Add("@OtherCharges", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtOtherChrg")).Text);
                            sqlcmdContract.Parameters.Add("@TotalAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text);
                            datarow_THCContract = _dataSet.THCContract[gridrow.DataSetIndex];
                            _dataSet.THCContract[gridrow.DataSetIndex].ItemArray = datarow_THCContract.ItemArray;
                            sqlcmdContract.ExecuteNonQuery();
                        }
                    }
                    sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();
                 
                    #region gvEnroute

                    foreach (GridViewRow gridrow in gvEnroute.Rows)
                    {
                        DropDownList ddlNExpense = (DropDownList)gvEnroute.Rows[gridrow.RowIndex].Cells[1].FindControl("ddlNExpense");
                        TextBox txtAmount = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[2].FindControl("txtAmount");
                        TextBox txtBillNo = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[3].FindControl("txtBillNo");
                        TextBox txtDate = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[4].FindControl("txtDate");
                        TextBox txtEAmt = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("txtEAmt");
                        TextBox txtRemark = (TextBox)gvEnroute.Rows[gridrow.RowIndex].Cells[6].FindControl("txtRemark");
                        HiddenField hfEAmt = (HiddenField)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("hfEAmt");
                        HiddenField hfPolarity = (HiddenField)gvEnroute.Rows[gridrow.RowIndex].Cells[5].FindControl("hfPolarity");
                        TextBox txtEnAmtTotal = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtEnAmtTotal");

                        if (ddlNExpense.SelectedValue != "0")
                        {
                            string sqlEnroute = "USP_INSERT_ENROUTE_EXP";

                            SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                            sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                            sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = mTripSheetNo;
                            sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = ddlNExpense.SelectedValue;
                            if (txtAmount.Text.ToString() != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                            }
                            else
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                            }
                            sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                            if (hfEAmt.Value != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble(hfEAmt.Value.ToString());
                            }
                            else
                            {
                                if (txtEAmt.Text != "")
                                {
                                    sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble(txtEAmt.Text.ToString());
                                }
                                else
                                {
                                    sqlcmdEnRoute.Parameters.Add("@Exe_Appr_Amt", SqlDbType.Float).Value = Convert.ToDouble("0");
                                }
                            }

                            sqlcmdEnRoute.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemark.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@Polarity", SqlDbType.VarChar).Value = hfPolarity.Value.ToString();
                            if (txtEnAmtTotal.Text.Trim() != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@TotEnrouteExp", SqlDbType.VarChar).Value = Convert.ToDouble(txtEnAmtTotal.Text.ToString());
                            }
                            else
                            {
                                sqlcmdEnRoute.Parameters.Add("@TotEnrouteExp", SqlDbType.VarChar).Value = Convert.ToDouble("0.0");
                            }
                            datarow_EnExp = _dataSet.EnExpense[gridrow.RowIndex];
                            _dataSet.EnExpense[gridrow.RowIndex].ItemArray = datarow_EnExp.ItemArray;
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }

                    #endregion

                    string mPreparedBy = txtPreparedBy.Text;
                    string mCheckedBy = txtCheckedBy.Text;
                    string mApprovedBy = txtApprovedBy.Text;
                    string mAuditedBy = txtAuditedBy.Text;

                    string sqlfinstr = "";
                    if (modeval == "FE")
                    {

                        sqlfinstr = ",finupdt_dt=getdate(),finupdt_by='" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "'";
                    }
                    else
                    {
                        sqlfinstr = ",expacc_entry='N'";
                    }

                    sql = "Update WEBX_FLEET_VEHICLE_ISSUE set TotAdvExp='" + mTotAdvExp + "',TotOilExp='" + mTotOilExp + "',TotRepairExp='" + mTotRepairExp + "',TotIncDedExp='" + mTotIncDedExp + "',TotEnrouteExp='" + mTotEnrouteExp + "',TotClaimsAmt='" + mTotClaimsExp + "',TotSpareExp='" + mTotSpareExp + "', PreparedBy='" + mPreparedBy + "',CheckedBy='" + mCheckedBy + "',ApprovedBy='" + mApprovedBy + "',AuditedBy='" + mAuditedBy + "'" + sqlfinstr + "  Where VSlipNo ='" + mTripSheetNo + "' ";
                    SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
                    TripHeader.CommandType = CommandType.Text;
                    TripHeader.ExecuteNonQuery();







                    sql = " Update webx_vehicle_hdr set Vehicle_Status='Available'   ,current_KM_Read='" + txtCloseKM.Text.ToString().Trim() + "'   where vehno='" + lblVehno.Text + "'";
                    SqlCommand VH = new SqlCommand(sql, conn, trans);
                    VH.CommandType = CommandType.Text;
                    VH.ExecuteNonQuery();


                    SqlCommand cdCurLoc = new SqlCommand(" Update WEBX_VEHICLE_HDR set CURLOC='" + lblEndLoc.Text.ToString().Trim() + "' where VEHNO='" + lblVehno.Text.ToString().Trim() + "'", conn, trans);
                    cdCurLoc.CommandType = CommandType.Text;
                    cdCurLoc.ExecuteNonQuery();


                    sql = " Update WEBX_FLEET_DRIVERMST set Driver_Status='Available' where Driver_id in (select driver1  from WEBX_FLEET_VEHICLE_ISSUE  where VSlipNo='" + mTripSheetNo + "')";
                    SqlCommand VD = new SqlCommand(sql, conn, trans);
                    VD.CommandType = CommandType.Text;
                    VD.ExecuteNonQuery();


                    sql = " Update WEBX_FLEET_DRIVERMST set Driver_Status='Available' where Driver_id in (select  (CASE  WHEN ISNUMERIC(driver2)=0  THEN 0  ELSE  DRIVER2 END)  from WEBX_FLEET_VEHICLE_ISSUE  where VSlipNo='" + mTripSheetNo + "')";
                    SqlCommand VD1 = new SqlCommand(sql, conn, trans);
                    VD1.CommandType = CommandType.Text;
                    VD1.ExecuteNonQuery();
                    lblError1.Text = "";
                    //TextBox txtEnAmtTotal = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtEnAmtTotal");
                    //TextBox txtETotalAmt = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtETotalAmt"); 
                    double TotExpenseAmt = 0;
                    if (hfETotalAmt.Value.ToString() != "")
                    {
                        TotExpenseAmt = mTotOilExp + mTotEnrouteExp + mTotRepairExp + mTotIncDedExp + mTotClaimsExp + mTotSpareExp + Convert.ToDouble(hfETotalAmt.Value.ToString());
                    }
                    else
                    {
                        TotExpenseAmt = mTotOilExp + mTotEnrouteExp + mTotRepairExp + mTotIncDedExp + mTotClaimsExp + mTotSpareExp + Convert.ToDouble("0");
                    }
                    if (TotExpenseAmt <= 0)
                    {
                        lblError1.Text = "Expense amount can not be ZERO !!! Please check.";
                        trans.Rollback();
                        success = false;
                        //Response.End();
                    }

                    if (lblError1.Text == "")
                    {
                        trans.Commit();
                        //trans.Rollback();
                        success = true;
                        Session["strDriverCode"] = null;
                    }
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
                }
                if (success)
                {
                    Response.Redirect("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
                    //Server.Transfer("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=" + modeval, true);
                }
            }
        }
        //catch (Exception e1)
        //{
        //    Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
        //    Response.End();
        //}
    }

    
    //protected void DataGrid3_ItemDataBound(object sender, DataGridItemEventArgs e)
    //{
    //    if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
    //    {
    //        datarow_EnExp = ((MyFleetDataSet.EnExpenseRow)((DataRowView)e.Item.DataItem).Row);
    //        //((DropDownList)e.Item.FindControl("cboAdvPlace")).SelectedValue = datarow_Adv.AdvPlace;
    //        ((Label)e.Item.FindControl("lblNExpense")).Text = datarow_EnExp.NExpense;

    //        ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_EnExp.Amount;
    //        ((TextBox)e.Item.FindControl("txtBillNo")).Text = datarow_EnExp.BillNo;
    //        ((TextBox)e.Item.FindControl("txtDate")).Text = datarow_EnExp.Date;
    //        ((TextBox)e.Item.FindControl("txtEAmt")).Text = datarow_EnExp.EAmt;
    //        ((TextBox)e.Item.FindControl("txtRemark")).Text = datarow_EnExp.Remarks;
    //    }
    //    if ((e.Item.ItemType == ListItemType.Footer || e.Item.ItemType == ListItemType.Footer))
    //    {
    //        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //        conn.Open();
    //        string Amt = "", ExeAmt = "";
    //        string STR = "select  sum(amount_spent)  as amount, sum(EXE_Appr_amt)  as exeAmt  from WEBX_FLEET_ENROUTE_EXP  where TripsheetNo='" + Session["Tripsheet"].ToString().Trim() + "' ";
    //        SqlCommand tcmd = new SqlCommand(STR, conn);
    //        SqlDataReader tdr = tcmd.ExecuteReader();
    //        if (tdr.HasRows)
    //        {
    //            while (tdr.Read())
    //            {
    //                Amt = Convert.ToString(tdr["amount"]);
    //                ExeAmt = Convert.ToString(tdr["exeAmt"]);
    //            }
    //        }
    //        tdr.Close();
    //        conn.Close();
    //        ((TextBox)e.Item.FindControl("txtEnAmtTotal")).Text = Amt.ToString();
    //        ((TextBox)e.Item.FindControl("txtETotalAmt")).Text = ExeAmt.ToString();
    //    }
    //}

    //protected void txtKM_Reading_TextChanged(object sender, EventArgs e)
    //{
        //foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        //{
        //    if (((Label)gridrow.FindControl("txtLKmRead")).Text != "")
        //    {
        //        temp1 = ((Label)gridrow.FindControl("txtLKmRead")).Text;
        //    }
        //    if (lblError1.Text == "")
        //    {
        //        if (temp != "")
        //        {
        //            ((Label)gridrow.FindControl("txtLKmRead")).Text = temp;
        //        }
        //    }
        //    temp = "";
        //    if (((TextBox)gridrow.FindControl("txtKM_Reading")).Text != "")
        //    {
        //        temp = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
        //    }
        //    if (temp != "" && temp1 != "")
        //    {
        //        if (Convert.ToDouble(temp) < Convert.ToDouble(temp1))
        //        {
        //            if (lblError1.Text == "")
        //            {
        //                lblError1.Visible = true;
        //                lblError1.Text = "Current km reading cannot be less than last km reading!";
        //            }
        //        }
        //        else
        //        {
        //            lblError1.Visible = true;
        //            lblError1.Text = "";
        //        }
        //    }
        //    if (lblStartKm.Text.ToString().Trim() != "")
        //    {
        //        first_km = Convert.ToDouble(lblStartKm.Text.ToString().Trim());
        //    }
        //    if (temp != "")
        //    {
        //        current_km = Convert.ToDouble(temp);
        //    }
        //    string CloseKM = txtCloseKM.Text;
        //    string StartKm = lblStartKm.Text;
        //    Double mCloseKM=0;
        //    Double mStartKm=0;
        //    Double Tot_Km = 0;
        //    if (StartKm != "" && CloseKM != "")
        //    {
        //        mCloseKM = Convert.ToDouble(CloseKM);
        //        mStartKm = Convert.ToDouble(StartKm);
        //        Tot_Km = (mCloseKM - mStartKm);
        //    }
        //}
    //}
    //protected void txtFuelFilledEnroute_TextChanged(object sender, EventArgs e)
    //{

    //}
    //protected void txtCloseKM_TextChanged(object sender, EventArgs e)
    //{
    //    Double mCloseKM = 0;
    //    Double mStartKm = 0;
    //    if (lblStartKm.Text != "")
    //    {
    //        mStartKm = Convert.ToDouble(lblStartKm.Text);
    //    }
    //    if (txtCloseKM.Text != "")
    //    {
    //        mCloseKM = Convert.ToDouble(txtCloseKM.Text);
    //    }
    //    if (lblStartKm.Text != "" && txtCloseKM.Text != "")
    //    {
    //        if (mCloseKM < mStartKm)
    //        {
    //            //lblError1.Text = "Close Km Cannot  be less than  Start Km!";
    //            lbl_Closing_KM_Err.Text = "Close Km Cannot  be less than  Start Km!";
    //            txtTotalKms.Text = "";
    //        }
    //        else
    //        {
    //            lblError1.Text = "";
    //            Double Total = mCloseKM - mStartKm;

    //            if (Total > 10000)
    //            {
    //                lbl_Closing_KM_Err.Text = "Trip sheet total km should not be greater than 10,000 Km!";
    //                txtTotalKms.Text = "";
    //            }
    //            else
    //            {
    //                txtTotalKms.Text = Total.ToString();

    //                Double mKMPL = 0;
    //                mKMPL = Convert.ToDouble(txtTotalKms.Text.ToString()) / Convert.ToDouble(hfKMPL.Value);
    //                lblApprovedDiesel.Text = mKMPL.ToString("0.00");

    //                Double mApprovedFuelAmt = 0;
    //                mApprovedFuelAmt = Convert.ToDouble(lblApprovedDiesel.Text) * Convert.ToDouble(lblAverageDieselRate.Text);
    //                lblApprovedFuelAmt.Text = mApprovedFuelAmt.ToString("0.00");
    //            }
    //        }
    //    }
    //    Double mTotal = 0, mTotalFuel = 0, IntFuelFilled = 0, KMPL = 0;
    //    if (txtFuelFilledEnroute.Text != "" && txtFuelFilled.Text != "" && txtTotalKms.Text != "")
    //    {
    //        mTotal = Convert.ToDouble(txtFuelFilledEnroute.Text);
    //        IntFuelFilled = Convert.ToDouble(txtFuelFilled.Text);
    //        mTotalFuel = mTotal + IntFuelFilled;
    //        if (mTotalFuel != 0)
    //        {
    //            KMPL = (Convert.ToDouble(txtTotalKms.Text) / mTotalFuel);
    //        }
    //        lblKMPL.Text = KMPL.ToString("0.00");
    //    }



    //}

    protected void txtCAddRow_TextChanged(object sender, EventArgs e)
    {
        //string rowno;
        //int mroww = 0;
        //int miroww = 0;
        //rowno = txtCAddRow.Text;
        //mroww = Convert.ToInt16(rowno);
        //int i;
        //int iroww = 0;
        //foreach (DataGridItem gridrow in dgClaims.Items)
        //{
        //    iroww = iroww + 1;
        //}
        //miroww = iroww;
        //if (mroww < miroww)
        //{
        //    miroww = mroww;
        //}
        //if (iroww >= 0)
        //{
        //    for (i = iroww - 1; i > -1 + miroww; i--)
        //    {
        //        _dataSet.Claims.RemoveClaimsRow(_dataSet.Claims[i]);
        //    }
        //}
        //for (i = 0 + miroww; i < Int16.Parse(txtCAddRow.Text); i++)
        //{
        //    _dataSet.Claims.AddClaimsRow("", "", "", "");
        //}
        //BindGrid();
    }
    #region new En-Route Expense
    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddlNExpense = (DropDownList)e.Row.FindControl("ddlNExpense");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            TextBox txtEAmt = (TextBox)e.Row.FindControl("txtEAmt");
            TextBox txtDate = (TextBox)e.Row.FindControl("txtDate");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
            
            BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);
            txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtDate.Attributes.Add("OnBlur", "javascript:ValidDate(" + txtDate.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");

            ddlNExpense.Attributes.Add("onChange", "return CheckValidExp(" + e.Row.RowIndex + "," + ddlNExpense.ClientID.ToString() + "," + txtEAmt.ClientID.ToString() + "," + hfEAmt.ClientID.ToString() + "," + hfPolarity.ClientID.ToString() + ");");
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dtEnExpense.Clear();
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            dtEnExpense.AddEnExpenseRouteRow("", "", "", "", "", "", "");
        }
        tb_Row_No.Text = "0";
        BindGridEnExpense();
        ///lbl_Page_Error.Text = "";
    }

    private void BindGridEnExpense()
    {
        gvEnroute.DataSource = dtEnExpense;
        gvEnroute.DataBind();
    }

    #endregion 
}
