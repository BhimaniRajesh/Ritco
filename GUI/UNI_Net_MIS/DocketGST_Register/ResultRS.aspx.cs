using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_Net_MIS_DocketGST_Register_ResultRS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string datetype = Request.QueryString["datetype"].ToString();
            string paybase = Request.QueryString["paybase"].ToString();
            string customer = Request.QueryString["customer"].ToString();
            string dockno = Request.QueryString["dockno"].ToString();
            
            

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("DateType", datetype.ToString()));
            parameters.Add(new ReportParameter("FromDate", fromdt.ToString()));
            parameters.Add(new ReportParameter("ToDate", todt.ToString()));
            parameters.Add(new ReportParameter("PayBase", paybase.ToString()));
            parameters.Add(new ReportParameter("Customer", customer.ToString()));
            parameters.Add(new ReportParameter("DocketNo", dockno.ToString()));
            

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/CNGST_Register";

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            if (userAgent.Contains("MSIE 7.0"))
            {
                //ReportViewer1.Style.Add("margin-bottom", "26px");
                ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }
            if (userAgent.Contains("MSIE 8.0"))
            {
                //ReportViewer1.Style.Add("margin-bottom", "26px");
                ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }

            ReportViewer1.ServerReport.SetParameters(parameters);
        }        
    }
}
