using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.UI.WebControls.WebParts;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_DriverRegisterResult : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DriverRegister";


            ReportParameter[] parameters = new ReportParameter[6];
            parameters[0] = new ReportParameter("LIC_EXP_DT_From", Request.QueryString["LIC_EXP_DT_From"].ToString());
            parameters[1] = new ReportParameter("LIC_EXP_DT_To", Request.QueryString["LIC_EXP_DT_To"].ToString());
            parameters[2] = new ReportParameter("VEH_NO", Request.QueryString["VEH_NO"].ToString());
            parameters[3] = new ReportParameter("DRIVER_NAME", Request.QueryString["DRIVER_NAME"].ToString());
            parameters[4] = new ReportParameter("DRIVER_STATUS", Request.QueryString["DRIVER_STATUS"].ToString());

            parameters[5] = new ReportParameter("ConnString", strConnStr);
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
       
        //added By Manisha 20/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }
}
