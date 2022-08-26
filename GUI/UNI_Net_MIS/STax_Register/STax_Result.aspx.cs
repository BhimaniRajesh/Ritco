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
public partial class GUI_UNI_MIS_STax_Register_STax_Result : System.Web.UI.Page
{

    public static string   YearString, yearSuffix;

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

       
        string dtFrom = Request.QueryString["fromdt"].ToString();
        string dtTo = Request.QueryString["todt"].ToString();
        string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
        string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

        string PartyCode = Request.QueryString["PartyCode"].ToString();
        string Type = Request.QueryString["Type"].ToString();
        string RType = Request.QueryString["RType"].ToString();


        if (MAxStr_VAL == "")
            MAxStr_VAL = "All";

        if (MAxSTR_LV == "")
            MAxSTR_LV = "1";

        if (PartyCode == "")
            PartyCode = "All";


        List<ReportParameter> parameters = new List<ReportParameter>();
        parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
        parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
        parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
        parameters.Add(new ReportParameter("todt", dtTo.ToString()));
        parameters.Add(new ReportParameter("CUSTCOde", PartyCode.ToString()));
        parameters.Add(new ReportParameter("TYPE", Type.ToString()));
        parameters.Add(new ReportParameter("FinYear", yearSuffix));
        parameters.Add(new ReportParameter("RTYPE", RType.ToString()));

 string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            if (userAgent.Contains("MSIE 7.0"))
            {
                // ReportViewer1.Style.Add("margin-bottom", "26px");
                ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix +"/STAX_Register";
        ReportViewer1.ServerReport.SetParameters(parameters);


        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
 }
    }
   
}
