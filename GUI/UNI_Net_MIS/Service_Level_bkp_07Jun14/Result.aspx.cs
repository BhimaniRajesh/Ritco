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
using System.Data.SqlClient;

public partial class GUI_UNI_Net_MIS_Voucher_register_Query : System.Web.UI.Page
{
    public static string dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
 		if (!IsPostBack)
        {

            string location = Request.QueryString["location"];
            string locLevel = Request.QueryString["locLevel"];
            string Tolocation = Request.QueryString["Tolocation"];
            string Tolevel = Request.QueryString["Tolevel"];
            string fromdt = Request.QueryString["fromdt"];
            string todt = Request.QueryString["todt"];

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", location.ToString()));
            parameters.Add(new ReportParameter("locLevel", locLevel.ToString()));
            parameters.Add(new ReportParameter("Tolocation", Tolocation.ToString()));
            parameters.Add(new ReportParameter("TolocLevel", Tolevel.ToString()));
            parameters.Add(new ReportParameter("fromdt", fromdt.ToString()));
            parameters.Add(new ReportParameter("todt", todt.ToString()));
           
           
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Service_Level";
            ReportViewer1.ServerReport.SetParameters(parameters);
    }
        //added By Manisha 26/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }


}
