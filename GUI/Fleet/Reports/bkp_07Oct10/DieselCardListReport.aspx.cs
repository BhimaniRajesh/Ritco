using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_DieselCardListReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);


            ReportViewer1.Visible = true;
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";


            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DieselCardList";
            List<ReportParameter> parameters = new List<ReportParameter>();



            parameters.Add(new ReportParameter("COMPANY", Cls_Diesel_Card_List.strCOMPANY));
            parameters.Add(new ReportParameter("CARDNO", Cls_Diesel_Card_List.strCARDNO));
            parameters.Add(new ReportParameter("VEHNO", Cls_Diesel_Card_List.strVEHNO));
            parameters.Add(new ReportParameter("CARDVAL_FROM", Cls_Diesel_Card_List.strCARDVAL_FROM));
            parameters.Add(new ReportParameter("CARDVAL_TO", Cls_Diesel_Card_List.strCARDVAL_TO));
            parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    }
}
