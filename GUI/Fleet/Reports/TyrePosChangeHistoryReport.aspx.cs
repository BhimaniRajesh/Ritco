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
using System.IO;
using System.Text;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;

public partial class GUI_Fleet_Reports_TyrePosChangeHistoryReport : System.Web.UI.Page
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

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TyrePosChangeHistory";

            ReportParameter[] parameters = new ReportParameter[5];
            parameters[0] = new ReportParameter("TyreNo", Request.QueryString["TyreNo"].ToString());
            parameters[1] = new ReportParameter("PosHisDateFrom", Request.QueryString["PosHisDateFrom"].ToString());
            parameters[2] = new ReportParameter("PosHisDateTo", Request.QueryString["PosHisDateTo"].ToString());
            parameters[3] = new ReportParameter("Company_Code",  Request.QueryString["Company_Code"].ToString());
            parameters[4] = new ReportParameter("ConnString", strConnStr);


            //List<ReportParameter> parameters = new List<ReportParameter>();
            //parameters.Add(new ReportParameter("TyreNo", Cls_TyrePosChangHistory.strTyreNo));

            //parameters.Add(new ReportParameter("PosHisDateFrom", Cls_TyrePosChangHistory.strPosHisDateFrom));
            //parameters.Add(new ReportParameter("PosHisDateTo", Cls_TyrePosChangHistory.strPosHisDateTo));
            //parameters.Add(new ReportParameter("Company_Code", Cls_TyrePosChangHistory.strCompany));
            //parameters.Add(new ReportParameter("ConnString", strConnStr));


            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            // UpdatePanel1.Update();
            
            //added By Manisha 21/5/2014
            DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];

        }
    }
}
