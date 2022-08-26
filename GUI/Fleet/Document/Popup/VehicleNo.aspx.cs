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

public partial class GUI_popups_vehno : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        SqlConn.ConnectionString = Session["SqlProvider"].ToString().Trim();
        if(!IsPostBack)
        {
            hVehNo.Value = Request.QueryString["vehno"].ToString();
            hID.Value = Request.QueryString["vehid"].ToString();
            //hVehCategory.Value = Request.QueryString["vehcat"].ToString();
            hKm.Value = Request.QueryString["km"].ToString();
            hVehType.Value = Request.QueryString["VehType"].ToString();
        }
    }
}
