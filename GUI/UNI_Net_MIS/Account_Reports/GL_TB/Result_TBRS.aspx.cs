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

public partial class GUI_UNI_NET_MIS_Account_Reports_GL_TB_Result_TBRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string RO, LO, custcd, empcd, ACC_cd, Cumulative, vendcd, TYP_CD, RO_TO, LO_TO, Rtyp, View_Sales, DateType, st_paybasis, st_status, st_custcd, st_type, st_trnmod, fromdt, todt, st_Docnolist, select_list, select_Text, st_doctyp;

            fromdt = Request.QueryString["dateFrom"].ToString();
            todt = Request.QueryString["dateTo"].ToString();
            Rtyp = Request.QueryString["Rtyp"].ToString();
            TYP_CD = Request.QueryString["TYP_CD"].ToString();
            ACC_cd = Request.QueryString["ACCODE"].ToString();
            Cumulative = Request.QueryString["Cumlative"].ToString();
            RO = Request.QueryString["branch"].ToString();

            string YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));

            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("from_date", fromdt.ToString()));
            parameters.Add(new ReportParameter("to_date", todt.ToString()));
            parameters.Add(new ReportParameter("Cumilative", Cumulative.ToString()));
            parameters.Add(new ReportParameter("Fin_Year", yearSuffix));
            //parameters.Add(new ReportParameter("accode", ACC_cd.ToString()));
            parameters.Add(new ReportParameter("CUST_EMP_VEND_CD", "ALL"));
            parameters.Add(new ReportParameter("brcd", RO.ToString()));
            parameters.Add(new ReportParameter("RPT", Rtyp.ToString()));
            //parameters.Add(new ReportParameter("Page", "1"));
            //parameters.Add(new ReportParameter("PageSize", "999999"));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/TRBALANCE";
  
            ReportViewer1.Style.Add("margin-bottom", "26");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }

        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  


    }
}

