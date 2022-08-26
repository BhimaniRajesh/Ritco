using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
using WebX.Common;

public partial class GUI_UNI_Net_MIS_DKT_Profi_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string dtFrom = Request.QueryString["dtFrom"].ToString();
            string dtTo = Request.QueryString["dtTo"].ToString();
            string MAxStr_VAL = Request.QueryString["MAxStr_VAL"].ToString();
            string MAxSTR_LV = Request.QueryString["MAxSTR_LV"].ToString();

            string DocketLsit = "", strcustcd = "";
            strcustcd = Request.QueryString["strcustcd"].ToString();
            if (strcustcd == "")
                strcustcd = "All";
            if (DocketLsit == "")
                DocketLsit = "All";

            string docknolist = Request.QueryString["docknolist"].ToString();
            string st_paybasis = Request.QueryString["st_paybasis"].ToString();
            string st_trnmod = Request.QueryString["st_trnmod"].ToString();
            string st_type = Request.QueryString["st_type"].ToString();
            string st_busttype = Request.QueryString["st_busttype"].ToString();
            string str_paybasis = Request.QueryString["str_paybasis"].ToString();
            string str_trnmod = Request.QueryString["str_trnmod"].ToString();
            string str_busttype = Request.QueryString["str_busttype"].ToString();
            string str_type = Request.QueryString["str_type"].ToString();
            string DT_TYPE = Request.QueryString["DT_TYPE"].ToString();

            string RPTTYP = Request.QueryString["RPTTYP"].ToString();
            string renderType = Convert.ToString(Request.QueryString["renderType"]);

            //LBLDATE.Text = dtFrom.ToString() + " - " + dtTo.ToString();
            //LBLBRANCH.Text = MAxStr_VAL;
            //lblPaybasis.Text = str_paybasis;
            //lblmode.Text = str_trnmod;
            //lblBKGTYP.Text = str_type;
            //Label1.Text = str_busttype;

            string SQL = " '" + MAxStr_VAL + "','" + MAxSTR_LV + "','" + dtFrom + "','" + dtTo + "','" + st_paybasis + "','" + st_trnmod + "','" + st_type + "','" + st_busttype + "','" + strcustcd + "' ";

            // Response.Write(" SQL..." + SQL);
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("Location", MAxStr_VAL.ToString()));
            parameters.Add(new ReportParameter("locLevel", MAxSTR_LV.ToString()));
            parameters.Add(new ReportParameter("fromdt", dtFrom.ToString()));
            parameters.Add(new ReportParameter("TODT", dtTo.ToString()));
            parameters.Add(new ReportParameter("LOCTYP", DT_TYPE.ToString()));

            parameters.Add(new ReportParameter("paybas", st_paybasis.ToString()));
            parameters.Add(new ReportParameter("TRN", st_trnmod.ToString()));
            parameters.Add(new ReportParameter("BKGTYP", st_type.ToString()));
            parameters.Add(new ReportParameter("BUSTYP", st_busttype.ToString()));
            parameters.Add(new ReportParameter("custcode", strcustcd));
            parameters.Add(new ReportParameter("dktnoList", docknolist));

            ReportViewer1.ServerReport.ReportServerCredentials = ReportServiceUtilities.GetReportCredentials();
            ReportViewer1.ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote;
            ReportViewer1.ServerReport.ReportServerUrl = ReportServiceUtilities.ReportServerURL;

            if (RPTTYP == "0")
            {
                if (renderType == "1")
                {
                    var conn = new SqlConnection(SessionUtilities.ConnectionString);
                    var ds = new DataSet();
                    try
                    {
                        if (conn.State != ConnectionState.Open)
                        {
                            conn.Open();
                        }
                        var cmd = new SqlCommand("[dbo].[WebxNet_Profitability_DKT_SUMMARY_CSV]", conn)
                        {
                            CommandType = CommandType.StoredProcedure
                        };

                        cmd.Parameters.Add(new SqlParameter("@Location", MAxStr_VAL.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@locLevel", MAxSTR_LV.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@fromdt", dtFrom.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@TODT", dtTo.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@paybas", st_paybasis.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@TRN", st_trnmod.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@BKGTYP", st_type.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@BUSTYP", st_busttype.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@custcode", strcustcd));
                        cmd.Parameters.Add(new SqlParameter("@dktnoList", DocketLsit));
                        cmd.Parameters.Add(new SqlParameter("@LOCTYP", DT_TYPE.ToString()));

                        cmd.CommandTimeout = 10800;
                        var da = new SqlDataAdapter(cmd);
                        da.Fill(ds, "Sales Profitability Summary");
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
                    ExportUtils.ExportToCSV(ds.Tables[0], "Sales Profitability Summary Report");
                }
                else
                {
                    ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix +"/DKT_Prof_Summary";
                    ReportViewer1.ShowParameterPrompts = true;
                }
            }
            else if (RPTTYP == "1")
            {
                if (renderType == "1")
                {
                    var conn = new SqlConnection(SessionUtilities.ConnectionString);
                    var ds = new DataSet();
                    try
                    {
                        if (conn.State != ConnectionState.Open)
                        {
                            conn.Open();
                        }
                        var cmd = new SqlCommand("[dbo].[WebxNet_Profitability_DKT_CSV]", conn)
                        {
                            CommandType = CommandType.StoredProcedure
                        };

                        cmd.Parameters.Add(new SqlParameter("@Location", MAxStr_VAL.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@locLevel", MAxSTR_LV.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@fromdt", dtFrom.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@TODT", dtTo.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@paybas", st_paybasis.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@TRN", st_trnmod.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@BKGTYP", st_type.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@BUSTYP", st_busttype.ToString()));
                        cmd.Parameters.Add(new SqlParameter("@custcode", strcustcd));
                        cmd.Parameters.Add(new SqlParameter("@dktnoList", DocketLsit));
                        cmd.Parameters.Add(new SqlParameter("@LOCTYP", DT_TYPE.ToString()));
                        
                        cmd.CommandTimeout = 10800;
                        var da = new SqlDataAdapter(cmd);
                        da.Fill(ds, "Sales Profitability Register");
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
                    ExportUtils.ExportToCSV(ds.Tables[0], "Sales Profitability Register Report");
                }
                else
                {
                    ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Prof";
                    ReportViewer1.ShowParameterPrompts = false;
                }
            }
            else
            {
                ReportViewer1.ServerReport.ReportPath = ReportServiceUtilities.ReportPathPrefix + "/DKT_Prof_Summary";
                ReportViewer1.ShowParameterPrompts = true;
            }

            ReportViewer1.ServerReport.SetParameters(parameters);
        }
        //added By Manisha 23/5/2014
        DataTable dtRptInsert = ReportCounter.InsertReportCounter(Request.QueryString["hdnRptId"].ToString(), SessionUtilities.CurrentEmployeeID, SessionUtilities.CurrentBranchCode).Tables[0];


    }
}
