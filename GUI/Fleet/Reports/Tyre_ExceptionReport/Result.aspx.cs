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

public partial class GUI_Fleet_Reports_Tyre_ExceptionReport_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "ExceptionTyreRegister_NEW";
            ReportViewer1.Style.Add("margin-bottom", "26px");

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Vehno", Request.QueryString["Vehno"].ToString()));
            parameters.Add(new ReportParameter("FromDT", Request.QueryString["FromDT"].ToString()));
            parameters.Add(new ReportParameter("ToDT", Request.QueryString["ToDT"].ToString()));
            parameters.Add(new ReportParameter("RO", Request.QueryString["RO"].ToString()));
            parameters.Add(new ReportParameter("LO", Request.QueryString["LO"].ToString()));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
        }
    }
}