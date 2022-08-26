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

public partial class GUI_Finance_voucher_Print_ContraVoucherView : System.Web.UI.Page
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
        NumberToText ntt = new NumberToText();
        MyFunctions fn = new MyFunctions();

        voucherno = Request.QueryString["voucherno"].ToString();
        printyn = Request.QueryString["printyn"].ToString();

        lblvoucherno.Text = voucherno;
        lblvoucherheader.Text = "CONTRA VOUCHER";

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        string YEAR_SUFFIX = fin_year;

        string strTranTable = "webx_acctrans_" + YEAR_SUFFIX;

        //  Contra Voucher header information
        //  ================================
        string sql = "select convert(varchar, a.transdate, 6) as VoucherDate,b.Manual_Voucherno,b.Brcd as PreparedAt,";
        sql += "b.Entryby as PreparedBy,b.Refno,b.narration,a.transtype";
        sql += " from  " + strTranTable + " a,webx_vouchertrans_arch b";
        sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno=b.voucherno and a.voucherno='" + voucherno + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblVoucherdate.Text = dr["VoucherDate"].ToString();
            LblManuavoucherno.Text = dr["Manual_Voucherno"].ToString();
            lblPreparedAt.Text = dr["PreparedAt"].ToString() + " : " + fn.GetLocation(dr["PreparedAt"].ToString());
            lblPreparedBY.Text = dr["PreparedBy"].ToString() + " : " + fn.GetEmpName(dr["PreparedBy"].ToString());
            lblRefno.Text = dr["Refno"].ToString();
            LblNarration.Text = dr["narration"].ToString();
            lbl_Transtype.Text = dr["transtype"].ToString();
        }

        dr.Close();

        sql = "select b.company_acccode + ' : ' + b.accdesc AccountDescription,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(debit as decimal(12,2)) ELSE cast(round(debit,0) as decimal(12,2)) END) DebitAmount,(CASE WHEN a.Transtype='BANK PAYMENT' OR a.Transtype='BANK RECEIPT' THEN cast(credit as decimal(12,2)) ELSE cast(round(credit,0) as decimal(12,2)) END) CreditAmount,Chqno,convert(varchar,Chqdate,106) Chqdate,Narration";
        sql += " from " + strTranTable + " as a,Webx_acctinfo b";
        sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno='" + lblvoucherno.Text + "' and a.acccode = b.acccode";
        sql += " union select AccountDescription='Total',DebitAmount=sum(cast(round(debit,0) as decimal(12,2))),";
        sql += " CreditAmount=sum(cast(round(credit,0) as decimal(12,2))),Chqno='',Chqdate='',Narration=''";
        sql += " from " + strTranTable + " where isnull(voucher_cancel,'N')='N' and voucherno='" + lblvoucherno.Text + "'"; 
        
        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
        
        //  Contra Voucher footer information
        //  ================================
        sql = "select (CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(debit) as decimal(12,2)) ELSE cast(sum(round(debit,0)) as decimal(12,2)) END) DebitTotal,(CASE WHEN Transtype='BANK PAYMENT' OR Transtype='BANK RECEIPT' THEN cast(sum(credit) as decimal(12,2)) ELSE cast(sum(round(credit,0)) as decimal(12,2)) END) CreditTotal ";
        sql += " from " + strTranTable + " where isnull(voucher_cancel,'N')='N' and voucherno='" + lblvoucherno.Text + "' GROUP BY Transtype";

        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {   
            lblinwords.Text = ntt.numberToText(dr["CreditTotal"].ToString()).ToString();
        }

        dr.Close();
    }
}
