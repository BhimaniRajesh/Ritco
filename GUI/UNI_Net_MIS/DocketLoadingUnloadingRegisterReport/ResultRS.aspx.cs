using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;

public partial class GUI_UNI_Net_MIS_DocketLoadingUnloadingRegisterReport_ResultRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string RO = Request.QueryString["RO"].ToString();
			string LO = Request.QueryString["LO"].ToString();
            string Status = Request.QueryString["Status"].ToString();
			string DocketNo = Request.QueryString["DocketNo"].ToString();
           
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FromDate", fromdt.ToString()));
            parameters.Add(new ReportParameter("ToDate", todt.ToString()));
            parameters.Add(new ReportParameter("RO", RO.ToString()));
			parameters.Add(new ReportParameter("LO", LO.ToString()));
            parameters.Add(new ReportParameter("Status", Status.ToString()));
			parameters.Add(new ReportParameter("DocketNo", DocketNo.ToString()));
           
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DocketReportingUnloading_Register";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }        
    }
}
