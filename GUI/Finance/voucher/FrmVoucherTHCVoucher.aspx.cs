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

public partial class GUI_Finance_voucher_FrmVoucherTHCVoucher : System.Web.UI.Page
{
    SqlConnection cn;
    string VoucherNo = "", DocumentType = "", PaymentType = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        VoucherNo = Request.QueryString["VoucherNo"];
        DocumentType = Request.QueryString["documentType"];
        PaymentType = Request.QueryString["PaymentType"];

        BindData();
    }

    private void BindData()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "";

        if (PaymentType == "A")
        {
            sql = "select distinct advvoucherno as VoucherNo,'THC' as DocumentType,fincmplbr as Branch,(Vendor_Code + ':'+ Vendor_Name) as Vendor from webx_THC_Summary With(NOLOCK) where advvoucherno = '" + VoucherNo + "'";
            GridVoucherAdvance.Visible = true;
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            GridVoucherAdvance.DataSource = ds;
            GridVoucherAdvance.DataBind();

        }
        else if (PaymentType == "B")
        {
            sql = "select distinct balvoucherno as VoucherNo,'THC' as DocumentType,balamtbrcd as Branch,(Vendor_Code + ':'+ Vendor_Name) as Vendor from webx_THC_Summary With(NOLOCK) where balvoucherno = '" + VoucherNo + "'";
            //Response.Write(sql);
            //Response.End();
            GridVoucherBalance.Visible = true;
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            GridVoucherBalance.DataSource = ds;
            GridVoucherBalance.DataBind();
        }

    }
}
