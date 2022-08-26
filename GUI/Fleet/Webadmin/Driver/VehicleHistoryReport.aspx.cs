using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;

public partial class GUI_Fleet_Webadmin_Driver_VehicleHistoryReport : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("VehNo", Request.QueryString["VehicleNo"].ToString()));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DriverMasterHistoryReport";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}