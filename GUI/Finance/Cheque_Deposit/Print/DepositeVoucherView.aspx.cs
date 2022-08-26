using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Finance_chqMgt_Print_DepositeVoucherView : System.Web.UI.Page
{
    public string border = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataReader dr;
        DataTable dt = new DataTable();
        string strVoucherNo = "", strSQL = "", YEAR_SUFFIX = "", Financial_Year="";

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        YEAR_SUFFIX = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        YEAR_SUFFIX = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        strVoucherNo = Request.QueryString["voucherNo"].ToString();

        //  Cheque deposite header information
        //  ==================================
        strSQL = "Select Top 1 VoucherNo, Convert(VarChar, TransDate, 6) As VoucherDate, " +
                        "IsNull(AccCode + ' : ' + (Select Top 1 AccDesc " +
                                            "From webx_AcctInfo " +
                                            "Where webx_AcctInfo.AccCode = webx_acctrans_" + YEAR_SUFFIX + ".AccCode), '') " +
                                "As DepositedInAccount, " +
                        "Convert(VarChar, EntryDt, 6) As DepositeDate, Narration " +
                 "From webx_acctrans_" + YEAR_SUFFIX + " " +
                 "Where VoucherNo = '" + strVoucherNo + "'";

        cnn.Open();
        cmd = new SqlCommand(strSQL, cnn);
        dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

        while (dr.Read())
        {
            lblVoucherNo.Text = strVoucherNo;
            lblVoucherDate.Text = Convert.ToDateTime(dr["VoucherDate"].ToString()).ToString("dd MMM yy");
            lblDepositedInAccount.Text = dr["DepositedInAccount"].ToString();
            lblDepositeDate.Text = Convert.ToDateTime(dr["DepositeDate"].ToString()).ToString("dd MMM yy");
            lblNarration.Text = dr["Narration"].ToString();
        }

        dr.Close();
        //  End of Debit Voucher header information

        //  Total Amount information
        //  ========================
        strSQL = "Select IsNull(Sum(Debit), 0) As TotalAmount From webx_acctrans_" + YEAR_SUFFIX + " Where VoucherNo = '" + strVoucherNo + "'";

        cnn.Open();
        cmd = new SqlCommand(strSQL, cnn);
        dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

        while (dr.Read())
        {
            string TotalDepositeAmount = dr["TotalAmount"].ToString();
            double TotalAmount = Convert.ToDouble(TotalDepositeAmount);
            lblTotalDepositeAmount.Text = String.Format("{0:0.00}", TotalAmount);
            string TTotalAmount = dr["TotalAmount"].ToString();
            double TAmt = Convert.ToDouble(TTotalAmount);
            lblTotalAmount.Text = String.Format("{0:0.00}", TAmt);
        }

        dr.Close();
        //  End of Total Amount information

        //  Cheque details information
        //  ==========================
        strSQL = "Select ChqNo, Convert(VarChar, ChqDt, 6) As ChqDt, ChqAmt, " +
                    "Convert(VarChar, EntryDt, 6) As EntryDate, " +
                    "ReceivedFrom = (CASE WHEN ptmsptcd IS NULL OR ptmsptcd='' THEN '--'" +
                    "WHEN ptmsptcd IS NOT NULL AND ptmsptnm is null or ptmsptnm='' then (ptmsptcd + ' : ' + (Select Top 1 CustNm From webx_custhdr Where CustCd = ptmsptcd))" +
                    "WHEN ptmsptcd IS NOT NULL AND ptmsptnm is NOT null then (ptmsptcd + ' : ' + ptmsptnm) end), " + 
                    "IsNull(DepoLocCode + ' : ' + (Select Top 1 LocName " +
                                                   "From webx_Location " +
                                                   "Where LocCode = DepoLocCode), '') As LocationOfEntry " +
                 "From webx_CHQ_DET " +
                 "Where VoucherNo = '" + strVoucherNo + "'";

        da = new SqlDataAdapter(strSQL, cnn);
        da.Fill(dt);
        rptrDepositVoucher.DataSource = dt;
        rptrDepositVoucher.DataBind();
        //  End of Cheque details information
    }
}
