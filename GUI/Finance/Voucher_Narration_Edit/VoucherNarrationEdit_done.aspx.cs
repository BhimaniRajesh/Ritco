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

public partial class GUI_Finance_Voucher_Narration_Edit_VoucherNarrationEdit_done : System.Web.UI.Page
{
    public string docknos = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        docknos = Request.QueryString["vouchernos"].ToString();
        lblvouchernos.Text = docknos;
    }
}
