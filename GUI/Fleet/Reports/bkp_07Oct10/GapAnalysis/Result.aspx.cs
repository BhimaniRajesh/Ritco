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
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_Net_MIS_Trip_Profitablility_Report_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr =  Convert.ToString(Session["SqlProvider"]);

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FROM_DT", cls_Report_TripGapAnalysis.strFROM_DT));
            parameters.Add(new ReportParameter("TO_DT", cls_Report_TripGapAnalysis.strTO_DT));
            parameters.Add(new ReportParameter("VEH_NO", cls_Report_TripGapAnalysis.strVEH_NO));
            parameters.Add(new ReportParameter("Company_Code", cls_Report_TripGapAnalysis.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TripGapAnalysis"; 
            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;   
            rvDocuments.Style.Add("margin-bottom", "26px");

            rvDocuments.ServerReport.SetParameters(parameters);
           
        }
    }
}
