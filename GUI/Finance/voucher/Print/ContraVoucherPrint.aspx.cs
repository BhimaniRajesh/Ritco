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

public partial class GUI_Finance_voucher_Print_ContraVoucherPrint : System.Web.UI.Page
{
    SqlConnection con;

    // CONSTANT DECLARATIONS
    string YEAR_SUFFIX = "", TBL_NAME = "";

    string voucherno = "", transtype = "", autoentry = "", printyn = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        NumberToText ntt = new NumberToText();
        MyFunctions fn = new MyFunctions();

        string branch = "";
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        voucherno = Request.QueryString["voucherno"].ToString();
        printyn = "N";
        lblvoucherno.Text = voucherno;

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        string YEAR_SUFFIX = "";
        if (DateTime.Now.Month < 4)
            YEAR_SUFFIX = Convert.ToString((DateTime.Now.Year - 1)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year)).Substring(2, 2);
        else
            YEAR_SUFFIX = Convert.ToString((DateTime.Now.Year)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year + 1)).Substring(2, 2);

        //  Contra Voucher header information
        //  =================================
        string sql = "SELECT brcd, payto, convert(varchar, transdate, 6) as transdate, transtype,acccode,narration,credit,debit FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblvoucherno.Text = voucherno;
            lblvoucherdate.Text = dr["transdate"].ToString();
            lblNarration.Text = dr["Narration"].ToString();
        }

        dr.Close();
        //  End of Contra Voucher header information

        //  Contra Voucher Transaction details
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
            "End As CreditAmount " +
            "FROM " + strTranTable + ", webx_acctinfo " +
            "WHERE " + strTranTable + ".acccode = webx_acctinfo.acccode " +
            "And " + strTranTable + ".voucherno = '" + voucherno + "' " +
            "Order By CreditAmount";

        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();

        da.Fill(dt);
        rptrContraVoucher.DataSource = dt;
        rptrContraVoucher.DataBind();
        //  End of Debit Voucher Transaction details
    }
}
