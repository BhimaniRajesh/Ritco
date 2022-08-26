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
        if (!IsPostBack && !IsCallback)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
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

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "OwnVehicleProfitability_New";

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;   
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 21/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }
}
