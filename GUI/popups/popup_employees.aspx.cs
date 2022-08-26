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

public partial class GUI_popups_popup_employees : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;

        SqlConn.ConnectionString = Session["SqlProvider"].ToString().Trim();
        //if (!IsPostBack)
        //{
        //    SetOpenerValue(btnClick, Request["sender"].ToString().Trim());
        //}
    }

    //public void SetOpenerValue(System.Web.UI.WebControls.WebControl childControl, String openerObjectName)
    //{
    //    string clientScript;
    //    //Building the client script- window.open , with additional parameters
    //    clientScript = "window.opener.document.form1." + openerObjectName.Trim() + ".value='xxx';alert('" + openerObjectName.Trim() + "');return false;";
    //    //register the script to the clientside click event of the opener control
    //    childControl.Attributes.Add("onClick", clientScript);
    //}

    protected void JavaScriptProc()
    {
        //Part 1 the same code as before
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");

        sb.Append("function SetOpenerValue()");
        sb.Append("{");
        sb.Append("window.opener.document.aspnetForm." + Request["sender"].ToString().Trim() + ".value=document.form1." + hUserID.ClientID.Trim() + ".value" + ";return false;");
        sb.Append("}");

        sb.Append("SetOpenerValue();");
        sb.Append("window.close();");
        sb.Append("<");
        sb.Append("/script>");

        //Part 2 Registering The ClientScriptBlock
        //Type t = this.GetType();

        //Check whether they are already registered
        if (!this.IsStartupScriptRegistered("SetOpenerValue_"))
        {
            //Register the script
            this.RegisterStartupScript("SetOpenerValue_", sb.ToString());
        }
    }


    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            hUserID.Value = Request.Form["radSelect"].ToString().Trim();
        }
        catch (Exception ex) { }
        JavaScriptProc();
    }
}
