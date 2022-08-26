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

public partial class GUI_Octroi_ViewOctroiBill_FrmBillDetail_RITCO : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    SqlConnection cn;
    string frmdate, todate, fdate, tdate, billno, mbillno;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            tblall.Visible = false;
            tblbillno.Visible = false;

            Array str, str1;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            billno = Request.QueryString["billno"];
            mbillno = Request.QueryString["mbillno"];
            
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            frmdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            todate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            lbldaterange.Text = TxtDateRange.Text;
           
            lblbillno.Text = billno;
            lblmbillno.Text = mbillno;
            
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
            cmd.CommandText = "select BillNo,BBRCD,Convert(Varchar(20),BGNDT,106) as BGNDT,PTMSCD + ':' + PTMSNM as PartyName,BILLAMT from webx_BillMST where BillNo='" + billno + "' and paybas='6'";
        }
        else if (mbillno != "")
        {
            cmd.CommandText = "select BillNo,BBRCD,Convert(Varchar(20),BGNDT,106) as BGNDT,PTMSCD + ':' + PTMSNM as PartyName,BILLAMT from webx_billmst where manualbillno='" + mbillno + "' and paybas='6'";
        }
        else
        {
            cmd.CommandText = "select BillNo,BBRCD,Convert(Varchar(20),BGNDT,106) as BGNDT,PTMSCD + ':' + PTMSNM as PartyName,BILLAMT from webx_billmst where convert(varchar,bgndt,106) between Convert(datetime,'" + frmdate + "',106) and convert(datetime,'" + todate + "',106) and paybas='6'";
        }

        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        DataSet ds1 = new DataSet();
        sqlDA.Fill(ds1);
        grvOctroi.DataSource = ds1;
        grvOctroi.DataBind();

    }
    protected void grvOctroi_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grvOctroi.PageIndex = e.NewPageIndex;
        BindTheData();
    }
}
