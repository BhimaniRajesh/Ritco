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

public partial class GUI_Fleet_Reports_Vehical_Expnse_Summary_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.Visible = true;

        string strConnStr = Convert.ToString(Session["SqlProvider"]);

        //string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

        //if (userAgent.Contains("MSIE 7.0"))
        //{
        //    // ReportViewer1.Style.Add("margin-bottom", "26px");
        //    ReportViewer1.Attributes.Add("style", "overflow:auto;");
        //}


        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "Vehicle_Expense_Summary";
        ReportParameter[] parameters = new ReportParameter[7];
        parameters[0] = new ReportParameter("Start_dt", Request.QueryString["Start_dt"].ToString());
        parameters[1] = new ReportParameter("End_dt", Request.QueryString["End_dt"].ToString());
        parameters[2] = new ReportParameter("loccode", Request.QueryString["loccode"].ToString());
        parameters[3] = new ReportParameter("Type_Code", Request.QueryString["Type_Code"].ToString());
        parameters[4] = new ReportParameter("VehicleNo", Request.QueryString["VehicleNo"].ToString());
        parameters[5] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
        parameters[6] = new ReportParameter("ConnString", strConnStr);

        ReportViewer1.ServerReport.SetParameters(parameters);
        ReportViewer1.ServerReport.Refresh();
        //UpdatePanel1.Update();


    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Vehical_Expnse_Summary.aspx");
    }
}
