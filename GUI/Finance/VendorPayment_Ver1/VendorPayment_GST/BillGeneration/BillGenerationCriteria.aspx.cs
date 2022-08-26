using System;
using System.Data;
using System.Web.Services;
using System.Linq;

public partial class GUI_Finance_VendorPayment_GST_Billgeneration_BillGenerationCriteria : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        uMsgBox.Hide();
        if (IsPostBack || IsCallback) return;

        hdnCompanyCode.Value = SessionUtilities.DefaultCompanyCode.Trim();

        CreateToken();
        BindTransactionCategory();
    }

    protected void BindTransactionCategory()
    {
        //var objBillGen = new BillGenerationGST();
        //ddlTransactionCategory.DataSource = objBillGen.GetTransactionType();
        //ddlTransactionCategory.DataTextField = "TransactionCategoryDesc";
        //ddlTransactionCategory.DataValueField = "TransactionCategory";
        //ddlTransactionCategory.DataBind();
    }

    protected void btnGetList_Click(object sender, EventArgs e)
    {
        if (IsValidated())
        {
            string quryString = "";
            quryString = quryString + "TransactionType=" + ddlTransactionType.SelectedValue;
            //quryString = quryString + "&TransactionCategory=" + ddlTransactionCategory.SelectedValue;
            quryString = quryString + "&TransactionCategory=";
            quryString = quryString + "&FromDate=" + dtBookingDate.FromDate;
            quryString = quryString + "&ToDate=" + dtBookingDate.ToDate;
            quryString = quryString + "&VendorCode=" + txtVendorCode.Text.Trim();
            //quryString = quryString + "&CustomerState=" + ddlCustomerState.SelectedValue;

            if (ddlTransactionType.SelectedValue == "1")
                Response.Redirect("FreightBillGeneration.aspx?" + quryString, false);
            else if (ddlTransactionType.SelectedValue == "2")
                Response.Redirect("VendorGeneralBillGeneration.aspx?" + quryString, false);
        }
    }

    protected bool IsValidated()
    {
        //if (ddlTransactionCategory.SelectedValue.Trim() == "" && ddlTransactionType.SelectedValue.Trim() == "1")
        //{
        //    uMsgBox.Show("Please select Transaction Category.");
        //    return false;
        //}
        if (txtVendorCode.Text.Trim() == "")
        {
            uMsgBox.Show("Please select valid Vendor.");
            return false;
        }
        //if (ddlCustomerState.SelectedValue.Trim() == "" && ddlTransactionType.SelectedValue.Trim() == "1")
        //{
        //    uMsgBox.Show("Please select State.");
        //    return false;
        //}
        return true;
    }
    protected void txtCustomerCode_TextChanged(object sender, EventArgs e)
    {
        try
        {
            //var objBillGen = new BillGenerationGST();
            //ddlCustomerState.DataSource = objBillGen.GetStateCustomerWise(txtCustomerCode.Text.Trim());
            //ddlCustomerState.DataTextField = "Name";
            //ddlCustomerState.DataValueField = "Code";
            //ddlCustomerState.DataBind();
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.ToString());
        }
    }
    [WebMethod]
    public static string GetDocketDetails(string TransactionType, string TransactionCategory, string FromDate, string ToDate, string CustomerCode, string StateCode)
    {
        try
        {
            var tv = new VendorBillGenerationGST_AccCodeValidation();
            var oGSTMasterController = new VendorBillGenerationGST();
            var oBillGenerationGST_Entity = new VendorBillGenerationGST_Entity();
            oBillGenerationGST_Entity.FromDate = FromDate;
            oBillGenerationGST_Entity.ToDate = ToDate;
            oBillGenerationGST_Entity.VendorCode = CustomerCode;
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
    public static string GetSupplyState(string strVendorCode, string strGstChargeCode)
    {
        try
        {
            var objBill = new VendorBillGenerationGST();
            var dtCustomerState = objBill.GetSupplyState(strVendorCode, strGstChargeCode);
            var items = dtCustomerState.AsEnumerable().Select(row =>
                        new VendorBillGenerationGST_CustomerState()
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

    [WebMethod]
    public static string GetBookingState(string strVendorCompanyCode, string strGstChargeCode)
    {
        try
        {
            var objBill = new VendorBillGenerationGST();
            var dtCustomerState = objBill.GetBookingState(strVendorCompanyCode, strGstChargeCode);
            var items = dtCustomerState.AsEnumerable().Select(row =>
                        new VendorBillGenerationGST_CustomerState()
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