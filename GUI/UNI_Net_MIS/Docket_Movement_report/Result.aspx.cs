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

public partial class GUI_Operations_Enroute_Status_Update_Vehicle_Movement_Report_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string FromDT = Request.QueryString["FromDT"].ToString();
            string ToDT = Request.QueryString["ToDT"].ToString();
            string Type = Request.QueryString["Type"].ToString();
            string PartyCode = Request.QueryString["PartyCode"].ToString();
            string PartyName = Request.QueryString["PartyName"].ToString();
            string DocumentNo = Request.QueryString["DocumentNo"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDT", FromDT.ToString()));
            parameters.Add(new ReportParameter("ToDT", ToDT.ToString()));
            parameters.Add(new ReportParameter("Type", Type.ToString()));
            parameters.Add(new ReportParameter("PartyCode", PartyCode.ToString()));
            parameters.Add(new ReportParameter("PartyName", PartyName.ToString()));
            parameters.Add(new ReportParameter("DocumentNo", DocumentNo.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            
	
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Docket_Movement_Report";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 26/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
