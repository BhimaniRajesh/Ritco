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
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_VehicleTracking_VehicleTrackingView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string strConnStr = "Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt";
            string strConnStr = Session["SqlProvider"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("VehicleNo", Convert.ToString(Request.QueryString["VehicleNo"])));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleTracking";

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
