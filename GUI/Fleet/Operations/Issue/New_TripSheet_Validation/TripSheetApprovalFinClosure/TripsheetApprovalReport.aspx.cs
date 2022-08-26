using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripSheetApprovalFinClosure_TripsheetApprovalReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string VehicleNo = Request.QueryString["VehicleNo"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
                        
            parameters.Add(new ReportParameter("VehicleNo", VehicleNo.Trim()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/TripsheetApproval_Report";
            ReportViewer1.ServerReport.SetParameters(parameters);

        }

    }
}