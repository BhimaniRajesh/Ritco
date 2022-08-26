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
    string voucherno = "", printyn = "", YEAR_SUFFIX = "", TBLNAME="";
    SqlConnection con;
    public string  Financial_Year = "", fin_year = "", FinancialYear = "", Finyear = "";
    public string border = "";
    protected void Page_Load(object sender, EventArgs e)
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
        
        RupeesToWords ntt = new RupeesToWords();
        MyFunctions fn = new MyFunctions();
        lblvoucherheader.Text = "SPECIAL COST VOUCHER";        

        lblvoucherno.Text = voucherno;
        //con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
        con.Open();

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
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

        //string YEAR_SUFFIX = fin_year;

        string strTranTable = "webx_acctrans_" + YEAR_SUFFIX;
       
        //  Debit Voucher header information
        //  ================================
        string sql = "select top 1 convert(varchar, a.transdate, 6) as VoucherDate,b.Manual_Voucherno,b.Brcd as PreparedAt,";
        sql += "b.Entryby as PreparedBy,Business_type=(select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type),b.Accounting_Brcd,b.preparefor,b.Refno,a.Payto,a.pbov_code,";
        sql += "a.pbov_name,b.narration,b.chqno,convert(varchar,b.chqdate,6) Chqdate,a.transtype,b.transmode";
        sql += " from  " + strTranTable + " a";
        sql += " inner join webx_vouchertrans_arch b on a.voucherno=b.voucherno";
        sql += " and a.voucher_cancel='N' and a.voucherno='" + voucherno + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {   
            lblvoucherheader.Text = "SPECIAL COST VOUCHER";
            lblvoucherno.Text = voucherno;
            lblvoucherdate.Text = dr["VoucherDate"].ToString();
            LblManuavoucherno.Text = dr["Manual_Voucherno"].ToString();
            lblPreparedLoc.Text = dr["PreparedAt"].ToString() + " : " + fn.GetLocation(dr["PreparedAt"].ToString());
            lblPreparedBY.Text = dr["PreparedBy"].ToString() + " : " + fn.GetEmpName(dr["PreparedBy"].ToString());
            LblBusiness_type.Text = dr["Business_type"].ToString();
            lblAcctloc.Text = dr["Accounting_Brcd"].ToString() + " : " + fn.GetLocation(dr["Accounting_Brcd"].ToString());
            lblPreparefor.Text = dr["preparefor"].ToString();
            lblRefno.Text = dr["Refno"].ToString();
            lblPayto.Text = dr["PBOV_CODE"].ToString().ToUpper() + " : " + dr["PBOV_NAME"].ToString().ToUpper();
            Lbl_Narration.Text = dr["narration"].ToString();
            if (dr["transmode"].ToString() != "Cash")
                lbl_Cheque_Entry_Date.Text = dr["chqno"].ToString() + " | " + dr["Chqdate"].ToString().ToUpper();
            else
                lbl_Cheque_Entry_Date.Text = " -- ";
            lbl_Transtype.Text = dr["transtype"].ToString();

        }

        dr.Close();
        //  End of Debit Voucher header information

        //  Debit Voucher Transaction details
        //  =================================

        sql = "select b.company_acccode + ' : ' + b.accdesc AccountDescription,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(debit as decimal(12,2)) ELSE cast(round(debit,0) as decimal(12,2)) END) DebitAmount,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(credit as decimal(12,2)) ELSE cast(round(credit,0) as decimal(12,2)) END) CreditAmount,Narration,";
        sql += "Docno,DocType=(select CodeDesc from webx_master_general where codetype='DOCS' and CodeId=DocType)";
        sql += " from " + strTranTable + " as a";
        sql += " inner join Webx_acctinfo b on a.acccode = b.acccode and a.voucherno='" + lblvoucherno.Text + "'";
        sql += " and a.voucher_cancel='N' order by srno";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        rptrDebitVoucher.DataSource = dt;
        rptrDebitVoucher.DataBind();

        //  End of Debit Voucher Transaction details

        //  Debit Voucher footer information (Sum Of Debit and Credit Amount)
        //  ================================

        sql = "select (CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(debit) as decimal(12,2)) ELSE cast(sum(round(debit,0)) as decimal(12,2)) END) DebitTotal,(CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(credit) as decimal(12,2)) ELSE cast(sum(round(credit,0)) as decimal(12,2)) END) CreditTotal ";
        sql += " from " + strTranTable + " where voucher_cancel='N' and voucherno='" + lblvoucherno.Text + "' GROUP BY Transtype";

        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblTotalDebitAmount.Text = dr["DebitTotal"].ToString();
            lblTotalCreditAmount.Text = dr["CreditTotal"].ToString();
        }

        dr.Close();

        double amt2 = Convert.ToDouble(lblTotalDebitAmount.Text);
        Int64 debitamt = Convert.ToInt64(amt2);

        lblinwords.Text = ntt.NumberToText(debitamt).ToString() + " Only.";
        
        // Code For Account Head Information
        string strAccHead = "";

        //SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
        conn2.Open();

        string Sql2 = "select b.company_acccode + ' : ' + b.accdesc as AccountHeader from " + strTranTable + " a,webx_acctinfo b where a.acccode=b.acccode and a.voucher_cancel='N' and b.Acccategory != 'TDS' and a.voucherno='" + lblvoucherno.Text + "' and a.debit = 0";
        SqlCommand sqlCommand2 = new SqlCommand(Sql2, conn2);
        SqlDataReader dr2;
        dr2 = sqlCommand2.ExecuteReader();

        while (dr2.Read())
        {
            strAccHead = strAccHead + " , " + dr2["AccountHeader"].ToString();
        }
        dr2.Close();

        lblAccHead.Text = strAccHead.Substring(2).ToString();

    }

   
}
