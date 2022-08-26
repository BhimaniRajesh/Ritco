using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_Billing_GST_BillGSTViewPrint_BillGST_ViewPrintVer1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strBillNo = "", strBillType = "";
        if (!IsPostBack && !IsCallback)
        {
            strBillNo = Request.QueryString["BillNo"].ToString();
            strBillType = Request.QueryString["BillType"].ToString();

            List<ReportParameter> parameters = new List<ReportParameter>();
            var str_Report_Name = "";
            if (strBillType == "F")
                str_Report_Name = "CustFreightGSTViewPrint";
            else
                str_Report_Name = "CustSuppGSTViewPrint";

            parameters.Add(new ReportParameter("BillNo", strBillNo));
            //parameters.Add(new ReportParameter("BillType", strBillType));

            rvBillGSTViewPrint.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            rvBillGSTViewPrint.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;  // Report Server URL
            rvBillGSTViewPrint.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();

            //rvBillGSTViewPrint.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            //rvBillGSTViewPrint.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            //ReportServiceUtilities.PrepareReport(rvBillGSTViewPrint, str_Report_Name, parameters);

            rvBillGSTViewPrint.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/" + str_Report_Name;
            rvBillGSTViewPrint.ServerReport.SetParameters(parameters);
            rvBillGSTViewPrint.ServerReport.Refresh();

        }
    }
}