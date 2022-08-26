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
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_admin_setting_cust_opn_bal_OPBalCust_step2 : System.Web.UI.Page
{ 
    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_title.Text = "You are in finanacial year : " + SessionUtilities.FinYear.ToString() + "-" + Convert.ToString(Convert.ToInt16(SessionUtilities.FinYear.ToString()) + 1);
        lbl_title.Text = lbl_title.Text + "<Br> System will set closing balance of finanacial year : " + Convert.ToString(Convert.ToInt16(SessionUtilities.FinYear.ToString()) - 1) + "-" + SessionUtilities.FinYear.ToString() + " as opening balance of finanacial year : " + SessionUtilities.FinYear.ToString() + "-" + Convert.ToString(Convert.ToInt16(SessionUtilities.FinYear.ToString()) + 1);
 
    }
    protected void Btn_ledger_Click(object sender, EventArgs e)
    {
        string Sql_Ledger = "";
        try
        {
            Sql_Ledger = "exec Usp_Balance_TRF '1','" + Rd_Ledger_1.Text.ToString() + "','1','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, Sql_Ledger);
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/Admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
        Response.Redirect("Balance_trf_Done.aspx");
    }
    protected void Btn_Sub_ledger_Click(object sender, EventArgs e)
    {
        string Sql_Sub_Ledger = "";
        try
        {
            if(Rd_Sub_Ledger_1.Checked)
                Sql_Sub_Ledger = "exec Usp_Balance_TRF '2','ALL','ALL','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";  
            else if(Rd_Sub_Ledger_2.Checked)
                Sql_Sub_Ledger = "exec Usp_Balance_TRF '2','ALL','1','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            else if (Rd_Sub_Ledger_3.Checked)
                Sql_Sub_Ledger = "exec Usp_Balance_TRF '2','ALL','2','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            else if (Rd_Sub_Ledger_4.Checked)
                Sql_Sub_Ledger = "exec Usp_Balance_TRF '2','ALL','3','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            else if (Rd_Sub_Ledger_5.Checked)
                Sql_Sub_Ledger = "exec Usp_Balance_TRF '2','ALL','4','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            if (Sql_Sub_Ledger != "")
            {
                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, Sql_Sub_Ledger);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/Admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
        Response.Redirect("Balance_trf_Done.aspx");
    }
    protected void Btn_PNL_Click(object sender, EventArgs e)
    {
        string Sql_Ledger = "";
        try
        {
            Sql_Ledger = "exec Usp_Balance_TRF '3','ALL','1','" + SessionUtilities.FinYear.ToString() + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "'";
            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, Sql_Ledger);
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/Admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
        Response.Redirect("Balance_trf_Done.aspx");
    }
 
}
