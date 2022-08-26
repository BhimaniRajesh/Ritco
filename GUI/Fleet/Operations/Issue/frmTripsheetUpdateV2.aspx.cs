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

public partial class GUI_Fleet_Operations_Issue_frmTripsheetUpdateV2 : System.Web.UI.Page
{

    private double sum = 0;
    static string str_Connection_String = "";
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenFARow datarow_Adv;

    DateFunction DtFun = new DateFunction();
    DriverBalance DBalance = new DriverBalance();

    string stVSlipId = "";
    DataTable dt_BindGrid = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        dt_BindGrid = new DataTable();
        dt_BindGrid.Columns.Add("SystemDate", typeof(string));
        dt_BindGrid.Columns.Add("AdvPlace", typeof(string));
        dt_BindGrid.Columns.Add("AdvDt", typeof(string));
        dt_BindGrid.Columns.Add("Mode", typeof(string));
        dt_BindGrid.Columns.Add("Account", typeof(string));
        dt_BindGrid.Columns.Add("AdvAmt", typeof(string));
        dt_BindGrid.Columns.Add("RefNo", typeof(string));
        dt_BindGrid.Columns.Add("BranchCode", typeof(string));
        dt_BindGrid.Columns.Add("Signature", typeof(string));

        str_Connection_String = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString.ToString();
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            //DtCal.SetCalenderText(strrightnow);
            txtDate.Text = strrightnow;
            hfTodayDate.Value = righnow.ToString("dd/MM/yyyy");
            conn.Open();
            stVSlipId = Request.QueryString["id"];


            Session["Tripsheet"] = null;

            Session["Tripsheet"] = stVSlipId;

            string sql = "select V.VSlipNo,Convert(varchar,VSlipDt,103) VSlipDt,V.Vehicleno as vehno,f_issue_startkm as Start_km,f_issue_fill "
                     + " ,(Select Driver_Name from webx_fleet_drivermst where Driver_Id=v.driver1) driver_name "
                     + " ,(Select License_no from webx_fleet_drivermst where Driver_Id=v.driver1) License_no "
                     + " ,(Select convert(varchar,valdity_dt,106) valdity_dt from webx_fleet_drivermst where Driver_Id=v.driver1) valdity_dt,v.driver1,v.CustCode,v.Category,v.Market_Own ,Tripsheet_StartLoc,Tripsheet_EndLoc ,(Select custnm  from webx_CUSTHDR  where custcd=v.CustCode) as Custname "
                     + " from WEBX_FLEET_VEHICLE_ISSUE v LEFT OUTER JOIN webx_fleet_vehicle_request r ON V.VSlipNo=r.VSlipId"
                     + " where 1=1 "
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

