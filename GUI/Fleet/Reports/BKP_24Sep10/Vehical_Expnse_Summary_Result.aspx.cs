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

public partial class GUI_Fleet_Reports_Vehical_Expnse_Summary_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Start_dt", cls_Vehicle_Expense_Summary.strStart_Dt));
            parameters.Add(new ReportParameter("End_dt", cls_Vehicle_Expense_Summary.strEnd_Dt));
            parameters.Add(new ReportParameter("loccode", cls_Vehicle_Expense_Summary.strLoccode));
            parameters.Add(new ReportParameter("Type_Code", cls_Vehicle_Expense_Summary.strVeh_Model));
            parameters.Add(new ReportParameter("VehicleNo", cls_Vehicle_Expense_Summary.strVehicleNo));
             parameters.Add(new ReportParameter("Company_Code", cls_Vehicle_Expense_Summary.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));
         
          

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            UpdatePanel1.Update();
        }

    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Vehical_Expnse_Summary.aspx");
    }
}
