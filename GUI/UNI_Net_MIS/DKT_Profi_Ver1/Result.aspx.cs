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
using System.Globalization;
using System.Data.SqlClient;
using System.Reflection;

public partial class GUI_UNI_Net_MIS_DKT_Profi_Result1 : System.Web.UI.Page
{
     protected void Page_Load(object sender, EventArgs e)
    {
         if (!IsPostBack)
         {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string abc = Request.QueryString["RPTID"].ToString();
            //Response.Write(abc);
            string DocketLsit = "", strcustcd = "";
            strcustcd = Request.QueryString["strcustcd"].ToString();
            if (strcustcd == "")
                strcustcd = "All";
            if (DocketLsit == "")
                DocketLsit = "All";

            string docknolist = Request.QueryString["docknolist"].ToString();
            string st_paybasis = Request.QueryString["st_paybasis"].ToString();
            string st_trnmod = Request.QueryString["st_trnmod"].ToString();
            string st_type = Request.QueryString["st_type"].ToString();
            string st_busttype = Request.QueryString["st_busttype"].ToString();
            string str_paybasis = Request.QueryString["str_paybasis"].ToString();
            string str_trnmod = Request.QueryString["str_trnmod"].ToString();
            string str_busttype = Request.QueryString["str_busttype"].ToString();
            string str_type = Request.QueryString["str_type"].ToString();

            string RPTTYP = Request.QueryString["RPTTYP"].ToString();

            

            string SQL = " '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + dtFrom + "','" + dtTo + "','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "' ";

            // Response.Write(" SQL..." + SQL);
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("TODT", dtTo.ToString()));

            parameters.Add(new ReportParameter("paybas", st_paybasis.ToString()));
            parameters.Add(new ReportParameter("TRN", st_trnmod.ToString()));
            parameters.Add(new ReportParameter("BKGTYP", st_type.ToString()));
            parameters.Add(new ReportParameter("BUSTYP", st_busttype.ToString()));
            parameters.Add(new ReportParameter("custcode", strcustcd));
            parameters.Add(new ReportParameter("dktnoList", docknolist));


				ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
				ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
                ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        //TextBox txtReportName = (TextBox)LnkRPT1.FindControl("txtReportName");
        //LnkRPT1.Report_NM = txtReportName.Text;

            if (RPTTYP == "0")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Prof_Summary_Ver1";
                //LnkRPT1.Report_URL = ReportServiceUtilities.ReportPathPrefix + "DKT_Prof_Summary_Ver1";
                ReportViewer1.ShowParameterPrompts = true;
            }
            else if (RPTTYP == "1")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Prof_Ver1";
                //LnkRPT1.Report_URL = ReportServiceUtilities.ReportPathPrefix + "DKT_Prof_Ver1";
                ReportViewer1.ShowParameterPrompts = false;
            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Prof_Summary_Ver1";
                //LnkRPT1.Report_URL = ReportServiceUtilities.ReportPathPrefix + "DKT_Prof_Summary_Ver1";
                ReportViewer1.ShowParameterPrompts = true;
            }

            //DataTable RPTInsert = ReportCounter.InsertReportCounter(Request.QueryString["RPTID"].ToString(), SessionUtilities.CurrentEmployeeID.ToString(), SessionUtilities.CurrentBranchCode.ToString()).Tables[0];

			//string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            //if (userAgent.Contains("MSIE 7.0") || userAgent.Contains("MSIE 8.0"))
            //{
                //ReportViewer1.Style.Add("margin-bottom", "26px");
                //ReportViewer1.Attributes.Add("style", "overflow:auto;");
            //}
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //LnkRPT1.ReportViewer = ReportViewer1;
    }
}
