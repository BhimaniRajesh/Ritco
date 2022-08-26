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
public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_Jobsheet_JobOrder : System.Web.UI.Page
{

    public static string transtype1, Chqno11, chqdt11, CHQAMT1;
    string doc, vendor, from, to;
    string strDateRange;
    public string Panno1, accountcode, SqlDisplay = "", s2 = "";
    public string VendorBill, VehicleNo, DocumentNo;
    public string[] accountcode1;
    public static string strsession1, strsession2, Financial_Year = "";
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    public static string fromdt, todt, Todt, Fromdt, voucherNo;
    DateTime Fromdate, Todate;
    int i;
    MyFunctions fn = new MyFunctions();
    public static int intCurrentPageNo, intTotalRecords = 0;
    static int intPageSize = 10;
    public string vendorCode = "", VendorName = "", effected_acccode = "";
    public double debit, credit;
    public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
    public string[] VehicleArray, DocumentArray, VendorBillArray;

    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;


    protected void Page_Load(object sender, EventArgs e)
    {
        strsession1 = SessionUtilities.CurrentBranchCode.ToString();
        strsession2 = SessionUtilities.CurrentEmployeeID.ToString();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        if (!IsPostBack)
        {

            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();

            txtBillEntryDate.Attributes.Add("OnBlur", "javascript:GetSTAXDetails(" + txtBillEntryDate.ClientID.ToString() + ");");


            strsession2 = Session["brcd"].ToString();
            fromdt = Request.QueryString["dtFrom"];
            // fromdt = f.ToString("dd/MM/yyyy");
            fromdt = fn.Mydate(fromdt);
            //t = Convert.ToDateTime(Request.QueryString["dtTo"]);
            todt = Request.QueryString["dtTo"];
            Todt = Request.QueryString["dtTo"];
            Fromdt = Request.QueryString["dtFrom"];
            todt = fn.Mydate(todt);
            vendorCode = Request.QueryString["vendor"];


            //lblAgentBillDate.Text = fromdt + " - " + todt;
            DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
            VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);

            if (DocumentNo == "")
            {
                vendorCode = Convert.ToString(Request.QueryString["vendor"]);
            }
            else
            {
                string sql1 = "usp_JobOrderListForBillGen";
                SqlCommand cmd = new SqlCommand(sql1, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@JobOrderNo", SqlDbType.VarChar).Value = DocumentNo;
                cmd.Parameters.Add("@JobOrderFromDt", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@JobOrderToDt", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@JobOrderVendor", SqlDbType.VarChar).Value = "";
                SqlDataReader dr1 = cmd.ExecuteReader();
                if (dr1.HasRows)
                {
                    while (dr1.Read())
                    {
                        vendorCode = Convert.ToString(dr1["VENDOR_CODE"]);
                    }
                }
                dr1.Close();
            }


            //lblVendor.Text = fn.GetVendor(vendorCode);
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            txtBillEntryDate.Text = strrightnow;
            txtBillDt.Text = strrightnow;
            popVendor();
            DisplayJobOrderlist();
        }

        //btnSubmit.Attributes.Add("onclick", "javascript:return CheckData()");
    }

    private void DisplayJobOrderlist()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid , (select SERVTAXNO from webx_vendor_hdr where vendorcode=h.vendorcode) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=h.vendorcode) as PAN_NO,Convert(varchar,vendorBILLDT,103) as VendorBill_DT1, * from WEBX_VendorBill_hdr h where ( Bill_cancel='N' or Bill_cancel is null) and isnull(pendamt,0)>0 and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)";
        SqlDisplay = "usp_JobOrderListForBillGen";
        SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@JobOrderNo", SqlDbType.VarChar).Value = DocumentNo;
        cmd.Parameters.Add("@JobOrderFromDt", SqlDbType.VarChar).Value = fromdt;
        cmd.Parameters.Add("@JobOrderToDt", SqlDbType.VarChar).Value = todt;
        cmd.Parameters.Add("@JobOrderVendor", SqlDbType.VarChar).Value = vendorCode;

        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        sqlDA.Fill(ds);
        gvJobOrderDetail.DataSource = ds;
        gvJobOrderDetail.DataBind();

    }

    protected void gvJobOrderDetail_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //int no = e.Row.RowIndex + 2;
            //if (no < 10)
            //{
            //    //Label l1 = (Label)e.Row.FindControl("netamt");
            //    a = "'ctl00_MyCPH1_gvJobOrderDetail_ctl0" + Convert.ToString(no) + "_TOT_ACT_PART_COST'";
            //}
            //else
            //{
            //    //Label l1 = (Label)e.Row.FindControl("netamt");
            //    a = "'ctl00_MyCPH1_gvJobOrderDetail_ctl" + Convert.ToString(no) + "_TOT_ACT_PART_COST'";
            //}

            //((CheckBox)(e.Row.FindControl("chkJobOrder"))).Attributes.Add("onclick", "return calculation(" + a + ")");

            ((CheckBox)(e.Row.FindControl("chkJobOrder"))).Attributes.Add("onclick", "return calculation()");

        }
    }

    private void popVendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select codeid as Type_Code,codedesc as Type_name from webx_master_general where codetype='VENDTY' and CodeId='14' ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataReader dr;
        dr = sqlcmd.ExecuteReader();
        cboVendorType.Items.Clear();
        while (dr.Read())
        {
            cboVendorType.Items.Add(new ListItem(dr["Type_name"].ToString(), dr["Type_Code"].ToString()));
        }
        dr.Close();
        cboVendorType.CssClass = "blackfnt";

        VendorList();

    }

    public void Show_Pbov_list(object sender, EventArgs e)
    {

        //Show_Pbov_list_Display();

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";



        //Response.Write("submitted....");
        //Response.End();
        if (lblError1.Text == "")
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();



            string sql = "sp_get_next_be_code", BILLNO = "", Branch = SessionUtilities.CurrentBranchCode.ToString();
            SqlCommand sqlcmd1 = new SqlCommand(sql, con);
            sqlcmd1.CommandType = CommandType.StoredProcedure;
            sqlcmd1.Parameters.Add("@loccode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString();
            SqlDataReader r1 = sqlcmd1.ExecuteReader();
            if (r1.Read())
            {
                BILLNO = r1["NewCode"].ToString();
            }
            r1.Close();

            string Vbrcd = SessionUtilities.CurrentBranchCode.ToString();
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


            UserControls_ServiceTDSVAT ServiceTDSVAT = (UserControls_ServiceTDSVAT)UCMyServiceTDSVAT1;
            TextBox txtServiceTax = (TextBox)ServiceTDSVAT.FindControl("txtServiceTax");
            TextBox txtTDSRate = (TextBox)ServiceTDSVAT.FindControl("txtTDSRate");
            TextBox txtTDSAmt = (TextBox)ServiceTDSVAT.FindControl("txtTDSAmt");

            DropDownList Tdssection = (DropDownList)ServiceTDSVAT.FindControl("Tdssection");

            TextBox txtEduCess = (TextBox)ServiceTDSVAT.FindControl("txtEduCess");
            TextBox txtHEduCess = (TextBox)ServiceTDSVAT.FindControl("txtHEduCess");



            Label LblSTaxRate = (Label)ServiceTDSVAT.FindControl("LblSTaxRate");
            Label LblEduCess = (Label)ServiceTDSVAT.FindControl("LblEduCess");
            Label LblHEduCess = (Label)ServiceTDSVAT.FindControl("LblHEduCess");


            TextBox txtVATAmt = (TextBox)ServiceTDSVAT.FindControl("txtVATAmt");
            TextBox txtVATRate = (TextBox)ServiceTDSVAT.FindControl("txtVATRate");

            TextBox txtSBCess = (TextBox)ServiceTDSVAT.FindControl("txtSBCess");// Added By Anupam
            Label LblSBCess = (Label)ServiceTDSVAT.FindControl("LblSBCess");// Added By Anupam

            TextBox txtKKCess = (TextBox)ServiceTDSVAT.FindControl("txtKKCess");// Added By Anupam 
            Label LblKKCess = (Label)ServiceTDSVAT.FindControl("LblKKCess");// Added By Anupam

            TextBox txtNetPayableAmt = (TextBox)ServiceTDSVAT.FindControl("txtNetPayableAmt");

            double SVCTAX = Convert.ToDouble(txtServiceTax.Text);
            string DUEDT = txtDueDate.Text;
            string ENTRYBY = SessionUtilities.CurrentEmployeeID.ToString();
            string REMARK = txtRemarks.Text;
            string PAYDT = txtBillEntryDate.Text;
            double OTHERDED = 0;
            double TDSRATE = Convert.ToDouble(txtTDSRate.Text);
            double TDS = Convert.ToDouble(txtTDSAmt.Text);
            double SVCTAXDED = 0;
            double OTHERCHRG = 0;

            double VATAmt = Convert.ToDouble(txtVATAmt.Text);
            double VATRate = Convert.ToDouble(txtVATRate.Text);

            string tdsacccode = Tdssection.SelectedValue.ToString();
            string tdsaccdesc = Tdssection.SelectedItem.ToString();
            string tdsfor = "0";//cboCorporate.SelectedValue.ToString();
            string cessamt = txtEduCess.Text;
            double HEduCess = Convert.ToDouble(txtHEduCess.Text);

            double EduCess_Rate = Convert.ToDouble(LblEduCess.Text);
            double HEduCess_Rate = Convert.ToDouble(LblHEduCess.Text);




            //string Hcessamt = txtHEduCess.Text;
            string tdsgrpcode = Tdssection.SelectedValue.ToString();
            string tdsgrpdesc = Tdssection.SelectedItem.ToString();
            string mExpenseType = "Job";
            string betype = mExpenseType + " Expense";
            string REFNO = txtRefNo.Text;
            double servicetaxrate = Convert.ToDouble(LblSTaxRate.Text);// 12;// Convert.ToDouble(txtServiceTax_rate.Text);
            double othertax = EduCess_Rate;// 2;// Convert.ToDouble(txtEduCessRate.Text);
            double ACTothertax = 0;// Convert.ToDouble(txtEduCess.Text);
            double DEDUCTION_CHRG = 0;// Convert.ToDouble(txtOtherDedudction.Text);
            double discount = 0;// Convert.ToDouble(txtDiscRecvd.Text);
            double NETAMT = Convert.ToDouble(txtNetPayableAmt.Text);

            double SBCess = Convert.ToDouble(txtSBCess.Text);// Added By Anupam
            double SBCess_Rate = Convert.ToDouble(LblSBCess.Text);// Added By Anupam

            double KKCess = Convert.ToDouble(txtKKCess.Text);// Added By Anupam
            double KKCess_Rate = Convert.ToDouble(LblKKCess.Text);// Added By Anupam

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

                string sqlInsert = "INSERT INTO WEBX_VENDORBILL_HDR (BILLNO, BILLSF, BRCD, BILLDT, VENDORCODE, VENDORNAME, VENDORBILLDT,VENDORBILLNO, "
                    + " PCAMT, ADVAMT, OTHAMT, SVCTAX, DUEDT,ENTRYBY, ENTRYDT, REMARK, PAYDT, VOUCHERNO, OTHERDED, TDSRATE, TDS,SVCTAXDED, OTHERCHRG, "
                    + " NETAMT,tdsfor,cessamt,tdsgrpcode,tdsgrpdesc,betype,acccode,accdesc,REFNO,tdsacccode,tdsaccdesc,servicetaxrate,othertaxrate, "
                    + " othertax,DEDUCTION_CHRG,discount,PENDAMT,Hedu_cess,hdu_cessrate,VATRate,VATAmt,COMPANY_CODE,SBCAMT,SBCRATE,KKCAMT,KKCRATE) VALUES "
                    + " ('" + BILLNO + "','.','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + BILLDT + "','" + VENDORCODE + "','" + VENDORNAME + "','" + VENDORBILLDT + "','" + VENDORBILLNO + "',"
                    + " " + PCAMT + "," + ADVAMT + "," + OTHAMT + "," + SVCTAX + ",'" + DUEDT + "','" + ENTRYBY + "',getdate(),'" + REMARK + "'," + PAYDT + "," + voucherNo + "," + OTHERDED + "," + TDSRATE + "," + TDS + "," + SVCTAXDED + "," + OTHERCHRG + ", "
                    + " " + NETAMT + ",'" + tdsfor + "'," + cessamt + ",'" + tdsgrpcode + "','" + tdsgrpdesc + "','" + betype + "','" + expenseacccode + "','" + expenseaccdesc + "','" + REFNO + "','" + tdsacccode + "','" + tdsaccdesc + "'," + servicetaxrate + ","
                    + " " + othertax + "," + ACTothertax + "," + DEDUCTION_CHRG + "," + discount + "," + PCAMT + "," + HEduCess + ",'" + HEduCess_Rate + "'," + VATRate + "," + VATAmt + ",'" + SessionUtilities.DefaultCompanyCode.Trim().ToUpper() + "','" + SBCess + "','" + SBCess_Rate + "','" + KKCess + "','" + KKCess_Rate + "')";//EduCess_Rate,HEduCess_Rate //Changed by Anupam

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
                string v_approve_reject_branch = SessionUtilities.CurrentBranchCode.ToString(), panno = "", servicetaxNo = "";
                string entryfor = SessionUtilities.CurrentEmployeeID.ToString(), Entryby = SessionUtilities.CurrentEmployeeID.ToString();
                string PBOV_code = VENDORCODE, PBOV_Name = VENDORNAME;
                string Deptcode = "";
                Branch = SessionUtilities.CurrentBranchCode.ToString();


                //-------------------------JOB EXPENSE DETAILS---------------------------------------------------------

                foreach (GridViewRow gridrow2 in gvJobOrderDetail.Rows)
                {
                    string JOB_ORDER_NO = ((Label)gridrow2.FindControl("JOB_ORDER_NO")).Text.Trim();
                    bool Chk_Sel = ((CheckBox)gridrow2.FindControl("chkJobOrder")).Checked;

                    if (Chk_Sel == true)
                    {
                        string mmstr = "update WEBX_FLEET_PM_JOBORDER_HDR  set Billed_Yn='Y',billno='" + BILLNO + "' where  JOB_ORDER_NO='" + JOB_ORDER_NO.Trim() + "'   ";
                        SqlCommand mcmd = new SqlCommand(mmstr, con, trn);
                        mcmd.ExecuteNonQuery();

                    }
                }

                //------------------------------------------------------------------------------------

                string mFinYear = "";
                mFinYear = Session["FinYear"].ToString().Trim();

                //string sqlFinYear = "Select left(YearVal,2) as YearVal From vw_Get_Finacial_Years Where CurrentFinYear='T'";
                //SqlCommand sqlcmdFinYear = new SqlCommand(sqlFinYear, con, trn);
                //sqlcmdFinYear.CommandType = CommandType.Text;
                //SqlDataReader drFinYear = sqlcmdFinYear.ExecuteReader();
                //if (drFinYear.Read())
                //{
                //    mFinYear = drFinYear["YearVal"].ToString().Trim();
                //}
                //drFinYear.Close();

                string mYearVal = "";
                if (Session["FinYear_Change"] != null)
                {
                    mYearVal = Session["FinYear_Change"].ToString().Trim();
                }

                string sqlAcc1 = "usp_Vendor_Job_Billentry_transaction";
                SqlCommand sqlcmdAcc1 = new SqlCommand(sqlAcc1, con, trn);
                sqlcmdAcc1.CommandType = CommandType.StoredProcedure;
                sqlcmdAcc1.Parameters.Add("@currbrcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString();
                sqlcmdAcc1.Parameters.Add("@transNo", SqlDbType.VarChar).Value = "1";
                sqlcmdAcc1.Parameters.Add("@docNo", SqlDbType.VarChar).Value = BILLNO;
                sqlcmdAcc1.Parameters.Add("@finYear", SqlDbType.VarChar).Value = mFinYear;
                sqlcmdAcc1.Parameters.Add("@yearSuffix", SqlDbType.VarChar).Value = mYearVal;
                sqlcmdAcc1.Parameters.Add("@COMPANY_CODE_37", SqlDbType.VarChar, 50).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim(); // 09_10
                sqlcmdAcc1.ExecuteNonQuery();

                trn.Commit();
                //trn.Rollback();
                con.Close();


                string final = "?BillNo=" + BILLNO;
                final += "&voucherNo=" + voucherNo;
                Response.Redirect("JobEntryDone.aspx" + final);

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


        VendorList();

    }

    public void VendorList()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        int strvendor = Convert.ToInt16(cboVendorType.SelectedValue);
        //string sql = "select top 1 '' as c1,'-Select-' as c2 from webx_vendor_hdr WITH(NOLOCK) Union select distinct m.vendorcode as c1 ,m.vendorname +':'+ m.vendorcode  as c2 from webx_vendor_hdr m  WITH(NOLOCK) ,webx_vendor_det d  WITH(NOLOCK)  where m.vendorcode=d.vendorcode and vendor_type=" + strvendor + " and vendorbrcd like '%" + Session["brcd"].ToString() + "%'";
        string sql = "select distinct m.vendorcode as c1 ,m.vendorname +':'+ m.vendorcode  as c2 from webx_vendor_hdr m  WITH(NOLOCK) ,webx_vendor_det d  WITH(NOLOCK)  where m.vendorcode=d.vendorcode and vendor_type=" + strvendor + " and vendorbrcd like '%" + Session["brcd"].ToString() + "%' and m.vendorCode='" + vendorCode + "'";
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
            }
        }
        crediit_account.Text = acccode + ":" + accdesc;
        crediit_account.CssClass = "blackfnt";
        dr.Close();

        conn.Close();
    }


    //protected void gvJobOrderDetail_RowCreated(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        int no = e.Row.RowIndex + 2;
    //        String a, b, c, d, m;
    //        if (no < 10)
    //        {
    //            Label l1 = (Label)e.Row.FindControl("netamt");
    //            a = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_netamt'";

    //            Label l2 = (Label)e.Row.FindControl("pendamt");
    //            b = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_pendamt'";

    //            TextBox txtCurrPayment1 = (TextBox)e.Row.FindControl("txtCurrPayment");
    //            c = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_txtCurrPayment'";

    //            CheckBox chkBill1 = (CheckBox)e.Row.FindControl("chkBill");
    //            d = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_chkBill'";

    //            //TextBox txttotal1 = (TextBox)e.Row.FindControl("txtTotal");
    //            //m = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_txtTotal'";

    //        }
    //        else
    //        {
    //            a = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_netamt'";
    //            b = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_pendamt'";
    //            c = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_txtCurrPayment'";
    //            d = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_chkBill'";
    //            //m = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_txtTotal'";

    //        }

    //        ((TextBox)(e.Row.FindControl("txtCurrPayment"))).Attributes.Add("onblur", "fvalidatePayAmt(" + a + "," + b + "," + c + "," + d + ")");
    //        ((CheckBox)(e.Row.FindControl("chkBill"))).Attributes.Add("onclick", "return calculation(" + a + "," + b + "," + c + "," + d + ")");
    //    }
    //}


    //protected void add_row(object sender, EventArgs e)
    //{

    //    string rowno;
    //    int mroww = 0;
    //    int miroww = 0;
    //    rowno = txtAddRow.Text;
    //    mroww = Convert.ToInt16(rowno);
    //    int i;


    //    int iroww = 0;
    //    //foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
    //    //{
    //    //    iroww = iroww + 1;
    //    //}
    //    miroww = iroww;

    //    if (mroww < miroww)
    //    {
    //        miroww = mroww;
    //    }


    //    if (iroww >= 0)
    //    {
    //        for (i = iroww - 1; i > -1 + miroww; i--)
    //        {
    //            //_dataSet.HSD_OIL_EXP.RemoveHSD_OIL_EXPRow(_dataSet.HSD_OIL_EXP[i]);
    //        }
    //    }


    //    for (i = 0 + miroww; i < Int16.Parse(txtAddRow.Text); i++)
    //    {


    //        if (i == 0)
    //        {

    //            //_dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", LastKm2, "", "", "", "0", "0", "", "0", "", "", "0", "0", "", "");
    //        }
    //        else
    //        {

    //           // _dataSet.HSD_OIL_EXP.AddHSD_OIL_EXPRow("", "", "", "", "", "", "", "", "0", "0", "", "0", "", "", "0", "0", "", "");
    //        }

    //    }



    //    BindGrid();

    //}


    //public void BindGrid()
    //{
    //    //dgHSD_OIL_EXP.DataSource = _dataSet.HSD_OIL_EXP;
    //    //dgHSD_OIL_EXP.DataBind();
    //    //_lastEditedPage = dgHSD_OIL_EXP.CurrentPageIndex;
    //}


    //protected void dgHSD_OIL_EXP_ItemDataBound(object sender, DataGridItemEventArgs e)
    //{

    //}


    protected void JobsheetNo_Change(object sender, EventArgs e)
    {

    }


    //private void ReverseBind()
    //{
    //    //foreach (DataGridItem gridrow in dgHSD_OIL_EXP.Items)
    //    //{
    //    //}

    //}


    //protected override void LoadViewState(object savedState)
    //{
    //    base.LoadViewState(savedState);
    //    if ((!(this.ViewState["Data"] == null)))
    //    {
    //        _dataSet = ((DieselDataSet)(this.ViewState["Data"]));
    //    }
    //    if ((!(this.ViewState["LastEditedPage"] == null)))
    //    {
    //        _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
    //    }
    //}

    //protected override object SaveViewState()
    //{
    //    this.ViewState["Data"] = _dataSet;
    //    this.ViewState["LastEditedPage"] = _lastEditedPage;
    //    return (base.SaveViewState());
    //}
}
