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
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;


public partial class GUI_UNI_Net_MIS_ReportCounterSummary_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string location = Request.QueryString["location"].ToString();
            //string locLevel = Request.QueryString["locLevel"].ToString();
            //string RO = Request.QueryString["RO"].ToString();
            //string LO = Request.QueryString["LO"].ToString();            
            string Fromdt = Request.QueryString["fromdt"].ToString();
            string Todt = Request.QueryString["todt"].ToString();            
            string RPTType = Request.QueryString["RPTType"].ToString();
            string EmpCode = Request.QueryString["EmpCode"].ToString();
            string ReportType = Request.QueryString["ReportType"].ToString();
            string ReportCode = Request.QueryString["ReportCode"].ToString();

            

            List<ReportParameter> parameters = new List<ReportParameter>();

            //parameters.Add(new ReportParameter("location", location.ToString()));
            //parameters.Add(new ReportParameter("locLevel", locLevel.ToString()));
            parameters.Add(new ReportParameter("FROMDT", Fromdt.ToString()));
            parameters.Add(new ReportParameter("TODT", Todt.ToString()));
            parameters.Add(new ReportParameter("dttype", RPTType.ToString()));
            parameters.Add(new ReportParameter("EmpName", EmpCode.ToString()));
            parameters.Add(new ReportParameter("ReportType", ReportType.ToString()));
            parameters.Add(new ReportParameter("ReportID", ReportCode.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/ReportCounterSummary_ver1";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
