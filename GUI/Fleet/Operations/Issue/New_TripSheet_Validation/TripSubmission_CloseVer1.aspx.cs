using Newtonsoft.Json;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;
using WebX.Controllers;
using System.Collections;
using System.Collections.Generic;
using WebX.Common;
using System.IO;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripSubmission_CloseVer1 : BasePage
{
    #region Declare
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlConnection con;
    DataSet ds;
    string TripSheetNo;
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.HSD_OIL_EXPRow datarow_HSDOIL;
    MyFleetDataSet.SparePartRow datarow_Spare;
    MyFleetDataSet.EnExpenseRow datarow_EnExp;
    MyFleetDataSet.EnExpenseRouteDataTable dtEnExpense = new MyFleetDataSet.EnExpenseRouteDataTable();
    MyFleetDataSet.EnExpenseRouteRow datarow_Enroute;
    MyFleetDataSet.EnrouteExpenseLegWiseDataTable dtEnrouteExpense = new MyFleetDataSet.EnrouteExpenseLegWiseDataTable();
    MyFleetDataSet.ExternalCustDetailsRow datarow_ExternalCustDetails;
    MyFleetDataSet.EnrouteExpenseLegWise123Row datarow_EnrouteExpenseLegWise;
    MyFleetDataSet.TripsheetCnoteLegWiseRow datarow_TripsheetCnoteLegWise;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable dt_WorkGroup = new MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable();
    public string strPolarity = "";
    public double totExAmt = 0, totStandardAmt = 0;
    public double totExAmt2 = 0, totStandardAmt2 = 0;
    public double totExAmt3 = 0, totStandardAmt3 = 0;
    public double totExAmt4 = 0, totStandardAmt4 = 0;
    public double totExAmt5 = 0, totStandardAmt5 = 0;
    public double totExAmt6 = 0, totStandardAmt6 = 0;

    public double totExpenseAmt = 0, totProposedAmt = 0;
    string stVSlipId = "", strVEHNO = "", strStartKM = "";
    SqlConnection conn;
    static string str_Connection_String = "";
    public string modeval = "";
    public string clintName = "Ritco", path = "UploadedImages";

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            umsg.Hide();
            var obj = new TripSubmissionOperationFinancialClosureController();

            if (obj.IsTripSubmissionAlreadyDone(Request.QueryString["VSlipNo"].ToString()) == "Y")
            {
                umsg.Show("Tripshubmission is Already Done !!!");
                btnTripSubbmission.Visible = false;
                btnOperationClose.Visible = false;
                btnNextStep.Visible = false;
                btnSummary.Visible = false;
                return;
            }

            var dtValidation = obj.GetTripSubmissionValidation(Request.QueryString["VSlipNo"].ToString());
            if (Convert.ToInt16(dtValidation.Rows[0]["PendingTripsheetCount"]) > 0)
            {
                umsg.Show("Vehicle's Previous Tripsheet trip submission is pending  !!!");
                btnTripSubbmission.Visible = false;
                btnOperationClose.Visible = false;
                btnNextStep.Visible = false;
                btnSummary.Visible = false;
                return;
            }

            if (Convert.ToInt16(dtValidation.Rows[0]["PendingDriverSettlementCount"]) > 0)
            {
                umsg.Show("Vehicle's Previous Tripsheet Driver settlement is pending  !!!");
                btnTripSubbmission.Visible = false;
                btnOperationClose.Visible = false;
                btnNextStep.Visible = false;
                btnSummary.Visible = false;
                return;
            }

            str_Connection_String = Session["SqlProvider"].ToString();
            TripSheetNo = Request.QueryString["VSlipNo"];
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            GetFuelSlipDetails();

            DataTable dtTripsheetVehicle = obj.GetTripsheetVehicleDetails(TripSheetNo);

            if (dtTripsheetVehicle.Rows.Count > 0)
            {
                lblFuelEconomy.Text = dtTripsheetVehicle.Rows[0]["FuelEconomy"].ToString();
            }
            else
            {
                lblFuelEconomy.Text = "0";
            }

            InetializEnrouteExpense();
            Previous_HSD_OIL_EXP();
            RepeterData();
            BindData();
            BindThcdata();
            BindProtsahanRashiPopUpGrid();
            string strVehNo = "", strRouteType = "";
            foreach (RepeaterItem item in Repeater1.Items)
            {
                Label lblVehicleNo = item.FindControl("lblVehicleNo") as Label;
                Label lblRouteTypeDetail = item.FindControl("lblRouteTypeDetail") as Label;
                HiddenField hfOperationalyCloseDate = item.FindControl("hfOperationalyCloseDate") as HiddenField;

                if (hfOperationalyCloseDate.Value != "")
                {
                    TextBox txtTripEndDate = item.FindControl("txtTripEndDate") as TextBox;
                    TextBox txtTripEndKm = item.FindControl("txtTripEndKm") as TextBox;
                    txtTripEndDate.ReadOnly = true;
                    txtTripEndKm.ReadOnly = true;
                    hdnIsOperationalClose.Value = "1";
                }
                else
                {
                    TextBox txtTripEndDate = item.FindControl("txtTripEndDate") as TextBox;
                    txtTripEndDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
                    txtTripEndDate.ReadOnly = true;

                }

                strVehNo = lblVehicleNo.Text;
                strRouteType = lblRouteTypeDetail.Text;
            }
            var objTripSheet = new TripSheet(SessionUtilities.ConnectionString);
            //DataTable dt = objTripSheet.GetEnrouteExpense(strRouteType, strVehNo);
            DataTable dt = objTripSheet.GetEnrouteExpenseVer1(strRouteType, strVehNo);
            if (dt.Rows.Count > 0)
            {
                DataView dataViewEnroute = dt.DefaultView;
                //dataViewEnroute.RowFilter = "ExpenseId  NOT IN ('01', '29', '30')";
                dataViewEnroute.RowFilter = "Expense  NOT IN ('Toll', 'CashFuel', 'CashAddBlue')";
                gvEnroute.DataSource = dataViewEnroute;
                gvEnroute.DataBind();

                DataView dataViewEnrouteExtra = dt.DefaultView;
                //dataViewEnrouteExtra.RowFilter = "ExpenseId  IN ('01', '29', '30')";
                dataViewEnroute.RowFilter = "Expense IN ('Toll', 'CashFuel', 'CashAddBlue')";
                gvEnrouteExtra.DataSource = dataViewEnroute;
                gvEnrouteExtra.DataBind();

            }
            con.Open();
            cmd = new SqlCommand("USP_GET_ENRoute_Details_Cash", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Route", strRouteType);
            cmd.Parameters.AddWithValue("@VehicleNo", strVehNo);
            cmd.Parameters.AddWithValue("@Location", SessionUtilities.CurrentBranchCode);
            SqlDataReader dataReadVI = cmd.ExecuteReader();
            while (dataReadVI.Read())
            {
                txtCashRate.Text = dataReadVI["CashRate"].ToString();
                txtCashLiter.Text = dataReadVI["CashLtr"].ToString();
                lblCashTotal.Text = dataReadVI["CashTotal"].ToString();
                hidCashTotal.Value = dataReadVI["CashTotal"].ToString();
                txtCreditFuel.Text = dataReadVI["CreditFuel"].ToString();
            }
            dataReadVI.Close();
            con.Close();
            txtRow_TextChanged(txtRow, null);

            GetFuelCardDetails();
            BindRouteDetails();
            BindEmptyKm_DetentionDetails();
            BindPreviousCarryForwardDetails();

            if (hdnIsOperationalClose.Value == "1")
            {
                btnNextStep.Visible = false;
                btnOperationClose.Visible = false;
                setRecoverableAmount();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowStep", "TripSubmissionRows('HIDE');", true);
            }

        }


    }

    public void BindRouteDetails()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string brcd = Session["brcd"].ToString();
        string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader drBr;
        drBr = sqlcmd1.ExecuteReader();
        drBr.Read();
        string loccd = drBr["loccode"].ToString();
        drBr.Close();
        String SQL_LOC;

        if (brcd == loccd)
        {
            SQL_LOC = "Select '--Select--' AS RouteName UNION select RouteName from StandardExpense_FixedRoute_HDR";
            //sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

        }
        else
        {
            SQL_LOC = "Select '-Select-' AS RouteNo UNION select RouteName from StandardExpense_FixedRoute_HDR";
            //sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
        }
        SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd2.ExecuteReader();
        while (dr1.Read())
        {

            ddlRouteName.Items.Add(new ListItem(dr1.GetValue(0).ToString()));
        }
        dr1.Close();
        //ddlRouteName.SelectedValue = loccd;
        string strVehNo = "", strRouteType = "";
        foreach (RepeaterItem item in Repeater1.Items)
        {
            Label lblVehicleNo = item.FindControl("lblVehicleNo") as Label;
            Label lblRouteTypeDetail = item.FindControl("lblRouteTypeDetail") as Label;
            strVehNo = lblVehicleNo.Text;
            strRouteType = lblRouteTypeDetail.Text;
        }
        ddlRouteName.SelectedValue = strRouteType;
        conn.Close();
    }

    public void GetFuelCardDetails()
    {
        string strVehNo = "";
        foreach (RepeaterItem item in Repeater1.Items)
        {
            Label lblVehicleNo = item.FindControl("lblVehicleNo") as Label;
            strVehNo = lblVehicleNo.Text;
        }

        con.Open();
        cmd = new SqlCommand("USP_TripSubmission_GetFuelCardDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TripsheetNo", TripSheetNo);
        cmd.Parameters.AddWithValue("@VehicleNo", strVehNo);
        DataSet ds = new DataSet();
        da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        if (ds.Tables[0].Rows.Count > 0)
        {
            hdnJsonVehicleTollCardNo.Value = ds.Tables[0].Rows[0]["FuelCardNo"].ToString();
            //hdnJsonVehicleTollCardRefDate.Value = ds.Tables[0].Rows[0]["TransactionDate"].ToString();
            //hdnJsonVehicleTollCardRefNo.Value = ds.Tables[0].Rows[0]["TransactionId"].ToString();
            //hdnJsonVehicleTollCardRefDate.Value = ds.Tables[0].Rows[0]["LastThisDate"].ToString();
            //hdnJsonVehicleTollCardRefNo.Value = ds.Tables[0].Rows[0]["LastThisRefNo"].ToString();
            hdnJsonFuelCardData.Value = JsonConvert.SerializeObject(ds.Tables[0]);

        }

        grdFuelCardDetails.DataSource = ds;
        grdFuelCardDetails.DataBind();
        con.Close();

        con.Open();
        cmd = new SqlCommand("USP_TripSubmission_GetTollCardLastRefDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TripsheetNo", TripSheetNo);
        cmd.Parameters.AddWithValue("@VehicleNo", strVehNo);
        DataSet dsF = new DataSet();
        SqlDataAdapter daF = new SqlDataAdapter(cmd);
        daF.Fill(dsF);

        if (dsF.Tables[0].Rows.Count > 0)
        {
            hdnJsonVehicleTollCardRefDate.Value = dsF.Tables[0].Rows[0]["LastThisDate"].ToString();
            hdnJsonVehicleTollCardRefNo.Value = dsF.Tables[0].Rows[0]["LastThisRefNo"].ToString();

        }
        con.Close();

    }
    public void RepeterData()
    {
        //SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        cmd = new SqlCommand("USP_Get_TripSubmissionByTripSheetNo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TripSheetNo", TripSheetNo);
        DataSet ds = new DataSet();
        da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
        con.Close();

    }
    public void BindData()
    {
        con.Open();
        cmd = new SqlCommand("USP_Get_AdvPaidToDriver_By_TripSheetNoVer1", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TripSheetNo", TripSheetNo);
        SqlDataReader dr = cmd.ExecuteReader();
        GridView1.DataSource = dr;
        GridView1.DataBind();
        dr.Close();
        con.Close();
    }
    public void BindThcdata()
    {
        con.Open();
        cmd = new SqlCommand("USP_Get_TripThcDetailsBy_Tripno", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TripSheetNo", TripSheetNo);
        SqlDataReader dr = cmd.ExecuteReader();
        GridView2.DataSource = dr;
        GridView2.DataBind();
        dr.Close();
        con.Close();
    }

    public void BindProtsahanRashiPopUpGrid()
    {
        con.Open();
        cmd = new SqlCommand("USP_TripSubmission_GetETHCListForProtsahanRashi", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TripSheetNo", TripSheetNo);
        SqlDataReader dr = cmd.ExecuteReader();
        grdProtsahanRashi.DataSource = dr;
        grdProtsahanRashi.DataBind();
        dr.Close();
        con.Close();
    }
    public void BindPreviousCarryForwardDetails()
    {
        DataTable dt = new DataTable();
        var obj = new TripSubmissionOperationFinancialClosureController();
        dt = obj.GetPreviouseCarryForwardDetails(Request.QueryString["VSlipNo"].ToString());

        if (dt.Rows.Count > 0)
        {
            lblPreviouseFuelCF_Ltr.Text = dt.Rows[0]["PreviousFuleCF_Ltr"].ToString();
            lblPreviouseFuelCF_amount.Text = dt.Rows[0]["PreviousFuleCF_Amount"].ToString();
            lblPreviouseDriverAdvanceCF_amount.Text = dt.Rows[0]["PreviousDriverBalanceAmount"].ToString();
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
            Label txtEAmt = (Label)row.FindControl("txtEAmt");
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
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++)
        {
            _dataSet.EnExpense.AddEnExpenseRow("", "", "", "", "", "");
        }
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
    protected void gvEnroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label lblNExpense = (Label)e.Row.FindControl("lblNExpense");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            Label txtEAmt = (Label)e.Row.FindControl("txtEAmt");
            TextBox txtDate = (TextBox)e.Row.FindControl("txtDate");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
            TextBox txtBillNo = (TextBox)e.Row.FindControl("txtBillNo");
            TextBox txtRemark = (TextBox)e.Row.FindControl("txtRemark");
            HiddenField hdnFlag = (HiddenField)e.Row.FindControl("hdnFlag");
            Label lblDisplay = (Label)e.Row.FindControl("lblDisplay");



            DropDownList ddlFixedPerKM = (DropDownList)e.Row.FindControl("ddlFixedPerKM");
            TextBox txtAmtRate = (TextBox)e.Row.FindControl("txtAmtRate");
            Label lblDistance = (Label)e.Row.FindControl("lblDistance");

            if (lblNExpense.Text.ToUpper() == "PROTSAHANRASHI")
            {
                lblNExpense.Attributes.Add("onClick", "javascript:OpenProtsahanRashiPopup('" + lblNExpense.ClientID + "');");
                lblNExpense.Style.Add("text-decoration", "underline");
                txtAmount.Attributes.Add("readonly", "true");
            }
            if (lblNExpense.Text.ToString().ToUpper() != "INCENTIVE" && lblNExpense.Text.ToString().ToUpper() != "ENROUTEEXPENSE")
            {
                ddlFixedPerKM.Attributes.Add("style", "display:none;");
                txtAmtRate.Attributes.Add("style", "display:none;");
                lblDistance.Attributes.Add("style", "display:none;");
            }

            setRecoverableAmount();
            if (lblNExpense.Text == "RecoverableAmount")
            {
                txtAmount.Text = (hdnTotalRecoverableAmount.Value == "" ? "0" : hdnTotalRecoverableAmount.Value);
                txtEAmt.Text = (hdnTotalRecoverableAmount.Value == "" ? "0" : hdnTotalRecoverableAmount.Value);

                txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalanceNewVer1();SetRecoverableAmount('VALIDATE');");
                txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalanceNewVer1();");

            }
            else
            {
                txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalanceNewVer1();");
                txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalanceNewVer1();");
            }

            foreach (RepeaterItem item in Repeater1.Items)
            {
                Label lblTripSheetDate = item.FindControl("lblTripSheetDate") as Label;
                txtDate.Attributes.Add("OnBlur", "javascript:ValidDate(" + txtDate.ClientID.ToString() + "," + lblTripSheetDate.ClientID.ToString() + ");");
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
            totProposedAmt = totProposedAmt + Convert.ToDouble(txtAmount.Text);
            totExpenseAmt = totExpenseAmt + Convert.ToDouble(txtEAmt.Text);
            if (hdnFlag.Value == "1")
            {
                lblFlag.Text = "(En-Route expenses found from master)";
                lblFlag.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblFlag.Text = "(En-Route expenses not found from master)";
                lblFlag.ForeColor = System.Drawing.Color.Red;
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtETotalAmt = (Label)e.Row.FindControl("txtETotalAmt");
            Label txtEnAmtTotal = (Label)e.Row.FindControl("txtEnAmtTotal");
            txtEnAmtTotal.Text = Convert.ToString(totProposedAmt);
            txtETotalAmt.Text = Convert.ToString(totExpenseAmt);
        }
    }

    protected void gvEnrouteExtra_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label lblNExpense = (Label)e.Row.FindControl("lblNExpense");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            Label txtEAmt = (Label)e.Row.FindControl("txtEAmt");
            TextBox txtDate = (TextBox)e.Row.FindControl("txtDate");
            HiddenField hfEAmt = (HiddenField)e.Row.FindControl("hfEAmt");
            HiddenField hfPolarity = (HiddenField)e.Row.FindControl("hfPolarity");
            TextBox txtBillNo = (TextBox)e.Row.FindControl("txtBillNo");
            TextBox txtRemark = (TextBox)e.Row.FindControl("txtRemark");
            HiddenField hdnFlag = (HiddenField)e.Row.FindControl("hdnFlag");
            Label lblDisplay = (Label)e.Row.FindControl("lblDisplay");

            FileUpload fldTollUpload = (FileUpload)e.Row.FindControl("fldTollUpload");

            //txtEAmt.Enabled = false;
            //BindDropDown("usp_fulExp", "CodeDesc", "CodeId", ddlNExpense);
            if (lblNExpense.Text.ToUpper() == "TOLL")
            {

                lblNExpense.Attributes.Add("onClick", "javascript:OpenTollPopup('" + lblNExpense.ClientID + "');");
                lblNExpense.Style.Add("text-decoration", "underline");
                fldTollUpload.Visible = true;
            }
            if (lblNExpense.Text.ToUpper() == "CASHFUEL")
            {
                lblNExpense.Attributes.Add("onClick", "javascript:OpenFuelPopup('" + lblNExpense.ClientID + "');");
                lblNExpense.Style.Add("text-decoration", "underline");
                lblDisplay.Text = "Fuel Slip";
                lblDisplay.Visible = true;
                lblDisplay.Style.Add("text-decoration", "underline");
                lblDisplay.Attributes.Add("onClick", "javascript:ViewFuelPopup('" + lblNExpense.ClientID + "');");
                lblStanderdFuel.Text = hfEAmt.Value;
                txtEAmt.Text = "0";
                txtAmount.Text = "0";
            }
            if (lblNExpense.Text.ToUpper() == "CASHADDBLUE")
            {
                lblNExpense.Attributes.Add("onClick", "javascript:OpenAddBluePopup('" + lblNExpense.ClientID + "');");
                lblNExpense.Style.Add("text-decoration", "underline");
                lblDisplay.Text = "Total Add Blue";
                lblDisplay.Visible = true;
                lblDisplay.Style.Add("text-decoration", "underline");
                lblDisplay.Attributes.Add("onClick", "javascript:ViewAddBluePopup('" + lblNExpense.ClientID + "');");
            }


            txtAmount.Attributes.Add("OnBlur", "javascript:GVcalculateBalanceNewVer1();");
            txtEAmt.Attributes.Add("OnBlur", "javascript:GVcalculateBalanceNewVer1();");
            foreach (RepeaterItem item in Repeater1.Items)
            {
                Label lblTripSheetDate = item.FindControl("lblTripSheetDate") as Label;
                txtDate.Attributes.Add("OnBlur", "javascript:ValidDate(" + txtDate.ClientID.ToString() + "," + lblTripSheetDate.ClientID.ToString() + ");");
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
            totProposedAmt = totProposedAmt + Convert.ToDouble(txtAmount.Text);
            totExpenseAmt = totExpenseAmt + Convert.ToDouble(txtEAmt.Text);
            if (hdnFlag.Value == "1")
            {
                lblFlag.Text = "(En-Route expenses found from master)";
                lblFlag.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblFlag.Text = "(En-Route expenses not found from master)";
                lblFlag.ForeColor = System.Drawing.Color.Red;
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtETotalAmt = (Label)e.Row.FindControl("txtETotalAmt");
            Label txtEnAmtTotal = (Label)e.Row.FindControl("txtEnAmtTotal");
            txtEnAmtTotal.Text = Convert.ToString(totProposedAmt);
            txtETotalAmt.Text = Convert.ToString(totExpenseAmt);
        }
    }
    private void BindGridEnExpense()
    {
        gvEnroute.DataSource = dtEnExpense;
        gvEnroute.DataBind();
    }
    public void BindGridFuelDetails()
    {
        dgWorkgroup.DataSource = dt_WorkGroup;
        dgWorkgroup.DataBind();
    }
    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        dt_WorkGroup.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";
        for (int i = 0; i < Convert.ToInt32(txtRow.Text); i++)
        {
            dt_WorkGroup.AddWebx_Fleet_SM_Task_DetRow("", "", "", "", "", "", "", "", "", "");
        }
        BindGridFuelDetails();
    }

    protected void txtEmtyKMRows_TextChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[3] {
                            new DataColumn("FromKm", typeof(string)),
                            new DataColumn("ToKm",typeof(string)),
                            new DataColumn("Distance",typeof(string))
        });

        if ((txtEmtyKMRows.Text == "") || (txtEmtyKMRows.Text == "0")) txtEmtyKMRows.Text = "0";
        for (int i = 0; i < Convert.ToInt32(txtEmtyKMRows.Text); i++)
        {
            dt.Rows.Add("", "", "");
        }

        grdEmtyKM.DataSource = dt;
        grdEmtyKM.DataBind();
    }

    protected void txtDetentionRows_TextChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[3] {
                            new DataColumn("FromDate", typeof(string)),
                            new DataColumn("ToDate",typeof(string)),
                            new DataColumn("Remarks",typeof(string))
        });

        if ((txtDetentionRows.Text == "") || (txtDetentionRows.Text == "0")) txtDetentionRows.Text = "0";
        for (int i = 0; i < Convert.ToInt32(txtDetentionRows.Text); i++)
        {
            dt.Rows.Add("", "", "");
        }

        grdDetantion.DataSource = dt;
        grdDetantion.DataBind();
    }

    protected void dgWorkgroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        foreach (GridViewRow gvr in dgWorkgroup.Rows)
        {
            //Button BtnCustCode = gvr.FindControl("BtnCustCode") as Button;
            //TextBox txtCstLoc = gvr.FindControl("txtCstLoc") as TextBox;
            //TextBox txtCashLtr = gvr.FindControl("txtCashLtr") as TextBox;
            //TextBox txtToll = (TextBox)gvr.FindControl("txtToll");
            //TextBox txtBorder = (TextBox)gvr.FindControl("txtBorder");
            //TextBox txtCheckPost = (TextBox)gvr.FindControl("txtCheckPost");
            //TextBox txtRto = (TextBox)gvr.FindControl("txtRto");
            //TextBox txtLoading = (TextBox)gvr.FindControl("txtLoading");
            //TextBox txtUnLoading = (TextBox)gvr.FindControl("txtUnLoading");
            //TextBox txtIncentive = (TextBox)gvr.FindControl("txtIncentive");
            //TextBox txtDriverDA = (TextBox)gvr.FindControl("txtDriverDA");
            //TextBox txtTelephone = (TextBox)gvr.FindControl("txtTelephone");
            //TextBox txtEnrouteRepair = (TextBox)gvr.FindControl("txtEnrouteRepair");
            //TextBox txtPenalty = (TextBox)gvr.FindControl("txtPenalty");
            //TextBox txtHeight = (TextBox)gvr.FindControl("txtHeight");
            //TextBox txtBrokarage = (TextBox)gvr.FindControl("txtBrokarage");
            //TextBox txtGuide = (TextBox)gvr.FindControl("txtGuide");
            //TextBox txtBehtiExp = (TextBox)gvr.FindControl("txtBehtiExp");
            //TextBox txtGreenTax = (TextBox)gvr.FindControl("txtGreenTax");
            //TextBox txtPExp = (TextBox)gvr.FindControl("txtPExp");
            //TextBox txtMislExp = (TextBox)gvr.FindControl("txtMislExp");
            //TextBox txtOtherExp = (TextBox)gvr.FindControl("txtOtherExp");
            //TextBox txtMExp = (TextBox)gvr.FindControl("txtMExp");
            //TextBox txtCashRate = (TextBox)gvr.FindControl("txtCashRate");
            //TextBox txtCashTotal = (TextBox)gvr.FindControl("txtCashTotal");
            //TextBox txtGCashRate = (TextBox)gvr.FindControl("txtGCashRate");
            //TextBox txtGCashLtr = (TextBox)gvr.FindControl("txtGCashLtr");
            //TextBox txtGrandTotal = gvr.FindControl("txtGrandTotal") as TextBox;
            //BtnCustCode.Attributes.Add("OnClick", "window.open('popupLoc.aspx?ctlid=" + txtCstLoc.ClientID + "',null,'left=300, top=250, height=300, width=350, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            //txtCstLoc.Attributes.Add("Onblur", "javascript: return SelectAllVehicles()");
            //txtMExp.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtToll.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtBorder.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtCheckPost.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtRto.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtLoading.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtUnLoading.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtIncentive.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtDriverDA.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtTelephone.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtEnrouteRepair.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtPenalty.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtHeight.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtBrokarage.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtGuide.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtBehtiExp.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtGreenTax.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtPExp.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtMislExp.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtOtherExp.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtMExp.Attributes.Add("Onblur", "javascript: return CalculateTotal(" + e.Row.RowIndex + ");");
            //txtCashLtr.Attributes.Add("Onblur", "javascript: return CalculateCashTotal(" + e.Row.RowIndex + ");");
            //txtCashLtr.Attributes.Add("Onblur", "javascript: return CalculateGrandTotal(" + e.Row.RowIndex + ");");
        }
    }
    protected void add_rowOil(object sender, EventArgs e)
    {
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
                string LastKm2 = "";
                foreach (RepeaterItem item in Repeater1.Items)
                {
                    Label lblTripStartKm = item.FindControl("lblTripStartKm") as Label;
                    LastKm2 = lblTripStartKm.Text;
                }
                if (LastKm2 == "")
                    LastKm2 = "0";
                LastKm1 = Convert.ToDouble(LastKm2);
                int LastKm = Convert.ToInt32(LastKm1);
                if (i == 0)
                {
                    _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "Select", "Select", "Select", LastKm2, "", "", "", "0", "0", "", "", "", "", "0", "0");
                }
                else
                {
                    _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "Select", "Select", "Select", "", "", "", "", "0", "0", "", "", "", "", "0", "0");
                }
            }
            BindGrid();
            int k = 0;
            foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
            {
                string cash_card = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Value;
                if (k < count)
                {
                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = false;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = false;
                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = false;
                    k = k + 1;
                }
                else
                {
                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                }
            }
        }
        else
        {
            lblError.Text = "Sorry, HSD/OIL Expenses row can not be less than " + Session["dbOilRow"].ToString() + " !!!";
        }
    }
    protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
            ddlPPName.Items.Insert(0, "Select");
            TextBox txtKM_Reading = (TextBox)e.Item.FindControl("txtKM_Reading");
            TextBox txtLKmRead = (TextBox)e.Item.FindControl("txtLKmRead");
            TextBox txtExeAmt = (TextBox)e.Item.FindControl("txtExeAmt");
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
            ddlBrand.Items.Insert(0, "Select");
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
            ddlFuelType.Items.Insert(0, "Select");
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
            ((TextBox)e.Item.FindControl("txtAmt")).Text = datarow_HSDOIL.Amt;
            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_HSDOIL.Exe_Amt;
            ((DropDownList)e.Item.FindControl("ddlPayment")).SelectedValue = datarow_HSDOIL.Payment;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_HSDOIL.Remarks;
            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Text = datarow_HSDOIL.Diesel_Rate;
            foreach (RepeaterItem item in Repeater1.Items)
            {
                Label lblTripSheetDate = item.FindControl("lblTripSheetDate") as Label;
                ((TextBox)e.Item.FindControl("txtBilldt")).Attributes.Add("OnBlur", "javascript:ValidDateHSD(" + ((TextBox)e.Item.FindControl("txtBilldt")).ClientID.ToString() + "," + lblTripSheetDate.ClientID.ToString() + ");");
            }
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
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = false;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = false;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = false;
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
                ((TextBox)e.Item.FindControl("txtAmt")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtExeAmt")).Enabled = true;
                ((DropDownList)e.Item.FindControl("ddlPayment")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtRemarks")).Enabled = true;
                ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Enabled = true;
            }
        }
    }
    protected void CardNo_Dispaly(object sender, EventArgs e)
    {
        lblError.Text = "";
        //MyFleetDataSet.HSD_OIL_EXPRow datarow_OilExp;
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            //datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                string FCCardNo = "";
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                string msql = "";
                foreach (RepeaterItem item in Repeater1.Items)
                {
                    Label lblVehicleNo = item.FindControl("lblVehicleNo") as Label;
                    msql = "select Manual_Fuel_Card_No  from WEBX_FLEET_FUELCARD where Vehicle_No='" + lblVehicleNo.Text + "'";
                }
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
    public void Previous_HSD_OIL_EXP()
    {
        string mSTR = "select convert(varchar,BillDt,103) as BillDt1,(select top 1 vendorname from webx_vendor_hdr where vendorcode=PetrolPName or VendorName=PetrolPName) as PPName,(select  top 1 Fuel_Brand_Name from WEBX_FLEET_FUELBRAND where convert(varchar(3),Fuel_Brand_ID)=Brand or Fuel_Brand_Name=Brand) BrandName,(select CodeDesc from Webx_Master_General where CodeType='FUELTY' and (CodeId=FuelType or CodeDesc=FuelType)) FuelTypeName, * from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo ='" + Request.QueryString["VSlipNo"] + "'";
        int count = 0;
        int mcount = 0;
        TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());
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
                _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow(place, ppname, Brand, FuelType, Last_Km_read, KMRead, BillNo, BillDt, Disesel_Ltr, Oil_Ltr, Amount, Exe_amt, Card_Cash, Remark, Dsl_rate, Oil_Rate);
            }
        }
        BindGrid();
        Session["dbOilRow"] = mcount;
        Session["dbOilRow1"] = count;
        txtAddRowOilExp.Text = count.ToString();
    }
    public void InetializEnrouteExpense()
    {
        TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());
        string str = "SELECT G.Trip_Exp_Header + ' (' +G.Polarity + ')' as CodeDesc,G.Polarity , E.TripsheetNo, E.id, E.Amount_Spent, E.BillNo, E.Dt, E.Exe_Appr_Amt"
              + ", E.Remarks FROM Webx_Trip_Expense_Master AS G INNER JOIN WEBX_FLEET_ENROUTE_EXP AS E "
              + "ON G.ID = E.id AND (E.TripsheetNo = '" + Request.QueryString["VSlipNo"] + "') ORDER BY G.ID ";
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
                _dataSet.EnExpense.AddEnExpenseRow(id, Amount, BillNo, BillDt, Exe_amt, Remarks);
            }
        }
        BindGrid();
    }
    public void BindGrid()
    {
        dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
        dgHSD_OIL_EXP.DataBind();
        _lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;
        //gvEnroute.DataSource = _dataSet.EnExpense;
        //gvEnroute.DataBind();
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

    public void BindEmptyKm_DetentionDetails()
    {
        var obj = new TripSubmissionOperationFinancialClosureController();
        DataSet dataset = obj.GetTripsheetEmptyKM_Detention(Request.QueryString["VSlipNo"]);
        if (dataset.Tables[0].Rows.Count > 0)
        {
            grdEmtyKM.DataSource = dataset.Tables[0];
            grdEmtyKM.DataBind();
        }
        if (dataset.Tables[1].Rows.Count > 0)
        {
            grdDetantion.DataSource = dataset.Tables[1];
            grdDetantion.DataBind();
        }

    }

    protected void btnOperationClose_Click(object sender, EventArgs e)
    {
        btnTripSubbmission_Click(null, null);
    }

    protected void btnNextStep_Click(object sender, EventArgs e)
    {
        //btnNextStep.Visible = false;
        //btnOperationClose.Visible = false;
        //setRecoverableAmount();
        //Page.RegisterClientScriptBlock("ShowStep", "TripSubmissionRows('SHOW');");


        //ScriptManager.RegisterClientScriptBlock(btnNextStep, this.GetType(), "alert", "disableOpeartionRow()", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowStep", "TripSubmissionRows('SHOW');", true);
    }
    public void setRecoverableAmount()
    {
        decimal amt = 0;
        foreach (GridViewRow gridrow in GridView2.Rows)
        {
            TextBox txtRecoverableAmount = (TextBox)gridrow.FindControl("txtRecoverableAmount");
            amt = amt + Convert.ToDecimal(txtRecoverableAmount.Text == "" ? "0" : txtRecoverableAmount.Text);

        }
        hdnTotalRecoverableAmount.Value = amt.ToString();

        foreach (GridViewRow gridrow in gvEnroute.Rows)
        {
            Label lblNExpense = ((Label)gridrow.FindControl("lblNExpense"));
            HiddenField hidNExpense = ((HiddenField)gridrow.FindControl("hidNExpense"));
            TextBox txtAmount = ((TextBox)gridrow.FindControl("txtAmount"));
            Label txtEAmt = ((Label)gridrow.FindControl("txtEAmt"));
            HiddenField hfEAmt = ((HiddenField)gridrow.FindControl("hfEAmt"));
            HiddenField hfPolarity = ((HiddenField)gridrow.FindControl("hfPolarity"));


            if (lblNExpense.Text == "RecoverableAmount")
            {
                txtAmount.Text = hdnTotalRecoverableAmount.Value;
                txtEAmt.Text = hdnTotalRecoverableAmount.Value;
            }
        }
    }
    protected void btnTripSubbmission_Click(object sender, EventArgs e)
    {

        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        bool success = false;
        string sql = "";
        string sqlDEL = "";
        double mTotAdvExp = 0, mTotOilExp = 0, mTotRepairExp = 0, mTotIncDedExp = 0, mTotEnrouteExp = 0, mTotClaimsExp = 0, mTotSpareExp = 0;
        string mTripSheetNo = "";
        SqlCommand cmdDEL = new SqlCommand();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlTransaction trans;
        conn.Open();
        trans = conn.BeginTransaction();
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime mIssueDt = new DateTime();
        string vehno = "";
        string TripOpCloseDate = "";
        foreach (RepeaterItem item in Repeater1.Items)
        {
            Label lblTripSheetDate = item.FindControl("lblTripSheetDate") as Label;
            mIssueDt = Convert.ToDateTime(lblTripSheetDate.Text.ToString(), dtfi);
            Label lblVehicleNo = item.FindControl("lblVehicleNo") as Label;
            vehno = lblVehicleNo.Text;
            TextBox txtTripEndDate = item.FindControl("txtTripEndDate") as TextBox;
            TripOpCloseDate = txtTripEndDate.Text;
        }
        DateTime mServerDt = DateTime.Now;
        DateTime mCloseDt = new DateTime();


        if (Convert.ToDateTime(TripOpCloseDate, dtfi) > DateTime.Now)
        {
            umsg.Show("Operation Date can not be Greater then TripSubmission Date !!!");
            Response.Redirect("TripSubmission_CloseVer1.aspx?VSlipNo=" + Request.QueryString["VSlipNo"]);
            return;
        }


        try
        {
            foreach (GridViewRow gridrow in grdDetantion.Rows)
            {
                var txtFrom = ((TextBox)gridrow.FindControl("txtFrom"));
                var txtTo = ((TextBox)gridrow.FindControl("txtTo"));
                var txtRemarks = ((TextBox)gridrow.FindControl("txtRemarks"));

                if (txtFrom.Text != "" && txtTo.Text != "")
                {
                    var ValidDt = Convert.ToDateTime(txtFrom.Text.ToString(), dtfi);
                }
            }
        }
        catch (Exception ex)
        {
            umsg.Show("Please Enter Date in Detentian Detials!!!");
            Response.Redirect("TripSubmission_CloseVer1.aspx?VSlipNo=" + Request.QueryString["VSlipNo"]);
            return;
        }


        try
        {

            if (hdnIsOperationalClose.Value == "0")
            {

                SqlCommand cmd = new SqlCommand("[USP_Op_CloseVehicleIssue]", conn, trans);
                cmd.CommandType = CommandType.StoredProcedure;
                foreach (RepeaterItem item in Repeater1.Items)
                {
                    Label lblTripSheetNo = item.FindControl("lblTripSheetNo") as Label;
                    TextBox txtTripEndKm = item.FindControl("txtTripEndKm") as TextBox;
                    TextBox txtTripEndDate = item.FindControl("txtTripEndDate") as TextBox;
                    TextBox tsDateOpClose = item.FindControl("tsDateOpClose") as TextBox;
                    cmd.Parameters.Add("@VSlipNo", SqlDbType.VarChar).Value = lblTripSheetNo.Text.Trim().ToString();
                    if (txtTripEndKm.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = txtTripEndKm.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@f_closure_closekm ", SqlDbType.Float).Value = "0";
                    }
                    cmd.Parameters.Add("@Oper_Closedt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtTripEndDate.Text, dtfi);
                    if (txtCashRate.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@CashRate", SqlDbType.Float).Value = txtCashRate.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@CashRate", SqlDbType.Float).Value = "0";
                    }
                    if (txtCashLiter.Text.ToString() != "")
                    {
                        cmd.Parameters.Add("@CashLiter", SqlDbType.Float).Value = txtCashLiter.Text.ToString();
                    }
                    else
                    {
                        cmd.Parameters.Add("@CashLiter", SqlDbType.Float).Value = "0";
                    }
                    if (hidCashTotal.Value != "")
                    {
                        cmd.Parameters.Add("@CashTotal", SqlDbType.Float).Value = hidCashTotal.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@CashTotal", SqlDbType.Float).Value = "0";
                    }
                    if (txtCreditFuel.Text != "")
                    {
                        cmd.Parameters.Add("@CreditFuel", SqlDbType.Float).Value = txtCreditFuel.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@CreditFuel", SqlDbType.Float).Value = "0";
                    }
                    cmd.ExecuteNonQuery();

                    #region dgGeneral
                    foreach (GridViewRow gridrow in dgGeneral.Rows)
                    {
                        DateTime fillingDate = new DateTime();
                        if (((TextBox)gridrow.FindControl("txtFillingDate")).Text != "")
                        {
                            fillingDate = Convert.ToDateTime(Convert.ToString(((TextBox)gridrow.FindControl("txtFillingDate")).Text), dtfi);
                            string slipNo = Convert.ToString(((Label)gridrow.FindControl("lblUserSlipNo")).Text);
                            var hdnSrNo = (HiddenField)gridrow.FindControl("hdnSrNo");
                            var hdnModule = (HiddenField)gridrow.FindControl("hdnModule");
                            var txtFillingDate = (TextBox)gridrow.FindControl("txtFillingDate");
                            var hdnIsCancel = (HiddenField)gridrow.FindControl("hdnIsCancel");

                            var hdnRateAsPerFillingDate = (HiddenField)gridrow.FindControl("hdnRateAsPerFillingDate");
                            var hdnFinalAmount = (HiddenField)gridrow.FindControl("hdnFinalAmount");

                            if (slipNo != "" && txtFillingDate.Enabled == true && hdnIsCancel.Value != "Y")
                            {

                                if (hdnModule.Value.ToUpper() == "TRIPSHEET")
                                {
                                    sql = " update WEBX_FLEET_TRIPSHEET_FUEL_SLIPNO set FillingDate='" + fillingDate + "',isFillingDate='Y',FillingDateEntryBy='" + SessionUtilities.CurrentEmployeeID + "',FillingEntry_Dt=GETDATE(),SentFor_FillingDt='" + fillingDate + "',RateAsPerFillingDate='" + hdnRateAsPerFillingDate.Value + "',AmountAsPerFillingDate='" + hdnFinalAmount.Value + "' Where fuelSlipNo='" + slipNo + "' AND TripsheetNo='" + Request.QueryString["VSlipNo"] + "' and SrNo='" + hdnSrNo.Value + "'";
                                }
                                if (hdnModule.Value.ToUpper() == "ISSUESLIP")
                                {
                                    sql = " update Webx_Fuel_Issue_Slip set FillingDate='" + fillingDate + "',isFillingDate='Y',FillingDateEntryBy='" + SessionUtilities.CurrentEmployeeID + "',FillingEntry_Dt=GETDATE(),SentFor_FillingDt='" + fillingDate + "',RateAsPerFillingDate='" + hdnRateAsPerFillingDate.Value + "',AmountAsPerFillingDate='" + hdnFinalAmount.Value + "' Where UserSlipNo='" + slipNo + "' AND TripsheetNo='" + Request.QueryString["VSlipNo"] + "' and SrNo='" + hdnSrNo.Value + "'";
                                }

                                SqlCommand comdgGeneral = new SqlCommand(sql, conn, trans);
                                comdgGeneral.CommandType = CommandType.Text;
                                comdgGeneral.ExecuteNonQuery();
                            }
                        }


                    }
                    #endregion

                }
            }

            #region EmptyKM_Detention


            string emptyKmXML = "<Root>";
            foreach (GridViewRow gridrow in grdEmtyKM.Rows)
            {
                var txtFromKm = ((TextBox)gridrow.FindControl("txtFromKM"));
                var txtToKm = ((TextBox)gridrow.FindControl("txtToKM"));
                var txtDistance = ((TextBox)gridrow.FindControl("txtDistance"));

                if (txtFromKm.Text != "" && txtToKm.Text != "" && txtDistance.Text != "")
                {
                    emptyKmXML += "<EMPTYKM><FromKM>" + txtFromKm.Text + "</FromKM><ToKM>" + txtToKm.Text + "</ToKM><Distance>" + txtDistance.Text + "</Distance></EMPTYKM>";
                }

            }
            emptyKmXML = emptyKmXML + "</Root>";

            string detentionXML = "<Root>";
            foreach (GridViewRow gridrow in grdDetantion.Rows)
            {
                var txtFrom = ((TextBox)gridrow.FindControl("txtFrom"));
                var txtTo = ((TextBox)gridrow.FindControl("txtTo"));
                var txtRemarks = ((TextBox)gridrow.FindControl("txtRemarks"));

                if (txtFrom.Text != "" && txtTo.Text != "")
                {
                    detentionXML += "<Detention><FromDt>" + Convert.ToDateTime(txtFrom.Text.ToString(), dtfi).ToString() + "</FromDt><ToDt>" + Convert.ToDateTime(txtTo.Text.ToString(), dtfi).ToString() + "</ToDt><Remarks>" + txtRemarks.Text + "</Remarks></Detention>";
                }
            }
            detentionXML = detentionXML + "</Root>";


            string strRouteName;
            strRouteName = ddlRouteName.SelectedValue.ToString();
            if (strRouteName == "--Select--")
            {
                strRouteName = "";
            }


            SqlCommand cmdKMDetention = new SqlCommand("USP_TripSubmission_EmptyKM_DetentionDetails_Insert", conn, trans);
            cmdKMDetention.CommandType = CommandType.StoredProcedure;
            cmdKMDetention.Parameters.Add("@EmptyKMXML", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(emptyKmXML);
            cmdKMDetention.Parameters.Add("@DetentionXml", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(detentionXML);
            cmdKMDetention.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = Request.QueryString["VSlipNo"].ToString();
            cmdKMDetention.Parameters.Add("@Trip_Route_Type", SqlDbType.VarChar).Value = ddlRouteType.SelectedValue.ToString();
            cmdKMDetention.Parameters.Add("@Fixed_RouteName", SqlDbType.VarChar).Value = strRouteName;
            cmdKMDetention.Parameters.Add("@Opn_Route1", SqlDbType.VarChar).Value = txtRouteType1.Text;
            cmdKMDetention.Parameters.Add("@Opn_Route2", SqlDbType.VarChar).Value = txtRouteType2.Text;
            cmdKMDetention.Parameters.Add("@Opn_Route3", SqlDbType.VarChar).Value = txtRouteType3.Text;
            cmdKMDetention.Parameters.Add("@Opn_Route4", SqlDbType.VarChar).Value = txtRouteType4.Text;
            cmdKMDetention.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
            cmdKMDetention.Parameters.Add("@PreviousFuleCF_Ltr", SqlDbType.VarChar).Value = lblPreviouseFuelCF_Ltr.Text;
            cmdKMDetention.Parameters.Add("@PreviousFuleCF_Amount", SqlDbType.VarChar).Value = lblPreviouseFuelCF_amount.Text;
            cmdKMDetention.Parameters.Add("@PreviousDriverBalanceAmount", SqlDbType.VarChar).Value = lblPreviouseDriverAdvanceCF_amount.Text;
            cmdKMDetention.ExecuteNonQuery();
            cmdKMDetention.Dispose();

            #endregion

            #region gvEnroute_Finance

            string TollPopUpDetailXML = "", FuelPopUpDetailsXML = "", AddBluePopUpDetailsXML = "";
            string EnrouteFuelFixedPerXML = "<ROOT>";
            string ProtshahanRashiXML = "";
            if (sender != null)
            {
                #region gvEnroute
                sqlDEL = "Delete from WEBX_FLEET_ENROUTE_EXP where TripSheetNo='" + Request.QueryString["VSlipNo"] + "'";
                cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                cmdDEL.ExecuteNonQuery();
                cmdDEL.Dispose();

                foreach (GridViewRow gridrow in gvEnroute.Rows)
                {
                    Label lblNExpense = ((Label)gridrow.FindControl("lblNExpense"));
                    HiddenField hidNExpense = ((HiddenField)gridrow.FindControl("hidNExpense"));
                    TextBox txtAmount = ((TextBox)gridrow.FindControl("txtAmount"));
                    TextBox txtBillNo = ((TextBox)gridrow.FindControl("txtBillNo"));
                    TextBox txtDate = ((TextBox)gridrow.FindControl("txtDate"));
                    Label txtEAmt = ((Label)gridrow.FindControl("txtEAmt"));
                    HiddenField hfEAmt = ((HiddenField)gridrow.FindControl("hfEAmt"));
                    HiddenField hfPolarity = ((HiddenField)gridrow.FindControl("hfPolarity"));
                    TextBox txtRemark = ((TextBox)gridrow.FindControl("txtRemark"));
                    HiddenField hdnFlag = ((HiddenField)gridrow.FindControl("hdnFlag"));
                    HiddenField hdnPopUpData = (HiddenField)gridrow.FindControl("hdnPopUpData");

                    if (lblNExpense.Text.ToUpper() == "INCENTIVE" || lblNExpense.Text.ToUpper() == "ENROUTEEXPENSE")
                    {
                        DropDownList ddlFixedPerKM = ((DropDownList)gridrow.FindControl("ddlFixedPerKM"));
                        TextBox txtAmtRate = ((TextBox)gridrow.FindControl("txtAmtRate"));
                        EnrouteFuelFixedPerXML = EnrouteFuelFixedPerXML + "<NODE><EXPENSE>" + hidNExpense.Value + "</EXPENSE><TYPE>" + ddlFixedPerKM.SelectedValue + "</TYPE><VALUE>" + txtAmtRate.Text + "</VALUE></NODE>";
                    }

                    if (lblNExpense.Text.ToUpper() == "PROTSAHANRASHI" && hdnPopUpData.Value != "")
                    {
                        ProtshahanRashiXML = XmlUtility.XmlSerializeToString(JsonConvert.DeserializeObject<List<clsProtshanRashiDetails>>(hdnPopUpData.Value));
                    }

                    if (hdnFlag.Value == "1")
                    {
                        string sqlEnroute = "USP_INSERT_ENROUTE_EXP";
                        SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                        sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                        sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = Request.QueryString["VSlipNo"];
                        sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = hidNExpense.Value;
                        if (txtAmount.Text.ToString() != "")
                        {
                            sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                        }
                        else
                        {
                            sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                        sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                        //sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                        sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = "01 Jan 1990";
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
                        sqlcmdEnRoute.ExecuteNonQuery();
                    }
                    else
                    {
                        if (Convert.ToDouble(txtAmount.Text) + Convert.ToDouble(txtEAmt.Text) > 0)
                        {
                            string sqlEnroute = "USP_INSERT_ENROUTE_EXP";
                            SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                            sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                            sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = Request.QueryString["VSlipNo"];
                            sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = hidNExpense.Value;
                            if (txtAmount.Text.ToString() != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                            }
                            else
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                            }
                            sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                            //sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = "01 Jan 1990";
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
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }

                }
                EnrouteFuelFixedPerXML = EnrouteFuelFixedPerXML + "</ROOT>";
                string TollDocumentFile = "";
                foreach (GridViewRow gridrow in gvEnrouteExtra.Rows)
                {
                    Label lblNExpense = ((Label)gridrow.FindControl("lblNExpense"));
                    HiddenField hidNExpense = ((HiddenField)gridrow.FindControl("hidNExpense"));
                    TextBox txtAmount = ((TextBox)gridrow.FindControl("txtAmount"));
                    TextBox txtBillNo = ((TextBox)gridrow.FindControl("txtBillNo"));
                    TextBox txtDate = ((TextBox)gridrow.FindControl("txtDate"));
                    Label txtEAmt = ((Label)gridrow.FindControl("txtEAmt"));
                    HiddenField hfEAmt = ((HiddenField)gridrow.FindControl("hfEAmt"));
                    HiddenField hfPolarity = ((HiddenField)gridrow.FindControl("hfPolarity"));
                    TextBox txtRemark = ((TextBox)gridrow.FindControl("txtRemark"));
                    HiddenField hdnFlag = ((HiddenField)gridrow.FindControl("hdnFlag"));
                    HiddenField hdnPopUpData = (HiddenField)gridrow.FindControl("hdnPopUpData");
                    FileUpload fldTollUpload = (FileUpload)gridrow.FindControl("fldTollUpload");

                    if (lblNExpense.Text.ToUpper() == "TOLL" && hdnPopUpData.Value != "")
                    {
                        TollPopUpDetailXML = XmlUtility.XmlSerializeToString(JsonConvert.DeserializeObject<List<clsExtraTollDetails>>(hdnPopUpData.Value));


                        if (fldTollUpload.HasFile)
                        {
                            //newFName = GetFileName(fUThcDoc.PostedFile.FileName, mDocuementNo.ToString().Trim());
                            string ImgName = fldTollUpload.PostedFile.FileName;
                            int lastIndex = ImgName.LastIndexOf('.');
                            var name = ImgName.Substring(0, lastIndex);
                            var ext = ImgName.Substring(lastIndex + 1);
                            string docno = "TollDocument" + Request.QueryString["VSlipNo"].ToString().Trim().Replace("/", "$");
                            TollDocumentFile = docno + "." + ext;


                            double dblFileSize = Math.Ceiling(Convert.ToDouble(fldTollUpload.PostedFile.ContentLength) / 1000);
                            double MaxSize = 1024; //1MB
                            if (CheckUploadedImagesDirectory() == false)
                            {
                                throw new Exception("Fail to create directory ");
                            }
                            //if (dblFileSize > MaxSize)
                            //{

                            //    throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                            //}
                            //fUThcDoc.SaveAs(Server.MapPath(".") + @"\" + path + @"\" + clintName + @"\" + newFName);
                            fldTollUpload.SaveAs(Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + @"\" + TollDocumentFile);
                        }
                    }
                    if (lblNExpense.Text.ToUpper() == "CASHFUEL" && hdnPopUpData.Value != "")
                    {
                        FuelPopUpDetailsXML = XmlUtility.XmlSerializeToString(JsonConvert.DeserializeObject<List<clsExtraExpenseDetails>>(hdnPopUpData.Value));
                    }
                    if (lblNExpense.Text.ToUpper() == "CASHADDBLUE" && hdnPopUpData.Value != "")
                    {
                        AddBluePopUpDetailsXML = XmlUtility.XmlSerializeToString(JsonConvert.DeserializeObject<List<clsExtraExpenseDetails>>(hdnPopUpData.Value));
                    }

                    if (hdnFlag.Value == "1")
                    {
                        string sqlEnroute = "USP_INSERT_ENROUTE_EXP";
                        SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                        sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                        sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = Request.QueryString["VSlipNo"];
                        sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = hidNExpense.Value;
                        if (txtAmount.Text.ToString() != "")
                        {
                            sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                        }
                        else
                        {
                            sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                        }
                        sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                        //sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                        sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = "01 Jan 1990";
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
                        sqlcmdEnRoute.ExecuteNonQuery();
                    }
                    else
                    {
                        if (Convert.ToDouble(txtAmount.Text) + Convert.ToDouble(txtEAmt.Text) > 0)
                        {
                            string sqlEnroute = "USP_INSERT_ENROUTE_EXP";
                            SqlCommand sqlcmdEnRoute = new SqlCommand(sqlEnroute, conn, trans);
                            sqlcmdEnRoute.CommandType = CommandType.StoredProcedure;
                            sqlcmdEnRoute.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = Request.QueryString["VSlipNo"];
                            sqlcmdEnRoute.Parameters.Add("@id", SqlDbType.VarChar).Value = hidNExpense.Value;
                            if (txtAmount.Text.ToString() != "")
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble(txtAmount.Text.ToString());
                            }
                            else
                            {
                                sqlcmdEnRoute.Parameters.Add("@Amount_Spent", SqlDbType.Float).Value = Convert.ToDouble("0");
                            }
                            sqlcmdEnRoute.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = txtBillNo.Text.ToString();
                            //sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = txtDate.Text.ToString();
                            sqlcmdEnRoute.Parameters.Add("@dt", SqlDbType.VarChar).Value = "01 Jan 1990";
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
                            sqlcmdEnRoute.ExecuteNonQuery();
                        }
                    }
                }

                SqlCommand cmdPopup = new SqlCommand("USP_TripSubmission_Insert", conn, trans);
                cmdPopup.CommandType = CommandType.StoredProcedure;
                cmdPopup.Parameters.Add("@TollXML", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(TollPopUpDetailXML);
                cmdPopup.Parameters.Add("@FuelXml", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(FuelPopUpDetailsXML);
                cmdPopup.Parameters.Add("@AddBlueXml", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(AddBluePopUpDetailsXML);
                cmdPopup.Parameters.Add("@TripSheetNo", SqlDbType.VarChar).Value = Request.QueryString["VSlipNo"].ToString();
                cmdPopup.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
                cmdPopup.Parameters.Add("@ExpenseFuelXml", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(EnrouteFuelFixedPerXML);
                cmdPopup.Parameters.Add("@Fuel_Total", SqlDbType.VarChar).Value = txtTotalFuel_A.Text;
                cmdPopup.Parameters.Add("@FixedPerKM_Type", SqlDbType.VarChar).Value = ddlFixedPerKMTotal.SelectedValue;
                cmdPopup.Parameters.Add("@FixedPerKM_Value", SqlDbType.VarChar).Value = txtAmtRateTotal.Text;
                cmdPopup.Parameters.Add("@Fuel_Proposed", SqlDbType.VarChar).Value = txtProposedFuel.Text;
                cmdPopup.Parameters.Add("@Fuel_CF", SqlDbType.VarChar).Value = txtTotal_CF.Text;
                cmdPopup.Parameters.Add("@Fuel_Remark", SqlDbType.VarChar).Value = txtTotalFuelRemark.Text;
                cmdPopup.Parameters.Add("@TollFileDocument", SqlDbType.VarChar).Value = TollDocumentFile;
                cmdPopup.Parameters.Add("@ProtsahanRashiXml", SqlDbType.Xml).Value = XmlUtility.CleanXmlString(ProtshahanRashiXML);
                cmdPopup.Parameters.Add("@AddBlue_Total", SqlDbType.VarChar).Value = txtTotalAddBlue_A.Text;
                cmdPopup.Parameters.Add("@AddBlueFixedPerKM_Type", SqlDbType.VarChar).Value = ddlAddBlueFixedPerKMTotal.SelectedValue;
                cmdPopup.Parameters.Add("@AddBlueFixedPerKM_Value", SqlDbType.VarChar).Value = txtAddBlueAmtRateTotal.Text;
                cmdPopup.Parameters.Add("@AddBlue_Proposed", SqlDbType.VarChar).Value = txtProposedAddBlue.Text;
                cmdPopup.Parameters.Add("@AddBlue_CF", SqlDbType.VarChar).Value = txtTotal_AddBlue_CF.Text;
                cmdPopup.Parameters.Add("@AddBlue_Remark", SqlDbType.VarChar).Value = txtTotalAddBlueRemark.Text;

                cmdPopup.ExecuteNonQuery();
                cmdPopup.Dispose();

                //mTotEnrouteExp = hfETotalAmt.Value != "" ? Convert.ToDouble(hfETotalAmt.Value) : 0;

                #endregion

                #region dgHSD_OIL_EXP NOT IN USE
                /*
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
                
                foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                {
                    if (gridrow.ItemIndex != -1)
                    {
                        Label tbFCCard = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("FCCard");
                        DropDownList tbddlPayment = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlPayment");
                        string FCCardNo = "";
                        string msql = "select Manual_Fuel_Card_No  from WEBX_FLEET_FUELCARD where Vehicle_No='" + vehno + "'";
                        DataTable dtFuelCard = new DataTable();
                        dtFuelCard = objTripSheet.ExecuteSql(msql);
                        if (dtFuelCard.Rows.Count > 0)
                        {
                            FCCardNo = Convert.ToString(dtFuelCard.Rows[0]["Manual_Fuel_Card_No"]);
                        }
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
             
                foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                {
                    ((TextBox)gridrow.FindControl("txtOilPlace")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlPPName")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlBrand")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlFuelType")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtKM_Reading")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBillno")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtBilldt")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtAmt")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtExeAmt")).Enabled = true;
                    ((DropDownList)gridrow.FindControl("ddlPayment")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtRemarks")).Enabled = true;
                    ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Enabled = true;
                }


                string strFuelPayType = " and Card_Cash not in ('Credit Card','Credit')";
                sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + Request.QueryString["VSlipNo"] + "'" + strFuelPayType;
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
                    string mOil_Ltr = "0.0";
                    string mDiesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
                    string mOil_Rate = "0.0";
                    string mAmt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                    string mExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                    mTotOilExp = mTotOilExp + Convert.ToDouble(mExeAmt);
                    if (mCard_Cash != "Credit" && mCard_Cash != "Credit Card")
                    {
                        sql = " Insert into WEBX_TRIPSHEET_OILEXPDET (TripSheetNo,Place,KM_Reading,BillNo,BillDt,Diesel_Ltr,Oil_Ltr,Amount,Diesel_Rate,Oil_Rate,PetrolPName,Brand,FuelType,Last_Km_Read,Card_Cash,Remark,Exe_Amt) values ( "
                             + "'" + Request.QueryString["VSlipNo"] + "', '" + mOilPlace + "','" + mKM_Reading + "','" + mBillno + "','" + mBilldt + "','" + mDiesel_Ltr + "','" + mOil_Ltr + "','" + mAmt + "'," + mDiesel_Rate + "," + mOil_Rate + ",'" + mPPName + "','" + mBrand + "','" + mFuelType + "','" + mLastKm + "','" + mCard_Cash + "','" + mRemark + "','" + mExeAmt + "') ";
                        SqlCommand HSDOilDetail = new SqlCommand(sql, conn, trans);
                        HSDOilDetail.CommandType = CommandType.Text;
                        HSDOilDetail.ExecuteNonQuery();
                    }
                }
                 */
                #endregion

            }

            #endregion

            #region JOurney Details
            //Update Journey Details

            foreach (GridViewRow gridrow in GridView2.Rows)
            {
                HiddenField hdnEthcNo = (HiddenField)gridrow.FindControl("hdnEthcNo");
                TextBox txtDetentionAmount = (TextBox)gridrow.FindControl("txtDetentionAmount");
                TextBox txtDetentionRemark = (TextBox)gridrow.FindControl("txtDetentionRemark");
                TextBox txtRecoverableAmount = (TextBox)gridrow.FindControl("txtRecoverableAmount");
                TextBox txtRecoverableRemark = (TextBox)gridrow.FindControl("txtRecoverableRemark");
                TextBox txtPODRemark = (TextBox)gridrow.FindControl("txtPODRemark");
                FileUpload fUThcDoc = (FileUpload)gridrow.FindControl("fuPod");

                HiddenField hdnTripType = (HiddenField)gridrow.FindControl("hdnTripType");
                TextBox txtUnloadingDate = (TextBox)gridrow.FindControl("txtUnloadingDate");
                //TripSubmissionUnloadingDate
                string newFName = "";
                if (fUThcDoc.HasFile)
                {
                    //newFName = GetFileName(fUThcDoc.PostedFile.FileName, mDocuementNo.ToString().Trim());
                    string ImgName = fUThcDoc.PostedFile.FileName;
                    int lastIndex = ImgName.LastIndexOf('.');
                    var name = ImgName.Substring(0, lastIndex);
                    var ext = ImgName.Substring(lastIndex + 1);
                    string docno = "POD_" + hdnEthcNo.Value.Trim().Replace("/", "$");
                    newFName = docno + "." + ext;


                    double dblFileSize = Math.Ceiling(Convert.ToDouble(fUThcDoc.PostedFile.ContentLength) / 1000);
                    double MaxSize = 1024; //1MB
                    if (CheckUploadedImagesDirectory() == false)
                    {
                        throw new Exception("Fail to create directory ");
                    }
                    //if (dblFileSize > MaxSize)
                    //{

                    //    throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                    //}
                    //fUThcDoc.SaveAs(Server.MapPath(".") + @"\" + path + @"\" + clintName + @"\" + newFName);
                    fUThcDoc.SaveAs(Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + @"\" + newFName);

                }


                string sqlJourney = "";

                if (hdnTripType.Value == "E")
                {
                    sqlJourney = " update WEBX_FLEET_ExternalTHC set TripDetentionAmount='" + (txtDetentionAmount.Text == "" ? "0" : txtDetentionAmount.Text) + "',TripDetentionRemark='" + txtDetentionRemark.Text + "',TripRecoverableAmount='" + (txtRecoverableAmount.Text == "" ? "0" : txtRecoverableAmount.Text) + "',TripRecoverableRemark='" + txtRecoverableRemark.Text + "' ";

                    if (txtPODRemark.Text != "") { sqlJourney = sqlJourney + " ,Remarks ='" + txtPODRemark.Text + "' "; }

                    //if (newFName != "") { sqlJourney = sqlJourney + " ,UploadFileName ='" + newFName + "' "; }
                    if (newFName != "") { sqlJourney = sqlJourney + " ,ETHCTripSubPOD ='" + newFName + "' "; }

                    if (txtUnloadingDate.Text != "")
                    {
                        var UnloadingDate = Convert.ToDateTime(Convert.ToString(txtUnloadingDate.Text), dtfi);
                        sqlJourney = sqlJourney + " ,TripSubmissionUnloadingDate =  '" + UnloadingDate.ToString() + "' ";
                    }


                    sqlJourney = sqlJourney + " Where ExternalTHCNo='" + hdnEthcNo.Value + "' AND TripsheetNo='" + Request.QueryString["VSlipNo"] + "'";
                }
                if (hdnTripType.Value == "I")
                {
                    sqlJourney = " update webx_THC_SUMMARY set TripDetentionAmount='" + (txtDetentionAmount.Text == "" ? "0" : txtDetentionAmount.Text) + "',TripDetentionRemark='" + txtDetentionRemark.Text + "',TripRecoverableAmount='" + (txtRecoverableAmount.Text == "" ? "0" : txtRecoverableAmount.Text) + "',TripRecoverableRemark='" + txtRecoverableRemark.Text + "' ";

                    if (txtPODRemark.Text != "") { sqlJourney = sqlJourney + " ,TripRemark ='" + txtPODRemark.Text + "' "; }

                    if (newFName != "") { sqlJourney = sqlJourney + " ,TripPOD ='" + newFName + "' "; }


                    if (txtUnloadingDate.Text != "")
                    {
                        var UnloadingDate = Convert.ToDateTime(Convert.ToString(txtUnloadingDate.Text), dtfi);
                        sqlJourney = sqlJourney + " ,TripSubmissionUnloadingDate =  '" + UnloadingDate.ToString() + "' ";
                    }

                    sqlJourney = sqlJourney + " Where thcno='" + hdnEthcNo.Value + "' AND TripSheetNo='" + Request.QueryString["VSlipNo"] + "'";

                }

                SqlCommand comJourney = new SqlCommand(sqlJourney, conn, trans);
                comJourney.CommandType = CommandType.Text;
                comJourney.ExecuteNonQuery();

            }

            #endregion


            trans.Commit();
            success = true;

        }
        catch (Exception e1)
        {
            trans.Rollback();
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
            Response.End();
        }
        if (success)
        {
            if (sender == null)
            {
                Response.Redirect("TripSubmission_Operational_Close_Result.aspx?Type=OperationClose&TripSheetNo=" + Request.QueryString["VSlipNo"]);
            }
            else
            {
                Response.Redirect("TripSubmission_Operational_Close_Result.aspx?Type=Submission&TripSheetNo=" + Request.QueryString["VSlipNo"]);
            }

        }

    }

    protected void dgGeneral_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        double numOdometer = 0, numDiesel = 0, numRate = 0, numAmount = 0, numRateFillingDate = 0, numFinalAmount = 0;
        foreach (GridViewRow gr in dgGeneral.Rows)
        {

            //double Odometer = Convert.ToDouble(dgGeneral.Rows[gr.RowIndex].Cells[7].Text);
            //double Odometer = Convert.ToDouble(((Label)gr.FindControl("lblOdometerReading")).Text);
            //numOdometer = numOdometer + Odometer;
            //double Diesel = Convert.ToDouble(dgGeneral.Rows[gr.RowIndex].Cells[8].Text);
            double Diesel = Convert.ToDouble(((Label)gr.FindControl("lblQuantity")).Text);
            numDiesel = numDiesel + Diesel;
            //double Rate = Convert.ToDouble(dgGeneral.Rows[gr.RowIndex].Cells[9].Text);
            double Rate = Convert.ToDouble(((Label)gr.FindControl("lblRate")).Text);
            numRate = Rate;
            //double Amount = Convert.ToDouble(dgGeneral.Rows[gr.RowIndex].Cells[10].Text);
            double Amount = Convert.ToDouble(((Label)gr.FindControl("lblAmount")).Text);
            numAmount = numAmount + Amount;
            //double RateFillingDate = Convert.ToDouble(dgGeneral.Rows[gr.RowIndex].Cells[12].Text);
            //numRateFillingDate = RateFillingDate;
            //double FinalAmount = Convert.ToDouble(dgGeneral.Rows[gr.RowIndex].Cells[13].Text);
            //numFinalAmount = numFinalAmount + FinalAmount;
        }

        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {

            TextBox txtFillingDate = (TextBox)e.Row.FindControl("txtFillingDate");
            HiddenField hdnIsCancel = (HiddenField)e.Row.FindControl("hdnIsCancel");
            LinkButton lnkCancelFuelSlip = (LinkButton)e.Row.FindControl("lnkCancelFuelSlip");
            Label lblCancelFuelSlip = (Label)e.Row.FindControl("lblCancelFuelSlip");

            if (txtFillingDate.Text != "" || hdnIsCancel.Value == "Y")
            {
                txtFillingDate.Enabled = false;
            }

            if (hdnIsCancel.Value == "Y")
            {
                lnkCancelFuelSlip.Visible = false;
                lblCancelFuelSlip.Text = "Cancelled";
            }
        }


        //lblTotalOdometerReading.Text = Convert.ToString(numOdometer);
        lblTotalDieselQty.Text = Convert.ToString(numDiesel);
        lblTotalDieselRate.Text = Convert.ToString(numRate);
        lblTotalAmount.Text = Convert.ToString(numAmount);
        lblTotalRateFillingDate.Text = Convert.ToString(numRateFillingDate);
        lblTotalFinalAmount.Text = Convert.ToString(numFinalAmount);
    }

    protected void ddlRouteName_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strVehNo = "", strRouteType = "";
        foreach (RepeaterItem item in Repeater1.Items)
        {
            Label lblVehicleNo = item.FindControl("lblVehicleNo") as Label;
            Label lblRouteTypeDetail = item.FindControl("lblRouteTypeDetail") as Label;
            strVehNo = lblVehicleNo.Text;
            strRouteType = lblRouteTypeDetail.Text;
        }

        var objTripSheet = new TripSheet(SessionUtilities.ConnectionString);
        //DataTable dt = objTripSheet.GetEnrouteExpense(strRouteType, strVehNo);
        DataTable dt = objTripSheet.GetEnrouteExpenseVer1(ddlRouteName.SelectedValue, strVehNo);
        if (dt.Rows.Count > 0)
        {
            DataView dataViewEnroute = dt.DefaultView;
            dataViewEnroute.RowFilter = "Expense  NOT IN ('Toll', 'CashFuel', 'CashAddBlue')";
            gvEnroute.DataSource = dataViewEnroute;
            gvEnroute.DataBind();

            DataView dataViewEnrouteExtra = dt.DefaultView;
            dataViewEnrouteExtra.RowFilter = "Expense IN ('Toll', 'CashFuel', 'CashAddBlue')";
            gvEnrouteExtra.DataSource = dataViewEnroute;
            gvEnrouteExtra.DataBind();
        }
    }

    private bool CheckUploadedImagesDirectory()
    {
        try
        {
            //string strDirectoryName = Server.MapPath(".") + @"\" + path + @"\" + clintName + "";
            string strDirectoryName = Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + "";
            if (Directory.Exists(strDirectoryName))
            {
                return true;
            }
            else
            {
                Directory.CreateDirectory(strDirectoryName);
                return true;
            }
        }
        catch (Exception Ex)
        {
            return false;
        }
    }

    public void GetFuelSlipDetails()
    {

        var obj = new TripSubmissionOperationFinancialClosureController();
        DataTable dtFuelSlip = obj.GetTripsheetFuelSlipDetails(Request.QueryString["VSlipNo"].ToString());

        if (dtFuelSlip.Rows.Count > 0)
        {
            hdnJsonExistingfuelSlipData.Value = JsonConvert.SerializeObject(dtFuelSlip);

            dgGeneral.DataSource = dtFuelSlip;
            dgGeneral.DataBind();
        }

    }
    protected void lnkCancelFuelSlip_Click(object sender, EventArgs e)
    {
        var lnkCancelFuelSlip = (sender as LinkButton);
        var hdnSrNo = (HiddenField)lnkCancelFuelSlip.Parent.FindControl("hdnSrNo");
        var hdnModule = (HiddenField)lnkCancelFuelSlip.Parent.FindControl("hdnModule");

        var obj1 = new TripSubmissionOperationFinancialClosureController();
        obj1.CancelFuelSlip(hdnSrNo.Value, hdnModule.Value, Request.QueryString["VSlipNo"].ToString());

        GetFuelSlipDetails();
    }

    [System.Web.Services.WebMethod]
    public static string GetRateFillingDateWise(string FillingDate, string VendorCode, string FuelType)
    {
        var objFin = new TripSubmissionOperationFinancialClosureController();
        return objFin.GetRateFillingDateWise(FillingDate, VendorCode, FuelType);
    }
}

public class clsExtraExpenseDetails
{
    public string Place { get; set; }
    public string Date { get; set; }
    public string FuelLtr { get; set; }
    public string Rate { get; set; }
    public string Amount { get; set; }
    public string IGST { get; set; }
    public string SGST { get; set; }
    public string CGST { get; set; }
    public string TotalAmount { get; set; }

    public clsExtraExpenseDetails()
    {
        Place = string.Empty;
        Date = "";
        FuelLtr = "0";
        Rate = "0";
        Amount = "0";
        IGST = "0";
        SGST = "0";
        CGST = "0";
        TotalAmount = "0";
    }
}


public class clsProtshanRashiDetails
{
    public string ETHCNo { get; set; }
    public string TransitDays { get; set; }
    public string SaveDays { get; set; }
    public string Amount { get; set; }
    public string Remarks { get; set; }

    public clsProtshanRashiDetails()
    {
        ETHCNo = string.Empty;
        TransitDays = "0";
        Amount = "0";
        SaveDays = "0";
        Amount = "0";
    }
}


public class clsExtraTollDetails
{
    public string CardNo { get; set; }
    public string ThisDate { get; set; }
    public string ThisRefNo { get; set; }
    public string ByCard { get; set; }
    public string ByCash { get; set; }

    public clsExtraTollDetails()
    {
        CardNo = string.Empty;
        ThisDate = "";
        ThisRefNo = "";
        ByCard = "0";
        ByCash = "0";
    }
}