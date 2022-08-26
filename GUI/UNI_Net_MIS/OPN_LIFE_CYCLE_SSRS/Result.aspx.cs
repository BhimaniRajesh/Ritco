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
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
  
public partial class GUI_UNI_MIS_OPN_LIFE_CYCLE_Result : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string RO = Request.QueryString["RO"].ToString();
            string LO = Request.QueryString["LO"].ToString();
            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string st_columnlist = Request.QueryString["st_columnlist"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("Fromdt", fromdt.ToString()));
            parameters.Add(new ReportParameter("todt", todt.ToString()));
            parameters.Add(new ReportParameter("fromRo", RO.ToString()));
            parameters.Add(new ReportParameter("fromloc", LO.ToString()));
            parameters.Add(new ReportParameter("docklist", st_columnlist.ToString()));            

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/OPN_LIFE_CYCLE";
            //ReportViewer1.ServerReport.ReportPath = "/Reports/OPN_LIFE_CYCLE";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }

        //added By Manisha 23/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }
}
