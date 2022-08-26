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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_VendorPayment_Ver1_Advance_Balance_Payment_AdvanceVoucher : System.Web.UI.Page
{
    string Sql = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] Voucherno_Arr = Request.QueryString["Voucherno"].ToString().Split('~');

        string Voucherno = Voucherno_Arr[0].ToString(), VoucherType = Request.QueryString["VoucherType"].ToString();

        Sql = "EXEC [Usp_View_PaymentVoucher] '" + Voucherno + "','" + VoucherType + "'";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        VoucherView.DataSource = ds;
        VoucherView.DataBind();

        if (VoucherType == "ADV")
        {
            Lbl_Voucher_type.Text = "Advance Payment Voucher";
            lbl_title.Text = "Advance Payment Voucher Detail";
            Lbl_Docno.Text = "Voucher No.";
            Lbl_DocDate.Text = "Voucher Date";
            PaymentDetail.Visible = true;
        }

        Sql = "SELECT Voucherno,VoucherDt=CONVERT(VARCHAR,Transdate,106),Netamt,Manual_voucherno,PBOV_CODE,PBOV_NAME,Transtype,TRANSMODE,CashAmt,CashAcccode=A.Acccode+' : '+A.Accdesc,CHQAMT,BankAcccode=B.Acccode+' : '+B.Accdesc,Chqno,ChqDt=(CASE WHEN Chqdate IS NULL OR CONVERT(VARCHAR,Chqdate,106)='01 Jan 1900' THEN '' ELSE CONVERT(VARCHAR,Chqdate,106) END) FROM webx_vouchertrans V LEFT OUTER JOIN webx_acctinfo A ON A.Acccode=V.Cash_Acccode LEFT OUTER JOIN webx_acctinfo B ON A.Acccode=V.Bank_Acccode WHERE Voucherno='" + Voucherno + "'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];

        lbl_voucher_No.Text = dt.Rows[0]["Voucherno"].ToString();
        lbl_voucher_Dt.Text = dt.Rows[0]["VoucherDt"].ToString();
        Lbl_manualVRNO.Text = dt.Rows[0]["Manual_voucherno"].ToString();
        Lbl_Vendorname.Text = dt.Rows[0]["PBOV_CODE"].ToString() + "~" + dt.Rows[0]["PBOV_NAME"].ToString();
        Lbl_Paymode.Text = dt.Rows[0]["Transtype"].ToString();
        Lbl_CashAMt.Text = dt.Rows[0]["CashAmt"].ToString();
        Lbl_cash_accode.Text = dt.Rows[0]["CashAcccode"].ToString();
        Lbl_Chqamt.Text = dt.Rows[0]["CHQAMT"].ToString();
        Lbl_bankCode.Text = dt.Rows[0]["BankAcccode"].ToString();
        Lbl_chqno.Text = dt.Rows[0]["Chqno"].ToString();
        Lbl_chqDate.Text = dt.Rows[0]["ChqDt"].ToString();
        Lbl_netamt.Text = dt.Rows[0]["Netamt"].ToString();
    }
}
