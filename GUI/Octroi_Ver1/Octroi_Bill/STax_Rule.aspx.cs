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

public partial class GUI_Octroi_Ver1_Octroi_Bill_STax_Rule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                string str = "SELECT Rule_value,Rule_Y_N FROM Webx_Modules_Rules where Module_name = 'Prepare Octroi Bill' and Rule_Desc='Service Tax For Octroi Bill'";
                DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
                if (dt.Rows.Count > 0)
                {
                    txtRuleValue.Text = dt.Rows[0]["Rule_value"].ToString();
                    ddlRuleType.SelectedValue = dt.Rows[0]["Rule_Y_N"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Service Tax Rule Generation Error&detail1=Service Tax Rule Generation Error&detail2=" + strex);
            return;
        }
    }
    protected void btnApply_Click(object sender, EventArgs e)
    {
        try
        {
            string str = "SELECT Rule_value,Rule_Y_N FROM Webx_Modules_Rules where Module_name = 'Prepare Octroi Bill' and Rule_Desc='Service Tax For Octroi Bill'";
            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];
            if (dt.Rows.Count > 0)
            {
                string strUpdate = "Update Webx_Modules_Rules set Rule_value = '" + txtRuleValue.Text + "',Rule_Y_N = '" + ddlRuleType.SelectedValue + "' where Module_name = 'Prepare Octroi Bill' and Rule_Desc='Service Tax For Octroi Bill'";
                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, strUpdate);
            }
            else
            {
                string strInsert = "Insert into Webx_Modules_Rules(Module_Name,RULE_DESC,RULE_VALUE,RULE_Y_N)";
                strInsert = strInsert + "Values ('Prepare Octroi Bill','Service Tax For Octroi Bill','" + txtRuleValue.Text.Trim() + "','" + ddlRuleType.SelectedValue + "')";
                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, strInsert);
            }
            trMsg.Visible = true;
            lblMsg.Text = "Service Tax Rule Apply...";  
        }
        catch (Exception ex)
        {            
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Service Tax Rule Generation Error&detail1=Service Tax Rule Generation Error&detail2=" + strex);
            return;
        }
    }  
}
