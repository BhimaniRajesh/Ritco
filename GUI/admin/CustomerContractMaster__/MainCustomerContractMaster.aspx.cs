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

public partial class MainCustomerContractMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            populateCustomersForContract("Webx_SP_Get_Customers_For_Contract_Master_Add", ddlSelCustomerForAdd);
            populateCustomersForContract("Webx_SP_Get_Customers_For_Contract_Master_Edit_View", ddlSelCustomerForEdit);
            populateCustomersForContract("Webx_SP_Get_Customers_For_Contract_Master_Edit_View", ddlSelCustomerForView);

            ddlSelCustomerForAdd.Focus();
        }
    }

    private void populateCustomersForContract(string strSPName, DropDownList ddlCustomer)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = strSPName;
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
        DataSet dsCustomers = new DataSet();

        sqlDA.Fill(dsCustomers);

        ddlCustomer.DataTextField = "CustCDName";
        ddlCustomer.DataValueField = "CUSTCD";

        ddlCustomer.DataSource = dsCustomers;
        ddlCustomer.DataBind();

        ddlCustomer.Items.Insert(0, new ListItem("Select", "Select"));
    }

    protected void btnAddCustomerContract_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddCustomerContractStep1.aspx?CustomerCode=" + ddlSelCustomerForAdd.SelectedValue + "&CustomerCodeName=" + ddlSelCustomerForAdd.SelectedItem.Text);
    }

    protected void btnEditCustomerContract_Click(object sender, EventArgs e)
    {
        Response.Redirect("EditCustomerContractStep1.aspx?CustomerCode=" + ddlSelCustomerForEdit.SelectedValue + "&CustomerCodeName=" + ddlSelCustomerForEdit.SelectedItem.Text);
    }

    protected void btnViewCustomerContract_Click(object sender, EventArgs e)
    {
        Response.Redirect("ViewCustomerContractStep1.aspx?CustomerCode=" + ddlSelCustomerForView.SelectedValue + "&CustomerCodeName=" + ddlSelCustomerForView.SelectedItem.Text);
    }
}
