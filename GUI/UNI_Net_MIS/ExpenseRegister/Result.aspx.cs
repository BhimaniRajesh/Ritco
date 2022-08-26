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

public partial class GUI_UNI_NET_MIS_ExpenseRegister_Result : System.Web.UI.Page
{
    public static string dkt_call;
    string RPT_no = "";
    string RTP = "", RTP_DT_str = "";
    string RO_EMP = "";
    double RO_LOGIN = 0;
    double TOTRO_LOGIN = 0;
    int ij = 1;
    string RO, LO, toRO, toLO, fromdt, todt, daysfrom, daysto, RPT;
    string dateselection, MAxStr_VAL, MAxSTR_LV, MAxStr_VAL_to, MAxSTR_LV_to, DocType,Mode,Route,Vendor,st_Docnolist,Status,type="";

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
        DocType = Request.QueryString["DocType"].ToString();
        Mode = Request.QueryString["Mode"].ToString();
        Route = Request.QueryString["Route"].ToString();
        Vendor = Request.QueryString["Vendor"].ToString();
        Status = Request.QueryString["Status"].ToString();
        st_Docnolist = Request.QueryString["DocList"].ToString();
        type = Request.QueryString["vendtype"].ToString();
        
        if (Status == "")
        {
            Status = "ALL";
        }

        if (!IsPostBack)
        {
            
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL_to ));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV_to));
            parameters.Add(new ReportParameter("location_to", MAxStr_VAL));
            parameters.Add(new ReportParameter("locLevel_to",MAxSTR_LV ));
            parameters.Add(new ReportParameter("Fromdt", fromdt));
            parameters.Add(new ReportParameter("todt", todt));
            parameters.Add(new ReportParameter("trnmod", Mode));
            parameters.Add(new ReportParameter("custcode", Vendor));
            parameters.Add(new ReportParameter("docklist", st_Docnolist));
            parameters.Add(new ReportParameter("Select_view", ""));
            parameters.Add(new ReportParameter("status", Status));
            parameters.Add(new ReportParameter("Doc_typ", DocType));
            parameters.Add(new ReportParameter("type",type.ToString()));

            //string str = "EXEC webx_ExpenseRegister_SSRS '" + fromdt + "','" + todt + "','" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + Mode + "','" + type + "','" + Status + "','" + Vendor + "','" + st_Docnolist + "','','" + DocType + "'";
            //Response.Write(str);
                
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            if (DocType == "THC")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/EXP_REG_THC";
               // ReportViewer1.ServerReport.ReportPath = "/Reports/EXP_REG_THC";
            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/EXP_REG_PDC";
              //  ReportViewer1.ServerReport.ReportPath = "/Reports/EXP_REG_PDC";
            }

            ReportViewer1.ShowParameterPrompts = false;

            string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

            if (userAgent.Contains("MSIE 7.0") || userAgent.Contains("MSIE 8.0"))
            {
                //ReportViewer1.Style.Add("margin-bottom", "26px");
                ReportViewer1.Attributes.Add("style", "overflow:auto;");
            }
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 23/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  
    }
}
