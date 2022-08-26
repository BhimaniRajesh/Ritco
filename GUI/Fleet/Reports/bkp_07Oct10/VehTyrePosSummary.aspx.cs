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

public partial class GUI_Fleet_Reports_VehTyrePosSummary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
   
        if (!IsPostBack)
        {
            img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string strVEH_NO="";
        string strCard_No="";
        string[] VEHNO = txtVehNo.Text.Split(',');

        for (int i = 0; i < VEHNO.Length - 1; i++)
        {
            if (strVEH_NO == "")
            {
                strVEH_NO = "'" + VEHNO[i] + "'";
            }
            else
            {
                strVEH_NO = strVEH_NO + ",'" + VEHNO[i] + "'";
            }
        }
      
        if (strVEH_NO != "") { strVEH_NO = "(" + strVEH_NO + ")"; }
        ReportViewer1.Visible = true;


        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

        //ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        //ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        //ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ////ReportViewer1.ServerReport.ReportServerUrl = "http://121.241.155.241/ReportServer_ver1";

        //ReportViewer1.ServerReport.ReportPath = "/Report Project1/DieselCardTran";
        //ReportParameter[] parameters = new ReportParameter[4];
        //parameters[0] = new ReportParameter("VehNo", strVEH_NO.ToString().Trim());
        //parameters[1] = new ReportParameter("CardNo", strCard_No.ToString().Trim());
        //parameters[2] = new ReportParameter("VSlipDt_From", txtDateFrom.Text.ToString().Trim());
        //parameters[3] = new ReportParameter("VSlipDt_To", txtDateTo.Text.ToString().Trim());
        //ReportViewer1.ServerReport.SetParameters(parameters);
        //ReportViewer1.ServerReport.Refresh();
        //UpdatePanel1.Update();
    }


}
