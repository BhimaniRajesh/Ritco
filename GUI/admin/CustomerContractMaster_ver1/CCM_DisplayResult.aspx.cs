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

public partial class GUI_admin_CustomerContractMaster_CCM_DisplayResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblHeader.InnerHtml = "<b>Customer Contract Master - Display Result<b>";
        lblCCM.InnerHtml = "Customer Contract Master";
        HidContractID.Value = Request.QueryString["contractid"].ToString();
        lblCCMNo.InnerHtml = Request.QueryString["contractid"].ToString();
        lblVPCCM.Attributes.Add("onclick","javascript:return window.open('ViewContract.aspx?contractid=" + HidContractID.Value +  "')");
    }
}
