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
public partial class GUI_UNI_Net_MIS_PODReports_resultRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
	    
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string CustomerCode = Request.QueryString["CustomerCode"].ToString();
            string Origin = Request.QueryString["Orgin"].ToString();
            string Destination = Request.QueryString["Destination"].ToString();
            string Aging = Request.QueryString["Aging"].ToString();
            string RO = Request.QueryString["RO"].ToString();
            string LO = Request.QueryString["LO"].ToString();
            string Status = Request.QueryString["Status"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDate", dtFrom.ToString()));
            parameters.Add(new ReportParameter("ToDate", dtTo.ToString()));
            parameters.Add(new ReportParameter("CustomerCode", CustomerCode.Trim()));
            parameters.Add(new ReportParameter("Origin", Origin.Trim()));
            parameters.Add(new ReportParameter("Destination", Destination.Trim()));
            parameters.Add(new ReportParameter("Aging", Aging.Trim()));
            parameters.Add(new ReportParameter("RO", RO.Trim()));
            parameters.Add(new ReportParameter("LO", LO.Trim()));
            parameters.Add(new ReportParameter("Status", Status.Trim()));
            parameters.Add(new ReportParameter("StatusType", LO.Trim()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
          
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DocketPodDetailVer1";
			ReportViewer1.ShowParameterPrompts = true;
          
            ReportViewer1.ServerReport.SetParameters(parameters);
			
			//ReportViewer1.Refresh();
			ReportViewer1.LocalReport.Refresh();
        }

        //added By Manisha 23/5/2014
        //DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
