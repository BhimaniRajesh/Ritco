using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class GUI_Fleet_Reports_Driver_Register_Result : System.Web.UI.Page
{
    SqlConnection conn;
    string strRTO = "";
    string strVEH_NO = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string strConnStr = Convert.ToString(Session["SqlProvider"]);

        ReportViewer1.Visible = true;

        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DriverRegister";
        ReportParameter[] parameters = new ReportParameter[5];
        parameters[0] = new ReportParameter("LIC_EXP_DT_From", txtDateFrom.Text.ToString().Trim());
        parameters[1] = new ReportParameter("LIC_EXP_DT_To", txtDateTo.Text.ToString().Trim());
        parameters[2] = new ReportParameter("RTO", txtRTO.Text.ToString().Trim());
        parameters[3] = new ReportParameter("VEH_NO", txtVehicle.Text.ToString().Trim());
        //parameters[4] = new ReportParameter("DRIVER_NAME", txtDriverName.Text);
        //parameters[5] = new ReportParameter("DRIVER_SURNAME", txtDriverSurName.Text);
        parameters[4] = new ReportParameter("ConnString", strConnStr);
        //parameters[6] = new ReportParameter("ConnString", "Data Source=.;Initial Catalog=TMS;UID=sa;pwd=Ecfy%_ptn");

        ReportViewer1.ServerReport.SetParameters(parameters);
        ReportViewer1.ServerReport.Refresh();
        UpdatePanel1.Update();

    }
}
