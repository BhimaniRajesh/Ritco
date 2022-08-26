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
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

    
public partial class GUI_UNI_MIS_OPN_LIFE_CYCLE_PopUp_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string Docketno = Request.QueryString["dockno"].ToString();
            string Docketsf = Request.QueryString["docksf"].ToString();
            string doctyp = Request.QueryString["doc_typ"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("dockno", Docketno.ToString()));
            parameters.Add(new ReportParameter("docksf", Docketsf.ToString()));
            parameters.Add(new ReportParameter("doc_typ",doctyp.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = "/Reports/OPN_LIFE_CYCLE_DET";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }    
}
