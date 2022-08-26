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
    string custcode = "", contractid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        contractid = Request.QueryString["contractid"].ToString();
        custcode = Request.QueryString["custcode"].ToString();
        MyFunctions fn = new MyFunctions();
        lblcustcode.Text = custcode + " : " + fn.Getcustomer(custcode);
        lblcontractid.Text = contractid;

        lblview.Attributes.Add("onclick", "javascript:return window.open('ViewContract.aspx?contractid=" + contractid + "')");

    }
    protected void lnklist_Click(object sender, EventArgs e)
    {
        Response.Redirect("StepSelection.aspx?custcode=" + custcode + "&contractid=" + contractid);
    }

    protected void lnkcontract_Click(object sender, EventArgs e)
    {
        Response.Redirect("ContractEditList.aspx?custcode=" + custcode);
    }

    protected void lnkcustomer_Click(object sender, EventArgs e)
    {
        Response.Redirect("MainCustomerContractMaster.aspx");
    }
}
