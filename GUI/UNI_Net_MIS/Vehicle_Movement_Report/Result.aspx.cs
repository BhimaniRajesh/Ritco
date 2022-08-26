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
            string VendorCode = Request.QueryString["VendorCode"].ToString();
            string VendorName = Request.QueryString["VendorName"].ToString();
            string VehicleLocation = Request.QueryString["VehicleLocation"].ToString();
            string VehicleNo = Request.QueryString["VehicleNo"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDT", FromDT.ToString()));
            parameters.Add(new ReportParameter("ToDT", ToDT.ToString()));
            parameters.Add(new ReportParameter("VendorCode", VendorCode.ToString()));
            parameters.Add(new ReportParameter("VendorName", VendorName.ToString()));
            parameters.Add(new ReportParameter("VehicleLocation", VehicleLocation.ToString()));
            parameters.Add(new ReportParameter("VehicleNo", VehicleNo.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Vehicle_Movement_Report";
          
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 26/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }
}
