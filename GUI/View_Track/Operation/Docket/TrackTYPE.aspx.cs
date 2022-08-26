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

public partial class GUI_View_Track_Operation_Docket_TrackTYPE : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string str_dockno = Request.QueryString["strDckNo"].ToString();
        string str_docksf = Request.QueryString["strDcksf"].ToString();
        
        Response.Write("<br>str_dockno : " + str_dockno);
        Response.Write("<br>TYP : " + TYP);

    }
}
