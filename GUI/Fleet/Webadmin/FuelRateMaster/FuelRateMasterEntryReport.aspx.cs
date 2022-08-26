using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Webadmin_FuelRateMaster_FuelRateMasterEntryReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            ReportViewer1.Visible = true;
            string strConnStr = Convert.ToString(Session["SqlProvider"]);
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "FuelRateMasterEntry";
            ReportParameter[] parameters = new ReportParameter[1];
            parameters[0] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
        }
    }
}
