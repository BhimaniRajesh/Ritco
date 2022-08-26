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

public partial class GUI_UNI_NET_MIS_Account_Reports_GL_TB_Result_GLRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
	    Response.AppendHeader("X-UA-Compatible", "IE=edge");
            string st_ro, st_lo, dtFrom, RPT, dtTo, st_Acc, Acc, lRO = "", finyear;

            //RPT = Request.QueryString["RPT"].ToString();
            //st_ro = Request.QueryString["RO"].ToString().Trim();
            //st_lo = Request.QueryString["LO"].ToString().Trim();
            //dtFrom = Request.QueryString["fromdt"].ToString();
            //dtTo = Request.QueryString["todt"].ToString();
            //st_Acc = Request.QueryString["st_Acc"].ToString().Trim();
            //Acc = Request.QueryString["Acc"].ToString().Trim();
            //finyear = "08_09";

            string fromdt = Request.QueryString["dateFrom"].ToString();
            string Rtyp = Request.QueryString["Rtyp"].ToString();
            string todt = Request.QueryString["dateTo"].ToString();
            string TYP_CD = Request.QueryString["TYP_CD"].ToString();
            string ACC_cd = Request.QueryString["ACCODE"].ToString();
            string Cumulative = Request.QueryString["Cumlative"].ToString();
            string RO = Request.QueryString["branch"].ToString();
            string RPTTYP = Request.QueryString["RPTTYP"].ToString();
            string PGNO = Request.QueryString["PGNO"].ToString();
            //string PGSIZE = Request.QueryString["Psize"].ToString();

            string YearString = Session["FinYear"].ToString().Substring(2, 2);
            string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));

            //if (st_lo != "%%")
            //{
            //    stRO = "All";
            //}


            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            DateTime yrstartdt;
            string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);

            if (TYP_CD == "")
                TYP_CD = "All";
  			if (ACC_cd == "")
                ACC_cd = "All";
            //string ABD = "exec WebxNet_Sales_Register '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + dtFrom + "','" + dtTo + "',    '" + DTTYPE + "','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + strcustcd + "','" + select_list + "','" + selectView + "','" + st_status + "'";
            // Response.Write("ABD" + ABD);

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("from_date", fromdt.ToString()));
            parameters.Add(new ReportParameter("to_date", todt.ToString()));
            parameters.Add(new ReportParameter("Cumilative", Cumulative.ToString()));
            parameters.Add(new ReportParameter("Fin_Year", yearSuffix));
            parameters.Add(new ReportParameter("accode", ACC_cd.ToString()));
            parameters.Add(new ReportParameter("CUST_EMP_VEND_CD", TYP_CD.ToString()));
            parameters.Add(new ReportParameter("brcd", RO.ToString()));
            parameters.Add(new ReportParameter("RPT", "1"));
            parameters.Add(new ReportParameter("Page", PGNO.ToString()));
            parameters.Add(new ReportParameter("PageSize", "999999"));
             //<ServerReport DisplayName="General Ledger" ReportPath="/Reports/GL_Ver1"></ServerReport>

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;


            if (RPTTYP == "1" || RPTTYP == "4")
            {
                ReportViewer1.ServerReport.DisplayName = "General Ledger";
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/GenLedger";
            }
            else if (RPTTYP == "2")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/GENLedger_TYPWise";
                ReportViewer1.ServerReport.DisplayName = "Month Wise General Ledger";
            } 
            else if (RPTTYP == "3")
            {
                ReportViewer1.ServerReport.DisplayName = "General Ledger";
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix +"/GL_Ver1";
            }

           
            ReportViewer1.ServerReport.SetParameters(parameters);

        }


        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  

    }
}

