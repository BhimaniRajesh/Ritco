using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_VehTyrePosChangeReport : System.Web.UI.Page
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

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleTyrePosChange";

            ReportParameter[] parameters = new ReportParameter[6];
            parameters[0] = new ReportParameter("Dt_From", Request.QueryString["Dt_From"].ToString());
            parameters[1] = new ReportParameter("Dt_To", Request.QueryString["Dt_To"].ToString());
            parameters[2] = new ReportParameter("VehPosNotChangeDay", Request.QueryString["VehPosNotChangeDay"].ToString());
            parameters[3] = new ReportParameter("VehNo", Request.QueryString["VehNo"].ToString());
            parameters[4] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[5] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();



        }
    
    
    
    }
}
