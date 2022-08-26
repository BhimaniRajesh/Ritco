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


public partial class GUI_Fleet_Reports_DieselCardTranReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);
            ReportViewer1.Visible = true;


            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            //ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;


            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DieselCardTran";
            List<ReportParameter> parameters = new List<ReportParameter>();
           
            parameters.Add(new ReportParameter("VehNo", Cls_Diesel_Card_Trans.strVehNo));
            parameters.Add(new ReportParameter("CardNo", Cls_Diesel_Card_Trans.strCardNo));
			parameters.Add(new ReportParameter("VSlipDt_From", Cls_Diesel_Card_Trans.strVSlipDt_From));
            parameters.Add(new ReportParameter("VSlipDt_To", Cls_Diesel_Card_Trans.strVSlipDt_To));
            parameters.Add(new ReportParameter("Company_Code", Cls_Diesel_Card_Trans.strCompany.ToString().Trim()));
            parameters.Add(new ReportParameter("ConnString", strConnStr));



            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
        }
    }
}
