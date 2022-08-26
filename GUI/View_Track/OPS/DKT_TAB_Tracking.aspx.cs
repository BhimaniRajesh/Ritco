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

public partial class GUI_View_Track_Operation_DKT_TAB_Tracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
if (!IsPostBack)
        {
        AddView();
        }
    }

 
    private void AddView()
    {
        string docno = Request.QueryString["dockno"].ToString();
        string docsf = Request.QueryString["docksf"].ToString();
        string ID = Request.QueryString["ID"].ToString();

        List<ReportParameter> parameters = new List<ReportParameter>();
        //parameters.Add(new ReportParameter("RPTTB", "DKT"));
        parameters.Add(new ReportParameter("dockno", docno.ToString()));
        parameters.Add(new ReportParameter("docksf", docsf.ToString()));

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
       ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        if (ID == "1")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Summary_TAB";
        else if (ID == "2")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/TimeTracking";
        else if (ID == "3")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/OPN_LIFE_TAB";
        else if (ID == "4")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Fin_life_cycle";
        else if (ID == "5")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/POD_PFM";
        else if (ID == "6")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Movement_TAB";
        else if (ID == "7")
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Profit_loss_TAB";
        else
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Summary_TAB";

        ReportViewer1.ServerReport.SetParameters(parameters);
    }
}
