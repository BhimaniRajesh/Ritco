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
using System.Data.SqlClient;

public partial class GUI_UNI_Net_MIS_STAX_COLL_REGISTER_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
 if (!IsPostBack)
        {
        string dtFrom = Request.QueryString["fromdt"].ToString();
        string dtTo = Request.QueryString["todt"].ToString();
        string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
        string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

        string DT_TYPE = Request.QueryString["DT_TYPE"].ToString();
        string CUSTSTR = Request.QueryString["CUSTSTR"].ToString();
        string BILLNOSTR = Request.QueryString["BILLNOSTR"].ToString();
        string MRNOSTR = Request.QueryString["MRNOSTR"].ToString();
        string DKTNOSTR = Request.QueryString["DKTNOSTR"].ToString();

        List<ReportParameter> parameters = new List<ReportParameter>();
        
        parameters.Add(new ReportParameter("Location", MAxStr_VAL.ToString()));
        parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
        parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
        parameters.Add(new ReportParameter("TODT", dtTo.ToString()));

        parameters.Add(new ReportParameter("dktnoList", DKTNOSTR.ToString()));
        parameters.Add(new ReportParameter("MRSnoList", MRNOSTR.ToString()));
        parameters.Add(new ReportParameter("custcode", CUSTSTR.ToString()));
     
        //string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

        //if (userAgent.Contains("MSIE 7.0"))
        //{
        ReportViewer1.Style.Add("margin-bottom", "26px");
        //    ReportViewer1.Attributes.Add("style", "overflow:auto;");
        //}
        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/STAX_REG_VER1";
        ReportViewer1.ServerReport.SetParameters(parameters);
        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
}
    }
}
