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

public partial class GUI_admin_Accounts_masters_Acctgroup_View_acctGroups : System.Web.UI.Page
{
    DataAccess DAccess = new DataAccess();
    SqlConnection con;
    SqlDataReader dr;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Edit_2.Attributes.Add("onclick", "javascript:return Edit_code_2()");
        Submit.Attributes.Add("onclick", "javascript:return Edit_code()");
        if (!IsPostBack)
        {  
        }
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        string company_Groupcode = "", Groupcode = "";
        company_Groupcode = TxtGroupcode.Text.ToString();
        if (radCompanycode.Checked == true)
        {
            string sql = "select groupcode from webx_groups WITH(NOLOCK) Where company_groupcode = '" + company_Groupcode + "' order by groupdesc";
            con.Open();
            cmd = new SqlCommand(sql, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Groupcode = dr["groupcode"].ToString();
            }
            con.Close();
        }
        else
        {
            Groupcode = TxtGroupcode.Text.ToString();
        }
        Response.Redirect("View_acctGroups_step_2.aspx?Main_category=&Groupcode=" + Groupcode);
    }
    protected void OnChangeMainGroup(object sender, EventArgs e)
    {
        string sql_acc = "select GroupCode,(Groupdesc + ' : ' + Company_Groupcode) as Groupdesc from webx_groups WITH(NOLOCK) Where main_category = '" + Cmd_MainGroups.SelectedValue.ToString() + "'";
        con.Open();
        cmd = new SqlCommand(sql_acc, con);
        dr = cmd.ExecuteReader();
        dlstAccountsGroups.Items.Clear();
        dlstAccountsGroups.Items.Add(new ListItem("--- Select All ---", ""));
        while (dr.Read())
        {
            dlstAccountsGroups.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dlstAccountsGroups.SelectedIndex = 0;
        dlstAccountsGroups.CssClass = "blackfnt";
        dr.Close();
    }
    protected void Edit_2_Click(object sender, EventArgs e)
    {
        string groupcode = dlstAccountsGroups.SelectedItem.Value;
        string Main_category = Cmd_MainGroups.SelectedValue.ToString();
        if (groupcode == "" && Main_category != "")
            Response.Redirect("View_acctGroups_step_2.aspx?Groupcode=&Main_category=" + Cmd_MainGroups.SelectedValue.ToString());
        else if(Main_category != "" && groupcode != "")
            Response.Redirect("View_acctGroups_step_2.aspx?Main_category=&Groupcode=" + dlstAccountsGroups.SelectedItem.Value);
    }
    protected void showDetails(object sender, EventArgs e)
    {
        if (radCompanycode.Checked == true)
            lblgroupheader.Text = "Enter Company Group Code : ";
        else
            lblgroupheader.Text = "Enter System Group Code : ";
    }
}
