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

public partial class GUI_Finance_advice_AdviceView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection cnn = new SqlConnection(HttpContext.Current.Session["SqlProvider"].ToString().Trim());
        SqlDataAdapter sda = new SqlDataAdapter();
        DataTable dt = new DataTable();
        NumberToText ntt = new NumberToText();
        string str_SQL =
            "Select Adviceno, " +
	        "   CASE Advicetype " +
		    "       When 'D' Then 'Debit Advice' " +
		    "       When 'C' Then 'Credit Advice' " + 
	        "   END As Advicetype, " + 
	        "   Convert(VarChar, AdviceDt, 106) As AdviceDt, " + 
	        "   (Select UserID + ':' + [Name] From WebX_Master_Users Where WebX_Master_Users.UserID = WEBX_Advice_Hdr.entryby) As entryby, " + 
	        "   (Select LocCode + ':' + LocName From webx_location Where webx_location.LocCode = WEBX_Advice_Hdr.RaisedBy) As RaisedBy, " + 
	        "   (Select LocCode + ':' + LocName From webx_location Where webx_location.LocCode = WEBX_Advice_Hdr.RaisedOn) As RaisedOn, " + 
	        "   reason, enclosed, credit_account, " + 
	        "   (Select AccCode + ':' + AccDesc From webx_acctinfo Where webx_acctinfo.AccCode = WEBX_Advice_Hdr.fromAcccode) As fromAcccode, " + 
	        "   (Select CHQNO From WEBX_BILLCHQDETAIL Where DocNo = Adviceno) As CHQNO, " + 
	        "   Convert(VarChar, (Select CHQDT From WEBX_BILLCHQDETAIL Where DocNo = Adviceno), 106) As CHQDT, " + 
	        "   adjusted_amount " + 
            "From WEBX_Advice_Hdr " + 
            "Where Adviceno = '" + Request.QueryString["AdviceNo"].ToString() + "'";

        sda = new SqlDataAdapter(str_SQL, cnn);
        sda.Fill(dt);

        if (dt.Rows.Count == 1)
        {
            lbl_Advice_No.Text = dt.Rows[0]["Adviceno"].ToString();
            lbl_Advice_Type.Text = dt.Rows[0]["Advicetype"].ToString();
            lbl_Advice_Date.Text = dt.Rows[0]["AdviceDt"].ToString();
            lbl_Generated_By.Text = dt.Rows[0]["entryby"].ToString();
            lbl_Raised_By.Text = dt.Rows[0]["RaisedBy"].ToString();
            lbl_Raised_on_Branch.Text = dt.Rows[0]["RaisedOn"].ToString();
            lbl_Reason.Text = dt.Rows[0]["reason"].ToString();
            lbl_Enclosed_Documents.Text = dt.Rows[0]["enclosed"].ToString();

            lbl_Mode_Of_Transaction.Text = dt.Rows[0]["credit_account"].ToString();
            lbl_Cash_Bank_Account.Text = dt.Rows[0]["fromAcccode"].ToString();
            lbl_Cheque_Number.Text = dt.Rows[0]["CHQNO"].ToString();
            lbl_Cheque_Date.Text = dt.Rows[0]["CHQDT"].ToString();
            lbl_Payment_Amount.Text = dt.Rows[0]["adjusted_amount"].ToString();
            lbl_In_Words.Text = ntt.numberToText(lbl_Payment_Amount.Text);
        }
    }
}
