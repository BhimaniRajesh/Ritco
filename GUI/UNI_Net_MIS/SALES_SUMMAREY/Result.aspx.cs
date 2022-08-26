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
using System.Collections.Generic;
using System.Reflection;
using Microsoft.Reporting.WebForms;
public partial class GUI_UNI_NET_MIS_SALES_SUMMAREY_Result : System.Web.UI.Page
{
    SqlConnection conn;
    public static string selyear;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string stryear = Request.QueryString["stryear"].ToString();
            string strmonths = Request.QueryString["strmonths"].ToString();
            string DT_TYPE = Request.QueryString["DT_TYPE"].ToString();
            string custcode = Request.QueryString["custcode"].ToString();
        
            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("STRYEAR", stryear.ToString()));
            parameters.Add(new ReportParameter("STRMONTH", strmonths.ToString()));
            parameters.Add(new ReportParameter("LOCTYP", DT_TYPE.ToString()));
            parameters.Add(new ReportParameter("custcode", custcode.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Sales_Summary";

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            if (userAgent.Contains("MSIE 7.0") || userAgent.Contains("MSIE 8.0"))
            {
                // ReportViewer1.Style.Add("margin-bottom", "26px");
                ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }
            else
                ReportViewer1.Style.Add("margin-bottom", "26px");

            ReportViewer1.ServerReport.SetParameters(parameters);
        }           
       
    }
}
