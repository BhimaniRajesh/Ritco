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

public partial class GUI_UNI_NET_MIS_Bill_ENtry_ACCPAY_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

            string BILTYP = Request.QueryString["BILTYP"].ToString();
            string RTYP = Request.QueryString["RTYP"].ToString();
            string DTTYPE = Request.QueryString["DTTYPE"].ToString();
            string Vendcdstr = Request.QueryString["Vendcdstr"].ToString();
           
			if(Vendcdstr=="")
				Vendcdstr="All";

            List<ReportParameter> parameters = new List<ReportParameter>();
        //    parameters.Add(new ReportParameter("CnnStr", Session["SqlProvider"].ToString().Trim()));
            parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
           
 			if(BILTYP!="All")
			parameters.Add(new ReportParameter("BillTYP", BILTYP.ToString()));
          
            parameters.Add(new ReportParameter("vendcd", Vendcdstr.ToString()));
            parameters.Add(new ReportParameter("SelDAT", DTTYPE.ToString()));
            parameters.Add(new ReportParameter("RPTTYP", "1"));
            parameters.Add(new ReportParameter("RPT_SHT", RTYP.ToString()));

           // ReportViewer1.ServerReport.ReportPath = "/Reports/BILL_Entry";
           
            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            ReportViewer1.Attributes.Add("style", "overflow:auto;");
           // Response.Write(" ccc" );
          //  Response.End();
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/BILL_Entry";
            ReportViewer1.ServerReport.SetParameters(parameters);
        
        }
        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
