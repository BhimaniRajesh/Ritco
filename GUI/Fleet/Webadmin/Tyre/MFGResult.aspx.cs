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

public partial class admin_MFGResult : System.Web.UI.Page
{
    string MFGName = "",MFGID="";

    protected void Page_Load(object sender, EventArgs e)
    {

        MFGID = Request.QueryString["MFGID"];
        MFGName = Request.QueryString["MFGName"];
        lblDocNo.Text = MFGID + '/' + MFGName;
    }
}
