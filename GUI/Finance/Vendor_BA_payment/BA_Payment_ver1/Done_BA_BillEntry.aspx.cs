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

public partial class GUI_Finance_Vendor_BA_payment_BA_Payment_ver1_Done_BA_BillEntry : System.Web.UI.Page
{
    public static string docno;
    protected void Page_Load(object sender, EventArgs e)
    {
        docno = Request.QueryString.ToString().Replace("%2f", "/");
        lbldocno.Text = docno;
    }
}
