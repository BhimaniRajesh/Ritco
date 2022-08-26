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

public partial class UserControls_DatePicker : System.Web.UI.UserControl
{
    public string Text { get { return tb_Date.Text; } set { tb_Date.Text = value; } }
    public string ClientID { get { return tb_Date.ClientID; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        img_Calendar.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + tb_Date.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + tb_Date.ClientID + @"\')')");
    }
}
