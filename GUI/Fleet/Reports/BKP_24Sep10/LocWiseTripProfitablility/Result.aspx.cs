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
        string strConnStr = Convert.ToString(Session["SqlProvider"]);

         if (!IsPostBack && !IsCallback)
        {
            string TripSheetNo = Request.QueryString["TSNo"];
            string VehicleNo = Request.QueryString["VHNo"];
            string FromDate = Request.QueryString["FDT"];
            string ToDate = Request.QueryString["TDT"];
            string ProfStatus = Request.QueryString["PSTS"];
            string MarginFrom = Request.QueryString["MRF"];
            string MarginTo = Request.QueryString["MRT"];
            string TripStartLoc = Request.QueryString["LO"];
            string RO = Request.QueryString["RO"];
            string TripStartLocList = Request.QueryString["LO_List"];
            string Company_Code = Request.QueryString["Company_Code"];

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("TripStartLoc",TripStartLoc));
            parameters.Add(new ReportParameter("RO", RO));
            parameters.Add(new ReportParameter("TripSheetNo", TripSheetNo));
            parameters.Add(new ReportParameter("VehicleNo", VehicleNo));
            parameters.Add(new ReportParameter("FromDate", FromDate));
            parameters.Add(new ReportParameter("ToDate", ToDate));            
            parameters.Add(new ReportParameter("MarginFrom", MarginFrom));
            parameters.Add(new ReportParameter("MarginTo", MarginTo));
            parameters.Add(new ReportParameter("ProfStatus", ProfStatus));
            parameters.Add(new ReportParameter("TripStartLocList", TripStartLocList));
            parameters.Add(new ReportParameter("Company_Code", Company_Code));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "LocWiseTripProfitability";
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;   
            rvDocuments.Style.Add("margin-bottom", "26px");
            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
