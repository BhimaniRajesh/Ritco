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

public partial class GUI_UNI_Net_MIS_MarketVehicle_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string DDMRNo = Request.QueryString["DDMRCode"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("DDMRNo", DDMRNo.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DDMR_Customer_Wise_View";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
