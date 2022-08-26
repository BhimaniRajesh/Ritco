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
public partial class GUI_UNI_Net_MIS_BillingRegister_ResultRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
	    
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string CustomerCode = Request.QueryString["CustomerCode"].ToString();
            string BillNo = Request.QueryString["BillNo"].ToString();
            string DocketNo = Request.QueryString["DocketNo"].ToString();
            string RO = Request.QueryString["RO"].ToString();
            string LO = Request.QueryString["LO"].ToString();
            string paybase = Request.QueryString["st_paybasis"].ToString();
            string status = Request.QueryString["str_ststus"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDate", dtFrom.ToString()));
            parameters.Add(new ReportParameter("ToDate", dtTo.ToString()));
            parameters.Add(new ReportParameter("CustomerCode", CustomerCode.Trim()));
            parameters.Add(new ReportParameter("BillNo", BillNo.Trim()));
            parameters.Add(new ReportParameter("DocketNo", DocketNo.Trim()));
            parameters.Add(new ReportParameter("RO", RO.Trim()));
            parameters.Add(new ReportParameter("LO", LO.Trim()));
            parameters.Add(new ReportParameter("Status", paybase.Trim()));
            parameters.Add(new ReportParameter("PayBasType", status.Trim()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/BillingRegister";
            ReportViewer1.ServerReport.SetParameters(parameters);

        }

        //added By Manisha 23/5/2014
        //DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
