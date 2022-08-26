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
using System.Data.SqlClient;
public partial class GUI_UNI_Net_MIS_LocalCost_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

            string str_vendor = Request.QueryString["str_vendor"].ToString();
            string RPTTYP = Request.QueryString["RPTTYP"].ToString();
            string STR_DOCTYP = Request.QueryString["STR_DOCTYP"].ToString();
            string str_STATUS = Request.QueryString["str_STATUS"].ToString();
            string ST_DOCTYP = Request.QueryString["ST_DOCTYP"].ToString();
            string st_STATUS = Request.QueryString["str_STATUS"].ToString();
            string doclist = Request.QueryString["doclist"].ToString();


            if (str_vendor == " ")
                str_vendor = "All";
            else if (str_vendor == "")
                str_vendor = "All";

            if (doclist == " ")
                doclist = "All";
            else if (doclist == "")
                doclist = "All";

            LBLDATE.Text = dtFrom.ToString() + " - " + dtTo.ToString();
            LBLBRANCH.Text = MAxStr_VAL;

            SqlConnection Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim() + ";TimeOut=1000;");
             Conn.Open();

             string SELACC1 = "exec WebxNet_Get_DocName '" + str_vendor + "','V' ";
            SqlCommand cmd1 = new SqlCommand(SELACC1, Conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            string STR_ACCD1 = "";
            while (dr1.Read())
            {
                if (STR_ACCD1 == "")
                    STR_ACCD1 = dr1[0].ToString();
                else
                    STR_ACCD1 = STR_ACCD1 + "," + dr1[0].ToString();

            }
            dr1.Close();
            Conn.Close();

            if (STR_ACCD1 == "")
                lblPaybasis.Text = "All";
            else
                lblPaybasis.Text = STR_ACCD1;

            

            lblmode.Text = st_STATUS;
            if (ST_DOCTYP == "P")
                lblBKGTYP.Text = "PRS";
            else if (ST_DOCTYP == "D")
                lblBKGTYP.Text = "DRS";
            else
                lblBKGTYP.Text = "All";

            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("RPTTYP", RPTTYP.ToString()));
            parameters.Add(new ReportParameter("FILTER", str_STATUS.ToString()));
            parameters.Add(new ReportParameter("STTYPE", "All"));
            parameters.Add(new ReportParameter("VendCD", str_vendor.ToString()));
            parameters.Add(new ReportParameter("DocCD", STR_DOCTYP.ToString()));
            parameters.Add(new ReportParameter("DOCNOLIST", doclist.ToString()));
            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            if (RPTTYP == "1")
            {
                ReportViewer1.ServerReport.ReportPath = "/Report Project1/LocalCostReport_Register";

            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = "/Report Project1/LocalCostReport";
               // ReportViewer1.AsyncRendering = false;
            }
            

            ReportViewer1.ServerReport.SetParameters(parameters);
        }

        //if (ReportViewer1.ServerReport.ReportPath == "/Report Project1/LocalCostReport")
        //    ReportViewer1.AsyncRendering = false;
        //else
        //    ReportViewer1.AsyncRendering = true;

       
    }
}
