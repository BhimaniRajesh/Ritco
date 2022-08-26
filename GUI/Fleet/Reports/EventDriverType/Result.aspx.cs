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
using System.Data.SqlClient;

public partial class GUI_Fleet_Reports_EventDriverType_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DriverEventType";
            ReportParameter[] parameters = new ReportParameter[5];
            parameters[0] = new ReportParameter("FromDt", Request.QueryString["FromDt"].ToString());
            parameters[1] = new ReportParameter("ToDt", Request.QueryString["ToDt"].ToString());
            parameters[2] = new ReportParameter("EventType", Request.QueryString["EventType"].ToString());
            parameters[3] = new ReportParameter("Driver", Request.QueryString["Driver"].ToString());
            parameters[4] = new ReportParameter("ConnString", strConnStr);


            ReportViewer1.ServerReport.SetParameters(parameters);

            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }

    }
}
