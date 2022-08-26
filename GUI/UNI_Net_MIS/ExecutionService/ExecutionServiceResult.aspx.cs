using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_ExecutionService_ExecutionServiceResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ExecutionDate="",FromDate="",ToDate="";
            if (Request.QueryString["FromDate"] != "" && Request.QueryString["ToDate"] != "")
            {
                FromDate = Request.QueryString["FromDate"];
                ToDate = Request.QueryString["ToDate"];
            }
            string IndentNo = Request.QueryString["IndentNo"];
            if (Request.QueryString["ExecutionDate"] != "")
            {
                ExecutionDate = Request.QueryString["ExecutionDate"];
            }
	   if (Request.QueryString["ExecutionDate"] == "")
            {
                ExecutionDate = "01 JAN 1950";
            }


            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FromDate", FromDate));
            parameters.Add(new ReportParameter("ToDate", ToDate));
            parameters.Add(new ReportParameter("IndentNo", IndentNo));
            parameters.Add(new ReportParameter("ExecutionDate", ExecutionDate));

            rvExecutionServiceReport.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvExecutionServiceReport.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvExecutionServiceReport.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvExecutionServiceReport.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/ExecutionServiceReport";
            rvExecutionServiceReport.ServerReport.SetParameters(parameters);
        }
    }
}