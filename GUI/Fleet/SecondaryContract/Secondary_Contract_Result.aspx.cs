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
using System.Data.SqlClient;
public partial class Secondary_Contract_Result : System.Web.UI.Page
{
    string custcode = "", contractid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        contractid = Request.QueryString["Contract_Code"].ToString();
        custcode = Request.QueryString["Customer_Code"].ToString();
        MyFunctions fn = new MyFunctions();
        string CustName = DataProvider.GetCustomerName(custcode);
        if (CustName == "")
        {
            hdnflagcstvnd.Value = "V";
            CustName = DataProvider.GetVendorName(custcode);
            lbl_customername.Text = "Vendor Name";
            lnkcustomer.Text = "Click to Edit another Vendor";

        }
        else
        {
            hdnflagcstvnd.Value = "C";
            lbl_customername.Text = "Customer Name";
            lnkcustomer.Text = "Click to Edit another Customer";
        }


        lblcustcode.Text = custcode + " : " + CustName;
        lblcontractid.Text = contractid;

        lblview.Attributes.Add("onclick", "javascript:return window.open('Secondary_Contract_View.aspx?Customer_Code=" + custcode + "&Contract_Code=" + contractid + "','','scrollbars=yes,resizable=yes,statusbar=yes,width=1000,height=600')");
    }
    protected void lnklist_Click(object sender, EventArgs e)
    {
        Response.Redirect("StepSelection.aspx?Customer_Code=" + custcode + "&Contract_Code=" + contractid);
    }

    protected void lnkcontract_Click(object sender, EventArgs e)
    {
        Response.Redirect("ContractEditList.aspx?Customer_Code=" + custcode);
    }

    protected void lnkcustomer_Click(object sender, EventArgs e)
    {
        if (hdnflagcstvnd.Value == "C")
            Response.Redirect("MainContractMaster.aspx");
        else
            Response.Redirect("../Vendor_Contract_ver1/vendorContract_Step1.aspx");
    }
}
