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

public partial class GUI_admin_StateMaster_StateMasterEdSelect : System.Web.UI.Page
{
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        if (IsPostBack == false)
        {
            cn.Open();
            string sql = "Select Distinct STNM,(STCD + ' : ' + STNM) as STdetail, STCD From webx_state order by STNM";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddState.DataTextField = "STdetail";
                ddState.DataValueField = "STCD";
                ddState.DataSource = ds;
                ddState.DataBind();
            }
            ddState.Items.Insert(0, new ListItem("--Select--", "-1"));
            cn.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        Session["state"] = ddState.SelectedValue;  
        Server.Transfer("StateMasterEditsan.aspx");
    }
}
