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
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlDataReader dr_Acnt;

        if (!IsPostBack)
        {
            string sql_acc = "select distinct Acccategory as Text,Acccategory as Val from webx_Acccategory_master WITH(NOLOCK)";
            con.Open();
            SqlCommand cmd_acc = new SqlCommand(sql_acc, con);
            dr_Acnt = cmd_acc.ExecuteReader();

            Cmd_Acccategory.Items.Clear();
            Cmd_Acccategory.Items.Add(new ListItem("--- Select All ---", ""));
            while (dr_Acnt.Read())
            {
                Cmd_Acccategory.Items.Add(new ListItem(dr_Acnt.GetValue(1).ToString(), dr_Acnt.GetValue(0).ToString()));
            }
            Cmd_Acccategory.SelectedIndex = 0;
            Cmd_Acccategory.CssClass = "blackfnt";
            dr_Acnt.Close();
        }

        Submit.Attributes.Add("onclick", "javascript:return Edit_code()");
        
    }
    protected void Edit_Click(object sender, EventArgs e)
    {   
        string Acccategory = Cmd_Acccategory.SelectedValue.ToString();
        Response.Redirect("Add_Acccategory.aspx?Data=" + Acccategory);
    }
}
