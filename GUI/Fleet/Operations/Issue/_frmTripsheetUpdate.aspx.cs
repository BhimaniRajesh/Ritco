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


public partial class GUI_Fleet_Operations_Issue_frmTripsheetUpdate : System.Web.UI.Page
{

    private double sum = 0;

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;

    int mDataCount = 0;
    MyFleetDataSet.AdvanceTakenRow datarow_Adv;

    DateFunction DtFun = new DateFunction();
    DriverBalance DBalance = new DriverBalance();

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


        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this)");

        //txtBranchCode.Text = Session["brcd"].ToString();

        if (!IsPostBack)
        {
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

                System.DateTime righnow = System.DateTime.Today;
                string strrightnow = righnow.ToString("dd/MM/yyyy");
                string mToDt = DtFun.return_date(strrightnow);
                string mDBVal = "";
                mDBVal = DBalance.GetDriverBalanceAmt(Session["strDriverCode"].ToString(), mToDt);
                LblDriverBalance.Text = mDBVal;
            }

            dataReadVI.Close();
            conn.Close();
            BindGrid();

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


            string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ",'" + VslipDt + "','" + VCloseDt + "','" + ServerDt + "')";
            cmdSubmit.Attributes.Add("onClick", aa);
            //Inetialized_AdvanceTaken();


            //if (mDataCount == 0)
            //{

            //    BindGrid();
            //}
            //txtAddRowAdv.Text = mDataCount.ToString();

        }

    }

    protected void PopulateAdvamt(object sender, EventArgs e)
    {
        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {
            if (((TextBox)gridrow.FindControl("txtAdvAmt")).Text != "")
            {

                if (((TextBox)gridrow.FindControl("txtAdvAmt")).ReadOnly == false)
                {
                    txtAmount.Text = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;
                }
            }
        }
    }

    public void BindGrid()
    {
        dgAdvanceDet.DataSource = _dataSet.AdvanceTaken;
        dgAdvanceDet.DataBind();
        _lastEditedPage = dgAdvanceDet.CurrentPageIndex;

    }







    public void Previous_advance()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string mSTR = "  select convert(varchar,AdvDate,103) as ADate, * from WEBX_TRIPSHEET_ADVEXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
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


                _dataSet.AdvanceTaken.AddAdvanceTakenRow(place, advdt, amt, "", brnch, advpaidby);

            }

        }
        dr1.Close();
        conn.Close();
        Inetialized_AdvanceTaken();
        BindGrid();
        int i = 0;
        foreach (DataGridItem gridrow in dgAdvanceDet.Items)
        {

            //int i = 0;
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

                ((TextBox)gridrow.FindControl("txtBranchCode")).ReadOnly = true;
                ((TextBox)gridrow.FindControl("txtBranchCode")).Text = SessionUtilities.CurrentBranchCode.Trim();
                ((HiddenField)gridrow.FindControl("hdfldBranchCode")).Value = SessionUtilities.CurrentBranchCode.Trim();




                ((TextBox)gridrow.FindControl("txtSignature")).ReadOnly = false;
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



    protected void dgAdvanceDet_ItemDataBound(object sender, DataGridItemEventArgs e)
    {




        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {

            datarow_Adv = ((MyFleetDataSet.AdvanceTakenRow)((DataRowView)e.Item.DataItem).Row);


            ((TextBox)e.Item.FindControl("txtAdvPlace")).Text = datarow_Adv.AdvPlace;
            ((TextBox)e.Item.FindControl("txtAdvDt")).Text = datarow_Adv.AdvDt;
            ((TextBox)e.Item.FindControl("txtAdvAmt")).Text = datarow_Adv.AdvAmt;
            ((TextBox)e.Item.FindControl("txtBranchCode")).Text = datarow_Adv.BranchCode;

            string mTripLoc = "";
            //mTripLoc = Session["brcd"].ToString();
            mTripLoc = SessionUtilities.CurrentBranchCode.Trim();
            ((TextBox)e.Item.FindControl("txtSignature")).Text = datarow_Adv.Signature;

            ((TextBox)e.Item.FindControl("txtAdvDt")).Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Fleet_Date_Control_Rule_Check.aspx')");
            ((TextBox)e.Item.FindControl("txtAdvPlace")).Attributes.Add("onblur", "javascript:Trip_Validation(this,'" + lblIssueNo.Text + "','" + mTripLoc + "')");
        }
    }
    public void Inetialized_AdvanceTaken()
    {
        _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
    }

    //protected void add_rowAdv(object sender, EventArgs e)
    //{
    //    string rowno;
    //    int mroww = 0;
    //    int miroww = 0;
    //    int count=0;
    //    rowno = txtAddRowAdv.Text;
    //    mroww = Convert.ToInt16(rowno);
    //    int i;
    //    int iroww = 0;
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    foreach (DataGridItem gridrow in dgAdvanceDet.Items)
    //    {
    //        iroww = iroww + 1;
    //    }
    //    if (iroww >= 0)
    //    {
    //        int tmp = 0;
    //        conn.Open();
    //        string STR11 = "select *  from WEBX_TRIPSHEET_ADVEXP where TripSheetNo ='" + Session["Tripsheet"].ToString() + "'  ";
    //        SqlCommand STRcd = new SqlCommand(STR11, conn);
    //        SqlDataReader drSTR = STRcd.ExecuteReader();
    //        if (drSTR.HasRows)
    //        {
    //            while (drSTR.Read())
    //            {
    //                count = count + 1;
    //            }
    //        }
    //        drSTR.Close();


    //        int counter = 0;

    //    }


    //    if (dgAdvanceDet.Items.Count == 0)
    //    {

    //        for (i = 0 + miroww; i < Int16.Parse(txtAddRowAdv.Text); i++)
    //        {
    //            _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
    //        }

    //    }
    //    else
    //    {

    //       int count1 = 0;



    //       if (iroww > count)
    //       {
    //           int j = 0;

    //           int t = iroww;

    //           foreach (DataGridItem gridrow in dgAdvanceDet.Items)
    //           {
    //                   if (t > count)
    //               {
    //                   t = t - 1;

    //                   _dataSet.AdvanceTaken.RemoveAdvanceTakenRow(_dataSet.AdvanceTaken[t]);

    //               }   

    //           }

    //       }  



    //        for (i = 0 ; i < Int16.Parse(txtAddRowAdv.Text); i++)
    //        {
    //            _dataSet.AdvanceTaken.AddAdvanceTakenRow("", "", "", "", "", "");
    //        }


    //     }

    //    BindGrid();


    //    conn.Close();
    //    int m = 0;
    //    foreach (DataGridItem gridrow in dgAdvanceDet.Items)
    //    {

    //        if (m < count)
    //        {

    //            ((TextBox)gridrow.FindControl("txtAdvPlace")).ReadOnly = true;
    //            ((TextBox)gridrow.FindControl("txtAdvDt")).ReadOnly = true;
    //            ((TextBox)gridrow.FindControl("txtAdvAmt")).ReadOnly = true;

    //            ((TextBox)gridrow.FindControl("txtBranchCode")).ReadOnly = true;
    //            ((TextBox)gridrow.FindControl("txtSignature")).ReadOnly = true;
    //            m = m + 1;
    //        }

    //        else
    //        {

    //            ((TextBox)gridrow.FindControl("txtAdvPlace")).ReadOnly = false;
    //            ((TextBox)gridrow.FindControl("txtAdvDt")).ReadOnly = false;
    //            ((TextBox)gridrow.FindControl("txtAdvAmt")).ReadOnly = false;

    //            ((TextBox)gridrow.FindControl("txtBranchCode")).ReadOnly = false;
    //            ((TextBox)gridrow.FindControl("txtSignature")).ReadOnly = false;
    //        }

    //    }


    //}
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
            foreach (DataGridItem gridrow3 in dgAdvanceDet.Items)
            {



                if (((TextBox)gridrow3.FindControl("txtAdvPlace")).ReadOnly == false)
                {


                    string mplace = ((TextBox)gridrow3.FindControl("txtAdvPlace")).Text;
                    string mAdDt = ((TextBox)gridrow3.FindControl("txtAdvDt")).Text;

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

                    if (lblError.Text == "" && mAmt1 == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = " Advance Amount is Compulsory!";

                    }

                    if (lblError.Text == "" && mBCode == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = " Advance   Branchcode is Compulsory!";

                    }


                    if (lblError.Text == "" && mSign == "")
                    {
                        lblError.Visible = true;
                        lblError.Text = "Advance Payee is Compulsory!";

                    }

                }

            }

        }

        if (lblError.Text == "")
        {
            foreach (DataGridItem gridrow in dgAdvanceDet.Items)
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
            foreach (DataGridItem mgridrow in dgAdvanceDet.Items)
            {

                if (((TextBox)mgridrow.FindControl("txtBranchCode")).ReadOnly == false)
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
            string mBranchCode = "";
            try
            {
                //sqlDEL = "Delete from WEBX_TRIPSHEET_ADVEXP where TripSheetNo='" + mTripSheetNo + "'";
                //cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                //cmdDEL.ExecuteNonQuery();
                //cmdDEL.Dispose();

                foreach (DataGridItem gridrow in dgAdvanceDet.Items)
                {
                    if (((TextBox)gridrow.FindControl("txtAdvPlace")).ReadOnly == false)
                    {
                        //string mAdvPlace = ((DropDownList)gridrow.FindControl("cboAdvPlace")).SelectedItem.Value;
                        string mAdvPlace = ((TextBox)gridrow.FindControl("txtAdvPlace")).Text;

                        DateTime mAdvDt = new DateTime();
                        mAdvDt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtAdvDt")).Text, dtfi);

                        string mAdvAmt = ((TextBox)gridrow.FindControl("txtAdvAmt")).Text;

                        //   mTotAdvExp = mTotAdvExp + Convert.ToDouble(mAdvAmt);

                        //string mTHCno = ((TextBox)gridrow.FindControl("txtTHCno")).Text;
                        //mBranchCode = ((TextBox)gridrow.FindControl("txtBranchCode")).Text;
                        mBranchCode = ((HiddenField)gridrow.FindControl("hdfldBranchCode")).Value;



                        string mSignature = ((TextBox)gridrow.FindControl("txtSignature")).Text;




                        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
                        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
                        DropDownList dlstAcccode = (DropDownList)paymen.FindControl("dlstAcccode");

                        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
                        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");

                        string madv_Transtype = dlsttranstype.SelectedItem.Value;
                        if (madv_Transtype == "" || madv_Transtype == null)
                        {
                            madv_Transtype = "NULL";
                        }
                        else
                        {
                            madv_Transtype = "'" + madv_Transtype + "'";
                        }


                        string madv_Chqno = txtChqNo.Text;
                        if (madv_Chqno == "" || madv_Chqno == null)
                        {
                            madv_Chqno = "NULL";
                        }
                        else
                        {
                            madv_Chqno = "'" + madv_Chqno + "'";
                        }

                        string madv_Chqdate = txtChqDate.Text;
                        if (madv_Chqdate == "" || madv_Chqdate == null)
                        {
                            madv_Chqdate = "NULL";
                        }
                        else
                        {
                            madv_Chqdate = "'" + madv_Chqdate + "'";
                        }

                        string madv_acccode = dlstAcccode.SelectedItem.Value;
                        if (madv_acccode == "" || madv_acccode == null)
                        {
                            madv_acccode = "NULL";
                        }
                        else
                        {
                            madv_acccode = "'" + madv_acccode + "'";
                        }


                        string mEntryby = "'" + SessionUtilities.CurrentEmployeeID.Trim() + "'";


                        if (mAdvAmt != "" && mAdvAmt != null)
                        {

                            //sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature) values ("
                            //     + "'" + mTripSheetNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "') ";

                            sql = " Insert into WEBX_TRIPSHEET_ADVEXP (TripSheetNo,AdvLoc,AdvDate,AdvAmt,BranchCode,Signature,adv_Transtype,adv_Chqno,adv_Chqdate,adv_acccode,Entryby) values ("
                                 + "'" + mTripSheetNo + "','" + mAdvPlace + "','" + mAdvDt + "','" + mAdvAmt + "','" + mBranchCode + "','" + mSignature + "'," + madv_Transtype + "," + madv_Chqno + "," + madv_Chqdate + "," + madv_acccode + "," + mEntryby + " ) ";


                            SqlCommand AdvDetail = new SqlCommand(sql, conn, trans);
                            AdvDetail.CommandType = CommandType.Text;

                            datarow_Adv = _dataSet.AdvanceTaken[gridrow.DataSetIndex];

                            _dataSet.AdvanceTaken[gridrow.DataSetIndex].ItemArray = datarow_Adv.ItemArray;

                            AdvDetail.ExecuteNonQuery();
                        }
                    }
                }

                //// //----------------- FLEET TRANSACTION -----------------------------------
                //string mFinYear = "";
                //string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
                //SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, conn, trans);
                //sqlcmdFinYear.CommandType = CommandType.Text;
                //SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
                //if (drFinYear.Read())
                //{
                //    mFinYear = drFinYear["YearVal"].ToString().Trim();
                //}
                //drFinYear.Close();

                //string mYearVal = "";
                //if (Session["FinYear_Change"] != null)
                //{
                //    mYearVal = Session["FinYear_Change"].ToString().Trim();
                //}

                string mFinYear = "";
                mFinYear = SessionUtilities.FinYear.ToString().Trim();
                string mYearVal = "";
                GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));
                mYearVal = objFinYear.FinancialYear();


                string sqlAcc = "usp_FleetTransaction";
                SqlCommand sqlcmdAcc = new SqlCommand(sqlAcc, conn, trans);
                sqlcmdAcc.CommandType = CommandType.StoredProcedure;
                sqlcmdAcc.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = mBranchCode;// Session["brcd"].ToString();
                sqlcmdAcc.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "3";
                sqlcmdAcc.Parameters.Add("@docNo", SqlDbType.VarChar).Value = mTripSheetNo;
                sqlcmdAcc.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                sqlcmdAcc.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                sqlcmdAcc.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                sqlcmdAcc.ExecuteNonQuery();
                //////------------------------------------------------------------------------

                trans.Commit();
                //trans.Rollback();
                success = true;
                Session["strDriverCode"] = null;
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

                //    Response.Redirect("~/admin/lenseprice.aspx?code=" + Code + "&LenseId=" + LenseId);

                Response.Redirect("frmVehicleIssueSlipClose_result.aspx?VSlipId=" + lblIssueNo.Text.ToString() + "&mode=Advance&mFlag=" + mFlag, true);

            }

        }



    }
    protected void txtBranchCode_TextChanged(object sender, EventArgs e)
    {


        foreach (DataGridItem mgridrow in dgAdvanceDet.Items)
        {

            if (((TextBox)mgridrow.FindControl("txtBranchCode")).ReadOnly == false)
            {
                lblError.Text = "";
                string mBranchCode = ((TextBox)mgridrow.FindControl("txtBranchCode")).Text;
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

                conn.Open();
                string DataFound = "N";

                string msql = "select  * from webx_Location  where loccode='" + mBranchCode.Trim() + "' and ActiveFlag='Y' ";
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
}
