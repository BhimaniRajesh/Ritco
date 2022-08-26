using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.UI.WebControls.WebParts;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_DriverRegisterResult : System.Web.UI.Page
{
    //SqlConnection conn;
    //string strRTO = "";
    //string strVEH_NO = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DriverRegister";


            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("LIC_EXP_DT_From", cls_Report_DriverRegister.strLIC_EXP_DT_From));

            parameters.Add(new ReportParameter("LIC_EXP_DT_To", cls_Report_DriverRegister.strLIC_EXP_DT_To));
            parameters.Add(new ReportParameter("RTO", cls_Report_DriverRegister.strRTO));
            parameters.Add(new ReportParameter("VEH_NO", cls_Report_DriverRegister.strVEH_NO));
            parameters.Add(new ReportParameter("DRIVER_NAME", cls_Report_DriverRegister.strDRIVER_NAME));
            parameters.Add(new ReportParameter("DRIVER_STATUS", cls_Report_DriverRegister.strddlStatus));
            parameters[4] = new ReportParameter("ConnString", strConnStr);
            //parameters[6] = new ReportParameter("ConnString", "Data Source=.;Initial Catalog=TMS;UID=sa;pwd=Ecfy%_ptn");

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    }
}
