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

public partial class GUI_Finance_Billing_BillViewPrint_FrmBillDetail_Supp : System.Web.UI.Page
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
            lblbilltype.Text = "Supp";
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
            cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.billno='" + billno + "' and  m.billno=d.billno and m.paybas='" + billtype + "'";
        }
        else if (mbillno != "")
        {
            cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.manualbillno='" + mbillno + "' and  m.billno=d.billno and m.paybas='" + billtype + "'";
        }
        else
        {
            if ((pcode != "") && (billstatus != "-All-"))
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd in ('" + pcode + "') And m.paybas='" + billtype + "' and m.billstatus like '" + billstatus + "' And (convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";
            }
            else if ((billtype != "-") && (billstatus != "-All-"))
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd like '%%' And m.paybas='" + billtype + "' and m.billstatus like '" + billstatus + "' And (convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";
            }
            else if ((pcode != "") && (billstatus != "-All-"))
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd in ('" + pcode + "') and m.paybas='" + billtype + "' and m.billstatus like '" + billstatus + "' And (convert(varchar,m.bgndt,106) between Convert(datetime,'" + todate + "',106) and convert(datetime,'" + frmdate + "',106)) and  m.billno=d.billno";
            }
            else if (pcode != "")
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd in ('" + pcode + "') And m.paybas='" + billtype + "' And ( convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";
            }
            else if ((pcode != ""))
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd in ('" + pcode + "') and m.paybas='" + billtype + "' And ( convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";

            }
            else if ((billtype != "-"))
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd like '%%' And m.paybas='" + billtype + "' And ( convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";
            }
            else if ((billstatus != "-All-"))
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd like '%%' and m.paybas='" + billtype + "' and m.billstatus like '" + billstatus + "' And (convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";
            }
            else
            {
                cmd.CommandText = "select m.billno,m.bbrcd,m.ptmscd,m.ptmsnm,m.paybas,m.BILLAMT,m.bgndt,m.bsbdt,m.bduedt,m.bcldt,m.bcbsdt,m.ptmsbrcd,m.billsubbrcd,m.billcolbrcd,m.bill_cancel,m.BGENEMPCD,m.billstatus from webx_billmst m with(nolock),webx_billdet d with(nolock) where m.ptmscd like '%%' and m.paybas='" + billtype + "' And ( convert(varchar,m.bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and  m.billno=d.billno";
            }
        }
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
