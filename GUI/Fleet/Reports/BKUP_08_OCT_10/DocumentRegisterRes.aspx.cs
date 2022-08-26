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
using System.Reflection;

public partial class GUI_Fleet_Reports_DocumentRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Session["SqlProvider"].ToString();
            //string strjscript = "<script language='javascript' id='PopUpScript'>";
            //strjscript += "document.body.style.overflow = 'hidden';";
            //strjscript += "</script" + ">";

            //Page.RegisterStartupScript("a", strjscript);
            
            ReportViewer1.Visible = true;

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DocumentReg";
            ReportParameter[] parameters = new ReportParameter[20];
            //for show/hide columns
            cls_DocumentRegisterVariable a = new cls_DocumentRegisterVariable();

            parameters[0] = new ReportParameter("VehicleNumber", cls_DocumentRegisterVariable.strVehicleNumber.ToString().Trim());
            parameters[1] = new ReportParameter("VehicleType", cls_DocumentRegisterVariable.strVehicleType.ToString().Trim());
            parameters[2] = new ReportParameter("DocumentType", cls_DocumentRegisterVariable.strDocumentType.ToString().Trim());
            parameters[3] = new ReportParameter("DocumentDescription", cls_DocumentRegisterVariable.strDocumentDescription.ToString().Trim());
            parameters[4] = new ReportParameter("DocumentNumber", cls_DocumentRegisterVariable.strDocumentNumber.ToString().Trim());
            parameters[5] = new ReportParameter("RenewalAuturity", cls_DocumentRegisterVariable.strRenewalAuturity.ToString().Trim());
            parameters[6] = new ReportParameter("RenewalAuturityName", cls_DocumentRegisterVariable.strRenewalAuturityName.ToString().Trim());
            parameters[7] = new ReportParameter("StartDate", cls_DocumentRegisterVariable.strStartDate.ToString().Trim());
            parameters[8] = new ReportParameter("ExpiryDate", cls_DocumentRegisterVariable.strExpiryDate.ToString().Trim());
            parameters[9] = new ReportParameter("Cost", cls_DocumentRegisterVariable.strCost.ToString().Trim());
            parameters[10] = new ReportParameter("States", cls_DocumentRegisterVariable.strStates.ToString().Trim());
            parameters[11] = new ReportParameter("ScannedDocument", cls_DocumentRegisterVariable.strScannedDocument.ToString().Trim());

            //for search criteria
            parameters[12] = new ReportParameter("VEHNO", cls_DocumentRegisterVariable.strVEHNO.ToString().Trim());
            parameters[13] = new ReportParameter("DOC_TYPE", cls_DocumentRegisterVariable.strDOC_TYPE.ToString().Trim());
            parameters[14] = new ReportParameter("RENEW_AUTH", cls_DocumentRegisterVariable.strRENEW_AUTH.ToString().Trim());
            parameters[15] = new ReportParameter("EXP_STATUS", cls_DocumentRegisterVariable.strEXP_STATUS.ToString().Trim());
            parameters[16] = new ReportParameter("EXP_DT", cls_DocumentRegisterVariable.strEXP_DT.ToString().Trim());
            parameters[17] = new ReportParameter("OP_FORMAT", cls_DocumentRegisterVariable.strOP_FORMAT.ToString().Trim());
            parameters[18] = new ReportParameter("EXP_DT1", cls_DocumentRegisterVariable.strExDt.ToString().Trim());
           // parameters[19] = new ReportParameter("Company_Code", cls_DocumentRegisterVariable.strCompany.ToString().Trim());
            
            parameters[19] = new ReportParameter("ConnString", strConnStr);

            ReportViewer1.ServerReport.SetParameters(parameters);
            //ReportViewer1.DocumentMapCollapsed = true;
            //DisableUnwantedExportFormats();

            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.Style.Add("width", "100%");
            ReportViewer1.Style.Add("height", "90%");

            ReportViewer1.ServerReport.Refresh();


           // UpdatePanel1.Update();
        }
    }
    public void DisableUnwantedExportFormats()
    {
        foreach (RenderingExtension extension in ReportViewer1.ServerReport.ListRenderingExtensions())
        {
            if (extension.Name == "XML" || extension.Name == "IMAGE" || extension.Name == "MHTML" || extension.Name == "PDF")
            {
                ReflectivelySetVisibilityFalse(extension);
            }
        }
    }

    private void ReflectivelySetVisibilityFalse(RenderingExtension extension)
    {
        //FieldInfo info = extension.GetType().GetField("m_serverExtension", BindingFlags.NonPublic | BindingFlags.Instance);         //m_isVisible         //m_serverExtension

        //if (info != null)
        //{
        //    (info.GetValue(extension) as Microsoft.SqlServer.ReportingServices2005.Execution.Extension).Visible = false;
        //}
        //info.SetValue(extension, false);
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("DocumentRegister.aspx");
    }
}
