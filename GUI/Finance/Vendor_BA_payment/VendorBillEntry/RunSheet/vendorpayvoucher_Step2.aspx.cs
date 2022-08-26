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

public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_RunSheet_vendorpayvoucher_Step2 : System.Web.UI.Page
{
    string doc, vendor, from, to;
    string strDateRange;
    public string voucherNo, Panno1, accountcode, SqlDisplay = "", s2 = "";
    public string VendorBill, VehicleNo, DocumentNo;
    public string[] accountcode1;
    public static string strsession1, strsession2;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    string fromdt, todt;
    int i;
    MyFunctions fn = new MyFunctions();
    public static int intCurrentPageNo, intTotalRecords = 0;
    static int intPageSize = 10;
    public string vendorCode;
    public double debit, credit;
    public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
    public string[] VehicleArray, DocumentArray, VendorBillArray;

    protected void Page_Load(object sender, EventArgs e)
    {
        strsession1 = Session["brcd"].ToString();
        strsession2 = Session["empcd"].ToString();

        if (!IsPostBack)
        {
            strsession2 = Session["brcd"].ToString();
            fromdt = Request.QueryString["dtFrom"];
            // fromdt = f.ToString("dd/MM/yyyy");
            fromdt = fn.Mydate(fromdt);
            //t = Convert.ToDateTime(Request.QueryString["dtTo"]);
            todt = Request.QueryString["dtTo"];
            todt = fn.Mydate(todt);

            lblAgentBillDate.Text = fromdt + " - " + todt;
            DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
            VendorBill = Convert.ToString(Request.QueryString["VendorBill"]);
            VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
            vendorCode = Convert.ToString(Request.QueryString["vendor"]);

            lblVendor.Text = fn.GetVendor(vendorCode);
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            txtVoucherDt.Text = strrightnow;

            DisplayVendorBilllist();
            PopPaymentAcc();

            foreach (GridViewRow gridrow in BillDetail.Rows)
            {
                TextBox txtCurrPayment1 = (TextBox)gridrow.FindControl("txtCurrPayment");
                TextBox txtTotal1 = (TextBox)gridrow.FindControl("txtTotal");

                txtCurrPayment1.Text = "0";

            }

            string js = "<script language=\"javascript\" type=\"text/javascript\">var i = 2; var count= document.getElementById(\"ctl00_MyCPH1_BillDetail\").rows.length; for(i=2;i<count;i++) { if(i<=9){document.getElementById(\"ctl00_MyCPH1_BillDetail_ctl0\" + i + \"_txtCurrPayment\").disabled = true;}else{document.getElementById(\"ctl00_MyCPH1_BillDetail_ctl\" + i + \"_txtCurrPayment\").disabled = true;}}</script>";
            Page.RegisterStartupScript("abc", js);

        }

        btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit()");
    }
    private void PopPaymentAcc()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select acccode+'~'+acccategory+'~'+accdesc as accdval,accdesc,acccategory from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or bkloccode like '" + strsession2 + "%') AND acccategory='BANK'))";

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds, "tab1");

        acccode.DataSource = ds;
        acccode.DataTextField = "accdesc";
        acccode.DataValueField = "accdval";
        acccode.DataBind();

    }

    private void DisplayVendorBilllist()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (VehicleNo != "")
        {
            lblVendor.Text = "-";
            lblServiceTaxNo.Text = "-";
            lblVendor1.Text = "-";

            VehicleArray = VehicleNo.Split(',');

            for (i = 0; i < VehicleArray.Length; i++)
            {
                s2 += "'" + VehicleArray[i] + "',";
            }

            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }
        else if (VendorBill != "")
        {
            lblVendor.Text = "-";
            lblServiceTaxNo.Text = "-";
            lblVendor1.Text = "-";

            VendorBillArray = VendorBill.Split(',');

            for (i = 0; i < VendorBillArray.Length; i++)
            {
                s2 += "'" + VendorBillArray[i] + "',";
            }

            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VendorBillNo in (" + s2 + ")";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }
        else if (DocumentNo != "")
        {
            lblVendor.Text = "-";
            lblServiceTaxNo.Text = "-";
            lblVendor1.Text = "-";
            DocumentArray = DocumentNo.Split(',');

            for (i = 0; i < DocumentArray.Length; i++)
            {
                s2 += "'" + DocumentArray[i] + "',";
            }

            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and BILLNO in (" + s2 + ")";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }
        else if (vendorCode != "0")
        {
            lblVendor1.Text = fn.GetVendor(vendorCode);
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VENDORCODE='" + vendorCode + "'";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }

    }

    protected void BillDetail_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int no = e.Row.RowIndex + 2;
            String a, b, c, d, m;
            if (no < 10)
            {
                Label l1 = (Label)e.Row.FindControl("netamt");
                a = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_netamt'";

                Label l2 = (Label)e.Row.FindControl("pendamt");
                b = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_pendamt'";

                TextBox txtCurrPayment1 = (TextBox)e.Row.FindControl("txtCurrPayment");
                c = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_txtCurrPayment'";

                CheckBox chkBill1 = (CheckBox)e.Row.FindControl("chkBill");
                d = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_chkBill'";

                //TextBox txttotal1 = (TextBox)e.Row.FindControl("txtTotal");
                //m = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_txtTotal'";

            }
            else
            {
                a = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_netamt'";
                b = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_pendamt'";
                c = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_txtCurrPayment'";
                d = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_chkBill'";
                //m = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_txtTotal'";

            }

            ((TextBox)(e.Row.FindControl("txtCurrPayment"))).Attributes.Add("onblur", "fvalidatePayAmt(" + a + "," + b + "," + c + "," + d + ")");
            ((CheckBox)(e.Row.FindControl("chkBill"))).Attributes.Add("onclick", "return calculation(" + a + "," + b + "," + c + "," + d + ")");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string finyear = System.DateTime.Today.ToString("yy");

        string sqlpanno = "select top 1 PAN_NO from webx_vendor_hdr where vendorcode='" + vendorCode + "'";
        SqlCommand cmd1 = new SqlCommand(sqlpanno, conn);
        SqlDataReader dr1;
        dr1 = cmd1.ExecuteReader();

        while (dr1.Read())
        {
            Panno1 = dr1["PAN_NO"].ToString();
        }
        dr1.Close();

        string s1 = "";

        string sqlvoucher = "usp_next_VoucherNo_M";
        SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        cmdvou.CommandType = CommandType.StoredProcedure;
        cmdvou.Parameters.AddWithValue("@brcd", strsession1);
        cmdvou.Parameters.AddWithValue("@finyear", finyear);
        cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        DataSet dsvou = new DataSet();
        davou.Fill(dsvou);

        foreach (DataRow dr in dsvou.Tables[0].Rows)
        {
            voucherNo = dr["vno"].ToString();
        }

        foreach (GridViewRow gridrow in BillDetail.Rows)
        {
            CheckBox chkBill1 = (CheckBox)gridrow.FindControl("chkBill");
            Label BILLNO1 = (Label)gridrow.FindControl("BILLNO");
            Label netamt1 = (Label)gridrow.FindControl("netamt");
            Label pendamt1 = (Label)gridrow.FindControl("pendamt");
            TextBox txtCurrPayment1 = (TextBox)gridrow.FindControl("txtCurrPayment");

            string billbumber, netamount, pendingamount, currentpayment;

            if (chkBill1.Checked == true)
            {
                billbumber = BILLNO1.Text;
                netamount = netamt1.Text;
                pendingamount = pendamt1.Text;
                currentpayment = txtCurrPayment1.Text;

                double totnetamount, totcurrentpay, totpaid, pending;

                if (pendingamount == "")
                {
                    pendingamount = "0";
                }
                else
                {
                    pendingamount = pendingamount;
                }
                totcurrentpay = Convert.ToDouble(netamount) - Convert.ToDouble(pendingamount);
                totpaid = Convert.ToDouble(currentpayment);

                debit = 0;
                credit = Convert.ToDouble(colamt.Text);
                string transtype1 = transtype.SelectedItem.ToString();
                string bookcode = "VENDOR BILL";
                string BANKNAME = "";
                string TRANSMODE = "";
                string tdsacccode = "";
                string svctaxacccode = "";
                string chqno2 = "Null";
                string chqdate2 = "Null";
                string finyear1 = System.DateTime.Today.ToString("yy");
                string Transdate = System.DateTime.Today.ToString("dd MMM yyyy");
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
                string acccode1 = acccode.SelectedItem.ToString();
                string PBOV_code = "";
                string PBOV_Name = "";
                string PBOV_typ = "";
                string servicetaxNo = "";
                string DocNo = "";
                string Docsf = "";

                string acc = acccode.SelectedValue.ToString();
                accountcode1 = acc.Split('~');
                accountcode = accountcode1[0].ToString();


                if (transtype1 == "Cheque" || transtype1 == "Bank")
                {
                    string Cnt = VendorPayment_Utility.Duplicate_ChqNO(chqno.Text, fn.Mydate1(chqdate.Text));
                    if (Cnt == "F")
                    {
                        string ErrorMsg1 = "Duplicate Cheque Entered";
                        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
                    }
                }


                string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry) values (" + finyear1 + ",'" + Transdate + "','" + voucherNo + "','" + accountcode + "','" + acccode1 + "'," + chqno2 + "," + chqdate2 + "," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'" + DocNo + "','" + Session["brcd"].ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + Session["empcd"].ToString() + "','" + Session["brcd"].ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + netamt1.Text + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + Panno1 + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + CHQAMT + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y')";
                SqlCommand sqlCommand_Trnas = new SqlCommand(sql_VTrans, conn);
                sqlCommand_Trnas.ExecuteNonQuery();

                string sql_TransArch = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + voucherNo + "'";
                SqlCommand sqlCommand_TrnasArch = new SqlCommand(sql_TransArch, conn);
                sqlCommand_TrnasArch.ExecuteNonQuery();

                string sql_VTrans_delete = "delete from webx_vouchertrans where voucherNo='" + voucherNo + "'";
                SqlCommand sqlCommand_TrnasDelete = new SqlCommand(sql_VTrans_delete, conn);
                sqlCommand_TrnasDelete.ExecuteNonQuery();

                if (transtype1 == "Cheque")
                {
                    string depositdt = System.DateTime.Today.ToString("dd MMM yyyy");
                    string CHQAMT1 = colamt.Text;
                    string Chqno11 = chqno.Text;
                    string chqdt11 = chqdate.Text;
                    DateTime chequeDate = Convert.ToDateTime(chqdt11);
                    string chequeDt = chequeDate.ToString("dd MMM yyyy");

                    string banknm = "";
                    string ptmsptcd = "";
                    string ptmsptnm = "";
                    string adjustamt = "";
                    string comments = "NULL";
                    string bacd = "null";
                    string banm = "null";
                    string empnm = "null";
                    string staffcd = "Null";
                    string staffnm = "Null";
                    string branch = Session["brcd"].ToString();
                    string branchname = fn.GetLocation(Session["brcd"].ToString());
                    string acccodedec = acccode.SelectedItem.ToString();

                    string sql_chqdet = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values('" + Chqno11 + "','" + chequeDt + "'," + CHQAMT1 + ",'" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','" + comments + "','" + bacd + "','" + banm + "','" + Session["empcd"].ToString() + "','','" + Session["brcd"].ToString() + "','" + "" + "','" + staffcd + "','" + staffnm + "',null,'O','" + "" + "','" + adjustamt + "')";
                    SqlCommand sqlCommand_Cheque = new SqlCommand(sql_chqdet, conn);
                    sqlCommand_Cheque.ExecuteNonQuery();

                    string sql_cheque_update = "update webx_chq_det set voucherNo='" + voucherNo + "',transdate='" + depositdt + "',acccode='" + accountcode + "',depoloccode='" + Session["brcd"].ToString() + "',DepoFlag='Y' where chqno='" + Chqno11 + "' and convert(varchar,chqdt,106)=convert(datetime," + chqdt11 + ",106)";
                    SqlCommand sqlCommand_Cheq_Update = new SqlCommand(sql_cheque_update, conn);
                    sqlCommand_Cheq_Update.ExecuteNonQuery();
                }


                string SQL_Insert = "INSERT INTO [WEBX_VENDORBILL_PAYDET] SELECT [BILLNO],[BILLSF],[BRCD],[BILLDT],[VENDORCODE],[VENDORNAME],[VENDORBILLDT],[VENDORBILLNO],[DUEDT],[PAYDT],'" + voucherNo + "',[NETAMT]," + currentpayment + "," + pendingamount + ",''  FROM  WEBX_vendorbill_hdr WHERE BILLNO='" + billbumber + "'";
                SqlCommand sqlcmd = new SqlCommand(SQL_Insert, conn);
                sqlcmd.ExecuteNonQuery();

                if (pendingamount == netamount)
                {
                    string sql_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt=getdate(),voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                    SqlCommand sqlcmd1 = new SqlCommand(sql_hdr, conn);
                    sqlcmd1.ExecuteNonQuery();

                    string sql_detail = "update WEBX_vendorbill_det set voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                    SqlCommand sqlcmd2 = new SqlCommand(sql_detail, conn);
                    sqlcmd2.ExecuteNonQuery();

                    string sql_thc_summary = "update WEBX_thc_summary set PaymentDt=getdate(),balvoucherNo='" + voucherNo + "',balvoucherdt=getdate() where vendorBENo='" + billbumber + "'";
                    SqlCommand sqlcmd3 = new SqlCommand(sql_thc_summary, conn);
                    sqlcmd3.ExecuteNonQuery();

                    string sql_arch = "update WEBX_pdchdr_arch set PaymentDt=getdate(),bal_voucherNo='" + voucherNo + "',bal_voucherdt=getdate() where vendorBENo='" + billbumber + "'";
                    SqlCommand sqlcmd4 = new SqlCommand(sql_arch, conn);
                    sqlcmd4.ExecuteNonQuery();

                }

                else
                {
                    string sqlvendorbill_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + " where BillNo='" + billbumber + "'";
                    SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn);
                    sqlcmd5.ExecuteNonQuery();
                }

            }
            else
            {

            }


        }

        string final;
        final = "?VoucherNo=" + voucherNo;
        Response.Redirect("VendorPaymentVoucher_Done.aspx" + final);
    }
}
