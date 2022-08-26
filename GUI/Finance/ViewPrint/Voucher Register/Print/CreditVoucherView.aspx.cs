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

public partial class GUI_Finance_voucher_Print_DebitVoucherView : System.Web.UI.Page
{
    string voucherno = "", printyn = "", YEAR_SUFFIX = "";
    SqlConnection con;
    string  Financial_Year = "", fin_year = "";
    string FinancialYear = "", Finyear = "";
    public string border = "";
    public string boxbg = "";

    protected void Page_PreInit(object sender, EventArgs e)
    {
        voucherno = Request.QueryString["voucherno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        if (printyn == "Y")
        {
            border = "1";
            this.Theme = "Print";
            formbody.Attributes.Add("onload", "javascript:window.print();");
            border = "1";
        }
        else
        {
            border = "0";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        voucherno = Request.QueryString["voucherno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        RupeesToWords ntt = new RupeesToWords();
        MyFunctions fn = new MyFunctions();
        
        lblvoucherno.Text = voucherno;
        lblvoucherheader.Text = "CREDIT VOUCHER";

        //con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
        con.Open();

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        //Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        //fin_year = Session["FinYear"].ToString();
        //double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        //fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        //string YEAR_SUFFIX = fin_year;

        if (Request.QueryString["finyear"] != null)
        {
            FinancialYear = Request.QueryString["finyear"].ToString();
            Finyear = FinancialYear.Substring(2, 2);
        }
        else
        {
            FinancialYear = Session["FinYear"].ToString();
            Finyear = FinancialYear.Substring(2, 2);
        }

        string CloseYear = Convert.ToString((Convert.ToInt16(FinancialYear) + 1));
        if (CloseYear.Length == 1)
            CloseYear = "0" + CloseYear;
        CloseYear = CloseYear.Substring(2, 2);
        YEAR_SUFFIX = Finyear + "_" + CloseYear;

        string strTranTable = "webx_acctrans_" + YEAR_SUFFIX;

        //  Credit Voucher header information
        //  ================================
        //string sql = "select top 1 convert(varchar, a.transdate, 6) as VoucherDate,b.Manual_Voucherno,b.Brcd as PreparedAt,";
        //sql += "b.Entryby as PreparedBy,Business_type=(select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type),";
        //sql += "b.Accounting_Brcd,b.preparefor,b.Refno,a.Payto,a.pbov_code,a.pbov_name,b.narration,b.chqno,convert(varchar,b.chqdate,6) Chqdate,a.transtype,b.transmode";
        //sql += " from  " + strTranTable + " a,webx_vouchertrans_arch b";
        //sql += " where a.voucherno=b.voucherno and isnull(a.voucher_cancel,'N')='N' and a.voucherno='" + voucherno + "'";

        string sql = "select top 1 convert(varchar, a.transdate, 6) as VoucherDate,isnull(b.Manual_Voucherno,'--') Manual_Voucherno,a.Brcd as PreparedAt,a.Entryby as PreparedBy,";
        sql += " Case when (select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type) is null then '--' else ";
        sql += " (select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type) end as Business_type,";
        sql += " isnull(b.Accounting_Brcd,'--') Accounting_Brcd,isnull(b.preparefor,'--') preparefor,isnull(b.Refno,'--') Refno,";
        sql += " isnull(a.Payto,'--') Payto,isnull(a.pbov_code,'--') pbov_code,isnull(a.pbov_name,'--') pbov_name,";
        sql += " isnull(b.narration,'--') narration,(case when isnull(RTrim(LTrim(a.chqno)),'')='' OR RTrim(LTrim(a.chqno))='null' Then '--' else a.chqno end) as chqno,";
        sql += " isnull(convert(varchar,a.chqdate,6),'--') Chqdate,a.transtype,";
        //sql += " Entryby = (case when isnull(a.Entryby,'')='' then '--' else a.Entryby end),";
        sql += " Entryby =(Select Top 1 EntryBy From Webx_MR_Hdr where MRSNO=a.DocNo),";
        sql += " transmode = case when a.transtype='Cash Receipt' then 'Cash' else case when a.transtype='Bank Receipt' then 'Bank' else case when a.transtype='Both Receipt' then 'Both' end end end ";
        sql += " from  " + strTranTable + " a left outer join webx_vouchertrans_arch b on a.voucherno=b.voucherno ";
        sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno='" + voucherno + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblVoucherdate.Text = dr["VoucherDate"].ToString();
            LblManuavoucherno.Text = dr["Manual_Voucherno"].ToString();
            lblPreparedAt.Text = dr["PreparedAt"].ToString() + " : " + fn.GetLocation(dr["PreparedAt"].ToString());
            lblPreparedBY.Text = dr["PreparedBy"].ToString() + " : " + fn.GetEmpName(dr["PreparedBy"].ToString());
            LblBusiness_type.Text = dr["Business_type"].ToString();
            if (dr["Accounting_Brcd"].ToString().CompareTo("--") == 0)
                lblAcctloc.Text = dr["Accounting_Brcd"].ToString();
            else
                lblAcctloc.Text = dr["Accounting_Brcd"].ToString() + " : " + fn.GetLocation(dr["Accounting_Brcd"].ToString());
            //lblAcctloc.Text = dr["Accounting_Brcd"].ToString() + " : " + fn.GetLocation(dr["Accounting_Brcd"].ToString());
            lblPreparefor.Text = dr["preparefor"].ToString();
            lblRefno.Text = dr["Refno"].ToString();
            if (dr["Payto"].ToString().CompareTo("--") == 0 && dr["PBOV_CODE"].ToString().CompareTo("--") == 0)
                lblPayto.Text = "--";
            else if (dr["Payto"].ToString().CompareTo("--") == 0 && dr["PBOV_CODE"].ToString().CompareTo("--") != 0)
                lblPayto.Text = dr["PBOV_CODE"].ToString().ToUpper() + " : " + dr["PBOV_NAME"].ToString().ToUpper();
            else if (dr["Payto"].ToString().CompareTo("--") != 0 && dr["PBOV_CODE"].ToString().CompareTo("--") != 0)
                lblPayto.Text = dr["PBOV_CODE"].ToString().ToUpper() + " : " + dr["PBOV_NAME"].ToString().ToUpper();
            else if (dr["Payto"].ToString().CompareTo("--") != 0 && dr["PBOV_CODE"].ToString().CompareTo("--") == 0)
                lblPayto.Text = dr["Payto"].ToString().ToUpper();
            //lblPayto.Text = dr["pbov_code"].ToString().ToUpper() + " : " + dr["pbov_name"].ToString().ToUpper();
            LblNarration.Text = dr["narration"].ToString();
            if (dr["transmode"].ToString() != "Cash")
                lbl_Cheque_Entry_Date.Text = dr["chqno"].ToString().ToUpper() + " : " + dr["Chqdate"].ToString().ToUpper();
            else
                lbl_Cheque_Entry_Date.Text = "--";

            lbl_Transtype.Text = dr["transtype"].ToString();

            if (dr["Entryby"].ToString() != "--")
                lbl_Entryby.Text = dr["Entryby"].ToString() + " : " + fn.GetEmpName(dr["Entryby"].ToString()).ToString();
            else
                lbl_Entryby.Text = dr["Entryby"].ToString();
        }

        dr.Close();
        //  End of Debit Voucher header information

        //  Credit Voucher Transaction details
        //  =================================
        //string strTranTable = "webx_acctrans_" + YEAR_SUFFIX;

        sql = "select b.company_acccode + ' : ' + b.accdesc AccountDescription,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(debit as decimal(12,2)) ELSE cast(round(debit,0) as decimal(12,2)) END) DebitAmount,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(credit as decimal(12,2)) ELSE cast(round(credit,0) as decimal(12,2)) END) CreditAmount,Narration";
        sql += " from " + strTranTable + " as a,Webx_acctinfo b";
        sql += " where a.voucherno='" + lblvoucherno.Text + "' and UPPER(a.Transtype)<>'JOURNAL' and isnull(a.voucher_cancel,'N')='N' and a.acccode = b.acccode order by srno";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        rptrCreditVoucher.DataSource = dt;
        rptrCreditVoucher.DataBind();
        //  End of Credit Voucher Transaction details

        //  Credit Voucher footer information
        //  ================================
        sql = "select (CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(debit) as decimal(12,2)) ELSE cast(sum(round(debit,0)) as decimal(12,2)) END) DebitTotal,(CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(credit) as decimal(12,2)) ELSE cast(sum(round(credit,0)) as decimal(12,2)) END) CreditTotal ";
        sql += " from " + strTranTable + " where isnull(voucher_cancel,'N')='N' and UPPER(Transtype)<>'JOURNAL' and voucherno='" + lblvoucherno.Text + "' GROUP BY Transtype";

        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblTotalDebitAmount.Text = dr["DebitTotal"].ToString();
            lblTotalCreditAmount.Text = dr["CreditTotal"].ToString();
        }

        dr.Close();

        double amt2 = Convert.ToDouble(lblTotalDebitAmount.Text);
        Int64 creditamt = Convert.ToInt64(amt2);

        lblinwords.Text = ntt.NumberToText(creditamt).ToString() + " Only.";

        //Code For Account Head Information
        string strAccHead = "";

        sql = "select b.company_acccode + ' : ' + b.accdesc as AccountHeader from " + strTranTable + " a,webx_acctinfo b where a.acccode=b.acccode and b.Acccategory != 'TDS' and a.voucherno='" + lblvoucherno.Text + "' and a.credit = 0 and isnull(a.voucher_cancel,'N')='N'";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            strAccHead = strAccHead + " , " + dr["AccountHeader"].ToString();
        }

        dr.Close();
        if (strAccHead != "")
            lblAccHead.Text = strAccHead.Substring(2).ToString();

        //  End of credit Voucher footer information
    }
}
