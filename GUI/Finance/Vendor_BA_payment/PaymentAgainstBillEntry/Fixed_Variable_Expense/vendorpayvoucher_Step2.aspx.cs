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
    public string vendorCode="",VendorName="",effected_acccode="";
    public double debit, credit;
    public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
    public string[] VehicleArray, DocumentArray, VendorBillArray;

    protected void Page_Load(object sender, EventArgs e)
    {
        strsession1 = SessionUtilities.CurrentBranchCode.ToString();
        strsession2 = SessionUtilities.CurrentEmployeeID .ToString();
        Financial_Year = SessionUtilities.FinYear.ToString().Substring(2, 2);
        if (!IsPostBack)
        {
            strsession2 = SessionUtilities.CurrentBranchCode.ToString();
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
            //PopPaymentAcc();

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

        }

        btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit()");
    }
    private void PopPaymentAcc()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();

        //string sql = "select acccode+'~'+acccategory+'~'+accdesc as accdval,accdesc,acccategory from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";

        //SqlCommand sqlCommand = new SqlCommand(sql, conn);
        //DataSet ds = new DataSet();

        //SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        //da.Fill(ds, "tab1");

        //acccode.DataSource = ds;
        //acccode.DataTextField = "accdesc";
        //acccode.DataValueField = "accdval";
        //acccode.DataBind();
        //acccode.CssClass = "blackfnt";
        //transtype.CssClass = "blackfnt";
    }

    private void DisplayVendorBilllist()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (VehicleNo != "")
        {
            lblVendor.Text = "-";
            //lblServiceTaxNo.Text = "-";
            lblVendor1.Text = "-";

           

            VehicleArray = VehicleNo.Split(',');

            for (i = 0; i < VehicleArray.Length; i++)
            {
                s2 += "'" + VehicleArray[i] + "',";
            }

            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid , (select SERVTAXNO from webx_vendor_hdr where vendorcode=h.vendorcode) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=h.vendorcode) as PAN_NO,Convert(varchar,vendorBILLDT,103) as VendorBill_DT1, * from WEBX_VendorBill_hdr h where ( Bill_cancel='N' or Bill_cancel is null) and isnull(pendamt,0)>0 and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)";
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
            }
            BillDetail.DataBind();
        }
        else if (VendorBill != "")
        {
            lblVendor.Text = "-";
            //lblServiceTaxNo.Text = "-";
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
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid , (select SERVTAXNO from webx_vendor_hdr where vendorcode=h.vendorcode) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=h.vendorcode) as PAN_NO,Convert(varchar,vendorBILLDT,103) as VendorBill_DT1, * from WEBX_VendorBill_hdr h where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0  and VendorBillNo in (" + s2 + ")";//and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)
            
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
            }
            BillDetail.DataBind();
        }
        else if (DocumentNo != "")
        {
            lblVendor.Text = "-";
            //lblServiceTaxNo.Text = "-";
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
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid , (select SERVTAXNO from webx_vendor_hdr where vendorcode=h.vendorcode) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=h.vendorcode) as PAN_NO, Convert(varchar,vendorBILLDT,103) as VendorBill_DT1, * from WEBX_VendorBill_hdr h where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0   and BILLNO in (" + s2 + ")";//vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)
            
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
            }

            BillDetail.DataBind();
        }
        else if (vendorCode!="0")
        {
            BillDtRow.Visible = true;
            VendorRow.Visible = true;
            lblVendor1.Text = fn.GetVendor(vendorCode);
            SqlDisplay = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=h.vendorcode) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=h.vendorcode) as PAN_NO,Convert(varchar,vendorBILLDT,103) as VendorBill_DT1,* from WEBX_VendorBill_hdr h where ( Bill_cancel='N' or Bill_cancel is null)  and isnull(pendamt,0)>0 and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and VENDORCODE='" + vendorCode + "'";
            
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

        /*string sqlpanno = "select top 1 PAN_NO from webx_vendor_hdr where vendorcode='" + vendorCode + "'";
        SqlCommand cmd1 = new SqlCommand(sqlpanno, conn);
        SqlDataReader dr1;
        dr1 = cmd1.ExecuteReader();

        while (dr1.Read())
        {
            Panno1 = dr1["PAN_NO"].ToString();
        }
        dr1.Close();*/

        Panno1 = lblPANNo.Text;
        string s1 = "";

        //string sqlvoucher = "usp_next_VoucherNo_M";
        //SqlCommand cmdvou = new SqlCommand(sqlvoucher, conn);
        //cmdvou.CommandType = CommandType.StoredProcedure;
        //cmdvou.Parameters.AddWithValue("@brcd", strsession1);
        //cmdvou.Parameters.AddWithValue("@finyear", finyear);
        //cmdvou.Parameters.AddWithValue("@NextVoucherNo", s1);

        //SqlDataAdapter davou = new SqlDataAdapter(cmdvou);
        //DataSet dsvou = new DataSet();
        //davou.Fill(dsvou);

        //foreach (DataRow dr in dsvou.Tables[0].Rows)
        //{
        //    voucherNo = dr["vno"].ToString();
        //}
        foreach (GridViewRow gridrow in BillDetail.Rows)
        {
          
            HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
            HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
            HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");
           

            vendorCode = vendorcode.Value.ToString();
            VendorName = vendorname.Value.ToString();
            effected_acccode = Acccode.Value.ToString();
        }

        //-------------------------------------


        string mdlsttranstype = "";
        string mddrCashcode = "";
        string mddrBankaccode = "";
        string mtxtCashAmt = "";
        string mtxtChqAmt = "";
        string mtxtChqNo = "";
        string mtxtChqDate = "";
        string mtxtAmtApplA = "";
        string mtxtNetPay = "";



        UserControls_MyPaymentControl paymen = (UserControls_MyPaymentControl)UCMyPaymentControl1;
        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("ddlPayMode");
        DropDownList ddrCashcode = (DropDownList)paymen.FindControl("ddrCashcode");
        DropDownList ddrBankaccode = (DropDownList)paymen.FindControl("ddrBankaccode");

        TextBox txtCashAmt = (TextBox)paymen.FindControl("txtCashAmt");
        TextBox txtChqAmt = (TextBox)paymen.FindControl("txtChqAmt");

        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");

        //TextBox txtAmtApplA = (TextBox)paymen.FindControl("txtAmtApplA");
        //TextBox txtNetPay = (TextBox)paymen.FindControl("txtNetPay");

        mdlsttranstype = dlsttranstype.SelectedValue;
        
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

        if (dlsttranstype.SelectedValue == "Cash")
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

        if (dlsttranstype.SelectedValue == "Bank")
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

        


        //-------------------------------------


        SqlTransaction trn;
        trn = conn.BeginTransaction();
        string acccode1 = "";// acccode.SelectedItem.ToString();
        string[] pbov_arr;
        string PBOV_code = vendorCode;// pbov_arr[0];
        string PBOV_Name = VendorName;// pbov_arr[1];
        string PBOV_typ = "V";
        
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
        string finyear1 = System.DateTime.Today.ToString("yyyy");
        string Transdate = fn.Mydate1(txtVoucherDt.Text);// System.DateTime.Today.ToString("dd MMM yyyy");
        //string acc =  acccode.SelectedValue.ToString();
        //accountcode1 = acc.Split('~');
        //accountcode = accountcode1[0].ToString();
        

        string billbumber = "0", netamount = "0", pendingamount = "0", currentpayment = "0";
        try
        {
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
                    credit = credit + totpaid;// Convert.ToDouble(colamt.Text);
                    transtype1 = mdlsttranstype;// transtype.SelectedItem.ToString();
                    
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
                    

                    //acccode
                   
                   

                    string SQL_Insert = "INSERT INTO [WEBX_VENDORBILL_PAYDET] SELECT [BILLNO],[BILLSF],[BRCD],[BILLDT],[VENDORCODE],[VENDORNAME],[VENDORBILLDT],[VENDORBILLNO],[DUEDT],[PAYDT],'" + voucherNo + "',[NETAMT]," + currentpayment + "," + pendingamount + ",''  FROM  WEBX_vendorbill_hdr WHERE BILLNO='" + billbumber + "'";
                    SqlCommand sqlcmd = new SqlCommand(SQL_Insert, conn, trn);
                    sqlcmd.ExecuteNonQuery();
                    if (pendingamt.Value == txtCurrPayment1.Text)
                    {
                        //string sql_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt=getdate(),voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                        string sql_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt='" + Transdate + "',voucherNo='" + voucherNo + "',PAYDT='" + Transdate + "' where BillNo='" + billbumber + "'";
                        
                        SqlCommand sqlcmd1 = new SqlCommand(sql_hdr, conn,trn);
                        sqlcmd1.ExecuteNonQuery();

                        //string sql_detail = "update WEBX_vendorbill_det set voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                        string sql_detail = "update WEBX_vendorbill_det set voucherNo='" + voucherNo + "',PAYDT='" + Transdate + "' where BillNo='" + billbumber + "'";
                        
                        SqlCommand sqlcmd2 = new SqlCommand(sql_detail, conn, trn);
                        sqlcmd2.ExecuteNonQuery();

                        /*string sql_thc_summary = "update WEBX_thc_summary set PaymentDt=getdate(),balvoucherNo='" + voucherNo + "',balvoucherdt=getdate() where vendorBENo='" + billbumber + "'";
                        SqlCommand sqlcmd3 = new SqlCommand(sql_thc_summary, conn, trn);
                        sqlcmd3.ExecuteNonQuery();

                        string sql_arch = "update WEBX_pdchdr set PaymentDt=getdate(),bal_voucherNo='" + voucherNo + "',bal_voucherdt=getdate() where vendorBENo='" + billbumber + "'";
                        SqlCommand sqlcmd4 = new SqlCommand(sql_arch, conn, trn);
                        sqlcmd4.ExecuteNonQuery();

                        sql_arch = "update WEBX_pdchdr set PaymentDt=getdate(),bal_voucherNo='" + voucherNo + "',bal_voucherdt=getdate() where vendorBENo='" + billbumber + "'";
                        sqlcmd4 = new SqlCommand(sql_arch, conn, trn);
                        sqlcmd4.ExecuteNonQuery();*/
                    }

                    else
                    {
                        //string sqlvendorbill_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt=getdate(),voucherNo='" + voucherNo + "',PAYDT=getdate() where BillNo='" + billbumber + "'";
                        string sqlvendorbill_hdr = "update WEBX_vendorbill_hdr set pendamt=isnull(pendamt,0)-" + currentpayment + ",finclosedt= '" + Transdate + "',voucherNo='" + voucherNo + "',PAYDT= '" + Transdate + "' where BillNo='" + billbumber + "'";
                       
                        SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn,trn);
                        sqlcmd5.ExecuteNonQuery();
                    }

                }
                else
                {

                }


            }



            string banknm = "";
            string ptmsptcd = vendorCode;
            string ptmsptnm = VendorName;
            string adjustamt = "", chequeDt = "";
            string comments = "NULL";
            string bacd = "null";
            string banm = "null";
            string empnm = "null";
            string staffcd = "Null";
            string staffnm = "Null";
            string branch = SessionUtilities.CurrentBranchCode.ToString();
            string branchname = fn.GetLocation(SessionUtilities.CurrentBranchCode.ToString());
            //string acccodedec = acccode.SelectedItem.ToString();
            if (transtype1 == "Bank")
            {
                string depositdt = System.DateTime.Today.ToString("dd MMM yyyy");
                CHQAMT1 = credit.ToString();//colamt.Text;
                Chqno11 = mtxtChqNo;//chqno.Text;
                //chqdt11 = chqdate.Text;
                chequeDt = fn.Mydate(mtxtChqDate);
                //chequeDt= mtxtChqDate;

                string sql_chqdet = "Insert into webx_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values('" + Chqno11 + "','" + chequeDt + "'," + CHQAMT1 + ",'" + banknm + "','" + ptmsptcd + "','" + ptmsptnm + "','" + comments + "','" + bacd + "','" + banm + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + "" + "','" + staffcd + "','" + staffnm + "',null,'O','" + "" + "','" + adjustamt + "')";
                SqlCommand sqlCommand_Cheque = new SqlCommand(sql_chqdet, conn, trn);
                sqlCommand_Cheque.ExecuteNonQuery();

                string sql_cheque_update = "update webx_chq_det set voucherNo='" + voucherNo + "',transdate='" + depositdt + "',acccode='" + accountcode + "',depoloccode='" + SessionUtilities.CurrentBranchCode.ToString() + "',DepoFlag='Y' where chqno='" + Chqno11 + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chequeDt + "',106)";
                SqlCommand sqlCommand_Cheq_Update = new SqlCommand(sql_cheque_update, conn, trn);
                sqlCommand_Cheq_Update.ExecuteNonQuery();
            }


            string sql_VTrans = "Insert into webx_vouchertrans (finyear,Transdate,Voucherno,OppAcccode,oppaccount,chqno,chqdate,Debit,Credit,Transtype,Currbalance,docno,brcd,Entryby,Entrydt,Voucher_Cancel,voucher_status,preparefor,empcdfor,servicetaxrate,servicetax,tdsrate,tds,othertaxrate,othChrg,OCTPaid,AgentServiceChrg,ServiceChargPaid,TotalDed,Netamt,PBOV_code,PBOV_Name,PBOV_typ,panno,servicetaxNo,bookcode,BANKNAME,CHQAMT,TRANSMODE,DEDUCTION,TotChrg,tdsacccode,svctaxacccode,servicetaxCharged,autoentry,acccode) values (" + finyear1 + ",'" + Transdate + "','" + voucherNo + "','" + accountcode + "','" + acccode1 + "','" + Chqno11 + "','" + chequeDt + "'," + debit + "," + credit + ",'" + transtype1 + "'," + Currbalance + ",'" + DocNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'N','Submitted','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + SessionUtilities.CurrentBranchCode.ToString() + "',0,0,0,0,0," + othChrg + ",0,0,0," + mamul_chrg + "," + credit + ",'" + PBOV_code + "','" + PBOV_Name + "','" + PBOV_typ + "','" + Panno1 + "','" + servicetaxNo + "','" + bookcode + "','" + BANKNAME + "'," + CHQAMT + ",'" + TRANSMODE + "'," + DEDUCTION + "," + TotChrg + ",'" + tdsacccode + "','" + svctaxacccode + "'," + servicetaxCharged + ",'Y','" + effected_acccode + "')";
            SqlCommand sqlCommand_Trnas = new SqlCommand(sql_VTrans, conn, trn);
            sqlCommand_Trnas.ExecuteNonQuery();

            string sql_TransArch = "Insert into webx_vouchertrans_arch select * from  webx_vouchertrans where voucherNo='" + voucherNo + "'";
            SqlCommand sqlCommand_TrnasArch = new SqlCommand(sql_TransArch, conn, trn);
            sqlCommand_TrnasArch.ExecuteNonQuery();

            string sql_VTrans_delete = "delete from webx_vouchertrans where voucherNo='" + voucherNo + "'";
            SqlCommand sqlCommand_TrnasDelete = new SqlCommand(sql_VTrans_delete, conn, trn);
            sqlCommand_TrnasDelete.ExecuteNonQuery();


            //string sql_voucher_act = "exec usp_Vendor_Payment_transaction_other 4,'" + voucherNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Financial_Year + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + voucherNo + "','" + SessionUtilities.DefaultCompanyCode.Trim() + "'";
            string sql_voucher_act = "exec usp_Vendor_Payment_transaction_other 4,'" + voucherNo + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + Financial_Year + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + voucherNo + "'";
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
    //protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();

    //    if (transtype.SelectedValue.ToString() != "")
    //    {
          
    //        string sql = "";

    //        if (transtype.SelectedValue.ToString() != "Cash")
    //        {
    //            sql = "select acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  (((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
    //        }
    //        else
    //        {
    //            sql = "select  acccode+'~'+acccategory+'~'+accdesc as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
    //        }
    //        SqlCommand sqlCommand = new SqlCommand(sql, conn);
    //        DataSet ds = new DataSet();

    //        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
    //        da.Fill(ds, "tab1");

    //        acccode.DataSource = ds;
    //        acccode.DataTextField = "accdesc";
    //        acccode.DataValueField = "asscodeval";
    //        acccode.DataBind();
    //        acccode.CssClass = "blackfnt";
    //    }
    //}
}
