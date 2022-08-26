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

public partial class GUI_UNI_Net_MIS_Docket_flow_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

            //  string MAxStr_VAL_to = Request.QueryString["MAxStr_VAL_to"].ToString();
            //  string MAxSTR_LV_to = Request.QueryString["MAxSTR_LV_to"].ToString();

            string st_paybasis = Request.QueryString["st_paybasis"].ToString();
            string st_trnmod = Request.QueryString["st_trnmod"].ToString();
            string st_type = Request.QueryString["st_type"].ToString();
            string st_busttype = Request.QueryString["st_busttype"].ToString();
            string str_ststus = Request.QueryString["str_ststus"].ToString();
            string RTYP = Request.QueryString["RTYP"].ToString();
            string DTTYPE = Request.QueryString["DTTYPE"].ToString();

            string RPTTYP = "BKG";

            if (DTTYPE=="1")
                RPTTYP = "BKG";
            else
                RPTTYP = "DLY";

            if (RTYP == "2")
            {
                str_ststus = "0";
            }

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            // parameters.Add(new ReportParameter("location_to", MAxStr_VAL_to.ToString()));
            //  parameters.Add(new ReportParameter("locLevel_to", MAxSTR_LV_to.ToString()));
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("LOCTYP", DTTYPE.ToString()));
            parameters.Add(new ReportParameter("DTTYP", "1"));
            parameters.Add(new ReportParameter("paybas", st_paybasis.ToString()));
            parameters.Add(new ReportParameter("TRN", st_trnmod.ToString()));
            parameters.Add(new ReportParameter("BKGTYP", st_type.ToString()));
            parameters.Add(new ReportParameter("BUSTYP", st_busttype.ToString()));
            parameters.Add(new ReportParameter("STATUS", str_ststus));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");
            if (RTYP == "2")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_FLOW_Summary";
               // ReportViewer1.AsyncRendering = false;
                if (userAgent.Contains("MSIE 7.0"))
                {
                    // ReportViewer1.Style.Add("margin-bottom", "26px");
                    ReportViewer1.Attributes.Add("style", "overflow:auto;");
                }
            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_FLOW_REGISTER";
                //ReportViewer1.AsyncRendering = true;
            }


            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 26/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
