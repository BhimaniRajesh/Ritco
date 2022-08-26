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

public partial class GUI_Operation_DocketEditFields_DocketEditFieldSelect : System.Web.UI.Page
{
    static string dockno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        dockno = Request.QueryString["dockno"].ToString();
        if (Session["client"].ToString().ToUpper().CompareTo("VARUNA")!= 0)
        {
            optrequestlist.Items[2].Enabled = false;
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("DocketEditFields.aspx?dockno=" + dockno + "&requestcode=" + optrequestlist.SelectedValue);
    }
}
