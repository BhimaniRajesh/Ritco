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

public partial class GUI_Finance_voucher_Print_DebitVoucherPrint : System.Web.UI.Page
{
    string voucherno = "", printyn = "", YEAR_SUFFIX = "";
    SqlConnection con;

    protected void Page_Load(object sender, EventArgs e)
    {
        NumberToText ntt = new NumberToText();
        MyFunctions fn = new MyFunctions();

        voucherno = Request.QueryString["voucherno"].ToString();
        printyn = "N";

        lblvoucherno.Text = voucherno;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        string YEAR_SUFFIX = "";
        if (DateTime.Now.Month < 4)
            YEAR_SUFFIX = Session["YearVal"].ToString();//Convert.ToString((DateTime.Now.Year - 1)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year)).Substring(2, 2);
        else
            YEAR_SUFFIX = Session["YearVal"].ToString();//Convert.ToString((DateTime.Now.Year)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year + 1)).Substring(2, 2);

        //  Debit Voucher header information
        //  ================================
        string sql = "SELECT brcd, payto, convert(varchar, transdate, 6) as transdate, transtype,acccode,narration,credit,debit, convert(varchar, Chqdate, 6) as Chqdate FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            //  Variables to be initialized
            //lblaccdesc.Text = "";
            //lblcashtype.Text = "";

            lblbranch.Text = dr["brcd"].ToString() + fn.GetLocation(dr["brcd"].ToString());
            lblvoucherno.Text = voucherno;
            lbldate.Text = dr["transdate"].ToString();
            lblTotalCreditAmount.Text = dr["transtype"].ToString();
            //lblrecfrom.Text = dr["payto"].ToString();
            lblPayto.Text = dr["Payto"].ToString().ToUpper();
            lblvoucherheader.Text = "DEBIT VOUCHER";
            lbl_Cheque_Entry_Location.Text = dr["brcd"].ToString() + fn.GetLocation(dr["brcd"].ToString());
            lbl_Cheque_Entry_Date.Text = dr["Chqdate"].ToString().ToUpper();
        }

        dr.Close();
        //  End of Debit Voucher header information

        //  Debit Voucher Transaction details
        //  =================================
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
            "End As CreditAmount, Narration " +
            "FROM " + strTranTable + ", webx_acctinfo " +
            "WHERE " + strTranTable + ".acccode = webx_acctinfo.acccode " +
            "And " + strTranTable + ".voucherno = '" + voucherno + "' " +
            "Order By CreditAmount";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        rptrDebitVoucher.DataSource = dt;
        rptrDebitVoucher.DataBind();
        //  End of Debit Voucher Transaction details

        //  Debit Voucher footer information
        //  ================================
        sql = "SELECT Sum(debit) As TotalDebitAmount FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblTotalDebitAmount.Text = dr["TotalDebitAmount"].ToString();
            lblTotalCreditAmount.Text = dr["TotalDebitAmount"].ToString();
            lblinwords.Text = ntt.numberToText(lblTotalDebitAmount.Text);
        }

        dr.Close();
        //  End of Debit Voucher footer information
    }

    //protected string getAccountDesc(string acccode)
    //{
    //    string accdesc = "";
    //    string sql = "SELECT accdesc FROM webx_acctinfo WHERE acccode='" + acccode + "'";
    //    SqlCommand cd = new SqlCommand(sql,con);
    //    SqlDataReader dr = cd.ExecuteReader();
    //    while (dr.Read())
    //    {
    //        accdesc = dr[0].ToString();
    //        break;
    //    }
    //    dr.Close();
    //    return accdesc;
    //}
}