                //System.DateTime righnow = System.DateTime.Today;
                //string strrightnow = righnow.ToString("dd/MM/yyyy");
                string mToDt = DtFun.return_date(strrightnow);
                string mDBVal = "";
                mDBVal = DBalance.GetDriverBalanceAmt(Session["strDriverCode"].ToString(), mToDt);
                LblDriverBalance.Text = mDBVal;
            }

            dataReadVI.Close();
            conn.Close();
            //BindGrid();

            Previous_advance();

            string VslipDt = "";
            string VCloseDt = "";
            string ServerDt = "";


            conn.Open();
            string mSTR = "select  convert(varchar,Vslipdt,103) as Vslipdt1,ISNULL(convert(varchar,End_Dt_tm,103),'') as VCloseDt ,convert(varchar,getdate(),103) as ServerDt  from webx_fleet_vehicle_issue  where Vslipno='" + stVSlipId + "'";
            SqlCommand mcmd = new SqlCommand(mSTR, conn);
            SqlDataReader mdr = mcmd.ExecuteReader();
            if (mdr.HasRows)
            {
                while (mdr.Read())
                {
                    lblValidDt.Text = Convert.ToString(mdr["Vslipdt1"]);
                    VslipDt = Convert.ToString(mdr["Vslipdt1"]);
                    VCloseDt = Convert.ToString(mdr["VCloseDt"]);
                    ServerDt = Convert.ToString(mdr["ServerDt"]);
                }

            }
            mdr.Close();
            conn.Close();

        }

    }

    public void BindGrid()
    {
        dgAdvanceDet.DataSource = _dataSet.AdvanceTakenFA;
        dgAdvanceDet.DataBind();
    }

    public void Previous_advance()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string mSTR = "  select convert(varchar,Entrydt,106) Entrydt,  convert(varchar,AdvDate,103) as ADate,(CASE WHEN UPPER(adv_Transtype)='CASH' THEN '1' WHEN UPPER(adv_Transtype)='BANK' THEN '3' WHEN UPPER(adv_Transtype)='HAPPAY' THEN '2' END) AS Mode, * from WEBX_TRIPSHEET_ADVEXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "' AND (AdvanceToDriver='Y' OR THCno IS NULL) ";
        SqlCommand cmd = new SqlCommand(mSTR, conn);

        int count = 0;
        SqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.HasRows)
        {
            while (dr1.Read())
            {
                count = count + 1;

                string place = Convert.ToString(dr1["AdvLoc"]);
                string advdt = Convert.ToString(dr1["ADate"]);
                string amt = Convert.ToString(dr1["AdvAmt"]);

                string brnch = Convert.ToString(dr1["BranchCode"]);
                string advpaidby = Convert.ToString(dr1["Signature"]);
                string mode = Convert.ToString(dr1["Mode"]);
                string chqno = Convert.ToString(dr1["adv_Chqno"]);
                string accountCode = Convert.ToString(dr1["adv_acccode"]);

                string Entrydt = Convert.ToString(dr1["Entrydt"]);

                DataRow dr = dt_BindGrid.NewRow();
                dr["SystemDate"] = Entrydt;
                dr["AdvPlace"] = place;
                dr["AdvDt"] = advdt;
                dr["Mode"] = mode;
                dr["Account"] = accountCode;
                dr["AdvAmt"] = amt;
                dr["RefNo"] = "";
                dr["BranchCode"] = brnch;
                dr["Signature"] = advpaidby;
                dt_BindGrid.Rows.Add(dr);
                // _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow(place, advdt, amt, "", brnch, advpaidby, chqno, mode, accountCode);
            }

        }

        DataRow dr2 = dt_BindGrid.NewRow();
        dr2["SystemDate"] = System.DateTime.Now.ToString("dd MMM yyyy");
        dr2["AdvPlace"] = "";
        dr2["AdvDt"] = "";
        dr2["Mode"] = "";
        dr2["Account"] = "";
        dr2["AdvAmt"] = "";
        dr2["RefNo"] = "";
        dr2["BranchCode"] = "";
        dr2["Signature"] = "";
        dt_BindGrid.Rows.Add(dr2);

        dgAdvanceDet.DataSource = dt_BindGrid;
        dgAdvanceDet.DataBind();

        dr1.Close();
        conn.Close();
        //Inetialized_AdvanceTaken();
        //BindGrid();
        int i = 0;
        foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
        {
            if (i < count)
            {
                ((TextBox)gridrow.FindControl("txtAdvPlace")).Enabled = false;
                ((TextBox)gridrow.FindControl("txtAdvDt")).Enabled = false;
                ((DropDownList)gridrow.FindControl("ddlMode")).Enabled = false;
                ((DropDownList)gridrow.FindControl("ddlAcount")).Enabled = false;

                ((TextBox)gridrow.FindControl("txtAdvAmt")).Enabled = false;
                ((TextBox)gridrow.FindControl("txtRefNo")).Enabled = false;
                ((TextBox)gridrow.FindControl("txtBranchCode")).Enabled = false;
                ((TextBox)gridrow.FindControl("txtSignature")).Enabled = false;
                i = i + 1;
            }
            else
            {

                ((TextBox)gridrow.FindControl("txtAdvPlace")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtAdvDt")).Enabled = true;
                ((DropDownList)gridrow.FindControl("ddlMode")).Enabled = true;
                ((DropDownList)gridrow.FindControl("ddlAcount")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtAdvAmt")).Enabled = true;
                //((TextBox)gridrow.FindControl("txtRefNo")).Enabled = true;
                ((TextBox)gridrow.FindControl("txtBranchCode")).Enabled = false;
                ((TextBox)gridrow.FindControl("txtBranchCode")).Text = SessionUtilities.CurrentBranchCode.Trim();
                ((TextBox)gridrow.FindControl("txtSignature")).Enabled = true;

                var ddlMode = ((DropDownList)gridrow.FindControl("ddlMode"));
                //if (Request.QueryString["Type"] == "C")
                //{
                //    ddlMode.Items.Remove(ddlMode.Items.FindByText("Bank"));
                //}
                if (Request.QueryString["Type"] == "B")
                {
                    ddlMode.Items.Remove(ddlMode.Items.FindByText("Cash"));
                }
                
            }

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
    public void Inetialized_AdvanceTaken()
    {
        _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow("", "", "", "", "", "", "", "", "");
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string mTripSheetNo = "";
        string sql = "";
        string sqlDEL = "";
        SqlCommand cmdDEL = new SqlCommand();
        lblError.Text = "";


        cmdSubmit.Enabled = false;
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";

        DateTime mServerDt = DateTime.Now;

        DateTime mIssueDt = new DateTime();
        mIssueDt = Convert.ToDateTime(lblIssueDt.Text.ToString(), dtfi);

        if (lblError.Text == "")
        {
            foreach (GridViewRow gridrow3 in dgAdvanceDet.Rows)
            {
                if (((TextBox)gridrow3.FindControl("txtAdvPlace")).ReadOnly == false)
                {
                    string mplace = ((TextBox)gridrow3.FindControl("txtAdvPlace")).Text;
                    string mAdDt = ((TextBox)gridrow3.FindControl("txtAdvDt")).Text;

                    string mMode = ((DropDownList)gridrow3.FindControl("ddlMode")).SelectedValue;
                    string mAccount = ((DropDownList)gridrow3.FindControl("ddlAcount")).SelectedValue;

                    string mAmt1 = ((TextBox)gridrow3.FindControl("txtAdvAmt")).Text;
                    string mBCode = ((TextBox)gridrow3.FindControl("txtBranchCode")).Text;
                    string mSign = ((TextBox)gridrow3.FindControl("txtSignature")).Text;

                    if (mplace == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = " Advance Place is Compulsory!";
                    }
                    if (lblError.Text == "" && mAdDt == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = "Advance  Date is Compulsory!";
                    }
                    if (lblError.Text == "" && mMode == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = "Mode is Compulsory!";
                    }
                    if (lblError.Text == "" && mAccount == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = "Account Name is Compulsory!";
                    }
                    if (lblError.Text == "" && mAmt1 == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = " Advance Amount is Compulsory!";
                    }
                    if (lblError.Text == "" && mBCode == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = " Advance Branch code is Compulsory!";
                    }
                    if (lblError.Text == "" && mSign == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = "Advance Pay is Compulsory!";

                    }
                }
            }
        }

        if (lblError.Text == "")
        {
            foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
            {
                DateTime mAdvDt = new DateTime();
                string mAdt = ((TextBox)gridrow.FindControl("txtAdvDt")).Text.Trim();
                if (Session["FinYear_Change"] != null)
                {
                    if (mAdt != "" && ((TextBox)gridrow.FindControl("txtAdvDt")).ReadOnly == false)
                    {
                        mAdvDt = Convert.ToDateTime(mAdt, dtfi);

                        DateTime dtFrom = new DateTime();
                        DateTime dtTo = new DateTime();

                        string From = "", To = "";

                        From = "01/04/" + Session["FinYear"].ToString();
                        To = "31/03/" + Convert.ToDouble(Convert.ToDouble(Session["FinYear"].ToString()) + 1);

                        dtFrom = Convert.ToDateTime(From, dtfi);
                        dtTo = Convert.ToDateTime(To, dtfi);

                        if (mAdvDt >= dtFrom && mAdvDt <= dtTo)
                        {
                            lblError.Visible = false;
                            lblError.Text = "";
                        }
                        else
                        {
                            lblError.Visible = true;
                            lblError.Text = "Advance date  should be  in the  range of selected  financial year!";
                        }
                        if (lblError.Text == "")
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
                }
            }
        }

        if (lblError.Text == "")
        {
            foreach (GridViewRow mgridrow in dgAdvanceDet.Rows)
            {
                if (((TextBox)mgridrow.FindControl("txtBranchCode")).Enabled == true)
                {
                    lblError.Text = "";
                    string mBranchCode = ((TextBox)mgridrow.FindControl("txtBranchCode")).Text;
                    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                    conn.Open();
                    string DataFound = "N";

                    string msql = "select  * from webx_Location  where loccode='" + mBranchCode.Trim() + "' ";
                    SqlCommand cmd = new SqlCommand(msql, conn);
                    SqlDataReader mdr = cmd.ExecuteReader();
                    if (mdr.HasRows)
                    {
                        while (mdr.Read())
                        {
                            DataFound = "Y";
                        }
                    }
                    mdr.Close();
                    if (DataFound == "N")
                    {
                        lblError.Visible = true;
                        lblError.Text = "Invalid Branch Code!  Please Enter Valid Branch code!!";
                    }
                    else
                    {
                        lblError.Visible = false;
                        lblError.Text = "";
                    }
                    conn.Close();

                }
            }
        }

        if (lblError.Text == "")
        {
            mTripSheetNo = lblIssueNo.Text.ToString();
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            bool success = false;
            SqlTransaction trans;
            conn.Open();
            trans = conn.BeginTransaction();
            try
            {
                string mBranchCode = "";

                //sqlDEL = "Delete from WEBX_TRIPSHEET_ADVEXP where TripSheetNo='" + mTripSheetNo + "'";
                //cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                //cmdDEL.ExecuteNonQuery();
                //cmdDEL.Dispose();
                foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
                {
                    if (((TextBox)gridrow.FindControl("txtAdvPlace")).Enabled == true)
                    {
                        string mAdvPlace = ((TextBox)gridrow.FindControl("txtAdvPlace")).Text;

                        DateTime mAdvDt = new DateTime();
                        mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);

                        string mAdvAmt = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;
                        mBranchCode = ((TextBox)gridrow.FindControl("txtBranchCode")).Text;
                        string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;


                        DropDownList ddlAcount = (DropDownList)gridrow.FindControl("ddlAcount");
                        DropDownList ddlMode = (DropDownList)gridrow.FindControl("ddlMode");
                        HiddenField hdnBankAccount = (HiddenField)gridrow.FindControl("hdnBankAccount");
                        HiddenField hdnMode = (HiddenField)gridrow.FindControl("hdnMode");
                        TextBox txtRefNo = (TextBox)gridrow.FindControl("txtRefNo");

                        string mEntryby = "'" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "'";


                        if (mAdvAmt != "" && mAdvAmt != null)
                        {
                            sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature,adv_Transtype,adv_Chqno,adv_Chqdate,adv_acccode,Entryby,COMPANY_CODE) values ("
                                 + "'" + mTripSheetNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "','" + ddlMode.SelectedItem.Text + "','" + txtRefNo.Text.Trim() + "', CONVERT(VARCHAR(20),CAST('" + mAdvDt + "' AS DATE) ,103),'" + ddlAcount.SelectedValue + "'," + mEntryby + ",'" + SessionUtilities.DefaultCompanyCode.ToString().Trim() + "') ";
                            SqlCommand AdvDetail = new SqlCommand(sql, conn, trans);
                            AdvDetail.CommandType = CommandType.Text;
                            AdvDetail.ExecuteNonQuery();
                        }
                    }
                }

                double advamt = 0;
                foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
                {
                    advamt += Convert.ToDouble(((TextBox)gridrow.FindControl("txtAdvAmt")).Text);
                }
                if (advamt != 0)
                {
                    sql = " Update WEBX_FLEET_VEHICLE_ISSUE set TotAdvExp='" + Convert.ToString(advamt) + "' Where VSlipNo ='" + mTripSheetNo + "' ";
                    SqlCommand TripHeader = new SqlCommand(sql, conn, trans);
                    TripHeader.CommandType = CommandType.Text;
                    TripHeader.ExecuteNonQuery();
                }
                //----------------- FLEET TRANSACTION -----------------------------------
                string mFinYear = "";
                mFinYear = SessionUtilities.FinYear.ToString();
                string mYearVal = "";
                GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(str_Connection_String));
                mYearVal = objFinYear.FinancialYear();

                string sqlAcc = "Usp_FleetTransaction";
                SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = mBranchCode;// SessionUtilities.CurrentBranchCode.ToString().Trim();
                sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "3";
                sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear; //2001
                sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal; // 09_10
                sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10

                sqlcmdAcc.ExecuteNonQuery();
                //------------------------------------------------------------------------
                //trans.Rollback();
                trans.Commit();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                string mFlag = "U";
                Response.Redirect("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=AdvanceV2&mFlag=" + mFlag, true);

            }
        }
    }
    protected void txtBranchCode_TextChanged(object sender, EventArgs e)
    {
    }
    protected void Add_RowAdvance(object sender, EventArgs e)
    {
        try
        {
            if ((txtAddAdvanceRow.Text == "") || (txtAddAdvanceRow.Text == "0")) txtAddAdvanceRow.Text = "0";


            _dataSet.AdvanceTakenFA.Rows.Clear();

            foreach (GridViewRow row in dgAdvanceDet.Rows)
            {
                TextBox txtAdvPlace = (TextBox)row.FindControl("txtAdvPlace");
                TextBox txtAdvDt = (TextBox)row.FindControl("txtAdvDt");
                TextBox txtAdvAmt = (TextBox)row.FindControl("txtAdvAmt");
                DropDownList ddlMode = (DropDownList)row.FindControl("ddlMode");
                DropDownList ddlAcount = (DropDownList)row.FindControl("ddlAcount");

                TextBox txtBranchCode = (TextBox)row.FindControl("txtBranchCode");
                TextBox txtSignature = (TextBox)row.FindControl("txtSignature");
                TextBox txtRefNo = (TextBox)row.FindControl("txtRefNo");


                HiddenField hdnBankAccount = (HiddenField)row.FindControl("hdnBankAccount");
                HiddenField hdnMode = (HiddenField)row.FindControl("hdnMode");

                if (hdnBankAccount.Value == "")
                {
                    hdnBankAccount.Value = ddlAcount.SelectedValue;
                }
                if (hdnMode.Value == "")
                {
                    hdnMode.Value = ddlMode.SelectedValue;
                }

                _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow(txtAdvPlace.Text, txtAdvDt.Text, txtAdvAmt.Text, "", txtBranchCode.Text, txtSignature.Text, txtRefNo.Text, ddlMode.SelectedItem.Value, hdnBankAccount.Value);
            }

            int count = 0;
            string rowno;
            rowno = txtAddAdvanceRow.Text;
            int mroww = 0;

            mroww = Convert.ToInt16(rowno);

            if (mroww >= count)
            {
                int miroww = 0;
                int i;
                int iroww = 0;
                foreach (GridViewRow row in dgAdvanceDet.Rows)
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
                        _dataSet.AdvanceTakenFA.RemoveAdvanceTakenFARow(_dataSet.AdvanceTakenFA[i]);

                    }
                }
                for (i = 0 + miroww; i < Int16.Parse(txtAddAdvanceRow.Text); i++)
                {
                    _dataSet.AdvanceTakenFA.AddAdvanceTakenFARow("", "", "", "", SessionUtilities.CurrentBranchCode.ToString().Trim(), "", "", "", "");
                }
            }

            dgAdvanceDet.DataSource = _dataSet.AdvanceTakenFA;
            dgAdvanceDet.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void dgAdvanceDet_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddlAcount = (DropDownList)e.Row.FindControl("ddlAcount");
            DropDownList ddlMode = (DropDownList)e.Row.FindControl("ddlMode");
            HiddenField hdnBankAccount = (HiddenField)e.Row.FindControl("hdnBankAccount");
            HiddenField hdnMode = (HiddenField)e.Row.FindControl("hdnMode");
            TextBox txtRefNo = (TextBox)e.Row.FindControl("txtRefNo");

            if (hdnMode.Value != "")
            {
                ddlMode.SelectedValue = hdnMode.Value;
            }
            else
            {
                ddlMode.SelectedValue = "0";

            }

            BindDropDownWithPerameter("Usp_TripsheetGene_Happay_List_Advance", "CodeName", "CodeID", ddlMode.SelectedItem.Value, ddlAcount);

            if (hdnBankAccount.Value != "")
            {
                ddlAcount.SelectedValue = hdnBankAccount.Value;
            }

            if (ddlMode.SelectedValue == "1")
            {
                txtRefNo.Enabled = false;
            }
        }
    }
    public void BindDropDownWithPerameter(string strProc, string text, string value, string parameter, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(str_Connection_String.ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Mode", SqlDbType.VarChar).Value = parameter;
		
		 if (d.Enabled == true)
        {
            cmd.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
        }
        else
        {
            cmd.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = "";
        }
        SqlDataReader dr = cmd.ExecuteReader();
        d.Items.Clear();
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
	protected void ddlMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in dgAdvanceDet.Rows)
        {
            TextBox txtAdvPlace = (TextBox)gridrow.FindControl("txtAdvPlace");
            DropDownList ddlAcount = (DropDownList)gridrow.FindControl("ddlAcount");
            DropDownList ddlMode = (DropDownList)gridrow.FindControl("ddlMode");
            HiddenField hdnBankAccount = (HiddenField)gridrow.FindControl("hdnBankAccount");
            HiddenField hdnMode = (HiddenField)gridrow.FindControl("hdnMode");
            TextBox txtRefNo = (TextBox)gridrow.FindControl("txtRefNo");

            if (txtAdvPlace.Enabled == true) {
                BindDropDownWithPerameter("Usp_TripsheetGene_Happay_List_Advance", "CodeName", "CodeID", ddlMode.SelectedItem.Value, ddlAcount);

                if (hdnBankAccount.Value != "")
                {
                    ddlAcount.SelectedValue = hdnBankAccount.Value;
                }
                if (ddlMode.SelectedValue == "1")
                {
                    txtRefNo.Text = "";
                    txtRefNo.Enabled = false;
                }
            }

        }
    }
    protected void ddlAcount_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
