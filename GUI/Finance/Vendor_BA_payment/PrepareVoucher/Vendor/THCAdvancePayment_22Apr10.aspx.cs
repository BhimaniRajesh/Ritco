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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment : System.Web.UI.Page
{
    private string billno_nos, Branch, documentprint, voucherNo;
    public static string checkeddockno, fromdt, Todt, Financial_Year="";
    //private string Vno;
    public int totdkt, srno;
    private int ContractAmt = 0;
    private double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, H_CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    MyFunctions fn = new MyFunctions();
    DateTime Fromdate, Todate;
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        Branch = Session["BRCD"].ToString();
        if (!IsPostBack)
        {
            billno_nos = Request.QueryString.Get("billno_nos");
            checkeddockno = Request.QueryString.Get("checkeddockno").ToString();
            fromdt = Request.QueryString.Get("fromdt");
            Todt = Request.QueryString.Get("Todt");
            if (fromdt != "")
            {
                Fromdate = Convert.ToDateTime(fromdt);
                fromdt = Fromdate.ToString("dd/MM/yyyy");//Convert.ToString().ToString("dd/MM/yyyy");
            }

            if (Todt != "")
            {
                Todate = Convert.ToDateTime(Todt);
                Todt = Todate.ToString("dd/MM/yyyy");
            }
            txtVoucherDate.Text =System.DateTime.Today.ToString("dd/MM/yyyy");
            lblStandardAmt.Text = "0";
            PopPaymentAcc();
            PopTDSType();
            BindGrid();
            double TotalNet_Advamt = 0;
            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                TextBox indpcamt = (TextBox)gridrow.FindControl("indpcamt");
                TextBox indothamt = (TextBox)gridrow.FindControl("indothamt");
                TextBox inddiscount = (TextBox)gridrow.FindControl("inddiscount");
                TextBox cboindsvctaxrate = (TextBox)gridrow.FindControl("cboindsvctaxrate");
                TextBox indsvctax = (TextBox)gridrow.FindControl("indsvctax");
                TextBox indcess = (TextBox)gridrow.FindControl("indcess");
                TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                //TextBox indothded = (TextBox)gridrow.FindControl("indothded");
                TextBox ind_H_cess = (TextBox)gridrow.FindControl("ind_H_cess");
                
                TextBox indsvctaxded = (TextBox)gridrow.FindControl("indsvctaxded");
                TextBox indtds_rate = (TextBox)gridrow.FindControl("indtds_rate");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                TextBox TotalNetamt = (TextBox)gridrow.FindControl("TotalNetamt");
                HiddenField txtpendamt = (HiddenField)gridrow.FindControl("txtpendamt");
                
                ContractAmt = ContractAmt + Convert.ToInt32(indpcamt.Text);
                txtContractAmt.Text = ContractAmt.ToString();
               // TotalNet_Advamt = TotalNet_Advamt;
                NetAmount1 = Convert.ToDouble(indpcamt.Text) + Convert.ToDouble(indothamt.Text) - Convert.ToDouble(indtdsded.Text) + Convert.ToDouble(indsvctax.Text) + Convert.ToDouble(indcess.Text) + Convert.ToDouble(ind_H_cess.Text) - Convert.ToDouble(indadvamt.Text);
                indnetpay.Text = NetAmount1.ToString();
                PaymentAmt = PaymentAmt + Convert.ToDouble(indadvamt.Text);
                if (indothamt.Text != "")
                {
                    OtherAmt = OtherAmt + Convert.ToDouble(indothamt.Text);
                    txtOtherAmt.Text = OtherAmt.ToString();
                }
                else
                {
                    txtOtherAmt.Text = "0.00";
                    indothamt.Text = "0.00";
                }
                if (indtdsded.Text != "")
                {
                    TDSDeduction = TDSDeduction + Convert.ToDouble(indtdsded.Text);
                    txtTDSAmt.Text = TDSDeduction.ToString();
                }
                else
                {
                    txtTDSAmt.Text = "0.00";
                    indtdsded.Text = "0.00";
                }
                if (indsvctax.Text != "")
                {
                    ServiceTax = ServiceTax + Convert.ToDouble(indsvctax.Text);
                    txtServiceTax.Text = ServiceTax.ToString();
                }
                else
                {
                    txtServiceTax.Text = "0.00";
                    indsvctax.Text = "0.00";
                }
                if (indcess.Text != "")
                {
                    CessAmount = CessAmount + Convert.ToDouble(indcess.Text);
                    cessamt.Text = CessAmount.ToString();
                }
                else
                {
                    cessamt.Text = "0.00";
                    indcess.Text = "0.00";
                }
                if (ind_H_cess.Text != "")
                {
                    H_CessAmount = H_CessAmount + Convert.ToDouble(ind_H_cess.Text);
                    H_cessamt.Text = H_CessAmount.ToString();
                }
                else
                {
                    H_cessamt.Text = "0.00";
                    ind_H_cess.Text = "0.00";
                }
                
                if (indadvamt.Text != "")
                {
                    AdvancePaid = AdvancePaid + Convert.ToDouble(indadvamt.Text);
                    txtAdvanceAmtPaid.Text = AdvancePaid.ToString();
                }
                else
                {
                    txtAdvanceAmtPaid.Text = "0.00";
                    indadvamt.Text = "0.00";
                }
                if (indnetpay.Text != "")
                {
                    NetAmount = NetAmount + Convert.ToDouble(indnetpay.Text);
                    txtBalanceAmt.Text = NetAmount.ToString();
                    txtPaymentAmt.Text = NetAmount.ToString();
                }
                else
                {
                    txtBalanceAmt.Text = "0.00";
                    indnetpay.Text = "0.00";
                    txtPaymentAmt.Text = "0.00";
                }
               
                //txtPaymentAmt.Text = PaymentAmt.ToString();
                txtPaymentAmt.Text = "0.00";
                txtCashAmount.Text = PaymentAmt.ToString();
                //TotalNetamt.Text = PaymentAmt.ToString();
                //TotalNetamt.Enabled = true;
                //TotalNetamt.Text = PaymentAmt.ToString();
            }
            
            btnSubmit.Attributes.Add("onclick", "javascript:return check(" + txtAdvanceAmtPaid.ClientID + "," + txtBalanceAmt.ClientID + "," + cboModeOfTransaction.ClientID + "," + cboPaymentAccount.ClientID + "," + txtChequeNo.ClientID + "," + txtChequeDate.ClientID + "," + txtPaymentAmt.ClientID + ")");

        }
        txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'05','../../../../images/Date_Control_Rule_Check.aspx')");
        if (Session["empcd"].ToString() == "10001")
        {
            txtVoucherDate.Enabled = true;
        }
    }
    private void PopPaymentAcc()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds, "tab1");

        cboPaymentAccount.DataSource = ds;
        cboPaymentAccount.DataTextField = "accdesc";
        cboPaymentAccount.DataValueField = "asscodeval";
        cboPaymentAccount.DataBind();
    }
    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (cboModeOfTransaction.SelectedValue.ToString() != "")
        {

            string sql = "";

            if (cboModeOfTransaction.SelectedValue.ToString() != "Cash")
            {
                sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            }
            else
            {
                sql = "select  acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
            }
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds, "tab1");

            cboPaymentAccount.DataSource = ds;
            cboPaymentAccount.DataTextField = "accdesc";
            cboPaymentAccount.DataValueField = "asscodeval";
            cboPaymentAccount.DataBind();
            cboPaymentAccount.CssClass = "blackfnt";
        }
    }
    private void PopTDSType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select acccode+'~'+Accdesc as codeval,Accdesc from webx_acctinfo where acccode ='CLA0015'";
        //string sql = "select acccode+'~'+Accdesc as codeval,Accdesc from vw_tds_payable with(nolock)";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");

        cboTDSType.DataSource = ds;

        cboTDSType.DataTextField = "Accdesc";
        cboTDSType.DataValueField = "codeval";
        cboTDSType.DataBind();

    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        
        string sqlTHCPDC = "WEBX_document_Detail_m";
        SqlCommand cmd = new SqlCommand(sqlTHCPDC, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;

        myAdapter.SelectCommand.Parameters.Add("@docno", SqlDbType.VarChar).Value = checkeddockno.ToString().Trim();

        DataSet ds = new DataSet();

        myAdapter.Fill(ds, "billdata");
        totdkt = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
      
        double cheque = Convert.ToDouble(txtAdvanceAmtPaid.Text.ToString());
        string advamtpaidBy = txtAdvanceAmtPaidBy.Text;
        string balamount = txtBalanceAmt.Text;
        string balpayat = txtBalancePayableAt.Text;
        string chequeDate = txtChequeDate.Text;
        string chequeNo = "'" + txtChequeNo.Text + "'" ,adv_Chqamt="",adv_colamt="";
        if (chequeNo == "")
        {
            chequeNo = "Null";
        }
        //string Narration = txtNarration.Text;
        double paymentAmt = 0.00;//Convert.ToDouble(txtPaymentAmt.Text);
        string voucherDate = txtVoucherDate.Text;
        string tranmode = cboModeOfTransaction.Text;
        string paymentacc = cboPaymentAccount.SelectedItem.Text.ToString();
      
        if (tranmode == "Cash")
        {
            chequeDate = "NULL";
            chequeNo = "Null";
            paymentAmt = Convert.ToDouble(txtCashAmount.Text);
            string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmount.Text), fn.Mydate(txtVoucherDate.Text));
            if (Cnt == "F")
            {
                string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
            }

        }
        else
        {
            chequeDate = "'" + fn.Mydate(chequeDate) + "'";
            //chequeNo = "'" + chequeNo + "'";
              paymentAmt = Convert.ToDouble(txtPaymentAmt.Text);
              string Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChequeNo.Text, fn.Mydate1(txtChequeDate.Text));
              if (Cnt == "F")
              {
                  string ErrorMsg1 = "Duplicate Cheque Entered";
                  Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
              }



        }
        
        string Transdate = "'" + fn.Mydate(txtVoucherDate.Text) + "'";
       
        string[] Payment_acc_detail = cboPaymentAccount.SelectedValue.ToString().Split('~');
        string BankAcccode = Payment_acc_detail[0].ToString();
        string acccategory = Payment_acc_detail[1].ToString();
        string Accdesc = Payment_acc_detail[2].ToString();
        string acccode = BankAcccode;
        string PBOV_typ = "V";
        double TotChrg = 0;
        string[] tdsgrpcode_arr = cboTDSType.SelectedValue.ToString().Split('~');
        string tdsacccode = tdsgrpcode_arr[0].ToString();
        string tdsaccdesc = tdsgrpcode_arr[1].ToString(); // fn.getAccountDesc(tdsacccode);
        tdsacccode = "'" + tdsacccode + "'";
        tdsaccdesc = "'" + tdsaccdesc + "'";



        string sql_adv = "select isnull(max(srno),0) as srno  from webx_thc_AdvanceDetail";
        double Debit = 0, Credit = paymentAmt, Currbalance = 0, servicetaxCharged = 0;
        string  brcd = Session["brcd"].ToString(), Deptcode = "", paid_to = "", servicetaxNo = "", bookcode = "ADVANCE VENDOR PAYMENT", svctaxacccode = "";
        //string docno = thcno.ToString();
        SqlCommand cmd_adv = new SqlCommand(sql_adv, conn);
        //Response.Write("hi...." + Transdate);
        //Response.End();
        SqlDataReader dr_adv;
        dr_adv = cmd_adv.ExecuteReader();
        while (dr_adv.Read())
        {
            srno = Convert.ToInt32(dr_adv[0].ToString());
            srno = srno + 1;
        }
        dr_adv.Close();
       
        string finyear = System.DateTime.Today.ToString("yy"); //fn.GetFinyear();
 
        string s1 = "";
        string sqlvoucher = "usp_next_VoucherNo_M";
        SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        SqlCommand cmd_voucher = new SqlCommand();
        cmdvou.CommandType = CommandType.StoredProcedure;
        cmdvou.Parameters.AddWithValue("@brcd", Session["BRCD"].ToString());
        cmdvou.Parameters.AddWithValue("@finyear", finyear);
        cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        DataSet dsvou = new DataSet();
        davou.Fill(dsvou);

        foreach (DataRow dr in dsvou.Tables[0].Rows)
        {
            voucherNo = dr["vno"].ToString();
        }
        //string VendorCode = "";
        string accdesc = "";
        SqlCommand Acct_cmd = new SqlCommand();
        string Vbrcd = Session["brcd"].ToString(), Voucherno = fn.NextVoucherno(Session["BRCD"].ToString(), Financial_Year);
        string Vno = fn.NextVoucherno(Session["BRCD"].ToString(), Financial_Year);
        SqlTransaction trn;
        trn = conn.BeginTransaction();


        try  //  try FOR ALL
        {
            if (paymentAmt > 0)
            {

                foreach (GridViewRow gridrow in dockdata.Rows)
                {
                    Label SrNo = (Label)gridrow.FindControl("SrNo");
                    Label THCNO = (Label)gridrow.FindControl("THCNO");
                    TextBox indpcamt = (TextBox)gridrow.FindControl("indpcamt");
                    TextBox indothamt = (TextBox)gridrow.FindControl("indothamt");
                    TextBox inddiscount = (TextBox)gridrow.FindControl("inddiscount");
                    TextBox cboindsvctaxrate = (TextBox)gridrow.FindControl("cboindsvctaxrate");
                    TextBox indsvctax = (TextBox)gridrow.FindControl("indsvctax");
                    TextBox indcess = (TextBox)gridrow.FindControl("indcess");
                    TextBox indadvamt = (TextBox)gridrow.FindControl("indadvamt");
                    //TextBox indothded = (TextBox)gridrow.FindControl("indothded");
                    TextBox indsvctaxded = (TextBox)gridrow.FindControl("indsvctaxded");
                    TextBox indtds_rate = (TextBox)gridrow.FindControl("indtds_rate");
                    TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                    TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                    HiddenField txtpendamt = (HiddenField)gridrow.FindControl("txtpendamt");
                    HiddenField VendorCode = (HiddenField)gridrow.FindControl("vendor_code");
                    HiddenField VendorName = (HiddenField)gridrow.FindControl("vendor_Name");
                    HiddenField PANNO = (HiddenField)gridrow.FindControl("pan_no");

                    documentprint = "'" + THCNO.Text + "',";
                    //string sql_AdvDetail = "Select * from webx_thc_AdvanceDetail where thcno='" + THCNO.Text + "'";
                    //string sql_AdvDetail = "INSERT INTO [webx_thc_AdvanceDetail]([srno],[thcno],[thcsf],[adv_transtype],[adv_colamt],[adv_chqno],[adv_chqdt],[adv_chqamt],[adv_voucherNo],[adv_VoucherDt],[adv_paidby],[adv_acccode],[adv_accdesc],[vendor_code],[vendor_name])VALUES(" + srno + ",'" + THCNO.Text + "','.','" + tranmode + "'," + paymentAmt + "," + chequeNo + "," + chequeDate + "," + cheque + ",'" + voucherNo + "',getdate(),'" + advamtpaidBy + "','" + paymentacc + "','" + Accdesc + "','" + VendorCode.Value + "','" + VendorName.Value + "')";
                    string sql_AdvDetail = "INSERT INTO webx_thc_AdvanceDetail(srno,thcno,thcsf,adv_transtype,adv_colamt,adv_chqno,adv_chqdt,adv_chqamt,adv_voucherNo,adv_VoucherDt,adv_paidby,adv_acccode,adv_accdesc,vendor_code,vendor_name) VALUES (" + srno + ",'" + THCNO.Text + "','.','" + tranmode + "'," + paymentAmt + "," + chequeNo + "," + chequeDate + "," + cheque + ",'" + Vno + "',getdate(),'" + advamtpaidBy + "','" + paymentacc + "','" + Accdesc + "','" + VendorCode.Value + "','" + VendorName.Value + "')";
                    SqlCommand cmd_AdvDetail = new SqlCommand(sql_AdvDetail, conn,trn);
                    cmd_AdvDetail.ExecuteNonQuery();

                    if (tranmode == "Cash")
                    {
                        chequeDate = "NULL";
                        chequeNo = "Null";
                        adv_Chqamt = "0.00";
                        adv_colamt = indnetpay.Text.ToString();
                    }
                    else
                    {
                        // chequeDate = "'" + fn.Mydate(chequeDate) + "'";
                        //  chequeNo = "'" + chequeNo + "'";
                        adv_Chqamt = indnetpay.Text.ToString();
                        adv_colamt = "0.00";
                    }

                    string sql = "update webx_thc_summary set advamt_lastpaid='" + indadvamt.Text.ToString() + "',netbalamt='" + indnetpay.Text.ToString() + "',Advamt='" + indadvamt.Text.ToString() + "',Advance_paid='F',advvoucherNo='" + Vno + "',advvoucherdt=" + Transdate + ",advpaidat='" + brcd + "',adv_transtype='" + tranmode.ToString() + "',adv_Chqamt=" + adv_Chqamt + ",adv_colamt=" + adv_colamt + ",adv_Chqno=" + chequeNo + ",adv_Chqdate =" + chequeDate + ",adv_Acccode='" + BankAcccode + "',adv_AccCategory='" + acccategory + "' where THCNO='" + THCNO.Text + "' and thcsf='.'";
                    //  Response.Write("hi...." + sql);
                    // Response.End();    
                    cmd_voucher = new SqlCommand(sql, conn, trn);
                    cmd_voucher.ExecuteNonQuery();

                    string sql_Adv_acct = "exec usp_THCTransaction 1,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                    Acct_cmd = new SqlCommand(sql_Adv_acct, conn, trn);
                    // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
                    Acct_cmd.ExecuteNonQuery();

                }
                foreach (GridViewRow gridrow in dockdata.Rows)
                {
                    Label SrNo = (Label)gridrow.FindControl("SrNo");
                    Label THCNO = (Label)gridrow.FindControl("THCNO");
                    HiddenField Advance_paid = (HiddenField)gridrow.FindControl("Advance_paid");
                    if (Advance_paid.Value == "N")
                    {
                        string sql_bal_acct = "exec usp_THCTransaction 2,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                        Acct_cmd = new SqlCommand(sql_bal_acct, conn);
                        // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
                        Acct_cmd.ExecuteNonQuery();
                    }

                }
                foreach (GridViewRow gridrow in dockdata.Rows)
                {
                    Label SrNo = (Label)gridrow.FindControl("SrNo");
                    Label THCNO = (Label)gridrow.FindControl("THCNO");
                    TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                    HiddenField Advance_paid = (HiddenField)gridrow.FindControl("Advance_paid");
                    if (Advance_paid.Value == "N")
                    {
                        if (Convert.ToDouble(indtdsded.Text) > 0)
                        {
                            string sql_bal_acct_tds = "exec usp_THCTransaction 3,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                            Acct_cmd = new SqlCommand(sql_bal_acct_tds, conn);
                            //   Response.Write("<br>" + sql_bal_acct_tds);
                            Acct_cmd.ExecuteNonQuery();
                        }

                    }
                }
            }
            //Response.Write("hi....");
            //Response.End();

            if (tranmode.ToString() == "Cheque")
            {
                //****variable for cheque detail ************
                string acccodecb = BankAcccode;
                string depositdt = fn.Mydate(DateTime.Now.ToString("dd/MM/yyyy"));
                double CHQAMT = Convert.ToDouble(txtPaymentAmt.Text.ToString()), adjustamt = paymentAmt;
                string comments = "NULL";
                string bacd = "null";
                string banm = "null";
                string empnm = "null";
                string staffcd = "Null";
                string staffnm = "Null";
                string brnm = fn.GetLocation(Session["brcd"].ToString());
                string banknm = Accdesc.ToString();
                string BANKBRN = "";
                ///******************************************

                string sql = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt,Transtype,transdate,acccode,depoloccode,DepoFlag,voucherNo) values(" + chequeNo + "," + chequeDate + "," + CHQAMT + ",'" + banknm + "','',''," + comments + "," + bacd + "," + banm + ",'" + Session["empcd"].ToString() + "'," + empnm + ",'" + Session["brcd"].ToString() + "','" + brnm + "'," + staffcd + "," + staffnm + ",null,'O','" + BANKBRN + "'," + adjustamt + ",'Bank Payment','" + depositdt + "','" + acccodecb + "','" + brcd + "','Y','" + Vno + "')";
                cmd_voucher = new SqlCommand(sql, conn, trn);
                cmd_voucher.ExecuteNonQuery();

                //sql = "update webx_chq_det set voucherNo='" + Vno + "',transdate='" + depositdt + "',acccode='" + acccodecb + "',depoloccode='" + brcd + "',DepoFlag='Y' where chqno=" + chequeNo + " and convert(varchar,chqdt,106)=convert(datetime," + chequeDate + ",106)";
                //cmd_voucher = new SqlCommand(sql, conn, trn);
                //cmd_voucher.ExecuteNonQuery();
            }

            string sql2 = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged) values ";
            sql2 = sql2 + "(" + finyear + "," + Transdate + ",'" + Vno + "','" + acccode + "','" + Accdesc + "'," + chequeNo + "," + chequeDate + "," + Debit + "," + Credit + ",'" + tranmode + "'," + Currbalance + ",'','" + brcd + "','" + Deptcode + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + paid_to + "','" + Session["empcd"].ToString() + "','" + brcd + "',0,0,0,0,0," + txtOtherAmt.Text + ",0,0,0," + PaymentAmt + ",'','','" + PBOV_typ + "','','" + servicetaxNo + "','" + bookcode + "','" + Accdesc + "'," + cheque + ",'" + tranmode + "'," + txtTDSAmt.Text + "," + TotChrg + "," + tdsacccode + ",'" + svctaxacccode + "'," + servicetaxCharged + ")";
            cmd_voucher = new SqlCommand(sql2, conn, trn);
            cmd_voucher.ExecuteNonQuery();


            sql2 = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + Vno + "'";
            cmd_voucher = new SqlCommand(sql2, conn, trn);
            cmd_voucher.ExecuteNonQuery();

            sql2 = "Delete from webx_vouchertrans where voucherNo='" + Vno + "'";
            cmd_voucher = new SqlCommand(sql2, conn, trn);
            cmd_voucher.ExecuteNonQuery();

            trn.Commit();

            conn.Close();

            string final = "?DocumentPrint=" + checkeddockno;
            final += "&voucherNo=" + Vno;
            Response.Redirect("THCAdvanceDone.aspx" + final);
            conn.Close();
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
