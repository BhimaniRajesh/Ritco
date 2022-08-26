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

public partial class WebUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string dateid = txt_Date.ClientID;

        string scriptStr = "javascript:return popUpCalendar(this," + dateid + @", 'dd/mm/yyyy', '__doPostBack(\'" + dateid + @"\')')";
        imgCalendar.Attributes.Add("onclick", scriptStr);
    }
    //protected void Name_Change(object sender, EventArgs e)
    //{

    //    txt_Date.Text = SetClientID();
    //}
    public string SetClientID()
    {
        string dateid = txt_Date.ClientID;
        return dateid;
    }
    public string getValue()
    {
        return txt_Date.Text;
    }
    public string CalendarDate
    {
        get
        {
            return txt_Date.Text;
        }
        set
        {
            txt_Date.Text = value;
        }
    }
}
