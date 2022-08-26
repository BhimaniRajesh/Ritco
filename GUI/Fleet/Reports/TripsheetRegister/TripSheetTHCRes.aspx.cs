using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_TripSheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();

            //for search criteria
             parameters.Add(new ReportParameter("Company_Code", cls_Report_TripSheet.strCompany.ToString().Trim()));
            parameters.Add(new ReportParameter("CreatedFrom", cls_Report_TripSheet.strDateFrom.ToString().Trim()));
            parameters.Add(new ReportParameter("CreatedTo", cls_Report_TripSheet.strDateTo.ToString().Trim()));
            parameters.Add(new ReportParameter("Status", cls_Report_TripSheet.strStatus.ToString().Trim()));
            parameters.Add(new ReportParameter("Branch", cls_Report_TripSheet.strBranch.ToString().Trim()));
            parameters.Add(new ReportParameter("Manual", cls_Report_TripSheet.strManual.ToString().Trim()));
            parameters.Add(new ReportParameter("Tripsheet", cls_Report_TripSheet.strTripsheet.ToString().Trim()));
            parameters.Add(new ReportParameter("VehicleNo", cls_Report_TripSheet.strVehicleNo.ToString().Trim()));
            parameters.Add(new ReportParameter("Driver", cls_Report_TripSheet.strDriver.ToString().Trim()));
           
            parameters.Add(new ReportParameter("ConnString", Convert.ToString(Session["SqlProvider"])));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TripsheetTHCDetails";
            
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("TripsheetQuery.aspx");
    }
}
