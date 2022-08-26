using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_PendingTHCAdvanceCheque : BasePage
{
    public static string transtype1, Chqno11, chqdt11, CHQAMT1;
    string doc, vendor, from, to;
    string strDateRange;
    public string Panno1, accountcode, SqlDisplay = "", s2 = "", PartyCode = "";
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
    public string vendorCode = "", VendorName = "", effected_acccode = "", Location = "";
    public double debit, credit;
    public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
    public string[] VehicleArray, DocumentArray, VendorBillArray;
    ThcInstallmentWiseAdvanceDataSet dsAdvanceCheque = new ThcInstallmentWiseAdvanceDataSet();
    DataSet ds1 = new DataSet();
    string srNoAdvanceCheque = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        strsession1 = SessionUtilities.CurrentBranchCode.ToString();
        strsession2 = SessionUtilities.CurrentEmployeeID.ToString();
        Financial_Year = SessionUtilities.FinYear.ToString().Substring(2, 2);
        if (!IsPostBack)
        {
	    CreateToken();
            //divAdvanceCheque.Visible = false;
            strsession2 = SessionUtilities.CurrentBranchCode.ToString();
            fromdt = Request.QueryString["dtFrom"];
            fromdt = fn.Mydate(fromdt);
            todt = Request.QueryString["dtTo"];
            Todt = Request.QueryString["dtTo"];
            Fromdt = Request.QueryString["dtFrom"];
            todt = fn.Mydate(todt);



            DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
            VendorBill = Convert.ToString(Request.QueryString["VendorBill"]);
            VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
            vendorCode = Convert.ToString(Request.QueryString["vendor"]);
            Location = Convert.ToString(Request.QueryString["Location"]);





            DisplayVendorBilllist();

            foreach (GridViewRow gridrow in BillDetail.Rows)
            {
                TextBox txtCurrPayment1 = (TextBox)gridrow.FindControl("txtCurrPayment");
                TextBox txtTotal1 = (TextBox)gridrow.FindControl("txtTotal");
                HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
                HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
                HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");
                txtCurrPayment1.Text = "0";

                vendorCode = vendorcode.Value.ToString();
                VendorName = vendorname.Value.ToString();
                effected_acccode = Acccode.Value.ToString();
            }

            string js = "<script language=\"javascript\" type=\"text/javascript\">var i = 2; var count= document.getElementById(\"ctl00_MyCPH1_BillDetail\").rows.length; for(i=2;i<count;i++) { if(i<=9){document.getElementById(\"ctl00_MyCPH1_BillDetail_ctl0\" + i + \"_txtCurrPayment\").disabled = true;}else{document.getElementById(\"ctl00_MyCPH1_BillDetail_ctl\" + i + \"_txtCurrPayment\").disabled = true;}}</script>";
            Page.RegisterStartupScript("abc", js);
            divAdvanceCheque.Visible = true;
            BlankRowAdvanceCheque("1");
            BindGridAdvanceCheque();

        }

        btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit()");//javascript:return CheckDocketSelection();
    }
    private void PopPaymentAcc()
    {

    }

    private void DisplayVendorBilllist()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (VehicleNo != "")
        {
            VehicleArray = VehicleNo.Split(',');
            for (i = 0; i < VehicleArray.Length; i++)
            {
                s2 += "'" + VehicleArray[i] + "',";
            }
            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode,ts.vehno,ts.ManualTHCNo from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno INNER JOIN ViewWebXThcChequeInstallmentPendingCount CI ON Ci.thcno=ts.thcno  where  isnull(h.pendamount,0)>0 and h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)";
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

            VendorBillArray = VendorBill.Split(',');

            for (i = 0; i < VendorBillArray.Length; i++)
            {
                s2 += "'" + VendorBillArray[i] + "',";
                doc += VendorBillArray[i] + ",";
            }

            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode,ts.vehno,ts.ManualTHCNo from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0  and h.BILLDT in (" + s2 + ")";//and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)

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
            DocumentArray = DocumentNo.Split(',');
            string doc = "";
            for (i = 0; i < DocumentArray.Length; i++)
            {
                s2 += "'" + DocumentArray[i] + "',";
                doc += DocumentArray[i] + ",";
            }
            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select '' as VendorBill_DT , '' as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,'' as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ts.thcno,ts.VENDOR_CODE AS Thcvendorcode,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,'' AS vendorBILLNO,'' AS BILLNO,'' AS Acccode,ts.sourcehb,ts.pcamt ,ts.advamt,ts.AdvanceCash,ts.AdvanceCheque,ts.OtherAdvance,h.Amount AS netamt,ts.vehno,ts.ManualTHCNo from WebX_Thc_ChequeInstallment_Pending h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.thcno=ad.thcno AND ad.InstalmentType='ADVCHQ' AND   AdvChqPending IS NOT NUll INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno INNER JOIN ViewWebXThcChequeInstallmentPendingCount CI ON Ci.thcno=ts.thcno where  isnull(h.pendamount,0)>0   and h.BILLNO in (" + s2 + ")";//vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)

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
            SqlDisplay = "select '' as VendorBill_DT , '' as Due_DT,(h.paidamount-isnull(h.paidamount,h.pendamount)) as Advpaid, '' as SERVTAXNO,'' as PAN_NO,'' as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,ts.VENDOR_NAME AS vendorname,ts.thcno,ts.VENDOR_CODE AS Thcvendorcode,h.pendamount AS netamt,ts.VENDOR_CODE AS vendorcode,h.paidamount AS pendamt,'' AS vendorBILLNO,'' AS BILLNO,'' AS Acccode,ts.sourcehb,ts.pcamt ,ts.advamt,ts.AdvanceCash,ts.AdvanceCheque,ts.OtherAdvance,ts.vehno,ts.ManualTHCNo from WebX_Thc_ChequeInstallment_Pending h  INNER JOIN webx_THC_SUMMARY ts ON h.ThcNo=ts.thcno INNER JOIN ViewWebXThcChequeInstallmentPendingCount CI ON Ci.thcno=ts.thcno  where  isnull(h.pendamount,0)>0 and ts.VENDOR_CODE='" + vendorCode + "' ";

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);

            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }

        else if (vendorCode == "0")
        {
            SqlDisplay = "select '' as VendorBill_DT , '' as Due_DT,(h.paidamount-isnull(h.paidamount,h.pendamount)) as Advpaid, '' as SERVTAXNO,'' as PAN_NO,'' as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,ts.VENDOR_NAME AS vendorname,ts.thcno,ts.VENDOR_CODE AS Thcvendorcode,h.pendamount AS netamt,ts.VENDOR_CODE AS vendorcode,h.paidamount AS pendamt,'' AS vendorBILLNO,'' AS BILLNO,'' AS Acccode,ts.sourcehb,ts.pcamt ,ts.advamt,ts.AdvanceCash,ts.AdvanceCheque,ts.OtherAdvance,ts.vehno,ts.ManualTHCNo from WebX_Thc_ChequeInstallment_Pending h  INNER JOIN webx_THC_SUMMARY ts ON h.ThcNo=ts.thcno  INNER JOIN ViewWebXThcChequeInstallmentPendingCount CI ON Ci.thcno=ts.thcno  where  isnull(h.pendamount,0)>0 and ts.thcdt between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)  and (SELECT TOP 1 AdvChqBranch FROM Webx_Thc_AdvanceInstalment_Det where thcno=ts.thcno AND InstalmentType='ADVCHQ')='" + Location + "'";

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
            String a, b, c, d, m, prevC;
            if (no < 10)
            {
                Label l1 = (Label)e.Row.FindControl("netamt");
                a = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_netamt'";

                Label l2 = (Label)e.Row.FindControl("pendamt");
                b = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_pendamt'";

                TextBox txtCurrPayment1 = (TextBox)e.Row.FindControl("txtCurrPayment");
                c = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_txtCurrPayment'";

                RadioButton chkBill1 = (RadioButton)e.Row.FindControl("chkBill");
                d = "'ctl00_MyCPH1_BillDetail_ctl0" + Convert.ToString(no) + "_chkBill'";


            }
            else
            {
                a = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_netamt'";
                b = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_pendamt'";
                c = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_txtCurrPayment'";
                d = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_chkBill'";

            }

            ((TextBox)(e.Row.FindControl("txtCurrPayment"))).Attributes.Add("onblur", "fvalidatePayAmt(" + a + "," + b + "," + c + "," + d + ")");
            ((RadioButton)(e.Row.FindControl("chkBill"))).Attributes.Add("onclick", "RadioCheck(this," + a + "," + b + "," + c + "," + d + ");return calculation(" + a + "," + b + "," + c + "," + d + ")");
            // ((RadioButton)(e.Row.FindControl("chkBill"))).Attributes.Add("onclick", "javascript: calculation(" + a + "," + b + "," + c + "," + d + ")");
            //txtInstallmentAmount.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');javascript:AdvCashInstallmentAmtCalc();");
            //onclick = "RadioCheck(this);"
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
	if (IsTokenValid())
        {
	ConsumeToken();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        var advChqArg = GenerateArgumentAdvanceCheque();

        if (advChqArg != "")
        {
            foreach (GridViewRow gridrow in dgAdvanceCheque.Rows)
            {
                TextBox ChequeNo = (TextBox)gridrow.FindControl("txtChequeNo");
                TextBox txtDate = (TextBox)gridrow.FindControl("txtDate");
                string Cnt = VendorPayment_Utility.Duplicate_ChqNO(ChequeNo.Text.Trim(), fn.Mydate1(txtDate.Text));
                if (Cnt == "F")
                {
                    string ErrorMsg1 = "Duplicate Cheque Entered";
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1, false);
                    return;
                }
            }
        }

        SqlTransaction trn;
        trn = conn.BeginTransaction();
        var final = "";
        var isSuccess = false;
        try
        {
            if (advChqArg != "")
            {
                //string sqlvendorbill_hdr = "update WebX_Thc_ChequeInstallment_Pending set pendamount=isnull(pendamount,0)-" + currentpayment + ",PAYDT= '" + Transdate + "' where thcno='" + billbumber + "'";
                //SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn, trn);
                //sqlcmd5.ExecuteNonQuery();

                string sqlAdvanceChequeInsert = "exec Usp_Thc_AdvanceInstalment_Det_InsertAdvanceChequePending '" +
                                                advChqArg + "','" + Session["empcd"].ToString() + "'";
                SqlCommand cmdAdvanceCheque = new SqlCommand(sqlAdvanceChequeInsert, conn, trn);
                cmdAdvanceCheque.ExecuteNonQuery();
            }
            trn.Commit();
            isSuccess = true;
            //trn.Rollback();

            final = "?DocumentPrint=" + hdnTHCNo.Value.Trim();

            //Response.Redirect("THCPendingChequeDoneInstallmentWise.aspx" + final);
        }
        catch (Exception e1)
        {
            trn.Rollback();
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            //Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + msg + "</font>");
            Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Advance Cheque&ErrorMsg=" + msg, false);
            return;
        }
        finally
        {
            trn.Dispose();
            if (conn.State == ConnectionState.Open)
                conn.Close();
        }
        if (isSuccess)
        {
            Response.Redirect("THCPendingChequeDoneInstallmentWise.aspx" + final, false);
            return;
        }
	}
    }

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    string finyear = System.DateTime.Today.ToString("yy");
    //    Panno1 = lblPANNo.Text;
    //    string s1 = "";

    //    foreach (GridViewRow gridrow in BillDetail.Rows)
    //    {

    //        HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
    //        HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
    //        HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");


    //        vendorCode = vendorcode.Value.ToString();
    //        VendorName = vendorname.Value.ToString();
    //        effected_acccode = Acccode.Value.ToString();
    //    }

    //    string mdlsttranstype = "";
    //    string mddrCashcode = "";
    //    string mddrBankaccode = "";
    //    string mtxtChqNo = "";
    //    string mtxtChqDate = "";



    //    SqlTransaction trn;
    //    trn = conn.BeginTransaction();
    //    string PBOV_code = vendorCode;// pbov_arr[0];
    //    string PBOV_Name = VendorName;// pbov_arr[1];

    //    string finyear1 = System.DateTime.Today.ToString("yyyy");
    //    string Transdate = fn.Mydate1(txtVoucherDt.Text);// System.DateTime.Today.ToString("dd MMM yyyy");

    //    string billbumber = "0", netamount = "0", pendingamount = "0", currentpayment = "0";
    //    try
    //    {
    //        string Vbrcd = SessionUtilities.CurrentBranchCode.ToString();
    //        voucherNo = fn.NextVoucherno(Vbrcd, Financial_Year);
    //        foreach (GridViewRow gridrow in BillDetail.Rows)
    //        {
    //            RadioButton chkBill1 = (RadioButton)gridrow.FindControl("chkBill");
    //            Label BILLNO1 = (Label)gridrow.FindControl("THCNo");
    //            Label netamt1 = (Label)gridrow.FindControl("netamt");
    //            Label pendamt1 = (Label)gridrow.FindControl("pendamt");
    //            HiddenField pendingamt = (HiddenField)gridrow.FindControl("pendingamt");
    //            TextBox txtCurrPayment1 = (TextBox)gridrow.FindControl("txtCurrPayment");

    //            if (chkBill1.Checked == true)
    //            {
    //                billbumber = BILLNO1.Text;
    //                netamount = netamt1.Text;
    //                pendingamount = pendamt1.Text;
    //                currentpayment = txtCurrPayment1.Text;

    //                double  totcurrentpay, totpaid;

    //                if (pendingamount == "")
    //                {
    //                    pendingamount = "0";
    //                }
    //                else
    //                {
    //                    pendingamount = pendingamount;
    //                }
    //                totcurrentpay = Convert.ToDouble(netamount) - Convert.ToDouble(pendingamount);
    //                totpaid = Convert.ToDouble(currentpayment);

    //                debit = 0;
    //                credit = credit + totpaid;// Convert.ToDouble(colamt.Text);
    //                transtype1 = mdlsttranstype;// transtype.SelectedItem.ToString();

    //                servicetaxrate = 0;
    //                OCTPaid = 0;
    //                AgentServiceChrg = 0;
    //                ServiceChargPaid = 0;
    //                TotalDed = 0;
    //                TotChrg = 0;
    //                CHQAMT = 0;
    //                DEDUCTION = 0;
    //                othChrg = 0;
    //                tdsrate = 0;
    //                servicetaxCharged = 0;
    //                Currbalance = 0;
    //                mamul_chrg = 0;

    //                    string sqlvendorbill_hdr = "update WebX_Thc_ChequeInstallment_Pending set pendamount=isnull(pendamount,0)-" + currentpayment + ",PAYDT= '" + Transdate + "' where thcno='" + billbumber + "'";
    //                    SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn, trn);
    //                    sqlcmd5.ExecuteNonQuery();
    //            }
    //        }
    //        string ptmsptcd = vendorCode;
    //        string ptmsptnm = VendorName;
    //        string chequeDt = "";
    //        string branch = SessionUtilities.CurrentBranchCode.ToString();
    //        string branchname = fn.GetLocation(SessionUtilities.CurrentBranchCode.ToString());


    //        //trn.Commit();
    //        trn.Rollback();
    //        conn.Close();
    //        string final;
    //        final = "?VoucherNo=" + voucherNo;
    //        final += "&VoucherDT=" + txtVoucherDt.Text;
    //        final += "&MODE=" + transtype1;
    //        final += "&chequeNo=" + Chqno11;
    //        final += "&chequeDT=" + chequeDt;
    //        final += "&Amount=" + credit.ToString();
    //        final += "&PayACC=" + accountcode;
    //        Response.Redirect("PendingTHCAdvanceChequeDone.aspx" + final);
    //    }
    //    catch (Exception e1)
    //    {
    //        Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
    //        string msg = e1.Message.ToString();
    //        msg = msg.Replace('\n', ' ');
    //        trn.Rollback();
    //        //Response.Redirect("Message.aspx?" + e1.Message);
    //        Response.End();

    //    }
    //}

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{ btnSubmit.Visible = false;

    //}
    #region AdvanceCheque
    protected void BindGridAdvanceCheque()
    {
        DataView dv = dsAdvanceCheque.ThcAdvanceCheque.DefaultView;
        dgAdvanceCheque.DataSource = dv;
        dgAdvanceCheque.DataBind();
    }
    protected ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow GetDataRowAdvanceCheque(int rowIndex)
    {
        ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow _mydatarow;
        _mydatarow = dsAdvanceCheque.ThcAdvanceCheque[rowIndex];
        _mydatarow.SrNoAdvChq = Convert.ToString((rowIndex + 1)).Trim();
        _mydatarow.ChequeNo = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtChequeNo")).Text;
        _mydatarow.BankName = ((DropDownList)dgAdvanceCheque.Rows[rowIndex].FindControl("cboBankName")).Text;
        _mydatarow.Date = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtDate")).Text;
        _mydatarow.Amount = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtAmount")).Text;
        _mydatarow.Favour = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtFavour")).Text;
        _mydatarow.CardNo = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtCardNo")).Text;
        _mydatarow.CardType = ((TextBox)dgAdvanceCheque.Rows[rowIndex].FindControl("txtCardType")).Text;
        return _mydatarow;
    }
    protected void MyDataRowsAdvanceCheque()
    {
        srNoAdvanceCheque = "";
        ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow datarow;
        foreach (GridViewRow gr in dgAdvanceCheque.Rows)
        {
            if (gr.RowIndex != -1)
            {
                srNoAdvanceCheque = Convert.ToString(gr.RowIndex + 2).Trim();
                BlankRowAdvanceCheque("");
                datarow = dsAdvanceCheque.ThcAdvanceCheque[gr.RowIndex];
                datarow = GetDataRowAdvanceCheque(gr.RowIndex);
                dsAdvanceCheque.ThcAdvanceCheque[gr.RowIndex].ItemArray = datarow.ItemArray;
            }
        }
    }
    protected void BlankRowAdvanceCheque(string srNoAdvanceCheque)
    {
        dsAdvanceCheque.ThcAdvanceCheque.AddThcAdvanceChequeRow(srNoAdvanceCheque, "", "", "", "", "", "", "");
    }
    protected void AddNewRowAdvanceCheque(Object sender, EventArgs e)
    {
        if (dgAdvanceCheque.Rows.Count < 10)
        {
            MyDataRowsAdvanceCheque();
            BlankRowAdvanceCheque(srNoAdvanceCheque);
            BindGridAdvanceCheque();
        }
    }
    protected void dg_RowDataBoundAdvanceCheque(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            txtAmount.Attributes.Add("OnBlur", "javascript:checkDecimal(this.getAttribute('id'), 'TRUE');javascript:AdvChqAmountAmtCalc();");

            DropDownList cbo = (DropDownList)e.Row.FindControl("cboBankName");
            if (dsAdvanceCheque.ThcAdvanceCheque.Count > 0)
            {
                cbo.SelectedValue = dsAdvanceCheque.ThcAdvanceCheque[e.Row.RowIndex]["BankName"].ToString().Trim();
            }
        }
    }
    protected void dg_RowCommandAdvanceCheque(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteRow")
        {
            MyDataRowsAdvanceCheque();
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);

            if (((GridView)(sender)).Rows.Count > 1)
            {
                ThcInstallmentWiseAdvanceDataSet.ThcAdvanceChequeRow dsRow;
                dsRow = dsAdvanceCheque.ThcAdvanceCheque[thisRow];
                dsAdvanceCheque.ThcAdvanceCheque.RemoveThcAdvanceChequeRow(dsRow);
                BindGridAdvanceCheque();
            }
        }
    }
    protected string GenerateArgumentAdvanceCheque()
    {
        string arg = "";
        int defaultVal = 0;
        string argVal = "";
        for (int index = 0; index < dgAdvanceCheque.Rows.Count; index++)
        {
            TextBox txtChequeNo = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtChequeNo");
            DropDownList cboBankName = (DropDownList)dgAdvanceCheque.Rows[index].FindControl("cboBankName");
            TextBox txtDate = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtDate");
            TextBox txtAmount = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtAmount");
            TextBox txtFavour = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtFavour");
            string finyear = Session["FinYear"].ToString().Substring(2, 2);
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            string Transdate = fn.Mydate(strrightnow);
            PartyCode = VendorPayment_Utility.GetThcPartyCode(hdnTHCNo.Value.Trim());

            TextBox txtCardNo = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtCardNo");
            TextBox txtCardType = (TextBox)dgAdvanceCheque.Rows[index].FindControl("txtCardType");

            if (txtAmount.Text.Trim() != "")
            {
                if (index == 0)
                {
                    arg = hdnTHCNo.Value.Trim() + "^" + "ADVCHQ" + "^" + txtAmount.Text.Trim() + "^" + txtChequeNo.Text.Trim() + "^" + cboBankName.Text.Trim() + "^" + fn.Mydate(txtDate.Text.Trim()) + "^" + txtFavour.Text.Trim() + "^" + "P" + "^" + Session["BRCD"].ToString() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^" + txtCardNo.Text.Trim() + "^" + txtCardType.Text.Trim() + "^-1";
                }
                else
                {
                    arg = arg + "," + hdnTHCNo.Value.Trim() + "^" + "ADVCHQ" + "^" + txtAmount.Text.Trim() + "^" + txtChequeNo.Text.Trim() + "^" + cboBankName.Text.Trim() + "^" + fn.Mydate(txtDate.Text.Trim()) + "^" + txtFavour.Text.Trim() + "^" + "P" + "^" + Session["BRCD"].ToString() + "^" + Session["BRCD"].ToString() + "^" + finyear + "^" + Transdate + "^" + PartyCode + "^" + txtCardNo.Text.Trim() + "^" + txtCardType.Text.Trim() + "^-1";
                }
            }
        }
        return arg;
    }
    protected void dg_RowCreatedAdvanceCheque(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cbo = (DropDownList)e.Row.FindControl("cboBankName");
            if (dsAdvanceCheque.ThcAdvanceCheque.Count > 0 && (cbo.SelectedValue == "0Select" || cbo.SelectedValue == ""))
            {
                //ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "Usp_Thc_AdvanceInstallmentWise_GetBankList");
                ds1 = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "Usp_Thc_AdvanceInstallmentWise_GetBankListNew", new SqlParameter("@brcd", Session["brcd"].ToString().Trim()));
                cbo.DataSource = ds1;
                cbo.DataBind();
            }
        }
    }
    #endregion
}