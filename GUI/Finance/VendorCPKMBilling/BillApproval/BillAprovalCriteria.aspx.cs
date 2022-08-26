using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        if (!IsPostBack)
        {
            BindVendor();
        }
    }

    public void BindVendor()
    {
        try
        {
            var objVehicleCPKMController = new VehicleCPKMController();
            ddlVendor.DataSource = objVehicleCPKMController.GetAllCPKMVendor("");
            ddlVendor.DataTextField = "VENDORNAME";
            ddlVendor.DataValueField = "VENDORCODE";
            ddlVendor.DataBind();
            ddlVendor.Items.Insert(0,new ListItem("All",""));
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex,"GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->BindVendor");
        }
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        try
        {
            string fromDate = RPT_Date.FromDate;
            string toDate = RPT_Date.ToDate;
            var objVendorCPKMBillController = new VendorCPKMBillController();
            gvCPKMBillDT.DataSource = objVendorCPKMBillController.GetCPKMBillList(fromDate, toDate,
                ddlVendor.SelectedValue,"");
            gvCPKMBillDT.DataBind();
            trsubbtn.Attributes.Remove("style");
        }
        catch (Exception ex)
        {
            
           ExceptionUtility.LogException(ex,"GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->btnSearch_OnClick");;
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        umsg.Hide();
        try
        {
            int i = 0;
            foreach (GridViewRow dr in gvCPKMBillDT.Rows)
            {
                var rbBill = (RadioButton) dr.FindControl("rbBill");
                var lblBillNo = (Label)dr.FindControl("lblBillNo");

                if (rbBill.Checked)
                {
                    i++;
                    Response.Redirect("BillApprovalDetail.aspx?BillNo="+lblBillNo.Text, false);
                }

                
            }
            if (i == 0)
            {
                throw  new Exception("Please select Row");
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}