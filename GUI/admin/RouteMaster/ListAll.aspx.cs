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

public partial class GUI_admin_VehicleMaster_ListAll : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
           bindGrid();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindGrid();
    }
    public void bindGrid()
    {
        cn.Open();
        string sql;
        sql = "select rutcd,rutnm,case when rutmod='S' then 'Road' when rutmod='R' then 'Rail' when rutmod='A' then 'Air' else '' end as rutmod,rutkm,transhrs from webx_rutmas order by rutnm";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dt.Columns.Add("Sr. No", typeof(int));
        dt.Columns["Sr. No"].AutoIncrement = true;
        dt.Columns["Sr. No"].AutoIncrementSeed = 1;
        dt.Columns["Sr. No"].AutoIncrementStep = 1;
        adp.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        cn.Close();
    }
    protected void jump(object sender, EventArgs e)
    {
        GridView1.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
        //Session["mode"] = "edit";
        Session["tRutCd"] = ((LinkButton)GridView1.SelectedRow.FindControl("lnkrutcode")).Text;
        Session["dRutSel"] = "";
        Response.Redirect("RouteMasterEdit.aspx?mode=edit");
    }
}



