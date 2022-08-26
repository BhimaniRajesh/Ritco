using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TyreTrackReport_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ActTyreNo = Request.QueryString["ActTyreNo"].ToString();
            string ManTyreNo = Request.QueryString["ManTyreNo"].ToString();

         

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TyreTrackRegister";
            ReportViewer1.Style.Add("margin-bottom", "26px");

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("ActTyreNo", ActTyreNo.ToString()));
            parameters.Add(new ReportParameter("ManTyreNo", ManTyreNo.ToString()));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
        }
    }
}