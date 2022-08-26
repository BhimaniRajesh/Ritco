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

public partial class GUI_admin_Holiday_Holiday : System.Web.UI.Page
{
    SqlConnection cn;
    Int16 i = -3;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            cn.Open();
            string sqlGetState = "select distinct STCD,STNM from webx_state order by stnm";
            SqlCommand cmd = new SqlCommand(sqlGetState, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddRg.DataTextField = "STNM";
                ddRg.DataValueField = "STCD";
                ddRg.DataSource = ds;
                ddRg.DataBind(); 
            }
            ddRg.Items.Insert(0, new ListItem("--Select--", "-1"));
            cn.Close();

        }

    }
    protected void ddRg_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ddLoc.Items.Clear();
        //ddLoc.Items.Add("--Select--");   
        cn.Open();
        string sqlGetLoc = "select (HDAY_NOTE + ' : ' + CONVERT(VARCHAR, HDAY_DATE, 103)) as HolidayDetails, CONVERT(VARCHAR, HDAY_DATE, 103) AS HDAY_DATE from webx_HOLIDAY where HDAY_REGION='" + ddRg.SelectedValue + "' order by HDAY_DATE";
        SqlCommand cmd = new SqlCommand(sqlGetLoc, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddLoc.DataTextField = "HolidayDetails";
            ddLoc.DataValueField = "HDAY_DATE";
            ddLoc.DataSource = ds;
            ddLoc.DataBind();
        }
        //ddLoc.Items.Insert(0, new ListItem("--Select--", "-1"));  
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Session["dRg"] = ddRg.SelectedValue;
        Session["dLoc"] = ddLoc.SelectedItem;
        Session["status"] = "No";
        //Server.Transfer("HolidayUpdate.aspx");
        Response.Redirect("HolidayUpdate.aspx");
        
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("HolidayListingNew.aspx");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        //Server.Transfer("HolidayAdd.aspx"); 
        Response.Redirect("HolidayAdd.aspx");
    }
}
