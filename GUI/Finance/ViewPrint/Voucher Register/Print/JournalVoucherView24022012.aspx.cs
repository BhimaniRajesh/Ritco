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

public partial class GUI_Finance_voucher_Print_JournalVoucherView : System.Web.UI.Page
{
    string voucherno = "", printyn = "", YEAR_SUFFIX = "";
    SqlConnection con;
    string Financial_Year = "", fin_year = "";
    public string border = "";

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
        RupeesToWords ntt = new RupeesToWords();
        MyFunctions fn = new MyFunctions();

        voucherno = Request.QueryString["voucherno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        lblvoucherno.Text = voucherno;
        lblvoucherheader.Text = "JOURNAL VOUCHER";

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        string YEAR_SUFFIX = fin_year;

        string strTranTable = "webx_acctrans_" + YEAR_SUFFIX;

        //string sql = "select top 1 convert(varchar, a.transdate, 6) as VoucherDate,b.Manual_Voucherno,b.Brcd as PreparedAt,";
        //sql += "b.Entryby as PreparedBy,Business_type=(select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type),";
        //sql += "b.Accounting_Brcd,b.preparefor,b.Refno,a.Payto,a.pbov_code,a.pbov_name,b.narration,b.chqno,convert(varchar,b.chqdate,6) Chqdate,a.transtype";
        //sql += " from  " + strTranTable + " a,webx_vouchertrans_arch b";
        //sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno=b.voucherno and a.voucherno='" + voucherno + "'";

        string sql = "select top 1 convert(varchar, a.transdate, 6) as VoucherDate,isnull(b.Manual_Voucherno,'--') Manual_Voucherno,a.Brcd as PreparedAt,a.Entryby as PreparedBy,";
        sql += " Case when (select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type) is null then '--' else ";
        sql += " (select CodeDesc from webx_master_general where codetype = 'BUT' and statuscode = 'Y' and codeid=b.Business_type) end as Business_type,";
        sql += " isnull(b.Accounting_Brcd,'--') Accounting_Brcd,isnull(b.preparefor,'--') preparefor,isnull(b.Refno,'--') Refno,";
        sql += " isnull(a.Payto,'--') Payto,isnull(a.pbov_code,'--') pbov_code,isnull(a.pbov_name,'--') pbov_name,isnull(b.narration,'--') narration,a.transtype";
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
            lblPreparefor.Text = dr["preparefor"].ToString();
            lblRefno.Text = dr["Refno"].ToString();
            LblNarration.Text = dr["narration"].ToString();
            lbl_Transtype.Text = dr["transtype"].ToString();
        }

        dr.Close();

        sql = "select b.company_acccode + ' : ' + b.accdesc AccountDescription,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(debit as decimal(12,2)) ELSE cast(round(debit,0) as decimal(12,2)) END) DebitAmount,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(credit as decimal(12,2)) ELSE cast(round(credit,0) as decimal(12,2)) END) CreditAmount,Narration,a.pbov_code + ' : ' + pbov_name Party";
        sql += " from " + strTranTable + " as a,Webx_acctinfo b";
        sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno='" + lblvoucherno.Text + "' and a.acccode = b.acccode order by srno";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        rptrJournalVoucher.DataSource = dt;
        rptrJournalVoucher.DataBind();

        sql = "select (CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(debit) as decimal(12,2)) ELSE cast(sum(round(debit,0)) as decimal(12,2)) END) DebitTotal,(CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(credit) as decimal(12,2)) ELSE cast(sum(round(credit,0)) as decimal(12,2)) END) CreditTotal ";
        sql += " from " + strTranTable + " where isnull(voucher_cancel,'N')='N' and voucherno='" + lblvoucherno.Text + "' GROUP BY Transtype";

        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblTotalDebitAmount.Text = dr["DebitTotal"].ToString();
            lblTotalCreditAmount.Text = dr["CreditTotal"].ToString();
        }

        dr.Close();

        double amt2 = Convert.ToDouble(lblTotalDebitAmount.Text);
        Int64 finalamt = Convert.ToInt64(amt2);

        lblinwords.Text = ntt.NumberToText(finalamt).ToString() + " Only.";

    }
}
