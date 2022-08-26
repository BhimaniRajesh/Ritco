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

public partial class GUI_finance_chqMgt_depositVoucher_done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //string chqno = Request.QueryString["chqNo"];
            //string chqdate = Request.QueryString["chqDate"];
            lblDocNameVal.Text = "Cheque Deposite";

            //  Change by DP (7th Jan 2007)
            //lblDocNoVal.Text = chqno.Replace("~", ",");
            lblDocNoVal.Text = Request.QueryString["voucherNo"];
        }
    }
}
