using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;

public partial class GUI_UNI_Net_MIS_THCTransshipmentRegisterReport_ResultRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string LocationLevel = Request.QueryString["LocationLevel"].ToString();
			string LocationCode = Request.QueryString["LocationCode"].ToString();
            string Status = Request.QueryString["Status"].ToString();
            string ThcNo = Request.QueryString["ThcNo"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FromDate", fromdt.ToString()));
            parameters.Add(new ReportParameter("ToDate", todt.ToString()));
            parameters.Add(new ReportParameter("LocatinLevel", LocationLevel.ToString()));
			parameters.Add(new ReportParameter("LocatinCode", LocationCode.ToString()));
            parameters.Add(new ReportParameter("Status", Status.ToString()));
            parameters.Add(new ReportParameter("ThcNo", ThcNo.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/THCTransshipmentRegister";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }        
    }
}
