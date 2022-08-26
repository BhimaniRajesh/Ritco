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

public partial class GUI_Finance_Fix_Asset_ViewPrint_PO_BillPaymentView : System.Web.UI.Page
{
    string strVoucherno;
    double totamt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strVoucherno = Request.QueryString["Voucherno"].ToString();
            string[] Split = strVoucherno.Split(new Char[] { ',' });
            strVoucherno = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);
            DipsplayReport();
            getData();
        }
        if (Session["Client"].ToString() == "PRRL")
        {
            imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
        }
        if (Session["Client"].ToString() == "TLL")
        {
            imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
        }
        else if (Session["Client"].ToString() == "EXL")
        {
            imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Varuna")
        {
            imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
        }
        else if (Session["Client"].ToString() == "RITCO")
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }
        else if (Session["Client"].ToString() == "RCPL")
        {
            imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Agility")
        {
            imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
        }
        else if (Session["Client"].ToString() == "ASL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
        }
        else if (Session["Client"].ToString() == "UFL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ufl_logo_NEW.gif";
        }
        else if (Session["Client"].ToString() == "RLL")
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.jpg";
        }
        else
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }
    }
    private void DipsplayReport()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd;
        SqlDataReader dr;
        string sqldata = "select distinct h.voucherno as voucherno,h.vendorcd as vendor,convert(varchar,h.PAYDT,06) as PAYDT,(Select VendorCode+' : '+VendorName FROM webx_vendor_hdr WHERE VENDORCODE = h.vendorcd) AS vendorname,(h.acccode + ':' + h.accdesc) AS creditaccount FROM WEBX_GENERAL_POASSET_HDR h ,WEBX_GENERAL_POASSET_PAYDET a WHERE a.voucherno=h.voucherno and h.voucherno='" + strVoucherno + "'";
        conn.Open();
        cmd = new SqlCommand(sqldata, conn);
        dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            lblVoucherNo.Text = Convert.ToString(dr["voucherno"]);
            lblVoucherDate.Text = Convert.ToString(dr["PAYDT"]);
            lblVendor.Text = Convert.ToString(dr["vendorname"]);
            LblCr_Account.Text = Convert.ToString(dr["creditaccount"]);
            hdnvendor.Value = Convert.ToString(dr["vendor"]);
        }
        dr.Close();
        conn.Close();

        conn.Open();
        string sqlvendor = "select Pan_no,servtaxno,AcctHead  from webx_vendor_hdr A With(NOLOCK) Inner join webx_AcctHead  B With(NOLOCK) on B.Codeid=A.vendor_type where Vendorcode='" + hdnvendor.Value + "'";
        cmd = new SqlCommand(sqlvendor, conn);
        SqlDataReader dr1;
        dr1 = cmd.ExecuteReader();
        while (dr1.Read())
        {
            V_Staxno.Text = Convert.ToString(dr1["servtaxno"]);
            V_PANNO.Text = Convert.ToString(dr1["Pan_no"]);
        }
        dr1.Close();
        conn.Close();


        conn.Open();
        string sqltds = "select tdsrate,tds,tdsacccode,tdsfor from WEBX_vouchertrans_arch where voucherno='" + strVoucherno + "'";
        cmd = new SqlCommand(sqltds, conn);
        SqlDataReader dr2;
        dr2 = cmd.ExecuteReader();
        while (dr2.Read())
        {
            TxtTds_Rate.Text = Convert.ToString(dr2["tdsrate"]);
            TxtTds_Amt.Text = Convert.ToString(dr2["tds"]);
            lblTDSType.Text = Convert.ToString(dr2["tdsacccode"]);
            lblTDSDeductedFor.Text = Convert.ToString(dr2["tdsfor"]);
            if (lblTDSDeductedFor.Text == "C")
            {
                lblTDSDeductedFor.Text = "Corporate";
            }
            else
            {
                lblTDSDeductedFor.Text = "Non-Corporate";
            }
        }
        dr2.Close();
        conn.Close();


        conn.Open();
        string sqltdsacc = "select Accdesc from webx_acctinfo where acccode='" + lblTDSType.Text + "'";
        cmd = new SqlCommand(sqltdsacc, conn);
        SqlDataReader dr3;
        dr3 = cmd.ExecuteReader();
        while (dr3.Read())
        {
            lblTDSType.Text = Convert.ToString(dr3["Accdesc"]);
        }
        dr3.Close();
        conn.Close();

        conn.Open();
        string sql = "select p.pocode as billno,convert(varchar,h.billdt,06) as billdt,p.paidamt as currentamt,h.pendamt,p.totalamt,P.Paidamt as paidamt from WEBX_GENERAL_POASSET_PAYDET p,WEBX_PO_BILL_HDR h  where p.pocode=h.billno and p.voucherno='" + strVoucherno + "'";
        
        cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_Booking.DataSource = ds;
        GV_Booking.DataBind();
        conn.Close();
    }
    private void getData()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
       
        //string sql1 = "select convert(varchar,podate,06) as podate,convert(varchar,Adv_VoucherDT,06) as Adv_VoucherDT,qutno,convert(varchar,qutdate,06) as qutdate,reqno,convert(varchar,reqdt,06) as reqdt,attn,vendorcd,accdesc,paymode,chqno,po_advamt,po_balamt,terms_condition,bank_accode=(select accdesc from webx_acctinfo where bank_accode=acccode),cash_accode=(select accdesc from webx_acctinfo where cash_accode=acccode),convert(varchar,chqdate,06) as chqdate,Po_advamt,PO_balamt,chqamt,cashamt,vendorcd +':'+ (select top 1 vendorname from webx_vendor_hdr where vendorcode=vendorcd) as vendor,* from webx_POASSET_HDR where Adv_VoucherNo='" + strVoucherno + "'";
        string sql1 = "select Transmode,debit,cashamt,chqamt,cash_acccode=(select accdesc from webx_acctinfo where a.cash_acccode=acccode),bank_acccode=(select accdesc from webx_acctinfo where a.bank_acccode=acccode),chqno,convert(varchar,chqdate,06) as chqdate from webx_vouchertrans_arch a where VoucherNo='" + strVoucherno + "'";

        SqlCommand cmdGetData = new SqlCommand(sql1, conn);
        SqlDataReader drPayment = cmdGetData.ExecuteReader();

        while (drPayment.Read())
        {

            lblVoucherNo.Text = strVoucherno;
            
            
            lblPaymentMode.Text = drPayment["Transmode"].ToString();
            lblAmountApplicable.Text = drPayment["debit"].ToString();
            if (lblPaymentMode.Text == "Cash")
            {
                lblCashAmount.Text = drPayment["cashamt"].ToString();
                lblCashAccount.Text = drPayment["cash_acccode"].ToString();
                lblChequeAmount.Text = "--";
                lblBankAccount.Text = "--";
            }
            else if (lblPaymentMode.Text == "Bank")
            {
                lblChequeAmount.Text = drPayment["chqamt"].ToString();
                lblBankAccount.Text = drPayment["bank_acccode"].ToString();
                lblChequeNo.Text = drPayment["chqno"].ToString();
                lblChequeDate.Text = drPayment["chqdate"].ToString();
                lblCashAmount.Text = "--";
                lblCashAccount.Text = "--";
            }
            else if (lblPaymentMode.Text == "BOTH")
            {
                lblCashAmount.Text = drPayment["cashamt"].ToString();
                lblCashAccount.Text = drPayment["cash_acccode"].ToString();
                lblChequeAmount.Text = drPayment["chqamt"].ToString();
                lblBankAccount.Text = drPayment["bank_acccode"].ToString();
                lblChequeNo.Text = drPayment["chqno"].ToString();
                lblChequeDate.Text = drPayment["chqdate"].ToString();
            }
            lblNetPayable.Text = drPayment["debit"].ToString();
        }
        drPayment.Close();
        conn.Close();
    }
    protected void GV_Booking_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label TXTCurramt = (Label)e.Row.FindControl("TXTCurramt");
            totamt = totamt + Convert.ToDouble(TXTCurramt.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label Txt_Total_netamt = (Label)e.Row.FindControl("Txt_Total_netamt");
            Txt_Total_netamt.Text = totamt.ToString();
        }
    }
}
