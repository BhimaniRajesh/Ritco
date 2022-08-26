using System;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_JobOrderTrackerReport_JobOrderTrackerView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string JONo = Request.QueryString["JONo"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("JobOrderNo", JONo.ToString()));

            RPVJobOrderTracker.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            RPVJobOrderTracker.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            RPVJobOrderTracker.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            RPVJobOrderTracker.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "JobSheetTracker1";

            RPVJobOrderTracker.ServerReport.SetParameters(parameters);
        }
    }
}