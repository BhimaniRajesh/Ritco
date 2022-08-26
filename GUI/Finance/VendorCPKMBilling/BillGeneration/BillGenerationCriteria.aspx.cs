using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_VendorCPKMBilling_BillGeneration_BillGenerationCriteria : BasePage
{
    private DataTable VendorsList
    {
        get { return (ViewState["VendorsList"] != null) ? ViewState["VendorsList"] as DataTable : new DataTable(); }
        set { ViewState["VendorsList"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        if (!IsPostBack)
        {
            txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            VendorsList = Vendor_Contract.GetVendors();
            CreateToken();
            for (int iLoop = 1900; iLoop <= DateTime.Now.Year; iLoop++)
            {
                ddlYear.Items.Add(iLoop.ToString());
            }
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();
            ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
        }
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        BindGrid(txtVedor.SelectedValue, ddlMonth.SelectedValue, ddlYear.SelectedValue, txtDateFrom.Text, txtDateTo.Text);
    }
    protected void btnSearch_DatewiseOnclick(object sender, EventArgs e)
    {
        BindGrid(txtVedor.SelectedValue, ddlMonth.SelectedValue, ddlYear.SelectedValue, txtDateFrom.Text, txtDateTo.Text);
    }
    public void BindGrid(string VendorCode, string month, string Year, string FromDate, string ToDate)
    {
        var objVendorCPKMBillController = new VendorCPKMBillController();
        string[] strDtFrom = FromDate.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = ToDate.Split('/');
        DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        var startdate1 = d1.ToString("dd MMM yyyy");
        var EndDate1 = d2.ToString("dd MMM yyyy");
        gvCPKMBillDT.DataSource = objVendorCPKMBillController.GetVendorCPKMBillDetailsForGeneration(VendorCode, month, Year, startdate1, EndDate1);
        gvCPKMBillDT.DataBind();

        if (gvCPKMBillDT.Rows.Count > 0)
        {
            trGv.Attributes.Remove("style");
            trTotal.Attributes.Remove("style");
            trsubbtn.Attributes.Remove("style");
            //txtVehicleNo.Enabled = false;
            btnSearch.Enabled = false;

        }else {
            umsg.Show("No record found !!");
            return;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (IsTokenValid())
            {
                var objcls_VehicleCPKM_BillGeneration = new cls_VehicleCPKM_BillGeneration();
                objcls_VehicleCPKM_BillGeneration.Subtotal = hdnSubTotal.Value;
                objcls_VehicleCPKM_BillGeneration.MiscTotal = hdnMiscAmount.Value;
                objcls_VehicleCPKM_BillGeneration.TotalAmount = hdnTotalbillAmount.Value;
                objcls_VehicleCPKM_BillGeneration.BillingMonth = ddlMonth.SelectedValue;
                objcls_VehicleCPKM_BillGeneration.BillingYear = ddlYear.SelectedValue;
                objcls_VehicleCPKM_BillGeneration.TDSAmount = Convert.ToDecimal(txtTDSAmount.Text == "" ? "0" : txtTDSAmount.Text);

                var ocls_VehicleCPKM_BillGeneration = new List<cls_VehicleCPKM_BillGeneration>();
                var objVendorCPKMBillController = new VendorCPKMBillController();
                
                foreach (GridViewRow grvDet in gvCPKMBillDT.Rows)
                {
                    var obj = new cls_VehicleCPKM_BillGeneration();

                    var chkVehicleNo = (CheckBox)grvDet.FindControl("chkVehicleNo");
                    var lblVehicleNo = (Label)grvDet.FindControl("lblVehicleNo");
                    var lblPreviousTripNo = (Label)grvDet.FindControl("lblPreviousTripNo");
                    var lblOpeningKM = (Label)grvDet.FindControl("lblOpeningKM");
                    var lblPreviouTripDT = (Label)grvDet.FindControl("lblPreviouTripDT");
                    var lblClosingTripNo = (Label)grvDet.FindControl("lblClosingTripNo");
                    var lblClosingDate = (Label)grvDet.FindControl("lblClosingDate");
                    var lblClosingKM = (Label)grvDet.FindControl("lblClosingKM");
                    var ddlOperation = (DropDownList)grvDet.FindControl("ddlOperation");
                    var txtAddSubtractKms = (TextBox)grvDet.FindControl("txtAddSubtractKms");
                    var lblActualClosingKm = (Label)grvDet.FindControl("lblActualClosingKm");
                    var hdnActualClosingKm = (HiddenField)grvDet.FindControl("hdnActualClosingKm");
                    var lblNetDistance = (Label)grvDet.FindControl("lblNetDistance");
                    var hdnNetDistance = (HiddenField)grvDet.FindControl("hdnNetDistance");
                    var lblBaseRate = (Label)grvDet.FindControl("lblBaseRate");
                    var hdnBaseRate = (HiddenField)grvDet.FindControl("hdnBaseRate");
                    var lblAmount = (Label)grvDet.FindControl("lblAmount");
                    var hdnAmount = (HiddenField)grvDet.FindControl("hdnAmount");
                    var txtRebate = (TextBox)grvDet.FindControl("txtRebate");
                    var lblNetAmount = (Label)grvDet.FindControl("lblNetAmount");
                    var hdnNetAmount = (HiddenField)grvDet.FindControl("hdnNetAmount");
                    var ddlGST = (DropDownList)grvDet.FindControl("ddlGST");
                    var lblIGST = (Label)grvDet.FindControl("lblIGST");
                    var hdnIGST = (HiddenField)grvDet.FindControl("hdnIGST");
                    var lblCGST = (Label)grvDet.FindControl("lblCGST");
                    var hdnCGST = (HiddenField)grvDet.FindControl("hdnCGST");
                    var lblSGST = (Label)grvDet.FindControl("lblSGST");
                    var hdnSGST = (HiddenField)grvDet.FindControl("hdnSGST");
                    var lblFinalAmount = (Label)grvDet.FindControl("lblFinalAmount");
                    var hdnFinalAmount = (HiddenField)grvDet.FindControl("hdnFinalAmount");
                    var lblRejectRemark = (Label)grvDet.FindControl("lblRejectRemark");

                    var hdnGSTPercantage = (HiddenField)grvDet.FindControl("hdnGSTPercantage");
                    var hdnGSTCredit = (HiddenField)grvDet.FindControl("hdnGSTCredit");
                    var hdnVendorCode = (HiddenField)grvDet.FindControl("hdnVendorCode");
                    var hdnVendorName = (HiddenField)grvDet.FindControl("hdnVendorName");

                    var hdnBalanceKms = (HiddenField)grvDet.FindControl("hdnBalanceKms");
                    var hdnCreditKms = (HiddenField)grvDet.FindControl("hdnCreditKms");

                    if (chkVehicleNo.Checked)
                    {
                        obj.VendorName = hdnVendorName.Value;
                        obj.VendorCode = hdnVendorCode.Value;
                        obj.VehicleNo = lblVehicleNo.Text;
                        obj.PreviousTripsheetNo = lblPreviousTripNo.Text;
                        obj.PreviousTripsheetDate = lblPreviouTripDT.Text;
                        obj.OpeningKM = lblOpeningKM.Text == "" ? "0" : lblOpeningKM.Text;
                        obj.ClosingTripsheetNo = lblClosingTripNo.Text;
                        obj.ClosingTripsheetDate = lblClosingDate.Text;
                        obj.ClosingKm = lblClosingKM.Text;
                        obj.KMS = txtAddSubtractKms.Text;
                        obj.OPType = ddlOperation.Text;
                        obj.ActualClosingKM = hdnActualClosingKm.Value;
                        obj.NetDistance = hdnNetDistance.Value;
                        obj.BaseRate = hdnBaseRate.Value;
                        obj.Amount = hdnAmount.Value;
                        obj.Rebate = txtRebate.Text;
                        obj.NEtAmount = hdnNetAmount.Value;
                        obj.GStType = ddlGST.Text;
                        obj.GStPersantage = hdnGSTPercantage.Value;
                        obj.IGST = hdnIGST.Value;
                        obj.CGST = hdnCGST.Value;
                        obj.SGST = hdnSGST.Value;
                        obj.FinalAmount = hdnFinalAmount.Value;
                        obj.RejectType = "G";
                        obj.RejectRemarks = lblRejectRemark.Text;
                        obj.EntryBy = SessionUtilities.CurrentEmployeeID;
                        obj.CreditKms = hdnCreditKms.Value;
                        obj.BalanceKms = hdnBalanceKms.Value;
                        
                        ocls_VehicleCPKM_BillGeneration.Add(obj);
                    }
                }

                var dt = objVendorCPKMBillController.CPKMBillGeneration(objcls_VehicleCPKM_BillGeneration, ocls_VehicleCPKM_BillGeneration, hdnMiscXML.Value);
                string BillNo = "";
                string VendorName = "";
                string BillDate = ""; string Vehicle = ""; string BillAmount = "";
                if (dt.Rows.Count > 0)
                {
                    BillNo = Convert.ToString(dt.Rows[0]["Billno"]);
                    VendorName = Convert.ToString(dt.Rows[0]["VendorName"]);
                    BillDate = Convert.ToString(dt.Rows[0]["BillDate"]);
                    Vehicle = Convert.ToString(dt.Rows[0]["NoVehicle"]);
                    BillAmount = Convert.ToString(dt.Rows[0]["NetAmount"]);
                }
                ConsumeToken();
                Response.Redirect("Done.aspx?VendorName=" + VendorName + "&Month=" + ddlMonth.SelectedItem.Text + "&BillNo=" + BillNo + "&BillDate=" + BillDate + "&Vehicle=" + Vehicle + "&BillAmount=" + BillAmount, false);
            }

        }
        catch (Exception ex)
        {
            umsg.Show(ex.ToString());
        }
    }
    protected void txtVedor_TextChanged(object source, Anthem.AutoSuggestEventArgs e)
    {
        DataView dv = new DataView(VendorsList);

        dv.RowFilter = string.Format("(vendorcode LIKE '{0}%' OR vendorname LIKE '{0}%') AND VendorTypeCode='{1}'", e.CurrentText,"20");

        txtVedor.DataSource = dv;
        txtVedor.DataBind();
    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (radDate.SelectedItem.Text == " Last Week (Including Today)")
        {
            txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
            DateTime MyDate = DateTime.Today;
            MyDate = MyDate + TimeSpan.FromDays(-7);
            txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        else
        {
            if (radDate.SelectedItem.Text == " Date Range [dd/mm/yyyy]")
            {
                DateTime MyDate = DateTime.Today;
                MyDate = MyDate + TimeSpan.FromDays(-31);
                //  txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
                txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
                txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateFrom.ReadOnly = false;
                txtDateTo.ReadOnly = false;
            }
            if (radDate.SelectedItem.Text == " Today:")
            {
                txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = txtDateFrom.Text;
                txtDateFrom.ReadOnly = true;
                txtDateTo.ReadOnly = true;
            }
        }
    }
    public void abc(object source, ServerValidateEventArgs value)
    {
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
}
