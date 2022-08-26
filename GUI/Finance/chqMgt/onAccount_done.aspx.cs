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

public partial class GUI_finance_chqMgt_onAccount_done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string chqno = Request.QueryString["chqno"];
            string chqdate = Request.QueryString["chqdate"];
            lblDocNameVal.Text = "Cheque Entry";
            lblDocNoVal.Text = chqno;
        }
    }
}
