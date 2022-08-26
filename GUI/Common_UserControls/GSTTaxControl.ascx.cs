/*
 *  Version 1.0.0.6 Rule Based customer registration allow.
 *  Version 1.0.0.5 Added New logic if company is registerd with GST Then do overwrite Make RCM Yes to No else keep Yes as Yes.
 *  Version 1.0.0.4 Added New logic for RCM Applicalble if NOT Register Then Make RCM To NO and calculate GST For same. 
 *                  ALSO Removed Provisinal text and made single GST Number. 
 *  Version 1.0.0.3 Added new validation in Submit and added logic of overwrite RCM in case of no registration. 
 *  Version 1.0.0.2 Resolved all bugs
 *  Version 1.0.0.1 Implemention of control logic.
 */
using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using WebX.Common;
using WebX.Controllers;

public partial class GUI_Common_UserControls_GSTTaxControl : UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnCompanyCode.Value = SessionUtilities.DefaultCompanyCode;
            using (var dbObject = new WebXHelper())
            {
                if (ddlGroupCode.Items.Count == 1)
                {
                    #region Load Customer Data
                    CustomerMasterController objCustomerMaster = new CustomerMasterController();
                    DataTable dtCustomerMaster = new DataTable();
                    dtCustomerMaster = objCustomerMaster.getAllCustomerGroup();
                    if (dtCustomerMaster != null && dtCustomerMaster.Rows.Count > 0)
                    {
                        ddlGroupCode.DataTextField = "GroupCodeName";
                        ddlGroupCode.DataValueField = "grpcd";
                        ddlGroupCode.DataSource = dtCustomerMaster;
                        ddlGroupCode.DataBind();
                    }
                    #endregion
                }

                var dtData = dbObject.ExecuteDataTable("USP_GST_STATE_GET");
                ddlGstCreateBillingStateUT.DataSource = dtData;
                ddlGstCreateBillingStateUT.DataTextField = "STNM";
                ddlGstCreateBillingStateUT.DataValueField = "STCD";
                ddlGstCreateBillingStateUT.DataBind();

                var dtddlExemptionCategory = GeneralMasterUtilities.GetGeneralMaster("EXCCATE");
                ddlExemptionCategory.DataSource = dtddlExemptionCategory;
                ddlExemptionCategory.DataTextField = "codedesc";
                ddlExemptionCategory.DataValueField = "codeid";
                ddlExemptionCategory.DataBind();

            }
            hdnRulesTBBAllowWithoutRegistration.Value = DocketRules.GetDefaultValue("GSTTBBGSTIN");
            hdnGSTPartyRegister.Value = DocketRules.GetDefaultValue("GSTPARTYREGISTER");
            hdnGSTRegister.Value = DocketRules.GetDefaultValue("GSTREGISTER");
            hdnGSTRegDeclaration.Value = DocketRules.GetDefaultValue("GSTREGDECLARATION");

            using (var dbObject = new WebXHelper())
            {
                hdnEnableGSTRCMLogic.Value = Convert.ToString(dbObject.ExecuteScalar(CommandType.StoredProcedure, "USP_GET_DOCKETGST_RULES", new[] {
                    new SqlParameter("@CompanyCode",hdnCompanyCode.Value)
                }));
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadControlOnCallBack_LOAD" + DateTime.Now.Ticks.ToString(), "LoadControl('" + ddlGroupCode.ClientID + "');", true);
    }

    #region Property required for use control
    public string GSTPaymentPartyCode
    {
        get
        {
            return hdnGSTBillingParyCode.Value;
        }
        set
        {
            lblBillingParyCode.Text = value;
            hdnGSTBillingParyCode.Value = value;
        }
    }
    public string GSTPaymentPartyName
    {
        get
        {
            return lblBillingParty.Text;
        }
        set
        {
            lblBillingParty.Text = value;
        }
    }

    public string CityId
    {
        get
        {
            return hdnCityId.Value;
        }
        set
        {
            hdnCityId.Value = value;
        }
    }
    public string GSTPayBaseId
    {
        get
        {
            return hdnPayBaseId.Value;
        }
        set
        {
            hdnPayBaseId.Value = value;
        }
    }
    public string GSTProductID
    {
        get
        {
            return hdnProduct.Value;
        }
        set
        {
            hdnProduct.Value = value;
        }
    }
    public string BookingBranch
    {
        get
        {
            return hdnBookingBranch.Value;
        }
        set
        {
            hdnBookingBranch.Value = value;
        }
    }

    public string IsGStDocumentScan
    {
        get
        {
            return hdnIsGStDocumentScan.Value;
        }
        set
        {
            hdnIsGStDocumentScan.Value = value;
        }
    }

    public string GSTRemark
    {
        get
        {
            return hdnGSTRemark.Value;
        }
        set
        {
            hdnGSTRemark.Value = value;
        }
    }
    public double SubTotals
    {
        get
        {
            return Convert.ToDouble(txtDocketSubTotal.Text);
        }
        set
        {
            txtDocketSubTotal.Text = value.ToString();
        }
    }
    public double DeductAmount
    {
        get
        {
            double mDeductAmount;
            double.TryParse(hdnDeductAmount.Value, out mDeductAmount);
            return mDeductAmount;
        }
        set
        {
            hdnDeductAmount.Value = value.ToString();
        }
    }
    public enum mDocketMode
    {
        NEW,
        FINANCIALEDIT,
        DeliveryMR
    }
    public mDocketMode DocketMode { set { hdnDocketMode.Value = value.ToString(); } get { return (mDocketMode)Enum.Parse(typeof(mDocketMode), hdnDocketMode.Value); } }
    public string DocketNumber { set { hdnDocketNumber.Value = value.ToString(); } get { return hdnDocketNumber.Value.ToString(); } }
    public string DestinationBranch { get { return hdnDestinationBranch.Value; } set { hdnDestinationBranch.Value = value; } }
    public string DestinatonCity { get { return hdnDestinatonCityId.Value; } set { hdnDestinatonCityId.Value = value; } }
    public string BilledAtBranch { get { return hdnBilledAtBranch.Value; } set { hdnBilledAtBranch.Value = value; hdnBilledAtBranchActual.Value = value; } }
    public string PartyAs { get { return hdnPartyAs.Value; } set { hdnPartyAs.Value = value; } }
    #endregion

    #region Propery for output of control
    public string GSTBillingStateCode { get { return hdnGstCreateStateUT.Value; } set { hdnActualGstCreateStateUT.Value = value; } }
    public string PlaceOfSupply { get { return hdnPlaceOfSupply.Value; } set { hdnActualPlaceOfSupply.Value = value; } }
    public string GSTIN { get { return hdnGstCreateGSTINNumber.Value.Trim(); } }
    public string SACCategory { get { return hdnSACCAtegory.Value; } }
    public string SACCode { get { return hdnSACCode.Value; } set { hdnActualSACCode.Value = value; } }
    public string GSTServiceType { get { return hdnServicetypeCode.Value; } }
    public string ISRCMApplicable { get { return hdnRCMApplicable.Value; } }
    public string IsGSTPartyRegistered { get { return hdnGSTRegistered.Value; } }

    #region Amounts
    public double GSTRate { get { return Convert.ToDouble(txtGstRate.Text); } }
    public double GSTAmount { get { return Convert.ToDouble(txtGSTAmount.Text); } }
    public double GSTCharged { get { return Convert.ToDouble(txtGSTCharged.Text); } }
    public double SubTotal { get { return Convert.ToDouble(txtDocketSubTotal.Text); } }
    public double DocketTotal { get { return Convert.ToDouble(txtDocketTotal.Text); } }
    public string GSTExempted { get { return ddlGSTExempted.SelectedValue; } set { ddlGSTExempted.SelectedValue = value; } }
    public string GSTExemptionCategory { get { return ddlExemptionCategory.SelectedValue; } set { ddlExemptionCategory.SelectedValue = value; } }

    #endregion

    #endregion
    public void StartGSTControl()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Load" + DateTime.Now.Ticks.ToString(), "LoadDetailsOfCustomer('');", true);
    }
    public void LoadDetails()
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Load" + DateTime.Now.Ticks.ToString(), "LoadDetails();", true);
    }

    public void BtnSaveGST_Click(object sender, EventArgs e)
    {

    }
}