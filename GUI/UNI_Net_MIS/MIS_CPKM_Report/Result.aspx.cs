using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_MIS_CPKM_Report_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string VendorCode = Request.QueryString["VendorCode"];
            string VoucherNo = Request.QueryString["VoucherNo"];
            string BillNo = Request.QueryString["BillNo"];
            string BillStatus = Request.QueryString["BillStatus"];
            string FromDate = Request.QueryString["FromDate"];
            string ToDate = Request.QueryString["ToDate"];

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("VendorCode", VendorCode));
            parameters.Add(new ReportParameter("VoucherNo", VoucherNo));
            parameters.Add(new ReportParameter("BillNo", BillNo));
            parameters.Add(new ReportParameter("BillStatus", BillStatus));
            parameters.Add(new ReportParameter("FromDate", FromDate));
            parameters.Add(new ReportParameter("ToDate", ToDate));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/MIS_CPKM_Report";
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}