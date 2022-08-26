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


public partial class GUI_UNI_Net_MIS_INS_RPT_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
   if (!IsPostBack)
        {
        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/INSRPT";
  

     
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string str_ststus = Request.QueryString["str_ststus"].ToString();
            string RTYP = Request.QueryString["RTYP"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));

            parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("Type", str_ststus.ToString()));

            parameters.Add(new ReportParameter("RPTTYP", RTYP.ToString()));
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");
        if (userAgent.Contains("MSIE 7.0"))
        {
            // ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.Attributes.Add("style", "overflow:auto;");
        }

        //added By Manisha 23/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
