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

public partial class GUI_UNI_MIS_RPT_Date : System.Web.UI.UserControl
{
    private DateFunction df = new DateFunction();
    public string FinYear = "", currdate;
    private string _FromDT = "";
    private string _ToDT = "";
    private bool _EnableTillDate = false;

    public string JSFromDT = "", JSToDT = "";

    public string FromDate
    {
        get 
        {
            GetFromToDates();
            return _FromDT;
        }
    }
    public string ToDate
    {
        get
        {
            GetFromToDates();
            return _ToDT;
        }
    }
    public bool EnableTillDate
    {
        get { return _EnableTillDate; }
        set { _EnableTillDate = value; }
    }

    public DateTime DateFrom
    {
        get
        {
            return Convert.ToDateTime(FromDate);
        }
    }
    public DateTime DateTo
    {
        get
        {
            return Convert.ToDateTime(ToDate);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        FinYear = Session["FinYear"].ToString().Substring(2, 2);
        currdate = DateTime.Now.ToString("dd/MM/yyyy");
        //document.getElementById('" + radDate.ClientID + "_0').checked=true;
        JSFromDT = "cal.select(" + txtDateFrom.ClientID + ",'anchor1','dd/MM/yyyy'); markDateRange(); return false;";
        JSToDT = "cal.select(" + txtDateTo.ClientID + ",'anchor2','dd/MM/yyyy'); markDateRange(); return false;";

        radDate.Items[0].Attributes.Add("OnClick", "javascript:makeDateRange();");
        radDate.Items[1].Attributes.Add("OnClick", "javascript:makeDateRange();");
        radDate.Items[2].Attributes.Add("OnClick", "javascript:makeDateRange();");
        radDate.Items[3].Attributes.Add("OnClick", "javascript:makeDateRange();");
        
        if (!IsPostBack && !Page.IsCallback)
        {            
            txtDateFrom.Text = DateTime.Now.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = currdate;
            txtDateFrom.Enabled = false;
            txtDateTo.Enabled = false;
            radDate.Items[3].Enabled = EnableTillDate;
        }
    }

    private void GetFromToDates()
    {
        string report_mode = "Week";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Tilldate";
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        
        _FromDT = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        _ToDT = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
    }
}
