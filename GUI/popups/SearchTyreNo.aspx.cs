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

public partial class GUI_popups_popup_tyres : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        SqlConn.ConnectionString = Session["SqlProvider"].ToString().Trim();
        if(!IsPostBack)
        {
            hTyreID.Value = Request.QueryString["tyreno"].ToString();
            hfTyrePos.Value = Request.QueryString["tyrepos"].ToString();
            hfTyreSize.Value = Request.QueryString["tyresize"].ToString();
            hfTyrePattern.Value = Request.QueryString["tyrepat"].ToString();
            hfMFG.Value = Request.QueryString["tyremfg"].ToString();
            hfVehNo.Value = Request.QueryString["vehno"].ToString();
            hflbl7.Value = Request.QueryString["lbl7"].ToString();
            hfPnlMount.Value = Request.QueryString["pnlM"].ToString();
            hfPnlDisMount.Value = Request.QueryString["pnlD"].ToString();
            hfTyreID.Value = Request.QueryString["tyreid"].ToString(); 
        }
    }

}
