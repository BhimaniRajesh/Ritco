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
public partial class GUI_UNI_NET_MIS_OUTSTD_SSRS_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
                  

           
              //  BILLTYP = "1,2,3,6,7,9";

           
           // Response.Write("cc " + ReportServiceUtilities.ReportPathPrefix);
            if (!IsPostBack)
            {
                string dtFrom = Request.QueryString["dtFrom"].ToString();
                string dtTo = Request.QueryString["dtTo"].ToString();
                string location = Request.QueryString["location"].ToString();
                string locLevel = Request.QueryString["locLevel"].ToString();

                string HDR_DETAILS = Request.QueryString["HDR_DETAILS"].ToString();
                string LOC_TYP = Request.QueryString["LOC_TYP"].ToString();
                string DT_TYP = Request.QueryString["DT_TYP"].ToString();
                string FinYear = Request.QueryString["FinYear"].ToString();
                string RPT = Request.QueryString["RPT"].ToString();
                string RPT_SUB = Request.QueryString["RPT_SUB"].ToString();
                string ASONDT = Request.QueryString["ASONDT"].ToString();
                string ASONDT_to = Request.QueryString["ASONDT_to"].ToString();
                string CUSTSTR = Request.QueryString["CUSTSTR"].ToString();

                string TYP = Request.QueryString["TYP"].ToString();
                string BILLTYP = Request.QueryString["BILLTYP"].ToString();
                HDR_DETAILS = HDR_DETAILS.Replace("AF", "<AGE><FIRST>");
                HDR_DETAILS = HDR_DETAILS.Replace("FS", "</FIRST><SECOND>");
                HDR_DETAILS = HDR_DETAILS.Replace("SA", "</SECOND></AGE>");

//Response.Write("HDR_DETAILS "+HDR_DETAILS );

                if (CUSTSTR == " ")
                    CUSTSTR = "All";

                ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
                ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
                ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/OUTSTD";
                List<ReportParameter> parameters = new List<ReportParameter>();

               // parameters.Add(new ReportParameter("CnnStr", Session["SqlProvider"].ToString().Trim()));
              parameters.Add(new ReportParameter("str_age", HDR_DETAILS.ToString()));
                parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
                parameters.Add(new ReportParameter("todt", dtTo.ToString()));
                parameters.Add(new ReportParameter("location", location.ToString()));
                parameters.Add(new ReportParameter("locLevel", locLevel.ToString()));
                parameters.Add(new ReportParameter("LOC_TYP", LOC_TYP.ToString()));

                parameters.Add(new ReportParameter("DT_TYP", DT_TYP.ToString()));
                parameters.Add(new ReportParameter("RPT", RPT.ToString()));
                parameters.Add(new ReportParameter("RPT_SUB", RPT_SUB.ToString()));
                parameters.Add(new ReportParameter("ASONDT", ASONDT.ToString()));
                parameters.Add(new ReportParameter("ASONDT_to", ASONDT_to.ToString()));
                parameters.Add(new ReportParameter("CUSTSTR", CUSTSTR.ToString()));
                parameters.Add(new ReportParameter("FinYear", FinYear.ToString()));

                parameters.Add(new ReportParameter("TYP", TYP.ToString()));

                if (BILLTYP != "All")
                parameters.Add(new ReportParameter("BILLTYP", BILLTYP.ToString()));


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
            //added By Manisha 22/5/2014
            DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  

    }
}
