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
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_UNI_Net_MIS_OutStanding_Amount_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strConnStr = Convert.ToString(Session["SqlProvider"]);



        ReportViewer1.Visible = true;



        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;


        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VendorBillAmount";

        List<ReportParameter> parameters = new List<ReportParameter>();
        parameters.Add(new ReportParameter("CurrDt", Cls_VendorBillAmount.strDate));

        string strVendorval = "";
        if (Cls_VendorBillAmount.strVendor == "")
        {
            strVendorval = "%%";
        }
        else
        {
            strVendorval = Cls_VendorBillAmount.strType;
        }
        parameters.Add(new ReportParameter("Vendor", strVendorval));
        parameters.Add(new ReportParameter("Type", Cls_VendorBillAmount.strType));
        parameters.Add(new ReportParameter("ConnString", strConnStr));
        parameters.Add(new ReportParameter("TempDt", Cls_VendorBillAmount.strTempDt));



        ReportViewer1.ServerReport.SetParameters(parameters);
        ReportViewer1.ServerReport.Refresh();
        //UpdatePanel1.Update();

    }
}
