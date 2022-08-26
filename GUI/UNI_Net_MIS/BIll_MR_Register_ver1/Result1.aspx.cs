using System;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
using System.Web;
public partial class GUI_UNI_Net_MIS_BIll_MR_Register_ver1_Result1 : System.Web.UI.Page
{
    public Dictionary<string, string> QueryStringDictionary;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            QueryStringDictionary = (Dictionary<string, string>)HttpContext.Current.Session[Request.QueryString["guid"].ToString()];


            string BM_TYP = QueryStringDictionary["BM_TYP"].ToString();
            string dtFrom = QueryStringDictionary["fromdt"].ToString();
            string dtTo = QueryStringDictionary["todt"].ToString();
            string MAxStr_VAL = QueryStringDictionary["MAxStr_VAL"].ToString();
            string MAxSTR_LV = QueryStringDictionary["MAxSTR_LV"].ToString();
            string RPT = QueryStringDictionary["RPT"].ToString();
            //string strmonths = QueryStringDictionary["strmonths"].ToString();
            string DT_TYPE = QueryStringDictionary["DT_TYPE"].ToString();

            string st_cust_vend = QueryStringDictionary["st_cust_vend"].ToString();

            string BM_STATUS = QueryStringDictionary["BM_STATUS"].ToString();
            //string CS_CHQ = QueryStringDictionary["CS_CHQ"].ToString();
            string AMT_G_THAN = QueryStringDictionary["AMT_G_THAN"].ToString();
            string OV_DYS = QueryStringDictionary["OV_DYS"].ToString();
            string BILLNO_list = QueryStringDictionary["BILLNO_list"].ToString();

            string MANBNOLIST = QueryStringDictionary["MANBNOLIST"].ToString();
            string DKTSNOLIST = QueryStringDictionary["DKTSNOLIST"].ToString();
            string DKTST = QueryStringDictionary["DKTST"].ToString();
            string CS_CHQ = QueryStringDictionary["CS_CHQ"].ToString();
            string M_L_TYP = QueryStringDictionary["M_L_TYP"].ToString();
            string MRSNOLIST = QueryStringDictionary["MRSNOLIST"].ToString();
            string TYPDET = QueryStringDictionary["TYPDET"].ToString();

            string Select_Text = QueryStringDictionary["Select_Text"].ToString();
            string Select_list = QueryStringDictionary["Select_list"].ToString();

            //string BM_TYP = Request.QueryString["BM_TYP"].ToString();
            //string dtFrom = Request.QueryString["fromdt"].ToString();
            //string dtTo = Request.QueryString["todt"].ToString();
            //string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            //string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            //string RPT = Request.QueryString["RPT"].ToString();
            ////string strmonths = Request.QueryString["strmonths"].ToString();
            //string DT_TYPE = Request.QueryString["DT_TYPE"].ToString();

            //string st_cust_vend = Request.QueryString["st_cust_vend"].ToString();

            //string BM_STATUS = Request.QueryString["BM_STATUS"].ToString();
            ////string CS_CHQ = Request.QueryString["CS_CHQ"].ToString();
            //string AMT_G_THAN = Request.QueryString["AMT_G_THAN"].ToString();
            //string OV_DYS = Request.QueryString["OV_DYS"].ToString();
            //string BILLNO_list = Request.QueryString["BILLNO_list"].ToString();

            //string MANBNOLIST = Request.QueryString["MANBNOLIST"].ToString();
            //string DKTSNOLIST = Request.QueryString["DKTSNOLIST"].ToString();
            //string DKTST = Request.QueryString["DKTST"].ToString();
            //string CS_CHQ = Request.QueryString["CS_CHQ"].ToString();
            //string M_L_TYP = Request.QueryString["M_L_TYP"].ToString();
            //string MRSNOLIST = Request.QueryString["MRSNOLIST"].ToString();
            //string TYPDET = Request.QueryString["TYPDET"].ToString();

            //string Select_Text = Request.QueryString["Select_Text"].ToString();
            //string Select_list = Request.QueryString["Select_list"].ToString();



            if (st_cust_vend == "")
                st_cust_vend = "All";

            if (Select_list == "")
                Select_list = "BillNo";

            /*if(RPT=="B")
            {
                if (Select_list == "")
                    Select_list = "BillNo";
            }
            else
            {
                if (Select_list == "")
                    Select_list = "Mrsno";
            }*/

            string sql = "exec WebxNet_MR_Register_ver1 '"
                + dtFrom.ToString() + "','" + dtTo.ToString() + "','" + MAxStr_VAL.ToString() + "','"
                + MAxSTR_LV.ToString() + "','" + st_cust_vend.ToString() + "','" + BM_TYP.ToString() + "','"
                + BM_STATUS.ToString() + "','" + CS_CHQ.ToString() + "','" + DT_TYPE.ToString() + "','"
                + OV_DYS.ToString() + "','" + AMT_G_THAN.ToString() + "','" + Select_list.ToString() + "','"
                + BILLNO_list.ToString() + "','" + MRSNOLIST.ToString() + "','" + MANBNOLIST.ToString() + "','"
                + DKTSNOLIST.ToString() + "','" + TYPDET.ToString() + "'";

            //Response.Write("sql : " + sql);

            List<ReportParameter> parameters = new List<ReportParameter>();
            // parameters.Add(new ReportParameter("ConnectionStr", SessionUtilities.ConnectionString.Trim()));
            parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("todt", dtTo.ToString()));
            parameters.Add(new ReportParameter("Select_LIST", Select_list.ToString()));
            parameters.Add(new ReportParameter("CUSTCD", st_cust_vend.ToString()));
            parameters.Add(new ReportParameter("TYPDET", TYPDET.ToString()));
            parameters.Add(new ReportParameter("DTTYP", DT_TYPE.ToString()));
            parameters.Add(new ReportParameter("Bill_STATuS", BM_STATUS.ToString()));

            if (BM_TYP != "All")
                parameters.Add(new ReportParameter("Bill_TYP", BM_TYP.ToString()));

            parameters.Add(new ReportParameter("Bill_TYP_CL", CS_CHQ.ToString()));
            parameters.Add(new ReportParameter("bill_TYP_LIST", M_L_TYP.ToString()));
            parameters.Add(new ReportParameter("OVDAYS", OV_DYS.ToString()));
            parameters.Add(new ReportParameter("AMT", AMT_G_THAN.ToString()));
            parameters.Add(new ReportParameter("BillNO_LIST", BILLNO_list.ToString()));
            parameters.Add(new ReportParameter("MR_LIST", MRSNOLIST.ToString()));
            parameters.Add(new ReportParameter("MANBillNO_LIST", MANBNOLIST.ToString()));
            parameters.Add(new ReportParameter("DOCKNO_LIST", DKTSNOLIST.ToString()));
            //parameters.Add(new ReportParameter("ASONDT", ""));
            //parameters.Add(new ReportParameter("ASONDT_to", ""));
            //parameters.Add(new ReportParameter("AGE1", ""));
            //parameters.Add(new ReportParameter("AGE2", ""));
            parameters.Add(new ReportParameter("RPTBRK", "1"));


            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            if (RPT == "B")
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Bill_Register_Ritco";
            else
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/MR_Register";


            ReportViewer1.Style.Add("margin-bottom", "26");

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
    }
}