using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Finance_voucher_Print_frmvoucher_view_printResult : System.Web.UI.Page
{
    DataAccess DAccess = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string voucher = Request.QueryString["VoucherNo"].ToString().Trim();
            string location = Request.QueryString["branch"].ToString().Trim();
            string date_from = Request.QueryString["dateFrom"].ToString().Trim();
            string date_to = Request.QueryString["dateTo"].ToString().Trim();
            string fin_year = Session["YearVal"].ToString();
            //string voucher_type = Request.QueryString["voucher_type"].ToString().Trim();

            if (voucher == "")
            {
                if (location == Session["HeadOfficeCode"].ToString())
                {
                    myGrid.DataSource = DAccess.getdataset("select distinct Transdate,convert(varchar,Transdate,106) as tran_date,Voucherno,brcd  from webx_acctrans_" + fin_year + " where Voucher_Cancel='N' and convert(varchar,Transdate,106) between convert(datetime,'" + date_from + "',106) and convert(varchar,'" + date_to + "',106) order by Transdate desc");
                }
                else
                {
                    myGrid.DataSource = DAccess.getdataset("select distinct Transdate,convert(varchar,Transdate,106) as tran_date,Voucherno,brcd  from webx_acctrans_" + fin_year + " where Voucher_Cancel='N' and convert(varchar,Transdate,106) between convert(datetime,'" + date_from + "',106) and convert(varchar,'" + date_to + "',106) and brcd = " + location + " order by Transdate desc");
                }
                myGrid.DataBind();
            }
            else
            {
                if (location == Session["HeadOfficeCode"].ToString())
                {
                    myGrid.DataSource = DAccess.getdataset("select distinct Transdate,convert(varchar,Transdate,106) as tran_date,Voucherno,brcd  from webx_acctrans_" + fin_year + " where Voucher_Cancel='N' and voucherno=" + voucher +" order by Transdate desc");
                }
                else
                {
                    myGrid.DataSource = DAccess.getdataset("select distinct Transdate,convert(varchar,Transdate,106) as tran_date,Voucherno,brcd  from webx_acctrans_" + fin_year + " where Voucher_Cancel='N' and  brcd = " + location + " and voucherno=" + voucher + " order by Transdate desc");
                }
                myGrid.DataBind();
            }
        }
    }
}
