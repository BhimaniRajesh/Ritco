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
using Microsoft.Reporting.WebForms;

public partial class GUI_admin_FuelSlipMaster_PendingFuelBillsApproval_Result_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string Billno = Request.QueryString["Billno"].ToString();
            //string EntryBy = Session["empcd"].ToString();

           

            List<ReportParameter> parameters = new List<ReportParameter>();
            //    parameters.Add(new ReportParameter("CnnStr", Session["SqlProvider"].ToString().Trim()));

            //parameters.Add(new ReportParameter("Billno", Billno.ToString()));
            //parameters.Add(new ReportParameter("EntryBy", EntryBy.ToString()));
            parameters.Add(new ReportParameter("VoucherNo", Billno.ToString()));



            // ReportViewer1.ServerReport.ReportPath = "/Reports/BILL_Entry";

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            ReportViewer1.Attributes.Add("style", "overflow:auto;");
            // Response.Write(" ccc" );
            //  Response.End();
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            //ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/FuelBillPendingPayment_ViewPrint";
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "FuelBillPendingPayment_ViewPrint";
            ReportViewer1.ServerReport.SetParameters(parameters);

        }
    }
}