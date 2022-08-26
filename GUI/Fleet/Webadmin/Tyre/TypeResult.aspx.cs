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

public partial class admin_TypeResult : System.Web.UI.Page
{
    string TypeName = "", TYPE_ID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        TYPE_ID = Request.QueryString["TYPE_ID"];
        TypeName = Request.QueryString["TypeName"];
        lblDocNo.Text = TYPE_ID + '/' + TypeName;
    }
}
