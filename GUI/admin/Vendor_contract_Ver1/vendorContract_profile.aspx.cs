using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_Admin_Vendor_contract_vendorContract_profile : System.Web.UI.Page
{
    string VendorDesc = "", VendorID = "", VendorTypeID = "", VendorTypeDesc = "", Add_Edit_Flag = "", ContractType = "", ContractCode = "", NextStep="";
    
    private VendorContractSummary VendorCS
    {
        get { return (ViewState["VendorCS"] != null) ? ViewState["VendorCS"] as VendorContractSummary : null; }
        set { ViewState["VendorCS"] = value; }
    }
    private VendorContractSummary ActiveContract
    {
        get { return (ViewState["ActiveContract"] != null) ? ViewState["ActiveContract"] as VendorContractSummary : null; }
        set { ViewState["ActiveContract"] = value; }
    }
    private bool isEdit { get { return (ViewState["isEdit"] != null) ? Convert.ToBoolean(ViewState["isEdit"]) : true; } set { ViewState["isEdit"] = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        VendorID = Request.QueryString.Get("VendorID");
        VendorDesc = Request.QueryString.Get("VendorDesc");
        VendorTypeID = Request.QueryString.Get("VendorTypeID");
        VendorTypeDesc = Request.QueryString.Get("VendorTypeDesc");
        Add_Edit_Flag = Request.QueryString.Get("Add_Edit_Flag");
        ContractType = Request.QueryString.Get("ContractType");
        ucContractDT.ImageUrl = "../../images/calendar.jpg";
        ucEffectiveFrom.ImageUrl = "../../images/calendar.jpg";
        ucSDDate.ImageUrl = "../../images/calendar.jpg";
        ucValidTill.ImageUrl = "../../images/calendar.jpg";
        hidVendorTypeID.Value = VendorTypeID;

        txtContractloccode.Attributes.Add("onchange", "javascript:return ValidateLocation('" + txtContractloccode.ClientID + "');");

        if (VendorTypeID.Trim() == "08")
        { trDefCharge.Style.Add("display", "block"); }
        else
        { trDefCharge.Style.Add("display", "none"); }

        if (!IsPostBack)
        {
            BindContractData();
        }
    }

    private void BindContractData()
    {
        try
        {
            if (VendorID.Trim() != "")
            {
                lblvendor.Text = VendorDesc;
                lblvendortype.Text = VendorTypeDesc;
                ActiveContract = VendorContractSummaryController.GetByVendorCode(VendorID);
                if (ActiveContract != null)
                {
                    if (ActiveContract.CONTRACTCD != "")
                    {                                                
                        if (ActiveContract.MetrixType == ContractType)
                            VendorCS = ActiveContract;
                        else
                        {
                            List<VendorContractSummary> listVCS = VendorContractSummaryController.GetByMatrixAndStatus(VendorID, ContractType, "");
                            if (listVCS.Count > 0)
                                VendorCS = listVCS[0];
                            else
                            {
                                VendorCS = new VendorContractSummary();
                                isEdit = false;
                            }
                        }
                        if(isEdit)
                            lblConrtaID.Text = VendorCS.CONTRACTCD;
                        txtContractloccode.Text = VendorCS.Contract_loccode;
                        if(VendorCS.ContractDt>DateTime.MinValue && VendorCS.ContractDt<DateTime.MaxValue)
                            ucContractDT.SelectedDate = VendorCS.ContractDt.ToString("dd/MM/yyyy");
                        if (VendorCS.Valid_uptodt > DateTime.MinValue && VendorCS.Valid_uptodt < DateTime.MaxValue)
                            ucValidTill.SelectedDate = VendorCS.Valid_uptodt.ToString("dd/MM/yyyy");
                        if (VendorCS.Start_Dt > DateTime.MinValue && VendorCS.Start_Dt < DateTime.MaxValue)
                            ucEffectiveFrom.SelectedDate = VendorCS.Start_Dt.ToString("dd/MM/yyyy");
                        txtCompEmpName.Text = VendorCS.CompEmpName;
                        txtCompEmpDesg.Text = VendorCS.CompEmpDesg;
                        txtCompWitness.Text = VendorCS.CompWitness;
                        txtVendorPerName.Text = VendorCS.VendorPerName;
                        txtVendorPerDesg.Text = VendorCS.VendorPerDesg;
                        txtVendorWitness.Text = VendorCS.VendorWitness;
                        txtVendorAdd.Text = VendorCS.Vendor_Address;
                        txtVendorCity.Text = VendorCS.VendorCity;
                        txtVendorPin.Text = VendorCS.VendorPin;
                        cboVendorCategory.SelectedValue = VendorCS.VendorCategory;
                        cboVendorContractCat.SelectedValue = VendorCS.VendorContractCat;
                        TDSChk.Checked = (VendorCS.TDSAppl_YN.ToUpper() == "Y") ? true : false;
                        txtTDS.Text = (VendorCS.TDSAppl_YN.ToUpper() == "Y") ? "Yes" : "No";
                        if(VendorCS.TDS_Rate > -1)
                            txtTdsRate.Text = VendorCS.TDS_Rate.ToString("0.00");
                        txtNoOfCheques.Text = VendorCS.Security_deposit_chq;
                        if (VendorCS.Security_deposit_Amt > -1)
                            txtSecDepAmt.Text = VendorCS.Security_deposit_Amt.ToString("0.00");
                        if (VendorCS.Security_deposit_date > DateTime.MinValue && VendorCS.Security_deposit_date < DateTime.MaxValue)
                            ucSDDate.SelectedDate = VendorCS.Security_deposit_date.ToString("dd/MM/yyyy");
                        cboPayInterval.SelectedValue = VendorCS.Payment_interval;
                        cboTransType.SelectedValue = VendorCS.Payment_Basis;
                        txtPayLoccode.Text = VendorCS.Payment_loc;
                        if (VendorCS.Monthly_Phone_Charges > -1)
                            txtMonPhChrg.Text = VendorCS.Monthly_Phone_Charges.ToString("0.00");
                        if (VendorCS.Default_Charge > -1)
                            txtDefCharge.Text = VendorCS.Default_Charge.ToString("0.00");
                    }
                    else
                        isEdit = false;
                }
                else
                    isEdit = false;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            if (isEdit)
            {
                VendorCS.UpdateBy = SessionUtilities.CurrentEmployeeID;
                VendorCS.UpdateDt = DateTime.Now;
            }
            else
            {
                VendorCS = new VendorContractSummary();
                VendorCS.CONTRACTCD = VendorContractSummaryController.GenerateNewContractCode();
                VendorCS.VendorCode = VendorID;
                VendorCS.VendorName = VendorDesc;
                VendorCS.Vendor_Type = VendorTypeID;
                VendorCS.EntryBy = SessionUtilities.CurrentEmployeeID;
                VendorCS.EntryDt = DateTime.Now;
            }
            ContractCode = VendorCS.CONTRACTCD;
            if (txtContractloccode.Text.Trim() != "")
                VendorCS.Contract_loccode = txtContractloccode.Text.Trim();
            if (ucContractDT.SelectedDate.Trim() != "")
                VendorCS.ContractDt = GetDate(ucContractDT.SelectedDate);
            if (ucValidTill.SelectedDate.Trim() != "")
                VendorCS.Valid_uptodt = GetDate(ucValidTill.SelectedDate);
            if (ucEffectiveFrom.SelectedDate.Trim() != "")
                VendorCS.Start_Dt = GetDate(ucEffectiveFrom.SelectedDate);
            if (txtCompEmpName.Text.Trim() != "")
                VendorCS.CompEmpName = txtCompEmpName.Text.Trim();
            if (txtCompEmpDesg.Text.Trim() != "")
                VendorCS.CompEmpDesg = txtCompEmpDesg.Text;
            if (txtCompWitness.Text.Trim() != "")
                VendorCS.CompWitness = txtCompWitness.Text;
            if (txtVendorPerName.Text.Trim() != "")
                VendorCS.VendorPerName = txtVendorPerName.Text;
            if (txtVendorPerDesg.Text.Trim() != "")
                VendorCS.VendorPerDesg = txtVendorPerDesg.Text;
            if (txtVendorWitness.Text.Trim() != "")
                VendorCS.VendorWitness = txtVendorWitness.Text;
            if (txtVendorAdd.Text.Trim() != "")
                VendorCS.Vendor_Address = txtVendorAdd.Text;
            if (txtVendorCity.Text.Trim() != "")
                VendorCS.VendorCity = txtVendorCity.Text;
            if (txtVendorPin.Text.Trim() != "")
                VendorCS.VendorPin = txtVendorPin.Text;
            if (cboVendorCategory.SelectedValue != "")
                VendorCS.VendorCategory = cboVendorCategory.SelectedValue;
            if (cboVendorContractCat.SelectedValue != "")
                VendorCS.VendorContractCat = cboVendorContractCat.SelectedValue;
            VendorCS.TDSAppl_YN = (TDSChk.Checked) ? "Y" : "N";
            if (txtTdsRate.Text.Trim() != "")
                VendorCS.TDS_Rate = Convert.ToDouble(txtTdsRate.Text);
            if (txtNoOfCheques.Text.Trim() != "")
                VendorCS.Security_deposit_chq = txtNoOfCheques.Text;
            if (txtSecDepAmt.Text.Trim() != "")
                VendorCS.Security_deposit_Amt = Convert.ToDouble(txtSecDepAmt.Text);
            if (ucSDDate.SelectedDate.Trim() != "")
                VendorCS.Security_deposit_date = GetDate(ucSDDate.SelectedDate);
            if (cboPayInterval.SelectedValue != "")
                VendorCS.Payment_interval = cboPayInterval.SelectedValue;
            if (cboTransType.SelectedValue != "")
                VendorCS.Payment_Basis = cboTransType.SelectedValue;
            if (txtPayLoccode.Text.Trim() != "")
                VendorCS.Payment_loc = txtPayLoccode.Text;
            if (txtMonPhChrg.Text.Trim() != "")
                VendorCS.Monthly_Phone_Charges = Convert.ToDouble(txtMonPhChrg.Text);
            if (txtDefCharge.Text.Trim() != "")
                VendorCS.Default_Charge = Convert.ToDouble(txtDefCharge.Text);
            VendorCS.Status = "Y";
            VendorCS.MetrixType = ContractType;
            bool isSuccess = false;
            if (isEdit)
                isSuccess = VendorContractSummaryController.Update(VendorCS);
            else
                isSuccess = VendorContractSummaryController.Insert(VendorCS);
            if (isSuccess)
            {
                if (ActiveContract != null)
                {
                    if (ActiveContract.CONTRACTCD != VendorCS.CONTRACTCD)
                    {
                        ActiveContract.Status = "N";
                        ActiveContract.UpdateBy = SessionUtilities.CurrentEmployeeID;
                        ActiveContract.UpdateDt = DateTime.Now;
                        VendorContractSummaryController.Update(ActiveContract);
                    }
                }
                if (!isEdit)
                    isEdit = true;
                RedirectPage();
            }
            else
            {
                if (!isEdit)
                    throw new Exception("Add vendor contract summary : Operation fail");
                else
                    throw new Exception("Update vendor contract summary : Operation fail");
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    private void RedirectPage()
    {
        string Qstring = "?VendorTypeID=" + VendorTypeID.ToString(), PageName = "";
        Qstring += "&VendorTypeDesc=" + VendorTypeDesc.ToString();
        Qstring += "&VendorID=" + VendorID.ToString();
        Qstring += "&VendorDesc=" + VendorDesc;
        Qstring += "&Add_Edit_Flag=" + Add_Edit_Flag;
        Qstring += "&ContractCode=" + ContractCode;
        Qstring += "&ContractType=" + ContractType;        
        if (ContractType == "01" || ContractType == "02" || ContractType == "03" )
        {
            Qstring += "&NextStep=2";
            PageName = "Route_Based_Contract.aspx";
        }
        else if (ContractType == "04" || ContractType == "05" || ContractType == "06")
        {
            Qstring += "&NextStep=2";
            PageName = "Distance_Based_Contract.aspx";
        }
        else if (ContractType == "09" || ContractType == "10" || ContractType == "11")
        {
            Qstring += "&NextStep=2";
            PageName = "City_Based_Contract.aspx";
        }
        else if (ContractType == "07")
        {
            Qstring += "&NextStep=2";
            PageName = "Docket_Based_Contract.aspx";
        }
        else if (ContractType == "08")
        {
            Qstring += "&NextStep=2";
            PageName = "3PL_Based_Contract.aspx";
        }
        else if (ContractType == "20")
        {
            Qstring += "&NextStep=2";
            PageName = "CPKM_Contract.aspx";
        }
        Response.Redirect(PageName + Qstring);
    }
    private DateTime GetDate(string ddMMyyyy)
    {
        string[] strArrDt = ddMMyyyy.Split('/');
        return Convert.ToDateTime(strArrDt[1] + "/" + strArrDt[0] + "/" + strArrDt[2]);
    }
}
