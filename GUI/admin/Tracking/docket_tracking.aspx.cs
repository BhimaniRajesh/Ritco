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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class docket_tracking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string dockno = Request.QueryString.Get("strDckNo");
            Response.Write("<br> dockno12 : " + dockno);
            Response.Write("<br> menuTabs : " + menuTabs.SelectedValue);


        }
        protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
        {
            multiTabs.ActiveViewIndex = Int32.Parse(menuTabs.SelectedValue);
        }
    }


