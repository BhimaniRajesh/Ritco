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

public partial class GUI_Fleet_Reports_VehicleWiseFuelFill_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleWiseFuelFill";

       
            ReportParameter[] parameters = new ReportParameter[5];
            parameters[0] = new ReportParameter("VEHNO", Request.QueryString["VEHNO"].ToString());
            parameters[1] = new ReportParameter("VSlipDt_From", Request.QueryString["VSlipDt_From"].ToString());
            parameters[2] = new ReportParameter("VSlipDt_To", Request.QueryString["VSlipDt_To"].ToString());
            parameters[3] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[4] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());

            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Query.aspx");
    }
}
