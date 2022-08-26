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
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using ApplicationManager;

public partial class GUI_Fleet_Reports_VendorBillReg : System.Web.UI.Page
{

    //string strCreatedFrom = "";
    //string strCreatedTo = "";
    //string strStatus = "";
    //string strVendorType = "";
    //string strVendorName = "";
    //string strCompany = "";
    //string strAgingAnlysisB = "";
    //string strAgingAnlysisD = "";
    //string strDtF = "";
    //string strDtT = "";
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
    //        if (Request.QueryString["CreatedFrom"] != null)
    //        {
    //            strCreatedFrom =  DTM.ConvertToDate(Request.QueryString["CreatedFrom"].ToString()).ToString("dd MMM yyyy"); 
    //        }
            
    //        if (Request.QueryString["CreatedTo"] != null)
    //        {
    //            strCreatedTo = DTM.ConvertToDate(Request.QueryString["CreatedTo"].ToString()).ToString("dd MMM yyyy"); 
    //        }
    //        if (Request.QueryString["Status"] != null)
    //        {
    //            strStatus = Request.QueryString["Status"].ToString(); 
    //        }
    //        if (Request.QueryString["VendorType"] != null)
    //        {
    //            strVendorType = Request.QueryString["VendorType"].ToString(); 
    //        }
    //        if (Request.QueryString["VendorName"] != null)
    //        {
    //            strVendorName = Request.QueryString["VendorName"].ToString(); 
    //        }
    //        if (Request.QueryString["Company"] != null)
    //        {
    //            strCompany = Request.QueryString["Company"].ToString();
    //        }
    //        if (Request.QueryString["AgingAnlysisB"] != null)
    //        {
    //            strAgingAnlysisB = Request.QueryString["AgingAnlysisB"].ToString(); 
    //        }
    //        if (Request.QueryString["AgingAnlysisD"] != null)
    //        {
    //            strAgingAnlysisD = Request.QueryString["AgingAnlysisD"].ToString(); 
    //        }
    //        if (Request.QueryString["DtF"] != null)
    //        {
    //            strDtF = Request.QueryString["DtF"].ToString(); 
    //        }
    //        if (Request.QueryString["DtT"] != null)
    //        {
    //            strDtT = Request.QueryString["DtT"].ToString();
    //        }
           
    //        //BindGrid();
    //        //GridView1.Visible = false; 
            
    //        LoadReport();
        }
   // }
    //public void LoadReport()
    //{
    //    if (strStatus == "ALL")
    //    {
    //        strStatus = "";
    //    }
    //    if (strVendorType == "0")
    //    {
    //        strVendorType = "";
    //    }
    //    if (strVendorName == "0")
    //    {
    //        strVendorName = "";
    //    }
      
    //    if (strCreatedFrom == "" ){strCreatedFrom = null;}
    //    if (strCreatedTo == "" ){strCreatedTo = null;}
    //    if (strStatus == "" ){strStatus = null;}
    //    if (strVendorType == "" ){strVendorType = null;}
    //    if (strVendorName == "") { strVendorName = null; }
    //    if (strCompany == "") { strCompany = null; }

        string strConnStr = Convert.ToString(Session["SqlProvider"]);
        ReportViewer1.Visible = true;
        
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath =  ReportServiceUtilities.ReportFleetPathPrefix + "VendorBillRegister";
        ReportParameter[] parameters = new ReportParameter[7];
        parameters[0] = new ReportParameter("CreatedFrom", Request.QueryString["CreatedFrom"].ToString());
        parameters[1] = new ReportParameter("CreatedTo", Request.QueryString["CreatedTo"].ToString());
        parameters[2] = new ReportParameter("Status", Request.QueryString["Status"].ToString());
        parameters[3] = new ReportParameter("VendorType", Request.QueryString["VendorType"].ToString());
        parameters[4] = new ReportParameter("VendorName", Request.QueryString["VendorName"].ToString());
        parameters[5] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
        parameters[6] = new ReportParameter("ConnString", Session["SqlProvider"].ToString());

        
        ReportViewer1.ServerReport.SetParameters(parameters);
        ReportViewer1.Style.Add("margin-bottom", "26px");
        ReportViewer1.ServerReport.Refresh();
    }
}
