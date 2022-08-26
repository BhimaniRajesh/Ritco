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
    protected Label lbl_Date;
    //protected TextBox txt_Date;
    //protected Image imgCalendar;
    protected void Page_Load(object sender, EventArgs e)
    {
        string scriptStr = "javascript:return popUpCalendar(this," + getClientID() + @", 'dd/mm/yyyy', '__doPostBack(\'" + getClientID() + @"\')')";
        txt_Date.Attributes.Add("onclick", scriptStr);
    }
    public string getClientID()
    {
        return txt_Date.ClientID;
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
    // This Property sets or gets the the label for 
    // Dateselector user control
    //public string Text
    //{
    //    //get
    //    //{
    //        //return lbl_Date.Text;
    //    //}
    //    //set
    //    //{
    //        //lbl_Date.Text = value;
    //    //}
    //}

}
