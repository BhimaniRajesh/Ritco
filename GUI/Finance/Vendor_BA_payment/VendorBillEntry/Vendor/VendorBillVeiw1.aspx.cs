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
    public double totnetpayment = 0.00;
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            voucherNo = Convert.ToString(Request.QueryString["strGenerateBillNo"]);
            string[] Split = voucherNo.Split(new Char[] { ',' });
            voucherNo = Convert.ToString(Split[0]);
            lblVoucherNo.Text = voucherNo;
            string print_yn = Convert.ToString(Split[1]);

            string voucherDT = Convert.ToString(Split[2]);
            string mode = Convert.ToString(Split[3]);
            string chequeNo = Convert.ToString(Split[4]);
            string chequeDt = Convert.ToString(Split[5]);
            string amount = Convert.ToString(Split[6]);
            string accCode = Convert.ToString(Split[7]);
            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn1.Open();

            //string sql2 = "select convert(varchar,chqdate,106) as chqdt,chqno,TRANSMODE,* from webx_vouchertrans";
            //string sql1 = "select  convert(varchar,adv_Chqdate,106) as adv_Chqdate,* from WEBX_VendorBill_hdr where voucherNo='" + voucherNo + "'";
            //string sql1 = "select * from WEBX_vendorbill_hdr where voucherNo='" + voucherNo + "'";
            //SqlCommand cmd1 = new SqlCommand(sql1, conn1);
            //SqlDataReader dr;
            //dr = cmd1.ExecuteReader();
            //if (dr.Read())
           // {
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
            else
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }

            lblVoucherDt.Text = fn.Mydate1(voucherDT);
            
                lblMode.Text = mode;
                if (lblMode.Text == "Cash")
                {
                    lblPaymentAmt.Text = amount;
                    lblChequeNo.Text = "--";
                    lblChequeDt.Text = "--";
                }
                else
                {
                    lblPaymentAmt.Text = amount;
                    lblChequeNo.Text = chequeNo;
                    lblChequeDt.Text = chequeDt;
                }
             NumberToText m = new NumberToText();
             lblWords.Text = m.numberToText(amount);
                
                SqlConnection conn_code = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn_code.Open();

                string sql_code = "select Accdesc from webx_acctinfo where acccode ='" + accCode + "'";
                SqlCommand sqlcmd1 = new SqlCommand(sql_code, conn_code);
                SqlDataReader dr1;
                dr1 = sqlcmd1.ExecuteReader();
                if (dr1.Read())
                {
                    lblPaymentAcc.Text = dr1["Accdesc"].ToString();
                }
                dr1.Close();
                conn_code.Close();
            }
           
            
            BindGrid();
        }
   
    private void BindGrid()
    {
        //foreach (GridViewRow gridrow in dockdata.Rows)
        //{
        //    Label TotNet = (Label)gridrow.FindControl("TotalNetamt");

        //    if (TotNet.Text != "")
        //    {
        //        totnetpayment = totnetpayment + Convert.ToDouble(TotNet.Text);
        //        TotNet.Text = totnetpayment.ToString();
        //    }
        //    else
        //    {
        //        totnetpayment = 0.00;
        //        TotNet.Text = "0.00";
        //    }
        //}
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select Convert(varchar,vendorBILLDT,06) as VendorBill_DT , Convert(varchar,DUEDT,06) as Due_DT,(Netamt-isnull(pendamt,netamt)) as Advpaid, * from WEBX_VendorBill_hdr where ( Bill_cancel='N' or Bill_cancel is null) and voucherNo is not null and voucherNo='" + voucherNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        
        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        //totdkt = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
}
