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


public partial class GUI_Fleet_Reports_VehicleLogRegisterReport : System.Web.UI.Page
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
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicelLogRegister";


            //List<ReportParameter> parameters = new List<ReportParameter>();
            //parameters.Add(new ReportParameter("TRIPSHEET_FROM_DT", Cls_Report_VehiclogRes.strTRIPSHEET_FROM_DT));
            //parameters.Add(new ReportParameter("TRIPSHEET_TO_DT", Cls_Report_VehiclogRes.strTRIPSHEET_TO_DT));
            //parameters.Add(new ReportParameter("VEH_NO", Cls_Report_VehiclogRes.strVEH_NO));
            //parameters.Add(new ReportParameter("DRIVER_NAME", Cls_Report_VehiclogRes.strDRIVER_NAME));
            //parameters.Add(new ReportParameter("KM_RUN_FROM", Cls_Report_VehiclogRes.strKM_RUN_FROM));
            //parameters.Add(new ReportParameter("KM_RUN_TO", Cls_Report_VehiclogRes.strKM_RUN_TO));
            //parameters.Add(new ReportParameter("KMPL_FROM", Cls_Report_VehiclogRes.strKMPL_FROM));
            //parameters.Add(new ReportParameter("KMPL_TO", Cls_Report_VehiclogRes.strKMPL_TO));
            //parameters.Add(new ReportParameter("Company_Code", Cls_Report_VehiclogRes.strCompany));
            //parameters.Add(new ReportParameter("ConnString", strConnStr));


            ReportParameter[] parameters = new ReportParameter[10];
            parameters[0] = new ReportParameter("TRIPSHEET_FROM_DT", Request.QueryString["TRIPSHEET_FROM_DT"].ToString());
            parameters[1] = new ReportParameter("TRIPSHEET_TO_DT", Request.QueryString["TRIPSHEET_TO_DT"].ToString());
            parameters[2] = new ReportParameter("VEH_NO", Request.QueryString["VEH_NO"].ToString());
            parameters[3] = new ReportParameter("DRIVER_NAME", Request.QueryString["DRIVER_NAME"].ToString());
            parameters[4] = new ReportParameter("KM_RUN_FROM", Request.QueryString["KM_RUN_FROM"].ToString());
            parameters[5] = new ReportParameter("KM_RUN_TO", Request.QueryString["KM_RUN_TO"].ToString());
            parameters[6] = new ReportParameter("KMPL_FROM", Request.QueryString["KMPL_FROM"].ToString());
            parameters[7] = new ReportParameter("KMPL_TO", Request.QueryString["KMPL_TO"].ToString());
            parameters[8] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[9] = new ReportParameter("ConnString", strConnStr);




            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }

        //added By Manisha 21/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
