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
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;     

public partial class GUI_UNI_Net_MIS_TDS_REgister_Result : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string Year = Session["FinYear"].ToString();

            string abc = Year.Substring(2, 2);           
            string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            string YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
            string yearSuffix = YearString;

            string Location = Request.QueryString["Location"].ToString();
            string loclevel = Request.QueryString["loclevel"].ToString();
            string fromdt = Request.QueryString["fromdt"].ToString();
            string todt = Request.QueryString["todt"].ToString();
            string RPT = Request.QueryString["RPT"].ToString();
            string RTP_DT_str = Request.QueryString["RTP_DT_str"].ToString();
            string cust_vendcd = Request.QueryString["cust_vendcd"].ToString();
            string cust_vendnm = Request.QueryString["cust_vendnm"].ToString();
            string acccd = Request.QueryString["acccd"].ToString();
            string accnm = Request.QueryString["accnm"].ToString();
            string VRnolist = Request.QueryString["VRnolist"].ToString();
            string amt_frm = Request.QueryString["amt_frm"].ToString();
            string amt_to = Request.QueryString["amt_to"].ToString();            

            if (amt_frm == "0.00")
                amt_frm = "0";

            if (amt_to == "0.00")
                amt_to = "0";

 string SQL_STR = "EXEC WebxNet_TDS_Register_SSRS '" + fromdt + "','" + todt + "','" + Location + "','" + loclevel + "','" + cust_vendcd + "','" + cust_vendnm + "','" + acccd + "','" + VRnolist + "','" + amt_frm + "','" + amt_to + "','" + RPT + "','" + yearSuffix + "'";
       
      // Response.Write("SQL_STR : " + SQL_STR);

            List<ReportParameter> parameters = new List<ReportParameter>();

            parameters.Add(new ReportParameter("fromdt", fromdt.ToString()));
            parameters.Add(new ReportParameter("todt", todt.ToString()));
            parameters.Add(new ReportParameter("Location", Location.ToString()));
            parameters.Add(new ReportParameter("loclevel", loclevel.ToString()));
            parameters.Add(new ReportParameter("Cust_vendcd", cust_vendcd.ToString()));
            parameters.Add(new ReportParameter("Cust_vendnm", cust_vendnm.ToString()));
            parameters.Add(new ReportParameter("AccList", acccd.ToString()));
            parameters.Add(new ReportParameter("VRNOLsit", VRnolist.ToString()));
            parameters.Add(new ReportParameter("amtfrm", amt_frm.ToString()));
            parameters.Add(new ReportParameter("amtto", amt_to.ToString()));
            parameters.Add(new ReportParameter("RPTTYP", RPT.ToString()));
            parameters.Add(new ReportParameter("finYear",yearSuffix.ToString()));


            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            ReportViewer1.ServerReport.ReportPath = "/Reports/TDS_Register";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
