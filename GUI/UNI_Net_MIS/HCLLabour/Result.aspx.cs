using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_HCLLabour_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var Fromdt = Convert.ToString(Request.QueryString["Fromdt"]);
            var Todt = Convert.ToString(Request.QueryString["Todt"]);
            var BillNo = Convert.ToString(Request.QueryString["BillNo"]);
            var Status = Convert.ToString(Request.QueryString["Status"]);

           
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Fromdt", Fromdt));
            parameters.Add(new ReportParameter("Todt", Todt));
            parameters.Add(new ReportParameter("BillNo", BillNo));
            parameters.Add(new ReportParameter("Status", Status));


            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/HCLLabour";
           
            ReportViewer1.Style.Add("margin-bottom", "26");

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}