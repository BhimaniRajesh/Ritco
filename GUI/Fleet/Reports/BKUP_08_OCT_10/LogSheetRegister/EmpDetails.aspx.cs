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
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_LogSheetRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("TripsheetNo", Convert.ToString(Request.QueryString["TripsheetNo"])));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "LogsheetEmpDet";

            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvDocuments.Style.Add("margin-bottom", "26px");

            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
