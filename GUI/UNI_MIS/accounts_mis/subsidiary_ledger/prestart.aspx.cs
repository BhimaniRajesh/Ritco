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

public partial class GUI_UNI_MIS_accounts_mis_subsidiary_ledger_prestart : System.Web.UI.Page
{
    string scriptStr;
    string sql, sqlall1;
    SqlDataAdapter da;
    DateFunction DAccess = new DateFunction();
    string dateFrom, dateTo;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strredFromTo = redFromTo.ID.ToString();
        string strToDay = redToday.ID.ToString();
        string strSevenDay = redSevenDay.ID.ToString();
        string scriptStr = "javascript:return CHK1(this," + strredFromTo + " )";
        string scriptStrToday = "javascript:return CHK1(this," + strToDay + ")";
        string scriptstrSevenDay = "javascript:return CHK1(this," + strSevenDay + ")";

        redFromTo.Attributes.Add("onClick", scriptStr);
        redToday.Attributes.Add("onClick", scriptStrToday);
        redSevenDay.Attributes.Add("onClick", scriptstrSevenDay);

        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string loccode = Session["brcd"].ToString();

            if (loccode == Session["HeadOfficeCode"].ToString())
            {
                sql = "select loccode,locname + ' : ' + loccode as locname from webx_location where activeFlag='Y' order by locName";
            }
            else
            {
                sql = "select loccode,locname + ' : ' + loccode as locname from webx_location where activeFlag='Y' and loccode='" + loccode + "' order by locName";
            }
            da = new SqlDataAdapter(sql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Load");
            dlstBranch.DataSource = ds;
            dlstBranch.DataValueField = "loccode";
            dlstBranch.DataTextField = "locname";
            dlstBranch.DataBind();
            dlstBranch.Items.Insert(0, "Select");
            dlstBranch.Items[0].Value = "";
            dlstBranch.SelectedValue = loccode;
        }
    }
    protected void btn_Customer_Click(object sender, EventArgs e)
    {
        string branch = dlstBranch.SelectedItem.Value;
        string branchText = dlstBranch.SelectedItem.Text;
        string strdlstTranType = dlstTranType.SelectedItem.Value;
        string cust_code = txtCustomer.Text;
        string cust = "Y";
        if (redFromTo.Checked == true)
        {
            if (txtDateFrom.CalendarDate != "" && txtDateTo.CalendarDate != "")
            {
                dateFrom = DAccess.return_date(txtDateFrom.CalendarDate);
                dateTo = DAccess.return_date(txtDateTo.CalendarDate);
                Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&cust_code=" + cust_code + "&branchText=" + branchText + "&cust=" + cust + "&ledgerof=C", true);
            }
        }
        else if (redToday.Checked == true)
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            dateFrom = DAccess.return_date(date);
            dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&cust_code=" + cust_code + "&branchText=" + branchText + "&cust=" + cust + "&ledgerof=C", true);
        }
        else
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");

            DateTime righnow = DateTime.Now;
            righnow = righnow.AddDays(-6);
            string strrightnow = righnow.ToString("dd/MM/yyyy");

            dateFrom = DAccess.return_date(strrightnow);
            dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&cust_code=" + cust_code + "&branchText=" + branchText + "&cust=" + cust + "&ledgerof=C", true);
        }
    }

    protected void btnVendor_Click(object sender, EventArgs e)
    {
        string branch = dlstBranch.SelectedItem.Value;
        string branchText = dlstBranch.SelectedItem.Text;
        string strdlstTranType = dlstTranType.SelectedValue;
        string vend_code = txtVendor.Text;
        if (redFromTo.Checked == true)
        {
            if (txtDateFrom.CalendarDate != "" && txtDateTo.CalendarDate != "")
            {
                dateFrom = DAccess.return_date(txtDateFrom.CalendarDate);
                dateTo = DAccess.return_date(txtDateTo.CalendarDate);
                Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&vend_code=" + vend_code + "&branchText=" + branchText + "&ledgerof=V", true);
            }
        }
        else if (redToday.Checked == true)
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            dateFrom = DAccess.return_date(date);
            dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&vend_code=" + vend_code + "&branchText=" + branchText + "&ledgerof=V", true);
        }
        else
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            DateTime righnow = DateTime.Now;
            righnow = righnow.AddDays(-6);
            string strrightnow = righnow.ToString("dd/MM/yyyy");

            dateFrom = DAccess.return_date(strrightnow);
            dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&vend_code=" + vend_code + "&branchText=" + branchText + "&ledgerof=V", true);
        }
    }
    protected void btnEmployee_Click(object sender, EventArgs e)
    {
        string branch = dlstBranch.SelectedItem.Value;
        string branchText = dlstBranch.SelectedItem.Text;
        string strdlstTranType = dlstTranType.SelectedValue;
        string emp_code = txtEmployee.Text;
        if (redFromTo.Checked == true)
        {
            if (txtDateFrom.CalendarDate != "" && txtDateTo.CalendarDate != "")
            {
                dateFrom = DAccess.return_date(txtDateFrom.CalendarDate);
                dateTo = DAccess.return_date(txtDateTo.CalendarDate);
                Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&emp_code=" + emp_code + "&branchText=" + branchText + "&ledgerof=E", true);
            }
        }
        else if (redToday.Checked == true)
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            dateFrom = DAccess.return_date(date);
            dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&emp_code=" + emp_code + "&branchText=" + branchText + "&ledgerof=E", true);
        }
        else
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");

            DateTime righnow = DateTime.Now;
            righnow = righnow.AddDays(-6);
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            dateFrom = DAccess.return_date(strrightnow);
            dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&emp_code=" + emp_code + "&branchText=" + branchText + "&ledgerof=E", true);
        }
    }
}
