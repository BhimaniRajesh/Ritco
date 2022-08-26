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
using System.Reflection;
using Microsoft.Reporting.WebForms;

public partial class GUI_View_Track_Operation_THC_TAB_Tracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AddView();
        
    }

 
    private void AddView()
    {
        string THCNO = Request.QueryString["THCNO"].ToString();
       
        string ID = Request.QueryString["ID"].ToString();

        List<ReportParameter> parameters = new List<ReportParameter>();
        //parameters.Add(new ReportParameter("RPTTB", "DKT"));
        parameters.Add(new ReportParameter("THCNO", THCNO.ToString()));

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;



        if (ID == "1")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Tracking_THC_Summary";
        else if (ID == "2")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Movement_TAB_THC";
        else
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Tracking_THC_Summary";


        ReportViewer1.ServerReport.SetParameters(parameters);
    }
}
