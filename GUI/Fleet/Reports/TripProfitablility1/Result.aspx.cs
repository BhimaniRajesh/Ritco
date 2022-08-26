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
         if (!IsPostBack )
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);


            rvDocuments.Visible = true;

            //string TripSheetNo = Request.QueryString["TSNo"];
            //string VehicleNo = Request.QueryString["VHNo"];
            //string FromDate = Request.QueryString["FDT"];
            //string ToDate = Request.QueryString["TDT"];
            //string ProfStatus = Request.QueryString["PSTS"];
            //string MarginFrom = Request.QueryString["MRF"];
            //string MarginTo = Request.QueryString["MRT"];
            

            //List<ReportParameter> parameters = new List<ReportParameter>();
            //parameters.Add(new ReportParameter("TripSheetNo", TripSheetNo));
            //parameters.Add(new ReportParameter("VehicleNo", VehicleNo));
            //parameters.Add(new ReportParameter("FromDate", FromDate));
            //parameters.Add(new ReportParameter("ToDate", ToDate));
            //parameters.Add(new ReportParameter("ProfStatus", ProfStatus));
            //parameters.Add(new ReportParameter("MarginFrom", MarginFrom));
            //parameters.Add(new ReportParameter("MarginTo", MarginTo));
            //parameters.Add(new ReportParameter("ConnString", Convert.ToString(Session["SqlProvider"])));


            ReportParameter[] parameters = new ReportParameter[9];
            parameters[0] = new ReportParameter("FromDate", Request.QueryString["FromDate"].ToString());
            parameters[1] = new ReportParameter("ToDate", Request.QueryString["ToDate"].ToString());
            parameters[2] = new ReportParameter("ProfStatus", Request.QueryString["ProfStatus"].ToString());
            parameters[3] = new ReportParameter("MarginFrom", Request.QueryString["MarginFrom"].ToString());
            parameters[4] = new ReportParameter("MarginTo", Request.QueryString["MarginTo"].ToString());
            parameters[5] = new ReportParameter("TripSheetNo", Request.QueryString["TripSheetNo"].ToString());
            parameters[6] = new ReportParameter("VehicleNo", Request.QueryString["VehicleNo"].ToString());
            parameters[7] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[8] = new ReportParameter("ConnString", strConnStr);  




            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TripProfitabilityReport";

            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;   
            rvDocuments.Style.Add("margin-bottom", "26px");
            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
