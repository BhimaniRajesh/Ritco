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

public partial class GUI_DatePicker : System.Web.UI.UserControl
{
    private string _imageUrl = "";
    private string _validationGroup = "";
    private bool _requied = false;
    private bool _enableRangeValidation = false;
    private string _minimumValue = DateTime.MinValue.ToString("dd/MM/yyyy");
    private string _maximumValue = DateTime.MaxValue.ToString("dd/MM/yyyy");
    private bool _readOnly = false;

    public string ImageUrl
    {
        get { return _imageUrl; }
        set { _imageUrl = value; }
    }

    public string SelectedDate
    {
        get{ return txtDtBox.Text; }
        set { txtDtBox.Text = value; }
    }
    public bool Enabled
    {
        get { return txtDtBox.Enabled; }
        set { txtDtBox.Enabled = value; }
    }
    public bool ReadOnly
    {
        get { return txtDtBox.Enabled; }
        set { txtDtBox.Enabled = value; }
    }
    public string ValidationGroup
    {
        get { return _validationGroup; }
        set { _validationGroup = value; }
    }
    public bool Required
    {
        get { return _requied; }
        set { _requied = value; }
    }
    public bool EnableRangeValidation
    {
        get { return _enableRangeValidation; }
        set { _enableRangeValidation = value; }
    }
    public string MaximumValue
    {
        get { return _maximumValue; }
        set { _maximumValue = value; }
    }
    public string MinimumValue
    {
        get { return _minimumValue; }
        set { _minimumValue = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (_imageUrl != "")
            lnkBtnCal.Text = "<img src='" + _imageUrl + "' border='0' alt='' />";
        else
            lnkBtnCal.Text = "<b>#</b>";
        string SD = "cal.select(document.aspnetForm." + txtDtBox.ClientID.ToString() + ",'" + lnkBtnCal.ClientID.ToString() + "','dd/MM/yyyy'); return false;";
        lnkBtnCal.Attributes.Add("onclick", SD);
        if (_requied)
        {
            lblRequired.Visible = true;
            ReqValidator1.Visible = true;
            ReqValidator1.Enabled = true;
            ReqValidator1.ValidationGroup = _validationGroup;
        }
        regexValidator.ValidationGroup = _validationGroup;

        if (EnableRangeValidation)
        {
            RangeValidator1.Enabled = true;
            RangeValidator1.Visible = true;
            RangeValidator1.MaximumValue = _maximumValue;
            RangeValidator1.MinimumValue = _minimumValue;
            RangeValidator1.ValidationGroup = _validationGroup;
        }
    }
}
