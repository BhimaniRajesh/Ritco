using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TruckProfit_Result : System.Web.UI.Page
{
    //static string FROMDT;
    //static string TODT;


    public static string strFromDate;
    public static string strToDate;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            strFromDate = "";
            strToDate = "";
            //FROMDT = Convert.ToDateTime(Request.QueryString["FROMDT"].ToString()).ToString("dd MMM yyyy");
            //TODT = Convert.ToDateTime(Request.QueryString["TODT"].ToString()).ToString("dd MMM yyyy");

            strFromDate = getDateInddMMMyyFormat(Request.QueryString["FROMDT"].ToString());
            strToDate = getDateInddMMMyyFormat(Request.QueryString["TODT"].ToString());

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();

            string strConnStr = Convert.ToString(Session["SqlProvider"]);
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TruckProfitSummary";

            ReportViewer1.ShowPrintButton = true;

            ReportViewer1.Visible = true;
            ReportParameter[] parameters = new ReportParameter[4];

            parameters[0] = new ReportParameter("FROMDATE", strFromDate);
            parameters[1] = new ReportParameter("TODATE", strToDate);
            parameters[2] = new ReportParameter("RO", Request.QueryString["RO"].ToString());
            parameters[3] = new ReportParameter("LO", Request.QueryString["LO"].ToString());

            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();


            //added By Manisha 20/5/2014
            DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
        }
    }

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
}