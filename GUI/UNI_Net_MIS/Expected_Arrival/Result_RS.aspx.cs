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
using System.Globalization;
using System.Data.SqlClient;
using System.Reflection;

public partial class GUI_UNI_NET_MIS_Expected_Arrival_Result_RS : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    string RTP = "", RTP_DT_str = "";
    string RO_EMP = "";
    double RO_LOGIN = 0;
    double TOTRO_LOGIN = 0;
    int ij = 1;
    string RO, LO, toRO, toLO, fromdt, todt, daysfrom, daysto, RPT;
    string dateselection, MAxStr_VAL, MAxSTR_LV, MAxStr_VAL_to, MAxSTR_LV_to, DateType, Status;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        fromdt = Request.QueryString["dtFrom"].ToString();
        todt = Request.QueryString["dtTo"].ToString();
        MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
        MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
        MAxStr_VAL_to = Request.QueryString["MAxStr_VAL_to"].ToString();
        MAxSTR_LV_to = Request.QueryString["MAxSTR_LV_to"].ToString();
        DateType = Request.QueryString["DTTYPE"].ToString();
        Status = Request.QueryString["Status"].ToString();

        if (Status == "")
        {
            Status = "ALL";
        }
       
        if (!IsPostBack)
        {
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV));
            parameters.Add(new ReportParameter("location_to", MAxStr_VAL_to));
            parameters.Add(new ReportParameter("locLevel_to", MAxSTR_LV_to));
            parameters.Add(new ReportParameter("Fromdt", fromdt));
            parameters.Add(new ReportParameter("todt", todt));
            parameters.Add(new ReportParameter("status", Status));
            parameters.Add(new ReportParameter("DTTYP", DateType));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/ExpectedArrival";
            ReportViewer1.ShowParameterPrompts = false;

            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
 

            //ReportViewer1.ServerReport.ReportPath = "/Report Project1/ExpectedArrival";

            
        }
        
    }
}
/*
 
         List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("RO", RO.ToString()));
            parameters.Add(new ReportParameter("LO", LO.ToString()));
            parameters.Add(new ReportParameter("fromdt", fromdt.ToString()));
            parameters.Add(new ReportParameter("todt", todt.ToString()));
            parameters.Add(new ReportParameter("DTTY", DTTY.ToString()));
            parameters.Add(new ReportParameter("str_vedcd", str_vedcd.ToString()));
            parameters.Add(new ReportParameter("status", status.ToString()));
            parameters.Add(new ReportParameter("st_columnlist", st_columnlist.ToString()));            

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
          
            ReportViewer1.ServerReport.ReportPath = "/Reports/DRS_Register";
            ReportViewer1.ShowParameterPrompts = false;
           
            ReportViewer1.Style.Add("margin-bottom", "26px"); 
            ReportViewer1.ServerReport.SetParameters(parameters);
 
 
 */
