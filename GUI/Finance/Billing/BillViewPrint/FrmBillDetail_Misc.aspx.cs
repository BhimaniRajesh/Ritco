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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
using System.Text;

public partial class GUI_Finance_Billing_BillViewPrint_FrmBillDetail_Misc : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    SqlConnection cn;
    private GridViewHelper helper;
    String frmdate, todate, fdate, tdate, billno, mbillno, pcode, billtype, billstatus;
    decimal totcodchg, tothldchrg, totstatechrg, tothlddlychrg, totnformchrg, totfodcharge, tototchg, subtotal, totsvctax, totcess, totheducess;
    Boolean flgxls2;
    string Number;
    string deciml;
    string _number;
    string _deciml, iamegyrl = "";
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        totcodchg = tothldchrg = totstatechrg = tothlddlychrg = totnformchrg = totfodcharge = tototchg = subtotal = totsvctax = totcess = totheducess = 0.0M;
        
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        flgxls2 = false;
        iamegyrl = "http:/123.108.47.77/WebX/GUI/images/" + Session["Client"].ToString() + "_logo.JPG";
        if (Session["Client"].ToString() == "PRRL")
        {
            iamegyrl = "http:/123.108.47.77/WebX/GUI/images/clip_image002.gif";
        }
        if (!IsPostBack)
        {
            tblall.Visible = false;
            tblbillno.Visible = false;
            Array str, str1;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            billno = Request.QueryString["billno"];
            mbillno = Request.QueryString["mbillno"];
            pcode = Request.QueryString["partycode"];
            billtype = Request.QueryString["billtype"];
            billstatus = Request.QueryString["billstatus"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            frmdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            todate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            lbldaterange.Text = TxtDateRange.Text;
            billtype = "7";
            lblbilltype.Text = "Misc";
            lblbillstatus.Text = billstatus == "-All-" ? "All" : billstatus;
            lblbillno.Text = billno;
            lblmbillno.Text = mbillno;
            lblccode.Text = pcode;
            if (lblbillno.Text == "" && lblmbillno.Text == "")
            {
                tblall.Visible = true;
            }
            else
            {
                tblbillno.Visible = true;
                if (lblbillno.Text != "")
                {
                    lblmbillno.Visible = false;
                    lbldmbillno.Visible = false;
                }
                else
                {
                    lblbillno.Visible = false;
                    lbldbillno.Visible = false;
                }
            }
            BindTheData();
        }

    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        if (billno != "")
        {
            cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where billno='" + billno + "' and paybas='" + billtype + "' and billno not in (select billno from webx_billdet)";
            //string sql = "select count(*) from webx_billdet where billno='" + billno + "' and paybas='" + billtype + "'";

        }
        else if (mbillno != "")
        {
            cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where manualbillno='" + mbillno + "' and paybas='" + billtype + "' and billno not in (select billno from webx_billdet)";
        }
        else
        {
            if ((pcode != "") && (billstatus != "-All-"))
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";
            }
            else if ((billtype != "-") && (billstatus != "-All-"))
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";
            }
            else if ((pcode != "") && (billstatus != "-All-"))
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + todate + "',106) and convert(datetime,'" + frmdate + "',106)) and billno not in (select billno from webx_billdet)";
            }
            else if (pcode != "") 
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";
            }
            else if ((pcode != ""))
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";

            }
            else if ((billtype != "-"))
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";
            }
            else if ((billstatus != "-All-"))
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";
            }
            else
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and billno not in (select billno from webx_billdet)";
            }
        }
        //Response.Write(cmd.CommandText);
        //Response.End();
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "Billdetail");
        GrdLoadUnload.DataSource = ds.Tables["Billdetail"];
        GrdLoadUnload.DataBind();

    }
    
}
