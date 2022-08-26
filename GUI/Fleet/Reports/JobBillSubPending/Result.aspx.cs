using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data;

public partial class GUI_Fleet_Reports_JobBillSubPending_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string Region = Request.QueryString["region"].ToString();
        string Loc = Request.QueryString["location"].ToString();
        string fromdate = Request.QueryString["fromdate"].ToString();
        string todate = Request.QueryString["todate"].ToString();
        //string cust = Request.QueryString["cust"].ToString();

        string TO_DT = WebXConvert.ToDateTime(todate, "en-GB").ToString("dd MMM yyyy");
        string FRM_DT = WebXConvert.ToDateTime(fromdate, "en-GB").ToString("dd MMM yyyy");
        
        List<ReportParameter> parameters = new List<ReportParameter>();

        parameters.Add(new ReportParameter("RO", Region.ToString()));
        parameters.Add(new ReportParameter("LO", Loc.ToString()));
        parameters.Add(new ReportParameter("From_dt", FRM_DT.ToString()));
        parameters.Add(new ReportParameter("To_dt", TO_DT.ToString()));
       // parameters.Add(new ReportParameter("Route", cust.ToString()));
        

        //string ReportServer = System.Configuration.ConfigurationManager.AppSettings["ReportServer"].ToString().Trim();
        //string ReportServerURL = System.Configuration.ConfigurationManager.AppSettings["ReportServerURL"].ToString().Trim();
        //string ReportServerUser = System.Configuration.ConfigurationManager.AppSettings["ReportServerUser"].ToString().Trim();
        //string ReportServerPass = System.Configuration.ConfigurationManager.AppSettings["ReportServerPass"].ToString().Trim();
        //string ReportPathPrefix = System.Configuration.ConfigurationManager.AppSettings["ReportPathPrefix"].ToString().Trim();


        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "JobBillSubPending";
        ReportViewer1.ServerReport.SetParameters(parameters);
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
   
    }


}