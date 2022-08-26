using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System;


public partial class GUI_Fleet_Reports_GapAnalysis_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["sqlProvider"]);

            ReportViewer1.Visible = true;
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TripGapAnalysis";

            ReportParameter[] parameters = new ReportParameter[5];
            parameters[0] = new ReportParameter("FROM_DT", Request.QueryString["FROM_DT"].ToString());
            parameters[1] = new ReportParameter("TO_DT", Request.QueryString["TO_DT"].ToString());
            parameters[2] = new ReportParameter("VEH_NO", Request.QueryString["VEH_NO"].ToString());
            parameters[3] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());

            parameters[4] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());

          
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
        //added By Manisha 20/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
