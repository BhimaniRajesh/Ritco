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

public partial class GUI_UNI_Net_MIS_Trip_Profitablility_Report_Result_Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string VHModel = Request.QueryString["VHModel"];
            string FromDT = Request.QueryString["FDT"];
            string ToDT = Request.QueryString["TDT"];
            string ProfStatus = Request.QueryString["PSTS"];
            string MarginFrom = Request.QueryString["MRF"];
            string MarginTo = Request.QueryString["MRT"];
            

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("VHModel", VHModel));
            parameters.Add(new ReportParameter("FromDT", FromDT));
            parameters.Add(new ReportParameter("ToDT", ToDT));
            parameters.Add(new ReportParameter("ProfStatus", ProfStatus));
            parameters.Add(new ReportParameter("MarginFrom", MarginFrom));
            parameters.Add(new ReportParameter("MarginTo", MarginTo));
            parameters.Add(new ReportParameter("ConnString", Convert.ToString(Session["SqlProvider"])));

              
            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "OwnVehicleProfitability_New";

            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvDocuments.Style.Add("margin-bottom", "26px");
            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
