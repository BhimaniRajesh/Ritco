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

public partial class GUI_admin_ManualVoucherRules_ManualVouchersRules : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (!IsPostBack)
        {
            loaddata();
        }
    }
    public void loaddata()
    {
        string ManualDecimalRule = "N";
        string ManualSvrTaxRule = "N";

        double count_total = 0;
        count_total = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT count(*) FROM WEBX_MODULES_RULES WHERE Module_Name='Manual Vouchers' and RULE_DESC='Decimal Values Y/N'"));
        if (count_total > 0)
        {
            ManualDecimalRule = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT RULE_Y_N FROM WEBX_MODULES_RULES WHERE Module_Name='Manual Vouchers' and RULE_DESC='Decimal Values Y/N'").ToString();
            if (ManualDecimalRule == "Y")
                chkdecimal.Checked = true;
            else
                chkdecimal.Checked = false;
        }
        count_total = 0;
        count_total = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT count(*) FROM WEBX_MODULES_RULES WHERE Module_Name='Manual Vouchers' and RULE_DESC='Editable ServiceTax Rate Y/N'"));
        if (count_total > 0)
        {
            ManualSvrTaxRule = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT RULE_Y_N FROM WEBX_MODULES_RULES WHERE Module_Name='Manual Vouchers' and RULE_DESC='Editable ServiceTax Rate Y/N'").ToString();
            if (ManualSvrTaxRule == "Y")
                chksvrtaxrate.Checked = true;
            else
                chksvrtaxrate.Checked = false;
        }
    }
    protected void btnsubmit(object sender, EventArgs e)
    {  
        string ManualDecimalRule = "N";
        string ManualSvrTaxRule = "N";

        if (chkdecimal.Checked == true)
        {
            ManualDecimalRule = "Y";
        }
        if (chksvrtaxrate.Checked == true)
        {
            ManualSvrTaxRule = "Y";
        }
        
        SqlTransaction trans;
        trans = con.BeginTransaction();
        try
        {
            string sql_Acctrans = "exec usp_Manage_Manual_Vouchers_Rules '" + ManualDecimalRule + "','" + ManualSvrTaxRule + "'";
            SqlCommand cmd = new SqlCommand(sql_Acctrans, con, trans);
            cmd.ExecuteNonQuery();

            trans.Commit();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + msg);
            Response.End();
        }
        
        con.Close();
        Response.Redirect("ManualVouchersRules.aspx", false);
    }
}
