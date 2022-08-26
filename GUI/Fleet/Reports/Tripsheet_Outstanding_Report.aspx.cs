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

public partial class GUI_Fleet_Reports_Tripsheet_Outstanding_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string strConnStr = Convert.ToString(Session["SqlProvider"]);

            ReportViewer1.Visible = true;
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "TripsheetOSRegister";


            //List<ReportParameter> parameters = new List<ReportParameter>();
            //parameters.Add(new ReportParameter("start_dt", Cls_Report_Tripsheet_Outstanding.strstart_dt));

            //parameters.Add(new ReportParameter("End_dt", Cls_Report_Tripsheet_Outstanding.strEnd_dt));
            //parameters.Add(new ReportParameter("Custnm", Cls_Report_Tripsheet_Outstanding.strCustnm));
            //parameters.Add(new ReportParameter("From_City", Cls_Report_Tripsheet_Outstanding.strFrom_City));
            //parameters.Add(new ReportParameter("To_City", Cls_Report_Tripsheet_Outstanding.strTo_City));
            //parameters.Add(new ReportParameter("Company_Code", Cls_Report_Tripsheet_Outstanding.strCompany));
            //parameters.Add(new ReportParameter("ConnString", strConnStr));


            ReportParameter[] parameters = new ReportParameter[7];
            parameters[0] = new ReportParameter("start_dt", Request.QueryString["start_dt"].ToString());
            parameters[1] = new ReportParameter("End_dt", Request.QueryString["End_dt"].ToString());
            parameters[2] = new ReportParameter("Custnm", Request.QueryString["Custnm"].ToString());
            parameters[3] = new ReportParameter("From_City", Request.QueryString["From_City"].ToString());
            parameters[4] = new ReportParameter("To_City", Request.QueryString["To_City"].ToString());
            parameters[5] = new ReportParameter("Company_Code", Request.QueryString["Company_Code"].ToString());
            parameters[6] = new ReportParameter("ConnString", strConnStr);  


            ReportViewer1.ServerReport.SetParameters(parameters);
            ReportViewer1.ServerReport.Refresh();
            //UpdatePanel1.Update();

        }
    }
}
