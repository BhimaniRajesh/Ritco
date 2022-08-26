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
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        string company_AccCode = "", AccCode = "";
        company_AccCode = TxtAcccode.Text.ToString();
        if (radCompanycode.Checked == true)
        {
            string sql = "select AccCode from webx_acctinfo WITH(NOLOCK) Where company_AccCode = '" + company_AccCode + "' order by accdesc";
            con.Open();
            cmd = new SqlCommand(sql, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                AccCode = dr["AccCode"].ToString();
            }
            con.Close();
        }
        else
        {
            AccCode = TxtAcccode.Text.ToString();
        }
        Response.Redirect("View_accounts_step_2.aspx?Main_category=&AccCode=" + AccCode);
    }
    protected void OnChangeMainGroup(object sender, EventArgs e)
    {
        string sql_acc = "select AccCode,(Accdesc + ' : ' + Company_AccCode) as Accdesc from webx_acctinfo WITH(NOLOCK) Where Activeflag='Y' and groupcode in(select groupcode from webx_groups where main_category = '" + Cmd_MainGroups.SelectedValue.ToString() + "')";
        con.Open();
        cmd = new SqlCommand(sql_acc, con);
        dr = cmd.ExecuteReader();
        dlstAccountsCodes.Items.Clear();
        dlstAccountsCodes.Items.Add(new ListItem("--- Select All ---", ""));
        while (dr.Read())
        {
            dlstAccountsCodes.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dlstAccountsCodes.SelectedIndex = 0;
        dlstAccountsCodes.CssClass = "blackfnt";
        dr.Close();
    }
    protected void Edit_2_Click(object sender, EventArgs e)
    {
        string AccCode = dlstAccountsCodes.SelectedItem.Value;
        string Main_category = Cmd_MainGroups.SelectedValue.ToString();
        if (AccCode == "" && Main_category != "")
            Response.Redirect("View_accounts_step_2.aspx?AccCode=&Main_category=" + Cmd_MainGroups.SelectedValue.ToString());
        else if (Main_category != "" && AccCode != "")
            Response.Redirect("View_accounts_step_2.aspx?Main_category=&AccCode=" + dlstAccountsCodes.SelectedItem.Value);
    }
    protected void showDetails(object sender, EventArgs e)
    {
        if (radCompanycode.Checked == true)
            lblaccheader.Text = "Enter Company Account Code : ";
        else
            lblaccheader.Text = "Enter System Account Code : ";
    }
}
