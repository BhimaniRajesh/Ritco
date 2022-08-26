using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_vendorpayvoucher_Step2 : System.Web.UI.Page
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
    public string vendorCode = "", VendorName = "", effected_acccode = "", Location="";
    public double debit, credit;
    public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
    public string[] VehicleArray, DocumentArray, VendorBillArray;
    protected void Page_Load(object sender, EventArgs e)
    {
        strsession1 = SessionUtilities.CurrentBranchCode.ToString();
        strsession2 = SessionUtilities.CurrentEmployeeID.ToString();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        if (!IsPostBack)
        {
            strsession2 = SessionUtilities.CurrentBranchCode.ToString();
            fromdt = Request.QueryString["dtFrom"];
            fromdt = fn.Mydate(fromdt);
            todt = Request.QueryString["dtTo"];
            Todt = Request.QueryString["dtTo"];
            Fromdt = Request.QueryString["dtFrom"];
            todt = fn.Mydate(todt);


            lblAgentBillDate.Text = fromdt + " - " + todt;
            DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
            VendorBill = Convert.ToString(Request.QueryString["VendorBill"]);
            VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
            vendorCode = Convert.ToString(Request.QueryString["vendor"]);
            Location = Convert.ToString(Request.QueryString["Location"]);


            lblVendor.Text = fn.GetVendor(vendorCode);
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            txtVoucherDt.Text = strrightnow;

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
            ddlPayType.Style["display"] = "block";
            trInstrument.Style["display"] = "block";
            lblRedeemFuelRewards.Style["display"] = "block";
            txtRedeemFuelRewards.Style["display"] = "block";
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            ddlBankAccount.Items.Clear();

            string strSql = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + SessionUtilities.CurrentBranchCode + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            SqlCommand cmd = new SqlCommand(strSql, con);

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddlBankAccount.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddlBankAccount.CssClass = "blackfnt";
            con.Close();
            string js = "<script language=\"javascript\" type=\"text/javascript\">var i = 2; var count= document.getElementById(\"ctl00_MyCPH1_BillDetail\").rows.length; for(i=2;i<count;i++) { if(i<=9){document.getElementById(\"ctl00_MyCPH1_BillDetail_ctl0\" + i + \"_txtCurrPayment\").disabled = true;}else{document.getElementById(\"ctl00_MyCPH1_BillDetail_ctl\" + i + \"_txtCurrPayment\").disabled = true;}}</script>";
            Page.RegisterStartupScript("abc", js);

        }

        //btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit()");
//btnSubmit.Attributes.Add("onclick", "javascript:return CheckDouble()");
//btnSubmit.Attributes.Add("onclick", "javascript:return CheckDouble();fsubmit();");//javascript:return CheckDocketSelection();
	btnSubmit.Attributes.Add("onclick", "javascript:return CheckDouble();");//javascript:return CheckDocketSelection();
    }

    private void DisplayVendorBilllist()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (VehicleNo != "")
        {
            lblVendor.Text = "-";
            lblVendor1.Text = "-";

            VehicleArray = VehicleNo.Split(',');

            for (i = 0; i < VehicleArray.Length; i++)
            {
                s2 += "'" + VehicleArray[i] + "',";
            }

            s2 = s2.Substring(0, s2.Length - 1);
           // SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0 and h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";
		   SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid,WVH.SERVTAXNO  as SERVTAXNO,WVH.PAN_NO  as PAN_NO,CONVERT(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,WVH.VENDORNAME  AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode,WVH.DiscountRate FROM WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_vendor_hdr WVH ON WVH.vendorcode=ad.OthAdvVendor INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno WHERE  isnull(h.pendamount,0)>0 AND h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            if (intTotalRecords > 0)
            {
                lblServiceTaxNo.Text = ds.Tables[0].Rows[0][3].ToString();
                lblPANNo.Text = ds.Tables[0].Rows[0][4].ToString();

                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblRate.Text = ds.Tables[0].Rows[0]["DiscountRate"].ToString() == "" ? "0.00" : ds.Tables[0].Rows[0]["DiscountRate"].ToString();
            }
            BillDetail.DataBind();
        }
        else if (VendorBill != "")
        {
            lblVendor.Text = "-";
            lblVendor1.Text = "-";

            VBENoRow.Visible = true;

            VendorBillArray = VendorBill.Split(',');

            for (i = 0; i < VendorBillArray.Length; i++)
            {
                s2 += "'" + VendorBillArray[i] + "',";
                doc += VendorBillArray[i] + ",";
            }
            LblVBENo.Text = doc;

            s2 = s2.Substring(0, s2.Length - 1);
            //SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0  and h.BILLDT in (" + s2 + ") AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";//and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)
			SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid,WVH.SERVTAXNO as SERVTAXNO,WVH.PAN_NO as PAN_NO,CONVERT(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,WVH.VENDORNAME AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode,WVH.DiscountRate FROM WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_vendor_hdr WVH ON WVH.vendorcode=ad.OthAdvVendor INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno WHERE  isnull(h.pendamount,0)>0  and h.BILLDT in (" + s2 + ") AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";//and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            if (intTotalRecords > 0)
            {
                lblServiceTaxNo.Text = ds.Tables[0].Rows[0][3].ToString();
                lblPANNo.Text = ds.Tables[0].Rows[0][4].ToString();

                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblRate.Text = ds.Tables[0].Rows[0]["DiscountRate"].ToString() == "" ? "0.00" : ds.Tables[0].Rows[0]["DiscountRate"].ToString();
            }
            BillDetail.DataBind();
        }
        else if (DocumentNo != "")
        {
            lblVendor.Text = "-";
            lblVendor1.Text = "-";
            BENoRow.Visible = true;


            DocumentArray = DocumentNo.Split(',');
            string doc = "";
            for (i = 0; i < DocumentArray.Length; i++)
            {
                s2 += "'" + DocumentArray[i] + "',";
                doc += DocumentArray[i] + ",";
            }
            LblBENo.Text = doc;

            s2 = s2.Substring(0, s2.Length - 1);
           // SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0   and h.BILLNO in (" + s2 + ") AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";//vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)
			SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid,WVH.SERVTAXNO AS SERVTAXNO,WVH.PAN_NO as PAN_NO,CONVERT(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,WVH.VENDORNAME AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode,WVH.DiscountRate from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_vendor_hdr WVH ON WVH.vendorcode=ad.OthAdvVendor INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0   and h.BILLNO in (" + s2 + ") AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";//vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            if (intTotalRecords > 0)
            {
                lblServiceTaxNo.Text = ds.Tables[0].Rows[0][3].ToString();
                lblPANNo.Text = ds.Tables[0].Rows[0][4].ToString();

                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblRate.Text = ds.Tables[0].Rows[0]["DiscountRate"].ToString() == "" ? "0.00" : ds.Tables[0].Rows[0]["DiscountRate"].ToString();
            }

            BillDetail.DataBind();
        }
        else if (vendorCode != "0")
        {
            BillDtRow.Visible = true;
            VendorRow.Visible = true;
            lblVendor1.Text = fn.GetVendor(vendorCode);
            //SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0 and h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and ad.OthAdvVendor='" + vendorCode + "' and ad.branchcode='" + Location + "' AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";
			SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid,WVH.SERVTAXNO as SERVTAXNO,WVH.PAN_NO as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,WVH.VENDORNAME AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode ,WVH.DiscountRate FROM WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_vendor_hdr WVH ON WVH.vendorcode=ad.OthAdvVendor  INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno WHERE  isnull(h.pendamount,0)>0 and h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and ad.OthAdvVendor='" + vendorCode + "' and ad.branchcode='" + Location + "' AND ISNULL(BillApproval,'N')='Y' AND  ISNULL(ts.cancelled,'')<>'Y'";

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            if (intTotalRecords > 0)
            {
                lblServiceTaxNo.Text = ds.Tables[0].Rows[0][3].ToString();
                lblPANNo.Text = ds.Tables[0].Rows[0][4].ToString();

                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblRate.Text = ds.Tables[0].Rows[0]["DiscountRate"].ToString() == "" ? "0.00" : ds.Tables[0].Rows[0]["DiscountRate"].ToString();
            }
            BillDetail.DataSource = ds;
            BillDetail.DataBind();
        }
    }

    protected void BillDetail_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int no = e.Row.RowIndex + 2;
            String a, b, c, d;
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
            }
            else
            {
                a = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_netamt'";
                b = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_pendamt'";
                c = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_txtCurrPayment'";
                d = "'ctl00_MyCPH1_BillDetail_ctl" + Convert.ToString(no) + "_chkBill'";
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
        Panno1 = lblPANNo.Text;
        foreach (GridViewRow gridrow in BillDetail.Rows)
        {

            HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
            HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
            HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");
            vendorCode = vendorcode.Value.ToString();
            VendorName = vendorname.Value.ToString();
            effected_acccode = Acccode.Value.ToString();
        }
        string mdlsttranstype = "";
        string mddrCashcode = "";
        string mddrBankaccode = "";
        string mtxtChqNo = "";
        string mtxtChqDate = "";

        //UserControls_MyPaymentControl paymen = (UserControls_MyPaymentControl)UCMyPaymentControl1;
        //DropDownList dlsttranstype = (DropDownList)paymen.FindControl("ddlPayMode");
        //DropDownList ddrCashcode = (DropDownList)paymen.FindControl("ddrCashcode");
        //DropDownList ddrBankaccode = (DropDownList)paymen.FindControl("ddrBankaccode");

        //TextBox txtCashAmt = (TextBox)paymen.FindControl("txtCashAmt");
        //TextBox txtChqAmt = (TextBox)paymen.FindControl("txtChqAmt");

        //TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        //TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        //mdlsttranstype = dlsttranstype.SelectedValue;
        //mddrCashcode = ddrCashcode.SelectedValue;
        //mddrBankaccode = ddrBankaccode.SelectedValue;
        //if (dlsttranstype.SelectedValue == "Cash")
        //{
        //    accountcode = mddrCashcode;
        //}
        //if (dlsttranstype.SelectedValue == "Bank")
        //{
        //    accountcode = mddrBankaccode;
        //}
        //mtxtChqNo = txtChqNo.Text;
        //mtxtChqDate = txtChqDate.Text;
        if (ddlTranType.SelectedValue == "Both")
        {
             accountcode = ddlBankAccount.SelectedValue;
        }
        if (ddlTranType.SelectedValue == "Redeem")
        {
            accountcode = "";
        }
        if (ddlTranType.SelectedValue == "Instrument")
        {
            accountcode = ddlBankAccount.SelectedValue;
        }
        SqlTransaction trn;
        trn = conn.BeginTransaction();
        string acccode1 = "";
        string PBOV_code = vendorCode;
        string PBOV_Name = VendorName;
        string PBOV_typ = "V";

        string servicetaxNo = "";
        string DocNo = "";
        string bookcode = "VENDOR BILL";
        string BANKNAME = "";
        string TRANSMODE = "";
        string tdsacccode = "";
        string svctaxacccode = "";
        string finyear1 = System.DateTime.Today.ToString("yyyy");
        string Transdate = fn.Mydate1(txtVoucherDt.Text);
        string billbumber = "0", netamount = "0", pendingamount = "0", currentpayment = "0",BillNoString="";
        try
        {
            if (ddlTranType.SelectedValue == "Instrument" || ddlTranType.SelectedValue == "Both")
            {
                string Cnt = VendorPayment_Utility.Duplicate_ChqNO(txtInstrumentNo.Text.Trim(), fn.Mydate1(txtInstrumentDate.Text));
                if (Cnt == "F")
                {
                    string ErrorMsg1 = "Duplicate Cheque Entered";
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=Cheque Entry Error&ErrorMsg=" + ErrorMsg1);
                }
            }
            string Vbrcd = SessionUtilities.CurrentBranchCode.ToString();
            voucherNo = fn.NextVoucherno(Vbrcd, Financial_Year);
            foreach (GridViewRow gridrow in BillDetail.Rows)
            {
                CheckBox chkBill1 = (CheckBox)gridrow.FindControl("chkBill");
                Label BILLNO1 = (Label)gridrow.FindControl("BILLNO");
                Label netamt1 = (Label)gridrow.FindControl("netamt");
                Label pendamt1 = (Label)gridrow.FindControl("pendamt");
                HiddenField pendingamt = (HiddenField)gridrow.FindControl("pendingamt");
                TextBox txtCurrPayment1 = (TextBox)gridrow.FindControl("txtCurrPayment");
                if (chkBill1.Checked == true)
                {
                    billbumber = BILLNO1.Text;
                    netamount = netamt1.Text;
                    pendingamount = pendamt1.Text;
                    currentpayment = txtCurrPayment1.Text;

                    double  totcurrentpay, totpaid;
if(BillNoString=="")
                    {
                        BillNoString = billbumber;

                    }
                     else
                    {
                        BillNoString = BillNoString + "," + billbumber;
                    }
                    if (pendingamount == "")
                    {
                        pendingamount = "0";
                    }
                    totcurrentpay = Convert.ToDouble(netamount) - Convert.ToDouble(pendingamount);
                    totpaid = Convert.ToDouble(currentpayment);

                    debit = 0;
                    credit = credit + totpaid;
                    transtype1 = ddlTranType.SelectedValue;
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
                    string SQL_Insert = "INSERT INTO [WEBX_VENDORBILL_PAYDET] SELECT h.BILLNO,'.',ad.BranchCode,h.BILLDT,ad.OthAdvVendor,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor),h.BILLDT,h.BILLNO,(GETDATE()+30),'" + Transdate + "','" + voucherNo + "',h.Amount," + currentpayment + "," + pendingamount + ",ad.ThcNo  FROM   WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno WHERE h.BILLNO='" + billbumber + "'";
                    SqlCommand sqlcmd = new SqlCommand(SQL_Insert, conn, trn);
                    sqlcmd.ExecuteNonQuery();
                    if (pendingamt.Value == txtCurrPayment1.Text)
                    {
                        string sql_hdr = "update WEBX_THC_OTHER_ADVANCE_BILL set pendamount=isnull(pendamount,0)-" + currentpayment + ",finclosedt='" + Transdate + "',voucherNo='" + voucherNo + "',PAYDT='" + Transdate + "',PaidAmount='" + currentpayment + "' where BillNo='" + billbumber + "'";
                        SqlCommand sqlcmd1 = new SqlCommand(sql_hdr, conn, trn);
                        sqlcmd1.ExecuteNonQuery();
                    }

                    else
                    {
                        string sqlvendorbill_hdr = "update WEBX_THC_OTHER_ADVANCE_BILL set pendamount=isnull(pendamount,0)-" + currentpayment + ",finclosedt= '" + Transdate + "',voucherNo='" + voucherNo + "',PAYDT= '" + Transdate + "',PaidAmount='" + currentpayment + "' where BillNo='" + billbumber + "'";
                        SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn, trn);
                        sqlcmd5.ExecuteNonQuery();
                    }
                }
            }
            string banknm = "";
            string ptmsptcd = vendorCode;
            string ptmsptnm = VendorName;
            string adjustamt = "", chequeDt = "";
            string comments = "NULL";
            string bacd = "null";
            string banm = "null";
            string staffcd = "Null";
            string staffnm = "Null";
            string branch = SessionUtilities.CurrentBranchCode.ToString();
            string branchname = fn.GetLocation(SessionUtilities.CurrentBranchCode.ToString());
            credit = Convert.ToDouble(txtRedeemFuelRewards.Text) + Convert.ToDouble(txtInstrumentAmount.Text);
            if (transtype1 == "Instrument" || transtype1 == "Both")
            {
                string depositdt = System.DateTime.Today.ToString("dd MMM yyyy");
                CHQAMT1 = txtInstrumentAmount.Text;//colamt.Text;
                Chqno11 = txtInstrumentNo.Text;//chqno.Text;
                chequeDt = fn.Mydate(txtInstrumentDate.Text);

                string sql_chqdet = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values('" + Chqno11 + "','" + chequeDt + "'," + CHQAMT1 + ",'" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','" + comments + "','" + bacd + "','" + banm + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + "" + "','" + staffcd + "','" + staffnm + "',null,'O','" + "" + "','" + adjustamt + "')";
                SqlCommand sqlCommand_Cheque = new SqlCommand(sql_chqdet, conn, trn);
                sqlCommand_Cheque.ExecuteNonQuery();

                string sql_cheque_update = "update webx_chq_det set voucherNo='" + voucherNo + "',transdate='" + depositdt + "',acccode='" + accountcode + "',depoloccode='" + SessionUtilities.CurrentBranchCode.ToString() + "',DepoFlag='Y' where chqno='" + Chqno11 + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chequeDt + "',106)";
                SqlCommand sqlCommand_Cheq_Update = new SqlCommand(sql_cheque_update, conn, trn);
                sqlCommand_Cheq_Update.ExecuteNonQuery();
            }
            string tChqAmt = "0.00";
            string CashAmt = "0.00";
            double fuleDiscount = Convert.ToDouble(hdnFuleDiscount.Value);
            if (transtype1 == "Both" && txtRedeemFuelRewards.Text != "" && txtInstrumentAmount.Text != "")
            {
                tChqAmt = txtInstrumentAmount.Text; 
                CashAmt = txtRedeemFuelRewards.Text;
              
               // var payment = Request.Form[txtTotalPaymentAmount.Text];
                credit = Convert.ToDouble(txtRedeemFuelRewards.Text) + Convert.ToDouble(txtInstrumentAmount.Text);
            }
            else if (transtype1 == "Redeem" && txtRedeemFuelRewards.Text != "")
            {
                tChqAmt = "0.00";
                CashAmt = txtRedeemFuelRewards.Text;
                credit = Convert.ToDouble(txtRedeemFuelRewards.Text);
				transtype1 = "Journal";
            }
            else if (transtype1 == "Instrument" && txtInstrumentAmount.Text != "")
            {
                CashAmt = "0.00";
                tChqAmt = txtInstrumentAmount.Text;
				transtype1 = "BANK PAYMENT";
                
                credit = Convert.ToDouble(txtInstrumentAmount.Text);
            }

            string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry,acccode,CashAmt,Bank_Acccode,FuelRate,FuelUnit,FuelDiscount,PayType,RedeemFuelRewards,OilCompanyName,Remark) values (" + finyear1 + ",'" + Transdate + "','" + voucherNo + "','" + accountcode + "','" + acccode1 + "','" + Chqno11 + "','" + chequeDt + "'," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'" + DocNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + SessionUtilities.CurrentBranchCode.ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + credit + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + Panno1 + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + tChqAmt + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y','" + effected_acccode + "'," + CashAmt + ",'" + accountcode + "','" + lblRate.Text + "','" + txtTotUnit.Text + "','" + fuleDiscount + "','" + ddlPayType.SelectedValue + "','" + txtRedeemFuelRewards.Text + "','" + txtOilCompanyName.Text + "','" + txtRemark.Text + "')";
            SqlCommand sqlCommand_Trnas = new SqlCommand(sql_VTrans, conn, trn);
            sqlCommand_Trnas.ExecuteNonQuery();

            string sql_TransArch = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + voucherNo + "'";
            SqlCommand sqlCommand_TrnasArch = new SqlCommand(sql_TransArch, conn, trn);
            sqlCommand_TrnasArch.ExecuteNonQuery();

            string sql_VTrans_delete = "delete from webx_vouchertrans where voucherNo='" + voucherNo + "'";
            SqlCommand sqlCommand_TrnasDelete = new SqlCommand(sql_VTrans_delete, conn, trn);
            sqlCommand_TrnasDelete.ExecuteNonQuery();
            string sql_voucher_act = "EXEC USP_OtherAdvance_Bill_Payment_Transaction_Ver1 '" + voucherNo + "','" + Financial_Year + "'";

            SqlCommand Acct_cmd = new SqlCommand(sql_voucher_act, conn, trn);
            Acct_cmd.ExecuteNonQuery();
            trn.Commit();
            //trn.Rollback();
            conn.Close();
            string final;
            final = "?VoucherNo=" + voucherNo;
            final += "&VoucherDT=" + txtVoucherDt.Text;
            final += "&MODE=" + transtype1;
            final += "&chequeNo=" + Chqno11;
            final += "&chequeDT=" + chequeDt;
            final += "&Amount=" + credit.ToString();
            final += "&PayACC=" + accountcode;
            final += "&DocumentNo=" + BillNoString;
            Response.Redirect("VendorPaymentVoucher_Done.aspx" + final,false);

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