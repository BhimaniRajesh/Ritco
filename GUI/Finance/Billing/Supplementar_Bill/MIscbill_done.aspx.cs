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

public partial class Finance_Billing_Billsubmission_Billsub_Step2 : System.Web.UI.Page
{
    //string billnos = Request.QueryString["Billno"].ToString();
    public string billnos = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        billnos = Request.QueryString["Billno"];
        lblbillno.Text = billnos.ToString();
        
    }
}
