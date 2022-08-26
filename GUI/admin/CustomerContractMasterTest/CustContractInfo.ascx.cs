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

public partial class GUI_admin_CustomerContractMaster_CustContractInfo : System.Web.UI.UserControl
{
    private string custcode = "", contractid = "";
    MyFunctions fn;
    public string CustCode
    {
        get { return custcode; }
        set { custcode = value; }
    }

    public string ContractID
    {
        get { return contractid; }
        set { contractid = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();
        lblcontractid.Text = ContractID;
        lblcustcodename.Text = CustCode + " : " + fn.Getcustomer(CustCode);
    }
}
