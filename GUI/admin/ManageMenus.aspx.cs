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

public partial class GUI_admin_ManageMenus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;

        SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
    }
    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string tmp = "";
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            //We're only interested in Rows that contain data    
            //get a reference to the data used to databound the row    
            DataRowView drv = ((DataRowView)e.Row.DataItem);
            tmp = drv["Text"].ToString().Trim();
            if (tmp == "")
            {
                try
                {
                    e.Row.Cells[0].Controls.Clear();
                    e.Row.Cells[0].Text = "-NA-";
                }
                catch (Exception ex) { }
            }
        }
    }
}
