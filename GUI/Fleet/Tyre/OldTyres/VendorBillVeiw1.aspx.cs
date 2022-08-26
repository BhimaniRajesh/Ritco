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

public partial class GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_VendorBillVeiw1 : System.Web.UI.Page
{
    public static string voucherNo;
    public string Transtype, ChequeNo, ChequeDate, Transdate, PaymentAccount;
    public double totnetpayment = 0.00;
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            
                //imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            

            voucherNo = Convert.ToString(Request.QueryString["strGenerateBillNo"]);
            string[] Split = voucherNo.Split(new Char[] { ',' });
            voucherNo = Convert.ToString(Split[0]);
            lblVoucherNo.Text = voucherNo;
            string print_yn = Convert.ToString(Split[1]);


            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn1.Open();
            //string voucherDetail = "select Credit,AccCode,TransType,chqno,Convert(Varchar,chqdate,06) as chqdate,Convert(Varchar,Transdate,06) as Transdate,BankName,* from webx_vouchertrans_arch where VoucherNo='" + voucherNo + "'";
		
            /* Alter By Kinjal Patel(Bank Name not show so add joints)*/
	    string voucherDetail = "select Credit,V.AccCode,TransType,chqno,Convert(Varchar,chqdate,06) as chqdate,Convert(Varchar,Transdate,06) as Transdate,CASE WHEN ISNULL(BankName,'')='' THEN A.Accdesc ELSE BankName END as BankName,* " +
	"from webx_vouchertrans_arch V WITH(NOLOCK) LEFT JOIN webx_acctinfo A WITH(NOLOCK) ON a.Acccode= V.oppacccode where VoucherNo='" + voucherNo + "'";

            SqlCommand newcmd = new SqlCommand(voucherDetail, conn1);
            SqlDataReader drnew;
            drnew = newcmd.ExecuteReader();
            if (drnew.Read())
            {
                lblPaymentAcc.Text = Convert.ToString(drnew["AccCode"]);
                Transtype = Convert.ToString(drnew["TransType"]);
                ChequeNo = Convert.ToString(drnew["chqno"]);
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
            if (lblMode.Text == "Cash Payment" || lblMode.Text == "Cash")
            {
                lblMode.Text = "Cash";
                //lblPaymentAmt.Text = amount;
                lblChequeNo.Text = "--";
                lblChequeDt.Text = "--";
                lblPaymentAcc.Text = PaymentAccount;
            }
            else
            {
                //lblPaymentAmt.Text = amount;
                lblMode.Text = "Cheque";
                lblChequeNo.Text = ChequeNo;
                lblChequeDt.Text = ChequeDate;
                lblPaymentAcc.Text = PaymentAccount;
            }

            double amt2 = Convert.ToDouble(lblPaymentAmt.Text);
            Int64 amt1 = Convert.ToInt64(amt2);
            RupeesToWords rupee = new RupeesToWords();
            lblWords.Text = Convert.ToString(rupee.NumberToText(amt1)) + " Only ";

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




            //string sqlPaymentamt = "select voucherno,credit as paymentamt,chqno,Convert(varchar,chqdt,06) as chqdt,TransType from webx_vouchertrans_arch where voucherno='" + voucherNo + "'";
            //SqlCommand cmdamt = new SqlCommand(sqlPaymentamt, conn_code);
            //SqlDataReader dramt;
            //dramt = cmdamt.ExecuteReader();

            //while (dramt.Read())
            //{
            //    lblPaymentAmt.Text = dramt["tot"].ToString();
            //}
            //dramt.Close();
            //conn_code.Close();

            ////NumberToText m = new NumberToText();
            ////lblWords.Text = m.numberToText(lblPaymentAmt.Text);



        }


        BindGrid();
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //string sql = "select Convert(varchar,vendorBILLDT,106) as VendorBill_DT , Convert(varchar,DUEDT,106) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is not null and voucherNo='" + voucherNo + "'";
        string sql = "select d.Billno,d.Vendorbillno,Convert(varchar,d.vendorBILLDT,106) as VendorBill_DT , Convert(varchar,d.DUEDT,106) as Due_DT,d.Netamt,d.pendamt as pending,d.paidamt as currentpayment from WEBX_VendorBill_hdr h,WEBX_VENDORBILL_PAYDET d where ( h.Bill_cancel='N' or h.Bill_cancel is null) and h.voucherNo is not null and h.voucherNo='" + voucherNo + "' and h.billno=d.billno and h.voucherno=d.voucherno";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
}
