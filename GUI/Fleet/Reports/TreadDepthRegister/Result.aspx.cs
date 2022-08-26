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
        if (!IsPostBack && !IsCallback)
        {


            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            //List<ReportParameter> parameters = new List<ReportParameter>();

            //parameters.Add(new ReportParameter("FROM_DT", cls_Report_TreadDepth_Register.strFROM_DT));
            //parameters.Add(new ReportParameter("TO_DT", cls_Report_TreadDepth_Register.strTO_DT));
            //parameters.Add(new ReportParameter("VEH_NO", cls_Report_TreadDepth_Register.strVEH_NO));
            //parameters.Add(new ReportParameter("TYRE_NO", cls_Report_TreadDepth_Register.strTYRE_NO));
            //parameters.Add(new ReportParameter("TWI_FROM", cls_Report_TreadDepth_Register.strTWI_FROM));
            //parameters.Add(new ReportParameter("TWI_TO", cls_Report_TreadDepth_Register.strTWI_TO));
            //parameters.Add(new ReportParameter("Company_Code", cls_Report_TreadDepth_Register.strCompany));
            //parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportParameter[] parameters = new ReportParameter[8];
            parameters[0] = new ReportParameter("FROM_DT", Request.QueryString["FROM_DT"].ToString());
            parameters[1] = new ReportParameter("TO_DT", Request.QueryString["TO_DT"].ToString());
            parameters[2] = new ReportParameter("VEH_NO", Request.QueryString["VEH_NO"].ToString());
            parameters[3] = new ReportParameter("TYRE_NO", Request.QueryString["TYRE_NO"].ToString());
            parameters[4] = new ReportParameter("TWI_FROM", Request.QueryString["TWI_FROM"].ToString());
            parameters[5] = new ReportParameter("TWI_TO", Request.QueryString["TWI_TO"].ToString());
            parameters[6] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[7] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());

            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TreadDepthMeasurement";
            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            rvDocuments.Style.Add("margin-bottom", "26px");

            rvDocuments.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 20/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
