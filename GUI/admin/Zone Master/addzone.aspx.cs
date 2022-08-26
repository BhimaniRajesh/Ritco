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

    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();
        cmdSubmit.Attributes.Add("onclick", "javascript:return check(" + txtzoneName.ClientID + ")");
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
    public string nextz()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string sql = "select max(zonecode)+1 as z from webx_zonemaster";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr;
        dr = sqlCommand.ExecuteReader();

        dr.Read();

        string nextzone = dr["z"].ToString();
 dr.Close();
        return nextzone;
       

    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string z = nextz();
         

        string sql = "Insert into webx_zonemaster values ('"+ z +"','" + txtzoneName.Text + "')";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        sqlCommand.ExecuteNonQuery();
       Response.Redirect("../Company_Structure.aspx");
    }
    protected void cmdList_Click(object sender, EventArgs e)
    {
    Response.Redirect("zonelist.aspx");
    }
    
}
