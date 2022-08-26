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

public partial class GUI_Popups_Tripsheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        if(!IsPostBack)
        {
            SqlConn.ConnectionString = Session["SqlProvider"].ToString().Trim();
            if (Request.QueryString["VehNo"] != null)
            {
                SqlConn.SelectCommand = "SELECT *FROM WEBX_FLEET_VEHICLE_ISSUE WHERE VEHICLENO='" + Request.QueryString["VehNo"].ToString() + "'";
            }
        }
    }
}
