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
using System.Globalization;
using System.Data.SqlClient;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_admin_Vendor_contract_Ver1_ContractView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            //@RO,@Branch,@StartDT,@EndDT,@DocList
            string ContractID = Request.QueryString["ContractID"];

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("ContractID", ContractID));

            rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            rvDocuments.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/VendorContractView"; 
            rvDocuments.Style.Add("margin-bottom", "26px");
            rvDocuments.ServerReport.SetParameters(parameters);
        }
    }
}
