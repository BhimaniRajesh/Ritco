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
    public string billno_nos, Branch, documentprint, TotNet, Accdesc, PBOV_code, PBOV_Name, PBOV_typ, final;
    public static string chqdt, chqdt1, fromdt, Todt, Financial_Year = "";
    public string vendorcode = "", runsheettype = "", archiveFlag, transtype1, checkeddockno;
    protected string advbal = "", acccode = "", accdesc = "", pdcnos = "";

    MyFunctions fn = new MyFunctions();

    SqlConnection con;
    public int ContractAmt = 0, totdkt;
    protected int rows = 0;
    double totalBalamt = 0;
    protected double totbalamt = 0.00, totadvamt = 0.00, tottdsamt = 000, tdsrate = 0.00, totothamt = 0.00, totconamt = 0.00, debit, credit;
    public double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, H_CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    public double servicetaxrate, colamt_check, chqamt1, colamt1;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        //string sql = "SELECT accdesc,acccode FROM webx_acctinfo WHERE acccode='CLA0014'";
        //SqlCommand cmd = new SqlCommand(sql, con);
        //SqlDataReader dr = cmd.ExecuteReader();
        //cboTDSType.Items.Clear();
        //while (dr.Read())
        //{
        //    cboTDSType.Items.Add(new ListItem(dr["accdesc"].ToString(), dr["acccode"].ToString()));
        //    acccode = dr["acccode"].ToString();
        //    accdesc = dr["accdesc"].ToString();
        //}
        //dr.Close();
        pdcnos = Request.QueryString["pdcnos"].ToString();
        advbal = Request.QueryString["advbal"].ToString();
        billno_nos = Request.QueryString.Get("billno_nos");
        checkeddockno = Request.QueryString.Get("checkeddockno").ToString();
        if (!IsPostBack)
        {
            btnSubmit.Enabled = true;
            Branch = Session["brcd"].ToString();
            dataBind();
            PopPaymentAcc();
            // PopTDSType();

            foreach (GridViewRow gridrow in gvrunsheet.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label docno = (Label)gridrow.FindControl("thcno");
                TextBox indpcamt1 = (TextBox)gridrow.FindControl("indpcamt");
                TextBox advamt = (TextBox)gridrow.FindControl("indadvamt");
                TextBox netpayment = (TextBox)gridrow.FindControl("indnetpay");
                TextBox othcharge = (TextBox)gridrow.FindControl("indothamt");
                TextBox tds_rate1 = (TextBox)gridrow.FindControl("indtds_rate");
                TextBox tdsamount = (TextBox)gridrow.FindControl("indtdsded");

                ContractAmt = ContractAmt + Convert.ToInt32(indpcamt1.Text);
                txtContractAmt.Text = ContractAmt.ToString();
                txtContractAmt.Enabled = false;
                if (othcharge.Text != "")
                {
                    OtherAmt = OtherAmt + Convert.ToDouble(othcharge.Text);
                    txtOtherAmt.Text = OtherAmt.ToString();
                    txtOtherAmt.Enabled = false;
                }
                else
                {
                    txtOtherAmt.Text = "0.00";
                    othcharge.Text = "0.00";
                    txtOtherAmt.Enabled = false;
                }
                if (tdsamount.Text != "")
                {
                    TDSDeduction = TDSDeduction + Convert.ToDouble(tdsamount.Text);
                    txtTDSAmt.Text = TDSDeduction.ToString();
                    txtTDSAmt.Enabled = false;
                }
                else
                {
                    txtTDSAmt.Text = "0.00";
                    tdsamount.Text = "0.00";
                    txtTDSAmt.Enabled = false;
                }
                if (advamt.Text != "")
                {
                    AdvancePaid = AdvancePaid + Convert.ToDouble(advamt.Text);
                    txtAdvanceAmtPaid.Text = AdvancePaid.ToString();
                    txtAdvanceAmtPaid.Enabled = false;
                }
                else
                {
                    txtAdvanceAmtPaid.Text = "0.00";
                    advamt.Text = "0.00";
                    txtAdvanceAmtPaid.Enabled = false;
                }
                if (netpayment.Text != "")
                {
                    NetAmount = NetAmount + Convert.ToDouble(netpayment.Text);
                    txtBalanceAmt.Text = NetAmount.ToString();
                    //txtPaymentAmt.Text = NetAmount.ToString();
                    txtBalanceAmt.Enabled = false;
                    txtPaymentAmt.Enabled = false;
                }
                else
                {
                    txtBalanceAmt.Text = "0.00";
                    netpayment.Text = "0.00";
                    txtPaymentAmt.Text = "0.00";
                    txtBalanceAmt.Enabled = false;
                    txtPaymentAmt.Enabled = false;
                }
                NetAmount1 = Convert.ToDouble(indpcamt1.Text) + Convert.ToDouble(othcharge.Text) - Convert.ToDouble(tdsamount.Text) - Convert.ToDouble(advamt.Text);
                netpayment.Text = NetAmount1.ToString();
                PaymentAmt = PaymentAmt + Convert.ToDouble(advamt.Text);
                txtPaymentAmt.Text = "0.00";
                txtCashAmount.Text = "0.00";

            }

            txtVoucherDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

        }
        btnSubmit.Attributes.Add("onclick", "javascript:return check(" + txtAdvanceAmtPaid.ClientID + "," + txtBalanceAmt.ClientID + "," + cboModeOfTransaction.ClientID + "," + cboPaymentAccount.ClientID + "," + txtChequeNo.ClientID + "," + txtChequeDate.ClientID + "," + txtPaymentAmt.ClientID + ")");
        txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'05','../../../../images/Date_Control_Rule_Check.aspx')");
        if (Session["empcd"].ToString() == "10001")
        {
            txtVoucherDate.Enabled = true;
        }
    }
    private void PopTDSType()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();

        //string sql = "select acccode+'~'+Accdesc as codeval,Accdesc from webx_acctinfo where acccode ='CLA0015'";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);

        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        //da.Fill(ds, "tab1");

        //cboTDSType.DataSource = ds;

        //cboTDSType.DataTextField = "Accdesc";
        //cboTDSType.DataValueField = "codeval";
        //cboTDSType.DataBind();

    }



    public void dataBind()
    {

        //string sqlstr = "WEBX_PDC_DetailS '" + pdcnos + "'"; 
        string sqlstr = "WEBX_PDC_DetailS";
        SqlCommand cmdoct = new SqlCommand(sqlstr, con);
        cmdoct.Connection = con;

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);
        cmdoct.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.Add("@docno", SqlDbType.VarChar).Value = checkeddockno.ToString().Trim();
        sda.Fill(ds, "tbl1");

        gvrunsheet.DataSource = ds;
        gvrunsheet.DataBind();
        rows = ds.Tables[0].Rows.Count;
        totdkt = ds.Tables[0].Rows.Count;
        con.Close();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvrunsheet.PageIndex = e.NewPageIndex;
        dataBind();
    }

    protected void gvrunsheet_SelectedIndexChanged(object sender, EventArgs e)
    {

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





    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        btnSubmit.Enabled = false;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string transdate = fn.Mydate(txtVoucherDate.Text.ToString());
        string sql, sql1;
        conn.Open();
        string Acccode = "";
        string tds_chrg1 = txtTDSAmt.Text;
        string OtherAmt = txtOtherAmt.Text;
        string tdsfor1 = "";// cboTDSDeducted.SelectedValue.ToString();
        //string paidby1 = txtAdvanceAmtPaidBy.Text;
        transtype1 = cboModeOfTransaction.SelectedItem.ToString();
        string chqno1 = txtChequeNo.Text;

        if (chqno1 == "")
        {
            chqno1 = "Null";
        }
        chqdt = txtChequeDate.Text;

        //string balamtbrcd1 = txtBalancePayableAt.Text;
        string balamt1 = txtBalanceAmt.Text;
        string vendcd1 = "";
        string tdsgrpdesc1 = "null";
        string tdsacccode1 = "null";
        string tdsaccdesc1 = "null";
        if (transtype1 == "Cash")
        {
            chqdt = "NULL";
        }
        else
        {
            chqdt = "'" + fn.Mydate(chqdt) + "'";
        }
        if (transtype1 == "Cash")
        {
            transtype1 = "Cash";
            chqno1 = "null";
            chqdt1 = "null";
            chqamt1 = 0;

            string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(txtCashAmount.Text), fn.Mydate(txtVoucherDate.Text));
            if (Cnt == "F")
            {
                string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
            }

        }
        else
        {
            transtype1 = "BANK";
            chqno1 = txtChequeNo.Text;
            chqdt1 = chqdt;
            chqamt1 = Convert.ToDouble(txtPaymentAmt.Text);
            colamt1 = Convert.ToDouble(txtPaymentAmt.Text);
            colamt_check = Convert.ToDouble(txtPaymentAmt.Text);

            string Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtChequeNo.Text, fn.Mydate1(txtChequeDate.Text));
            if (Cnt == "F")
            {
                string ErrorMsg1 = "Duplicate Cheque Entered";
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
            }

        }
        string advvoucheramt = txtPaymentAmt.Text;
        string finyear = System.DateTime.Today.ToString("yy");

        string Vbrcd = Session["brcd"].ToString(), Voucherno = fn.NextVoucherno(Session["brcd"].ToString(), Financial_Year);
        if (cboModeOfTransaction.SelectedItem.ToString() == "Cheque")
        {
            int cnt = 0;
            string sql_chq = "select count(*)  as cnt from webx_chq_det where chqno='" + chqno1 + "' and chqdt=" + chqdt + " and ownCust='O'";
            SqlCommand cmd_chq = new SqlCommand(sql_chq, conn);
            //Response.Write("hi...." + Transdate);
            //Response.End();
            SqlDataReader dr_chq;
            dr_chq = cmd_chq.ExecuteReader();
            while (dr_chq.Read())
            {
                cnt = Convert.ToInt32(dr_chq[0].ToString());

            }
            if (cnt > 0)
            {
                Response.Write("<Table border=1 cellspacing=0 cellpadding=2 width=70% align=center class=bglightblue><TR><TD align=center class='bgbluegrey'><font class=blackfnt color=red><b>Result</b></font></TD></TR> <TR><TD><br> <p align=center><font class=blackfnt >");
                Response.Write("Duplicate Cheque ,This cheque is already issued!s!!");
                Response.Write("</font><br><br><font class=blackfnt><a href='javascript:history.go(-1)'><u>Back</u></a></br></p></TD> </TR> </TABLE>");
                Response.End();
            }
            dr_chq.Close();
        }
        SqlTransaction trn;
        trn = conn.BeginTransaction();


        try  //  try FOR ALL
        {

            foreach (GridViewRow gridrow in gvrunsheet.Rows)
            {
                Label SrNo = (Label)gridrow.FindControl("SrNo");
                Label docno = (Label)gridrow.FindControl("thcno");
                TextBox indpcamt1 = (TextBox)gridrow.FindControl("indpcamt");
                TextBox advamt = (TextBox)gridrow.FindControl("indadvamt");
                TextBox netpayment = (TextBox)gridrow.FindControl("indnetpay");
                TextBox othcharge = (TextBox)gridrow.FindControl("indothamt");
                TextBox tds_rate1 = (TextBox)gridrow.FindControl("indtds_rate");
                TextBox indoth_ded_amt = (TextBox)gridrow.FindControl("indoth_ded_amt");

                totalBalamt = Convert.ToDouble(netpayment.Text) + totalBalamt;
                string sql_check = "select * from webx_PDCHDR where pdcno='" + docno.Text + "'";
                SqlCommand sqlcmd_check = new SqlCommand(sql_check, conn, trn);
                SqlDataReader dr_check = sqlcmd_check.ExecuteReader();

                if (dr_check.Read())
                {

                    archiveFlag = "N";
                    vendorcode = dr_check["vendorcode"].ToString();
                    runsheettype = "Delivery Run Sheet";
                }
                dr_check.Close();
                // string sqlArch = "select * from webx_PDCHDR_ARCH where pdcno='" + docno + "'";
                //  SqlCommand sqlcmdArch = new SqlCommand(sqlArch, conn);
                //  SqlDataReader dr1Arch = sqlcmdArch.ExecuteReader();

                //  if (dr1Arch.Read())
                //  {

                //     archiveFlag = "Y";
                //      vendorcode = dr1Arch["vendorcode"].ToString();
                //      runsheettype = "Pick-UP Run Sheet";
                //  }
                //  dr1Arch.Close();
                //Arch_tableflag.Value = archiveFlag;

                string tablename = "";
                //if (Arch_tableflag.Value == "N")
                //{
                tablename = "webx_PDCHDR";
                //}
                //else
                //{
                //    tablename = "webx_PDCHDR_ARCH";
                //}
                string[] Payment_acc_detail = cboPaymentAccount.SelectedValue.ToString().Split('~');
                string BankAcccode = Payment_acc_detail[0].ToString();
                string acccategory = Payment_acc_detail[1].ToString();
                Accdesc = "";// Payment_acc_detail[2].ToString();


                Acccode = BankAcccode;
                string vendorcode1 = vendorcode + "~" + fn.GetVendor(vendorcode);
                string[] PBOV_detail_arr = vendorcode1.Split('~');
                PBOV_code = PBOV_detail_arr[0].ToString();
                PBOV_Name = PBOV_detail_arr[1].ToString();
                PBOV_typ = "V";
                string bal_chqamt = "null";
                if (transtype1 == "BANK")
                {
                    bal_chqamt = netpayment.Text;
                }
                string sql_arch = "UPDATE " + tablename + "  set  MIS_CHG='" + othcharge.Text + "',pdc_totded='" + indoth_ded_amt.Text + "',manual_adv_voucherno='" + Manualvoucherno.Text + "',bal_Chqno='" + chqno1 + "',bal_Chqdate=" + chqdt1 + ",bal_CHQAMT=" + bal_chqamt + ",pdc_status='FC' where PDCNO = '" + docno.Text + "'";
                SqlCommand sqlCommand_arch = new SqlCommand(sql_arch, conn, trn);
                sqlCommand_arch.ExecuteNonQuery();

                if (Convert.ToDouble(netpayment.Text) > 0)
                {
                    string sqlHDR1 = "UPDATE " + tablename + "  set balamt =" + netpayment.Text + ",bal_colamt=" + netpayment.Text + ",bal_acccode='" + Acccode + "',bal_accdesc='" + Accdesc + "',bal_transtype='" + transtype1 + "',bal_voucherNo='" + Voucherno + "',bal_voucherdt='" + transdate + "' where PDCNO = '" + docno.Text + "'";
                    SqlCommand sqlCommandHDR1 = new SqlCommand(sqlHDR1, conn, trn);
                    sqlCommandHDR1.ExecuteNonQuery();

                    string sql_Adv_acct = "exec usp_PDCTransaction 4,'" + docno.Text.ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Voucherno + "'";
                    SqlCommand Acct_cmd = new SqlCommand(sql_Adv_acct, conn, trn);
                    // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
                    Acct_cmd.ExecuteNonQuery();
                }
            }
            colamt_check = colamt_check;
            debit = 0;
            credit = Convert.ToDouble(totalBalamt);
            string bookcode = "ADVANCE VENDOR PAYMENT";
            string BANKNAME = "";
            string TRANSMODE = "";
            string tdsacccode = "";
            string svctaxacccode = "";
            string chqno2 = "Null";
            string chqdate2 = "Null";
            string finyear1 = System.DateTime.Today.ToString("yy");
            string Transdate = System.DateTime.Today.ToString("dd/MM/yyyy");

            double servicetaxrate = 0;
            double OCTPaid = 0;
            double AgentServiceChrg = 0;
            double ServiceChargPaid = 0;
            double TotalDed = 0;
            double TotChrg = 0;
            double CHQAMT = 0;
            double DEDUCTION = 0;
            double othChrg = 0;
            double tdsrate = 0;
            double servicetaxCharged = 0;
            double Currbalance = 0;
            double mamul_chrg = 0;

            if (transtype1 == "BANK")
            {
                string depositdt = System.DateTime.Today.ToString("dd/MM/yyyy");
                CHQAMT = Convert.ToDouble(totalBalamt);
                chqno2 = "'" + txtChequeNo.Text + "'";
                chqdate2 = "'" + fn.Mydate1(txtChequeDate.Text) + "'";
            }
            string servicetaxNo = "";
            string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry) values (" + finyear1 + ",'" + fn.Mydate1(Transdate) + "','" + Voucherno + "','" + Acccode + "','" + Accdesc + "'," + chqno2 + "," + chqdate2 + "," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'','" + Session["brcd"].ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + Session["empcd"].ToString() + "','" + Session["brcd"].ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + txtPaymentAmt.Text + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + CHQAMT + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y')";
            SqlCommand sqlCommand_Trnas = new SqlCommand(sql_VTrans, conn, trn);
            sqlCommand_Trnas.ExecuteNonQuery();
            string sql_TransArch = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + Voucherno + "'";
            SqlCommand sqlCommand_TrnasArch = new SqlCommand(sql_TransArch, conn, trn);
            sqlCommand_TrnasArch.ExecuteNonQuery();

            string sql_VTrans_delete = "delete from webx_vouchertrans where voucherNo='" + Voucherno + "'";
            SqlCommand sqlCommand_TrnasDelete = new SqlCommand(sql_VTrans_delete, conn, trn);
            sqlCommand_TrnasDelete.ExecuteNonQuery();

            if (transtype1 == "BANK")
            {
                string depositdt = System.DateTime.Today.ToString("dd/MM/yyyy");
                string CHQAMT1 = Convert.ToString(totalBalamt);
                string Chqno11 = txtChequeNo.Text;
                string banknm = Accdesc;
                string ptmsptcd = PBOV_code;
                string ptmsptnm = PBOV_Name;
                string adjustamt = txtPaymentAmt.Text;
                string comments = "NULL";
                string bacd = "null";
                string banm = "null";
                string empnm = "null";
                string staffcd = "Null";
                string staffnm = "Null";
                string branch = Session["brcd"].ToString();
                string branchname = fn.GetLocation(Session["brcd"].ToString());
                string acccodedec = cboPaymentAccount.SelectedItem.ToString();

                string sql_chqdet = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt,Transtype,transdate,acccode,depoloccode,DepoFlag,voucherNo) values('" + Chqno11 + "'," + chqdt1 + ",'" + CHQAMT1 + "','" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','" + comments + "','" + bacd + "','" + banm + "','" + Session["empcd"].ToString() + "','" + "" + "','" + Session["brcd"].ToString() + "','" + "" + "'," + staffcd + "," + staffnm + ",null,'O','" + "" + "'," + adjustamt + ",'Bank Payment','" + transdate + "','" + Acccode + "','" + Session["brcd"].ToString() + "','Y','" + Voucherno + "')";
                SqlCommand sqlCommand_Cheque = new SqlCommand(sql_chqdet, conn, trn);
                sqlCommand_Cheque.ExecuteNonQuery();

                string sql_cheque_update = "update webx_chq_det set voucherNo='" + Voucherno + "',transdate='" + transdate + "',acccode='" + Acccode + "',depoloccode='" + Session["brcd"].ToString() + "',DepoFlag='Y' where chqno='" + Chqno11 + "' and convert(varchar,chqdt,106)=convert(datetime," + chqdt1 + ",106)";
                SqlCommand sqlCommand_Cheq_Update = new SqlCommand(sql_cheque_update, conn, trn);
                sqlCommand_Cheq_Update.ExecuteNonQuery();
            }

            trn.Commit();

            conn.Close();


            final += "?VoucherNo=" + Voucherno;
            Response.Redirect("RunSheetBalancePaymentDone.aspx" + final);
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


    protected void gvrunsheet_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtcon = ((TextBox)(e.Row.FindControl("indpcamt")));
            TextBox txtoth = ((TextBox)(e.Row.FindControl("indothamt")));
            TextBox txttdsrate = ((TextBox)(e.Row.FindControl("indtds_rate")));
            TextBox txtded = ((TextBox)(e.Row.FindControl("indtdsded")));
            TextBox txtadvamt = ((TextBox)(e.Row.FindControl("indadvamt")));
            TextBox txtbalamt = ((TextBox)(e.Row.FindControl("indnetpay")));

            double advamt = Convert.ToDouble(((txtadvamt.Text == null) || (txtadvamt.Text == "")) ? "0.00" : txtadvamt.Text);
            double othamt = Convert.ToDouble(((txtoth.Text == null) || (txtoth.Text == "")) ? "0.00" : txtoth.Text);
            double conamt = Convert.ToDouble(((txtcon.Text == null) || (txtcon.Text == "")) ? "0.00" : txtcon.Text);
            double tdsamt = 0;
            if (Convert.ToDouble(txttdsrate.Text) != 0)
                tdsamt = (Convert.ToDouble(((txtcon.Text == null) || (txtcon.Text == "")) ? "0.00" : txtcon.Text) / Convert.ToDouble(((txttdsrate.Text == null) || (txttdsrate.Text == "")) ? "0.00" : txttdsrate.Text)) * 100;

            double tdsded = Convert.ToDouble(((txtded.Text == null) || (txtded.Text == "")) ? "0.00" : txtded.Text);
            if (Convert.ToDouble(((txttdsrate.Text == null) || (txttdsrate.Text == "")) ? "0.00" : txttdsrate.Text) != 0)
                tottdsamt = tottdsamt + tdsamt;

            double balamt = conamt + othamt + tdsamt - tdsded - advamt;
            txtbalamt.Text = balamt.ToString("F2");
            totadvamt = totadvamt + advamt;
            totconamt = totconamt + conamt;
            totothamt = totothamt + othamt;
            totbalamt = totbalamt + balamt;
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txttotbal = ((TextBox)(e.Row.FindControl("TotalNetPay")));
            TextBox txttotadv = ((TextBox)(e.Row.FindControl("TotalNetamt")));

            txttotadv.Text = totadvamt.ToString("F2");
            txttotbal.Text = totbalamt.ToString("F2");
            //txtCashAmount.Text = totbalamt.ToString("F2");
            //txtPaymentAmt.Text = totbalamt.ToString("F2");
            txtBalanceAmt.Text = totbalamt.ToString("F2");
            txtContractAmt.Text = totconamt.ToString("F2");
            txtOtherAmt.Text = totothamt.ToString("F2");
            txtTDSAmt.Text = tottdsamt.ToString("F2");
            txtAdvanceAmtPaid.Text = totadvamt.ToString("F2");

        }
    }
}
