using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_UNI_Net_MIS_CHQ_register_SSRS_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string RO = Request.QueryString["RO"].ToString();
            string LO = Request.QueryString["LO"].ToString();
            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string RPT = Request.QueryString["RPT"].ToString();
            string RPT_STR = Request.QueryString["RPT_STR"].ToString();
            string banklist = Request.QueryString["banklist"].ToString();
            string CHQ_DEPOST = Request.QueryString["CHQ_DEPOST"].ToString();
            string CHQ_DEPOST_str = Request.QueryString["CHQ_DEPOST_str"].ToString();
            string CHQ_AccSt_str = Request.QueryString["CHQ_AccSt_str"].ToString();
            string CHQ_AccSt = Request.QueryString["CHQ_AccSt"].ToString();
            string CHQ_REcoSt = Request.QueryString["CHQ_REcoSt"].ToString();
            string CHQ_REcoSt_str = Request.QueryString["CHQ_REcoSt_str"].ToString();

            string amtfrm = Request.QueryString["amtfrm"].ToString();
            string amtto = Request.QueryString["amtto"].ToString();
            string chqnolist = Request.QueryString["chqnolist"].ToString();
            string DTSTR = Request.QueryString["DTSTR"].ToString();
            string DTSTR_str = Request.QueryString["DTSTR_str"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("fromdt", fromdt.ToString()));
            parameters.Add(new ReportParameter("todt", todt.ToString()));
            parameters.Add(new ReportParameter("RO", RO.ToString()));
            parameters.Add(new ReportParameter("ORGNCD", LO.ToString()));
            parameters.Add(new ReportParameter("DTTYP", DTSTR.ToString()));
            parameters.Add(new ReportParameter("BankList", banklist.ToString()));
            parameters.Add(new ReportParameter("CHQ_CLST", CHQ_REcoSt.ToString()));
            parameters.Add(new ReportParameter("CHQDEPO", CHQ_DEPOST.ToString()));
            parameters.Add(new ReportParameter("CHQ_ACC", CHQ_AccSt.ToString()));
            parameters.Add(new ReportParameter("CHQ_AMTFRM", amtfrm.ToString()));
            parameters.Add(new ReportParameter("CHQ_AMTTO", amtto.ToString()));
            parameters.Add(new ReportParameter("RPTTYP", RPT.ToString()));
            parameters.Add(new ReportParameter("CHANO_LIST", chqnolist.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/CHQ_Register";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }

        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}