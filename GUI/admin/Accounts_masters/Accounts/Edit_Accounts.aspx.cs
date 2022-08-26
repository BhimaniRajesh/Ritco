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

public partial class GUI_admin_Accounts_masters_Accounts_Edit_Accounts : System.Web.UI.Page
{
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        Submit.Attributes.Add("onclick", "javascript:return Edit_code()");
        Edit_2.Attributes.Add("onclick", "javascript:return Edit_code_2()");
        Listall_2.Attributes.Add("onclick", "javascript:return Edit_code_2()");
        if (!IsPostBack)
        {  
        }
    }
    protected void OnChangeMainGroup(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlDataReader dr_Acnt;
        string sql_acc = "select Acccode,(Accdesc + ' : ' + Company_Acccode) as Accdesc from webx_acctInfo WITH(NOLOCK) Where groupcode in(select groupcode from webx_groups where main_category = '" + Cmd_MainGroups.SelectedValue.ToString() + "') order by accdesc";
        con.Open();
        SqlCommand cmd_acc = new SqlCommand(sql_acc, con);
        dr_Acnt = cmd_acc.ExecuteReader();

        Cmd_Accounts.Items.Clear();
        Cmd_Accounts.Items.Add(new ListItem("--- Select All ---", ""));
        while (dr_Acnt.Read())
        {
            Cmd_Accounts.Items.Add(new ListItem(dr_Acnt.GetValue(1).ToString(), dr_Acnt.GetValue(0).ToString()));
        }
        Cmd_Accounts.SelectedIndex = 0;
        Cmd_Accounts.CssClass = "blackfnt";
        dr_Acnt.Close();
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        string company_acccode = "",acccode="";
        company_acccode = TxtAccountcode.Text.ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlDataReader dr;
        if (radCompanycode.Checked == true)
        {
            string sql = "select AccCode from webx_acctinfo WITH(NOLOCK) Where company_AccCode = '" + company_acccode + "' order by accdesc";
            con.Open();
            cmd = new SqlCommand(sql, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                acccode = dr["AccCode"].ToString();
            }
            con.Close();
        }
        else
        {
            acccode = TxtAccountcode.Text.ToString();
        }

        Response.Redirect("Add_Accounts.aspx?Data=" + acccode);

    }
    protected void Edit_2_Click(object sender, EventArgs e)
    {
        string Accountcode = Cmd_Accounts.SelectedValue.ToString(); ;

        Response.Redirect("Add_Accounts.aspx?Data=" + Accountcode);
    }
    
    protected void List_Click(object sender, EventArgs e)
    {
        Response.Redirect("Accountslist.aspx?All");
    }
    protected void List_2_Click(object sender, EventArgs e)
    {
        string Parentcode = "";

        Response.Redirect("Accountslist.aspx?" + Parentcode);
    }
    protected void showDetails(object sender, EventArgs e)
    {
        if (radCompanycode.Checked == true)
            lblaccheader.Text = "Enter Company Account Code : ";
        else
            lblaccheader.Text = "Enter System Account Code : ";
    }
   
}
