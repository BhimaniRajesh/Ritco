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


public partial class Acct_Groups : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

      
        if (!IsPostBack)
        {
            //

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlDataReader dr_groups;
            conn.Open();
            string sql = "select groupcode,groupdesc+ '-' +groupcode,groupcode from webx_groups where grouplevel='1' order by groupdesc";
            //string sql = "select codetype_new,abbr_type from webx_typemst where   activeflag='Y'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr_groups = cmd.ExecuteReader();

            Cmd_groupcode_1.Items.Clear();
            //cmbParentCode.Items.Add("Main level");

            Cmd_groupcode_1.Items.Add(new ListItem("--- Select All ---", ""));

            while (dr_groups.Read())
            {
                Cmd_groupcode_1.Items.Add(new ListItem(dr_groups.GetValue(1).ToString(), dr_groups.GetValue(0).ToString()));

            }
            Cmd_groupcode_1.SelectedIndex = 0;
            Cmd_groupcode_1.CssClass = "blackfnt";
            dr_groups.Close();
        }
    }
   
    

  
   
    protected void Level1_Click(object sender, EventArgs e)
    {
        if (Cmd_groupcode_1.SelectedValue != "")
        {
            level2.Visible = true;
            //lastlevel.Value = "2";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlDataReader dr_groups;
            conn.Open();
            string sql = "select groupcode,groupdesc+ '-' +groupcode,groupcode from webx_groups where  grouplevel <> '1' and parentcode ='" + Cmd_groupcode_1.SelectedValue + "'  order by groupdesc";
            //string sql = "select codetype_new,abbr_type from webx_typemst where   activeflag='Y'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr_groups = cmd.ExecuteReader();

            Cmd_groupcode_2.Items.Clear();
            //cmbParentCode.Items.Add("Main level");

            Cmd_groupcode_2.Items.Add(new ListItem("--- Select All ---", ""));

            while (dr_groups.Read())
            {
                Cmd_groupcode_2.Items.Add(new ListItem(dr_groups.GetValue(1).ToString(), dr_groups.GetValue(0).ToString()));

            }
            Cmd_groupcode_2.SelectedIndex = 0;
            Cmd_groupcode_2.CssClass = "blackfnt";
            dr_groups.Close();
        }
    }
    protected void Level2_Click(object sender, EventArgs e)
    {
        if (Cmd_groupcode_2.SelectedValue != "")
        {
            level3.Visible = true;
            //lastlevel.Value = "3";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlDataReader dr_groups;
            conn.Open();
            string sql = "select groupcode,groupdesc+ '-' +groupcode,groupcode from webx_groups where  grouplevel <> '1' and parentcode ='" + Cmd_groupcode_2.SelectedValue + "'  order by groupdesc";
            //string sql = "select codetype_new,abbr_type from webx_typemst where   activeflag='Y'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr_groups = cmd.ExecuteReader();

            Cmd_groupcode_3.Items.Clear();
            //cmbParentCode.Items.Add("Main level");

            Cmd_groupcode_3.Items.Add(new ListItem("--- Select All ---", ""));

            while (dr_groups.Read())
            {
                Cmd_groupcode_3.Items.Add(new ListItem(dr_groups.GetValue(1).ToString(), dr_groups.GetValue(0).ToString()));

            }
            Cmd_groupcode_3.SelectedIndex = 0;
            Cmd_groupcode_3.CssClass = "blackfnt";
            dr_groups.Close();
        }
    }
    protected void Level3_Click(object sender, EventArgs e)
    {
        if (Cmd_groupcode_3.SelectedValue != "")
        {
            level4.Visible = true;
            //lastlevel.Value = "4";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlDataReader dr_groups;
            conn.Open();
            string sql = "select groupcode,groupdesc+ '-' +groupcode,groupcode from webx_groups where  grouplevel <> '1' and parentcode ='" + Cmd_groupcode_3.SelectedValue + "'  order by groupdesc";
            //string sql = "select codetype_new,abbr_type from webx_typemst where   activeflag='Y'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr_groups = cmd.ExecuteReader();

            Cmd_groupcode_4.Items.Clear();
            //cmbParentCode.Items.Add("Main level");

            Cmd_groupcode_4.Items.Add(new ListItem("--- Select All ---", ""));

            while (dr_groups.Read())
            {
                Cmd_groupcode_4.Items.Add(new ListItem(dr_groups.GetValue(1).ToString(), dr_groups.GetValue(0).ToString()));

            }
            Cmd_groupcode_4.SelectedIndex = 0;
            Cmd_groupcode_4.CssClass = "blackfnt";
            dr_groups.Close();
        }
    }
    public string get_Level1()
    {
        string groupcode_1_1;
        if (Cmd_groupcode_1.SelectedValue != "")
        {
            groupcode_1_1 = Cmd_groupcode_1.SelectedItem.Value;
            return groupcode_1_1;
        }
        else
        {
            return groupcode_1_1="";
        }
    }
    public string get_Level1_TEXT()
    {
        string groupcode_1_1;
        if (Cmd_groupcode_1.SelectedValue != "")
        {
            groupcode_1_1 = Cmd_groupcode_1.SelectedItem.Text;
            return groupcode_1_1;
        }
        else
        {
            return groupcode_1_1="";
        }
    }

    public string get_Level2()
    {
        string Cmd_groupcode_2_2;
        if (Cmd_groupcode_2.SelectedValue != "")
        {
             Cmd_groupcode_2_2 = Cmd_groupcode_2.SelectedItem.Value;
            return Cmd_groupcode_2_2;
        }
        else
        {
            return Cmd_groupcode_2_2 ="";
        }
    }
    public string get_Level2_TEXT()
    {
        string Cmd_groupcode_2_2;
        if (Cmd_groupcode_2.SelectedValue != "")
        {
            Cmd_groupcode_2_2 = Cmd_groupcode_2.SelectedItem.Text;
            return Cmd_groupcode_2_2;
        }
        else
        {
            return Cmd_groupcode_2_2 = "";
        }
    }
    public string get_Level3()
    {
        string Cmd_groupcode_3_3;
        if (Cmd_groupcode_3.SelectedValue != "")
        {
             Cmd_groupcode_3_3 = Cmd_groupcode_3.SelectedItem.Value;
            return Cmd_groupcode_3_3;
        }
        else
        {
            return Cmd_groupcode_3_3="";
        }
    }
    public string get_Level3_TEXT()
    {
        string Cmd_groupcode_3_3;
        if (Cmd_groupcode_3.SelectedValue != "")
        {
            Cmd_groupcode_3_3 = Cmd_groupcode_3.SelectedItem.Text;
            return Cmd_groupcode_3_3;
        }
        else
        {
            return Cmd_groupcode_3_3 = "";
        }
    }
    public string get_Level4()
    {
        string Cmd_groupcode_4_4;
        if (Cmd_groupcode_4.SelectedValue != "")
        {
            Cmd_groupcode_4_4 = Cmd_groupcode_4.SelectedItem.Value;
            return Cmd_groupcode_4_4;
        }
        else
        {
            return Cmd_groupcode_4_4="";
        }
    }
    public string get_Level4_TEXT()
    {
        string Cmd_groupcode_4_4;
        if (Cmd_groupcode_4.SelectedValue != "")
        {
            Cmd_groupcode_4_4 = Cmd_groupcode_4.SelectedItem.Text;
            return Cmd_groupcode_4_4;
        }
        else
        {
            return Cmd_groupcode_4_4 = "";
        }
    }
}
