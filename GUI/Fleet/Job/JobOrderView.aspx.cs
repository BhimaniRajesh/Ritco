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
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TripSheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string logo = Session["logofile"].ToString();
            string strImageUrl= "~/GUI/images/"  + logo;


            ReportParameter[] parameters = new ReportParameter[3];

            parameters[0] = new ReportParameter("OrderNo", Request.QueryString["ONo"].ToString());
            parameters[1] = new ReportParameter("Company_Code", SessionUtilities.DefaultCompanyCode.ToString());
            //parameters[1] = new ReportParameter("COMPANY_CODE", "JITEN_COM");
            parameters[2] = new ReportParameter("ConnString", Convert.ToString(Session["SqlProvider"]));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            //ReportViewer1.ServerReport.ReportPath = "/Report Project1/JobSheetView";

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "JobSheetView"; 

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
