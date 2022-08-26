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
using System.Xml.Linq;
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_TyreRegister_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;


            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            //ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TyreRegister";
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("TyreNumber", Cls_Report_TyreRegister.strTYRE_NO));
            parameters.Add(new ReportParameter("Tyrecategory", Cls_Report_TyreRegister.strTYRE_CATEGORY));
            parameters.Add(new ReportParameter("Manufacturer", Cls_Report_TyreRegister.strTYRE_MFG));
            parameters.Add(new ReportParameter("Model", Cls_Report_TyreRegister.strTYRE_MODEL));
            parameters.Add(new ReportParameter("Size", Cls_Report_TyreRegister.strTYRE_SIZE));
            parameters.Add(new ReportParameter("Pattern", Cls_Report_TyreRegister.strTYRE_PATTERN));
            parameters.Add(new ReportParameter("Type", Cls_Report_TyreRegister.strTYRE_TYPE));
            parameters.Add(new ReportParameter("PurchaseDate", Cls_Report_TyreRegister.strPurchaseDate));
            parameters.Add(new ReportParameter("PurchasedAs", Cls_Report_TyreRegister.strPurchasedAs));
            parameters.Add(new ReportParameter("PurchaseKm", Cls_Report_TyreRegister.strPurchaseKm));
            parameters.Add(new ReportParameter("PurchaseCost", Cls_Report_TyreRegister.strPurchaseCost));
            parameters.Add(new ReportParameter("Status", Cls_Report_TyreRegister.strStatus));
            parameters.Add(new ReportParameter("VehicleNumber", Cls_Report_TyreRegister.strVehicleNumber));
            parameters.Add(new ReportParameter("PositionCategory", Cls_Report_TyreRegister.strPositionCategory));
            parameters.Add(new ReportParameter("PositionCode", Cls_Report_TyreRegister.strPositionCode));
            parameters.Add(new ReportParameter("Position", Cls_Report_TyreRegister.strPosition));
            parameters.Add(new ReportParameter("KmCount", Cls_Report_TyreRegister.strKmCount));
            parameters.Add(new ReportParameter("TOTALCOST", Cls_Report_TyreRegister.strTOTALCOST));
            parameters.Add(new ReportParameter("COSTKM", Cls_Report_TyreRegister.strCOSTKM));
            parameters.Add(new ReportParameter("PUR_DT_FROM", Cls_Report_TyreRegister.strPUR_DT_FROM));
            parameters.Add(new ReportParameter("PUR_DT_TO", Cls_Report_TyreRegister.strPUR_DT_TO));
            parameters.Add(new ReportParameter("TYRE_CATEGORY", Cls_Report_TyreRegister.strTYRE_CATEGORY));
            parameters.Add(new ReportParameter("TYRE_MFG", Cls_Report_TyreRegister.strTYRE_MFG));
            parameters.Add(new ReportParameter("TYRE_MODEL", Cls_Report_TyreRegister.strTYRE_MODEL));
            parameters.Add(new ReportParameter("TYRE_SIZE", Cls_Report_TyreRegister.strTYRE_SIZE));
            parameters.Add(new ReportParameter("TYRE_PATTERN", Cls_Report_TyreRegister.strTYRE_PATTERN));
            parameters.Add(new ReportParameter("TYRE_TYPE", Cls_Report_TyreRegister.strTYRE_TYPE));
            parameters.Add(new ReportParameter("NSD_FROM", Cls_Report_TyreRegister.strNSD_FROM));
            parameters.Add(new ReportParameter("NSD_TO", Cls_Report_TyreRegister.strNSD_TO));
            parameters.Add(new ReportParameter("KMRUN_FROM", Cls_Report_TyreRegister.strKMRUN_FROM));
            parameters.Add(new ReportParameter("KMRUN_TO", Cls_Report_TyreRegister.strKMRUN_TO));
            parameters.Add(new ReportParameter("TYRE_STATUS", Cls_Report_TyreRegister.strTYRE_STATUS));
            parameters.Add(new ReportParameter("VEH_NO", Cls_Report_TyreRegister.strVEH_NO));
            parameters.Add(new ReportParameter("TYRE_NO", Cls_Report_TyreRegister.strTYRE_NO));
            parameters.Add(new ReportParameter("Company_Code", Cls_Report_TyreRegister.strCompany));
            parameters.Add(new ReportParameter("ConnString", strConnStr));
            //parameters[34] = new ReportParameter("ConnString", "Data Source=localhost;Initial Catalog=TMS;UID=sa;pwd=Ecfy%_ptn");

            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    
        //added By Manisha 21/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  
    }
}
