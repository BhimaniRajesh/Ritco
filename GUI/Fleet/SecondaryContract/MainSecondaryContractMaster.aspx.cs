using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

public partial class MainSecondaryContractMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillCustomer();
        }
    }

    public void FillCustomer()
    {
        string sqlstr = "Select CUSTCD,CUSTCD+' : '+CUSTNM AS CUSTNM from webx_CUSTHDR  where CUST_ACTIVE='Y' ";
        Secondary_Contract objSecContract = new Secondary_Contract(Session["SqlProvider"].ToString());
        objSecContract.BindDropDown(ddlcustomer, sqlstr);

        trnext.Visible = true;
        trcust.Visible = true;
    }

    protected void btnnext_Click(object sender, EventArgs e)
    {
        Response.Redirect("ContractEditList.aspx?Customer_Code=" + ddlcustomer.SelectedValue);
    }
}
