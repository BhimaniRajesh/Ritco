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

public partial class GUI_Finance_voucher_VoucherView : System.Web.UI.Page
{
    public static string voucherNo;
    public string Transtype, ChequeNo, ChequeDate, Transdate,PaymentAccount;
    public double totnetpayment = 0.00;
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
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
            else
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }

            voucherNo = Convert.ToString(Request.QueryString["strGenerateBillNo"]);
            string[] Split = voucherNo.Split(new Char[] { ',' });
            voucherNo = Convert.ToString(Split[0]);
            lblVoucherNo.Text = voucherNo;
            string print_yn = Convert.ToString(Split[1]);


            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn1.Open();
            string voucherDetail = "select oppAccCode,TransType,chqno,Convert(Varchar,chqdate,106) as chqdate,Convert(Varchar,Transdate,106) as Transdate,BankName,* from webx_vouchertrans_arch where VoucherNo='" + voucherNo + "'";
            SqlCommand newcmd = new SqlCommand(voucherDetail,conn1);
            SqlDataReader drnew;
            drnew = newcmd.ExecuteReader();
            if (drnew.Read())
            {
                lblPaymentAcc.Text = Convert.ToString(drnew["oppAccCode"]);
                Transtype  = Convert.ToString(drnew["TransType"]);
                ChequeNo =Convert.ToString(drnew["chqno"]);
                ChequeDate = Convert.ToString(drnew["chqdate"]);
                Transdate = Convert.ToString(drnew["Transdate"]);
                PaymentAccount = Convert.ToString(drnew["BankName"]);
                lblPaymentAmt.Text = Convert.ToString(drnew["Credit"]);
            }
            drnew.Close();
            conn1.Close();

            //lblVoucherDt.Text = fn.Mydate1(Transdate);
            lblVoucherDt.Text = Transdate;

            lblMode.Text = Transtype;
            if (lblMode.Text == "Cash")
            {
                lblMode.Text = "Cash";
                //lblPaymentAmt.Text = amount;
                lblChequeNo.Text = "--";
                lblChequeDt.Text = "--";
                //lblPaymentAcc.Text = PaymentAccount;
            }
            else
            {
                //lblPaymentAmt.Text = amount;
                lblMode.Text = "Bank";
                lblChequeNo.Text = ChequeNo;
                lblChequeDt.Text = ChequeDate;
                //lblPaymentAcc.Text = PaymentAccount;
            }
            

            SqlConnection conn_code = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn_code.Open();

            string sql_code = "select Accdesc from webx_acctinfo where acccode ='" + lblPaymentAcc.Text + "'";
            SqlCommand sqlcmd1 = new SqlCommand(sql_code, conn_code);
            SqlDataReader dr1;
            dr1 = sqlcmd1.ExecuteReader();
            if (dr1.Read())
            {
                lblPaymentAcc.Text = dr1["Accdesc"].ToString();
            }
            dr1.Close();

            //lblVendor.Text = fn.GetVendor(vendorCode);
            // GET EMPLOYEE CODE AND NAME FOR PREPARED BY

            lblPreparedby.Text = Session["empcd"].ToString();
            string sqlEmpname = "select UserId + ':' + Name as Employee from webx_master_users where UserId ='" + lblPreparedby.Text + "'";
            SqlCommand sqlcmd2 = new SqlCommand(sqlEmpname, conn_code);
            SqlDataReader dr2;
            dr2 = sqlcmd2.ExecuteReader();
            if (dr2.Read())
            {
                lblPreparedby.Text = dr2["Employee"].ToString();
            }
            dr2.Close();

            // GET VOUCHER DETAIL
            string sqlVendor = "select VENDORNAME as Vendor from WEBX_VendorBill_hdr where VoucherNo='" + voucherNo + "'";
            SqlCommand sqlcmd3 = new SqlCommand(sqlVendor, conn_code);
            SqlDataReader dr3;
            dr3 = sqlcmd3.ExecuteReader();
            if (dr3.Read())
            {
                lblVendor.Text = dr3["Vendor"].ToString();
            }
            dr3.Close();

            
            ////GET PAN NO

            //string sqlpanno = "select top 1 PAN_NO from webx_vendor_hdr where vendorcode='" + vendorCode + "'";
            //SqlCommand cmd1 = new SqlCommand(sqlpanno, conn);
            //SqlDataReader dr1;
            //dr1 = cmd1.ExecuteReader();

            //while (dr1.Read())
            //{
            //    Panno1 = dr1["PAN_NO"].ToString();
            //}
            //dr1.Close();

            //string sqlPaymentamt = "select isnull(sum(Netamt-isnull(pendamt,netamt)),0) as tot from WEBX_VendorBill_hdr where voucherNo='" + voucherNo + "'";
            //string sqlPaymentamt = "select top 1 Convert(varchar,p.vendorBILLDT,106) as VendorBill_DT , Convert(varchar,p.DUEDT,106) as Due_DT,(p.Netamt-isnull(p.pendamt,p.netamt)) as Advpaid, * from WEBX_VENDORBILL_PAYDET p, WEBX_VendorBill_hdr h where p.voucherno='" + voucherNo + "'";
            //SqlCommand cmdamt = new SqlCommand(sqlPaymentamt, conn_code);
            //SqlDataReader dramt;
            //dramt = cmdamt.ExecuteReader();

            //while (dramt.Read())
            //{
            //    //lblPaymentAmt.Text = dramt["Advpaid"].ToString();
            //    lblPaymentAmt.Text = dramt["Paidamt"].ToString();
            //}
            //dramt.Close();
            //conn_code.Close();

            //NumberToText m = new NumberToText();
            //lblWords.Text = m.numberToText(lblPaymentAmt.Text);

            double amt2 = Convert.ToDouble(lblPaymentAmt.Text);
            Int64 amt1 = Convert.ToInt64(amt2);
            RupeesToWords rupee = new RupeesToWords();
            lblWords.Text = Convert.ToString(rupee.NumberToText(amt1)) + " Only ";

        }


        BindGrid();
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //string sql = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is not null and voucherNo='" + voucherNo + "'";
        string sql = "select Convert(varchar,p.vendorBILLDT,106) as VendorBill_DT , Convert(varchar,p.DUEDT,106) as Due_DT,(p.Netamt-isnull(p.pendamt,p.netamt)) as Advpaid,isnull(p.pendamt,0) + isnull(p.paidamt,0) as NETAmount,(p.netamt-p.paidamt) as PendingAmount,* from WEBX_VENDORBILL_PAYDET p, WEBX_VendorBill_hdr h where p.voucherno='" + voucherNo + "' and p.billno=h.billno";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
}
