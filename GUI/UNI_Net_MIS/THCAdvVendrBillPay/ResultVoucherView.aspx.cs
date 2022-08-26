using System;
using System.Data;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_Net_MIS_THCAdvVendrBillPay_ResultVoucherView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("DocumentNo", Request.QueryString["DocumentNo"]));
            parameters.Add(new ReportParameter("VoucherNo", Request.QueryString["VoucherNo"]));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/THCAdvVdrBillPayDtVoucher_Rt";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}