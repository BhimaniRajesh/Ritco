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

public partial class GUI_Finance_voucher_Print_CreditVoucherPrint : System.Web.UI.Page
{
    string voucherno = "", printyn = "", YEAR_SUFFIX = "";
    SqlConnection con;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        NumberToText ntt = new NumberToText();
        MyFunctions fn = new MyFunctions();
        string sql;

        voucherno = Request.QueryString["voucherno"].ToString();

        lblvoucherno.Text = voucherno;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        string YEAR_SUFFIX = "";

        if (DateTime.Now.Month < 4)
            YEAR_SUFFIX = Session["YearVal"].ToString();//Convert.ToString((DateTime.Now.Year - 1)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year)).Substring(2, 2);
        else
            YEAR_SUFFIX = Session["YearVal"].ToString();//Convert.ToString((DateTime.Now.Year)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year + 1)).Substring(2, 2);

        //YEAR_SUFFIX = "08_09";

        //  Credit Voucher header information
        //  =================================
        sql = "SELECT brcd, ReceivedFrom, Narration, convert(varchar, transdate, 6) as transdate, transtype,acccode,narration,credit,debit FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            //  Variables to be initialized
            //lblaccdesc.Text = "";
            //lblcashtype.Text = "";

            lblbranch.Text = dr["brcd"].ToString() + fn.GetLocation(dr["brcd"].ToString());
            lblvoucherno.Text = voucherno;
            //lblrecfrom.Text = dr["payto"].ToString();
            lbldate.Text = dr["transdate"].ToString();
            lblTotalCreditAmount.Text = dr["transtype"].ToString();
            lblrecfrom.Text = dr["ReceivedFrom"].ToString().ToUpper();
            //lblNarration.Text = dr["Narration"].ToString().ToUpper();
            lblvoucherheader.Text = "CREDIT VOUCHER";
        }

        dr.Close();
        //  End of Credit Voucher header information

        //  Cheque information
        //  ==================
        sql = "Select chqno, Convert(VarChar, chqdt, 106) As chqdt, banknm, BANKBRN From WEBX_chq_det WHERE voucherno='" + voucherno + "'";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lbl_Cheque_Number.Text = dr["chqno"].ToString();
            lbl_Cheque_Date.Text = dr["chqdt"].ToString();
            lbl_Bank_Name.Text = dr["banknm"].ToString();
            lbl_Banch_Name.Text = dr["BANKBRN"].ToString();
        }

        dr.Close();
        //  End of Cheque information
        //  =========================

        //  Credit Voucher Transaction details
        //  ==================================
        string strTranTable = "webx_acctrans_" + YEAR_SUFFIX;

        sql = "SELECT webx_acctinfo.accdesc + ':' + " +
            strTranTable + ".acccode As AccountDescription, " +
            "Case " + strTranTable + ".debit " +
                "When 0.00 Then Null " +
                "Else " + strTranTable + ".debit " +
            "End As DebitAmount, " +
            "Case " + strTranTable + ".credit " +
                "When 0.00 Then Null " +
                "Else " + strTranTable + ".credit " +
            "End As CreditAmount, " +
            "Narration " +
            "FROM " + strTranTable + ", webx_acctinfo " +
            "WHERE " + strTranTable + ".acccode = webx_acctinfo.acccode " +
            "And " + strTranTable + ".voucherno = '" + voucherno + "' " +
            "Order By DebitAmount";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        rptrDebitVoucher.DataSource = dt;
        rptrDebitVoucher.DataBind();
        //  End of Credit Voucher Transaction details

        //  Credit Voucher footer information
        //  =================================
        sql = "SELECT Sum(round(credit,0)) As TotalCreditAmount FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblTotalDebitAmount.Text = dr["TotalCreditAmount"].ToString();
            lblTotalCreditAmount.Text = dr["TotalCreditAmount"].ToString();
            lblinwords.Text = ntt.numberToText(lblTotalDebitAmount.Text);
        }

        dr.Close();
        //  End of Credit Voucher footer information
    }
}
