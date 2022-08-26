using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using WebX.Controllers;

public partial class GUI_Operation_Singlescreen_docketentry_Docket_submit_done : System.Web.UI.Page
{

    protected string dkt_call = "", dockno = "", mrno = "", billno = "";
    public static string ToolTip_Str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string flag_edit = "ENTRY";
        dkt_call = Session["DocketCalledAs"].ToString();
        try
        {
            flag_edit = Request.QueryString["editflag"].ToString();
        }
        catch (Exception ex) { }

        if (flag_edit.CompareTo("EDIT") == 0)
        {
            tredit.Style["display"] = "block";
            trentry.Style["display"] = "none";
        }
        else
        {
            tredit.Style["display"] = "none";
            trentry.Style["display"] = "block";
        }

        mrno = Request.QueryString["mrsno"].ToString();
        try
        {
            billno = Convert.ToString(Request.QueryString["billno"]);
        }
        catch (Exception ex) { billno = "NA"; }

        cnno.Text = Request.QueryString["Dockno"].ToString();
        dockno = Request.QueryString["Dockno"].ToString();
        mrsno.Text = Request.QueryString["Mrsno"].ToString();
        mrno = Request.QueryString["Mrsno"].ToString();
        lblbillno.Text = billno;
        if (mrno.CompareTo("NA") == 0)
            trmr.Visible = false;

        if (billno == null || billno.CompareTo("NA") == 0)
            trbillno.Visible = false;
        else
            trbillno.Visible = true;

        try
        {


            string Financial_Year = "", fin_year = "";
            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string Table_Name = "webx_acctrans_" + fin_year;
            string sql = "exec Usp_Show_Doc_Accounting '" + dockno + "','" + Table_Name + "'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            ToolTip_Str = Convert.ToString(sqlcmd.ExecuteScalar());



        }
        catch (Exception ex) { }

        hdn_psp_url.Value = ViewPrintController.GetNavigationURL("PSP_DKT");
        hdn_bps_url.Value = ViewPrintController.GetNavigationURL("VW_BPS");
        hdn_abv_url.Value = ViewPrintController.GetNavigationURL("VW_ABV");
    }
}
