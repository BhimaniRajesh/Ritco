using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_DriverLicenseExpiry_result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
           // string strConnStr = Session["SqlProvider"].ToString();

            ReportViewer1.Visible = true;

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "Driver_License_Expiry_PreAlert";
            ReportViewer1.Style.Add("margin-bottom", "26px");

            ReportParameter[] parameters = new ReportParameter[0];

        // parameters[0] = new ReportParameter("ConnString", strConnStr);
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();

            //UpdatePanel1.Update();
        }

    }
}

