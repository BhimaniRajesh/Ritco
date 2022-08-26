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

public partial class GUI_Operations_THC_THCCreateMain : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        MySQLDataSource_Routes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_RouteNames.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_VendorTypes.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vendors.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicle_Types.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Vehicles.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_MFAvailable.ConnectionString = Session["SqlProvider"].ToString().Trim();
    }

    protected void OnRouteNameChange(object sender, EventArgs e)
    {
        tblMFList.Visible = false;    
        DropDownList dl = (DropDownList)sender;
        if (dl.Items[dl.SelectedIndex].Value != "")
        {
            tblMFList.Visible = true;
        }
    }

    protected void OnVendorTypeChange(object sender, EventArgs e)
    {
        DropDownList dl = (DropDownList)sender;
        txtMarketVendor.Text = dl.Items[dl.SelectedIndex].Value;
        txtMarketVendor.Visible = false;
        if (dl.Items[dl.SelectedIndex].Value == "XX")
        {
            txtMarketVendor.Text = "";
            txtMarketVendor.Visible = true;
        }
    }

    protected void OnRouteModeChange(object sender, EventArgs e)
    {
        tblMFList.Visible = false;  
        DropDownList dl = (DropDownList)sender;
        if (dl.Items[dl.SelectedIndex].Value == "S")
        {
            trForRouteModeS.Visible = true;
            trForRouteModeR.Visible = false;
            trForRouteModeA.Visible = false;
        }

        if (dl.Items[dl.SelectedIndex].Value == "R")
        {
            trForRouteModeS.Visible = false;
            trForRouteModeR.Visible = true;
            trForRouteModeA.Visible = false;
        }
        
        if (dl.Items[dl.SelectedIndex].Value == "A")
        {
            trForRouteModeS.Visible = false;
            trForRouteModeR.Visible = false;
            trForRouteModeA.Visible = true;
        }
    }

}
