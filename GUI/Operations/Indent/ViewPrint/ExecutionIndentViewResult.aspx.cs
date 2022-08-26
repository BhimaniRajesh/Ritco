using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_Indent_ViewPrint_ExecutionIndentViewResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("IndentNumber", Request.QueryString["IndentNo"].ToString()));
            parameters.Add(new ReportParameter("FromDate", Request.QueryString["FromDate"].ToString()));
            parameters.Add(new ReportParameter("ToDate", Request.QueryString["ToDate"].ToString()));
            parameters.Add(new ReportParameter("IndentNo", Request.QueryString["IndentNo"].ToString()));
            parameters.Add(new ReportParameter("DocketNo", Request.QueryString["DocketNo"].ToString()));
            parameters.Add(new ReportParameter("DeliveryPartyName", Request.QueryString["DeliveryPartyName"].ToString()));
            parameters.Add(new ReportParameter("BillingPartyName", Request.QueryString["BillingPartyName"].ToString()));
            parameters.Add(new ReportParameter("Status", Request.QueryString["Status"].ToString()));
            

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/ExecutionIndentView";

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");
            if (userAgent.Contains("MSIE 7.0"))
            {
                ReportViewer1.Style.Add("margin-bottom", "26px");
            }

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}