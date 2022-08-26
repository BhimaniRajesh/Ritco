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
using System.Data.SqlClient;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_VehicleLogBookReportResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);


            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;

            ////ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "VehicleLogBookReport";
            //ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "DieselCardTran";

            //List<ReportParameter> parameters = new List<ReportParameter>();
            //parameters.Add(new ReportParameter("TripSheetNo", cls_VehicleLogEntry.strTRIPSHEETNO));
            //parameters.Add(new ReportParameter("Customer", cls_VehicleLogEntry.strCUSTOMER));
            //parameters.Add(new ReportParameter("VEHNO", cls_VehicleLogEntry.strVEHNO));
            //parameters.Add(new ReportParameter("Category", cls_VehicleLogEntry.strCATEGORY));
            //parameters.Add(new ReportParameter("Product", cls_VehicleLogEntry.strPRODUCT));
            //parameters.Add(new ReportParameter("StartDt_From", cls_VehicleLogEntry.strStartDt_From));
            //parameters.Add(new ReportParameter("EndDt_To", cls_VehicleLogEntry.strEndDt_To));
            //parameters.Add(new ReportParameter("Company_Name", cls_VehicleLogEntry.strCompany));
            //parameters.Add(new ReportParameter("ConnString", strConnStr));

            ReportParameter[] parameters = new ReportParameter[9];
            parameters[0] = new ReportParameter("TripSheetNo", cls_VehicleLogEntry.strTRIPSHEETNO.ToString().Trim());
            parameters[1] = new ReportParameter("Customer", cls_VehicleLogEntry.strCUSTOMER.ToString().Trim());
            parameters[2] = new ReportParameter("VEHNO", cls_VehicleLogEntry.strVEHNO.ToString().Trim());
            parameters[3] = new ReportParameter("Category", cls_VehicleLogEntry.strCATEGORY.ToString().Trim());
            parameters[4] = new ReportParameter("Product", cls_VehicleLogEntry.strPRODUCT.ToString().Trim());
            parameters[5] = new ReportParameter("StartDt_From", cls_VehicleLogEntry.strStartDt_From.ToString().Trim());
            parameters[6] = new ReportParameter("EndDt_To", cls_VehicleLogEntry.strEndDt_To.ToString().Trim());
            parameters[7] = new ReportParameter("Company_Name", cls_VehicleLogEntry.strCompany.ToString().Trim());
            parameters[8] = new ReportParameter("ConnString", strConnStr);

            //ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("VehicleLogBookReport.aspx");
    }
}
