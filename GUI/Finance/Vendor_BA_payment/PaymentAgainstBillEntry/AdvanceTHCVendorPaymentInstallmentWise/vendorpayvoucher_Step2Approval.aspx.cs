using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_vendorpayvoucher_Step2Approval : System.Web.UI.Page
{
    
    string doc, vendor, from, to;
    //string strDateRange;
    public string Panno1, accountcode, SqlDisplay = "", s2 = "";
    public string VendorBill, VehicleNo, DocumentNo;
    //public string[] accountcode1;
    public static string strsession1, strsession2, Financial_Year = "";
    //DateTime f = new DateTime();
    //DateTime t = new DateTime();
    public static string fromdt, todt, Todt, Fromdt, voucherNo;
    //DateTime Fromdate, Todate;
    int i;
    MyFunctions fn = new MyFunctions();
    public static int intCurrentPageNo, intTotalRecords = 0;
    //static int intPageSize = 10;
    public string vendorCode = "", VendorName = "", effected_acccode = "", Location = "";
    //public double debit, credit;
    //public double servicetaxrate, OCTPaid, AgentServiceChrg, ServiceChargPaid, TotalDed, TotChrg, CHQAMT, DEDUCTION, othChrg, tdsrate, servicetaxCharged, Currbalance, mamul_chrg;
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
            DisplayVendorBilllist();
            foreach (GridViewRow gridrow in BillDetail.Rows)
            {
                TextBox txtTotal1 = (TextBox)gridrow.FindControl("txtTotal");
                HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
                HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
                HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");
                vendorCode = vendorcode.Value.ToString();
                VendorName = vendorname.Value.ToString();
                effected_acccode = Acccode.Value.ToString();
            }

        }
        btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit()");
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
            SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0 and h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) AND ISNULL(BillApproval,'N')='N' AND ISNULL(ts.cancelled,'N')<>'Y'";
            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            if (intTotalRecords > 0)
            {
                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
            }
            BillDetail.DataBind();
        }
        else if (VendorBill != "")
        {
            lblVendor.Text = "-";
            lblVendor1.Text = "-";

            VendorBillArray = VendorBill.Split(',');

            for (i = 0; i < VendorBillArray.Length; i++)
            {
                s2 += "'" + VendorBillArray[i] + "',";
                doc += VendorBillArray[i] + ",";
            }

            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0  and h.BILLDT in (" + s2 + ") AND ISNULL(BillApproval,'N')='N' AND ISNULL(ts.cancelled,'N')<>'Y'";//and vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            if (intTotalRecords > 0)
            {
                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
            }
            BillDetail.DataBind();
        }
        else if (DocumentNo != "")
        {
            lblVendor.Text = "-";
            lblVendor1.Text = "-";

            DocumentArray = DocumentNo.Split(',');
            string doc = "";
            for (i = 0; i < DocumentArray.Length; i++)
            {
                s2 += "'" + DocumentArray[i] + "',";
                doc += DocumentArray[i] + ",";
            }
            s2 = s2.Substring(0, s2.Length - 1);
            SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0   and h.BILLNO in (" + s2 + ") AND ISNULL(BillApproval,'N')='N' AND ISNULL(ts.cancelled,'N')<>'Y'";//vendorBILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106)

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            intTotalRecords = ds.Tables[0].Rows.Count;
            BillDetail.DataSource = ds;
            if (intTotalRecords > 0)
            {
                lblVendor1.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
                lblVendor.Text = fn.GetVendor(ds.Tables[0].Rows[0][10].ToString());
            }

            BillDetail.DataBind();
        }
        else if (vendorCode != "0")
        {
            BillDtRow.Visible = true;
            VendorRow.Visible = true;
            lblVendor1.Text = fn.GetVendor(vendorCode);
            SqlDisplay = "select Convert(varchar,h.BILLDT,106) as VendorBill_DT , Convert(varchar,(GETDATE()+30),106) as Due_DT,(h.Amount-isnull(h.PendAmount,h.Amount)) as Advpaid, (select SERVTAXNO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as SERVTAXNO,(select PAN_NO from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) as PAN_NO,Convert(varchar,h.BILLDT,103) as VendorBill_DT1,Convert(varchar,Thcdt,106) as ThcDate,ts.Vehno,(select VENDORNAME from webx_vendor_hdr where vendorcode=ad.OthAdvVendor) AS vendorname,ad.thcno,ad.OthAdvVendor AS Thcvendorcode,ad.OthAdvReferenceNo,ad.OthAdvUnit,h.Amount AS netamt,ad.OthAdvVendor AS vendorcode,h.pendamount AS pendamt,h.BILLNO AS vendorBILLNO,h.BILLNO,'' AS Acccode from WEBX_THC_OTHER_ADVANCE_BILL h INNER JOIN Webx_Thc_AdvanceInstalment_Det ad ON h.BILLNO=ad.BillNo INNER JOIN webx_THC_SUMMARY ts ON ad.ThcNo=ts.thcno where  isnull(h.pendamount,0)>0 and h.BILLDT between convert(varchar,'" + fromdt + "',106) and convert(varchar,'" + todt + "',106) and ad.OthAdvVendor='" + vendorCode + "' and ad.branchcode='" + Location + "' AND ISNULL(BillApproval,'N')='N' AND ISNULL(ts.cancelled,'N')<>'Y'";

            SqlCommand cmd = new SqlCommand(SqlDisplay, conn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            sqlDA.Fill(ds);

            intTotalRecords = ds.Tables[0].Rows.Count;

            if (intTotalRecords > 0)
            {

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
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string finyear = System.DateTime.Today.ToString("yy");
        foreach (GridViewRow gridrow in BillDetail.Rows)
        {

            HiddenField vendorcode = (HiddenField)gridrow.FindControl("vendorcode");
            HiddenField vendorname = (HiddenField)gridrow.FindControl("vendorname");
            HiddenField Acccode = (HiddenField)gridrow.FindControl("Acccode");
            vendorCode = vendorcode.Value.ToString();
            VendorName = vendorname.Value.ToString();
            effected_acccode = Acccode.Value.ToString();
        }
        SqlTransaction trn;
        trn = conn.BeginTransaction();
        string PBOV_code = vendorCode;// pbov_arr[0];
        string PBOV_Name = VendorName;// pbov_arr[1];
        string finyear1 = System.DateTime.Today.ToString("yyyy");
        string BillNoString = "";
        try
        {
            foreach (GridViewRow gridrow in BillDetail.Rows)
            {
                CheckBox chkBill1 = (CheckBox)gridrow.FindControl("chkBill");
                Label BILLNO1 = (Label)gridrow.FindControl("BILLNO");
                Label netamt1 = (Label)gridrow.FindControl("netamt");
                Label pendamt1 = (Label)gridrow.FindControl("pendamt");
                HiddenField pendingamt = (HiddenField)gridrow.FindControl("pendingamt");
                if (chkBill1.Checked == true)
                {
                    if (BillNoString == "")
                    {
                        BillNoString = BILLNO1.Text;

                    }
                    else
                    {
                        BillNoString = BillNoString + "," + BILLNO1.Text;
                    }

                    string sqlvendorbill_hdr = "update Webx_Thc_AdvanceInstalment_Det set BillApproval='Y',BillApprovalBy='" + Session["empcd"].ToString() + "',BillApprovalDate=GETDATE() where BillNo='" + BILLNO1.Text + "'";
                        SqlCommand sqlcmd5 = new SqlCommand(sqlvendorbill_hdr, conn, trn);
                        sqlcmd5.ExecuteNonQuery(); 
                }
            }
            trn.Commit();
            //trn.Rollback();
            conn.Close();
            string final;
            final = "?DocumentNo=" + BillNoString;
            Response.Redirect("VendorPaymentBillApprovalDone.aspx" + final,false);
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            Response.End();
        }
    }
}