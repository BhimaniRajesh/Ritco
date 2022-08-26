using System;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using Microsoft.ApplicationBlocks.Data;
using Microsoft.Reporting.WebForms;

public partial class GUI_Operations_FM_PendingScanReport_Result : System.Web.UI.Page
{
    string LO = "", RO = "", FromDT = "", ToDT = "", DocType = "";   

    protected void Page_Load(object sender, EventArgs e)
    {
        LO = Request.QueryString["LO"];
        RO = Request.QueryString["RO"];
        FromDT = HttpUtility.UrlDecode(Request.QueryString["FromDT"]);
        ToDT = HttpUtility.UrlDecode(Request.QueryString["ToDT"]);
        DocType = Request.QueryString["DocType"];

        List<ReportParameter> parameters = new List<ReportParameter>();
        parameters.Add(new ReportParameter("DocType", DocType));
        if(RO.Trim() != "" && RO.Trim().ToUpper() != "ALL")
            parameters.Add(new ReportParameter("Ro", RO));
        if (LO.Trim() != "" && LO.Trim().ToUpper() != "ALL")
            parameters.Add(new ReportParameter("Loc", LO));       
        parameters.Add(new ReportParameter("FromDT", FromDT));
        parameters.Add(new ReportParameter("ToDT", ToDT));

        rvDocuments.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        rvDocuments.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        rvDocuments.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;   
        rvDocuments.Style.Add("margin-bottom", "26px");
        rvDocuments.ServerReport.SetParameters(parameters);
    }   
}
