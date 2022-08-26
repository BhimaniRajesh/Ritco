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

public partial class GUI_admin_Accounts_masters_Acctgroup_Edit_acctGroups : System.Web.UI.Page
{
    DataAccess DAccess = new DataAccess();
    SqlConnection con;
    SqlDataReader dr;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Edit_2.Attributes.Add("onclick", "javascript:return Edit_code_2()");
        if (!IsPostBack)
        {
            dlstAccountsGroups.DataSource = DAccess.getdataset("select Groupcode, (Groupdesc + ' : ' + Company_Groupcode) as Groupdesc  from webx_groups Order by Groupdesc Asc");
            dlstAccountsGroups.DataTextField = "Groupdesc";
            dlstAccountsGroups.DataValueField = "Groupcode";
            dlstAccountsGroups.DataBind();
            dlstAccountsGroups.Items.Insert(0, "Select");
            dlstAccountsGroups.Items[0].Value = "";
            dlstAccountsGroups.Items[0].Selected = true;
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
         Response.Redirect("Add_acctGroups.aspx?Data=" + Groupcode);
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
        string data = dlstAccountsGroups.SelectedItem.Value;
        Response.Redirect("Add_acctGroups.aspx?Data=" + data);
    }
    protected void showDetails(object sender, EventArgs e)
    {
        if (radCompanycode.Checked == true)
            lblaccheader.Text = "Enter Company Group Code : ";
        else
            lblaccheader.Text = "Enter System Group Code : ";
    }
}
