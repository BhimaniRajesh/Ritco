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

    protected void Page_Load(object sender, EventArgs e)
    {


        mRepair = Request.QueryString["Repair"];
        if (mRepair == "" || mRepair == null)
        {
            mExpenseType = "Fixed";
        }
        else
        {
            mExpenseType = "Variable";
        }

        
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

        //string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid not in ('02','03','04','05','08','09','10')";
        string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and codeid  not in ('01','02','03','04','05','06','08','09','10','12','13') ";
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


    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    Int16 maxrows = 0;
    //    if (txtRows.Text.ToString().CompareTo("") != 0)
    //    {
    //        try
    //        {
    //            maxrows = Convert.ToInt16(txtRows.Text);
    //        }
    //        catch (Exception ex)
    //        {
    //            txtRows.Text = "";
    //            txtRows.Focus();
    //        }
    //    }

    //    for (int i = 0; i < maxrows; i++)
    //    {
    //        dt.Rows.Add();
    //    }

    //    grvcontrols.DataSource = dt;
    //    grvcontrols.DataBind();
    //}


    //protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        ((TextBox)e.Row.FindControl("txtAccCode")).Attributes.Add("onblur", "AccBlur('" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "')");
    //        ((Button)e.Row.FindControl("btnAccCode")).Attributes.Add("onclick", "popuplist('AccCode','" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "','none')");
    //        //((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot('" + ((TextBox)e.Row.FindControl("txtAmt")).ClientID.ToString() + "','" + ((TextBox)e.Row.FindControl("txtTotAmt")).ClientID.ToString() + "')");
    //        ((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot()");
    //    }
    //}
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

        //Response.Write("submitted....");
        //Response.End();

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
       
        string VENDORCODE = cboVendor.SelectedValue.ToString(), VENDORNAME = "";
        if (VENDORCODE != "")
        {
            VENDORNAME = fn.GetVendor(VENDORCODE);
            string[] venname;
            venname = VENDORNAME.Split(':');
            VENDORNAME = venname[1];
        }

        //string BILLDT = txtBillDt.Text;
        //string VENDORBILLDT = txtBillEntryDate.Text;

        string BILLDT = txtBillEntryDate.Text;
        string VENDORBILLDT = txtBillDt.Text;

        string VENDORBILLNO = txtBillNumber.Text;
        double PCAMT = Convert.ToDouble(txtBillAmt.Text);
        double ADVAMT = 0, OTHAMT = 0;
        double SVCTAX = Convert.ToDouble(txtServiceTax.Text);
        string DUEDT = txtDueDate.Text;
        string ENTRYBY = Session["empcd"].ToString();
        string REMARK = txtRemarks.Text;
        string PAYDT =  txtBillEntryDate.Text;
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
        string Narration = "When Expence Entry Done ,Bill is generated : " + BILLNO;
        string opertitle = "Expence Bill Entry ";
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

            string sqlInsert = "INSERT INTO WEBX_VENDORBILL_HDR (BILLNO, BILLSF, BRCD, BILLDT, VENDORCODE, VENDORNAME, VENDORBILLDT,VENDORBILLNO, PCAMT, ADVAMT, OTHAMT, SVCTAX, DUEDT,ENTRYBY, ENTRYDT, REMARK, PAYDT, VOUCHERNO, OTHERDED, TDSRATE, TDS,SVCTAXDED, OTHERCHRG, NETAMT,tdsfor,cessamt,tdsgrpcode,tdsgrpdesc,betype,acccode,accdesc,REFNO,tdsacccode,tdsaccdesc,servicetaxrate,othertaxrate,othertax,DEDUCTION_CHRG,discount,PENDAMT,Hedu_cess,hdu_cessrate) VALUES('" + BILLNO + "','.','" + Session["brcd"].ToString() + "','" + BILLDT + "','" + VENDORCODE + "','" + VENDORNAME + "','" + VENDORBILLDT + "','" + VENDORBILLNO + "'," + PCAMT + "," + ADVAMT + "," + OTHAMT + "," + SVCTAX + ",'" + DUEDT + "','" + ENTRYBY + "',getdate(),'" + REMARK.Replace("'", "''") + "'," + PAYDT + "," + voucherNo + "," + OTHERDED + "," + TDSRATE + "," + TDS + "," + SVCTAXDED + "," + OTHERCHRG + "," + NETAMT + ",'" + tdsfor + "'," + cessamt + ",'" + tdsgrpcode + "','" + tdsgrpdesc + "','" + betype + "','" + expenseacccode + "','" + expenseaccdesc + "','" + REFNO + "','" + tdsacccode + "','" + tdsaccdesc + "'," + servicetaxrate + "," + othertax + "," + ACTothertax + "," + DEDUCTION_CHRG + "," + discount + "," + NETAMT + ",'" + txtHEduCess.Text + "','1')";
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


            string mStat = Request.QueryString["Stat"];
            string mCrewSal = Request.QueryString["CrewSal"];
            string mVehTrack = Request.QueryString["VehTrack"];
            string mFinExp = Request.QueryString["FinExp"];
            string mRepair = Request.QueryString["Repair"];

           

            UserControls_ExpenseVoucherFV ExpVoucher = (UserControls_ExpenseVoucherFV)UCMyExpenseVoucher1;
            DataGrid dgExpense1 = (DataGrid)ExpVoucher.FindControl("dgExpense1");
            DataGrid dgExpense2 = (DataGrid)ExpVoucher.FindControl("dgExpense2");
            DataGrid dgExpense3 = (DataGrid)ExpVoucher.FindControl("dgExpense3");
            DataGrid dgExpense4 = (DataGrid)ExpVoucher.FindControl("dgExpense4");
            DataGrid dgExpense = (DataGrid)ExpVoucher.FindControl("dgExpense");

            TextBox txtTotalExeAmt = (TextBox)ExpVoucher.FindControl("txtTotalExeAmt");

            string mDocuementNo = BILLNO;
            for (int i = 1; i < 5; i++)
            {
                DataGrid tgrdcntrl = (DataGrid)ExpVoucher.FindControl("dgExpense" + i.ToString());
                MyGridInsert(tgrdcntrl, mDocuementNo, con, trn, i, mStat, mCrewSal, mVehTrack, mFinExp, mRepair);
            }

            DataGrid Vtgrdcntrl = (DataGrid)ExpVoucher.FindControl("dgExpense");
            if (mRepair != "")
            {
                MyGridInsert(Vtgrdcntrl, mDocuementNo, con, trn, 5, mStat, mCrewSal, mVehTrack, mFinExp, mRepair);
            }


            

            




            trn.Commit();
            //trn.Rollback();
            con.Close();


            string final = "?BillNo=" + BILLNO;
            final += "&voucherNo=" + voucherNo;
            //Response.Write("submitted....");
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


    public void MyGridInsert(DataGrid mDataGrid, string mDocuementNo, SqlConnection conn, SqlTransaction trans, int k, string mStat, string mCrewSal, string mVehTrack, string mFinExp, string mRepair)
    {
        //double mTotExeAmt = 0;
        foreach (DataGridItem gridrow in mDataGrid.Items)
        {
            if ((mStat != "" && k == 1) || (mCrewSal != "" && k == 2) || (mVehTrack != "" && k == 3) || (mFinExp != "" && k == 4) || (mRepair != "" && k == 5))
            {
                string ExpenseId = ((DropDownList)gridrow.FindControl("ddlNature")).Text;
                string Amt = ((TextBox)gridrow.FindControl("txtAmt")).Text;
                string ExeAmt = ((TextBox)gridrow.FindControl("txtExeAmt")).Text;
                string BillNo = ((TextBox)gridrow.FindControl("txtBillNo")).Text;
                string Remarks = ((TextBox)gridrow.FindControl("txtRemarks")).Text;
                string VehNo = ((TextBox)gridrow.FindControl("txtVehNo")).Text;

                double mAmt = 0, mExeAmt = 0;
                if (Amt != "")
                {
                    mAmt = Convert.ToDouble(Amt);
                }
                else
                {
                    mAmt = 0;
                }
                if (ExeAmt != "")
                {
                    mExeAmt = Convert.ToDouble(ExeAmt);
                }
                else
                {
                    mExeAmt = 0;
                }
                //mTotExeAmt = mTotExeAmt + Convert.ToDouble(mExeAmt);

                if (ExpenseId != "")
                {
                    SqlCommand cmd1 = new SqlCommand("usp_VoucherExpDet_InsertUpdate", conn, trans);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add("@VoucherNo", SqlDbType.VarChar).Value = mDocuementNo;
                    cmd1.Parameters.Add("@ExpenseId", SqlDbType.VarChar).Value = ExpenseId;
                    cmd1.Parameters.Add("@Amt", SqlDbType.Float).Value = mAmt;
                    cmd1.Parameters.Add("@ExeAmt", SqlDbType.Float).Value = mExeAmt;
                    cmd1.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = BillNo;
                    cmd1.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = Remarks;
                    cmd1.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehNo;
                    cmd1.ExecuteNonQuery();
                    cmd1.Dispose();


                    string BILLNO = "";
                    double debitamt = 0;
                    string narration = "";

                    BILLNO = mDocuementNo;
                    debitamt = Convert.ToDouble(ExeAmt.ToString());

                        if (debitamt > 0)
                        {
                            string DOCKNO = "";
                            string AccCode = ExpenseId;
                            string AccDesc = "";
                            string AccHeadCode = "";
                            string AccHead = "";
                            double PCAMT1 = 0;
                            double OTHAMT1 = 0;
                            double SVCTAX1 = 0;
                            double CESS1 = 0;
                            double ADVPAID1 = 0;
                            double OTHDED1 = 0;
                            double SVCTAXDED1 = 0;
                            double netpay1 = 0;
                            double tdsded1 = 0;
                            string DOCNO = "";

                            string sql_Detail = "INSERT INTO WEBX_VENDORBILL_DET (BILLNO, BILLSF, DOCNO, DOCSF, PCAMT, OTHAMT, SVCTAX, CESS, ADVPAID,OTHDED, SVCTAXDED, voucherNo, paydt,netpay,tdsded,groupcode,groupdesc,acccode,accdesc,narration,debit)VALUES('" + BILLNO + "','.','" + DOCNO + "','.'," + PCAMT1 + "," + OTHAMT1 + "," + SVCTAX1 + "," + CESS1 + "," + ADVPAID1 + "," + OTHDED1 + "," + SVCTAXDED1 + ",null,null," + netpay1 + "," + tdsded1 + ",'" + AccHeadCode + "','" + AccHead + "','" + AccCode + "','" + AccDesc + "','" + narration + "'," + debitamt + ")";
                            SqlCommand sqlcmd_InsertDetail = new SqlCommand(sql_Detail, conn, trans);
                            sqlcmd_InsertDetail.ExecuteNonQuery();

                        }




                }
            }
        }




    }



    protected void cboVendorType_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
        string sql = "select top 1 '' as c1,'-Select-' as c2 from webx_vendor_hdr WITH(NOLOCK) Union select distinct m.vendorcode as c1 ,m.vendorname +':'+ m.vendorcode  as c2 from webx_vendor_hdr m  WITH(NOLOCK) ,webx_vendor_det d  WITH(NOLOCK)  where m.vendorcode=d.vendorcode and vendor_type=" + strvendor + "";
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
}
