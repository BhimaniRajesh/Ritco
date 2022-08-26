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
public partial class GUI_UNI_Net_MIS_DKT_Profi_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
	    HtmlMeta metaDescription = (HtmlMeta)Page.Master.FindControl("uiCompatible");
	    metaDescription.Content = "IE=8;IE=9;IE=10;IE=11";	

            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string RO = Request.QueryString["RO"].ToString();
            string ORGNCD = Request.QueryString["LO"].ToString();
            string VURNo = Request.QueryString["VURNo"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDT", dtFrom.ToString()));
            parameters.Add(new ReportParameter("ToDT", dtTo.ToString()));
            parameters.Add(new ReportParameter("RO", RO.Trim()));
            parameters.Add(new ReportParameter("ORGNCD", ORGNCD.Trim()));
            parameters.Add(new ReportParameter("VURNo", VURNo.Trim()));
            parameters.Add(new ReportParameter("ConnectionStr", SessionUtilities.ConnectionString.Trim()));
            
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
                        
            // ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix.Trim() + "/VehicleUnloadingRegister";
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/VehicleUnloadingRegister";
   //ReportViewer1.ServerReport.ReportPath = "/Reports/VehicleUnloadingRegister";
            ReportViewer1.ShowParameterPrompts = false;

            ReportViewer1.Style.Add("margin-bottom", "26px"); 
            ReportViewer1.ServerReport.SetParameters(parameters);

            //string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            //if (userAgent.Contains("MSIE 7.0"))
            //{
            //    ReportViewer1.Attributes.Add("style", "overflow:auto;");
            //}
        }

        //added By Manisha 23/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}
