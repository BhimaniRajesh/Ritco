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
using System.Collections.Generic;

public partial class GUI_admin_CustomerContractMaster_CustomerContractView : System.Web.UI.Page
{
    string strContractID = "";       
    string ConnStr = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        ConnStr = SessionUtilities.ConnectionString;
        strContractID = Request.QueryString["contractid"].ToString();
        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = strContractID;
        if (!IsPostBack & !IsCallback)
        {
            ucOCP.ContractID = strContractID;
            ucVCCS.CustomerContractID = strContractID;
            ucSSV.ContractID = strContractID;
            ucFTL.ContractID = strContractID;
            ViewODACharges.ContractID = strContractID;
        }
    }    
    protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        multiTabs.ActiveViewIndex = Int32.Parse(e.Item.Value);
    }
}
