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
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;

public partial class GUI_admin_AccountMasterRules_AccountingRules : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if(!IsPostBack)
        {
            loaddata();
        }
    }
    public void loaddata()
    {
        string ManualAcccodeRule = "N";
        string ManualBrcdRule = "N";
        string ManualGroupcodeRule = "N";
        double count_total = 0;
        
        count_total = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT count(*) FROM WEBX_MODULES_RULES WHERE Module_Name='Account Master' and RULE_DESC='Set Manual Account Code As System Generated Account Code'"));
        if (count_total > 0)
        { 
            ManualAcccodeRule = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT RULE_Y_N FROM WEBX_MODULES_RULES WHERE Module_Name='Account Master' and RULE_DESC='Set Manual Account Code As System Generated Account Code'").ToString();
            if (ManualAcccodeRule == "Y")
                chkManualAccode.Checked = true;
            else
                chkManualAccode.Checked = false;
        }

        count_total = 0;
        count_total = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT count(*) FROM WEBX_MODULES_RULES WHERE Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'"));
        if (count_total > 0)
        {
            ManualBrcdRule = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT RULE_Y_N FROM WEBX_MODULES_RULES WHERE Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'").ToString();
            if (ManualBrcdRule == "Y")
                chkbrcd.Checked = true;
            else
                chkbrcd.Checked = false;
        }

        count_total = 0;
        count_total = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT count(*) FROM WEBX_MODULES_RULES WHERE Module_Name='Group Master' and RULE_DESC='Set Manual Group Code As System Generated Group Code'"));
        if (count_total > 0)
        {
            ManualGroupcodeRule = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT RULE_Y_N FROM WEBX_MODULES_RULES WHERE Module_Name='Group Master' and RULE_DESC='Set Manual Group Code As System Generated Group Code'").ToString();
            if (ManualGroupcodeRule == "Y")
                chkGroupcode.Checked = true;
            else
                chkGroupcode.Checked = false;
        }
    }
    protected void btnsubmit(object sender, EventArgs e)
    {   
        string ManualAcccodeRule = "N";
        string ManualBrcdRule = "N";
        string ManualGroupcodeRule = "N";

        if (chkManualAccode.Checked == true)
        {
            ManualAcccodeRule = "Y";                   
        }
        if (chkbrcd.Checked == true)
        {
            ManualBrcdRule = "Y";
        }
        if (chkGroupcode.Checked == true)
        {
            ManualGroupcodeRule = "Y";
        }
        SqlTransaction trans;
        trans = con.BeginTransaction();
        try
        {
            string sql_Acctrans = "exec usp_Manage_Accounting_Rules '" + ManualAcccodeRule + "','" + ManualBrcdRule + "','" + ManualGroupcodeRule + "'";
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
        Response.Redirect("AccountingRules.aspx", false);
    }
}
