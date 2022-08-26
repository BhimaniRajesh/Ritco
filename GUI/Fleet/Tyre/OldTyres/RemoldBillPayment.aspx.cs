using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class GUI_Fleet_Tyre_OldTyres_RemoldBillPayment : BasePage//System.Web.UI.Page
{
    string VendorID = "", FromDT = "", ToDT = "", BillNo = "";

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

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        if (!IsPostBack)
        {
            Financial_Year = SessionUtilities.FinYear.ToString().Substring(2, 2);
            VendorID = Request.QueryString["VendorID"].Trim();
            FromDT = Request.QueryString["FromDT"].Trim();
            ToDT = Request.QueryString["ToDT"].Trim();
            BillNo = Request.QueryString["BillNo"].Trim();

            if (VendorID != "") { txtVendorNM.Text = fn.GetVendor(VendorID); } else { txtVendorNM.Text = ""; }
            Bind_GV_RemoldBill();
            CreateToken();
        }
    }

    /// <summary>
    /// bind grid
    /// </summary>
    public void Bind_GV_RemoldBill()
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        CTIM.VendorCode = VendorID.Trim();
        CTIM.BILL_NO = BillNo.Trim();
        CTIM.GetRemoldBill_List(GV_RemoldBill, FromDT, ToDT);
    }

    protected void RowDataBound_GV_RemoldBill(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            ////TextBox txtTotal = (TextBox)(GV_RemoldBill.FooterRow.FindControl("txtTotal"));

            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            TextBox txtPaidAmt = (TextBox)e.Row.FindControl("txtPaidAmt");
            TextBox txtPendingAmt = (TextBox)e.Row.FindControl("txtPendingAmt");
            TextBox txtTotAmt = (TextBox)e.Row.FindControl("txtTotAmt");
            TextBox txtCurrentAmt = (TextBox)e.Row.FindControl("txtCurrentAmt");
            HiddenField Advpaid = (HiddenField)e.Row.FindControl("Advpaid");
            HiddenField pendingamt = (HiddenField)e.Row.FindControl("pendingamt");
            HiddenField hdfVENDORCODE = (HiddenField)e.Row.FindControl("hdfVENDORCODE");
            HiddenField hdfVendorNM = (HiddenField)e.Row.FindControl("hdfVendorNM");
            HiddenField hdfVendorPAN = (HiddenField)e.Row.FindControl("hdfVendorPAN");

            HiddenField vendorcode = (HiddenField)e.Row.FindControl("vendorcode");
            HiddenField vendorname = (HiddenField)e.Row.FindControl("vendorname");
            HiddenField Acccode = (HiddenField)e.Row.FindControl("Acccode");

            //vendorCode = vendorcode.Value.ToString();
            //VendorName = vendorname.Value.ToString();
            effected_acccode = Acccode.Value.ToString();

            txtVendorPan_No.Text = hdfVendorPAN.Value;
            txtVendorNM.Text = hdfVENDORCODE.Value + "~" + hdfVendorNM.Value;
            hdfVendorCD.Value = hdfVENDORCODE.Value;
            hdfVendorName.Value = hdfVendorNM.Value;

            //txtCurrentAmt.Attributes.Add("OnBlur", "javascript:calulatePendingAmt(" + e.Row.RowIndex + "," + txtPaidAmt.ClientID.ToString() + "," + txtPendingAmt.ClientID.ToString() + "," + txtCurrentAmt.ClientID.ToString() + ");");
            txtCurrentAmt.Attributes.Add("OnBlur", "javascript:return calulatePendingAmt()");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {
                string voucherNo = "";
                Boolean IsCommit = false;

                string Vbrcd = SessionUtilities.CurrentBranchCode.ToString();
                voucherNo = fn.NextVoucherno(Vbrcd, Financial_Year);
                string billbumber = "0", netamount = "0", pendingamount = "0", currentpayment = "0";
                double totnetamount, totcurrentpay, totpaid, pending;
                string mdlsttranstype = "";
                string mddrCashcode = "";
                string mddrBankaccode = "";
                string mtxtChqNo = "";
                string mtxtChqDate = "";


                string acccode1 = "";
                string[] pbov_arr;
                //string PBOV_code = vendorCode;
                //string PBOV_Name = VendorName;
                string PBOV_code = "";
                string PBOV_Name = "";
                string PBOV_typ = "V";

                string servicetaxNo = "";
                string DocNo = "", chequeDt = "";
                string Docsf = "";
                string bookcode = "VENDOR BILL";
                string BANKNAME = "";
                string TRANSMODE = "";
                string tdsacccode = "";
                string svctaxacccode = "";
                string chqno2 = "Null";
                string chqdate2 = "Null";
                string finyear1 = System.DateTime.Today.ToString("yyyy");

                cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());

                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                SqlTransaction trn;
                trn = conn.BeginTransaction();

                CTIM.VOUCHER_NO = voucherNo;
                CTIM.VOUCHER_DT = txtVoucherDate.Text.Trim();
                CTIM.VOUCHER_AMT = Convert.ToDouble(hdf_TotalAmt.Value.Trim());
                string Transdate = fn.Mydate1(txtVoucherDate.Text);

                //-----------------------------------------------------

                UserControls_Webx_PaymentControl payment = (UserControls_Webx_PaymentControl)UCMyPaymentControl1;

                DropDownList ddlPayMode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddlPayMode");
                TextBox txtCashAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtCashAmt");
                DropDownList ddrCashcode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrCashcode");
                TextBox txtChqAmt = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqAmt");
                TextBox txtChqNo = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqNo");
                DropDownList ddrBankaccode = (DropDownList)this.UCMyPaymentControl1.FindControl("ddrBankaccode");
                TextBox txtChqDate = (TextBox)this.UCMyPaymentControl1.FindControl("txtChqDate");
                TextBox txtNetPay = (TextBox)this.UCMyPaymentControl1.FindControl("txtNetPay");


                ////UserControls_MyPaymentControl paymen = (UserControls_MyPaymentControl)UCMyPaymentControl1;
                ////DropDownList dlsttranstype = (DropDownList)paymen.FindControl("ddlPayMode");
                ////DropDownList ddrCashcode = (DropDownList)paymen.FindControl("ddrCashcode");
                ////DropDownList ddrBankaccode = (DropDownList)paymen.FindControl("ddrBankaccode");

                ////TextBox txtCashAmt = (TextBox)paymen.FindControl("txtCashAmt");
                ////TextBox txtChqAmt = (TextBox)paymen.FindControl("txtChqAmt");

                ////TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
                ////TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");

                //TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
                //TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");

                mdlsttranstype = ddlPayMode.SelectedValue.Trim();//dlsttranstype.SelectedValue;

                /*if (mdlsttranstype == "" || mdlsttranstype == null)
                {
                    mdlsttranstype = "NULL";
                }
                else
                {
                    mdlsttranstype = "'" + mdlsttranstype + "'";
                }*/
                mddrCashcode = ddrCashcode.SelectedValue;
                /*if (mddrCashcode == "" || mddrCashcode == null)
                {
                    mddrCashcode = "NULL";
           
                }
                else
                {
                    mddrCashcode = "'" + mddrCashcode + "'";
            
                }*/
                mddrBankaccode = ddrBankaccode.SelectedValue;
                /*if (mddrBankaccode == "" || mddrBankaccode == null)
                {
                    mddrBankaccode = "NULL";
                    accountcode = mddrBankaccode;
                }
                else
                {
                    mddrBankaccode = "'" + mddrBankaccode + "'";
                    accountcode = mddrBankaccode;
                }*/

                //if (dlsttranstype.SelectedValue == "Cash")
                if (ddlPayMode.SelectedValue == "Cash")
                {
                    //mtxtCashAmt = Convert.ToString(txtNetPay.Text);
                    accountcode = mddrCashcode;
                }
                /*else if (dlsttranstype.SelectedValue == "Both")
                {
                    mtxtCashAmt = txtCashAmt.Text;
                }
                else
                {
                    mtxtCashAmt = "";
                }*/

                /* if (mtxtCashAmt == "" || mtxtCashAmt == null)
                 {
                     mtxtCashAmt = "NULL";
                 }*/

                //if (dlsttranstype.SelectedValue == "Bank")
                if (ddlPayMode.SelectedValue == "Bank")
                {
                    //mtxtChqAmt = Convert.ToString(txtNetPay.Text);
                    accountcode = mddrBankaccode;
                }
                /*else if (dlsttranstype.SelectedValue == "Both")
                {
                    mtxtChqAmt = txtChqAmt.Text;
                }
                else
                {
                    mtxtChqAmt = "";
                }
                if (mtxtChqAmt == "" || mtxtChqAmt == null)
                {
                    mtxtChqAmt = "NULL";
                }*/
                mtxtChqNo = txtChqNo.Text;

                /*if (mtxtChqNo == "" || mtxtChqNo == null)
                {
                    mtxtChqNo = "NULL";
                }
                else
                {
                    mtxtChqNo = "'" + mtxtChqNo + "'";
                }
                */
                mtxtChqDate = txtChqDate.Text;
                /*if (mtxtChqDate == "" || mtxtChqDate == null)
                {
                    mtxtChqDate = "NULL";
                }
                else
                {
                    mtxtChqDate = "'" + mtxtChqDate + "'";
                }*/
                /*mtxtAmtApplA = txtAmtApplA.Text;
                if (mtxtAmtApplA == "" || mtxtAmtApplA == null)
                {
                    mtxtAmtApplA = "NULL";
                }
                mtxtNetPay = txtNetPay.Text;
                if (mtxtNetPay == "" || mtxtNetPay == null)
                {
                    mtxtNetPay = "NULL";
                }*/


                //--------------------------------------
                foreach (GridViewRow gridrow in GV_RemoldBill.Rows)
                {
                    CheckBox chkSelect = (CheckBox)gridrow.FindControl("chkSelect");

                    HiddenField hdfBILLNO = (HiddenField)gridrow.FindControl("hdfBILLNO");
                    HiddenField pendingamt = (HiddenField)gridrow.FindControl("pendingamt");

                    TextBox txtBillNo = (TextBox)gridrow.FindControl("txtBillNo");
                    TextBox txtBillDT = (TextBox)gridrow.FindControl("txtBillDT");
                    TextBox txtBillAmt = (TextBox)gridrow.FindControl("txtBillAmt");
                    TextBox txtPaidAmt = (TextBox)gridrow.FindControl("txtPaidAmt");
                    TextBox txtPendingAmt = (TextBox)gridrow.FindControl("txtPendingAmt");
                    TextBox txtTotAmt = (TextBox)gridrow.FindControl("txtTotAmt");
                    TextBox txtCurrentAmt = (TextBox)gridrow.FindControl("txtCurrentAmt");
                    //TextBox txtTotal = (TextBox)gridrow.FindControl("txtTotal");
                    TextBox txtTotal = (TextBox)(GV_RemoldBill.FooterRow.FindControl("txtTotal"));

                    HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
                    HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
                    HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");


                    if (chkSelect.Checked == true)
                    {
                        CTIM.TYRE_ID = "";
                        CTIM.CLAIM_REMOLD_SALE_ID = "";
                        CTIM.BILL_NO = txtBillNo.Text;


                        billbumber = txtBillNo.Text;
                        netamount = txtTotAmt.Text;
                        pendingamount = txtPendingAmt.Text;
                        currentpayment = txtCurrentAmt.Text;

                        if (txtBillAmt.Text == "") { CTIM.BILL_AMT = 0; } else { CTIM.BILL_AMT = Convert.ToDouble(txtBillAmt.Text); }
                        if (txtPaidAmt.Text == "") { CTIM.PAID_AMT = 0; } else { CTIM.PAID_AMT = Convert.ToDouble(txtPaidAmt.Text); }

                        if (txtPendingAmt.Text == "") { CTIM.PENDING_AMT = 0; } else { CTIM.PENDING_AMT = Convert.ToDouble(txtPendingAmt.Text); }
                        if (txtCurrentAmt.Text == "") { CTIM.CURRENT_AMT = 0; } else { CTIM.CURRENT_AMT = Convert.ToDouble(txtCurrentAmt.Text); }
                        if (hdf_TotalAmt.Value == "") { CTIM.NetPay = 0; }
                        else
                        {
                            CTIM.NetPay = Convert.ToDouble(hdf_TotalAmt.Value);//txtTotal
                        }

                        CTIM.VendorCode = hdfVendorCD.Value.Trim();
                        CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.Trim();
                        CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();

                        //INSERT INTO [WEBX_VENDORBILL_PAYDET] 
                        //if(pendingamt==currentAmt){
                        //update WEBX_vendorbill_hdr
                        //update WEBX_vendorbill_det}

                        //else { update WEBX_vendorbill_hdr }
                        //Insert into webx_vouchertrans
                        //Insert into webx_vouchertrans_arch
                        //delete from webx_vouchertrans
                        //usp_Vendor_Payment_transaction_other

                        ////CTIM.UpdateRemold_BillPayment();
                        effected_acccode = Acccode.Value;

                        //updated by vidya on 20 may 2014
                        debit = 0;
                        totcurrentpay = Convert.ToDouble(netamount) - Convert.ToDouble(pendingamount);
                        totpaid = Convert.ToDouble(currentpayment);

                        credit = credit + totpaid;
                        transtype1 = mdlsttranstype;

                        servicetaxrate = 0;
                        OCTPaid = 0;
                        AgentServiceChrg = 0;
                        ServiceChargPaid = 0;
                        TotalDed = 0;
                        TotChrg = 0;
                        CHQAMT = 0;
                        DEDUCTION = 0;
                        othChrg = 0;
                        tdsrate = 0;
                        servicetaxCharged = 0;
                        Currbalance = 0;
                        mamul_chrg = 0;
                        //-------------------------
                        string SQL_Insert = "INSERT INTO [WEBX_VENDORBILL_PAYDET] SELECT [BILLNO],[BILLSF],[BRCD],[BILLDT],[VENDORCODE],[VENDORNAME],[VENDORBILLDT],[VENDORBILLNO],[DUEDT],[PAYDT],'" + voucherNo + "',[NETAMT]," + currentpayment + "," + pendingamount + " ,'' FROM  WEBX_vendorbill_hdr WHERE BILLNO='" + txtBillNo.Text + "'";
                        SqlCommand sqlcmd = new SqlCommand(SQL_Insert, conn, trn);
                        sqlcmd.ExecuteNonQuery();
                        if (pendingamt.Value == txtCurrentAmt.Text)
                        {

                            string sql_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + txtCurrentAmt.Text + ",finclosedt='" + Transdate + "',voucherNo='" + voucherNo + "',PAYDT='" + Transdate + "' where BillNo='" + txtBillNo.Text + "'";

                            SqlCommand sqlcmd1 = new SqlCommand(sql_hdr, conn, trn);
                            sqlcmd1.ExecuteNonQuery();

                            string sql_detail = "update WEBX_vendorbill_det set voucherNo='" + voucherNo + "',PAYDT='" + Transdate + "' where BillNo='" + txtBillNo.Text + "'";

                            SqlCommand sqlcmd2 = new SqlCommand(sql_detail, conn, trn);
                            sqlcmd2.ExecuteNonQuery();
                        }
                        else
                        {
                            //string sqlvendorbill_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt=getdate(),voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                            string sqlvendorbill_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + txtCurrentAmt.Text + ",finclosedt= '" + Transdate + "',voucherNo='" + voucherNo + "',PAYDT= '" + Transdate + "' where BillNo='" + txtBillNo.Text + "'";

                            SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn, trn);
                            sqlcmd5.ExecuteNonQuery();
                        }
                    }
                }

                PBOV_code = hdfVendorCD.Value;
                PBOV_Name = hdfVendorName.Value;

                chequeDt = mtxtChqDate.ToString();
                string[] strArrChequeDtFrom = chequeDt.Split('/');
                string dtCheque = Convert.ToDateTime(strArrChequeDtFrom[1] + "/" + strArrChequeDtFrom[0] + "/" + strArrChequeDtFrom[2]).ToString("dd MMM yy");

                string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry,acccode) values (" + finyear1 + ",'" + Transdate + "','" + voucherNo + "','" + accountcode + "','" + acccode1 + "','" + mtxtChqNo + "','" + dtCheque + "'," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'" + DocNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + SessionUtilities.CurrentBranchCode.ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + credit + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + Panno1 + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + CHQAMT + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y','" + effected_acccode + "')";

                //string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry) values (" + finyear1 + ",'" + Transdate + "','" + voucherNo + "','" + accountcode + "','" + acccode1 + "','" + Chqno11 + "','" + chequeDt + "'," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'" + DocNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + SessionUtilities.CurrentBranchCode.ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + credit + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + Panno1 + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + CHQAMT + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y')";
                SqlCommand sqlCommand_Trnas = new SqlCommand(sql_VTrans, conn, trn);
                sqlCommand_Trnas.ExecuteNonQuery();

                string sql_TransArch = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + voucherNo + "'";
                SqlCommand sqlCommand_TrnasArch = new SqlCommand(sql_TransArch, conn, trn);
                sqlCommand_TrnasArch.ExecuteNonQuery();

                string sql_VTrans_delete = "delete from webx_vouchertrans where voucherNo='" + voucherNo + "'";
                SqlCommand sqlCommand_TrnasDelete = new SqlCommand(sql_VTrans_delete, conn, trn);
                sqlCommand_TrnasDelete.ExecuteNonQuery();
                //transaction no 5 for remold tyre bill payment

                //string sql_voucher_act = "exec usp_Vendor_Payment_transaction_other 5,'" + voucherNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Financial_Year + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + voucherNo + "','" + SessionUtilities.DefaultCompanyCode.Trim() + "'";
                string sql_voucher_act = "exec usp_Vendor_Payment_transaction_other 5,'" + voucherNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Financial_Year + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + voucherNo + "'";
                SqlCommand Acct_cmd = new SqlCommand(sql_voucher_act, conn, trn);
                Acct_cmd.ExecuteNonQuery();
                trn.Commit();
                IsCommit = true;
                //trn.Rollback();
                conn.Close();

                if (IsCommit == true)
                {
                    //Response.Redirect("RemoldBillPayment_Msg.aspx?VOUCHER_NO=" + voucherNo);
                    //updated by vidya on 17 Jan 2014
                    Response.Redirect("RemoldBillPayment_Msg.aspx?VoucherNo=" + voucherNo + "&VoucherDT=" + txtVoucherDate.Text.Trim() + "&MODE=" + ddlPayMode.SelectedValue.Trim() + "&chequeNo=" + txtChqNo.Text + "&chequeDT=" + txtChqDate.Text + "&Amount=" + txtNetPay.Text);
                }
            }
        }
        catch (Exception ex)
        {
           ex.Message.ToString();
        }

    }

}