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
{
    string scriptStr;
    string sql, sqlall1;
    SqlDataAdapter da;
    DateFunction DAccess = new DateFunction();
    SqlDataReader dtr;
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
                dlstTranType.Enabled = false;
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

            sqlall1 = "select Company_Acccode as acccode,accdesc + ' - ' + Company_Acccode as accdesc,acccode as actual_acccode from webx_acctinfo where activeFlag='Y' order by accdesc";
            da = new SqlDataAdapter(sqlall1, conn);
            DataSet ds1 = new DataSet();
            da.Fill(ds1, "Load");
            dlstSalesAmount.DataSource = ds1;
            dlstSalesAmount.DataValueField = "actual_acccode";
            dlstSalesAmount.DataTextField = "accdesc";
            dlstSalesAmount.DataBind();
            dlstSalesAmount.Items.Insert(0, "Select");
            dlstSalesAmount.Items[0].Value = "";
            dlstSalesAmount.Items[0].Selected = true;

        }
        
    }
    public void accout_info(string groupcode)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string branText = dlstBranch.SelectedItem.Text;
        string branch = dlstBranch.SelectedItem.Value;
        string strdlstTranType = dlstTranType.SelectedItem.Value.ToString();
        string strdlstSalesAmount="" ; //= dlstSalesAmount.SelectedItem.Value;
        string strSalesAccountText = "";
        
        strdlstSalesAmount = dlstSalesAmount.SelectedItem.Value;
       
        if (redFromTo.Checked == true)
        {
            if (txtDateFrom.CalendarDate != "" && txtDateTo.CalendarDate != "")
            {
                string dateFrom = DAccess.return_date(txtDateFrom.CalendarDate);
                string dateTo = DAccess.return_date(txtDateTo.CalendarDate);
                Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&branText=" + branText, true);
            }
        }
        else if (redToday.Checked == true)
        {
            DateTime dt = DateTime.Now;
            string date = dt.ToString("dd/MM/yyyy");
            string dateFrom = DAccess.return_date(date);
            string dateTo = DAccess.return_date(date);
            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&branText=" + branText + "&strSalesAccountText=" + strSalesAccountText, true);
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

            Response.Redirect("result.aspx?branch=" + branch + "&strdlstTranType=" + strdlstTranType + "&dateFrom=" + dateFrom + "&dateTo=" + dateTo + "&strdlstSalesAmount=" + strdlstSalesAmount + "&branText=" + branText + "&strSalesAccountText=" + strSalesAccountText, true);
        }
    }
    
}
