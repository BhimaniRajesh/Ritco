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
using System.IO;
using System.Globalization;
using System.Data.SqlClient;

public partial class GUI_Finance_Billing_BillViewPrint_FrmBillDetail_RITCO : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    SqlConnection cn;
    private GridViewHelper helper;
    String frmdate, todate, fdate, tdate, billno, mbillno, pcode, billtype, billstatus;
    decimal totcodchg,tot_oth,totfuel, tothldchrg, totstatechrg, tothlddlychrg, totnformchrg, totfodcharge, tototchg, subtotal, totsvctax, totcess, totheducess,totqty1,totamt1,totqty2,totamt2;
    Boolean flgxls2;
    string Number;
    string deciml;
    string _number;
    string _deciml, iamegyrl = "";
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    double totActualWeight = 0.0;
    double totFreightDiff = 0.0;
    double totMiscChrg = 0.0;
    double totDemChrg = 0.0;
    double totLabour = 0.0;
    double totCartage = 0.0;
    double totSurChrg = 0.0;
    double totdktchrg = 0.0;
    double totSubTotal = 0.0;
    double totbasicfreight = 0.0;
    double totstaxcesshcess = 0.0;
    double totbillamt = 0.0;
    double totdkttot = 0.0;
    double tototchg1 = 0.0;
    double totFOV = 0.0;
    double totddcharge = 0.0;
    double totdccharge = 0.0;
    double totdc = 0.0;
    double totfreight = 0.0;
    double totrate = 0.0;
    double totchargewt = 0.0;
    double totpkgs = 0.0;
    protected void Page_Load(object sender, EventArgs e)
    {
        totcodchg = tot_oth = totfuel = tothldchrg = totstatechrg = tothlddlychrg = totnformchrg = totfodcharge = tototchg = subtotal = totsvctax = totcess = totheducess = 0.0M;
        Initialize();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        flgxls2 = false;
        iamegyrl = "http:/123.108.47.70/ritco/GUI/images/Ritco_Logo.gif";
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
            lblbilltype.Text = billtype == "-" ? "All" : "TBB";
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
        if (Session["BRCD"].ToString() == "HQTR")
        {
            if (billno != "")
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where bill_cancel<>'Y' and billno='" + billno + "'";
            }
            else if (mbillno != "")
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where bill_cancel<>'Y' and manualbillno='" + mbillno + "'";
            }
            else
            {
                if ((pcode != "") && (billtype != "-") && (billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                }
                else if ((billtype != "-") && (billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                }
                else if ((pcode != "") && (billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + todate + "',106) and convert(datetime,'" + frmdate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + todate + "',106) and convert(datetime,'" + frmdate + "',106))";
                }
                else if ((pcode != "") && (billtype != "-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                }
                else if ((pcode != ""))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";

                }
                else if ((billtype != "-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                }
                else if ((billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                }
                else
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                }
            }
        }
        else
        {
            if (billno != "")
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where bill_cancel<>'Y' and  billno='" + billno + "' and bbrcd='" + Session["BRCD"].ToString() + "'";
            }
            else if (mbillno != "")
            {
                cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,bill_cancel,BGENEMPCD,billstatus from webx_billmst where bill_cancel<>'Y' and  manualbillno='" + mbillno + "' and bbrcd='" + Session["BRCD"].ToString() + "'";
            }
            else
            {
                if ((pcode != "") && (billtype != "-") && (billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
                else if ((billtype != "-") && (billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' And paybas='" + billtype + "' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
                else if ((pcode != "") && (billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + todate + "',106) and convert(datetime,'" + frmdate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + todate + "',106) and convert(datetime,'" + frmdate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
                else if ((pcode != "") && (billtype != "-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
                else if ((pcode != ""))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd in ('" + pcode + "') and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd in ('" + pcode + "') and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd in ('" + pcode + "') and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";

                }
                else if ((billtype != "-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' And paybas='" + billtype + "' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
                else if ((billstatus != "-All-"))
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' and paybas like '%' and billstatus like '" + billstatus + "' And (convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
                else
                {
                    //cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where ptmscd like '%%' and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) union select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst_arch where ptmscd like '%%' and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106))";
                    cmd.CommandText = "select billno,bbrcd,ptmscd,ptmsnm,paybas,BILLAMT,bgndt,bsbdt,bduedt,bcldt,bcbsdt,ptmsbrcd,billsubbrcd,billcolbrcd,billstatus from webx_billmst where bill_cancel<>'Y' and ptmscd like '%%' and paybas like '%' And ( convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106)) and bbrcd='" + Session["BRCD"].ToString() + "'";
                }
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
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void xls1(object sender, EventArgs e)
    {
        tblxls1.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkbilldtl")).Text;
        string sql = "select * from vw_BillDetail_Annexure where  billno='" + bno + "' order by trn_mod,DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet dsxls1 = new DataSet();
        da.Fill(dsxls1, "xls1");
        GrdXLS1.DataSource = dsxls1.Tables["xls1"];
        GrdXLS1.DataBind();
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where bill_cancel<>'Y' and billno='" + bno + "'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblpartyname.Text = Convert.ToString(dr["ptmsnm"]);
            lblpbillno.Text = bno;
        }
        dr.Close();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=BillDeatail_new.xls");
        Response.Charset = "";
        Response.ContentType = "Application/x-msexcel";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls1);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
        //tblxls2.Visible = false;
    }
    protected void xls2(object sender, EventArgs e)
    {
        flgxls2 = true;
        tblxls2.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkportrait")).Text;
        lblABillNo.Text = bno;

        string sql = "select * from poitrait_Bill where billno='" + bno + "' order by trn_mod,DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet dsxls2 = new DataSet();
        da.Fill(dsxls2, "xls2");
        GrdXLS2.DataSource = dsxls2.Tables["xls2"];
        GrdXLS2.DataBind();

        subtotal = 0;
        for (int i = 0; i < dsxls2.Tables["xls2"].Rows.Count; i++)
        {
            subtotal += Convert.ToDecimal(dsxls2.Tables["xls2"].Rows[i]["SubTotal"]);
        }
        lblsubtotal.Text = Convert.ToString(subtotal);
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where bill_cancel<>'Y' and billno='" + bno + "'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }

        }
        dr.Close();


        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Portrait.xls");
        Response.Charset = "";
        Response.ContentType = "Application/x-msexcel";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls2);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblxls2.Visible = false;
    }
    protected void xls3(object sender, EventArgs e)
    {
        flgxls2 = false;
        tblxls2.Visible = true;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lnkportrait")).Text;
        lblABillNo.Text = bno;

        string sql = "select * from poitrait_Bill where billno='" + bno + "' order by trn_mod,DOCKDT";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet dsxls2 = new DataSet();
        da.Fill(dsxls2, "xls2");
        GrdXLS2.DataSource = dsxls2.Tables["xls2"];
        GrdXLS2.DataBind();
        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where  bill_cancel<>'Y' and billno='" + bno + "'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
        dr.Close();
        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        //Response.Charset = "";
        //Response.ContentType = "Application/x-msexcel";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //frm.Controls.Add(tblxls2);
        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
        //tblxls2.Visible = false;

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        Response.Charset = "";
        Response.ContentType = "Application/x-msexcel";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblxls2);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblxls2.Visible = false;
    }
    protected void xls4(object sender, EventArgs e)
    {
        tblbulk.Visible = true;
        tblxls2.Visible = false;
        grd1.Visible = true;
        grd2.Visible = false;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lblBillNew1")).Text;
        lblABillNo.Text = bno;
        string sql = "select distinct DocketNo,DocketDate,Cnee,ChargeWeight,Rate,Destination,VehicleNo,DONumber,PKGSNO,InvoiceNo,FREIGHT,UnLoadingCharge,Amount from VW_RITCOBill_UnLoading where billno='" + bno + "' order by DocketDate";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet dsxls4 = new DataSet();
        da.Fill(dsxls4, "xls4");
        GridView1.DataSource = dsxls4.Tables["xls4"];
        GridView1.DataBind();
        GridView1.FooterRow.Cells[09].Text = Convert.ToString(totqty1);
        GridView1.FooterRow.Cells[11].Text = Convert.ToString(totamt1);

        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where bill_cancel<>'Y' and billno='" + bno + "'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
        dr.Close();


        SqlCommand cmd1 = new SqlCommand("select Convert(varchar,h.bgndt,106) as bgndt,ptmsnm,c.custnm as CustomerName,c.CustAddress as CustAddress,h.manualbillno as manualbillno,* from Webx_billmst h,webx_custhdr c where c.custcd=h.ptmscd and h.bill_cancel<>'Y' and  billno='" + bno + "'", cn);

        SqlDataReader dr1 = cmd1.ExecuteReader();
        if (dr1.Read())
        {
            lblBillNox.Text = bno;
            lblBillDt.Text = Convert.ToString(dr1["bgndt"]);
            lblManualBillNo.Text = Convert.ToString(dr1["manualbillno"]);
            lblCustName.Text = Convert.ToString(dr1["CustomerName"]);
        }
        dr1.Close();

        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        //Response.Charset = "";
        //Response.ContentType = "Application/x-msexcel";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //frm.Controls.Add(tblbulk);
        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
        //tblbulk.Visible = false;

        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=WithOutUnloadingDate.xls");
        //Response.Charset = "";
        //Response.ContentType = "Application/x-msexcel";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //frm.Controls.Add(tblbulk);
        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
        //tblbulk.Visible = false;

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=WithOutUnloadingDate.xls");
        Response.Charset = "";
        Response.ContentType = "Application/x-msexcel";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblbulk);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblbulk.Visible = false;


    }
    protected void xls5(object sender, EventArgs e)
    {
        tblbulk.Visible = true;
        tblxls2.Visible = false;
        grd2.Visible = true;
        grd1.Visible = false;
        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        string bno = ((LinkButton)GrdLoadUnload.SelectedRow.FindControl("lblBillNew11")).Text;
        lblABillNo.Text = bno;
        string sql = "select DocketNo,DocketDate,Cnee,ChargeWeight,Destination,Rate,VehicleNo,DONumber,PKGSNO,InvoiceNo,FREIGHT,UnLoadingCharge,Amount,THC_ArrivalDate,* from VW_RITCOBill_UnLoading where billno='" + bno + "'";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet dsxls2 = new DataSet();
        da.Fill(dsxls2, "xls2");
        GridView2.DataSource = dsxls2.Tables["xls2"];
        GridView2.DataBind();
        GridView2.FooterRow.Cells[10].Text = Convert.ToString(totqty2);
        GridView2.FooterRow.Cells[12].Text = Convert.ToString(totamt2);

        SqlCommand cmd = new SqlCommand("select * from Webx_billmst where bill_cancel<>'Y' and billno='" + bno + "'", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lbltotal.Text = Convert.ToString(dr["BillAmt"]);
            amtword = Convert.ToString(dr["BillAmt"]);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
        dr.Close();

        SqlCommand cmd2 = new SqlCommand("select Convert(varchar,h.bgndt,106) as bgndt,ptmsnm,c.custnm as CustomerName,c.CustAddress as CustAddress,h.manualbillno as manualbillno,* from Webx_billmst h,webx_custhdr c where c.custcd=h.ptmscd and h.bill_cancel<>'Y' and  billno='" + bno + "'", cn);

        SqlDataReader dr2 = cmd2.ExecuteReader();
        if (dr2.Read())
        {
            lblBillNox.Text = bno;
            lblBillDt.Text = Convert.ToString(dr2["bgndt"]);
            lblCustName.Text = Convert.ToString(dr2["CustomerName"]);
            lblManualBillNo.Text = Convert.ToString(dr2["manualbillno"]);

        }
        dr2.Close();

        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=WOInvoice.xls");
        //Response.Charset = "";
        //Response.ContentType = "Application/x-msexcel";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //frm.Controls.Add(tblbulk);
        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
        //tblbulk.Visible = false;

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=WithUnloadingDate.xls");
        Response.Charset = "";
        Response.ContentType = "Application/x-msexcel";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblbulk);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
        tblbulk.Visible = false;
    }
    public string NameOfNumber(string Number)
    {
        string GroupName = "";
        string OutPut = "";

        if ((Number.Length % 3) != 0)
        {
            Number = Number.PadLeft((Number.Length + (3 - (Number.Length % 3))), '0');
        }
        string[] Array = new string[Number.Length / 3];
        Int16 Element = -1;
        Int32 DisplayCount = -1;
        bool LimitGroupsShowAll = false;
        int LimitGroups = 0;
        bool GroupToWords = true;
        for (Int16 Count = 0; Count <= Number.Length - 3; Count += 3)
        {
            Element += 1;
            Array[Element] = Number.Substring(Count, 3);

        }
        if (LimitGroups == 0)
        {
            LimitGroupsShowAll = true;
        }
        for (Int16 Count = 0; (Count <= ((Number.Length / 3) - 1)); Count++)
        {
            DisplayCount++;
            if (((DisplayCount < LimitGroups) || LimitGroupsShowAll))
            {
                if (Array[Count] == "000") continue;
                {
                    GroupName = US[((Number.Length / 3) - 1) - Count + 1];
                }


                if ((GroupToWords == true))
                {
                    OutPut += Group(Array[Count]).TrimEnd(' ') + " " + GroupName + " ";

                }
                else
                {
                    OutPut += Array[Count].TrimStart('0') + " " + GroupName;

                }
            }

        }
        Array = null;
        return OutPut;

    }


    private string Group(string Argument)
    {
        string Hyphen = "";
        string OutPut = "";
        Int16 d1 = Convert.ToInt16(Argument.Substring(0, 1));
        Int16 d2 = Convert.ToInt16(Argument.Substring(1, 1));
        Int16 d3 = Convert.ToInt16(Argument.Substring(2, 1));
        if ((d1 >= 1))
        {
            OutPut += SNu[d1] + " hundred ";
        }
        if ((double.Parse(Argument.Substring(1, 2)) < 20))
        {
            OutPut += SNu[Convert.ToInt16(Argument.Substring(1, 2))];
        }
        if ((double.Parse(Argument.Substring(1, 2)) >= 20))
        {
            if (Convert.ToInt16(Argument.Substring(2, 1)) == 0)
            {
                Hyphen += " ";
            }
            else
            {
                Hyphen += " ";
            }
            OutPut += SNt[d2] + Hyphen + SNu[d3];
        }
        return OutPut;
    }

    private void Initialize()
    {

        SNu[0] = "";
        SNu[1] = "One";
        SNu[2] = "Two";
        SNu[3] = "Three";
        SNu[4] = "Four";
        SNu[5] = "Five";
        SNu[6] = "Six";
        SNu[7] = "Seven";
        SNu[8] = "Eight";
        SNu[9] = "Nine";
        SNu[10] = "Ten";
        SNu[11] = "Eleven";
        SNu[12] = "Twelve";
        SNu[13] = "Thirteen";
        SNu[14] = "Fourteen";
        SNu[15] = "Fifteen";
        SNu[16] = "Sixteen";
        SNu[17] = "Seventeen";
        SNu[18] = "Eighteen";
        SNu[19] = "Nineteen";
        SNt[2] = "Twenty";
        SNt[3] = "Thirty";
        SNt[4] = "Forty";
        SNt[5] = "Fifty";
        SNt[6] = "Sixty";
        SNt[7] = "Seventy";
        SNt[8] = "Eighty";
        SNt[9] = "Ninety";
        US[1] = "";
        US[2] = "Thousand";
        US[3] = "Million";
        US[4] = "Billion";
        US[5] = "Trillion";
        US[6] = "Quadrillion";
        US[7] = "Quintillion";
        US[8] = "Sextillion";
        US[9] = "Septillion";
        US[10] = "Octillion";
    }
    protected void abc(object sender, EventArgs e)
    {

        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;

    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdLoadUnload.PageIndex = e.NewPageIndex;
        BindTheData();

    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {

        DataView dv = new DataView();
        dv = ds.Tables["Dockets"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdLoadUnload.DataSource = ds.Tables["Dockets"];
        GrdLoadUnload.DataBind();

    }

    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {

        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
            E.Item.Cells[0].CssClass = "blackfnt";
        }

    }


    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DateTime d1;
            if (((Label)e.Row.FindControl("lblgendate")).Text != "" && ((Label)e.Row.FindControl("lblgendate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblgendate")).Text);
                ((Label)e.Row.FindControl("lblgendate")).Text = d1.ToString("dd MMM yyyy");
            }
            if (((Label)e.Row.FindControl("lblduedate")).Text != "" && ((Label)e.Row.FindControl("lblduedate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblduedate")).Text);
                ((Label)e.Row.FindControl("lblduedate")).Text = d1.ToString("dd MMM yyyy");
            }
            if (((Label)e.Row.FindControl("lblsubdate")).Text != "" && ((Label)e.Row.FindControl("lblsubdate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblsubdate")).Text);
                ((Label)e.Row.FindControl("lblsubdate")).Text = d1.ToString("dd MMM yyyy");
            }
            if (((Label)e.Row.FindControl("lblcollectiondate")).Text != "" && ((Label)e.Row.FindControl("lblcollectiondate")).Text != null)
            {
                d1 = Convert.ToDateTime(((Label)e.Row.FindControl("lblcollectiondate")).Text);
                ((Label)e.Row.FindControl("lblcollectiondate")).Text = d1.ToString("dd MMM yyyy");
            }
            ((Label)e.Row.FindControl("lblbilltype")).Text = "2" == "2" ? "TBB" : ((Label)e.Row.FindControl("lblbilltype")).Text;
        }
        if (Convert.ToString(Session["Client"]) == "EXL")
        {
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;
        }
        else if (Convert.ToString(Session["Client"]) == "PRRL")
        {
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;
        }

        else if (Convert.ToString(Session["Client"]) == "UFL")
        {
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
        }
        else
        {
	    if (e.Row.Cells.Count > 1)
            {
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[12].Visible = false;
            e.Row.Cells[13].Visible = false;
            e.Row.Cells[14].Visible = false;

}
        }
    }
    protected void GrdXLS1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Docket";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oTableCell.Font.Bold = true;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "Bill";
            oTableCell.ColumnSpan = 17;
            oTableCell.Font.Bold = true;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblmode;
            string mode, dno, sql, invno;
            mode = ((Label)e.Row.FindControl("lblmode")).Text;
            lblmode = (Label)e.Row.FindControl("lblmode");
            if (mode == "0")
            {
                lblmode.Text = "No Mode";
            }
            else if (mode == "1")
            {
                lblmode.Text = "Air";
            }
            else if (mode == "2")
            {
                lblmode.Text = "Road";
            }
            else if (mode == "3")
            {
                lblmode.Text = "Train";
            }
            else if (mode == "4")
            {
                lblmode.Text = "Express";
            }
            dno = ((Label)e.Row.FindControl("lblinvoiceno")).Text;
            sql = "select distinct invno from Webx_master_docket_invoice where Dockno='" + dno + "'";
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand(sql, cn);
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            dr = cmd.ExecuteReader();
            invno = "";
            while (dr.Read())
            {
                invno = invno + "," + Convert.ToString(dr["invno"]);
            }
            if (invno.Length > 0)
            {
                invno = invno.Substring(1, invno.Length - 1);
            }
            dr.Close();
            ((Label)e.Row.FindControl("lblinvoiceno")).Text = invno;
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblpcs = (Label)e.Row.FindControl("lblpcs");
            totpkgs = totpkgs + Convert.ToDouble(lblpcs.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblPkgs = (Label)e.Row.FindControl("totlblPkgs");
            totlblPkgs.Text = totpkgs.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblchargewt = (Label)e.Row.FindControl("lblchargewt");
            totchargewt = totchargewt + Convert.ToDouble(lblchargewt.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblchargewt = (Label)e.Row.FindControl("totlblchargewt");
            totlblchargewt.Text = totchargewt.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblrate = (Label)e.Row.FindControl("lblrate");
            totrate = totrate + Convert.ToDouble(lblrate.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblrate = (Label)e.Row.FindControl("totlblrate");
            totlblrate.Text = totrate.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblfreight = (Label)e.Row.FindControl("lblfreight");
            totfreight = totfreight + Convert.ToDouble(lblfreight.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblfreight = (Label)e.Row.FindControl("totlblfreight");
            totlblfreight.Text = totfreight.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbldc = (Label)e.Row.FindControl("lbldc");
            totdc = totdc + Convert.ToDouble(lbldc.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblDC = (Label)e.Row.FindControl("totlblDC");
            totlblDC.Text = totdc.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbldccharge = (Label)e.Row.FindControl("lbldccharge");
            totdccharge = totdccharge + Convert.ToDouble(lbldccharge.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblDCC = (Label)e.Row.FindControl("totlblDCC");
            totlblDCC.Text = totdccharge.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblddcharge = (Label)e.Row.FindControl("lblddcharge");
            totddcharge = totddcharge + Convert.ToDouble(lblddcharge.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblDDCharge = (Label)e.Row.FindControl("totlblDDCharge");
            totlblDDCharge.Text = totddcharge.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblfov = (Label)e.Row.FindControl("lblfov");
            totFOV = totFOV + Convert.ToDouble(lblfov.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblFOV = (Label)e.Row.FindControl("totlblFOV");
            totlblFOV.Text = totFOV.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblotchg = (Label)e.Row.FindControl("lblotchg");
            tototchg1 = tototchg1 + Convert.ToDouble(lblotchg.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblOtherCharge = (Label)e.Row.FindControl("totlblOtherCharge");
            totlblOtherCharge.Text = tototchg1.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbldkttot = (Label)e.Row.FindControl("lbldkttot");
            totdkttot = totdkttot + Convert.ToDouble(lbldkttot.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblTotal = (Label)e.Row.FindControl("totlblTotal");
            totlblTotal.Text = totdkttot.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblbillamount = (Label)e.Row.FindControl("lblbillamount");
            totbillamt = totbillamt + Convert.ToDouble(lblbillamount.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblBillAmount = (Label)e.Row.FindControl("totlblBillAmount");
            totlblBillAmount.Text = totbillamt.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblstaxcesshcess = (Label)e.Row.FindControl("lblstaxcesshcess");
            totstaxcesshcess = totstaxcesshcess + Convert.ToDouble(lblstaxcesshcess.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblStax = (Label)e.Row.FindControl("totlblStax");
            totlblStax.Text = totstaxcesshcess.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblBasicFreight = (Label)e.Row.FindControl("lblBasicFreight");
            totbasicfreight = totbasicfreight + Convert.ToDouble(lblBasicFreight.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblbasicfreight = (Label)e.Row.FindControl("totlblbasicfreight");
            totlblbasicfreight.Text = totbasicfreight.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblsubtotal = (Label)e.Row.FindControl("lblsubtotal");
            totSubTotal = totSubTotal + Convert.ToDouble(lblsubtotal.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblSubTotal = (Label)e.Row.FindControl("totlblSubTotal");
            totlblSubTotal.Text = totSubTotal.ToString();
        }

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblActualWeight = (Label)e.Row.FindControl("lblActualWeight");
            totActualWeight = totActualWeight + Convert.ToDouble(lblActualWeight.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblActualWeight = (Label)e.Row.FindControl("totlblActualWeight");
            totlblActualWeight.Text = totActualWeight.ToString();
        }

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFreightdiff = (Label)e.Row.FindControl("lblFreightdiff");
            totFreightDiff = totFreightDiff + Convert.ToDouble(lblFreightdiff.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblfreightDiff = (Label)e.Row.FindControl("totlblfreightDiff");
            totlblfreightDiff.Text = totFreightDiff.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbldktcharge = (Label)e.Row.FindControl("lbldktcharge");
            totdktchrg = totdktchrg + Convert.ToDouble(lbldktcharge.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblDocketCharge = (Label)e.Row.FindControl("totlblDocketCharge");
            totlblDocketCharge.Text = totdktchrg.ToString();
        }

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblMiscChrg = (Label)e.Row.FindControl("lblMiscChrg");
            totMiscChrg = totMiscChrg + Convert.ToDouble(lblMiscChrg.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblMisc = (Label)e.Row.FindControl("totlblMisc");
            totlblMisc.Text = totMiscChrg.ToString();
        }

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblDemmerageCharge = (Label)e.Row.FindControl("lblDemmerageCharge");
            totDemChrg = totDemChrg + Convert.ToDouble(lblDemmerageCharge.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblDemmerageCharge = (Label)e.Row.FindControl("totlblDemmerageCharge");
            totlblDemmerageCharge.Text = totDemChrg.ToString();
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblSurCharge = (Label)e.Row.FindControl("lblSurCharge");
            totSurChrg = totSurChrg + Convert.ToDouble(lblSurCharge.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblSurCharge = (Label)e.Row.FindControl("totlblSurCharge");
            totlblSurCharge.Text = totSurChrg.ToString();
        }

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblLabour = (Label)e.Row.FindControl("lblLabour");
            totLabour = totLabour + Convert.ToDouble(lblLabour.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblLabour = (Label)e.Row.FindControl("totlblLabour");
            totlblLabour.Text = totLabour.ToString();
        }

        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblCartage = (Label)e.Row.FindControl("lblCartage");
            totCartage = totCartage + Convert.ToDouble(lblCartage.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label totlblCartage = (Label)e.Row.FindControl("totlblCartage");
            totlblCartage.Text = totCartage.ToString();
        }

    }
    protected void GrdXLS2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {

        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblmode;
            string mode, dno, sql, invno;
            mode = ((Label)e.Row.FindControl("lblmode")).Text;
            lblmode = (Label)e.Row.FindControl("lblmode");
            if (mode == "0")
            {
                lblmode.Text = "No Mode";
            }
            else if (mode == "1")
            {
                lblmode.Text = "Air";
            }
            else if (mode == "2")
            {
                lblmode.Text = "Road";
            }
            else if (mode == "3")
            {
                lblmode.Text = "Train";
            }
            else if (mode == "4")
            {
                lblmode.Text = "Express";
            }

        }
        tot_oth = tot_oth + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "OTCHG") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "OTCHG"));
        totcodchg = totcodchg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "codchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "codchg"));
        tothldchrg = tothldchrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_chrg"));
        totstatechrg = totstatechrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "state_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "state_chrg"));
        tothlddlychrg = tothlddlychrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hld_dlychrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hld_dlychrg"));
        totnformchrg = totnformchrg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "nform_chrg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "nform_chrg"));
        totfodcharge = totfodcharge + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "FODCharge") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "FODCharge"));
        tototchg = tototchg + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "otchg") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "otchg"));
        totsvctax = totsvctax + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "servicetax") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "servicetax"));
        totcess = totcess + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "cess"));
        totheducess = totheducess + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "hedu_cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "hedu_cess"));
        lblOtherCharges.Text = Convert.ToString(tot_oth);
        lblcoddod.Text = Convert.ToString(totcodchg);
        lblhandlecharge.Text = Convert.ToString(tothldchrg);
        lblstatechrg.Text = Convert.ToString(totstatechrg);
        lblholidaychrg.Text = Convert.ToString(tothlddlychrg);
        lblnformcharge.Text = Convert.ToString(totnformchrg);
        lblfodcharge.Text = Convert.ToString(totfodcharge);
        lblothercharge.Text = Convert.ToString(tototchg);
        lblservicetax.Text = Convert.ToString(totsvctax);
        lblcessontax.Text = Convert.ToString(totcess);
        lblhigheducess.Text = Convert.ToString(totheducess);
        
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totqty1 = totqty1 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ChargeWeight") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "ChargeWeight"));
            totamt1 = totamt1 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "Amount"));
            Int64 amt1 = Convert.ToInt64(totamt1);
            RupeesToWords rupee = new RupeesToWords();
            lbl_Inwords.Text = Convert.ToString(rupee.NumberToText(amt1));
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totqty2 = totqty2 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ChargeWeight") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "ChargeWeight"));
            totamt2 = totamt2 + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "Amount"));
            Int64 amt = Convert.ToInt64(totamt2);
            RupeesToWords rupee = new RupeesToWords();
            lbl_Inwords.Text = Convert.ToString(rupee.NumberToText(amt));
            
        }
    }
}
