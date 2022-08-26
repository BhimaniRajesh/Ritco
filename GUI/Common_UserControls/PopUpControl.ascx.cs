using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class GUI_Common_UserControls_PopUpControl : System.Web.UI.UserControl
{
    private string _Header_Text = "";
    public string Header_Text { get { return _Header_Text; } set { _Header_Text = value; } }

    private bool _ReadOnly = false;
    public bool ReadOnly { get { return _ReadOnly; } set { _ReadOnly = value; } }

    private string _Table_Name = "";
    public string Table_Name { get { return _Table_Name; } set { _Table_Name = value; } }

    private string _Value_Field = "";
    public string Value_Field { get { return _Value_Field; } set { _Value_Field = value; } }

    private string _Text_Field = "";
    public string Text_Field { get { return _Text_Field; } set { _Text_Field = value; } }

    private string _Active_Flag_Field = "";
    public string Active_Flag_Field { get { return _Active_Flag_Field; } set { _Active_Flag_Field = value; } }

    private string _Height = "";
    public string Height { get { return _Height; } set { _Height = value; } }

    private string _Width = "";
    public string Width { get { return _Width; } set { _Width = value; } }

    // Webx_General_Master Purpose
    private string _CodeType = "";
    public string CodeType { get { return _CodeType; } set { _CodeType = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbl_Hdr_Text.Text = Header_Text;
            tb_TextBox.ReadOnly = ReadOnly;
            btn_PopUp.Attributes.Add("OnClick", "window.open('popup_MultiValueSelection.aspx?Header=" + Header_Text + "&OpenerCtl=" + tb_TextBox.ClientID + "&TableName=" + Table_Name + "&ValueField=" + Value_Field + "&TextField=" + Text_Field + "&ActiveFlagField=" + Active_Flag_Field + "&CodeType="+ CodeType +"&width=" + Width + "',null,'left=300, top=150, height=" + Height + ", width=" + Width + ", status=no, resizable=no, scrollbars=no, toolbar=no,location=no, menubar= no');return false;");
        }
    }
}
