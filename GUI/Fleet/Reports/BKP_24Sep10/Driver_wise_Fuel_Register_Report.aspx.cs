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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class Driver_wise_Fuel_Register_Report : System.Web.UI.Page
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

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";


            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DriverwiseFuelRegisterReport";
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("start_dt", Cls_Driver_Wise_Fuel_Register.strstart_dt));

            parameters.Add(new ReportParameter("End_dt", Cls_Driver_Wise_Fuel_Register.strEnd_dt));
            parameters.Add(new ReportParameter("driver1", Cls_Driver_Wise_Fuel_Register.strDriver1));
            parameters.Add(new ReportParameter("Company_Code", Cls_Driver_Wise_Fuel_Register.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();

        }
    }
   
}
