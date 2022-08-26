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

public partial class GUI_UNI_MIS_accounts_mis_ledger_prestart : System.Web.UI.Page
    //, System.Web.UI.ICallbackEventHandler

{
    //protected System.Collections.Specialized.ListDictionary catalog;
    //protected String returnValue;

    string scriptStr;
    string sql, sqlall1;
    SqlDataAdapter da;
    DateFunction DAccess = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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

            if (loccode == Session["HeadOfficeCode"].ToString())
            {
                sql = "select loccode,locname + ' : ' + loccode as locname from webx_location where activeFlag='Y' order by locName";
            }
            else
            {
                sql = "select loccode,locname + ' : ' + loccode as locname from webx_location where activeFlag='Y' and loccode='" + loccode + "' order by locName";
            }
            da= new SqlDataAdapter(sql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Load");
            dlstBranch.DataSource = ds;
            dlstBranch.DataValueField = "loccode";
            dlstBranch.DataTextField = "locname";
            dlstBranch.DataBind();
            dlstBranch.Items.Insert(0, "Select");
            dlstBranch.Items[0].Value = "";
            dlstBranch.SelectedValue = loccode;
            string HQ = Session["brcd"].ToString();
            if (loccode == Session["HeadOfficeCode"].ToString())
            {
                sqlall1 = "select acccode,acccode + ' : ' + accdesc as accdesc from webx_acctinfo where activeFlag='Y' and (  acccategory='BANK')  order  by accdesc";
            }
            else
            {
                sqlall1 = "select acccode,acccode + ' : ' + accdesc as accdesc from webx_acctinfo where activeFlag='Y' and (  ((bkloccode like '%" + HQ + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            da = new SqlDataAdapter(sqlall1, conn);
            DataSet ds1 = new DataSet();
            da.Fill(ds1, "Load");
            dlstSalesAmount.DataSource = ds1;
            dlstSalesAmount.DataValueField = "acccode";
            dlstSalesAmount.DataTextField = "accdesc";
            dlstSalesAmount.DataBind();
            dlstSalesAmount.Items.Insert(0, "Select");
            dlstSalesAmount.Items[0].Value = "";
            dlstSalesAmount.Items[0].Selected = true;
        }
        
    }

    public void change_Account(object sender, EventArgs e)
    {
        string HQ = Session["brcd"].ToString();
        if (dlstBranch.SelectedItem.Value == Session["brcd"].ToString())
        {
            sqlall1 = "select acccode,acccode + ' : ' + accdesc as accdesc from webx_acctinfo where activeFlag='Y' and (  acccategory='BANK')  order  by accdesc";
        }
        else
        {
            sqlall1 = "select acccode,acccode + ' : ' + accdesc as accdesc from webx_acctinfo where activeFlag='Y' and (  ((bkloccode like '%" + dlstBranch.SelectedItem.Value + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
        }
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
            da = new SqlDataAdapter(sqlall1, conn);
            DataSet ds1 = new DataSet();
            da.Fill(ds1, "Load");
            dlstSalesAmount.DataSource = ds1;
            dlstSalesAmount.DataValueField = "acccode";
            dlstSalesAmount.DataTextField = "accdesc";
            dlstSalesAmount.DataBind();
            dlstSalesAmount.Items.Insert(0, "Select");
            dlstSalesAmount.Items[0].Value = "";
            dlstSalesAmount.Items[0].Selected = true;
        }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string strdlstTranType = dlstTranType.SelectedItem.Value;
        string branText = dlstBranch.SelectedItem.Text;
        string branch = dlstBranch.SelectedItem.Value;
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
                Response.Redirect("BankRecoPrint.aspx?branch=" + branch + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&branText=" + branText + "&strSalesAccountText=" + strSalesAccountText + "&TranType=" + strdlstTranType + "&FinYear=" + FinYear, true);
            }
        }
        else if (redToday.Checked == true)
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            string dateFrom = DAccess.return_date(date);
            string dateTo = DAccess.return_date(date);
            Response.Redirect("BankRecoPrint.aspx?branch=" + branch + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&branText=" + branText + "&strSalesAccountText=" + strSalesAccountText + "&TranType=" + strdlstTranType + "&FinYear=" + FinYear, true);
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
            Response.Redirect("BankRecoPrint.aspx?branch=" + branch + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&branText=" + branText + "&strSalesAccountText=" + strSalesAccountText + "&TranType=" + strdlstTranType + "&FinYear=" + FinYear, true);
        }
    }
}
