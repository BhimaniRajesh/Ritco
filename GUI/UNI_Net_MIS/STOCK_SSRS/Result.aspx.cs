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
using System.Reflection;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_NET_MIS_STOCK_SSRS_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string location = Request.QueryString["location"].ToString();
            string locLevel = Request.QueryString["locLevel"].ToString();
            string location_to = Request.QueryString["location_to"].ToString();
            string locLevel_to = Request.QueryString["locLevel_to"].ToString();
            string DT_TYP = Request.QueryString["DT_TYP"].ToString();
            string LOC_TYP = Request.QueryString["LOC_TYP"].ToString();

            string RPT_TYP = Request.QueryString["RPT_TYP"].ToString();
            string RPT_FORTYP = Request.QueryString["RPT_FORTYP"].ToString();
            string RPT_SFTYP = Request.QueryString["RPT_SFTYP"].ToString();
            //string company = Request.QueryString["company"].ToString();




            //ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/OUTSTD";
            List<ReportParameter> parameters = new List<ReportParameter>();

            // parameters.Add(new ReportParameter("CnnStr", Session["SqlProvider"].ToString().Trim()));
            // parameters.Add(new ReportParameter("str_age", HDR_DETAILS.ToString()));
            parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("location", location.ToString()));
            parameters.Add(new ReportParameter("locLevel", locLevel.ToString()));
            parameters.Add(new ReportParameter("location_to", location_to.ToString()));
            parameters.Add(new ReportParameter("locLevel_to", locLevel_to.ToString()));
            parameters.Add(new ReportParameter("LOCTYP", LOC_TYP.ToString()));

            parameters.Add(new ReportParameter("DTTYP", DT_TYP.ToString()));
            parameters.Add(new ReportParameter("RPT", RPT_TYP.ToString()));
            parameters.Add(new ReportParameter("RPT_FORTYP", RPT_FORTYP.ToString()));

            parameters.Add(new ReportParameter("Suffix", RPT_SFTYP.ToString()));
            parameters.Add(new ReportParameter("GODOWN", "All"));
            //	if (company != "All")
            //    parameters.Add(new ReportParameter("Company", company.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            if (RPT_FORTYP.ToString() == "1")
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Stock_Report_Register";
            else
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Stock_Report_Summary_Ver1";

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            if (userAgent.Contains("MSIE 7.0") || userAgent.Contains("MSIE 8.0"))
            {
                // ReportViewer1.Style.Add("margin-bottom", "26px");
                ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }
            else
                ReportViewer1.Style.Add("margin-bottom", "26px");

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 26/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }
}
