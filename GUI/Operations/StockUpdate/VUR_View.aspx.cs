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
using System.Reflection;
using Microsoft.Reporting.WebForms;
public partial class GUI_Operations_StockUpdate_VUR_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string VURNO = Request.QueryString["VURNO"].ToString();

        List<ReportParameter> parameters = new List<ReportParameter>();
        parameters.Add(new ReportParameter("VURNO", VURNO.ToString()));

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = "/Reports/TUR_VIEW";
        ReportViewer1.ServerReport.SetParameters(parameters);    
    }
}
