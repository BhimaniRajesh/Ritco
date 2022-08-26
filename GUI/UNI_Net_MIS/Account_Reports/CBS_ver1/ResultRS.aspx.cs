using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_Account_Reports_CBS_ver1_ResultRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string st_ro, st_lo, dtFrom, RPT, dtTo, st_Acc, Acc, lRO = "", finyear;

            RPT = Request.QueryString["RPT"].ToString();
            st_ro = Request.QueryString["RO"].ToString().Trim();
            st_lo = Request.QueryString["LO"].ToString().Trim();
            dtFrom = Request.QueryString["fromdt"].ToString();
            dtTo = Request.QueryString["todt"].ToString();
            st_Acc = Request.QueryString["st_Acc"].ToString().Trim();
            Acc = Request.QueryString["Acc"].ToString().Trim();
            finyear = "08_09";

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


            //string ABD = "exec WebxNet_Sales_Register '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + dtFrom + "','" + dtTo + "',    '" + DTTYPE + "','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + strcustcd + "','" + select_list + "','" + selectView + "','" + st_status + "'";
            // Response.Write("ABD" + ABD);

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("from_date", dtFrom.ToString()));
            parameters.Add(new ReportParameter("to_date", dtTo.ToString()));
            parameters.Add(new ReportParameter("Cumilative", "Y"));
            parameters.Add(new ReportParameter("Fin_Year", yearSuffix));
            parameters.Add(new ReportParameter("accode", st_Acc.ToString()));
            parameters.Add(new ReportParameter("CUST_EMP_VEND_CD", "ALL"));
            parameters.Add(new ReportParameter("RO", st_ro.ToString()));
            parameters.Add(new ReportParameter("brcd", st_lo.ToString()));
            parameters.Add(new ReportParameter("RPT", "1"));
            parameters.Add(new ReportParameter("Page", "1"));
            parameters.Add(new ReportParameter("PageSize", "999999"));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/CBS_Ver1";

            ReportViewer1.Style.Add("margin-bottom", "26");
            ReportViewer1.ServerReport.SetParameters(parameters);


            //added By Manisha 22/5/2014
            DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
        }

    }
}