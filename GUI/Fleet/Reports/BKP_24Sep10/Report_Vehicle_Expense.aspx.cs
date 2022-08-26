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

public partial class GUI_Fleet_Reports_Report_Vehicle_Expense : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
                string strConnStr = Convert.ToString(Session["SqlProvider"]);
        ReportViewer1.Visible = true;

        ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
        ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
        ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

        ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleExpense";

        List<ReportParameter> parameters = new List<ReportParameter>();
        parameters.Add(new ReportParameter("Start_dt", Cls_Report_Vehicle_Expense.strStart_dt));

        parameters.Add(new ReportParameter("End_dt", Cls_Report_Vehicle_Expense.strEnd_dt));
        parameters.Add(new ReportParameter("loccode", Cls_Report_Vehicle_Expense.strloccode));
        parameters.Add(new ReportParameter("VehicleNo", Cls_Report_Vehicle_Expense.strVehicleNo));
       
        parameters.Add(new ReportParameter("ConnString", strConnStr));

        ReportViewer1.ServerReport.SetParameters(parameters);
        ReportViewer1.Style.Add("margin-bottom", "26px");
        ReportViewer1.ServerReport.Refresh();
        //UpdatePanel1.Update();

    }
}
