using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TyreInterchangeReport_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {           
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TyreInterchangeReport";

            ReportViewer1.Style.Add("margin-bottom", "26px");

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FROMDATE", Request.QueryString["FromDate"].ToString()));
            parameters.Add(new ReportParameter("TODATE", Request.QueryString["ToDate"].ToString()));

            if (Request.QueryString["TyreNo"].ToString() != "")
            {
                parameters.Add(new ReportParameter("TYRE", Request.QueryString["TyreNo"].ToString()));
            }
          
            parameters.Add(new ReportParameter("RO", Request.QueryString["RO"].ToString()));
            parameters.Add(new ReportParameter("LO", Request.QueryString["LO"].ToString()));           
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();

        }
    }
}