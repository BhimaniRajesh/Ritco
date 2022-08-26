using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;
public partial class GUI_UNI_Net_MIS_BIll_MR_Register_ver2_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string BM_TYP = Request.QueryString["BM_TYP"].ToString();


            string dtFrom = Request.QueryString["fromdt"].ToString();
            string dtTo = Request.QueryString["todt"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            //string RPT = Request.QueryString["RPT"].ToString();
            //string strmonths = Request.QueryString["strmonths"].ToString();
            string DT_TYPE = Request.QueryString["DT_TYPE"].ToString();

            string st_cust_vend = Request.QueryString["st_cust_vend"].ToString();

            string BM_STATUS = Request.QueryString["BM_STATUS"].ToString();
            //string CS_CHQ = Request.QueryString["CS_CHQ"].ToString();
            string AMT_G_THAN = Request.QueryString["AMT_G_THAN"].ToString();
            string OV_DYS = Request.QueryString["OV_DYS"].ToString();
            string BILLNO_list = Request.QueryString["BILLNO_list"].ToString();

            string MANBNOLIST = Request.QueryString["MANBNOLIST"].ToString();
            string DKTSNOLIST = Request.QueryString["DKTSNOLIST"].ToString();
            string DKTST = Request.QueryString["DKTST"].ToString();
            string CS_CHQ = Request.QueryString["CS_CHQ"].ToString();
            string M_L_TYP = Request.QueryString["M_L_TYP"].ToString();
            string MRSNOLIST = Request.QueryString["MRSNOLIST"].ToString();
            string TYPDET = Request.QueryString["TYPDET"].ToString();
            string RenderType = Request.QueryString["RenderType"].ToString();
            //string Select_Text = Request.QueryString["Select_Text"].ToString();


            string Select_list = Session[Request.QueryString["Select_list"]].ToString(); 
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

            //string sql = "exec WebxNet_MR_Register_ver1 '"
            //    + dtFrom.ToString() + "','" + dtTo.ToString() + "','" + MAxStr_VAL.ToString() + "','"
            //    + MAxSTR_LV.ToString() + "','" + st_cust_vend.ToString() + "','" + BM_TYP.ToString() + "','"
            //    + BM_STATUS.ToString() + "','" + CS_CHQ.ToString() + "','" + DT_TYPE.ToString() + "','"
            //    + OV_DYS.ToString() + "','" + AMT_G_THAN.ToString() + "','" + Select_list.ToString() + "','"
            //    + BILLNO_list.ToString() + "','" + MRSNOLIST.ToString() + "','" + MANBNOLIST.ToString() + "','"
            //    + DKTSNOLIST.ToString() + "','" + TYPDET.ToString() + "'";

            //Response.Write("sql : " + sql);
            if (RenderType != "3")
            {
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
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/Bill_Register_Ver2";

                string userAgent = Request.ServerVariables.Get("HTTP_USER_AGENT");

                if (userAgent.Contains("MSIE 7.0"))
                {
                    //ReportViewer1.Style.Add("margin-bottom", "26px");
                    ReportViewer1.Attributes.Add("style", "overflow:auto;");
                }
                ReportViewer1.ServerReport.SetParameters(parameters);
            }
            else
            {
                var conn = new SqlConnection(Convert.ToString(Session["SqlProvider"]).Trim());
                var ds = new DataSet();
                try
                {
                    if (conn.State != ConnectionState.Open) { conn.Open(); }
                    var cmd = new SqlCommand("WebxNet_BILL_Register_ver2", conn) { CommandType = CommandType.StoredProcedure };

                    cmd.Parameters.Add(new SqlParameter("@location", MAxStr_VAL.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@locLevel", MAxSTR_LV.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@fromdt", dtFrom.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@todt", dtTo.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@Select_LIST", Select_list.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@CUSTCD", st_cust_vend.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@TYPDET", TYPDET.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@DTTYP", DT_TYPE.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@Bill_STATuS", BM_STATUS.ToString()));
                    if (BM_TYP != "All")
                        cmd.Parameters.Add(new SqlParameter("@Bill_TYP", BM_TYP.ToString()));
                    else
                        cmd.Parameters.Add(new SqlParameter("@Bill_TYP", "All"));
                    cmd.Parameters.Add(new SqlParameter("@Bill_TYP_CL", CS_CHQ.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@bill_TYP_LIST", M_L_TYP.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@OVDAYS", OV_DYS.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@AMT", AMT_G_THAN.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@BillNO_LIST", BILLNO_list.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@MR_LIST", MRSNOLIST.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@MANBillNO_LIST", MANBNOLIST.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@DOCKNO_LIST", DKTSNOLIST.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@ASONDT", dtFrom.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@ASONDT_to", dtTo.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@AGE1", ""));
                    cmd.Parameters.Add(new SqlParameter("@AGE2", ""));
                    //cmd.Parameters.Add(new SqlParameter("@RPTBRK", "1"));

                    cmd.CommandTimeout = 10800;
                    var da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    if (conn.State != ConnectionState.Closed) { conn.Close(); }
                }
                    catch
                {
                    if (conn.State != ConnectionState.Closed) { conn.Close(); }
                }
                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ExportUtils.ExportToCSV(ds.Tables[0], "Sales Register Report");
                    }
                }
            }
        }

        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
  


    }
}
