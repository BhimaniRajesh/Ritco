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

public partial class GUI_popups_Popup_Location : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        SqlConn.ConnectionString = Session["SqlProvider"].ToString().Trim();
        if (!IsPostBack)
        {
           
            //hlocname.Value = Request.QueryString["locname"].ToString();
            hloccode.Value = Request.QueryString["hfloccode"].ToString();
        }

    }
}
