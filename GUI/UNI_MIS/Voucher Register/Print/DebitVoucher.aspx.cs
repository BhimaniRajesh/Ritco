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

public partial class GUI_Finance_DebitCredit_DebitVoucher : System.Web.UI.Page
{
    string voucherno = "", printyn = "",YEAR_SUFFIX="";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        voucherno=Request.QueryString["voucherno"].ToString();
        printyn=Request.QueryString["printyn"].ToString();
        lblvoucherno.Text = voucherno;
        MyFunctions fn = new MyFunctions();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        string YEAR_SUFFIX = "";
        if (DateTime.Now.Month < 4)
            YEAR_SUFFIX = Convert.ToString((DateTime.Now.Year - 1)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year)).Substring(2, 2);
        else
            YEAR_SUFFIX = Convert.ToString((DateTime.Now.Year)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year + 1)).Substring(2, 2);

        // FILLING DATA VALUES
        string sql = "SELECT brcd,payto,convert(varchar,transdate,6) as transdate,transtype,acccode,narration,credit,debit FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblbranch.Text = dr["brcd"].ToString() + fn.GetLocation(dr["brcd"].ToString());
            lblvoucherno.Text = voucherno;
            lblrecfrom.Text = dr["payto"].ToString();
            lbldate.Text = dr["transdate"].ToString();
            if (dr["narration"].ToString() != "")
            {
                lblnarration.Text = dr["narration"].ToString().ToUpper();
            }
            if (dr["transtype"].ToString().ToUpper().CompareTo("CASH PAYMENT") == 0 || dr["transtype"].ToString().ToUpper().CompareTo("BANK PAYMENT") == 0)
            {
                lblvoucherheader.Text = "DEBIT VOUCHER";
                lbltotalrs.Text=dr["debit"].ToString();
                NumberToText ntt = new NumberToText();
                lblinwords.Text = ntt.numberToText(lbltotalrs.Text);
            }
            else if (dr["transtype"].ToString().ToUpper().CompareTo("CASH RECEIPT") == 0 || dr["transtype"].ToString().ToUpper().CompareTo("BANK RECEIPT") == 0)
            {
                lblvoucherheader.Text = "CREDIT VOUCHER";
                lbltotalrs.Text = dr["credit"].ToString();
                NumberToText ntt = new NumberToText();
                lblinwords.Text = ntt.numberToText(lbltotalrs.Text);
            }
            else if (dr["transtype"].ToString().ToUpper().CompareTo("JOURNAL") == 0)
            {
                Response.Redirect("JournalVoucher.aspx?voucherno=" + voucherno + "&printyn=" + printyn);
            }


             lblaccno.Text = dr["acccode"].ToString();
        }
        dr.Close();
        lblaccno.Text = lblaccno.Text + " : " + getAccountDesc(lblaccno.Text);

    }

    protected string getAccountDesc(string acccode)
    {
        string accdesc = "";
        string sql = "SELECT accdesc FROM webx_acctinfo WHERE acccode='" + acccode + "'";
        SqlCommand cd = new SqlCommand(sql,con);
        SqlDataReader dr = cd.ExecuteReader();
        while (dr.Read())
        {
            accdesc = dr[0].ToString();
            break;
        }
        dr.Close();
        return accdesc;
    }
}
