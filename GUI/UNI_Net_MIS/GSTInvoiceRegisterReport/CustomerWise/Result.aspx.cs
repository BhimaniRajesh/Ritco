using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_NET_MIS_GSTInvoiceRegisterReport_CustomerWise_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FromDate", Request.QueryString["FromDate"].ToString()));
            parameters.Add(new ReportParameter("ToDate", Request.QueryString["ToDate"].ToString()));
            parameters.Add(new ReportParameter("State", Request.QueryString["State"].ToString()));
            parameters.Add(new ReportParameter("DocType", Request.QueryString["DocType"].ToString()));
            parameters.Add(new ReportParameter("PartyCode", Request.QueryString["PartyCode"].ToString()));
            parameters.Add(new ReportParameter("SACCode", Request.QueryString["SACCode"].ToString()));
            parameters.Add(new ReportParameter("DocumentNo", Request.QueryString["DocumentNo"].ToString()));
            parameters.Add(new ReportParameter("PartyType", "C"));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/GSTInvoiceRegisterReport_CustomerWise";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
     
    }
}