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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_Net_MIS_Account_Reports_GL_TB_Result_PNL : System.Web.UI.Page
{
    public static string lv, RPT_flag, YearString, yearSuffix, finyearstart, strFinalQS = "", mHeadOfficeCode;
   
     protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);

            string fromdt = Request.QueryString["dateFrom"].ToString();
            string  todt = Request.QueryString["dateTo"].ToString();
            string Rtyp = Request.QueryString["Rtyp"].ToString();
           
            string RPT = Request.QueryString["RPT"].ToString();
            string TYP_CD = Request.QueryString["TYP_CD"].ToString();
            string ACC_cd = Request.QueryString["ACCODE"].ToString();
            string Cumulative = Request.QueryString["Cumlative"].ToString();
            string RO = Request.QueryString["branch"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", RO.ToString()));
            parameters.Add(new ReportParameter("Cumulative", Cumulative.ToString()));
            parameters.Add(new ReportParameter("FromDT", fromdt.ToString()));
            parameters.Add(new ReportParameter("toDt", todt.ToString()));
            parameters.Add(new ReportParameter("ROWSBY", "A"));
            parameters.Add(new ReportParameter("Groupby", "Category,Groups,Account,Location"));
            parameters.Add(new ReportParameter("Summary", "CR-DR"));
            parameters.Add(new ReportParameter("FINYear", yearSuffix.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/ProfitLoss";
            ReportViewer1.ServerReport.SetParameters(parameters);
        }

        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
    
    
}

