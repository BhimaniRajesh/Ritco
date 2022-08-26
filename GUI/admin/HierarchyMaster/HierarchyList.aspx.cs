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

public partial class GUI_admin_HierarchyMaster_HierarchyList : System.Web.UI.Page
{
    SqlConnection conn;  //= new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        BindGrid();
        
    }
    private void BindGrid()
    {
        conn.Open();
        string sql = "select * from WEBX_Hierarchy order by Level_No";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        HierarchyList.DataSource = dv;
        HierarchyList.DataBind();

        conn.Close();
    }
    //protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (((Control)e.CommandSource).ID == "DeleteButton")
    //    {
    //        int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
    //        string LevelNo = HierarchyList.DataKeys[thisRow].Values[0].ToString();
    //        LevelNo = LevelNo.Trim().ToString();
    //        string Query = "Delete from  WEBX_Hierarchy where Level_No='" + LevelNo + "'";
            
    //        conn.Open();
    //        SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
    //        Command.ExecuteNonQuery();
    //        conn.Close();
    //        BindGrid();
    //    }
    //}
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        HierarchyList.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
