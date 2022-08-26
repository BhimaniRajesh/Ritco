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

public partial class GUI_Fleet_Job_AckJobResult : System.Web.UI.Page
{
    string OrderNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        OrderNo = Request.QueryString["OrderNo"];

        lblDocNo.Text = OrderNo;
    }
}
