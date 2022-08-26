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

public partial class GUI_Finance_Fix_Asset_ViewPrint_PO_BillEntryView : System.Web.UI.Page
{
    string strBillno;
    double totadv = 0, totpend = 0, totcurr = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strBillno = Request.QueryString["Billno"].ToString();
            string[] Split = strBillno.Split(new Char[] { ',' });
            strBillno = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);
            DipsplayReport();
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
        string sqldata = "select h.vendorcode as vendor,h.billno,convert(varchar,h.entrydt,06) as entrydt,(h.vendorcode + ':' + h.vendorname) as vendorname,('UNS0004' + ':' + 'Sundry Creditors - Others')  as creditaccount,h.vendorbillno,convert(varchar,h.vendorbilldt,06) as vendorbilldt,convert(varchar,h.duedt,06) as duedt,h.DUEDAY,h.remark,h.NETAMT,h.pendamt from WEBX_PO_BILL_HDR h ,webx_GENERAL_POASSET_HDR a where a.billno=h.billno and h.billno='" + strBillno + "'";
        conn.Open();
        cmd = new SqlCommand(sqldata, conn);
        dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            lblPaymentVoucherno.Text = Convert.ToString(dr["billno"]);
            lblBillEntryDate.Text = Convert.ToString(dr["entrydt"]);
            lblVendor.Text = Convert.ToString(dr["vendorname"]);
            LblCr_Account.Text = Convert.ToString(dr["creditaccount"]);
            lblVendorBillno.Text = Convert.ToString(dr["vendorbillno"]);
            lblVendorBillDt.Text = Convert.ToString(dr["vendorbilldt"]);
            lblDueDays.Text = Convert.ToString(dr["DUEDAY"]);
            lblDueDate.Text = Convert.ToString(dr["duedt"]);
            lblRemarks.Text = Convert.ToString(dr["remark"]);
            hdnvendor.Value = Convert.ToString(dr["vendor"]);
            lblNetAmt.Text = Convert.ToString(dr["NETAMT"]);
            hdnNetAmt.Value = Convert.ToString(dr["NETAMT"]);
            lblPendAmt.Text = Convert.ToString(dr["pendamt"]);
            hdnPendAmt.Value = Convert.ToString(dr["pendamt"]);
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
            //AcctHead = dr["AcctHead"].ToString();
        }
        dr1.Close();
        conn.Close();

        string sql = "select h.Adv_voucherno,Convert(varchar,h.Adv_voucherDT,06) as Adv_voucherDT,d.DOCNO,h.voucherno,d.ADVPAID,h.pendamt,d.paidamt,d.netpay from WEBX_PO_BILL_Det d,webx_GENERAL_POASSET_HDR h where d.billno=h.billno and h.pocode=d.docno and d.billno='" + strBillno + "'";
        conn.Open();
        cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_Booking.DataSource = ds;
        GV_Booking.DataBind();
    }
    protected void GV_Booking_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label LblPaidamt = (Label)e.Row.FindControl("LblPaidamt");
            totadv = totadv + Convert.ToDouble(LblPaidamt.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label Txt_Total_AdvAmt = (Label)e.Row.FindControl("Txt_Total_AdvAmt");
            Txt_Total_AdvAmt.Text = totadv.ToString();
        }

        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    Label LblPendamt = (Label)e.Row.FindControl("LblPendamt");
        //    totpend = totpend + Convert.ToDouble(LblPendamt.Text);
        //}
        //if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    Label Txt_Total_Pendamt = (Label)e.Row.FindControl("Txt_Total_Pendamt");
        //    Txt_Total_Pendamt.Text = totpend.ToString();
        //}

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label TXTCurramt = (Label)e.Row.FindControl("TXTCurramt");
            totcurr = totcurr + Convert.ToDouble(TXTCurramt.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label Txt_Total_netamt = (Label)e.Row.FindControl("Txt_Total_netamt");
            Txt_Total_netamt.Text = totcurr.ToString();
        }
    }
}
