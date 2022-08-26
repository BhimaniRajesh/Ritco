using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Reflection;
using Microsoft.Reporting.WebForms;
using System.Net;
using System.IO;

public partial class GUI_Operations_FM_NewPODModules_PODHandover_ViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

           string strPDHNo = Request.QueryString["PDHNo"].ToString();
            List<ReportParameter> parameters = new List<ReportParameter>();

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            parameters.Add(new ReportParameter("PDHNo", strPDHNo.ToString()));
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/PODHandoverDocument_ViewPrint";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}