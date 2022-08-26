using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data;

public partial class GUI_UNI_NET_MIS_Tripsheet_pending_milkrun_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strRegion = "", strLocation = "", strFromDate = "", strToDate = "";

        if (!IsPostBack && !IsCallback)
        {
            strRegion = Request.QueryString["RO"].ToString();
            strLocation = Request.QueryString["LO"].ToString();
            strFromDate = Request.QueryString["FromDate"].ToString();
            strToDate = Request.QueryString["ToDate"].ToString();
            //strFromDate = dateString(Request.QueryString["FromDate"].ToString());
            //strToDate = dateString(Request.QueryString["ToDate"].ToString());


            rvvehicle.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvvehicle.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;  // Report Server URL
            rvvehicle.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();

            rvvehicle.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Tripsheet_pend_milkrun_bill";
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("FROM_DT", strFromDate));
            parameters.Add(new ReportParameter("TO_DT", strToDate));
            parameters.Add(new ReportParameter("RO", strRegion));
            parameters.Add(new ReportParameter("LO", strLocation));


            rvvehicle.ServerReport.SetParameters(parameters);
            rvvehicle.ServerReport.Refresh();

            DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["RPTID"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
            TextBox txtReportName = (TextBox)LnkRPT1.FindControl("txtReportName");
            LnkRPT1.Report_NM = txtReportName.Text;
            LnkRPT1.Report_URL = ReportServiceUtilities.ReportPathPrefix + "/Tripsheet_pend_milkrun_bill";

        }
        LnkRPT1.ReportViewer = rvvehicle;
    }
}