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

public partial class GUI_Octroi_ViewnPrint_TypeMast : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick","javascript:return validateFields()");
        txtpaytypecode.Attributes.Add("onblur","javascript:return typeCheck()");
    }
}
