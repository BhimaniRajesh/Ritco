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
using ApplicationManager;

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
    MyFleetDataSet.VehicleLogEntryRow datarow_VehicleLogEntry;



    public string strPolarity = "";
    public double totExAmt = 0, totStandardAmt = 0;

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

    string Category = "", CustCode = "", Market_Own = "", StartLoc = "", EndLoc = "";
    public string modeval = "";
    SqlConnection conn;

    //public string strDriverCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
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


            //TextBox txt_Date = (TextBox)txtDateFrom.FindControl("txt_Date");
            txtDateFrom.Attributes.Add("OnBlur", "javascript:ValidCloseDateFinance(" + lblIssueNo.ClientID.Trim() + "," + txtDateFrom.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");
            txtDateOpClose.Attributes.Add("OnBlur", "javascript:ValidCloseDateOperational(" + txtDateOpClose.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");


            txtTotalKms.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtApprKMPL.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
            txtApprovedDiesel.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtAddRowOilExp.ClientID.ToString() + "').focus();");
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
                cmdOpClose.Visible = false;
            }
            Session["Tripsheet"] = null;
            Session["Tripsheet"] = stVSlipId;
            System.DateTime righnow = System.DateTime.Today;


            //DateTime StartDate = DateTime.ParseExact(txtStartDate.Text + " " + ddlFromHours.SelectedValue + ":" + ddlFromMinutes.SelectedValue, "MM/dd/yyyy HH:mm",
            //System.Globalization.CultureInfo.InvariantCulture);

            //DateTime EndDate = DateTime.ParseExact(txtStartDate.Text + " " + ddlToHours.SelectedValue + ":" + ddlToMinutes.SelectedValue, "MM/dd/yyyy HH:mm",
            //System.Globalization.CultureInfo.InvariantCulture);
            try
            {
                TripSheet objTripSheet = new TripSheet(str_Connection_String);

                objTripSheet.CheckTripRule();
                if (objTripSheet.Diff_Bet_CloseKM_StartKM == "Y")
                {
                    hf_CloseKMGreater10K.Value = "Y";
                }
                else
                {
                    hf_CloseKMGreater10K.Value = "";
                }
                if (objTripSheet.CloseKM_Greater_Than_StartKM == "Y")
                {
                    hf_CloseKMGreater10K.Value = "N";
                }
                else
                {
                    hf_CloseKMGreater10K.Value = "";
                }
                

                ////Trip closure should not be submitted if total expense (en-route + diesel) should (I) equal to zero or (II) not equal to zero
                hf_Check_Amt_Rule.Value = "";
                if(objTripSheet.Trip_Closure_Not_Zero == "Y")
                {
                    hf_Check_Amt_Rule.Value = "N";
                }
                else if (objTripSheet.Trip_Closure_Zero == "Y")
                {
                    hf_Check_Amt_Rule.Value = "Y";
                }

                
                if (objTripSheet.VEHICLE_MODE == "Y")
                {
                    row_Vehicle_Mode.Visible = true;
                }
                else
                {
                    row_Vehicle_Mode.Visible = false;
                }

                lblDocketsLable.Text = objTripSheet.DOCKET_NO_LABEL + " Numbers ";

                DataTable dtVI = new DataTable();
                dtVI = objTripSheet.ExecuteSql("SELECT *from vw_TripSheetClose where VSlipNo= '" + stVSlipId + "'");

                //string strrightnow = righnow.ToString("dd/MM/yyyy");
                //txtDateFrom.Text = strrightnow;

                if (dtVI.Rows.Count > 0)
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

                    txtDateOpClose.Text = dtVI.Rows[0]["Oper_Close_Dt"].ToString();
                    txtDateFrom.Text = dtVI.Rows[0]["TS_Close_Dt"].ToString();

                    hfFinancialCloseDate.Value = dtVI.Rows[0]["TS_Close_Dt"].ToString();
                    hfOperationalyCloseDate.Value = dtVI.Rows[0]["Oper_Close_Dt"].ToString();

                    if (dtVI.Rows[0]["Oper_Close_Dt"].ToString() != "")
                    {
                        txtDateOpClose.Enabled = false;
                        txtCloseKM.Enabled = false;
                    }
                    else
                    {
                        txtDateOpClose.Enabled = true;
                        txtCloseKM.Enabled = true;
                    }



                    //if (dtVI.Rows[0]["Externalusage_Category"].ToString() == "02")
                    //{
                    //    rowTHCHdr.Style["display"] = "none";
                    //    rowTHCRow.Style["display"] = "none";
                    //    rowTHCDet.Style["display"] = "none";
                    //}
                    //if (dtVI.Rows[0]["Externalusage_Category"].ToString() == "01")
                    //{
                    //    rowVehicleLogHdr.Style["display"] = "none";
                    //    RowVehicleLogRow.Style["display"] = "none";
                    //    rowVehicleLogDet.Style["display"] = "none";
                    //}

                    //lblRoute.Text = dtVI.Rows[0]["rut_code"].ToString() + " : " + dtVI.Rows[0]["rutdesc"].ToString();

                    lblFTLType.Text = dtVI.Rows[0]["VehicleType"].ToString();
                    hfKMPL.Value = dtVI.Rows[0]["KMPL"].ToString();
                    lblAverageDieselRate.Text = dtVI.Rows[0]["AvgDieselRate"].ToString();
                    lblFromCity.Text = dtVI.Rows[0]["From_City"].ToString();
                    lblToCity.Text = dtVI.Rows[0]["To_City"].ToString();
                    if (dtVI.Rows[0]["rut_code"].ToString() != "0")
                    {
                        //row_Route.Visible = true;
                        //row_FTCity.Visible = false;
                        lblRoute.Text = dtVI.Rows[0]["rut_code"].ToString() + " : " + dtVI.Rows[0]["rutdesc"].ToString();
                    }
                    else
                    {
                        //row_Route.Visible = false;
                        //row_FTCity.Visible = true;
                        lblRoute.Text = dtVI.Rows[0]["From_City"].ToString() + "~" + dtVI.Rows[0]["To_City"].ToString() + "~" + dtVI.Rows[0]["From_City"].ToString();
                    }
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
                    lblExternalCategory.Text = dtVI.Rows[0]["Externalusage_Category"].ToString();

                    txtApprKMPL.Text = dtVI.Rows[0]["KMPL"].ToString();
                    //Approved_KMPL,Actual_KMPL
                    if (dtVI.Rows[0]["Category"].ToString().Trim() == "External Usage")
                    {
                        lblCustCodeHead.Visible = true;
                        lblCustcodeMarket.Text = dtVI.Rows[0]["CustCode"].ToString();

                        if (objTripSheet.ExternalUsage_Category == "Y")
                        {
                            if (dtVI.Rows[0]["Externalusage_Category"].ToString() == "Milk Run")
                            {
                                rowTHCHdr.Visible = false;
                                rowTHCRow.Visible = false;
                                rowTHCDet.Visible = false;

                                rowVehicleLogHdr.Visible = true;
                                RowVehicleLogRow.Visible = true;
                                rowVehicleLogDet.Visible = true;

                                row_Dockets.Visible = true;
                            }
                            else if (dtVI.Rows[0]["Externalusage_Category"].ToString() == "Long Haul")
                            {

                                rowTHCHdr.Visible = true;
                                rowTHCRow.Visible = true;
                                rowTHCDet.Visible = true;

                                rowVehicleLogHdr.Visible = false;
                                RowVehicleLogRow.Visible = false;
                                rowVehicleLogDet.Visible = false;

                                row_Dockets.Visible = false;
                            }
                        }
                        else if (objTripSheet.ExternalUsage_Category == "N")
                        {

                            rowTHCHdr.Visible = true;
                            rowTHCRow.Visible = true;
                            rowTHCDet.Visible = true;

                            rowVehicleLogHdr.Visible = false;
                            RowVehicleLogRow.Visible = false;
                            rowVehicleLogDet.Visible = false;
                        }
                    }

                    if (dtVI.Rows[0]["Category"].ToString().Trim() == "Internal Usage")
                    {
                        lblMarketHead.Visible = true;
                        lblCustcodeMarket.Text = dtVI.Rows[0]["Market_Own"].ToString();

                        rowTHCHdr.Visible = false;
                        rowTHCRow.Visible = false;
                        rowTHCDet.Visible = false;

                        rowVehicleLogHdr.Visible = false;
                        RowVehicleLogRow.Visible = false;
                        rowVehicleLogDet.Visible = false;
                    }
                    lblVehicleMode.Text = dtVI.Rows[0]["Vehicle_Mode"].ToString().Trim();
                    lblDockets.Text = dtVI.Rows[0]["DOCKNO"].ToString().Trim();
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
                Previous_VehicleLogEntry();

                //Previous_Claim();
                //Previous_INCDED();
                //Previous_SPARE();
                //Previous_Repair();

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
    protected void add_rowTHC(object sender, EventArgs e)
    {
        if ((txtAddTHCrow.Text == "") || (txtAddTHCrow.Text == "0")) txtAddTHCrow.Text = "0";

        _dataSet.THCContract.Rows.Clear();

        foreach (GridViewRow row in gvTHC.Rows)
        {
            TextBox txtFrom = (TextBox)row.FindControl("txtFrom");
            TextBox txtTo = (TextBox)row.FindControl("txtTo");
            TextBox txtTHCNo = (TextBox)row.FindControl("txtTHCNo");
            TextBox txtTHCDt = (TextBox)row.FindControl("txtTHCDt");
            TextBox txtFreightAmt = (TextBox)row.FindControl("txtFreightAmt");
            TextBox txtLabourChrg = (TextBox)row.FindControl("txtLabourChrg");
            TextBox txtOtherChrg = (TextBox)row.FindControl("txtOtherChrg");

            TextBox txtTHCTotalAmt = (TextBox)row.FindControl("txtTHCTotalAmt");
            _dataSet.THCContract.AddTHCContractRow(txtFrom.Text, txtTo.Text, txtTHCNo.Text, txtTHCDt.Text, txtFreightAmt.Text, txtLabourChrg.Text, txtOtherChrg.Text, txtTHCTotalAmt.Text, "", "", "");
        }
        for (int i = 0; i < Convert.ToInt32(txtAddTHCrow.Text); i++) _dataSet.THCContract.AddTHCContractRow("", "", "", "", "", "", "", "", "", "", "");
        txtAddTHCrow.Text = "0";
        gvTHC.DataSource = _dataSet.THCContract;
        gvTHC.DataBind();
    }

    protected void Add_RowVehicleLog(object sender, EventArgs e)
    {
        //if ((txtAddVehicleLogRow.Text == "") || (txtAddVehicleLogRow.Text == "0")) txtAddVehicleLogRow.Text = "0";

        //_dataSet.VehicleLogEntry.Rows.Clear();

        //foreach (GridViewRow row in gvVehicleLogEntry.Rows)
        //{
        //    TextBox txtFrom = (TextBox)row.FindControl("txtFrom");
        //    TextBox txtTo = (TextBox)row.FindControl("txtTo");
        //    TextBox txtStartDate = (TextBox)row.FindControl("txtStartDate");
        //    TextBox tb_StartTime_HH = (TextBox)row.FindControl("tb_StartTime_HH");
        //    TextBox tb_StartTime_MM = (TextBox)row.FindControl("tb_StartTime_MM");
        //    TextBox txtInvoiceNo = (TextBox)row.FindControl("txtInvoiceNo");
        //    TextBox txtStartKm = (TextBox)row.FindControl("txtStartKm");
        //    DropDownList ddlCategory = (DropDownList)row.FindControl("ddlCategory");
        //    DropDownList ddlTypeofProduct = (DropDownList)row.FindControl("ddlTypeofProduct");
        //    TextBox txtNoOfCrates = (TextBox)row.FindControl("txtNoOfCrates");
        //    TextBox txtEndDate = (TextBox)row.FindControl("txtEndDate");
        //    TextBox tb_EndTime_HH = (TextBox)row.FindControl("tb_EndTime_HH");
        //    TextBox tb_EndTime_MM = (TextBox)row.FindControl("tb_EndTime_MM");
        //    TextBox txtEndKm = (TextBox)row.FindControl("txtEndKm");
        //    TextBox txtKMRun = (TextBox)row.FindControl("txtKMRun");
        //    TextBox tb_Transit_HH = (TextBox)row.FindControl("tb_Transit_HH");
        //    TextBox tb_Transit_MM = (TextBox)row.FindControl("tb_Transit_MM");
        //    TextBox tb_IdleTime_HH = (TextBox)row.FindControl("tb_IdleTime_HH");
        //    TextBox tb_IdleTime_MM = (TextBox)row.FindControl("tb_IdleTime_MM");

        //    _dataSet.VehicleLogEntry.AddVehicleLogEntryRow(txtFrom.Text, txtTo.Text, txtStartDate.Text, tb_StartTime_HH.Text, tb_StartTime_MM.Text, txtInvoiceNo.Text, txtStartKm.Text, ddlCategory.Text, ddlTypeofProduct.Text, txtNoOfCrates.Text, txtEndDate.Text, tb_EndTime_HH.Text, tb_EndTime_MM.Text, txtEndKm.Text, txtKMRun.Text, tb_Transit_HH.Text, tb_Transit_MM.Text, tb_IdleTime_HH.Text, tb_IdleTime_MM.Text);
        //}

        //for (int i = 0; i < Convert.ToInt32(txtAddVehicleLogRow.Text); i++)
        //    _dataSet.VehicleLogEntry.AddVehicleLogEntryRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

        //txtAddVehicleLogRow.Text = "0";
        //gvVehicleLogEntry.DataSource = _dataSet.VehicleLogEntry;
        //gvVehicleLogEntry.DataBind();

        if ((txtAddVehicleLogRow.Text == "") || (txtAddVehicleLogRow.Text == "0")) txtAddVehicleLogRow.Text = "0";

        _dataSet.VehicleLogEntry.Rows.Clear();

        foreach (GridViewRow row in gvVehicleLogEntry.Rows)
        {
            TextBox txtFrom = (TextBox)row.FindControl("txtFrom");
            TextBox txtTo = (TextBox)row.FindControl("txtTo");
            TextBox txtStartDate = (TextBox)row.FindControl("txtStartDate");
            TextBox tb_StartTime_HH = (TextBox)row.FindControl("tb_StartTime_HH");
            TextBox tb_StartTime_MM = (TextBox)row.FindControl("tb_StartTime_MM");
            TextBox txtInvoiceNo = (TextBox)row.FindControl("txtInvoiceNo");
            TextBox txtStartKm = (TextBox)row.FindControl("txtStartKm");
            DropDownList ddlCategory = (DropDownList)row.FindControl("ddlCategory");
            DropDownList ddlTypeofProduct = (DropDownList)row.FindControl("ddlTypeofProduct");
            TextBox txtNoOfCrates = (TextBox)row.FindControl("txtNoOfCrates");
            TextBox txtEndDate = (TextBox)row.FindControl("txtEndDate");
            TextBox tb_EndTime_HH = (TextBox)row.FindControl("tb_EndTime_HH");
            TextBox tb_EndTime_MM = (TextBox)row.FindControl("tb_EndTime_MM");
            TextBox txtEndKm = (TextBox)row.FindControl("txtEndKm");
            TextBox txtKMRun = (TextBox)row.FindControl("txtKMRun");
            TextBox tb_Transit_HH = (TextBox)row.FindControl("tb_Transit_HH");
            TextBox tb_Transit_MM = (TextBox)row.FindControl("tb_Transit_MM");
            TextBox tb_IdleTime_HH = (TextBox)row.FindControl("tb_IdleTime_HH");
            TextBox tb_IdleTime_MM = (TextBox)row.FindControl("tb_IdleTime_MM");

            _dataSet.VehicleLogEntry.AddVehicleLogEntryRow(txtFrom.Text, txtTo.Text, txtStartDate.Text, tb_StartTime_HH.Text, tb_StartTime_MM.Text, txtInvoiceNo.Text, txtStartKm.Text, ddlCategory.Text, ddlTypeofProduct.Text, txtNoOfCrates.Text, txtEndDate.Text, tb_EndTime_HH.Text, tb_EndTime_MM.Text, txtEndKm.Text, txtKMRun.Text, tb_Transit_HH.Text, tb_Transit_MM.Text, tb_IdleTime_HH.Text, tb_IdleTime_MM.Text);
        }

        lbl_VehicleLog_Err.Text = "";
        int count = Convert.ToInt32(Session["dbVEHLogRow"].ToString());
        string rowno;
        rowno = txtAddVehicleLogRow.Text;
        int mroww = 0;

        mroww = Convert.ToInt16(rowno);

        if (mroww >= count)
        {
            int miroww = 0;
            int i;
            int iroww = 0;
            foreach (GridViewRow row in gvVehicleLogEntry.Rows)
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
                    _dataSet.VehicleLogEntry.RemoveVehicleLogEntryRow(_dataSet.VehicleLogEntry[i]);

                }
            }
            for (i = 0 + miroww; i < Int16.Parse(txtAddVehicleLogRow.Text); i++)
            {
                Double LastKm1 = 0;
                string LastKm2 = lblStartKm.Text;
                LastKm1 = Convert.ToDouble(lblStartKm.Text);
                int LastKm = Convert.ToInt32(LastKm1);
                //LastKm=LastKm+
                if (i == 0)
                {
                    _dataSet.VehicleLogEntry.AddVehicleLogEntryRow("", "", "", "", "", "", LastKm2, "", "", "", "", "", "", "", "", "", "", "", "");
                }
                else
                {
                    _dataSet.VehicleLogEntry.AddVehicleLogEntryRow("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                }
            }
        }

        // BindGrid();

        //txtAddVehicleLogRow.Text = "0";
        gvVehicleLogEntry.DataSource = _dataSet.VehicleLogEntry;
        gvVehicleLogEntry.DataBind();
    }

    protected void add_rowOil(object sender, EventArgs e)
    {
        _dataSet.THCContract.Rows.Clear();

        foreach (GridViewRow row in gvTHC.Rows)
        {
            TextBox txtFrom = (TextBox)row.FindControl("txtFrom");
            TextBox txtTo = (TextBox)row.FindControl("txtTo");
            TextBox txtTHCNo = (TextBox)row.FindControl("txtTHCNo");
            TextBox txtTHCDt = (TextBox)row.FindControl("txtTHCDt");
            TextBox txtFreightAmt = (TextBox)row.FindControl("txtFreightAmt");
            TextBox txtLabourChrg = (TextBox)row.FindControl("txtLabourChrg");
            TextBox txtOtherChrg = (TextBox)row.FindControl("txtOtherChrg");

            TextBox txtTHCTotalAmt = (TextBox)row.FindControl("txtTHCTotalAmt");
            _dataSet.THCContract.AddTHCContractRow(txtFrom.Text, txtTo.Text, txtTHCNo.Text, txtTHCDt.Text, txtFreightAmt.Text, txtLabourChrg.Text, txtOtherChrg.Text, txtTHCTotalAmt.Text, "", "", "");
        }
        gvTHC.DataSource = _dataSet.THCContract;
        gvTHC.DataBind();

        _dataSet.VehicleLogEntry.Rows.Clear();

        foreach (GridViewRow row in gvVehicleLogEntry.Rows)
        {
            TextBox txtFrom = (TextBox)row.FindControl("txtFrom");
            TextBox txtTo = (TextBox)row.FindControl("txtTo");
            TextBox txtStartDate = (TextBox)row.FindControl("txtStartDate");
            TextBox tb_StartTime_HH = (TextBox)row.FindControl("tb_StartTime_HH");
            TextBox tb_StartTime_MM = (TextBox)row.FindControl("tb_StartTime_MM");
            TextBox txtInvoiceNo = (TextBox)row.FindControl("txtInvoiceNo");
            TextBox txtStartKm = (TextBox)row.FindControl("txtStartKm");
            DropDownList ddlCategory = (DropDownList)row.FindControl("ddlCategory");
            DropDownList ddlTypeofProduct = (DropDownList)row.FindControl("ddlTypeofProduct");
            TextBox txtNoOfCrates = (TextBox)row.FindControl("txtNoOfCrates");
            TextBox txtEndDate = (TextBox)row.FindControl("txtEndDate");
            TextBox tb_EndTime_HH = (TextBox)row.FindControl("tb_EndTime_HH");
            TextBox tb_EndTime_MM = (TextBox)row.FindControl("tb_EndTime_MM");
            TextBox txtEndKm = (TextBox)row.FindControl("txtEndKm");
            TextBox txtKMRun = (TextBox)row.FindControl("txtKMRun");
            TextBox tb_Transit_HH = (TextBox)row.FindControl("tb_Transit_HH");
            TextBox tb_Transit_MM = (TextBox)row.FindControl("tb_Transit_MM");
            TextBox tb_IdleTime_HH = (TextBox)row.FindControl("tb_IdleTime_HH");
            TextBox tb_IdleTime_MM = (TextBox)row.FindControl("tb_IdleTime_MM");

            _dataSet.VehicleLogEntry.AddVehicleLogEntryRow(txtFrom.Text, txtTo.Text, txtStartDate.Text, tb_StartTime_HH.Text, tb_StartTime_MM.Text, txtInvoiceNo.Text, txtStartKm.Text, ddlCategory.Text, ddlTypeofProduct.Text, txtNoOfCrates.Text, txtEndDate.Text, tb_EndTime_HH.Text, tb_EndTime_MM.Text, txtEndKm.Text, txtKMRun.Text, tb_Transit_HH.Text, tb_Transit_MM.Text, tb_IdleTime_HH.Text, tb_IdleTime_MM.Text);
        }
        gvVehicleLogEntry.DataSource = _dataSet;
        gvVehicleLogEntry.DataBind();


        lblError.Text = "";
        int count = Convert.ToInt32(Session["dbOilRow"].ToString());
        string rowno;
        rowno = txtAddRowOilExp.Text;
        int mroww = 0;

        mroww = Convert.ToInt16(rowno);

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
                if (k < count) // && cash_card=="Credit"
                {
                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = false;

                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = false;
                    //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = false;
                    //((TextBox)gridrow.FindControl("txtOil_Ltr")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = false;

                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = false;
                    //((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Enabled = false;

                    k = k + 1;
                }
                else
                {

                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;

                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                    //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

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

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "0";
        _dataSet.EnExpense.Clear();
        string strPolarity = "";
        foreach (GridViewRow row in gvEnroute.Rows)
        {
            DropDownList ddlNExpense = (DropDownList)row.FindControl("ddlNExpense");
            TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
            TextBox txtBillNo = (TextBox)row.FindControl("txtBillNo");
            TextBox txtDate = (TextBox)row.FindControl("txtDate");
            TextBox txtEAmt = (TextBox)row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)row.FindControl("hfPolarity");
            TextBox txtRemark = (TextBox)row.FindControl("txtRemark");
            if (strPolarity == "")
            {
                strPolarity = hfPolarity.Value + "~";
            }
            else
            {
                strPolarity = strPolarity + hfPolarity.Value + "~";
            }
            _dataSet.EnExpense.AddEnExpenseRow(ddlNExpense.SelectedValue, txtAmount.Text, txtBillNo.Text, txtDate.Text, txtEAmt.Text, txtRemark.Text);
        }
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) _dataSet.EnExpense.AddEnExpenseRow("", "", "", "", "", "");
        tb_Row_No.Text = "0";
        gvEnroute.DataSource = _dataSet.EnExpense;
        gvEnroute.DataBind();

        if (strPolarity != "")
        {
            strPolarity = strPolarity.Substring(0, strPolarity.Length - 1);
        }

        string[] strPol = strPolarity.Split('~');
        int len = strPol.Length;
        foreach (GridViewRow row in gvEnroute.Rows)
        {
            TextBox txtEAmt = (TextBox)row.FindControl("txtEAmt");
            HiddenField hfEAmt = (HiddenField)row.FindControl("hfEAmt");
            txtEAmt.Text = hfEAmt.Value;
            if (len > 0)
            {
                HiddenField hfPolarity = (HiddenField)row.FindControl("hfPolarity");
                hfPolarity.Value = strPol[row.RowIndex].ToString();
            }
            len = len - 1;
        }
    }


    #region VehicleLogEntry


    public void Previous_VehicleLogEntry()
    {
        string mSTR = " select From_Point,To_Point,Convert(varchar,Start_Date_Tm,103) as StartDate,Substring(Convert(varchar,Start_Date_Tm,108),1,2) as StartTime_HH,Substring(Convert(varchar,Start_Date_Tm,108),4,2) as StartTime_MM,Convert(varchar,End_Date_Tm,103) as EndDate,Substring(Convert(varchar,End_Date_Tm,108),1,2) as EndTime_HH,Substring(Convert(varchar,End_Date_Tm,108),4,2) as EndTime_MM,Start_KM_Read,End_KM_Read,KM_Read,Substring(Convert(varchar,Transit_Time,108),1,2) as Transit_HH,Substring(Convert(varchar,Transit_Time,108),4,2) as Transit_MM,Substring(Convert(varchar,Idle_Time,108),1,2) as IdleTime_HH,Substring(Convert(varchar,Idle_Time,108),4,2) as IdleTime_MM,Invoice_No,Category,Prod_Typ,No_Crates from webx_fleet_vehiclelog_det where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();

        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow gv in dt.Rows)
            {
                count = count + 1;

                string From = Convert.ToString(gv["From_Point"]);
                string To = Convert.ToString(gv["To_Point"]);
                string StartDate = Convert.ToString(gv["StartDate"]);
                string StartTime_HH = Convert.ToString(gv["StartTime_HH"]);
                string StartTime_MM = Convert.ToString(gv["StartTime_MM"]);
                string Invoice_No = Convert.ToString(gv["Invoice_No"]);
                string StartKM = Convert.ToString(gv["Start_KM_Read"]);
                string Category = Convert.ToString(gv["Category"]);
                string TypeofProduct = Convert.ToString(gv["Prod_Typ"]);
                string No_Crates = Convert.ToString(gv["No_Crates"]);
                string EndDate = Convert.ToString(gv["EndDate"]);
                string EndTime_HH = Convert.ToString(gv["EndTime_HH"]);
                string EndTime_MM = Convert.ToString(gv["EndTime_MM"]);
                string EndKM = Convert.ToString(gv["End_KM_Read"]);
                string KMRun = Convert.ToString(gv["KM_Read"]);
                string Transit_HH = Convert.ToString(gv["Transit_HH"]);
                string Transit_MM = Convert.ToString(gv["Transit_MM"]);
                string IdleTime_HH = Convert.ToString(gv["IdleTime_HH"]);
                string IdleTime_MM = Convert.ToString(gv["IdleTime_MM"]);

                _dataSet.VehicleLogEntry.AddVehicleLogEntryRow(From, To, StartDate, StartTime_HH, StartTime_MM, Invoice_No, StartKM, Category, TypeofProduct, No_Crates, EndDate, EndTime_HH, EndTime_MM, EndKM, KMRun, Transit_HH, Transit_MM, IdleTime_HH, IdleTime_MM);
            }
        }
        BindGrid();

        Session["dbVEHLogRow"] = mcount;

        txtAddVehicleLogRow.Text = count.ToString();
    }
    protected void gvVehicleLogEntry1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddlCategory = (DropDownList)e.Row.FindControl("ddlCategory");
            DropDownList ddlTypeofProduct = (DropDownList)e.Row.FindControl("ddlTypeofProduct");
            TextBox txtStartDate = (TextBox)e.Row.FindControl("txtStartDate");
            TextBox txtEndDate = (TextBox)e.Row.FindControl("txtEndDate");

            TextBox txtStartKM = (TextBox)e.Row.FindControl("txtStartKM");
            TextBox txtEndKM = (TextBox)e.Row.FindControl("txtEndKM");

            TextBox tb_StartTime_HH = (TextBox)e.Row.FindControl("tb_StartTime_HH");
            TextBox tb_EndTime_HH = (TextBox)e.Row.FindControl("tb_EndTime_HH");
            TextBox tb_StartTime_MM = (TextBox)e.Row.FindControl("tb_StartTime_MM");
            TextBox tb_EndTime_MM = (TextBox)e.Row.FindControl("tb_EndTime_MM");

            TextBox txtKMRun = (TextBox)e.Row.FindControl("txtKMRun");
            TextBox tb_Transit_HH = (TextBox)e.Row.FindControl("tb_Transit_HH");
            TextBox tb_Transit_MM = (TextBox)e.Row.FindControl("tb_Transit_MM");
            TextBox tb_IdleTime_HH = (TextBox)e.Row.FindControl("tb_IdleTime_HH");
            TextBox tb_IdleTime_MM = (TextBox)e.Row.FindControl("tb_IdleTime_MM");

            txtStartDate.Attributes.Add("OnBlur", "javascript:CheckLogEntryStardate(" + e.Row.RowIndex + "," + txtStartDate.ClientID.ToString() + " ," + lblIssueDt.ClientID.ToString() + " ," + txtDateFrom.ClientID.ToString() + ");");
            txtEndDate.Attributes.Add("OnBlur", "javascript:CheckLogEntryEndDate(" + txtEndDate.ClientID.ToString() + "," + txtStartDate.ClientID.ToString() + " ," + txtDateFrom.ClientID.ToString() + ");");

            txtStartKM.Attributes.Add("OnBlur", "javascript:CheckKMRun1(" + e.Row.RowIndex + "," + txtStartKM.ClientID.ToString() + "," + txtEndKM.ClientID.ToString() + "," + txtKMRun.ClientID.ToString() + " ," + lblStartKm.ClientID.ToString() + " ," + txtCloseKM.ClientID.ToString() + ");");
            txtEndKM.Attributes.Add("OnBlur", "javascript:CheckKMRun2(" + e.Row.RowIndex + "," + txtStartKM.ClientID.ToString() + "," + txtEndKM.ClientID.ToString() + "," + txtKMRun.ClientID.ToString() + " ," + txtCloseKM.ClientID.ToString() + ");");

            tb_StartTime_HH.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');CheckTransitTime(" + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_StartTime_MM.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_Transit_HH.ClientID.ToString() + "," + tb_Transit_MM.ClientID.ToString() + ");CheckIdleTime(" + e.Row.RowIndex + "," + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_IdleTime_HH.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_StartTime_MM.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_IdleTime_MM.ClientID.ToString() + " );");
            tb_EndTime_HH.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');CheckTransitTime(" + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_StartTime_MM.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_Transit_HH.ClientID.ToString() + "," + tb_Transit_MM.ClientID.ToString() + ");CheckIdleTime(" + e.Row.RowIndex + "," + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_IdleTime_HH.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_StartTime_MM.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_IdleTime_MM.ClientID.ToString() + " );");
            tb_StartTime_MM.Attributes.Add("OnBlur", "javascript:CheckValidMin(this.getAttribute('id'), 'TRUE');CheckTransitTime(" + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_StartTime_MM.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_Transit_HH.ClientID.ToString() + "," + tb_Transit_MM.ClientID.ToString() + ");CheckIdleTime(" + e.Row.RowIndex + "," + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_IdleTime_HH.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_StartTime_MM.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_IdleTime_MM.ClientID.ToString() + ");");
            tb_EndTime_MM.Attributes.Add("OnBlur", "javascript:CheckValidMin(this.getAttribute('id'), 'TRUE');CheckTransitTime(" + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_StartTime_MM.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_Transit_HH.ClientID.ToString() + "," + tb_Transit_MM.ClientID.ToString() + ");CheckIdleTime(" + e.Row.RowIndex + "," + txtStartDate.ClientID.Trim() + "," + tb_StartTime_HH.ClientID.ToString() + "," + tb_EndTime_HH.ClientID.ToString() + "," + tb_IdleTime_HH.ClientID.ToString() + "," + txtEndDate.ClientID.Trim() + "," + tb_StartTime_MM.ClientID.ToString() + "," + tb_EndTime_MM.ClientID.ToString() + "," + tb_IdleTime_MM.ClientID.ToString() + " );");

            BindDropDown("usp_categorycode", "CodeDesc", "CodeId", ddlCategory);
            BindDropDown("usp_producttypecode", "CodeDesc", "CodeId", ddlTypeofProduct);

            if (_dataSet.VehicleLogEntry.Count > 0)
            {
                ddlCategory.SelectedValue = _dataSet.VehicleLogEntry[e.Row.RowIndex]["Category"].ToString().Trim();
                ddlTypeofProduct.SelectedValue = _dataSet.VehicleLogEntry[e.Row.RowIndex]["TypeofProduct"].ToString().Trim();
            }
        }
    }

    public void AddCategory(DropDownList d)
    {
        cls_VehicleLogEntry vehjob = new cls_VehicleLogEntry(str_Connection_String);
        vehjob.BindDropDown(d, "select CodeId,CodeDesc from webx_master_general where codetype= 'FLTCAT' and StatusCode='Y' order by CodeDesc");
    }

    public void AddProduct(DropDownList d)
    {
        cls_VehicleLogEntry vehjob = new cls_VehicleLogEntry(str_Connection_String);
        vehjob.BindDropDown(d, "select CodeId,CodeDesc from webx_master_general where codetype= 'FLTPROD' and StatusCode='Y' order by CodeDesc");
    }

    #endregion

    public void InetializEnrouteExpense()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        //string str = "SELECT G.CodeDesc, E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt, E.Remarks"
        //+ " FROM Webx_Master_General AS G LEFT OUTER JOIN"
        //+ " WEBX_FLEET_ENROUTE_EXP AS E ON G.CodeId = E.id AND (E.TripsheetNo = '" + Session["Tripsheet"].ToString().Trim() + "')"
        //+ " WHERE (G.CodeType = 'FULEXP') "
        //+ " ORDER BY G.CodeId";

        string str = "SELECT G.Trip_Exp_Header + ' (' +G.Polarity + ')' as CodeDesc,G.Polarity , E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt"
              + ", E.Remarks FROM Webx_Trip_Expense_Master AS G INNER JOIN WEBX_FLEET_ENROUTE_EXP AS E "
              + "ON G.ID = E.id AND (E.TripsheetNo = '" + Session["Tripsheet"].ToString().Trim() + "') ORDER BY G.ID ";


        DataTable dtDR = new DataTable();
        dtDR = objTripSheet.ExecuteSql(str);
        Double mAmt = 0, mEAmt = 0;
        if (dtDR.Rows.Count > 0)
        {
            foreach (DataRow dr in dtDR.Rows)
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
                    Exe_amt = "0";
                }
                string Remarks = Convert.ToString(dr["Remarks"]);
                //dtEnExpense.AddEnExpenseRouteRow(mCodeDesc,"" , Amount, BillNo, BillDt, Exe_amt, Remarks);
                if (strPolarity == "")
                {
                    strPolarity = Convert.ToString(dr["Polarity"]);
                }
                else
                {
                    strPolarity = strPolarity + "," + Convert.ToString(dr["Polarity"]);
                }


                if (Convert.ToString(dr["Polarity"]) == "+")
                {
                    totExAmt = totExAmt + Convert.ToDouble(Convert.ToString(dr["Amount_spent"]) == "" ? "0" : Convert.ToString(dr["Amount_spent"]));
                    totStandardAmt = totStandardAmt + Convert.ToDouble(Convert.ToString(dr["exe_appr_amt"]) == "" ? "0" : Convert.ToString(dr["exe_appr_amt"]));
                }
                else if (Convert.ToString(dr["Polarity"]) == "-")
                {
                    totExAmt = totExAmt - Convert.ToDouble(Convert.ToString(dr["Amount_spent"]) == "" ? "0" : Convert.ToString(dr["Amount_spent"]));
                    totStandardAmt = totStandardAmt - Convert.ToDouble(Convert.ToString(dr["exe_appr_amt"]) == "" ? "0" : Convert.ToString(dr["exe_appr_amt"]));
                }
                hfETotalAmt.Value = Convert.ToString(totExAmt);

                //_dataSet.EnExpense.AddEnExpenseRow(mCodeDesc, Amount, BillNo, BillDt, Exe_amt, Remarks);
                _dataSet.EnExpense.AddEnExpenseRow(id, Amount, BillNo, BillDt, Exe_amt, Remarks);

                //dtEnExpense.AddEnExpenseRouteRow(mCodeDesc, "", Amount, BillNo, BillDt, Exe_amt, Remarks);
            }
        }
        BindGrid();
        //foreach (GridViewRow r in gvEnroute.Rows)
        //{
        //    DropDownList ddlNExpense = (DropDownList)r.FindControl("ddlNExpense");
        //    //BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);
        //    ddlNExpense.SelectedItem.Text = _dataSet.EnExpense[r.RowIndex]["NExpense"].ToString().Trim();
        //}


    }
    public void Previous_Repair()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();
        string mSTR = "  select convert(varchar,BillDt,103) as BillDt1, * from WEBX_TRIPSHEET_REPAIREXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
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
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
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

        //txtAddTHCrow.Text = count.ToString();

        //string mFreightAmt = "0";
        //string mLabourChrg = "0";
        //string mOtherChrg = "0";
        //double mTotalAmt = 0;

        //double mTotFreightAmt = 0;
        //double mTotLabourChrg = 0;
        //double mTotOtherChrg = 0;
        //double mTotTotalAmt = 0;

        //foreach (GridViewRow gridrow in gvTHC.Rows)
        //{
        //    mFreightAmt = "0";
        //    mLabourChrg = "0";
        //    mOtherChrg = "0";
        //    mTotalAmt = 0;

        //    if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "")
        //    {
        //        {
        //            mFreightAmt = ((TextBox)gridrow.FindControl("txtFreightAmt")).Text;
        //            mTotFreightAmt = mTotFreightAmt + Convert.ToDouble(mFreightAmt);
        //        }
        //    }

        //    if (((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "")
        //    {
        //        {
        //            mLabourChrg = ((TextBox)gridrow.FindControl("txtLabourChrg")).Text;
        //            mTotLabourChrg = mTotLabourChrg + Convert.ToDouble(mLabourChrg);
        //        }
        //    }
        //    if (((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
        //    {
        //        {
        //            mOtherChrg = ((TextBox)gridrow.FindControl("txtOtherChrg")).Text;
        //            mTotOtherChrg = mTotOtherChrg + Convert.ToDouble(mOtherChrg);
        //        }
        //    }
        //    mTotalAmt = Convert.ToDouble(mFreightAmt) + Convert.ToDouble(mLabourChrg) + Convert.ToDouble(mOtherChrg);
        //    mTotTotalAmt = mTotTotalAmt + mTotalAmt;
        //    if (((TextBox)gridrow.FindControl("txtFreightAmt")).Text != "" || ((TextBox)gridrow.FindControl("txtLabourChrg")).Text != "" || ((TextBox)gridrow.FindControl("txtOtherChrg")).Text != "")
        //    {
        //        ((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text = mTotalAmt.ToString();
        //    }
        //}
        //TotFreightChrg.Text = mTotFreightAmt.ToString();
        //TotLabourChrg.Text = mTotLabourChrg.ToString();
        //TotOtherChrg.Text = mTotOtherChrg.ToString();
        //TotChrg.Text = mTotTotalAmt.ToString();
    }
    public void Previous_advance()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        string mSTR = "  select convert(varchar,AdvDate,103) as ADate, * from WEBX_TRIPSHEET_ADVEXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        DataTable dt = new DataTable();
        dt = objTripSheet.ExecuteSql(mSTR);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
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
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
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
        string mSTR = "  select convert(varchar,BillDt,103) as BillDt1,(select top 1 vendorname from webx_vendor_hdr where vendorcode=PetrolPName or VendorName=PetrolPName) as PPName,(select  top 1 Fuel_Brand_Name from WEBX_FLEET_FUELBRAND where convert(varchar(3),Fuel_Brand_ID)=Brand or Fuel_Brand_Name=Brand) BrandName,(select CodeDesc from Webx_Master_General where CodeType='FUELTY' and (CodeId=FuelType or CodeDesc=FuelType)) FuelTypeName, * from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        DataTable dt = new DataTable();

        dt = objTripSheet.ExecuteSql(mSTR);
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

                //DropDownList ddlPayment = (DropDownList)e.Item.FindControl("ddlPayment");
                //if (datarow_HSDOIL.Payment == "Credit")
                //{
                //    ddlPayment.Items.Add(new ListItem("Credit", "Credit"));

                //    ddlPayment.SelectedValue = "Credit";
                //}

                _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow(place, ppname, Brand, FuelType, Last_Km_read, KMRead, BillNo, BillDt, Disesel_Ltr, Oil_Ltr, Amount, Exe_amt, Card_Cash, Remark, Dsl_rate, Oil_Rate);
            }
        }
        BindGrid();

        Session["dbOilRow"] = mcount;
        txtFuelFilledEnroute.Text = TotDisesel_Ltr.ToString();

        txtAddRowOilExp.Text = count.ToString();
    }

    public void Inetialized_AdvanceTaken()
    {
        _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
    }

    public void Inetialized_HSD_OIL_EXP()
    {
        _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "", "", "", "0", "0");
    }

    public void Inetialized_Repair_Expense()
    {
        _dataSet.Repair_Expense.AddRepair_ExpenseRow("", "", "0", "0", "", "", "");
    }

    public void Inetialized_Incidental_Ded()
    {
        _dataSet.Incidental_Ded.AddIncidental_DedRow("", "", "", "", "", "", "");
    }





    protected void dgAdvanceDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_Adv = ((MyFleetDataSet.AdvanceTakenRow)((DataRowView)e.Item.DataItem).Row);
            ((TextBox)e.Item.FindControl("txtAdvPlace")).Text = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtAdvDt")).Text = datarow_Adv.AdvDt;
            ((TextBox)e.Item.FindControl("txtAdvAmt")).Text = datarow_Adv.AdvAmt;

            ((TextBox)e.Item.FindControl("txtBranchCode")).Text = datarow_Adv.BranchCode;
            ((TextBox)e.Item.FindControl("txtSignature")).Text = datarow_Adv.Signature;
        }
    }

    protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        DataSet ds1 = new DataSet();
        SqlDataAdapter da1 = new SqlDataAdapter("select distinct VENDORNAME,VENDORCODE from webx_VENDOR_HDR where VENDOR_TYPE='12' Order By VENDORNAME", conn);
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
            //txtLKmRead.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtKM_Reading.ClientID.ToString() + "').focus();");
            txtExeAmt.Attributes.Add("OnBlur", "return CheckApprovedAmt(" + e.Item.ItemIndex + ",this)");
            txtKM_Reading.Attributes.Add("OnBlur", "return CheckKM(" + e.Item.ItemIndex + ",this," + txtLKmRead.ClientID.ToString().Trim() + ")");

            DropDownList ddlFuelType = (DropDownList)e.Item.FindControl("ddlFuelType");
            ddlFuelType.Attributes.Add("OnChange", "javascript:FillLastKmRead(" + e.Item.ItemIndex + ",this);");



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
            ((DropDownList)e.Item.FindControl("ddlPayment")).SelectedValue = datarow_HSDOIL.Payment;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_HSDOIL.Remarks;

            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Text = datarow_HSDOIL.Diesel_Rate;
            //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Text = datarow_HSDOIL.Oil_Rate;

            ((TextBox)e.Item.FindControl("txtBilldt")).Attributes.Add("OnBlur", "javascript:ValidDateHSD(" + ((TextBox)e.Item.FindControl("txtBilldt")).ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Attributes.Add("OnBlur", "javascript:CalculateDiesel()");

            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Attributes.Add("OnBlur", "javascript:CalculateDieselLiters(" + ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).ClientID.ToString() + "," + ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).ClientID.ToString() + "," + ((TextBox)e.Item.FindControl("txtAmt")).ClientID.ToString() + ")");

            ((TextBox)e.Item.FindControl("txtAmt")).Attributes.Add("OnFocus", "javascript:document.getElementById('" + ((TextBox)e.Item.FindControl("txtExeAmt")).ClientID.ToString() + "').focus();");

            DropDownList ddlPayment = (DropDownList)e.Item.FindControl("ddlPayment");
            if (datarow_HSDOIL.Payment == "Credit")
            {
                ddlPayment.Items.Add(new ListItem("Credit", "Credit"));

                ddlPayment.SelectedValue = "Credit";
            }
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
                //((TextBox)e.Item.FindControl("txtOil_Ltr")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = false;

                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = false;
                //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Enabled = false;
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
            datarow_HSDOIL.Payment = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Text;
            datarow_HSDOIL.Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
            datarow_HSDOIL.Diesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
            //datarow_HSDOIL.Oil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
            datarow_HSDOIL.Oil_Rate = "";
        }
    }

    public void BindGrid()
    {
        //gvTHC.DataSource = _dataSet.THCContract;
        //gvTHC.DataBind();
        //_lastEditedPage = gvTHC.CurrentPageIndex;

        gvTHC.DataSource = _dataSet.THCContract;
        gvTHC.DataBind();

        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;

        dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
        dgHSD_OIL_EXP.DataBind();
        _lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;

        //dgEnroute.DataSource = _dataSet.EnExpense;
        //dgEnroute.DataBind();
        //_lastEditedPage = dgEnroute.CurrentPageIndex;

        gvEnroute.DataSource = _dataSet.EnExpense;
        gvEnroute.DataBind();

        gvVehicleLogEntry.DataSource = _dataSet.VehicleLogEntry;
        gvVehicleLogEntry.DataBind();

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
            //mCloseDt = Convert.ToDateTime(txtDateFrom.CalendarDate.ToString(), dtfi);
            mCloseDt = Convert.ToDateTime(txtDateFrom.Text.ToString(), dtfi);

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
            string ctr = "select  (case when Category='External Usage' then 'N' else  THC_ATTACHED_YN end ) THC_ATTACHED_YN ,Tripsheet_EndLoc,End_dt_tm from WEBX_FLEET_VEHICLE_ISSUE where VslipNo='" + Session["Tripsheet"].ToString() + "'";
            dt = objTripSheet.ExecuteSql(ctr);
            if (dt.Rows.Count>0)
            {
                THC_Attached_YN = Convert.ToString(dt.Rows[0]["THC_ATTACHED_YN"]);
                mEndLoc = Convert.ToString(dt.Rows[0]["Tripsheet_EndLoc"]);
                strEnd_dt_tm = Convert.ToString(dt.Rows[0]["End_dt_tm"]);
            }
            if (modeval != "FE")
            {
                if (strEnd_dt_tm != "" && strEnd_dt_tm != null)
                {
                    lblError.Visible = true;
                    lblError.Text = "Sorry!!! You have already submitted the data for this tripsheet.\nRe-submisssion is not allowed.";
                }
            }
            if (lblError.Text == "")
            {
                if (mEndLoc.ToLower().Trim() != SessionUtilities.CurrentBranchCode.ToString().ToLower().Trim())
                {
                    lblError.Visible = true;
                    lblError.Text = "Tripsheet is not allowed to close  at this location!";
                }
            }
            if (lblError.Text == "")
            {
                if ((hfEnAmtTotal.Value != "" ? Convert.ToDouble(hfEnAmtTotal.Value) : 0) > 500)
                {
                    //hfETotalAmt
                    if (THC_Attached_YN == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = "No THCs are Attached ,Hence Tripsheet cannot be closed!";
                    }
                    //Removed Validation on 16-Mar-10 by Ramashish (IMS# VRL_002980)
                    //if (THC_Attached_YN == "Y")
                    //{
                    //    lblError.Visible = true;
                    //    lblError.Text = "THC is already attached with this Tripsheet,So Tripsheet cannot be Closed!";
                    //}
                    if (THC_Attached_YN == "N")
                    {
                        lblError.Text = "";
                    }
                }
            }
            //if (lblCategory.Text == "External Usage")
            //{
            //    string mRow = "0";
            //    mRow = txtAddTHCrow.Text.ToString();
            //    if (lblError.Text.Trim() == "")
            //    {
            //        if (Convert.ToDouble(mRow) <= 0)
            //        {
            //            lblError.Visible = true;
            //            lblError.Text = "Atleast one THC Details required !!! ";
            //        }
            //    }
            //}
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

                    string strCloseDateTime = txtDateFrom.Text + " " + tsFinancialCloseDate.Hour + ":" + tsFinancialCloseDate.Minute + " " + tsFinancialCloseDate.AmPm;
                    string strOpCloseDateTime = txtDateOpClose.Text + " " + tsDateOpClose.Hour + ":" + tsDateOpClose.Minute + " " + tsDateOpClose.AmPm; 

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

                    cmd.Parameters.Add("@Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(strCloseDateTime.Trim(), dtfi);// lblExpTot.Text.ToString();
                    cmd.Parameters.Add("@Oper_Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(strOpCloseDateTime.Trim(), dtfi);// lblExpTot.Text.ToString();
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
                        //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

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



                    #region dgHSD_OIL_EXP

                    string strFuelPayType = " and Card_Cash not in ('Credit Card','Credit')";
                    sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'" + strFuelPayType;
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();
                   
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                        string mPPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Text;
                        string mBrand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Text;
                        string mFuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Text;
                        string mLastKm = ((TextBox)gridrow.FindControl("txtLKmRead")).Text;
                        string mCard_Cash = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedValue.Trim(); 
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

                    #region gvVehicleLogEntry


                    sqlDEL = "Delete from webx_fleet_vehiclelog_det where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                    foreach (GridViewRow gridrow in gvVehicleLogEntry.Rows)
                    {
                        SqlCommand sql_insert_veh = new SqlCommand("usp_InsertVehicleLogEntry", conn, trans);
                        sql_insert_veh.CommandType = CommandType.StoredProcedure;

                        if (((TextBox)gridrow.FindControl("txtFrom")).Text.ToString() != "" && ((TextBox)gridrow.FindControl("txtTo")).Text.ToString() != "")
                        {
                            sql_insert_veh.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                            sql_insert_veh.Parameters.Add("@From_Point", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtFrom")).Text.ToString();
                            sql_insert_veh.Parameters.Add("@To_Point", SqlDbType.VarChar, 100).Value = ((TextBox)gridrow.FindControl("txtTo")).Text.ToString();
                            if (((TextBox)gridrow.FindControl("txtStartDate")).Text.ToString() != "" && ((TextBox)gridrow.FindControl("txtEndDate")).Text.ToString() != "")
                            {
                                string mStartDateTm = ((TextBox)gridrow.FindControl("txtStartDate")).Text.ToString() + " " + ((TextBox)gridrow.FindControl("tb_StartTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_StartTime_MM")).Text.ToString();
                                string mEndDateTm = ((TextBox)gridrow.FindControl("txtEndDate")).Text.ToString() + " " + ((TextBox)gridrow.FindControl("tb_EndTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_EndTime_MM")).Text.ToString();

                                sql_insert_veh.Parameters.Add("@Start_Date_Tm", SqlDbType.DateTime).Value = Convert.ToDateTime(mStartDateTm, dtfi);
                                sql_insert_veh.Parameters.Add("@End_Date_Tm", SqlDbType.DateTime).Value = Convert.ToDateTime(mEndDateTm, dtfi);

                            }
                            else
                            {
                                string mStartDateTm = "" + "" + "";
                                string mEndDateTm = "" + "" + "";

                                sql_insert_veh.Parameters.Add("@Start_Date_Tm", SqlDbType.DateTime).Value = "";
                                sql_insert_veh.Parameters.Add("@End_Date_Tm", SqlDbType.DateTime).Value = "";

                            }
                            sql_insert_veh.Parameters.Add("@Start_Km_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtStartKm")).Text.ToString());
                            sql_insert_veh.Parameters.Add("@End_KM_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtEndKm")).Text.ToString());
                            sql_insert_veh.Parameters.Add("@KM_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtKMRun")).Text.ToString());
                            sql_insert_veh.Parameters.Add("@Transit_Time", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("tb_Transit_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_Transit_MM")).Text.ToString();
                            sql_insert_veh.Parameters.Add("@Idle_Time", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("tb_IdleTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_IdleTime_MM")).Text.ToString();
                            sql_insert_veh.Parameters.Add("@Invoice_No", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtInvoiceNo")).Text.ToString();

                            sql_insert_veh.Parameters.Add("@Category", SqlDbType.VarChar, 50).Value = ((DropDownList)gridrow.FindControl("ddlCategory")).SelectedValue.Trim();
                            sql_insert_veh.Parameters.Add("@Prod_Typ", SqlDbType.VarChar, 50).Value = ((DropDownList)gridrow.FindControl("ddlTypeofProduct")).SelectedValue.Trim();

                            sql_insert_veh.Parameters.Add("@No_Crates", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtNoOfCrates")).Text.ToString());

                            sql_insert_veh.ExecuteNonQuery();
                        }

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


                    #region THC_Details


                    if (lblCategory.Text == "External Usage")
                    {
                        sqlDEL = "Delete from WEBX_FLEET_TRIPTHCDET where TripSheetNo='" + mTripSheetNo + "'";
                        cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                        cmdDEL.ExecuteNonQuery();
                        cmdDEL.Dispose();
                        foreach (GridViewRow gridrow in gvTHC.Rows)
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
                            //sqlcmdContract.Parameters.Add("@TotalAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text);

                            datarow_THCContract = _dataSet.THCContract[gridrow.DataItemIndex];
                            _dataSet.THCContract[gridrow.DataItemIndex].ItemArray = datarow_THCContract.ItemArray; 
                            //datarow_THCContract = _dataSet.THCContract[gridrow.DataSetIndex];
                            //_dataSet.THCContract[gridrow.DataSetIndex].ItemArray = datarow_THCContract.ItemArray;
                            sqlcmdContract.ExecuteNonQuery();
                        }
                    }
                  

                    #endregion

                    #region gvEnroute

                    sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

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
                            datarow_EnExp = _dataSet.EnExpense[gridrow.RowIndex];
                            _dataSet.EnExpense[gridrow.RowIndex].ItemArray = datarow_EnExp.ItemArray;
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }


                    mTotEnrouteExp = hfETotalAmt.Value != "" ? Convert.ToDouble(hfETotalAmt.Value) : 0;

                    #endregion

                    strOpCloseDateTime = txtDateOpClose.Text + " " + tsDateOpClose.Hour + ":" + tsDateOpClose.Minute + " " + tsDateOpClose.AmPm; 

                    DateTime mOPCloseDt = new DateTime();
                    if (lblError.Text == "")
                    {
                        if (txtDateOpClose.Text.ToString() != "")
                        {
                            mOPCloseDt = Convert.ToDateTime(strOpCloseDateTime.ToString(), dtfi);
                        }

                        else
                        {
                            lblError.Visible = true;

                            lblError.Text = "Enter Operational Close Date!";
                        }

                    }

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


                 

                    sql = "Update WEBX_FLEET_VEHICLE_ISSUE set TotAdvExp='" + mTotAdvExp + "',TotOilExp='" + mTotOilExp + "',TotRepairExp='" + mTotRepairExp + "',TotIncDedExp='" + mTotIncDedExp + "',TotEnrouteExp='" + mTotEnrouteExp + "',TotClaimsAmt='" + mTotClaimsExp + "',TotSpareExp='" + mTotSpareExp + "', PreparedBy='" + mPreparedBy + "',CheckedBy='" + mCheckedBy + "',ApprovedBy='" + mApprovedBy + "',Oper_Close_dt='" + mOPCloseDt + "',AuditedBy='" + mAuditedBy + "'" + sqlfinstr + "  Where VSlipNo ='" + mTripSheetNo + "' ";
                    SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
                    TripHeader.CommandType = CommandType.Text;
                    TripHeader.ExecuteNonQuery();

                    if (hfOperationalyCloseDate.Value == "")
                    {
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

                        sql = "USP_Tyre_KM_Run_Update";
                        SqlCommand cmdTyreUpdate = new SqlCommand(sql, conn, trans);
                        cmdTyreUpdate.CommandType = CommandType.StoredProcedure;
                        cmdTyreUpdate.Parameters.Add("@VSlipNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                        cmdTyreUpdate.Parameters.Add("@f_closure_closekm", SqlDbType.Decimal).Value = Convert.ToDecimal(txtCloseKM.Text);
                        cmdTyreUpdate.Parameters.Add("@VehicleNo", SqlDbType.VarChar, 50).Value = lblVehno.Text;
                        cmdTyreUpdate.ExecuteNonQuery(); 
                    }
                    lblError1.Text = "";
                    //TextBox txtEnAmtTotal = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtEnAmtTotal");
                    //TextBox txtETotalAmt = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtETotalAmt"); 
                    double TotExpenseAmt = 0;
                    if (hfEnAmtTotal.Value.ToString() != "")
                    {
                        TotExpenseAmt = mTotOilExp + mTotEnrouteExp + mTotRepairExp + mTotIncDedExp + mTotClaimsExp + mTotSpareExp + Convert.ToDouble(hfEnAmtTotal.Value.ToString());
                    }
                    else
                    {
                        TotExpenseAmt = mTotOilExp + mTotEnrouteExp + mTotRepairExp + mTotIncDedExp + mTotClaimsExp + mTotSpareExp + Convert.ToDouble("0");
                    }

                    if (Math.Abs(TotExpenseAmt) <= 0)
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

    protected void cmdOpClose_Click(object sender, EventArgs e)
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
            //mCloseDt = Convert.ToDateTime(txtDateFrom.CalendarDate.ToString(), dtfi);
            //mCloseDt = Convert.ToDateTime(txtDateFrom.Text.ToString(), dtfi);
            mCloseDt = Convert.ToDateTime(txtDateOpClose.Text.ToString(), dtfi);

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
                    if (dtFuelCard.Rows.Count > 0)
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


            //string strEnd_dt_tm = "";
            //string THC_Attached_YN = "", mEndLoc = "";
            //DataTable dt = new DataTable();
            //string ctr = "select  THC_ATTACHED_YN ,Tripsheet_EndLoc,End_dt_tm from WEBX_FLEET_VEHICLE_ISSUE where VslipNo='" + Session["Tripsheet"].ToString() + "'";
            //dt = objTripSheet.ExecuteSql(ctr);
            //if (dt.Rows.Count > 0)
            //{
            //    THC_Attached_YN = Convert.ToString(dt.Rows[0]["THC_ATTACHED_YN"]);
            //    mEndLoc = Convert.ToString(dt.Rows[0]["Tripsheet_EndLoc"]);
            //    strEnd_dt_tm = Convert.ToString(dt.Rows[0]["End_dt_tm"]);
            //}
            //if (lblError.Text == "")
            //{
            //    if (mEndLoc.Trim() != SessionUtilities.CurrentBranchCode.ToString().Trim())
            //    {
            //        lblError.Visible = true;
            //        lblError.Text = "Tripsheet is not allowed to close  at this location!";
            //    }
            //}
            //if (lblError.Text == "")
            //{
            //    if ((hfEnAmtTotal.Value != "" ? Convert.ToDouble(hfEnAmtTotal.Value) : 0) > 500)
            //    {
            //        //hfETotalAmt
            //        if (THC_Attached_YN == "")
            //        {
            //            lblError.Visible = true;
            //            lblError.Text = "No THCs are Attached ,Hence Tripsheet cannot be closed!";
            //        }
            //        if (THC_Attached_YN == "Y")
            //        {
            //            lblError.Visible = true;
            //            lblError.Text = "THC is already attached with this Tripsheet,So Tripsheet cannot be Closed!";
            //        }
            //        if (THC_Attached_YN == "N")
            //        {
            //            lblError.Text = "";
            //        }
            //    }
            //}
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
                    //SqlCommand cmd = new SqlCommand("usp_CloseVehicleIssue", conn, trans);
                    //cmd.CommandType = CommandType.StoredProcedure;
                    //cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblIssueNo.Text.ToString();
                    //cmd.Parameters.Add("@Driver1", SqlDbType.VarChar).Value = Session["strDriverCode"].ToString();
                    //cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = lblVehno.ToString();
                    //if (txtCloseKM.Text.ToString() != "")
                    //{
                    //    cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = txtCloseKM.Text.ToString();
                    //}
                    //else
                    //{
                    //    cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = "0";
                    //}
                    //if (txtFuelFilledEnroute.Text.ToString() != "")
                    //{
                    //    cmd.Parameters.Add("@f_closure_fill", SqlDbType.Float).Value = txtFuelFilledEnroute.Text.ToString();
                    //}
                    //else
                    //{
                    //    cmd.Parameters.Add("@f_closure_fill", SqlDbType.Float).Value = "0";
                    //}
                    ////cmd.Parameters.Add("@AKMPL ", SqlDbType.Float).Value = lblKMPL.Text.ToString();
                    //if (txtKMPL.Text.ToString() != "")
                    //{
                    //    cmd.Parameters.Add("@AKMPL ", SqlDbType.Float).Value = txtKMPL.Text.ToString();
                    //}
                    //else
                    //{
                    //    cmd.Parameters.Add("@AKMPL ", SqlDbType.Float).Value = "0";
                    //}

                    //if (txtApprKMPL.Text.ToString() != "")
                    //{
                    //    cmd.Parameters.Add("@APPKMPL", SqlDbType.Float).Value = txtApprKMPL.Text.ToString();
                    //}
                    //else
                    //{
                    //    cmd.Parameters.Add("@APPKMPL", SqlDbType.Float).Value = "0";
                    //}
                    //cmd.Parameters.Add("@Contractamt", SqlDbType.Float).Value = "0";// txtContractAmt.Text.ToString();
                    //cmd.Parameters.Add("@c_Othercharg", SqlDbType.Float).Value = "0";// txtOtherCharge.Text.ToString();
                    //cmd.Parameters.Add("@c_TDSrate", SqlDbType.Float).Value = "0";// txtTDSRate.Text.ToString();
                    //cmd.Parameters.Add("@c_TDSamt", SqlDbType.Float).Value = "0";//txtTDSAmt.Text.ToString();
                    //cmd.Parameters.Add("@c_TDStype", SqlDbType.VarChar).Value = "0";// txtTDSType.Text.ToString();
                    //cmd.Parameters.Add("@c_Advamt_paid", SqlDbType.Float).Value = "0";// txtAdvancePaid.Text.ToString();
                    //cmd.Parameters.Add("@c_issue_tot", SqlDbType.Float).Value = "0";//lblCustIssueTot.Text.ToString();
                    //cmd.Parameters.Add("@c_dedamt", SqlDbType.Float).Value = "0";//txtContractDed.Text.ToString();
                    //cmd.Parameters.Add("@c_Balamt_paid", SqlDbType.Float).Value = "0";// txtBalPaid.Text.ToString();
                    //cmd.Parameters.Add("@c_closure_tot", SqlDbType.Float).Value = "0";// lblCustIssueTot.Text.ToString();
                    //cmd.Parameters.Add("@c_net_amt", SqlDbType.Float).Value = "0";// lblCustNet.Text.ToString();

                    //cmd.Parameters.Add("@e_issue_advamt", SqlDbType.Float).Value = "0";// txtAdvDriver.Text.ToString();
                    //cmd.Parameters.Add("@e_issue_spare", SqlDbType.Float).Value = "0";// txtExpSpares.Text.ToString();
                    //cmd.Parameters.Add("@e_issue_fuel", SqlDbType.Float).Value = "0";// txtExpFuel.Text.ToString();
                    //cmd.Parameters.Add("@e_issue_comm", SqlDbType.Float).Value = "0";// txtComm.Text.ToString();
                    //cmd.Parameters.Add("@e_closure_balamt", SqlDbType.Float).Value = "0";// txtBalDriver.Text.ToString();
                    //cmd.Parameters.Add("@e_closure_incentive", SqlDbType.Float).Value = "0";//txtIncentive.Text.ToString();
                    //cmd.Parameters.Add("@e_closure_deposit", SqlDbType.Float).Value = "0";// txtDeposit.Text.ToString();
                    //cmd.Parameters.Add("@e_closure_dedamt", SqlDbType.Float).Value = "0";// txtExpenseDed.Text.ToString();
                    //cmd.Parameters.Add("@e_issue_totamt", SqlDbType.Float).Value = "0";// lblExpIssueTot.Text.ToString();
                    //cmd.Parameters.Add("@e_closure_totamt", SqlDbType.Float).Value = "0";// lblExpCloseTot.Text.ToString();
                    //cmd.Parameters.Add("@e_net_amt", SqlDbType.Float).Value = "0";// lblExpTot.Text.ToString();
                    //cmd.Parameters.Add("@Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDateFrom.Text.Trim(), dtfi);// lblExpTot.Text.ToString();
                    //cmd.Parameters.Add("@Oper_Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtDateOpClose.Text.Trim(), dtfi);// lblExpTot.Text.ToString();
                    //cmd.ExecuteNonQuery();

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
                        //((TextBox)gridrow.FindControl("txtLKMRead")).Enabled = true;

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


                    #region gvVehicleLogEntry


                    sqlDEL = "Delete from webx_fleet_vehiclelog_det where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                    foreach (GridViewRow gridrow in gvVehicleLogEntry.Rows)
                    {
                        SqlCommand sql_insert_veh = new SqlCommand("usp_InsertVehicleLogEntry", conn, trans);
                        sql_insert_veh.CommandType = CommandType.StoredProcedure;

                        if (((TextBox)gridrow.FindControl("txtFrom")).Text.ToString() != "" && ((TextBox)gridrow.FindControl("txtTo")).Text.ToString() != "")
                        {
                            sql_insert_veh.Parameters.Add("@TripSheetNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                            sql_insert_veh.Parameters.Add("@From_Point", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtFrom")).Text.ToString();
                            sql_insert_veh.Parameters.Add("@To_Point", SqlDbType.VarChar, 100).Value = ((TextBox)gridrow.FindControl("txtTo")).Text.ToString();
                            if (((TextBox)gridrow.FindControl("txtStartDate")).Text.ToString() != "" && ((TextBox)gridrow.FindControl("txtEndDate")).Text.ToString() != "")
                            {
                                string mStartDateTm = ((TextBox)gridrow.FindControl("txtStartDate")).Text.ToString() + " " + ((TextBox)gridrow.FindControl("tb_StartTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_StartTime_MM")).Text.ToString();
                                string mEndDateTm = ((TextBox)gridrow.FindControl("txtEndDate")).Text.ToString() + " " + ((TextBox)gridrow.FindControl("tb_EndTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_EndTime_MM")).Text.ToString();

                                sql_insert_veh.Parameters.Add("@Start_Date_Tm", SqlDbType.DateTime).Value = Convert.ToDateTime(mStartDateTm, dtfi);
                                sql_insert_veh.Parameters.Add("@End_Date_Tm", SqlDbType.DateTime).Value = Convert.ToDateTime(mEndDateTm, dtfi);

                            }
                            else
                            {
                                string mStartDateTm = "" + "" + "";
                                string mEndDateTm = "" + "" + "";

                                sql_insert_veh.Parameters.Add("@Start_Date_Tm", SqlDbType.DateTime).Value = "";
                                sql_insert_veh.Parameters.Add("@End_Date_Tm", SqlDbType.DateTime).Value = "";

                            }
                            sql_insert_veh.Parameters.Add("@Start_Km_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtStartKm")).Text.ToString());
                            sql_insert_veh.Parameters.Add("@End_KM_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtEndKm")).Text.ToString());
                            sql_insert_veh.Parameters.Add("@KM_Read", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtKMRun")).Text.ToString());
                            sql_insert_veh.Parameters.Add("@Transit_Time", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("tb_Transit_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_Transit_MM")).Text.ToString();
                            sql_insert_veh.Parameters.Add("@Idle_Time", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("tb_IdleTime_HH")).Text.ToString() + ":" + ((TextBox)gridrow.FindControl("tb_IdleTime_MM")).Text.ToString();
                            sql_insert_veh.Parameters.Add("@Invoice_No", SqlDbType.VarChar, 50).Value = ((TextBox)gridrow.FindControl("txtInvoiceNo")).Text.ToString();

                            sql_insert_veh.Parameters.Add("@Category", SqlDbType.VarChar, 50).Value = ((DropDownList)gridrow.FindControl("ddlCategory")).SelectedValue.Trim();
                            sql_insert_veh.Parameters.Add("@Prod_Typ", SqlDbType.VarChar, 50).Value = ((DropDownList)gridrow.FindControl("ddlTypeofProduct")).SelectedValue.Trim();

                            sql_insert_veh.Parameters.Add("@No_Crates", SqlDbType.Decimal).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtNoOfCrates")).Text.ToString());

                            sql_insert_veh.ExecuteNonQuery();
                        }

                    }

                    #endregion


                    #region dgHSD_OIL_EXP
                    foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                    {
                        string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                        string mPPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Text;
                        string mBrand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Text;
                        string mFuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Text;
                        string mLastKm = ((TextBox)gridrow.FindControl("txtLKmRead")).Text;
                        string mCard_Cash = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedValue.Trim(); 
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


                    #region dgHSD_OIL_EXP


                    if (lblCategory.Text == "External Usage")
                    {
                        sqlDEL = "Delete from WEBX_FLEET_TRIPTHCDET where TripSheetNo='" + mTripSheetNo + "'";
                        cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                        cmdDEL.ExecuteNonQuery();
                        cmdDEL.Dispose();
                        foreach (GridViewRow gridrow in gvTHC.Rows)
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
                            //sqlcmdContract.Parameters.Add("@TotalAmt", SqlDbType.Float).Value = Convert.ToDouble(((TextBox)gridrow.FindControl("txtTHCTotalAmt")).Text);

                            datarow_THCContract = _dataSet.THCContract[gridrow.DataItemIndex];
                            _dataSet.THCContract[gridrow.DataItemIndex].ItemArray = datarow_THCContract.ItemArray;
                            //datarow_THCContract = _dataSet.THCContract[gridrow.DataSetIndex];
                            //_dataSet.THCContract[gridrow.DataSetIndex].ItemArray = datarow_THCContract.ItemArray;
                            sqlcmdContract.ExecuteNonQuery();
                        }
                    }
                    sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + mTripSheetNo + "'";
                    cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    cmdDEL.ExecuteNonQuery();
                    cmdDEL.Dispose();

                    #endregion

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
                            datarow_EnExp = _dataSet.EnExpense[gridrow.RowIndex];
                            _dataSet.EnExpense[gridrow.RowIndex].ItemArray = datarow_EnExp.ItemArray;
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }


                    mTotEnrouteExp = hfETotalAmt.Value != "" ? Convert.ToDouble(hfETotalAmt.Value) : 0;

                    #endregion

                    string strOpCloseDateTime = txtDateOpClose.Text + " " + tsDateOpClose.Hour + ":" + tsDateOpClose.Minute + " " + tsDateOpClose.AmPm; 

                    DateTime mOPCloseDt = new DateTime();
                    if (lblError.Text == "")
                    {
                        if (txtDateOpClose.Text.ToString() != "")
                        {
                            mOPCloseDt = Convert.ToDateTime(strOpCloseDateTime.ToString(), dtfi);
                        }

                        else
                        {
                            lblError.Visible = true;

                            lblError.Text = "Enter Operational Close Date!";
                        }

                    }

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


                    sql = "Update WEBX_FLEET_VEHICLE_ISSUE set f_closure_closekm=" + txtCloseKM.Text + ",TotAdvExp='" + mTotAdvExp + "',TotOilExp='" + mTotOilExp + "',TotRepairExp='" + mTotRepairExp + "',TotIncDedExp='" + mTotIncDedExp + "',TotEnrouteExp='" + mTotEnrouteExp + "',TotClaimsAmt='" + mTotClaimsExp + "',TotSpareExp='" + mTotSpareExp + "', PreparedBy='" + mPreparedBy + "',CheckedBy='" + mCheckedBy + "',ApprovedBy='" + mApprovedBy + "',Oper_Close_dt='" + mOPCloseDt + "',AuditedBy='" + mAuditedBy + "'" + sqlfinstr + "  Where VSlipNo ='" + mTripSheetNo + "' ";
                    SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
                    TripHeader.CommandType = CommandType.Text;
                    TripHeader.ExecuteNonQuery();

                    //if (hfOperationalyCloseDate.Value == "")
                    {
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

                        sql = "USP_Tyre_KM_Run_Update";
                        SqlCommand cmdTyreUpdate = new SqlCommand(sql, conn, trans);
                        cmdTyreUpdate.CommandType = CommandType.StoredProcedure;
                        cmdTyreUpdate.Parameters.Add("@VSlipNo", SqlDbType.VarChar, 50).Value = mTripSheetNo;
                        cmdTyreUpdate.Parameters.Add("@f_closure_closekm", SqlDbType.Decimal).Value = Convert.ToDecimal(txtCloseKM.Text);
                        cmdTyreUpdate.Parameters.Add("@VehicleNo", SqlDbType.VarChar, 50).Value = lblVehno.Text;
                        cmdTyreUpdate.ExecuteNonQuery(); 

                    }

                    lblError1.Text = "";
                    //TextBox txtEnAmtTotal = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtEnAmtTotal");
                    //TextBox txtETotalAmt = (TextBox)gvEnroute.FooterRow.Cells[2].FindControl("txtETotalAmt"); 
                    double TotExpenseAmt = 0;
                    if (hfEnAmtTotal.Value.ToString() != "")
                    {
                        TotExpenseAmt = mTotOilExp + mTotEnrouteExp + mTotRepairExp + mTotIncDedExp + mTotClaimsExp + mTotSpareExp + Convert.ToDouble(hfEnAmtTotal.Value.ToString());
                    }
                    else
                    {
                        TotExpenseAmt = mTotOilExp + mTotEnrouteExp + mTotRepairExp + mTotIncDedExp + mTotClaimsExp + mTotSpareExp + Convert.ToDouble("0");
                    }



                    if (hf_Check_Amt_Rule.Value == "Y")
                    {
                        if (TotExpenseAmt <= 0)
                        {
                            lblError1.Text = "Expense amount can not be ZERO !!! Please check.";
                            trans.Rollback();
                            success = false;
                            //Response.End();
                        }
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



    #region new En-Route Expense
    protected void gvTHC_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtFreightAmt = (TextBox)e.Row.FindControl("txtFreightAmt");
            TextBox txtLabourChrg = (TextBox)e.Row.FindControl("txtLabourChrg");
            TextBox txtOtherChrg = (TextBox)e.Row.FindControl("txtOtherChrg");
            TextBox txtTHCTotalAmt = (TextBox)e.Row.FindControl("txtTHCTotalAmt");
            txtFreightAmt.Attributes.Add("OnBlur", "javascript:CalculateTHCAmt(" + txtFreightAmt.ClientID.ToString() + "," + txtLabourChrg.ClientID.ToString() + "," + txtOtherChrg.ClientID.ToString() + "," + txtTHCTotalAmt.ClientID.ToString() + ");CallulateTHCFooter();");
            txtLabourChrg.Attributes.Add("OnBlur", "javascript:CalculateTHCAmt(" + txtFreightAmt.ClientID.ToString() + "," + txtLabourChrg.ClientID.ToString() + "," + txtOtherChrg.ClientID.ToString() + "," + txtTHCTotalAmt.ClientID.ToString() + ");CallulateTHCFooter();");
            txtOtherChrg.Attributes.Add("OnBlur", "javascript:CalculateTHCAmt(" + txtFreightAmt.ClientID.ToString() + "," + txtLabourChrg.ClientID.ToString() + "," + txtOtherChrg.ClientID.ToString() + "," + txtTHCTotalAmt.ClientID.ToString() + ");CallulateTHCFooter();");

            datarow_THCContract = ((MyFleetDataSet.THCContractRow)((DataRowView)e.Row.DataItem).Row);
            ((TextBox)e.Row.FindControl("txtFrom")).Text = datarow_THCContract.FromCity;
            ((TextBox)e.Row.FindControl("txtTo")).Text = datarow_THCContract.ToCity;
            ((TextBox)e.Row.FindControl("txtTHCNo")).Text = datarow_THCContract.THCNo;
            ((TextBox)e.Row.FindControl("txtTHCDt")).Text = datarow_THCContract.THCDt;
            if (txtFreightAmt.Text != "0") { txtFreightAmt.Text = datarow_THCContract.FreightAmt; } else { txtFreightAmt.Text = "0"; }
            if (txtLabourChrg.Text != "0") { txtLabourChrg.Text = datarow_THCContract.LabourChrg; } else { txtLabourChrg.Text = "0"; }
            if (txtOtherChrg.Text != "0") { txtOtherChrg.Text = datarow_THCContract.OtherChrg; } else { txtOtherChrg.Text = "0"; }
            if (txtTHCTotalAmt.Text != "0") { txtTHCTotalAmt.Text = datarow_THCContract.TotalChrg; } else { txtTHCTotalAmt.Text = "0"; }

        }
    }
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
            TextBox txtBillNo = (TextBox)e.Row.FindControl("txtBillNo");
            TextBox txtRemark = (TextBox)e.Row.FindControl("txtRemark");

            txtEAmt.Enabled = false;
            BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);
            txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalance();");
            txtDate.Attributes.Add("OnBlur", "javascript:ValidDate(" + txtDate.ClientID.ToString() + "," + lblIssueDt.ClientID.ToString() + ");");

            ddlNExpense.Attributes.Add("onChange", "return CheckValidExp(" + e.Row.RowIndex + "," + ddlNExpense.ClientID.ToString() + "," + txtEAmt.ClientID.ToString() + "," + hfEAmt.ClientID.ToString() + "," + hfPolarity.ClientID.ToString() + ");");

            if (_dataSet.EnExpense.Count > 0)
            {
                //ddlNExpense.SelectedItem.Text = _dataSet.EnExpense[e.Row.RowIndex]["NExpense"].ToString();
                ddlNExpense.SelectedValue = _dataSet.EnExpense[e.Row.RowIndex]["NExpense"].ToString();
            }

            if (strPolarity != "")
            {
                string[] strArr = strPolarity.ToString().Split(',');
                for (int i = 0; i < strArr.Length; i++)
                {
                    if (e.Row.RowIndex == i)
                    {
                        hfPolarity.Value = strArr[i].ToString();
                    }
                }
            }
            //datarow_EnExp.NExpense
            //ddlNExpense.SelectedItem.Text = _dataSet.EnExpense.d
            //txtEAmt.Text = datarow_EnExp.Amount;

            //txtBillNo.Text = datarow_EnExp.BillNo;
            //txtDate.Text = datarow_EnExp.Date;
            //txtEAmt.Text = datarow_EnExp.EAmt;
            //txtRemark.Text = datarow_EnExp.Remarks;

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txtETotalAmt = (TextBox)e.Row.FindControl("txtETotalAmt");
            TextBox txtEnAmtTotal = (TextBox)e.Row.FindControl("txtEnAmtTotal");
            txtETotalAmt.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtETotalAmt.ClientID.ToString() + "').disabled='true';");
            txtEnAmtTotal.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtEnAmtTotal.ClientID.ToString() + "').disabled='true';");

            txtEnAmtTotal.Text = Convert.ToString(totExAmt);
            txtETotalAmt.Text = Convert.ToString(totStandardAmt);
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


    private void BindGridEnExpense()
    {
        gvEnroute.DataSource = dtEnExpense;
        gvEnroute.DataBind();
    }

    #endregion

}
