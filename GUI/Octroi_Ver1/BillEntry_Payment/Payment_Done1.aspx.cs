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

public partial class GUI_finance_voucher_voucher_done : System.Web.UI.Page
{
    string GRNNO = "", Voucherno = "";
    MyFunctions fn = new MyFunctions();
    public static string ToolTip_Str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string Financial_Year = "", fin_year = "";
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        Voucherno = Request.QueryString["Voucherno"];
        
        if (!Page.IsPostBack)
        {

            Lbl_GRN_Voucherno.Text = Voucherno;
            Lbl_GRN_Voucherno.CssClass = "blackfnt";
            
        }
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Table_Name = "webx_acctrans_" + fin_year;
        string sql = "exec Usp_Show_Doc_Accounting '" + Voucherno + "','" + Table_Name + "'";
        //ToolTip_Str = "<table cellpadding'3' cellspacing='1' border='1'><tr class='bgbluegrey'><td>Voucherno</td><td>Transaction Date</td><td>Acccode : Account Desc</td><td>Debit Amount</td><td>Credit Amount</td><td>Party Code:Name</td><td>Narration</td><tr bgcolor='White' class='blackfnt'><td>VR/HQTR/08/000024</td><td>17 Oct 2008</td><td wrap='false'>Cash and Hand - HO / RO / BRANCH :BA301</td><td align='Right'>0.00</td><td align='Right'>11.00</td><td>V00010:LAXMI YADAV</td><td>PO Advance Made ,PO Generated PO/HQTR/08000001</td></tr><tr bgcolor='White' class='blackfnt'><td>VR/HQTR/08/000024</td><td>17 Oct 2008</td><td wrap='false'>Sundry Creditors - Transporter:BL511</td><td align='Right'>11.00</td><td align='Right'>0.00</td><td>V00010:LAXMI YADAV</td><td>PO Advance Made ,PO Generated PO/HQTR/08000001</td></tr></table>";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        ToolTip_Str = sqlcmd.ExecuteScalar().ToString();
    }
}
