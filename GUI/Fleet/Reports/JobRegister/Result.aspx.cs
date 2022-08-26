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

public partial class GUI_UNI_Net_MIS_Trip_Profitablility_Report_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strhdnRpt = cls_Report_JobsheeetRegister.strhdn;
        if (!IsPostBack && !IsCallback)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FROM_DT", cls_Report_JobsheeetRegister.strFROM_DT));
            parameters.Add(new ReportParameter("TO_DT", cls_Report_JobsheeetRegister.strTO_DT));
            parameters.Add(new ReportParameter("VEH_NO", cls_Report_JobsheeetRegister.strVEH_NO));
            parameters.Add(new ReportParameter("JOB_CARD_TYPE", cls_Report_JobsheeetRegister.strJOB_CARD_TYPE));
            parameters.Add(new ReportParameter("SERV_CENTER_TYPE", cls_Report_JobsheeetRegister.strSERV_CENTER_TYPE));
            parameters.Add(new ReportParameter("Workshop_Loc", cls_Report_JobsheeetRegister.strWorkshop_Loc));
            parameters.Add(new ReportParameter("Workshop_Vendor", cls_Report_JobsheeetRegister.strWorkshop_Vendor));
            parameters.Add(new ReportParameter("JOB_STATUS", cls_Report_JobsheeetRegister.strJOB_STATUS));
            parameters.Add(new ReportParameter("Company_Code", cls_Report_JobsheeetRegister.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "JobSheetRegister";

            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvDocuments.Style.Add("margin-bottom", "26px");

            rvDocuments.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 20/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(strhdnRpt, SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
