using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
using System;

public partial class GUI_UNI_Net_MIS_MIS_THC_Advance_Payement_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strRO = Request.QueryString["RO"].ToString();
            string strLO = Request.QueryString["LO"].ToString();
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string thcNo = Request.QueryString["thcNo"].ToString();
            string dataSelection = Request.QueryString["dataSelection"].ToString();
           
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("thcNo", thcNo.ToString()));
            parameters.Add(new ReportParameter("dataSelection", dataSelection.ToString()));
            parameters.Add(new ReportParameter("RO", strRO));
            parameters.Add(new ReportParameter("LO", strLO));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/THC_AdvancePayement";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}