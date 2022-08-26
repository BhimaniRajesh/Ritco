using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System.Reflection;

public partial class _Default : System.Web.UI.Page 
{
    string str_Connection_String = ConfigurationManager.AppSettings["ConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string strdriver1 = Request.QueryString["driver1"];
            string strstart_dt = Request.QueryString["start_dt"];
            string strEnd_dt = Request.QueryString["End_dt"];

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Driver1", strdriver1));
            parameters.Add(new ReportParameter("start_dt", strstart_dt));
            parameters.Add(new ReportParameter("End_dt", strEnd_dt));
            parameters.Add(new ReportParameter("ConnStr", str_Connection_String));

            VExp.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            VExp.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            VExp.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            VExp.Style.Add("margin-bottom", "26px");
            VExp.ServerReport.SetParameters(parameters);

            //DisableUnwantedExportFormats();

            VExp.ServerReport.Refresh();
        }




    }
}
