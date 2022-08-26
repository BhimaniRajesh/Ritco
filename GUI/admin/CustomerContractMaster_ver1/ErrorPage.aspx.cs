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

public partial class GUI_ErrorPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        try
        {
            lblheading.Text = Request.QueryString["heading"].ToString();
        }
        catch (Exception ex) { }

        try
        {
            lbldetail1.Text = Request.QueryString["detail1"].ToString();
        }
        catch (Exception ex) { }

        try
        {
            lbldetail2.Text = Request.QueryString["detail2"].ToString();
        }
        catch (Exception ex) { }


        lblsuggesion1.Text = "Docket not Saved. Further Entr Docket.";
        try
        {
            lblsuggesion2.Text = Request.QueryString["suggesion2"].ToString();
        }
        catch (Exception ex) { }
    }
}
