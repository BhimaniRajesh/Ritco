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

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Dt_From", Cls_Report_VehTyrePosChange.strDt_From));
            parameters.Add(new ReportParameter("Dt_To", Cls_Report_VehTyrePosChange.strDt_To));
            parameters.Add(new ReportParameter("VehPosNotChangeDay", Cls_Report_VehTyrePosChange.strVehPosNotChangeDay));
            parameters.Add(new ReportParameter("VehNo", Cls_Report_VehTyrePosChange.strVehNo));
            parameters.Add(new ReportParameter("Company_Code", Cls_Report_VehTyrePosChange.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();



        }
    
    
    
    }
}
