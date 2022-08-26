using System;
using System.Data;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_AdvanceTHCView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("thcno", Request.QueryString["thcno"]));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/THCAdvanceViewPrint";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }

}