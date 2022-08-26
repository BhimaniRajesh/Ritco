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

public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_vendorpayvoucher_Step2 : System.Web.UI.Page
{
    public static string transtype1, Chqno11, chqdt11, CHQAMT1;
    string doc, vendor, from, to, PBOV_code, PBOV_Name;
    string strDateRange;
    string acccode2;
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
    public string vendorCode;
    public double debit, credit;
    public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
    public string[] VehicleArray, DocumentArray, VendorBillArray;

    protected void Page_Load(object sender, EventArgs e)
    {
        strsession1 = Session["brcd"].ToString();
        strsession2 = Session["empcd"].ToString();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        if (!IsPostBack)
        {
            strsession2 = Session["brcd"].ToString();
            fromdt = Request.QueryString["dtFrom"];
           // fromdt = f.ToString("dd/MM/yyyy");
            fromdt = fn.Mydate(fromdt);
            //t = Convert.ToDateTime(Request.QueryString["dtTo"]);
            todt = Request.QueryString["dtTo"];
            Todt = Request.QueryString["dtTo"];
            Fromdt = Request.QueryString["dtFrom"];
            todt = fn.Mydate(todt);
           
            
            lblAgentBillDate.Text = fromdt + " - " + todt;
            DocumentNo =Convert.ToString(Request.QueryString["DocumentNo"]);
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

        string sql = "select acccode+'~'+acccategory+'~'+accdesc as accdval,accdesc,acccategory from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) ";

        SqlCommand sqlCommand = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds, "tab1");

        acccode.DataSource = ds;
        acccode.DataTextField = "accdesc";
        acccode.DataValueField = "accdval";
        acccode.DataBind();
        acccode.CssClass = "blackfnt";
        transtype.CssClass = "blackfnt";
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
           // SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)";
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and isnull(pendamt,0)>0 and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and BRCD='" + Session["BRCD"].ToString() + "'";
            //Response.Write("SqlDisplay-" + SqlDisplay);
            //Response.End();
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
            //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VendorBillNo in (" + s2 + ")";
            //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0 and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VendorBillNo in (" + s2 + ")";
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0 and VendorBillNo in (" + s2 + ") and BRCD='" + Session["BRCD"].ToString() + "'";
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
            //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and BILLNO in (" + s2 + ")";
            //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0  and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and BILLNO in (" + s2 + ")";
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0  and BILLNO in (" + s2 + ") and BRCD='" + Session["BRCD"].ToString() + "'";
            //Response.Write("SqlDisplay-" + SqlDisplay);
            //Response.End();
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }
        else if (vendorCode!="0")
        {
            lblVendor1.Text = fn.GetVendor(vendorCode);
            //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is null and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VENDORCODE='" + vendorCode + "'";
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0 and BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VENDORCODE='" + vendorCode + "' and BRCD='" + Session["BRCD"].ToString() + "'";
            //SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0 and VENDORCODE='" + vendorCode + "'";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            //Response.Write("SqlDisplay-" + SqlDisplay);
            //Response.End();
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

        

        SqlTransaction trn;
        trn = conn.BeginTransaction();
        string acccode1 = acccode.SelectedItem.ToString();
        acccode2 = acccode.SelectedValue.ToString();
        
        string PBOV_typ = "";
        string servicetaxNo = "";
        string DocNo = "";
        string Docsf = "";
        string bookcode = "VENDOR BILL";
        string BANKNAME = "";
        string TRANSMODE = "";
        string tdsacccode = "";
        string svctaxacccode = "";
        string chqno2 = "Null";
        string chqdate2 = "Null";
                   
        string finyear1 = System.DateTime.Today.ToString("yy");
        string Transdate = fn.Mydate1(txtVoucherDt.Text);
        string acc = acccode.SelectedValue.ToString();
        accountcode1 = acc.Split('~');
        accountcode = accountcode1[0].ToString();


        string billbumber = "0", netamount = "0", pendingamount = "0", currentpayment = "0";
        try
        {
            string Vbrcd = Session["brcd"].ToString();
            voucherNo = fn.NextVoucherno(Vbrcd, Financial_Year);
            foreach (GridViewRow gridrow in BillDetail.Rows)
            {
                CheckBox chkBill1 = (CheckBox)gridrow.FindControl("chkBill");
                Label BILLNO1 = (Label)gridrow.FindControl("BILLNO");
                Label netamt1 = (Label)gridrow.FindControl("netamt");
                Label pendamt1 = (Label)gridrow.FindControl("pendamt");
                HiddenField pendingamt = (HiddenField)gridrow.FindControl("pendingamt");
                TextBox txtCurrPayment1 = (TextBox)gridrow.FindControl("txtCurrPayment");
                Label lblvendor_code = (Label)gridrow.FindControl("lblvendor_code");
                if (lblvendor_code.Text != "")
                {
                    PBOV_code = lblvendor_code.Text;
                    PBOV_Name = fn.GetVendor(PBOV_code);
                }

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
                    transtype1 = transtype.SelectedItem.ToString();
                    
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

                    if (transtype1 == "Cheque" || transtype1 == "Bank")
                    {
                        string Cnt = VendorPayment_Utility.Duplicate_ChqNO(chqno.Text, fn.Mydate1(chqdate.Text));
                        if (Cnt == "F")
                        {
                            string ErrorMsg1 = "Duplicate Cheque Entered";
                            Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
                        }
                    }
                    else
                    {
                        string Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(colamt.Text), fn.Mydate(txtVoucherDt.Text));
                        if (Cnt == "F")
                        {
                            string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                            Response.Redirect("../../../../ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                        }
                    }
                    string SQL_Insert = "INSERT INTO [WEBX_VENDORBILL_PAYDET] SELECT [BILLNO],[BILLSF],[BRCD],[BILLDT],[VENDORCODE],[VENDORNAME],[VENDORBILLDT],[VENDORBILLNO],[DUEDT],[PAYDT],'" + voucherNo + "',[NETAMT]," + currentpayment + "," + pendingamount + ",''  FROM  WEBX_vendorbill_hdr WHERE BILLNO='" + billbumber + "'";
                    SqlCommand sqlcmd = new SqlCommand(SQL_Insert, conn, trn);
                    sqlcmd.ExecuteNonQuery();
                    // Response.Write("<br>pendingamount-" + pendingamt.Value);
                    // Response.Write("<br>currnet amrt -" + txtCurrPayment1.Text);
                    //Response.End();

                    string SQL_UpdateNew = "update WEBX_VENDORBILL_PAYDET set NETAMT = (isNULL(Paidamt,0)+ isNULL(pendamt,0)) WHERE BILLNO='" + billbumber + "' and VoucherNo='" + voucherNo + "'";
                    sqlcmd = new SqlCommand(SQL_UpdateNew, conn, trn);
                    sqlcmd.ExecuteNonQuery();

                    if (pendingamt.Value == txtCurrPayment1.Text)
                    {
                        string sql_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt=getdate(),voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                        SqlCommand sqlcmd1 = new SqlCommand(sql_hdr, conn,trn);
                        sqlcmd1.ExecuteNonQuery();

                        string sql_detail = "update WEBX_vendorbill_det set voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                        SqlCommand sqlcmd2 = new SqlCommand(sql_detail, conn, trn);
                        sqlcmd2.ExecuteNonQuery();

                        string sql_thc_summary = "update WEBX_thc_summary set PaymentDt=getdate(),balvoucherNo='" + voucherNo + "',balvoucherdt=getdate() where vendorBENo='" + billbumber + "'";
                        SqlCommand sqlcmd3 = new SqlCommand(sql_thc_summary, conn, trn);
                        sqlcmd3.ExecuteNonQuery();

                        string sql_arch = "update WEBX_pdchdr set PaymentDt=getdate(),bal_voucherNo='" + voucherNo + "',bal_voucherdt=getdate() where vendorBENo='" + billbumber + "'";
                        SqlCommand sqlcmd4 = new SqlCommand(sql_arch, conn, trn);
                        sqlcmd4.ExecuteNonQuery();

                        sql_arch = "update WEBX_pdchdr set PaymentDt=getdate(),bal_voucherNo='" + voucherNo + "',bal_voucherdt=getdate() where vendorBENo='" + billbumber + "'";
                        sqlcmd4 = new SqlCommand(sql_arch, conn, trn);
                        sqlcmd4.ExecuteNonQuery();
                    }

                    else
                    {
                        string sqlvendorbill_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt=getdate(),voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                        SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn,trn);
                        sqlcmd5.ExecuteNonQuery();
                    }

                }
                else
                {

                }


            }
            string banknm = "";
            string ptmsptcd = "";
            string ptmsptnm = "";
            string adjustamt = "", chequeDt = "";
            string comments = "NULL";
            string bacd = "null";
            string banm = "null";
            string empnm = "null";
            string staffcd = "Null";
            string staffnm = "Null";
            string branch = Session["brcd"].ToString();
            string branchname = fn.GetLocation(Session["brcd"].ToString());
            string acccodedec = acccode.SelectedItem.ToString();
            if (transtype1 == "Cheque")
            {
                string depositdt = System.DateTime.Today.ToString("dd MMM yyyy");
                CHQAMT1 = colamt.Text;
                Chqno11 = chqno.Text;
                chqdt11 = chqdate.Text;
                // DateTime chequeDate = Convert.ToDateTime(chqdt11);
                 chequeDt = fn.Mydate(chqdt11);
                //DateTime chequeDate = Convert.ToDateTime(chqdt11).GetDateTimeFormats("dd MMM yyyy");



                string sql_chqdet = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt,Transtype,transdate,acccode,depoloccode,DepoFlag,voucherNo) values('" + Chqno11 + "','" + chequeDt + "'," + CHQAMT1 + ",'" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','" + comments + "','" + bacd + "','" + banm + "','" + Session["empcd"].ToString() + "','','" + Session["brcd"].ToString() + "','" + "" + "','" + staffcd + "','" + staffnm + "',null,'O','" + "" + "','" + adjustamt + "','Bank Payment','" + depositdt + "','" + accountcode + "','" + Session["brcd"].ToString() + "','Y','" + voucherNo + "')";
                SqlCommand sqlCommand_Cheque = new SqlCommand(sql_chqdet, conn, trn);
                sqlCommand_Cheque.ExecuteNonQuery();

                //string sql_cheque_update = "update webx_chq_det set voucherNo='" + voucherNo + "',transdate='" + depositdt + "',acccode='" + accountcode + "',depoloccode='" + Session["brcd"].ToString() + "',DepoFlag='Y' where chqno='" + Chqno11 + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chequeDt + "',106)";
                //SqlCommand sqlCommand_Cheq_Update = new SqlCommand(sql_cheque_update, conn, trn);
                //sqlCommand_Cheq_Update.ExecuteNonQuery();
            }


            string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry) values (" + finyear1 + ",'" + Transdate + "','" + voucherNo + "','" + accountcode + "','" + acccode1 + "','" + Chqno11 + "','" + chequeDt + "'," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'" + DocNo + "','" + Session["brcd"].ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + Session["empcd"].ToString() + "','" + Session["brcd"].ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + credit + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + Panno1 + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + CHQAMT + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y')";
            SqlCommand sqlCommand_Trnas = new SqlCommand(sql_VTrans, conn, trn);
            sqlCommand_Trnas.ExecuteNonQuery();

            string sql_TransArch = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + voucherNo + "'";
            SqlCommand sqlCommand_TrnasArch = new SqlCommand(sql_TransArch, conn, trn);
            sqlCommand_TrnasArch.ExecuteNonQuery();

            string sql_VTrans_delete = "delete from webx_vouchertrans where voucherNo='" + voucherNo + "'";
            SqlCommand sqlCommand_TrnasDelete = new SqlCommand(sql_VTrans_delete, conn, trn);
            sqlCommand_TrnasDelete.ExecuteNonQuery();


            string sql_voucher_act = "exec usp_Vendor_Payment_transaction 4,'" + voucherNo + "','" + Session["brcd"].ToString() + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + voucherNo + "'";
            SqlCommand Acct_cmd = new SqlCommand(sql_voucher_act, conn, trn);
            //Response.Write("<br>" + sql_voucher_act);
            //Response.End();
            Acct_cmd.ExecuteNonQuery();
            trn.Commit();
            conn.Close();
            string final;
            final = "?VoucherNo=" + voucherNo;
            final += "&VoucherDT=" + txtVoucherDt.Text;
            final += "&MODE=" + transtype1;
            final += "&chequeNo=" + Chqno11;
            final += "&chequeDT=" + chqdt11;
            final += "&Amount=" + colamt.Text;
            final += "&PayACC=" + acccode.SelectedValue.ToString();
            Response.Redirect("VendorPaymentVoucher_Done.aspx" + final);
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
    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (transtype.SelectedValue.ToString() != "")
        {
          
            string sql = "";

            if (transtype.SelectedValue.ToString() != "Cash")
            {
                sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) ";
            }
            else
            {
                sql = "select  acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            }
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds, "tab1");

            acccode.DataSource = ds;
            acccode.DataTextField = "accdesc";
            acccode.DataValueField = "asscodeval";
            acccode.DataBind();
            acccode.CssClass = "blackfnt";
        }
    }
}
