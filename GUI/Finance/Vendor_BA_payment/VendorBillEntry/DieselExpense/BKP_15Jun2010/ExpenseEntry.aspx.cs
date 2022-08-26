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


public partial class GUI_Finance_Vendor_BA_payment_Fixed_Variable_Expense_ExpenseEntry : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    public string Financial_Year = "", fin_year = "", opertitle = "MANUAL DEBIT VOUCHER", Defaultdate = "";

    public static string mRepair = "";
    public static string mExpenseType = "";

    public DieselDataSet _dataSet = new DieselDataSet();
    int _lastEditedPage;
    DieselDataSet.HSD_OIL_EXPRow datarow_HSDOIL;
    string temp = "";
    string temp1 = "";
    Double current_km = 0;
    Double first_km = 0;



    protected void Page_Load(object sender, EventArgs e)
    {


       

        
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Defaultdate = Request.QueryString["Defaultdate"];
        if (Defaultdate == "")
        {
            Defaultdate = "today";
        }
        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            //grvcontrols.DataSource = dt;
            //grvcontrols.DataBind();

            string sql = "select acccode,accdesc from webx_acctinfo where accdesc like '%tds%'";
            SqlCommand cmd1 = new SqlCommand(sql, con);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            while (dr.Read())
            {
                Tdssection.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            Tdssection.CssClass = "blackfnt";

            Show_Pbov_list_Display();

            popVendor();
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            txtBillEntryDate.Text = strrightnow;
            txtBillDt.Text = strrightnow;
            // popAccountGroup();
        }
        else
        {
            ReverseBind();
        }

        txtServiceTax.Attributes.Add("onblur", "GetTot()");
        txtEduCess.Attributes.Add("onblur", "GetTot()");
        txtHEduCess.Attributes.Add("onblur", "GetTot()");
        txtTDSRate.Attributes.Add("onblur", "GetTot()");
        //  txtSrvTaxNo.Attributes.Add("onchange", "CheckTax()");
        //  txtPanNo.Attributes.Add("onblur", "CheckPan(this)");


    }
    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' ";//and codeid=12
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendorType.Items.Clear();
        cboVendorType.Items.Add(new ListItem("Select", ""));
        while (dr.Read())
        {
            cboVendorType.Items.Add(new ListItem(dr["Type_name"].ToString(), dr["Type_Code"].ToString()));
        }
        dr.Close();
        cboVendorType.CssClass = "blackfnt";
       

    }


    
    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void txtAmtApplL_TextChanged(object sender, EventArgs e)
    {

    }
    public void Show_Pbov_list_Display()
    {

    }
    public void Show_Pbov_list(object sender, EventArgs e)
    {

        Show_Pbov_list_Display();

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";

        lblError1.Text = "";
        string sql1 = "";
        string VslipDt1 = "";
        DateTime mTSDt = new DateTime();
        DieselDataSet.HSD_OIL_EXPRow datarow_OilExp;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

    
        DateTime SysBilldt = new DateTime();
        SysBilldt = Convert.ToDateTime(txtBillEntryDate.Text, dtfi);

        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                TextBox mTripsheetNo = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtTripsheetNo");
                DateTime mBilldt = new DateTime();
                mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);

                sql1 = "Select VslipDt,convert(varchar,VslipDt,103) as VslipDt1 from WEBX_FLEET_VEHICLE_ISSUE I where  Manual_TripSheetNo='" + mTripsheetNo.Text.ToString() + "'";
                SqlCommand Sqlcmd = new SqlCommand(sql1, conn);
                SqlDataReader rdr = Sqlcmd.ExecuteReader();
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        mTSDt = Convert.ToDateTime(rdr["VslipDt"].ToString());
                        VslipDt1 = rdr["VslipDt1"].ToString();
                    }
                }
                rdr.Dispose();
                rdr.Close();

                if (mBilldt < mTSDt)
                {
                    lblError1.Visible = true;
                    lblError1.Text = "Bill date should not less than tripsheet date  ( " + VslipDt1 + " ) for tripsheet no. " + mTripsheetNo.Text.ToString() + " !!!";
                }
                if (mBilldt > SysBilldt)
                {
                    lblError1.Visible = true;
                    lblError1.Text = "Bill date should not greater than system date for tripsheet no. " + mTripsheetNo.Text.ToString() + " !!!";
                }

                _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_OilExp.ItemArray;

            }
        }
        conn.Close();


        //Response.Write("submitted....");
        //Response.End();
        if (lblError1.Text == "")
        {
            string sql = "sp_get_next_be_code", BILLNO = "", Branch = Session["brcd"].ToString();
            SqlCommand sqlcmd1 = new SqlCommand(sql, con);
            sqlcmd1.CommandType = CommandType.StoredProcedure;
            sqlcmd1.Parameters.Add("@loccode", SqlDbType.VarChar).Value = Session["brcd"].ToString();
            SqlDataReader r1 = sqlcmd1.ExecuteReader();
            if (r1.Read())
            {
                BILLNO = r1["NewCode"].ToString();
            }
            r1.Close();

            string Vbrcd = Session["brcd"].ToString();
            string voucherNo = "null";// fn.NextVoucherno(Vbrcd, Financial_Year);

            string PBOV_typ = "V";
            string BILLDT = txtBillEntryDate.Text;




            string VENDORCODE = cboVendor.SelectedValue.ToString(), VENDORNAME = "";
            if (VENDORCODE != "")
            {
                VENDORNAME = fn.GetVendor(VENDORCODE);
                string[] venname;
                venname = VENDORNAME.Split(':');
                VENDORNAME = venname[1];
            }


            string VENDORBILLDT = txtBillDt.Text;
            string VENDORBILLNO = txtBillNumber.Text;
            double PCAMT = Convert.ToDouble(txtBillAmt.Text);
            double ADVAMT = 0, OTHAMT = 0;
            double SVCTAX = Convert.ToDouble(txtServiceTax.Text);
            string DUEDT = txtDueDate.Text;
            string ENTRYBY = Session["empcd"].ToString();
            string REMARK = txtRemarks.Text;
            string PAYDT = txtBillEntryDate.Text;
            double OTHERDED = 0;
            double TDSRATE = Convert.ToDouble(txtTDSRate.Text);
            double TDS = Convert.ToDouble(txtTDSAmt.Text);
            double SVCTAXDED = 0;
            double OTHERCHRG = 0;
            string tdsacccode = Tdssection.SelectedValue.ToString(), tdsaccdesc = Tdssection.SelectedItem.ToString();
            string tdsfor = cboCorporate.SelectedValue.ToString();
            string cessamt = txtEduCess.Text;
            string tdsgrpcode = Tdssection.SelectedValue.ToString();
            string tdsgrpdesc = Tdssection.SelectedItem.ToString();
            mExpenseType = "Fuel";
            string betype = mExpenseType + " Expense";
            string REFNO = txtRefNo.Text;
            double servicetaxrate = 12;// Convert.ToDouble(txtServiceTax_rate.Text);
            double othertax = 2;// Convert.ToDouble(txtEduCessRate.Text);
            double ACTothertax = Convert.ToDouble(txtEduCess.Text);
            double DEDUCTION_CHRG = 0;// Convert.ToDouble(txtOtherDedudction.Text);
            double discount = 0;// Convert.ToDouble(txtDiscRecvd.Text);
            double NETAMT = Convert.ToDouble(txtNetPayableAmt.Text);



            //Response.End();
            double acct_credit = 0, acct_debit = 0;
            string acct_acccode = "", acct_Oppaccount = "", acct_oppacccode = "";
            string Narration = "When Expense Entry Done ,Bill is generated : " + BILLNO;
            string opertitle = "Expense Bill Entry ";
            string TransNo = "1";
            string transdt = "";
            string[] exp_accdoe = crediit_account.Text.ToString().Split(':');
            string expenseacccode = exp_accdoe[0].Trim().ToString(), expenseaccdesc = exp_accdoe[1].ToString();
            //DateTime BillDate = Convert.ToDateTime(BILLDT);
            BILLDT = fn.Mydate1(BILLDT);
            //DateTime Vendor_BillDate = Convert.ToDateTime(VENDORBILLDT);
            VENDORBILLDT = fn.Mydate1(VENDORBILLDT);

            //DateTime paymentDt = Convert.ToDateTime(PAYDT);
            PAYDT = "null";// fn.Mydate1(PAYDT);

            // DateTime duedate = Convert.ToDateTime(DUEDT);
            DUEDT = fn.Mydate1(DUEDT);

            SqlTransaction trn;
            trn = con.BeginTransaction();


            try  //  try FOR ALL
            {

                string sqlInsert = "INSERT INTO WEBX_VENDORBILL_HDR (BILLNO, BILLSF, BRCD, BILLDT, VENDORCODE, VENDORNAME, VENDORBILLDT,VENDORBILLNO, PCAMT, ADVAMT, OTHAMT, SVCTAX, DUEDT,ENTRYBY, ENTRYDT, REMARK, PAYDT, VOUCHERNO, OTHERDED, TDSRATE, TDS,SVCTAXDED, OTHERCHRG, NETAMT,tdsfor,cessamt,tdsgrpcode,tdsgrpdesc,betype,acccode,accdesc,REFNO,tdsacccode,tdsaccdesc,servicetaxrate,othertaxrate,othertax,DEDUCTION_CHRG,discount,PENDAMT,Hedu_cess,hdu_cessrate) VALUES('" + BILLNO + "','.','" + Session["brcd"].ToString() + "','" + BILLDT + "','" + VENDORCODE + "','" + VENDORNAME + "','" + VENDORBILLDT + "','" + VENDORBILLNO + "'," + PCAMT + "," + ADVAMT + "," + OTHAMT + "," + SVCTAX + ",'" + DUEDT + "','" + ENTRYBY + "',getdate(),'" + REMARK + "'," + PAYDT + "," + voucherNo + "," + OTHERDED + "," + TDSRATE + "," + TDS + "," + SVCTAXDED + "," + OTHERCHRG + "," + NETAMT + ",'" + tdsfor + "'," + cessamt + ",'" + tdsgrpcode + "','" + tdsgrpdesc + "','" + betype + "','" + expenseacccode + "','" + expenseaccdesc + "','" + REFNO + "','" + tdsacccode + "','" + tdsaccdesc + "'," + servicetaxrate + "," + othertax + "," + ACTothertax + "," + DEDUCTION_CHRG + "," + discount + "," + NETAMT + ",'" + txtHEduCess.Text + "','1')";
                SqlCommand sqlcmd_Insert = new SqlCommand(sqlInsert, con, trn);
                sqlcmd_Insert.ExecuteNonQuery();
                transdt = BILLDT;
                string v_approve_reject_by = "null";
                //string v_approve_reject_branch = "";
                string v_closed_by = "null";
                string v_closed_branch = "null";
                string oppacccode = "null";
                string v_approve_reject_dt = "null";
                string prepareByLoc = Branch;
                string Payto = "NUll";
                string v_approve_reject_branch = Session["brcd"].ToString(), panno = "", servicetaxNo = "";
                string entryfor = Session["empcd"].ToString(), Entryby = Session["empcd"].ToString();
                string PBOV_code = VENDORCODE, PBOV_Name = VENDORNAME;
                string Deptcode = "";
                Branch = Session["brcd"].ToString();








                //----------------------------------------------------------------------------------




                //sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPDET where TripSheetNo='" + mTripSheetNo + "'";
                //cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                //cmdDEL.ExecuteNonQuery();
                // cmdDEL.Dispose();
                double mTotOilExp = 0;
                string mTripSheetNo = "";
                foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
                {
                    mTripSheetNo = ((TextBox)gridrow.FindControl("txtTripsheetNo")).Text;
                    string mOilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
                    string mPPName = cboVendor.SelectedItem.Value;// ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Text;
                    string mBrand = "2"; //((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Text;
                    string mFuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Value;
                    string mLastKm = ((Label)gridrow.FindControl("txtLKmRead")).Text;

                    string mCard_Cash = "Credit";// ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Text;
                    string mRemark = ((TextBox)gridrow.FindControl("txtRemarks")).Text;






                    string mKM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
                    string mBillno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
                    DateTime mBilldt = new DateTime();
                    mBilldt = Convert.ToDateTime(((TextBox)gridrow.FindControl("txtBilldt")).Text, dtfi);

                    string mDiesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
                    string mOil_Ltr = "0";// ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;

                    string mDiesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
                    string mOil_Rate = "0";// ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;

                    double mAmtval = 0;
                    mAmtval = (Convert.ToDouble(mDiesel_Ltr.ToString()) * Convert.ToDouble(mDiesel_Rate.ToString()));
                    string mAmt = mAmtval.ToString();// ((TextBox)gridrow.FindControl("txtAmt")).Text;


                    string mExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;

                    mTotOilExp = mTotOilExp + Convert.ToDouble(mAmt);


                    conn.Open();
                    string Vslipno = "";
                    string VehicleNo = "";
                    string sqlstr = "Select Vslipno,VehicleNo from WEBX_FLEET_VEHICLE_ISSUE I where  Manual_TripSheetNo='" + mTripSheetNo.ToString() + "'";
                    SqlCommand Sqlcmd1 = new SqlCommand(sqlstr, conn);
                    SqlDataReader rdr1 = Sqlcmd1.ExecuteReader();
                    if (rdr1.HasRows)
                    {
                        while (rdr1.Read())
                        {
                            Vslipno = rdr1["Vslipno"].ToString();
                            VehicleNo = rdr1["VehicleNo"].ToString();
                            
                        }
                    }
                    rdr1.Dispose();
                    rdr1.Close();
                    conn.Close();


                    sql = " Insert into WEBX_TRIPSHEET_OILEXPDET (TripSheetNo,Place,KM_Reading,BillNo,BillDt,Diesel_Ltr,Oil_Ltr,Amount,Diesel_Rate,Oil_Rate,PetrolPName,Brand,FuelType,Last_Km_Read,Card_Cash,Remark,Exe_Amt,Currloc,vendor_billno) values ( "
                         + "'" + Vslipno + "', '" + mOilPlace + "','" + mKM_Reading + "','" + mBillno + "','" + mBilldt + "','" + mDiesel_Ltr + "','" + mOil_Ltr + "','" + mAmt + "'," + mDiesel_Rate + "," + mOil_Rate + ",'" + mPPName + "','" + mBrand + "','" + mFuelType + "','" + mLastKm + "','" + mCard_Cash + "','" + mRemark + "','" + mExeAmt + "','" + Session["brcd"].ToString() + "','" + BILLNO + "') ";
                    SqlCommand HSDOilDetail = new SqlCommand(sql, con, trn);
                    HSDOilDetail.CommandType = CommandType.Text;

                    datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];

                    _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_HSDOIL.ItemArray;

                    HSDOilDetail.ExecuteNonQuery();


                    sql = " Update webx_vehicle_hdr set current_KM_Read='" + mKM_Reading + "'   where vehno='" + VehicleNo + "'";
                    SqlCommand VH = new SqlCommand(sql, con, trn);
                    VH.CommandType = CommandType.Text;
                    VH.ExecuteNonQuery();


                    string mActual_KMPL = "0";
                    string mActual_Approved = "0";
                    string mApproved_Ltr = "0";
                    string mApproved_Rate = "0";
                    string mApproved_Amt = "0";
                    string mAmount = mTotOilExp.ToString();

                    //sqlDEL = "Delete from WEBX_TRIPSHEET_OILEXPHDR where TripSheetNo='" + mTripSheetNo + "'";
                    //cmdDEL = new SqlCommand(sqlDEL, conn, trans);
                    //cmdDEL.ExecuteNonQuery();
                    //cmdDEL.Dispose();


                    sql = " Insert into WEBX_TRIPSHEET_OILEXPHDR (TripSheetNo,Actual_KMPL,Actual_Approved,Approved_Ltr,Approved_Rate,Approved_Amt,Amount) values ( "
                            + "'" + Vslipno + "','" + mActual_KMPL + "','" + mActual_Approved + "','" + mApproved_Ltr + "','" + mApproved_Rate + "','" + mApproved_Amt + "','" + mAmount + "') ";
                    SqlCommand HSDOilHeader = new SqlCommand(sql, con, trn);
                    HSDOilHeader.CommandType = CommandType.Text;
                    HSDOilHeader.ExecuteNonQuery();


                }






                //------------------------------------------------------------------------------------







                string mFinYear = "";
                string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
                SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, con, trn);
                sqlcmdFinYear.CommandType = CommandType.Text;
                SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
                if (drFinYear.Read())
                {
                    mFinYear = drFinYear["YearVal"].ToString().Trim();
                }
                drFinYear.Close();

                string mYearVal = "";
                if (Session["FinYear_Change"] != null)
                {
                    mYearVal = Session["FinYear_Change"].ToString().Trim();
                }

                string sqlAatlas = "usp_Vendor_Fuel_Billentry_transaction";
                SqlCommand sqlcmdAatlas = new SqlCommand(sqlAatlas, con, trn);
                sqlcmdAatlas.CommandType = CommandType.StoredProcedure;
                sqlcmdAatlas.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = Session["brcd"].ToString();
                sqlcmdAatlas.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "1";
                sqlcmdAatlas.Parameters.Add("@docNo", SqlDbType.VarChar).Value = BILLNO;
                sqlcmdAatlas.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                sqlcmdAatlas.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                sqlcmdAatlas.ExecuteNonQuery();


                //string sqlAcc2 = "usp_Vendor_Fixed_Variable_Billentry_transaction";
                //SqlCommand sqlcmdAcc2 = new SqlCommand(sqlAcc2, con, trn);
                //sqlcmdAcc2.CommandType = CommandType.StoredProcedure;
                //sqlcmdAcc2.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = Session["brcd"].ToString();
                //sqlcmdAcc2.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "2";
                //sqlcmdAcc2.Parameters.Add("@docNo", SqlDbType.VarChar).Value = BILLNO;
                //sqlcmdAcc2.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                //sqlcmdAcc2.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                //sqlcmdAcc2.ExecuteNonQuery();






                trn.Commit();
                //trn.Rollback();
                con.Close();


                string final = "?BillNo=" + BILLNO;
                final += "&voucherNo=" + voucherNo;
                Response.Redirect("ExpenseEntryDone.aspx" + final);

            }
            catch (Exception e1)
            {
                Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
                string msg = e1.Message.ToString();
                msg = msg.Replace('\n', ' ');
                trn.Rollback();
                //Response.Redirect("Message.aspx?" + e1.Message);
                Response.End();

            }

        }
    }

    



    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
        string sql = "select top 1 '' as c1,'-Select-' as c2 from webx_vendor_hdr WITH(NOLOCK)";// Union select distinct m.vendorcode as c1 ,m.vendorname +':'+ m.vendorcode  as c2 from webx_vendor_hdr m  WITH(NOLOCK) ,webx_vendor_det d  WITH(NOLOCK)  where m.vendorcode=d.vendorcode and VENDORBRCD like '%" + Session["brcd"].ToString() + "%'  and vendor_type=" + strvendor + "";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "c2";
        cboVendor.DataValueField = "c1";

        cboVendor.DataBind();
        cboVendor.CssClass = "blackfnt";
        sql = "select * from webx_AcctHead WITH(NOLOCK) where codeid=" + strvendor + " and accthead is not null";
        Response.Write("sql : " + sql);
        sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        string acccode = "", accdesc = "";

        while (dr.Read())
        {
            if (dr["accthead"].ToString() != "")
            {
                acccode = dr["accthead"].ToString();
                accdesc = fn.getAccountDesc("webx_acctinfo", acccode);
                // crediit_account.Text=dr["accthead"].ToString()+":"+fn.getAccountDesc(dr["accthead"].ToString());
            }
        }
        crediit_account.Text = acccode + ":" + accdesc;
        crediit_account.CssClass = "blackfnt";
        dr.Close();

        conn.Close();



    }



    private void ReverseBind()
    {
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_HSDOIL = _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex];
            datarow_HSDOIL.OilPlace = ((TextBox)gridrow.FindControl("txtOilPlace")).Text;
            //datarow_HSDOIL.PPName = ((DropDownList)gridrow.FindControl("ddlPPName")).SelectedItem.Value;
            //datarow_HSDOIL.Brand = ((DropDownList)gridrow.FindControl("ddlBrand")).SelectedItem.Value;
            datarow_HSDOIL.FuelType = ((DropDownList)gridrow.FindControl("ddlFuelType")).SelectedItem.Value;
            datarow_HSDOIL.Last_Km_Read = ((Label)gridrow.FindControl("txtLKMRead")).Text;
            datarow_HSDOIL.KM_Reading = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;
            datarow_HSDOIL.Billno = ((TextBox)gridrow.FindControl("txtBillno")).Text;
            datarow_HSDOIL.Billdt = ((TextBox)gridrow.FindControl("txtBilldt")).Text;
            datarow_HSDOIL.Diesel_Ltr = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;
            //datarow_HSDOIL.Oil_Ltr = ((TextBox)gridrow.FindControl("txtOil_Ltr")).Text;
            datarow_HSDOIL.Diesel_Rate = ((TextBox)gridrow.FindControl("txtDieselRate_Ltr")).Text;
            
            /*string diesel_qty = datarow_HSDOIL.Diesel_Ltr;
            if (diesel_qty == "")
            {
                diesel_qty = "0";
            }
            string diesel_rate = datarow_HSDOIL.Diesel_Rate;

            if (diesel_rate == "")
            {
                diesel_rate = "0";
            }

            double totamt = Convert.ToDouble(diesel_qty) * Convert.ToDouble(diesel_rate);*/
            //((TextBox)e.Item.FindControl("txtAmt")).Text = totamt.ToString();// datarow_HSDOIL.Amt;
            //datarow_HSDOIL.Amt = totamt.ToString();
            datarow_HSDOIL.Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;


            datarow_HSDOIL.Exe_Amt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
            //datarow_HSDOIL.Payment = ((DropDownList)gridrow.FindControl("ddlPayment")).SelectedItem.Value;
            datarow_HSDOIL.Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
            
            //datarow_HSDOIL.Oil_Rate = ((TextBox)gridrow.FindControl("txtOilRate_Ltr")).Text;
            datarow_HSDOIL.TripsheetNo = ((TextBox)gridrow.FindControl("txtTripsheetNo")).Text;
            datarow_HSDOIL.VehicleNo = ((Label)gridrow.FindControl("txtVehicleno")).Text;




        }
    }

    public void Inetialized_HSD_OIL_EXP()
    {
        _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "0", "", "", "0", "0", "", "");

    }

    protected void add_rowOil(object sender, EventArgs e)
    {

        string rowno;
        int mroww = 0;
        int miroww = 0;
        rowno = txtAddRowOilExp.Text;
        mroww = Convert.ToInt16(rowno);
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

            string LastKm2 = "0";// lblStartKm.Text;
            LastKm1 = 0;// Convert.ToDouble(lblStartKm.Text);
            int LastKm = Convert.ToInt32(LastKm1);
            //
            //



            if (i == 0)
            {



                _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", LastKm2, "", "", "", "0", "0", "", "0", "", "", "0", "0", "", "");
            }
            else
            {

                _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "0", "", "", "0", "0", "", "");
            }

        }


       
        BindGrid();

    }

    protected void txtKM_Reading_TextChanged(object sender, EventArgs e)
    {




        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {




            if (((Label)gridrow.FindControl("txtLKmRead")).Text != "")
            {

                temp1 = ((Label)gridrow.FindControl("txtLKmRead")).Text;

            }
            /* if (lblError1.Text == "")
             {


                 if (temp != "")
                 {

                     ((Label)gridrow.FindControl("txtLKmRead")).Text = temp;



                 }
             }*/

            temp = "";



            if (((TextBox)gridrow.FindControl("txtKM_Reading")).Text != "")
            {
                temp = ((TextBox)gridrow.FindControl("txtKM_Reading")).Text;


            }
            if (temp != "" && temp1 != "")
            {
                if (temp1 == "NA")
                {
                    temp1 = "0";
                }
                if (Convert.ToDouble(temp) < Convert.ToDouble(temp1))
                {
                    if (lblError1.Text == "")
                    {
                        lblError1.Visible = true;
                        lblError1.Text = "Current km reading cannot be less than last km reading!";
                    }
                }

                else
                {
                    lblError1.Visible = true;
                    lblError1.Text = "";
                }



            }








           



        }
    }

    public void BindGrid()
    {
        dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
        dgHSD_OIL_EXP.DataBind();
        _lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;
    }


    protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //double sum = 0;
        /*DataSet ds1 = new DataSet();
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
        */

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

            datarow_HSDOIL = ((DieselDataSet.HSD_OIL_EXPRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtOilPlace")).Text = datarow_HSDOIL.OilPlace;

            //((DropDownList)e.Item.FindControl("ddlPPName")).SelectedItem.Text = datarow_HSDOIL.PPName;
            //((DropDownList)e.Item.FindControl("ddlBrand")).SelectedItem.Text = datarow_HSDOIL.Brand;
            ((DropDownList)e.Item.FindControl("ddlFuelType")).SelectedItem.Text = datarow_HSDOIL.FuelType;
            ((Label)e.Item.FindControl("txtLKMRead")).Text = datarow_HSDOIL.Last_Km_Read;





            ((TextBox)e.Item.FindControl("txtKM_Reading")).Text = datarow_HSDOIL.KM_Reading;
            ((TextBox)e.Item.FindControl("txtBillno")).Text = datarow_HSDOIL.Billno;
            ((TextBox)e.Item.FindControl("txtBilldt")).Text = datarow_HSDOIL.Billdt;
            ((TextBox)e.Item.FindControl("txtDiesel_Ltr")).Text = datarow_HSDOIL.Diesel_Ltr;
            ((TextBox)e.Item.FindControl("txtDieselRate_Ltr")).Text = datarow_HSDOIL.Diesel_Rate;
            
            /*string diesel_qty = datarow_HSDOIL.Diesel_Ltr;
            if (diesel_qty == "")
            {
                diesel_qty = "0";
            }
            string diesel_rate = datarow_HSDOIL.Diesel_Rate;

            if (diesel_rate == "")
            {
                diesel_rate = "0";
            }

            double totamt = Convert.ToDouble(diesel_qty) * Convert.ToDouble(diesel_rate);*/
              //  ((TextBox)e.Item.FindControl("txtOil_Ltr")).Text = datarow_HSDOIL.Oil_Ltr;
            ((TextBox)e.Item.FindControl("txtAmt")).Text =  datarow_HSDOIL.Amt;

            ((TextBox)e.Item.FindControl("txtExeAmt")).Text = datarow_HSDOIL.Exe_Amt;
            //((DropDownList)e.Item.FindControl("ddlPayment")).SelectedItem.Text = datarow_HSDOIL.Payment;
            ((TextBox)e.Item.FindControl("txtRemarks")).Text = datarow_HSDOIL.Remarks;



            
            //((TextBox)e.Item.FindControl("txtOilRate_Ltr")).Text = datarow_HSDOIL.Oil_Rate;

            ((TextBox)e.Item.FindControl("txtTripsheetNo")).Text = datarow_HSDOIL.TripsheetNo;
            ((Label)e.Item.FindControl("txtVehicleno")).Text = datarow_HSDOIL.VehicleNo;



        }

    }


    protected void TripsheetNo_Change(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";
        string mVehNo = "";
        string mLastKM = "0";

        lblError1.Text = "";
        conn.Open();
        DieselDataSet.HSD_OIL_EXPRow datarow_OilExp;

        double g_totamt = 0;
        double g_totExeAmt = 0;

        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                TextBox mTripsheetNo = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtTripsheetNo");

                Label mVehicleNo = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtVehicleno");
                Label mLastKmRead = (Label)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtLKmRead");


                TextBox mDiesel_Ltr = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtDiesel_Ltr");
                TextBox mDieselRate_Ltr = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtDieselRate_Ltr");
                TextBox mAmt = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtAmt");
                TextBox mExeAmt = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtExeAmt");
              

                string diesel_qty = mDiesel_Ltr.Text;
                if (diesel_qty == "")
                {
                    diesel_qty = "0";
                }
                string diesel_rate = mDieselRate_Ltr.Text;

                if (diesel_rate == "")
                {
                    diesel_rate = "0";
                }

                double totamt = Convert.ToDouble(diesel_qty) * Convert.ToDouble(diesel_rate);
                double totExeAmt = Convert.ToDouble(mExeAmt.Text);
                mAmt.Text = totamt.ToString();


                g_totamt = g_totamt + totamt;
                g_totExeAmt = g_totExeAmt + totExeAmt;

                txtTotalAmt.Text = g_totamt.ToString();
                txtTotalExeAmt.Text = g_totExeAmt.ToString();

                mVehNo = "NA";
                mLastKM = "NA";
                string mCloseDt = "";
                sql = "Select VehicleNo,current_KM_Read,end_dt_tm from WEBX_FLEET_VEHICLE_ISSUE I,webx_vehicle_hdr v where V.vehno=I.VehicleNo and Manual_TripSheetNo='" + mTripsheetNo.Text.ToString() + "'";
                SqlCommand Sqlcmd = new SqlCommand(sql, conn);
                SqlDataReader rdr = Sqlcmd.ExecuteReader();
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        mVehNo = rdr["VehicleNo"].ToString();
                        mLastKM = rdr["current_KM_Read"].ToString();
                        mCloseDt = rdr["end_dt_tm"].ToString();
                    }
                }
                rdr.Dispose();
                rdr.Close();
                if (mVehNo == "NA" && mTripsheetNo.Text != "")
                {
                    lblError1.Visible = true;
                    lblError1.Text = "Invalid tripsheet no. !!!";
                }
                if (mCloseDt != "")
                {
                    lblError1.Visible = true;
                    lblError1.Text = "This tripsheet no. " + mTripsheetNo.Text.ToString() + " is already closed !!!";
                }


                DropDownList ddlFuelType = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlFuelType");
                ddlFuelType.SelectedIndex = 2;
                mVehicleNo.Text = mVehNo.ToString();
                mLastKmRead.Text = mLastKM.ToString();

                _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_OilExp.ItemArray;

            }
        }
        
        conn.Close();

        /*foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            DieselDataSet.HSD_OIL_EXPRow datarow_OilExp;
            datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                DropDownList ddlFuelType = (DropDownList)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("ddlFuelType");
                ddlFuelType.SelectedIndex = 1;
            }
        }*/

    }

    /*protected void Diesel_Oil_Calc(object sender, EventArgs e)
    {
        double mDieselQty, mDieselRate, mOilQty, mOilRate, mAmt, mTotAmt;
        mTotAmt = 0;

        Double tot_diesel = 0;
        DieselDataSet.HSD_OIL_EXPRow datarow_OilExp;
        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {
            datarow_OilExp = _dataSet.HSD_OIL_EXP[gridrow.ItemIndex];
            if (gridrow.ItemIndex != -1)
            {
                TextBox tbDieselQty = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtDiesel_Ltr");
                TextBox tbDieselRate = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtDieselRate_Ltr");
                //TextBox tbOilQty = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtOil_Ltr");
                //TextBox tbOilRate = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtOilRate_Ltr");

                TextBox tbAmt = (TextBox)dgHSD_OIL_EXP.Items[gridrow.ItemIndex].FindControl("txtAmt");

                mDieselQty = Convert.ToDouble(tbDieselQty.Text.ToString());
                mDieselRate = Convert.ToDouble(tbDieselRate.Text.ToString());

                //mOilQty = Convert.ToDouble(tbOilQty.Text.ToString());
                //mOilRate = Convert.ToDouble(tbOilRate.Text.ToString());

                mAmt = (mDieselQty * mDieselRate);//+ (mOilQty * mOilRate);
                mTotAmt = Convert.ToDouble(mTotAmt) + Convert.ToDouble(mAmt);
                tbAmt.Text = mAmt.ToString();

                _dataSet.HSD_OIL_EXP[gridrow.DataSetIndex].ItemArray = datarow_OilExp.ItemArray;

            }
        }

        foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
        {

            string mDiesel = ((TextBox)gridrow.FindControl("txtDiesel_Ltr")).Text;


            if (mDiesel != "")
            {
                tot_diesel = tot_diesel + Convert.ToDouble(mDiesel);


            }
        }




        


    }
    */

    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DieselDataSet)(this.ViewState["Data"]));
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
