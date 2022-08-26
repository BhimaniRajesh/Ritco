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

public partial class admin_TyreSizeResult : System.Web.UI.Page
{
    string SIZEName = "", SIZEID = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        SIZEID = Request.QueryString["SIZE_ID"];
        SIZEName = Request.QueryString["SizeName"];
        lblDocNo.Text = SIZEID + '/' + SIZEName;
    }
}
