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
using System.Reflection;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Reflection;
using Microsoft.Reporting.WebForms;
using WebX.Common;

public partial class GUI_UNI_Net_MIS_Sales_EXP_Register_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string select_list = Request.QueryString["select_list"].ToString();
            //  string select_Text = Request.QueryString["select_Text"].ToString();

            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();
            string MAxStr_VAL_to = Request.QueryString["MAxStr_VAL_to"].ToString();
            string MAxSTR_LV_to = Request.QueryString["MAxSTR_LV_to"].ToString();

            string selectView = Request.QueryString["selectView"].ToString();
            string st_status = Request.QueryString["st_status"].ToString();
            string str_status = Request.QueryString["str_status"].ToString();

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
            string renderType = Convert.ToString(Request.QueryString["renderType"]);
            //LBLDATE.Text = dtFrom.ToString() + " - " + dtTo.ToString();
            //LBLBRANCH.Text = MAxStr_VAL;
            //lblPaybasis.Text = str_paybasis;
            //lblmode.Text = str_trnmod;
            //lblBKGTYP.Text = str_type;
            //Label1.Text = str_busttype;
            //lblStatus.Text = str_status;

            //Response.Write(st_status);


            //string abcd = "exec WebxNet_Sales_Register '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + MAxStr_VAL_to + "','" + MAxSTR_LV_to + "','" + dtFrom + "',        '" + dtTo + "','" + DTTYPE + "','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "','" + DocketLsit + "',        '" + select_list + "','" + selectView + "','" + st_status + "'  ";
            //Response.Write("<br> st_status" + abcd);
            //Response.End();

            if (renderType == "3")
            {
                var conn = new SqlConnection(SessionUtilities.ConnectionString);
                var ds = new DataSet();
                try
                {
                    if (conn.State != ConnectionState.Open)
                    {
                        conn.Open();
                    }
                    var cmd = new SqlCommand("[dbo].[WebxNet_Sales_Register]", conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    cmd.Parameters.Add(new SqlParameter("@location", MAxStr_VAL.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@locLevel", MAxSTR_LV.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@location_to", MAxStr_VAL_to.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@locLevel_to", MAxSTR_LV_to.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@Fromdt", dtFrom.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@todt", dtTo.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@DTTYP", DTTYPE.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@paybas", st_paybasis.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@TRN", st_trnmod.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@BKGTYP", st_type.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@BUSTYP", st_busttype.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@custcode", strcustcd));
                    cmd.Parameters.Add(new SqlParameter("@DocketLsit", DocketLsit));
                    cmd.Parameters.Add(new SqlParameter("@SelectLsit", select_list.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@SelectView", selectView.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@Status", st_status.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@IsExport", "1"));                    
                    
                    cmd.CommandTimeout = 10800;
                    var da = new SqlDataAdapter(cmd);
                    da.Fill(ds, "Sales Expense Register");
                    if (conn.State != ConnectionState.Closed)
                    {
                        conn.Close();
                    }
                }
                catch
                {
                    if (conn.State != ConnectionState.Closed)
                    {
                        conn.Close();
                    }
                }
                ExportUtils.ExportToCSV(ds.Tables[0], "Sales Expense Register Report");

            }
            else
            {

                List<ReportParameter> parameters = new List<ReportParameter>();
                parameters.Add(new ReportParameter("location", MAxStr_VAL.ToString()));
                parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
                parameters.Add(new ReportParameter("location_to", MAxStr_VAL_to.ToString()));
                parameters.Add(new ReportParameter("locLevel_to", MAxSTR_LV_to.ToString()));
                parameters.Add(new ReportParameter("Fromdt", dtFrom.ToString()));
                parameters.Add(new ReportParameter("todt", dtTo.ToString()));
                parameters.Add(new ReportParameter("DTTYP", DTTYPE.ToString()));
                parameters.Add(new ReportParameter("paybas", st_paybasis.ToString()));
                parameters.Add(new ReportParameter("TRN", st_trnmod.ToString()));
                parameters.Add(new ReportParameter("BKGTYP", st_type.ToString()));
                parameters.Add(new ReportParameter("BUSTYP", st_busttype.ToString()));
                parameters.Add(new ReportParameter("custcode", strcustcd));
                parameters.Add(new ReportParameter("DocketLsit", DocketLsit));
                parameters.Add(new ReportParameter("SelectLsit", select_list.ToString()));
                parameters.Add(new ReportParameter("SelectView", selectView.ToString()));
                parameters.Add(new ReportParameter("Status", st_status.ToString()));


                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/SalesRegister_Test";

                ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
                ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
                ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;
                ReportViewer1.ServerReport.SetParameters(parameters);
            }
        }
        //added By Manisha 22/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];
    }
}


