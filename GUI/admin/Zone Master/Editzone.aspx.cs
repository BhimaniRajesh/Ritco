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

public partial class GUI_admin_Zone_Master_addzone : System.Web.UI.Page
{
    SqlConnection cn;
    public static string zcode;

    protected void Page_Load(object sender, EventArgs e)
    {
        // cmdSubmit.Attributes.Add("onclick", "javascript:return check(" + txtzoneName.ClientID + ")");
        getstring();
        if (!IsPostBack)
        {
            zcode = Request.QueryString["zno"].ToString();
            l1.Text = zcode;
            txtzoneName.Text = Request.QueryString["znm"].ToString();
            
            cmdUpdate.Visible = true;
        }
    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT zonename FROM  webx_zonemaster";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["zonename"] + "'"));
        }
        dr_Location.Close();
    }
 

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();


        string sql = "update webx_zonemaster set ZoneName='" + txtzoneName.Text + "' where zonecode='"+zcode+"'";


        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        sqlCommand.ExecuteNonQuery();
        Response.Redirect("../Company_Structure.aspx");
    }
    protected void cmdList_Click(object sender, EventArgs e)
    {
        Response.Redirect("zonelist.aspx");
    }
}
