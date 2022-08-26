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

public partial class Finance_Billing_Billcollection_BillMrDone : System.Web.UI.Page
{
    public static string mrsno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        mrsno = Request.QueryString.Get("mrsno");
        lblbillno.Text = mrsno.ToString();
    }
}
