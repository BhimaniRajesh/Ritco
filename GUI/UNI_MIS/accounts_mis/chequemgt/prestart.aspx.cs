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

public partial class GUI_UNI_MIS_accounts_mis_ledger_prestart : System.Web.UI.Page
{
    string scriptStr;
    string sql, sqlall1;
    DateFunction DAccess = new DateFunction();
    DataSet ds = new DataSet();
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
            string loccode = Session["brcd"].ToString();
            sqlall1 = "select acccode,accdesc + ' : ' + Company_acccode as accdesc,acccategory from webx_acctinfo where acccategory in ('BANK') order by acccategory desc";
            ds = DAccess.getdataset(sqlall1);
            dlstSalesAmount.DataSource = ds;
            dlstSalesAmount.DataValueField = "acccode";
            dlstSalesAmount.DataTextField = "accdesc";
            dlstSalesAmount.DataBind();
            dlstSalesAmount.Items.Insert(0, "All");
            dlstSalesAmount.Items[0].Value = "All";
            dlstSalesAmount.Items[0].Selected = true;
        }
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string strdlstSalesAmount = dlstSalesAmount.SelectedItem.Value;
        string strSalesAccountText = dlstSalesAmount.SelectedItem.Text;
        string FinYear="";
        DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
        if (mpLabel != null)
        {
            FinYear = mpLabel.SelectedItem.Value;
        }
        if (redFromTo.Checked == true)
        {
            if (txtDateFrom.CalendarDate != "" && txtDateTo.CalendarDate != "")
            {
                string dateFrom = DAccess.return_date(txtDateFrom.CalendarDate);
                string dateTo = DAccess.return_date(txtDateTo.CalendarDate);
                Response.Redirect("result.aspx?dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&strSalesAccountText=" + strSalesAccountText , true);
            }
        }
        else if (redToday.Checked == true)
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            string dateFrom = DAccess.return_date(date);
            string dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&strSalesAccountText=" + strSalesAccountText, true);
        }
        else 
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");

            DateTime righnow = DateTime.Now;
            righnow = righnow.AddDays(-6);
            string strrightnow = righnow.ToString("dd/MM/yyyy");

            string dateFrom = DAccess.return_date(strrightnow);
            string dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&strSalesAccountText=" + strSalesAccountText, true);
        }
    }
}
