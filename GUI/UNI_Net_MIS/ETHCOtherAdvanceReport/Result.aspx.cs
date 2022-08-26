using System;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
using System.Web;

public partial class GUI_Operations_ETHCOtherAdvanceReport_Result : System.Web.UI.Page
{
    public string FromDate = "", ToDate = "", ThcNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

               string FromDate = Request.QueryString["FromDate"].ToString();
               string ToDate = Request.QueryString["ToDate"].ToString();
                string EThcNo = Request.QueryString["EThcNo"].ToString();
                string Status = Request.QueryString["Status"].ToString();
                string Location = Request.QueryString["Location"].ToString();
                

                List<ReportParameter> parameters = new List<ReportParameter>();
                parameters.Add(new ReportParameter("FromDate", FromDate));
                parameters.Add(new ReportParameter("ToDate", ToDate));
                parameters.Add(new ReportParameter("ETHCNo", EThcNo));
                parameters.Add(new ReportParameter("Status", Status));
                parameters.Add(new ReportParameter("Location", Location));
                

                ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
                ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
                ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

                ReportViewer1.ServerReport.DisplayName = "ETHC Other Advance Report";
               // ReportViewer1.ServerReport.ReportPath = "/Reports/THCAuditReport";
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/MIS_ExternalThcOtherAdvanceReport";

                ReportViewer1.Style.Add("margin-bottom", "26");

                ReportViewer1.ServerReport.SetParameters(parameters);
                
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
            throw ex;
        }
    }

}
