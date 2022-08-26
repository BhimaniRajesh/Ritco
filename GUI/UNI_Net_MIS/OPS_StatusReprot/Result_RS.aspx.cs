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
public partial class GUI_UNI_Net_MIS_OPS_StatusReprot_Result_RS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

            string DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            string st_status = Request.QueryString["st_status"].ToString();
            string str_status = Request.QueryString["str_status"].ToString();

            string st_status_sub = Request.QueryString["st_status_sub"].ToString();
            string str_status_sub = Request.QueryString["str_status_sub"].ToString();
            string strdays = Request.QueryString["strdays"].ToString();

            string PGNO = Request.QueryString["PGNO"].ToString();
            string PGSIZE = Request.QueryString["Psize"].ToString();

            string DocketLsit = "", strcustcd = "";
            DocketLsit = Request.QueryString["DocketLsit"].ToString();
            strcustcd = Request.QueryString["strcustcd"].ToString();
            if (strcustcd == "")
                strcustcd = "All";
            if (DocketLsit == "")
                DocketLsit = "All";



            string st_paybasis = Request.QueryString["st_paybasis"].ToString();
            string st_trnmod = Request.QueryString["st_trnmod"].ToString();
            string st_type = Request.QueryString["st_type"].ToString();
            string st_busttype = Request.QueryString["st_busttype"].ToString();
            string str_paybasis = Request.QueryString["str_paybasis"].ToString();
            string str_trnmod = Request.QueryString["str_trnmod"].ToString();
            string str_busttype = Request.QueryString["str_busttype"].ToString();
            string str_type = Request.QueryString["str_type"].ToString();
            string DTTYPE = Request.QueryString["DTTYPE"].ToString();

            LBLDATE.Text = dtFrom.ToString() + " - " + dtTo.ToString();
            LBLBRANCH.Text = MAxStr_VAL;
            lblPaybasis.Text = str_paybasis;
            lblmode.Text = str_trnmod;
            lblBKGTYP.Text = str_type;
            Label1.Text = str_busttype;
            lblStatus.Text = str_status;

            if (st_status_sub != "All")
                lblStatus.Text = str_status + " - " + str_status_sub;
            if (strdays != "All")
                lblStatus.Text = str_status + " - " + str_status_sub + " - " + strdays + " Days";

            string sqlQuery = "exec WebxNet_OPSSTATUSREport '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + dtFrom + "','" + dtTo + "','" + DTTYPE + "','1','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + DocketLsit + "','" + st_status + "','" + st_status_sub + "','" + strdays + "'," + PGNO + "," + PGSIZE + "";
            // Response.Write("<br><br><br> abcd :   " + sqlQuery);


            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("location_to", "All"));
            parameters.Add(new ReportParameter("locLevel_to", "1"));
            parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("LOCTYP", DTTYPE.ToString()));
            parameters.Add(new ReportParameter("DTTYP", "1"));
            parameters.Add(new ReportParameter("paybas", st_paybasis.ToString()));
            parameters.Add(new ReportParameter("TRN", st_trnmod.ToString()));
            parameters.Add(new ReportParameter("BKGTYP", st_type.ToString()));
            parameters.Add(new ReportParameter("BUSTYP", st_busttype.ToString()));
            parameters.Add(new ReportParameter("custcode", strcustcd));
            parameters.Add(new ReportParameter("STTYPE", "0"));
            //parameters.Add(new ReportParameter("SelectLsit", select_list.ToString()));
            //parameters.Add(new ReportParameter("SelectView", selectView.ToString()));
            //parameters.Add(new ReportParameter("Status", st_status.ToString()));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
            // ReportViewer1.ServerReport.ReportPath = "/Report Project1/OPS_Performance";

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}
