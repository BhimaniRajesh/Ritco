using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;

using System.Data;

public partial class GUI_UNI_Net_MIS_Sale_Profitibility_Result_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string zone = Request.QueryString["zone"].ToString();
            string zone_loc = Request.QueryString["zone_loc"].ToString();
            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string datetype = Request.QueryString["datetype"].ToString();
            string RPTTYP = Request.QueryString["RPTTYP"].ToString();
            string paybas = Request.QueryString["paybas"].ToString();
            string mode= Request.QueryString["mode"].ToString();
            string sclass = Request.QueryString["sclass"].ToString();
            string businesstype = Request.QueryString["businesstype"].ToString();
            string custcode = Request.QueryString["custcode"].ToString();
            string RPTSUBTYP=Request.QueryString["RPTSUBTYP"].ToString();
            string docketlist = Request.QueryString["dockelist"].ToString();

            string dtFrom = fromdt;
            string dtTo = todt;
        
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("Zone", zone.ToString()));
            parameters.Add(new ReportParameter("ZoneLoc", zone_loc.ToString()));
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("DTTYP", datetype.ToString()));
            parameters.Add(new ReportParameter("RPTTY", RPTTYP.ToString()));
            parameters.Add(new ReportParameter("paybas", paybas.ToString()));
            parameters.Add(new ReportParameter("TRN", mode.ToString()));
            parameters.Add(new ReportParameter("BKGTYP", sclass.ToString()));
            parameters.Add(new ReportParameter("BUSTYP", businesstype.ToString()));
            parameters.Add(new ReportParameter("custcode", custcode.ToString()));
            parameters.Add(new ReportParameter("RPTTYSUB",RPTSUBTYP.ToString()));
            parameters.Add(new ReportParameter("DocketLsit", docketlist.ToString()));

           

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            if (RPTSUBTYP == "1")
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Salse Profitability";
    
            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Salse Profitability Summary";
            }
            
            ReportViewer1.ServerReport.SetParameters(parameters);
           
        }

        //added By Manisha 26/5/2014
		try{
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
		}
		catch{}


    }
}
