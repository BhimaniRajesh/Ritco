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


public partial class GUI_UNI_NET_MIS_Account_Reports_GL_TB_Result_BSRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string fromdt = Request.QueryString["dateFrom"].ToString();
            string todt = Request.QueryString["dateTo"].ToString();
            string Rtyp = Request.QueryString["Rtyp"].ToString();
            string TYP_CD = Request.QueryString["TYP_CD"].ToString();
            string ACC_cd = Request.QueryString["ACCODE"].ToString();
            string Cumulative = Request.QueryString["Cumlative"].ToString();
            string RO = Request.QueryString["branch"].ToString();

            string YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));


 if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);

            if (TYP_CD == "")
                TYP_CD = "All";
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("fromdt", fromdt.ToString()));
            parameters.Add(new ReportParameter("todt", todt.ToString()));
            parameters.Add(new ReportParameter("Cumulative", Cumulative.ToString()));
            parameters.Add(new ReportParameter("finyear", yearSuffix));
          //  parameters.Add(new ReportParameter("accode", ACC_cd.ToString()));
            parameters.Add(new ReportParameter("BRCD", RO.ToString()));
            parameters.Add(new ReportParameter("TYP", ""));
          
         

           
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;


            ReportViewer1.ServerReport.DisplayName = "Balance Sheet";
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Balance Sheet";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
