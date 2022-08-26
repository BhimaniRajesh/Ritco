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

public partial class GUI_admin_OpeningBalance_SelectBranch : System.Web.UI.Page
{
    DateFunction DAccess = new DateFunction();
    SqlDataReader dtr;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            AccountTrans Acctrans = new AccountTrans();
            string validlocs = Acctrans.getValidBranch();

            string strjs = " javascript : var raisedon=document.getElementById('" + txtBranchCode.ClientID + "');" +
                           " var valuetoCompare = '" + validlocs + "';" +
                           " raisedon.value = raisedon.value.toUpperCase();" +
                           " raisedon.focus();" +
                           " return; }";
            Acctrans = null;
            txtBranchCode.Attributes.Add("OnBlur", strjs);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string branch1 = txtBranchCode.Text;
        Response.Redirect("OpBal_list.aspx?branch=" + branch1);
    }
    protected void text_change(object sender, EventArgs e)
    {
        AccountTrans Acctrans = new AccountTrans();
        string validlocs = Acctrans.getValidBranch();
        if (validlocs != "")
        {
            string flag = "N";
            string loc = validlocs;
            string[] arLocation = new string[0];
            char[] split_arLocation = { ',' };
            arLocation = loc.Split(split_arLocation);
            for (int x = 0; x < arLocation.Length; x++)
            {
                string tempLoc = arLocation[x];
                if (tempLoc == txtBranchCode.Text)
                {
                    error.Visible = false;
                    flag = "N";
                    break;
                }
                else
                {
                    flag = "Y";
                }
            }
            if (flag == "Y")
            {
                error.Visible = true;
                error.Text = "'Invalid Branch !!!'"; 
            }
            else
            {
                error.Visible = false;
            }
        }
    }
}
