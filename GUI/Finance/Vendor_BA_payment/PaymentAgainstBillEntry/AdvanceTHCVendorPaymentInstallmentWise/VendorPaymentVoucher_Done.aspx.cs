using System;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_VendorPaymentVoucher_Done : System.Web.UI.Page
{
    public string VoucherNo, fin_year = "", Financial_Year = "";
    static string str_Connection_String = "";
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["SqlProvider"] != null)
            {
                str_Connection_String = Session["SqlProvider"].ToString();
                conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
            }
            else
            {
                Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
            }
        }
        catch (Exception Ex)
        {
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Session Expired.&sugession1=Please Log In again");
        }
        VoucherNo = Request.QueryString["VoucherNo"].ToString();
        HdnVoucherNo.Value = Request.QueryString["VoucherNo"].ToString();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        DataTable dtVI = new DataTable();
        TripSheet objTripSheet = new TripSheet(str_Connection_String);
        dtVI = objTripSheet.ExecuteSql("SELECT PBOV_NAME,PBOV_CODE,Voucherno,CONVERT(VARCHAR,A.Transdate,106) AS Transdate ,Debit FROM webx_acctrans_" + fin_year + " A WITH(NOLOCK) WHERE Debit>0 AND A.Oppaccount !=  'FUEL DISCOUNT' AND VOUCHERNO='" + VoucherNo + "'");
        //dtVI = objTripSheet.ExecuteSql("SELECT PBOV_NAME,PBOV_CODE,Voucherno,CONVERT(VARCHAR,A.Transdate,106) AS Transdate ,Debit FROM webx_acctrans_" + fin_year + " A WITH(NOLOCK) WHERE Debit>0 AND VOUCHERNO='VR/SRTBCO/16/000282'");
        
        if (dtVI.Rows.Count > 0)
        {
            lblVendorName.Text = dtVI.Rows[0]["PBOV_NAME"].ToString();
            lblAmount.Text = dtVI.Rows[0]["Debit"].ToString();
            lblVoucherDate.Text = dtVI.Rows[0]["Transdate"].ToString(); 
        }
        lblVoucherNo.Text = VoucherNo;
    }
}