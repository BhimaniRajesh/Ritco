using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_Common_UserControls_DatePicker2 : System.Web.UI.UserControl
{
    private bool _Enabled = true;
    private bool _IsReadOnly = false;

    public bool AllowPastDate { get; set; }
    public bool AllowFutureDate { get; set; }
    public bool IsReadOnly { get { return _IsReadOnly; } set { _IsReadOnly = value; } }
    public bool Enabled { get { return _Enabled; } set { _Enabled = value; } }
    public string CssClass { get; set; }
    public string Text { get { return txtDate.Text; } set { txtDate.Text = value; } }
    public string TxtClientId { get { return txtDate.ClientID; } }


    public bool Required
    {
        get { return ViewState[ClientID + "Required"] != null && (bool)ViewState[ClientID + "Required"]; }
        set { ViewState[ClientID + "Required"] = value; }
    }


    public DateTime SelectedDate
    {
        get
        {
            return txtDate.Text.Trim() != ""
                ? Utility.ConvertToDateTime(txtDate.Text.Trim(), ConfigHelper.DateFormat)
                : DateTime.MinValue;
        }
        set
        {
            txtDate.Text = (value > DateTime.MinValue && value < DateTime.MaxValue)
                ? value.ToString(ConfigHelper.DateFormat)
                : "";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        txtDate.Attributes.Add("onBlur", "checkDate(this,'" + AllowFutureDate + "','" + AllowPastDate + "');");

        txtDate.ReadOnly = IsReadOnly;
        txtDate.Enabled = Enabled;



        if (!string.IsNullOrEmpty(Text)) { txtDate.Text = Text; }
        if (!string.IsNullOrEmpty(CssClass)) { txtDate.CssClass += " " + CssClass; }
        if (IsPostBack)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadOnCallBack_" + txtDate.ClientID, "LoadOnCallBack1($('#" + txtDate.ClientID + "'),'" + ConfigHelper.JSDateFormat + "','" + AllowFutureDate + "','" + AllowPastDate + "','" + ResolveClientUrl("~/GUI/images/calendar.png") + "');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadOnCallBack_" + txtDate.ClientID, "LoadOnCallBack('" + txtDate.ClientID + "');", true);
        }
    }
    public void HideTextBox()
    {
        ShowHideTextBox(false);
    }

    public void ShowTextBox()
    {
        ShowHideTextBox(true);
    }

    private void ShowHideTextBox(bool bChk)
    {
        if (bChk)
            txtDate.Style["display"] = "Block";
        else
            txtDate.Style["display"] = "None";
    }
}