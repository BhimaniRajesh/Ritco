using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TyrePerKMCost_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strConnStr = Session["SqlProvider"].ToString();

        rvTyrePerKMCost.Visible = true;

        List<ReportParameter> parameters = new List<ReportParameter>();

        parameters.Add(new ReportParameter("From_Date", Request.QueryString["DateFrom"].ToString() + " 00:00:00.000"));
        parameters.Add(new ReportParameter("To_Date", Request.QueryString["DateTo"].ToString() + " 23:59:59.000"));
        parameters.Add(new ReportParameter("ConnString", strConnStr));


        rvTyrePerKMCost.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TyrePerKMCost";

        rvTyrePerKMCost.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        rvTyrePerKMCost.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        rvTyrePerKMCost.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
        rvTyrePerKMCost.Style.Add("margin-bottom", "26px");

        rvTyrePerKMCost.ServerReport.SetParameters(parameters);
    }
}
