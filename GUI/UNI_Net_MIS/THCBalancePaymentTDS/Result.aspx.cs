using System;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_Net_MIS_THCBalancePaymentTDS_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            string Cumlative = Request.QueryString["Cumlative"].ToString();
            string Brcd = Request.QueryString["Brcd"].ToString();
            string dateFrom = Request.QueryString["dateFrom"].ToString();
            string dateTo = Request.QueryString["dateTo"].ToString();
            string RPT = Request.QueryString["RPT"].ToString();


            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("from_date", dateFrom.ToString()));
            parameters.Add(new ReportParameter("to_date", dateTo.ToString()));
            parameters.Add(new ReportParameter("Cumilative", Cumlative.ToString()));
            parameters.Add(new ReportParameter("brcd", Brcd.ToString()));
            parameters.Add(new ReportParameter("RPT", RPT.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/THCBalancePaymentTDSReport";
            ReportViewer1.ServerReport.SetParameters(parameters);

        }

    }
}
