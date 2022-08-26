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

public partial class GUI_View_Track_Operation_Docket_DOcket_track : System.Web.UI.Page
{
    public static string call_dkt = "", str_dockno = "", str_docksf = "";
    protected void Page_Load(object sender, EventArgs e)
    {

         str_dockno = Request.QueryString["strDckNo"].ToString();
         str_docksf = Request.QueryString["strDcksf"].ToString();
        //call_dkt = Session["DocketCalledAs"].ToString();
    }
}
