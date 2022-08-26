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

public partial class MainContractMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());

            objTripSheet.BindDropDown(ddl_Contract_Type, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('CNTYP') And StatusCode='Y'");
            objTripSheet.BindDropDown(ddl_Customer, "Select CUSTCD,CUSTCD+' : '+CUSTNM AS CUSTNM from webx_CUSTHDR  where CUST_ACTIVE='Y'");
        }
    }
    protected void btnnext_Click(object sender, EventArgs e)
    {
        Response.Redirect("ContractEditList.aspx?Customer_Code=" + ddl_Customer.SelectedValue + "&Contract_Type=" + ddl_Contract_Type.SelectedValue);
    }
}
