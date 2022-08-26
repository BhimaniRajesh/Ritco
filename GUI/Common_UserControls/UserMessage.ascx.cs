using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Common_UserControls_UserMessage : System.Web.UI.UserControl
{
    public string Title
    {
        get { return lbltitle.Text; }
        set { lbltitle.Text = value; }
    }

    public string Message
    {
        get { return lblmessage.Text; }
        set { lblmessage.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        btnok.Attributes.Add("onclick", "javascript:return closeAlert('" + divbg.ClientID + "','" + divmsg.ClientID + "')");
    }

    public void Show()
    {
        divbg.Visible = true;
        divmsg.Visible = true;
    }

    public void Hide()
    {
        divbg.Visible = false;
        divmsg.Visible = false;
    }

    public void Show(string title, string message)
    {
        Title = title;
        Message = message;
        
        divbg.Visible = true;
        divmsg.Visible = true;
    }

    public void Show(string message)
    {
        Title = "Message";
        Message = message;
        divbg.Visible = true;
        divmsg.Visible = true;
    }

}
