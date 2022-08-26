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

public partial class DateCalendar : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    public void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        PopupControlExtender1.Commit(useDateCal, Calendar1.SelectedDate.ToString("dd/MM/yyyy"));
    }
    public string CalenderText()
    {
        return useDateCal.Text;
    }

    public string SetCalenderText(string dt)
    {
        
        useDateCal.Text = dt;
        return useDateCal.Text;
    }
}
