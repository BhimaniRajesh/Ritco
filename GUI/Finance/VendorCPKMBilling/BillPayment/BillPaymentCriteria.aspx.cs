using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_VendorCPKMBilling_BillPayment_BillPaymentCriteria : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        if (!IsPostBack)
        {
            CreateToken();
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
            //ddlVendor.Items.Insert(0, new ListItem("All", ""));
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->BindVendor");
        }
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        try
        {
            string fromDate = RPT_Date.FromDate;
            string toDate = RPT_Date.ToDate;
            var objVendorCPKMBillController = new VendorCPKMBillController();
			var dt =objVendorCPKMBillController.GetCPKMBillPaymentList(fromDate, toDate, ddlVendor.SelectedValue, txtBillNo.Text);
			//txtTDSAmount.Text=dt.Rows[0]["TDSAmount"].ToString();
            gvCPKMBillDT.DataSource = dt;
            gvCPKMBillDT.DataBind();

            if (gvCPKMBillDT.Rows.Count > 0)
            {
                tr1.Attributes.Remove("style");
                trsubbtn.Attributes.Remove("style");
                trTotal.Attributes.Remove("style");

                btnSearch.Enabled = false;


                var objVehicleCPKMController = new VehicleCPKMController();
                ddlConfirmVendor.DataSource = objVehicleCPKMController.GetAllCPKMVendor("");
                ddlConfirmVendor.DataTextField = "VENDORNAME";
                ddlConfirmVendor.DataValueField = "VENDORCODE";
                ddlConfirmVendor.DataBind();

                ddlBank.DataSource = objVehicleCPKMController.GetBankDetails();
                ddlBank.DataTextField = "Accdesc";
                ddlBank.DataValueField = "Acccode";
                ddlBank.DataBind();
                ddlBank.Items.Insert(0, new ListItem("-Select-", ""));

                lblCreditVendor.Text = ddlVendor.SelectedItem.Text;
            }
        }
        catch (Exception ex)
        {

            ExceptionUtility.LogException(ex, "GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria->btnSearch_OnClick"); ;
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        umsg.Hide();
        try
        {
            if (IsTokenValid())
            {
                var objcls_VehicleCPKM_BillGeneration = new cls_VehicleCPKM_BillPayment();
                objcls_VehicleCPKM_BillGeneration.TotalBillAmount = txtTotalBill.Text;
                objcls_VehicleCPKM_BillGeneration.FinalRebateAmount = txtRebateAmount.Text;
                objcls_VehicleCPKM_BillGeneration.NetBill = hdnNetTotalbillAmount.Value;
                objcls_VehicleCPKM_BillGeneration.TDSAmount = txtTDSAmount.Text;

                objcls_VehicleCPKM_BillGeneration.BankOption = ddlOption.SelectedItem.Text;
                objcls_VehicleCPKM_BillGeneration.Amount = txtAmount.Text;
                objcls_VehicleCPKM_BillGeneration.CreditAmount = txtCreditAmount.Text;
                objcls_VehicleCPKM_BillGeneration.InstrumentDate = txtFromDate.Text;
                objcls_VehicleCPKM_BillGeneration.InstrumentNo = txtInstrumentNo.Text;
                objcls_VehicleCPKM_BillGeneration.BankCode = ddlBank.SelectedItem.Value;
                objcls_VehicleCPKM_BillGeneration.CreditAccount = ddlVendor.SelectedItem.Value;
                objcls_VehicleCPKM_BillGeneration.ConfirmedCreditAccount = ddlVendor.SelectedItem.Value;
                objcls_VehicleCPKM_BillGeneration.NetPaybleAmount =  hdnNetTotalbillAmount.Value;



                var ocls_VehicleCPKM_BillGeneration = new List<cls_VehicleCPKM_BillPayment>();
                var objVendorCPKMBillController = new VendorCPKMBillController();
                foreach (GridViewRow grvDet in gvCPKMBillDT.Rows)
                {
                    var obj = new cls_VehicleCPKM_BillPayment();

                    var chkVehicleNo = (CheckBox)grvDet.FindControl("chkVehicleNo");
                    var hdnVendorCode = (HiddenField)grvDet.FindControl("hdnVendorCode");
                    var lblVendorName = (Label)grvDet.FindControl("lblVendorName");
                    var lblBillNo = (Label)grvDet.FindControl("lblBillNo");
                    var lblNoOfVehicle = (Label)grvDet.FindControl("lblNoOfVehicle");
                    var lblBillAmount = (Label)grvDet.FindControl("lblBillAmount");
                  



                    if (chkVehicleNo.Checked)
                    {
                        obj.VendorName = lblVendorName.Text;
                        obj.VendorCode = hdnVendorCode.Value;
                        obj.NetBillAmount = lblBillAmount.Text;
                        obj.NoVehicle = lblNoOfVehicle.Text;
                        obj.BillNo = lblBillNo.Text;
                        obj.EntryBy = SessionUtilities.CurrentEmployeeID;


                        ocls_VehicleCPKM_BillGeneration.Add(obj);
                    }
                }

                var dt = objVendorCPKMBillController.CPKMBillPayment(objcls_VehicleCPKM_BillGeneration, ocls_VehicleCPKM_BillGeneration);
                string VoucherNo = "";
                string VendorName = "";
                string FleetCenter = "";
                string VoucherDate = ""; string Vehicle = ""; string BillAmount = "";
                if (dt.Rows.Count > 0)
                {
                    VoucherNo = Convert.ToString(dt.Rows[0]["VoucherNo"]);
                    VendorName = Convert.ToString(dt.Rows[0]["VendorName"]);
                    FleetCenter = Convert.ToString(dt.Rows[0]["FleetCenter"]);
                    VoucherDate = Convert.ToString(dt.Rows[0]["VoucherDate"]);
                    Vehicle = Convert.ToString(dt.Rows[0]["NoVehicle"]);
                    BillAmount = Convert.ToString(dt.Rows[0]["NetAmount"]);
                }
                ConsumeToken();
                Response.Redirect("Done.aspx?VendorName=" + VendorName + "&FleetCenter=" + FleetCenter + "&VoucherNo=" + VoucherNo + "&VoucherDate=" + VoucherDate + "&Vehicle=" + Vehicle + "&BillAmount=" + BillAmount, false);
            }


        }
        catch (Exception ex)
        {
            umsg.Show(ex.Message);

        }
    }
}
