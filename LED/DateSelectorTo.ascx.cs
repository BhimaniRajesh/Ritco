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

public partial class include_DateSelector : System.Web.UI.UserControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //DateTime dt = DateTime.Now;
        //string date = dt.ToString("dd/MM/yyyy");
        //txt_Date.Text = date;
        string dateid = txt_Date.ClientID;
        
        string scriptStr = "javascript:return popUpCalendar(this," + dateid + @", 'dd/mm/yyyy', '__doPostBack(\'" + dateid + @"\')')";
        imgCalendar.Attributes.Add("onclick", scriptStr);
    }
    public string getClientID()
    {
        string dateid=txt_Date.ClientID;
        return dateid;
    }

    // This propery sets/gets the calendar date
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
