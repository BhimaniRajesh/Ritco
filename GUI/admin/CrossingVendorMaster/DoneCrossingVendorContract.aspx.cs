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

public partial class GUI_admin_CrossingVendorMaster_DoneCrossingVendorContract : System.Web.UI.Page
{
    string ContractNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        ContractNo = Request.QueryString["ContractNo"].ToString();
        lblContractNo.Text = ContractNo;
    }

}
