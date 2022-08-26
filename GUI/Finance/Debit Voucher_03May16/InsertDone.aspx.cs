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

public partial class GUI_Finance_Credit_Voucher_InsertDone : System.Web.UI.Page
{
    public string VoucherDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        VoucherDate = Request.QueryString["VoucherDate"].ToString();
    }
}
