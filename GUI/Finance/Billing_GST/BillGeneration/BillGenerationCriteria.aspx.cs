using System;
using System.Data;
using System.Web.Services;
using System.Linq;

public partial class GUI_Finance_Billing_GST_Billgeneration_BillGenerationCriteria : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        uMsgBox.Hide();
        if (IsPostBack || IsCallback) return;

        CreateToken();
        BindTransactionCategory();
        BindBusinessType();
    }

    protected void BindTransactionCategory()
    {
        var objBillGen = new BillGenerationGST();
        ddlTransactionCategory.DataSource = objBillGen.GetTransactionType();
        ddlTransactionCategory.DataTextField = "TransactionCategoryDesc";
        ddlTransactionCategory.DataValueField = "TransactionCategory";
        ddlTransactionCategory.DataBind();
    }
    protected void BindBusinessType()
    {
        var objBillGen = new BillGenerationGST();
        var dt = objBillGen.GetBusinessType();
        if (dt.Tables[0].Rows.Count > 0)
        {
            hidBusinessTypeRuleYesNo.Value = dt.Tables[0].Rows[0]["Rule"].ToString();
        }
        if (dt.Tables[2].Rows.Count > 0)
        {
            if (dt.Tables[2].Rows[0]["Rule"].ToString() == "Y")
                ddlLocationState.Enabled = true;
        }
        if (hidBusinessTypeRuleYesNo.Value == "Y")
        {
            trBusinessType.Visible = true;
            ddlBusinessType.DataSource = dt.Tables[1];
            ddlBusinessType.DataTextField = "CodeDesc";
            ddlBusinessType.DataValueField = "CodeID";
            ddlBusinessType.DataBind();
        }
        else
            trBusinessType.Visible = false;
    }

    protected void btnGetList_Click(object sender, EventArgs e)
    {
        if (IsValidated())
        {
            string quryString = "";
            quryString = quryString + "TransactionType=" + ddlTransactionType.SelectedValue;
            quryString = quryString + "&TransactionCategory=" + ddlTransactionCategory.SelectedValue;
            quryString = quryString + "&FromDate=" + dtBookingDate.FromDate;
            quryString = quryString + "&ToDate=" + dtBookingDate.ToDate;
            quryString = quryString + "&CustomerCode=" + txtCustomerCode.Text;
            quryString = quryString + "&CustomerState=" + ddlCustomerState.SelectedValue;

            if (ddlTransactionType.SelectedValue == "1")
                Response.Redirect("FreightBillGeneration.aspx?" + quryString, false);
            else if (ddlTransactionType.SelectedValue == "2")
                Response.Redirect("SupplementaryBillGeneration.aspx?" + quryString, false);
        }
    }

    protected bool IsValidated()
    {
        if (ddlTransactionCategory.SelectedValue.Trim() == "" && ddlTransactionType.SelectedValue.Trim() == "1")
        {
            uMsgBox.Show("Please select Transaction Category.");
            return false;
        }
        if (txtCustomerCode.Text.Trim() == "")
        {
            uMsgBox.Show("Please select valid Customer.");
            return false;
        }
        if (ddlCustomerState.SelectedValue.Trim() == "" && ddlTransactionType.SelectedValue.Trim() == "1")
        {
            uMsgBox.Show("Please select State.");
            return false;
        }
        return true;
    }
    protected void txtCustomerCode_TextChanged(object sender, EventArgs e)
    {
        try
        {
            var objBillGen = new BillGenerationGST();
            ddlCustomerState.DataSource = objBillGen.GetStateCustomerWise(txtCustomerCode.Text.Trim());
            ddlCustomerState.DataTextField = "Name";
            ddlCustomerState.DataValueField = "Code";
            ddlCustomerState.DataBind();
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.ToString());
        }
    }
    [WebMethod]
    public static string GetDocketDetails(string TransactionType, string TransactionCategory, string FromDate, string ToDate, string CustomerCode, string StateCode, string LocationState, string BusinessType)
    {
        try
        {
            if (BusinessType == "undefined")
                BusinessType = "";
            var tv = new BillGenerationGST_AccCodeValidation();
            var oGSTMasterController = new BillGenerationGST();
            var oBillGenerationGST_Entity = new BillGenerationGST_Entity();
            oBillGenerationGST_Entity.FromDate = FromDate;
            oBillGenerationGST_Entity.ToDate = ToDate;
            oBillGenerationGST_Entity.CustomerCode = CustomerCode;
            oBillGenerationGST_Entity.Location = SessionUtilities.CurrentBranchCode;
            oBillGenerationGST_Entity.Paybas = "P02";
            string[] TransactionCategoryArr = TransactionCategory.Split('~');
            oBillGenerationGST_Entity.ServiceType = TransactionCategoryArr[0];
            oBillGenerationGST_Entity.ProductType = TransactionCategoryArr[1];
            oBillGenerationGST_Entity.SACType = TransactionCategoryArr[2];
            oBillGenerationGST_Entity.InterState = false;
            oBillGenerationGST_Entity.ITC = false;
            oBillGenerationGST_Entity.GSTRate = 0;
            oBillGenerationGST_Entity.BillSubmissionState = StateCode;
            oBillGenerationGST_Entity.CompanyCode = SessionUtilities.DefaultCompanyCode;
            oBillGenerationGST_Entity.BillCollectionLocation = LocationState;
            oBillGenerationGST_Entity.BusinessType = BusinessType;
            var dtResult = oGSTMasterController.GetDocketCount(oBillGenerationGST_Entity);
            if (dtResult.Rows.Count == 0)
                return "";
            tv.CountFlag = Convert.ToString(dtResult.Rows[0]["CNT"]) != "0" ? "true" : "false";
            return JsonHelper.JavaScriptSerialize(tv);
        }
        catch (Exception ex)
        {
            return "";
        }
    }
    [WebMethod]
    public static string GetCustomerState(string customercode)
    {
        try
        {
            var objBill = new BillGenerationGST();
            var dtCustomerState = objBill.GetStateCustomerWise(customercode);
            var items = dtCustomerState.AsEnumerable().Select(row =>
                        new BillGenerationGST_CustomerState()
                        {
                            Code = row.Field<string>("Code"),
                            Name = row.Field<string>("Name")
                        }).ToList();

            return JsonHelper.JavaScriptSerialize(items);
        }
        catch (Exception ex)
        {
            return "";
        }
    }
}