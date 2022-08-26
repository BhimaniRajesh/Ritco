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
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operation_Singlescreen_DocketPrint_DocketView_xls : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string dockno = "", docksf = "";

        dockno = Request.QueryString["dockno"].ToString();
        docksf = Request.QueryString["docksf"].ToString();

		Response.Redirect("../../DocketEntry/DocketPrint/DocketView_Xls.aspx?dockno=" + dockno  + "&docksf=" + docksf);
        return;


    }
}
