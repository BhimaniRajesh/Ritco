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
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TripSheet : System.Web.UI.Page
{
    string contractid = "", custcode = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string logo = Session["logofile"].ToString();
            //string strImageUrl = "~/GUI/images/" + logo;

            custcode = Convert.ToString(Request.QueryString["Customer_Code"]);
            contractid = Convert.ToString(Request.QueryString["Contract_Code"]);

            ReportParameter[] parameters = new ReportParameter[4];

            parameters[0] = new ReportParameter("ContractID", contractid);
            parameters[1] = new ReportParameter("CustomerCode", custcode);
            parameters[2] = new ReportParameter("CustomerName", fn.Getcustomer(custcode));
            parameters[3] = new ReportParameter("ConnString", Convert.ToString(Session["SqlProvider"]));
            //parameters[3] = new ReportParameter("ConnString","Data Source=124.153.77.48;Initial Catalog=TMS_Net_35;UID=sa;pwd=tll@123$ecfy");

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportFleetPathPrefix + "SecondaryContractView";

            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            ReportViewer1.Style.Add("margin-bottom", "26px");
            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
