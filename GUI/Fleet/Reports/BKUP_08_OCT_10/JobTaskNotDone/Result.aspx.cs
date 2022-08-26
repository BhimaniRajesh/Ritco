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

public partial class GUI_Fleet_Reports_JobRegister_JobTaskNotDone_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string strConnStr = Session["SqlProvider"].ToString();
            string[] arrConnStr = strConnStr.Split(';');
            string[] arrSrv = arrConnStr[0].Split('=');
            string[] arrDb = arrConnStr[1].Split('=');

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("JOB_ORDER_NO", cls_Report_JobTaskNotDone.strJOB_ORDER_NO));
            parameters.Add(new ReportParameter("FROM_DT", cls_Report_JobTaskNotDone.strFROM_DT));
            parameters.Add(new ReportParameter("TO_DT", cls_Report_JobTaskNotDone.strTO_DT));
            parameters.Add(new ReportParameter("LOCNAME", cls_Report_JobTaskNotDone.strLOCNAME));

            //parameters.Add(new ReportParameter("ServerName", "ecfy_server"));
            //parameters.Add(new ReportParameter("ServerName", arrSrv[1].ToString()));
            //parameters.Add(new ReportParameter("DatabaseName", arrDb[1].ToString()));


            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvDocuments.Style.Add("margin-bottom", "26px");
            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
