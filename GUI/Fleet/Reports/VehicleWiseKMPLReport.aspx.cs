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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using ApplicationManager;

public partial class GUI_Fleet_Reports_VehicleWiseKMPLReport : System.Web.UI.Page
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

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleWiseKMPL";
            ReportParameter[] parameters = new ReportParameter[5];
            parameters[0] = new ReportParameter("VEHNO", Request.QueryString["VEHNO"].ToString());
            parameters[1] = new ReportParameter("VSLIP_FROMDT", Request.QueryString["VSLIP_FROMDT"].ToString());
            parameters[2] = new ReportParameter("VSLIP_TODT", Request.QueryString["VSLIP_TODT"].ToString());
            parameters[3] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[4] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //SUpdatePanel1.Update();
        }

        //added By Manisha 21/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
