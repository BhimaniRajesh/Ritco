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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_RunSheet_ViewRunSheetBalance : System.Web.UI.Page
{
    public static string voucherNo;
    public double totnetpayment = 0.00;
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            voucherNo = Convert.ToString(Request.QueryString["advvoucher"]);
            string[] Split = voucherNo.Split(new Char[] { ',' });
            voucherNo = Convert.ToString(Split[0]);
            lblVoucherNo.Text = voucherNo;
            string print_yn = Convert.ToString(Split[1]);

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

            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn1.Open();

            string sql1 = "select convert(varchar,bal_voucherdt,106) as bal_voucherdt, convert(varchar,bal_Chqdate,106) as bal_Chqdate,* from webx_PDCHDR where bal_voucherNo='" + voucherNo + "'";
            SqlCommand cmd1 = new SqlCommand(sql1, conn1);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            if (dr.Read())
            {
                lblVoucherDt.Text = dr["bal_voucherdt"].ToString();
                //lblVoucherDt.Text = (fn.Mydate1(lblVoucherDt.Text)).ToString();
                lblMode.Text = dr["bal_transtype"].ToString();
                //if (lblMode.Text == "Cash")
                //{
                //    lblPaymentAmt.Text = dr["bal_colamt"].ToString();
                //    lblChequeNo.Text = "--";
                //    lblChequeDt.Text = "--";
                //}
                //else
                //{
                //    lblPaymentAmt.Text = dr["bal_CHQAMT"].ToString();
                //    lblChequeNo.Text = dr["bal_Chqno"].ToString();
                //    lblChequeDt.Text = dr["bal_Chqdate"].ToString();
                //}
                //lblPaymentAcc.Text = dr["bal_acccode"].ToString() + " : " + fn.getAccountDesc("Webx_acctinfo",dr["bal_acccode"].ToString());
                lblManualVoucherNo.Text = dr["manual_adv_voucherno"].ToString();
                lblPANNo.Text = dr["panno"].ToString();



            }
            dr.Close();
            conn1.Close();

            conn1.Open();
            sql1 = "select convert(varchar,Chqdate,06) as bal_Chqdate,ChqNo as bal_Chqno,transtype as bal_transtype,Credit as bal_CHQAMT,OppaccCode as bal_acccode from webx_vouchertrans_arch where voucherNo='" + voucherNo + "'";
            //Response.Write(sql1);
            //Resposne.End();
            SqlCommand cmd2 = new SqlCommand(sql1, conn1);
            SqlDataReader dr1;
            dr1 = cmd2.ExecuteReader();
            if (dr1.Read())
            {
                lblMode.Text = dr1["bal_transtype"].ToString();
                if (lblMode.Text == "Cash")
                {
                    lblPaymentAmt.Text = dr1["bal_CHQAMT"].ToString();
                    lblChequeNo.Text = "--";
                    lblChequeDt.Text = "--";
                }
                else
                {
                    lblPaymentAmt.Text = dr1["bal_CHQAMT"].ToString();
                    lblChequeNo.Text = dr1["bal_Chqno"].ToString();
                    lblChequeDt.Text = dr1["bal_Chqdate"].ToString();
                }

                lblPaymentAcc.Text = dr1["bal_acccode"].ToString() + " : " + fn.getAccountDesc("Webx_acctinfo", dr1["bal_acccode"].ToString());
            }
            dr1.Close();


            NumberToText m = new NumberToText();
            lblWords.Text = m.numberToText(lblPaymentAmt.Text);
            conn1.Close();
            BindGrid();
        }
    }
    private void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "select * from webx_PDCHDR where bal_voucherNo='" + voucherNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();

        foreach (GridViewRow gridrow in dockdata.Rows)
        {
            if (gridrow.RowType == DataControlRowType.Footer)
            {
                Label TotNet = (Label)gridrow.FindControl("TotalNetamtvalue");

                if (TotNet.Text != "")
                {
                    totnetpayment = totnetpayment + Convert.ToDouble(TotNet.Text);
                    TotNet.Text = totnetpayment.ToString();
                }
                else
                {
                    totnetpayment = 0.00;
                    TotNet.Text = "0.00";
                }
            }


        }
    }
}
