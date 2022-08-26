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
using Microsoft.VisualBasic;
using System.Globalization;

public partial class GUI_Finance_voucher_FrmVoucherDetail : System.Web.UI.Page
{
   
    SqlConnection cn;
    String frmdate, todate, fdate, tdate, VoucherNo,DocumentType,Vendor,VendorType;
    string _deciml, iamegyrl = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        if (!IsPostBack)
        {
            Array str, str1;
            VendorType = Request.QueryString["vendortype"];
            fdate = Request.QueryString["fromdate"];
            tdate = Request.QueryString["todt"];
            VoucherNo = Request.QueryString["VoucherNo"];
            DocumentType = Request.QueryString["DocumentType"];
            Vendor = Request.QueryString["vendor"];

            //Response.Write(fdate);
            //Response.End();
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            frmdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            todate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtDateRange.Text = TxtDateRange.Text;
            lblVoucherNo.Text = VoucherNo;
            BindTheData();
        }
    }
    public void BindTheData()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "";
        if (VoucherNo == "" || VoucherNo == null)
        {
            if (DocumentType == "T")
            {
                sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch, VendorCode + ':' + VendorName as Vendor,convert(varchar,Paydt,106) paydt,(netamt-pendamt) as paidamt from WEBX_VendorBill_hdr where betype='THC' and VoucherNo is not NULL and VendorCode='" + Vendor + "' and convert(varchar,PayDt,106) between convert(varchar,'" + fdate + "',103) and convert(varchar,'" + tdate + "',103) and Company_Code='" + SessionUtilities.DefaultCompanyCode.ToUpper().Trim() + "' ";
            }
            else if (DocumentType == "P")
            {
                sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch, VendorCode + ':' + VendorName as Vendor,convert(varchar,Paydt,106) paydt,(netamt-pendamt) as paidamt from WEBX_VendorBill_hdr where betype='PDC' and VoucherNo is not NULL and VendorCode='" + Vendor + "' and convert(varchar,PayDt,106) between convert(varchar,'" + fdate + "',103) and convert(varchar,'" + tdate + "',103) and Company_Code='" + SessionUtilities.DefaultCompanyCode.ToUpper().Trim() + "' ";
            }
            else if (DocumentType == "B")
            {
                sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch, VendorCode + ':' + VendorName as Vendor,convert(varchar,Paydt,106) paydt,(netamt-pendamt) as paidamt from WEBX_VendorBill_hdr where betype='BA Payment' and VoucherNo is not NULL and VendorCode='" + Vendor + "' and convert(varchar,PayDt,106) between convert(varchar,'" + fdate + "',103) and convert(varchar,'" + tdate + "',103) and Company_Code='" + SessionUtilities.DefaultCompanyCode.ToUpper().Trim() + "' ";
            }
            else if (DocumentType == "O")
            {
                sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch,VendorCode + ':' + VendorName as Vendor,convert(varchar,Paydt,106) paydt,(netamt-pendamt) as paidamt from WEBX_VendorBill_hdr where betype like '%Expense%' and VoucherNo is not NULL and VendorCode='" + Vendor + "' and convert(varchar,PayDt,106) between convert(datetime,'" + fdate + "',103) and convert(datetime,'" + tdate + "',103) and Company_Code='" + SessionUtilities.DefaultCompanyCode.ToUpper().Trim() + "' ";
            }
            //Response.Write(sql);
            //Response.End();
            GridVoucher.Visible = true;
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sqlDA.Fill(ds);

            GridVoucher.DataSource = ds;
            GridVoucher.DataBind();
        }
        else
        {

            sql = "select  distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch,VendorCode + ':' + VendorName as Vendor ,convert(varchar,Paydt,106) Paydt,(netamt-pendamt) as paidamt from WEBX_VendorBill_hdr where VoucherNo='" + VoucherNo + "' and Company_Code='" + SessionUtilities.DefaultCompanyCode.ToUpper().Trim() + "'";
            //sql = "select distinct VoucherNo as VoucherNo,PBOV_CODE + ':' + PBOV_NAME as Vendor,BRCD as Branch,convert(varchar,transdate,106) Paydt,credit as paidamt from webx_vouchertrans_arch where voucherNo='" + VoucherNo + "'";
            //}
            //else if (DocumentType == "P")
            //{
            //    sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch,VendorCode + ':' + VendorName as Vendor from WEBX_VendorBill_hdr whereVoucherNo='" + VoucherNo + "'";
            //}
            //else if (DocumentType == "B")
            //{
            //    sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch,VendorCode + ':' + VendorName as Vendor from WEBX_VendorBill_hdr where  VoucherNo='" + VoucherNo + "'";
            //}
            //else if (DocumentType == "O")
            //{
            //    sql = "select distinct VoucherNo as VoucherNo,betype as DocumentType, BRCD as Branch,VendorCode + ':' + VendorName as Vendor from WEBX_VendorBill_hdr where  VoucherNo='" + VoucherNo + "'";
            //}
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sqlDA.Fill(ds);
            GridView1.Visible = true;
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        cn.Close();
        //Response.Write(sql);
        //Response.End();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridVoucher.PageIndex = e.NewPageIndex;
        BindTheData();

    }
}