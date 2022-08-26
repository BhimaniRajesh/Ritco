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

public partial class GUI_admin_GeneralMaster_MasterList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {       
        BindGrid();
    }

    private void BindGrid()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string s = "SELECT headercode,headerdesc FROM webx_master_codetypes WHERE activeflag_YN='Y' AND headeraccess='U' ORDER BY headerdesc ASC";
        con.Open();
        SqlCommand cmd = new SqlCommand(s, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds, "tbl");

        gvmasterlist.DataSource = ds;
        gvmasterlist.DataBind();
        con.Close();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvmasterlist.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void gvmasterlist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
