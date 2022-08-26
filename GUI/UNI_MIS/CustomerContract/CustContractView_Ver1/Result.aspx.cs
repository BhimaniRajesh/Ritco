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
using System.Data.SqlClient;

public partial class GUI_UNI_Net_MIS_Voucher_register_Query : System.Web.UI.Page
{
    public static string dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        
        strrightnow=Request.QueryString["fromdt"];
        strrightnow1 = Request.QueryString["todt"];

        //strrightnow = righnow.ToString("dd/MM/yyyy");
        //strrightnow1 = righnow.ToString("dd/MM/yyyy");

        string CustCode = Request.QueryString["CustCode"];
        string ContractId = Request.QueryString["ContractId"];
        
        
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string con_type=Request.QueryString["con_type"];
        string Con_status  =Request.QueryString["Con_status"];
        string servicetype = Request.QueryString["servicetype"];
        string LocCode = Request.QueryString["LocCode"];

        List<ReportParameter> parameters = new List<ReportParameter>();
        parameters.Add(new ReportParameter("ConractDatetype", con_type.ToString()));
        parameters.Add(new ReportParameter("FromDate", dtFrom.ToString()));
        parameters.Add(new ReportParameter("ToDate", dtTo.ToString()));
        parameters.Add(new ReportParameter("ConStatus", Con_status.ToString()));
        parameters.Add(new ReportParameter("CustCode", CustCode.ToString()));
        parameters.Add(new ReportParameter("ContractId", ContractId.ToString()));
        parameters.Add(new ReportParameter("ContractType", servicetype.ToString()));
        parameters.Add(new ReportParameter("Location", LocCode.ToString()));
       
        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Contract_View";
        ReportViewer1.ServerReport.SetParameters(parameters);
    }


}
