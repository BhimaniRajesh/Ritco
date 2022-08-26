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
using Microsoft.Reporting.WebForms;

public partial class FuelVendorBillRegisterResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Session["SqlProvider"].ToString();

            ReportViewer1.Visible = true;

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;


            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "FueVendorBillRegister";

            ReportParameter[] parameters = new ReportParameter[7];
            parameters[0] = new ReportParameter("VENDORNAME", cls_FuelVendorBillRegister.strVENDORNAME.ToString().Trim());
            parameters[1] = new ReportParameter("FROMDT", cls_FuelVendorBillRegister.strFROMDT.ToString().Trim());
            parameters[2] = new ReportParameter("TODT", cls_FuelVendorBillRegister.strTODT.ToString().Trim());
            parameters[3] = new ReportParameter("DOCU_TYPE", cls_FuelVendorBillRegister.strDOCU_TYPE.ToString().Trim());
            parameters[4] = new ReportParameter("TMP", cls_FuelVendorBillRegister.strTMP.ToString().Trim());
            parameters[5] = new ReportParameter("Company_Code", cls_FuelVendorBillRegister.strCompany.ToString().Trim());
            parameters[6] = new ReportParameter("ConnString", strConnStr);
            ReportViewer1.Style.Add("margin-bottom","26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
           // UpdatePanel1.Update();
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("FuelVendorBillRegister.aspx");
    }
}
