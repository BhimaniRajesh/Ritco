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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCBalancePayment : System.Web.UI.Page
{
    private string billno_nos, Branch, documentprint, voucherNo;
    public string checkeddockno, fromdt, Todt, server_dt, tranmode, Financial_Year = "";
    public int totdkt, srno;
    private int ContractAmt = 0;
    private double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    MyFunctions fn = new MyFunctions();
    DateTime Fromdate, Todate;
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        Branch = Session["brcd"].ToString();
        if (!IsPostBack)
        {
            /*string CheckStatus = VendorPayment_Utility.Pending_Advice_Status();
            if (CheckStatus != "Y")
            {
                string ErrorMesssage = "Transactions halted !!! " + CheckStatus;
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMesssage);
            }*/
            btnSubmit.Enabled = true;
            txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'05','./../../../../images/Date_Control_Rule_Check.aspx')");
            billno_nos = Request.QueryString.Get("billno_nos");
            checkeddockno = Request.QueryString.Get("checkeddockno").ToString();
            fromdt = Request.QueryString.Get("fromdt");
            Todt = Request.QueryString.Get("Todt");
            if (fromdt != "")
            {
                Fromdate = Convert.ToDateTime(fromdt);
                fromdt = Fromdate.ToString("dd/MM/yyyy");
            }

            if (Todt != "")
            {
                Todate = Convert.ToDateTime(Todt);
                Todt = Todate.ToString("dd/MM/yyyy");
            }
            txtVoucherDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            server_dt = System.DateTime.Today.ToString("dd/MM/yyyy");
            lblStandardAmt.Text = "0";
            PopPaymentAcc();
            BindGrid();
            cboModeOfTransaction.CssClass = "blackfnt";

            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                HiddenField PANNO = (HiddenField)gridrow.FindControl("pan_no");
                if (PANNO.Value == "")
                {
                    txtPANNo.Text = "PAN NOTAVL";
                }
                else
                {
                    txtPANNo.Text = Convert.ToString(PANNO.Value);
                }

            }
        }
        btnSubmit.Attributes.Add("onclick", "javascript:return check(" + cboModeOfTransaction.ClientID + "," + cboPaymentAccount.ClientID + "," + txtChequeNo.ClientID + "," + txtChequeDate.ClientID + "," + txtPaymentAmt.ClientID + ")");
    }
    private void PopPaymentAcc()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  ((( acccategory='CASH' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0 ) AND acccategory='BANK')) order by accdesc asc";

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
    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (cboModeOfTransaction.SelectedValue.ToString() != "")
        {

            string sql = "";

            if (cboModeOfTransaction.SelectedValue.ToString() != "Cash")
            {
                sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0 ) AND acccategory='BANK')) order by accdesc asc";
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        btnSubmit.Enabled = false;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string chequeDate = txtChequeDate.Text;
        string chequeNo = "'" + txtChequeNo.Text + "'", bal_Chqamt = "", bal_colamt = "";
        if (chequeNo == "")
        {
            chequeNo = "Null";
        }

        double paymentAmt = 0.00;
        string voucherDate = txtVoucherDate.Text;
        tranmode = cboModeOfTransaction.Text;
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

        SqlTransaction trans;

        string sql_adv = "select max(srno) from webx_thc_AdvanceDetail";
        double Debit = 0, Credit = paymentAmt, Currbalance = 0, servicetaxCharged = 0;
        string brcd = Session["brcd"].ToString(), Deptcode = "", paid_to = "", servicetaxNo = "", bookcode = "ADVANCE VENDOR PAYMENT", svctaxacccode = "";

        SqlCommand cmd_adv = new SqlCommand(sql_adv, conn);
        SqlDataReader dr_adv;
        dr_adv = cmd_adv.ExecuteReader();
        while (dr_adv.Read())
        {
            srno = Convert.ToInt32(dr_adv[0].ToString());
            srno = srno + 1;
        }
        dr_adv.Close();

        string finyear = System.DateTime.Today.ToString("yy");

        string s1 = "";
        string sqlvoucher = "usp_next_VoucherNo_M";
        SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        SqlCommand cmd_voucher = new SqlCommand();
        cmdvou.CommandType = CommandType.StoredProcedure;
        cmdvou.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
        cmdvou.Parameters.AddWithValue("@finyear", finyear);
        cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        DataSet dsvou = new DataSet();
        davou.Fill(dsvou);

        foreach (DataRow dr in dsvou.Tables[0].Rows)
        {
            voucherNo = dr["vno"].ToString();
        }
        string accdesc = "";
        SqlCommand Acct_cmd = new SqlCommand();
        string Vbrcd = Session["brcd"].ToString(),
        Vno = fn.NextVoucherno(Vbrcd, Financial_Year);
        trans = conn.BeginTransaction();
        try
        {
            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                TextBox incentive = (TextBox)gridrow.FindControl("incentive");
                TextBox indpenalty = (TextBox)gridrow.FindControl("indpenalty");
                TextBox indclaim = (TextBox)gridrow.FindControl("indclaim");
                DropDownList indcboHamali = (DropDownList)gridrow.FindControl("indcboHamali");

                TextBox indhamali = (TextBox)gridrow.FindControl("indhamali");
                TextBox inddetention = (TextBox)gridrow.FindControl("inddetention");
                TextBox indothded = (TextBox)gridrow.FindControl("indothded");
                TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                HiddenField PANNO = (HiddenField)gridrow.FindControl("pan_no");

                string tds_update_str = "";
                tds_update_str = ",tds_chrg=" + indtdsded.Text + "";

                documentprint = "'" + THCNO.Text + "',";
                if (tranmode == "Cash")
                {
                    chequeDate = "NULL";
                    chequeNo = "Null";
                    bal_Chqamt = "0.00";
                    bal_colamt = indnetpay.Text.ToString();
                }
                else
                {
                    bal_Chqamt = indnetpay.Text.ToString();
                    bal_colamt = "0.00";
                }

                string sql = "update webx_thc_summary set pan_no='" + txtPANNo.Text + "',BehatiDetail='" + txtBehatiNo.Text + "',Narration_added='" + txtNarration.Text + "',balvoucherNo='" + Vno + "',balvoucherdt=" + Transdate + ",unloadOperType='" + indcboHamali.SelectedValue + "',oth_ded=" + indothded.Text + ",deten_chrg=" + inddetention.Text + ",unload_chrg=" + indhamali.Text + ",THCCLOSE_MODE='F',THCCLOSE_ENTRYBY='" + Session["brcd"].ToString() + "',THCCLOSE_ENTRYDT=getdate(),incentive=" + incentive.Text + ",penalty=" + indpenalty.Text + ",Claim_chrg=" + indclaim.Text + ",TOTALAMTPAID=" + indnetpay.Text + ",bal_Acccode='" + BankAcccode + "', bal_AccCategory='" + acccategory + "', bal_Chqno=" + chequeNo + ", bal_Chqdate=" + chequeDate + ",bal_Chqamt=" + bal_Chqamt + ",bal_colamt=" + bal_colamt + ",bal_transtype='" + tranmode + "',balpaidby='" + txtBalPaidBy.Text + "'  " + tds_update_str + "  where THCNO='" + THCNO.Text + "' and thcsf='.'";

                cmd_voucher = new SqlCommand(sql, conn, trans);
                cmd_voucher.Transaction = trans;
                cmd_voucher.ExecuteNonQuery();
            }
            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                HiddenField Advance_paid = (HiddenField)gridrow.FindControl("Advance_paid");
                if (Advance_paid.Value == "Y")
                {
                    string sql_bal_acct = "exec usp_THCTransaction 2,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                    Acct_cmd = new SqlCommand(sql_bal_acct, conn, trans);
                    Acct_cmd.ExecuteNonQuery();
                }

            }
            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                HiddenField Advance_paid = (HiddenField)gridrow.FindControl("Advance_paid");

                if (indtdsded.Enabled)
                {
                    if (Convert.ToDouble(indtdsded.Text) > 0)
                    {
                        string sql_bal_acct_tds_for_old = "exec usp_THCTransaction 31,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                        Acct_cmd = new SqlCommand(sql_bal_acct_tds_for_old, conn, trans);
                        Acct_cmd.ExecuteNonQuery();
                    }

                }
            }
            foreach (GridViewRow gridrow in dockdata.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label THCNO = (Label)gridrow.FindControl("THCNO");
                TextBox indtdsded = (TextBox)gridrow.FindControl("indtdsded");
                string sql_bal_acct_tds = "exec usp_THCTransaction 4,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                Acct_cmd = new SqlCommand(sql_bal_acct_tds, conn, trans);
                Acct_cmd.Transaction = trans;
                Acct_cmd.ExecuteNonQuery();

                sql_bal_acct_tds = "exec usp_THCTransaction 5,'" + THCNO.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                Acct_cmd = new SqlCommand(sql_bal_acct_tds, conn, trans);
                Acct_cmd.Transaction = trans;
                Acct_cmd.ExecuteNonQuery();

                TextBox indnetpay = (TextBox)gridrow.FindControl("indnetpay");
            }



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
                cmd_voucher = new SqlCommand(sql, conn, trans);
                cmd_voucher.Transaction = trans;
                cmd_voucher.ExecuteNonQuery();

                //sql = "update webx_chq_det set voucherNo='" + Vno + "',transdate='" + depositdt + "',acccode='" + acccodecb + "',depoloccode='" + brcd + "',DepoFlag='Y' where chqno=" + chequeNo + " and convert(varchar,chqdt,106)=convert(datetime," + chequeDate + ",106)";
                //cmd_voucher = new SqlCommand(sql, conn, trans);
                //cmd_voucher.Transaction = trans;
                //cmd_voucher.ExecuteNonQuery();
            }

            string sql2 = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Deptcode,Entryby,Entrydt,Voucher_Cancel,voucher_status,PayTo,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged) values ";
            sql2 = sql2 + "(" + finyear + "," + Transdate + ",'" + Vno + "','" + acccode + "','" + Accdesc + "'," + chequeNo + "," + chequeDate + "," + Debit + "," + Credit + ",'" + tranmode + "'," + Currbalance + ",'','" + brcd + "','" + Deptcode + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + paid_to + "','" + Session["empcd"].ToString() + "','" + brcd + "',0,0,0,0,0,0,0,0,0," + PaymentAmt + ",'','','" + PBOV_typ + "','','" + servicetaxNo + "','" + bookcode + "','" + Accdesc + "'," + paymentAmt + ",'" + tranmode + "'," + txtTDSAmt.Text + "," + TotChrg + ",'','" + svctaxacccode + "'," + servicetaxCharged + ")";
            cmd_voucher = new SqlCommand(sql2, conn, trans);
            cmd_voucher.Transaction = trans;
            cmd_voucher.ExecuteNonQuery();

            sql2 = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + Vno + "'";
            cmd_voucher = new SqlCommand(sql2, conn, trans);
            cmd_voucher.Transaction = trans;
            cmd_voucher.ExecuteNonQuery();

            sql2 = "Delete from webx_vouchertrans where voucherNo='" + Vno + "'";
            cmd_voucher = new SqlCommand(sql2, conn, trans);
            cmd_voucher.Transaction = trans;
            cmd_voucher.ExecuteNonQuery();
            trans.Commit();
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : Done</font>");
            string final = "?DocumentPrint=" + checkeddockno;
            final += "&voucherNo=" + Vno;
            Response.Redirect("THCBalanceDone.aspx" + final);
            conn.Close();
        }

        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                string abc = "Insert Susccessfully !!!!!!!";
            }
            else
            {
                trans.Rollback();
                conn.Close();
            }
            Response.End();
        }


    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dockdata.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void TDS_AT_baltime_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox indtdsded = (TextBox)e.Row.FindControl("indtdsded");
            indtdsded.Text = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "tdsded"));
            if (Convert.ToDouble(indtdsded.Text) > 0)
            {
                indtdsded.Enabled = false;
            }
            else
            {
                indtdsded.Enabled = true;
            }
        }

    }
}
