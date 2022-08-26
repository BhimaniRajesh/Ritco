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

public partial class GUI_Finance_Vendor_BA_payment_PrepareVoucher_RunSheet_ViewRunsheetAdvance : System.Web.UI.Page
{
    public static string voucherNo;
    public double totnetpayment = 0.00,totadvpayment=0.00;
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

            string sql1 = "select convert(varchar,adv_voucherdt,06) as adv_voucherdt, convert(varchar,adv_Chqdate,06) as adv_Chqdate,* from webx_PDCHDR where adv_voucherNo='" + voucherNo + "'";
            SqlCommand cmd1 = new SqlCommand(sql1, conn1);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            if (dr.Read())
            {
                lblVoucherDt.Text = dr["adv_voucherdt"].ToString();
                //lblVoucherDt.Text = (fn.Mydate1(lblVoucherDt.Text)).ToString();
                lblMode.Text = dr["adv_transtype"].ToString();
                if (lblMode.Text == "Cash")
                {
                    lblPaymentAmt.Text = dr["adv_colamt"].ToString();
                    lblChequeNo.Text = "--";
                    lblChequeDt.Text = "--";
                }
                else
                {
                    lblPaymentAmt.Text = dr["adv_CHQAMT"].ToString();
                    lblChequeNo.Text = dr["adv_Chqno"].ToString();
                    lblChequeDt.Text = dr["adv_Chqdate"].ToString();
                }
                lblPaymentAcc.Text = dr["adv_acccode"].ToString() + " : " + fn.getAccountDesc("Webx_acctinfo",dr["adv_acccode"].ToString());
                lblManualVoucherNo.Text = dr["manual_adv_voucherno"].ToString();
                lblPANNo.Text = dr["panno"].ToString();
                


            }
            dr.Close();
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

        string sql = "select * from webx_PDCHDR where adv_voucherNo='" + voucherNo + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "tab1");
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();

        //foreach (GridViewRow gridrow in dockdata.Rows)
        //{
        //    if (gridrow.RowType == DataControlRowType.Footer)
        //    {
        //        Label TotNet = (Label)gridrow.FindControl("TotalNetamtvalue");
        //        Label TotAdv = (Label)gridrow.FindControl("TotalAdvanceAmt");
        //        if (TotNet.Text != "")
        //        {
        //            totnetpayment = totnetpayment + Convert.ToDouble(TotNet.Text);
        //            TotNet.Text = totnetpayment.ToString();
        //        }
        //        else
        //        {
        //            totnetpayment = 0.00;
        //            TotNet.Text = "0.00";
        //        }
        //        if (TotAdv.Text != "")
        //        {
        //            totadvpayment = totadvpayment + Convert.ToDouble(TotAdv.Text);
        //            TotAdv.Text = totadvpayment.ToString();
        //        }
        //        else
        //        {
        //            totadvpayment = 0.00;
        //            TotAdv.Text = "0.00";
        //        }
        //    }
            

        //}
    }
}
