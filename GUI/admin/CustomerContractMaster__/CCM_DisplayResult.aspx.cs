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
        string strCCMMode = "";

        if (!IsPostBack)
        {
            HidContractID.Value = Request.QueryString["ContractID"];
            HidCustCodeName.Value = Request.QueryString["CustCodeName"];
            strCCMMode = Request.QueryString["CCMMode"];
        }

        lblCCM.InnerHtml = HidContractID.Value;
        //if (strCCMMode == "A")
        //{
        //    lblNote.InnerHtml = "<b>Following document has been successfully generated for the customer " + HidCustCodeName.Value + ".";
        //}
        //else if (strCCMMode == "E")
        //{
        //    lblNote.InnerHtml = "<b>Following document has been successfully updated for the customer " + HidCustCodeName.Value + ".";
        //}

        //lblHeader.InnerHtml = "<b>Customer Contract Master - " + (strCCMMode == "A" ? "New Contract" : "Edit Existing Contract") + "<b>";
        lblHeader.InnerHtml = "<b>Customer Contract Master - Display Result<b>";
        lblCCM.InnerHtml = "Customer Contract Master";
        lblCCMNo.InnerHtml = HidContractID.Value;
        lblManualCCMNo.InnerHtml = "";
        lblVPCCM.InnerHtml = "<a href=\"JavaScript:alert('Yet to be implemented!')\">View</a>&nbsp;|&nbsp;<a href=\"JavaScript:alert('Yet to be implemented!')\">Print</a>";
    }
}
