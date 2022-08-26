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

public partial class GUI_Fleet_Reports_VehicleLogRegisterReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicelLogRegister";


            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("TRIPSHEET_FROM_DT", Cls_Report_VehiclogRes.strTRIPSHEET_FROM_DT));
            parameters.Add(new ReportParameter("TRIPSHEET_TO_DT", Cls_Report_VehiclogRes.strTRIPSHEET_TO_DT));
            parameters.Add(new ReportParameter("VEH_NO", Cls_Report_VehiclogRes.strVEH_NO));
            parameters.Add(new ReportParameter("DRIVER_NAME", Cls_Report_VehiclogRes.strDRIVER_NAME));
            parameters.Add(new ReportParameter("KM_RUN_FROM", Cls_Report_VehiclogRes.strKM_RUN_FROM));
            parameters.Add(new ReportParameter("KM_RUN_TO", Cls_Report_VehiclogRes.strKM_RUN_TO));
            parameters.Add(new ReportParameter("KMPL_FROM", Cls_Report_VehiclogRes.strKMPL_FROM));
            parameters.Add(new ReportParameter("KMPL_TO", Cls_Report_VehiclogRes.strKMPL_TO));
            parameters.Add(new ReportParameter("Company_Code", Cls_Report_VehiclogRes.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    }
}
