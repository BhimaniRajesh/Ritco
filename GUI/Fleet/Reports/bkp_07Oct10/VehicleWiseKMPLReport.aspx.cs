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

public partial class GUI_Fleet_Reports_VehicleWiseKMPLReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;


            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleWiseKMPL";
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("VEHNO", Cls_VehicleWiseKMPL.strVEHNO));
            parameters.Add(new ReportParameter("VSLIP_FROMDT", Cls_VehicleWiseKMPL.strVSLIP_FROMDT));
            parameters.Add(new ReportParameter("VSLIP_TODT", Cls_VehicleWiseKMPL.strVSLIP_TODT));
            parameters.Add(new ReportParameter("Company_Code", Cls_VehicleWiseKMPL.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //SUpdatePanel1.Update();
        }
    }
}
