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
public partial class GUI_UNI_Net_MIS_PODReports_ResultRS : System.Web.UI.Page
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
            string Type = Request.QueryString["Type"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDate", dtFrom.ToString()));
            parameters.Add(new ReportParameter("ToDate", dtTo.ToString()));
            parameters.Add(new ReportParameter("CustomerCode", CustomerCode.Trim()));
            parameters.Add(new ReportParameter("Origin", Origin.Trim()));
            parameters.Add(new ReportParameter("Destination", Destination.Trim()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            if (Type=="C")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/RamRam";
				  ReportViewer1.ShowParameterPrompts = true;
            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/RamRam";
				  ReportViewer1.ShowParameterPrompts = true;
            }
            ReportViewer1.ServerReport.SetParameters(parameters);
			
			//ReportViewer1.Refresh();
			ReportViewer1.LocalReport.Refresh();
        }

        //added By Manisha 23/5/2014
        //DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
