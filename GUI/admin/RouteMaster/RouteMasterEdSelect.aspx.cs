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

public partial class GUI_admin_RouteMaster_RouteMasterEdSelect : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            ddRutSelect.Items.Add("--Select--"); 
            cn.Open();
            SqlCommand cmd = new SqlCommand("select rutcd + ' : ' + rutnm from webx_rutmas where rutmod is not null order by rutnm", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddRutSelect.Items.Add(new ListItem(dr.GetSqlValue(0).ToString()));  
            }
            dr.Close();
            //cn.Close();
            
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtRutCd.Text != "")
        {
            Session["tRutCd"] = txtRutCd.Text.Trim();
            Session["dRutSel"] = "";
            //Server.Transfer("RouteMasterEdit.aspx");
            Response.Redirect("RouteMasterEdit.aspx?mode=edit"); 
        }
        //if (txtLocCd.Text != "")
        //{
        //    Session["tLocCd"] = txtLocCd.Text.Trim();
        //}
        else if (ddRutSelect.SelectedValue != "")
        {
            string[] strdRutSel = ddRutSelect.SelectedValue.Split(':');
            Session["dRutSel"] = strdRutSel[0].Trim();
            Session["tRutCd"] = "";
            //Server.Transfer("RouteMasterEdit.aspx");
            Response.Redirect("RouteMasterEdit.aspx?mode=edit"); 
        }
        //Server.Transfer("RouteMasterEdit.aspx");
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddRutSelect.Items.Clear();
        if (CmbRouteMode.Text == "All")
        {
            ddRutSelect.Items.Add("--Select--");
            cn.Open();
            SqlCommand cmd = new SqlCommand("select rutcd + ' : ' + rutnm from webx_rutmaswhere rutmod is not null  order by rutnm ", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddRutSelect.Items.Add(new ListItem(dr.GetSqlValue(0).ToString()));
            }
            dr.Close(); 
        }
        else if (CmbRouteMode.Text == "A")
        {
            ddRutSelect.Items.Add("--Select--");
            cn.Open();
            SqlCommand cmd = new SqlCommand("select rutcd + ' : ' + rutnm from webx_rutmas where rutmod='A' order by rutnm", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddRutSelect.Items.Add(new ListItem(dr.GetSqlValue(0).ToString()));
            }
            dr.Close(); 
        }
        else if (CmbRouteMode.Text == "S")
        {
            ddRutSelect.Items.Add("--Select--");
            cn.Open();
            SqlCommand cmd = new SqlCommand("select rutcd + ' : ' + rutnm from webx_rutmas  where rutmod='S' order by rutnm", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddRutSelect.Items.Add(new ListItem(dr.GetSqlValue(0).ToString()));
            }
            dr.Close();
        }
        else if (CmbRouteMode.Text == "R")
        {
            ddRutSelect.Items.Add("--Select--");
            cn.Open();
            SqlCommand cmd = new SqlCommand("select rutcd + ' : ' + rutnm from webx_rutmas where rutmod='R' order by rutnm", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddRutSelect.Items.Add(new ListItem(dr.GetSqlValue(0).ToString()));
            }
            dr.Close();
        }
    }
}
