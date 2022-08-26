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
using System.Reflection;
using Microsoft.Reporting.WebForms;
public partial class GUI_UNI_Net_MIS_CustomerContractViewSSRS : System.Web.UI.Page
{
    string strContractID = "";
    string strCustName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
if (!IsPostBack)
        {
            strContractID = Request.QueryString["contractid"].ToString();

            MyFunctions fn = new MyFunctions();
            strCustName = fn.Getcustomer(Request.QueryString["custcode"].ToString());

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("ContractID", strContractID.ToString()));
            parameters.Add(new ReportParameter("CustomerCode", Request.QueryString["custcode"].ToString()));
            parameters.Add(new ReportParameter("CustomerName", strCustName.ToString()));
  
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/CustomerContractView";           
        
            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");
            if (userAgent.Contains("MSIE 7.0"))
            {
                ReportViewer1.Style.Add("margin-bottom", "26px");
                // ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }
            ReportViewer1.ServerReport.SetParameters(parameters);            
    }
}
}
