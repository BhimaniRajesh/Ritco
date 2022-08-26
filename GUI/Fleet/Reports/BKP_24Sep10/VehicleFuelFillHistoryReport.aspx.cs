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

public partial class GUI_Fleet_Reports_VehicleFuelFillHistoryReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleFuelFillHistroy";
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("TYPE_NAME", Cls_Report_VehFuelFillHistory.strTYPE_NAME));
            parameters.Add(new ReportParameter("VEHNO", Cls_Report_VehFuelFillHistory.strVEHNO));
            parameters.Add(new ReportParameter("FROMDT", Cls_Report_VehFuelFillHistory.strFROMDT));
            parameters.Add(new ReportParameter("TODT", Cls_Report_VehFuelFillHistory.strTODT));
            parameters.Add(new ReportParameter("Company_Code", Cls_Report_VehFuelFillHistory.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    }
}
