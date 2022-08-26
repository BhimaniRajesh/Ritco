using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;

public partial class GUI_UNI_NET_MIS_LRWiseCollection_Result : System.Web.UI.Page
{
    string strRegion = "", strLocation = "", strFromDate = "", strToDate = "", strDockNo = "";
    DateTime dt1,dt2;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            string strrightnow, strrightnow1;
            System.DateTime righnow = System.DateTime.Today;
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

            strrightnow = Request.QueryString["FromDate"].ToString();
            strrightnow1 = Request.QueryString["ToDate"].ToString();

            if (strrightnow == "")
            {
                strrightnow = righnow.ToString("dd/MM/yyyy");
            }

            if (strrightnow1 == "")
            {
                strrightnow1 = righnow.ToString("dd/MM/yyyy");
            }

            string[] strArrDtFrom = strrightnow.Split('/');
            string[] strArrDtTo = strrightnow1.Split('/');

            string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            string fromdt = dtFrom.ToString();
            string todt = dtTo.ToString();

            //strFromDate = Request.QueryString["FromDate"].ToString();
            //strToDate = Request.QueryString["ToDate"].ToString();
            strDockNo = Request.QueryString["dockno"].ToString();
           
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;  // Report Server URL
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/LRWiseCollectionRegister";

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("FromDate", fromdt));
            parameters.Add(new ReportParameter("ToDate", todt));
            parameters.Add(new ReportParameter("DockNo", strDockNo.Trim()));

            ReportViewer1.ServerReport.SetParameters(parameters);


            ReportViewer1.ServerReport.Refresh();
        }

        //added By Manisha 26/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

    }
}
