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
using Microsoft.ApplicationBlocks.Data;

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
        imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        lblcompany.Text = Session["ClientName"].ToString();

        NumberToText ntt = new NumberToText();
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

        string sql = "select top 1 convert(varchar, a.transdate, 6) as VoucherDate,a.Brcd as PreparedAt,a.Entryby as PreparedBy,";
        sql += " isnull(a.Payto,'--') Payto,isnull(a.pbov_code,'--') pbov_code,isnull(a.pbov_name,'--') pbov_name,a.transtype";
        sql += " from  " + strTranTable + " a ";
        sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno='" + voucherno + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblVoucherdate.Text = dr["VoucherDate"].ToString();
            //LblManuavoucherno.Text = dr["Manual_Voucherno"].ToString();
            lblPreparedAt.Text = dr["PreparedAt"].ToString() + " : " + fn.GetLocation(dr["PreparedAt"].ToString());
            lblPreparedBY.Text = dr["PreparedBy"].ToString() + " : " + fn.GetEmpName(dr["PreparedBy"].ToString());
            //lblPreparefor.Text = dr["preparefor"].ToString();
            //lblRefno.Text = dr["Refno"].ToString();
            //LblNarration.Text = dr["narration"].ToString();
            lbl_Transtype.Text = dr["transtype"].ToString();
        }

        dr.Close();

        sql = "select b.company_acccode + ' : ' + b.accdesc AccountDescription,cast(debit as decimal(12,2)) DebitAmount,cast(credit as decimal(12,2)) CreditAmount,Narration,a.pbov_code + ' : ' + pbov_name Party";
        sql += " from " + strTranTable + " as a,Webx_acctinfo b";
        sql += " where isnull(a.voucher_cancel,'N')='N' and a.voucherno='" + lblvoucherno.Text + "' and a.acccode = b.acccode order by srno";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();

        sql = "select cast(sum(debit) as decimal(12,2)) DebitTotal,cast(sum(credit) as decimal(12,2)) CreditTotal ";
        sql += " from " + strTranTable + " where isnull(voucher_cancel,'N')='N' and voucherno='" + lblvoucherno.Text + "'";
        DataTable dtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];

        string amt2 = "";
        if (dtl.Rows.Count > 0)
        {
            amt2 = dtl.Rows[0]["DebitTotal"].ToString();
        }

        lblinwords.Text = ntt.numberToText(amt2).ToString() + ".";
        
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotDebitAmt = (Label)e.Row.FindControl("lblTotDebitAmt");
            Label lblTotCreditAmt = (Label)e.Row.FindControl("lblTotCreditAmt");

            string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            string fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

            string strTranTable = "webx_acctrans_" + fin_year;

            string sql = "select cast(sum(debit) as decimal(12,2)) DebitTotal,cast(sum(credit) as decimal(12,2)) CreditTotal ";
            sql += " from " + strTranTable + " where isnull(voucher_cancel,'N')='N' and voucherno='" + lblvoucherno.Text + "'";
            DataTable dtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];

            if (dtl.Rows.Count > 0)
            {
                lblTotDebitAmt.Text = dtl.Rows[0]["DebitTotal"].ToString();
                lblTotCreditAmt.Text = dtl.Rows[0]["CreditTotal"].ToString();
            }
        }
    }
}
