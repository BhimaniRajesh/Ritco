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
using ApplicationManager;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_MountDismount_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);
            ReportParameter[] parameters = new ReportParameter[4];
            parameters[0] = new ReportParameter("FromDt", Request.QueryString["FromDt"].ToString());
            parameters[1] = new ReportParameter("ToDt", Request.QueryString["ToDt"].ToString());
            parameters[2] = new ReportParameter("MODE", Request.QueryString["MODE"].ToString());
            parameters[3] = new ReportParameter("ConnString", strConnStr);




            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "MountDismount";

            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvDocuments.Style.Add("margin-bottom", "26px");
            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
