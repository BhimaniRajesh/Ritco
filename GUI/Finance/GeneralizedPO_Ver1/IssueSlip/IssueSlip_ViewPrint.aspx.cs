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

public partial class GUI_Finance_Fix_Asset_ViewPrint_PO_GenerationView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string IssueSlipNo = Request.QueryString["IssueSlipNo"].ToString();
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("IssueSlipNo", IssueSlipNo.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/IssueSlip_ViewPrint";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
