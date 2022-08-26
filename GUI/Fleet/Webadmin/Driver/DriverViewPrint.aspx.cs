using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;

public partial class GUI_Fleet_Webadmin_Driver_DriverViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindData();
        }
    }

    void BindData()
    {
        var obj = new TripApprovalController();
        DataTable dt = obj.DriverViewPrintDetail(Request.QueryString["id"].ToString()).Tables[0];

        if (dt.Rows.Count > 0)
        {
            DataRow r2 = dt.Rows[0];
            lblDriverCodeVal.Text = Convert.ToString(r2["Driver_Id"]);
            lblDriverNameVal.Text = Convert.ToString(r2["Driver_Name"]);
            lblManualDriverCodeVal.Text = Convert.ToString(r2["Manual_Driver_Code"]);
            lblFathersNameVal.Text = Convert.ToString(r2["DFather_Name"]);
            lblVehicleNumberVal.Text = Convert.ToString(r2["VEHNO"]);
            lblLocationVal.Text = Convert.ToString(r2["Driver_Location"]);

            lblContactNoVal.Text = r2["Telno"].ToString().Trim();
            lblCAddressVal.Text = r2["C_Address"].ToString().Trim();
            lblDOBVal.Text = r2["D_DOB"].ToString().Trim();
            lblLicNoVal.Text = r2["License_No"].ToString().Trim();
            lblValDtVal.Text = r2["ValdityDt"].ToString().Trim();
            lblbIssueDateVal.Text = r2["D_Lic_Initial_Issuance_Date"].ToString().Trim();
            
            lblRTOVal.Text = r2["Issue_By_RTO"].ToString().Trim();
            lblStatusVal.Text = r2["ActiveFlag"].ToString().Trim();

            lblLicIssueDateVal.Text = r2["D_Lic_Initial_Issuance_Date"].ToString().Trim();
            lblLicCategoryVal.Text = r2["LicenceCategory"].ToString().Trim();

            lblAddressVerfiedByVal.Text = r2["AddressVerifiedBy"].ToString().Trim(); ;
            lblAddressVerfiedDateVal.Text = r2["AddressVerifiedDate"].ToString().Trim(); ;
            lblVillageVal.Text = r2["Village_Name"].ToString().Trim();
            lblTahseelVal.Text = r2["Tahseel"].ToString().Trim();
            lblPSVal.Text = r2["PS"].ToString().Trim();
            lblPOVal.Text = r2["PO"].ToString().Trim();
            lblDistVal.Text = r2["Dist"].ToString().Trim();
            lblStateVal.Text = r2["DriverStateCode"].ToString().Trim();

            lblVillageMobileNoVal.Text = r2["Village_MobileNo"].ToString().Trim();
            lblAlternativeMobileNoVal.Text = r2["Alternative_MobileNo"].ToString().Trim();
            lblReferenceNameVal.Text = r2["Reference_By"].ToString().Trim();
            lblReferenceMobileNoVal.Text = r2["ReferenceByMobileNo"].ToString().Trim();

            txtAadharCardNo.Text = r2["Aadhar_Card_No"].ToString().Trim();

            if (r2["AadharCard_File"].ToString() != "")
            {
                LblAadharCardNo.Text = r2["AadharCard_File"].ToString().Trim();
            }

            if (r2["VoterId_File"].ToString() != "")
            {
                lblElectionCardNo.Text = r2["VoterId_File"].ToString().Trim();
            }
            if (r2["Rationcard_File"].ToString() != "")
            {
                lblRationCardNo.Text = r2["Rationcard_File"].ToString().Trim();
            }
            if (r2["Passport_File"].ToString() != "")
            {
                lblPassportNo.Text = r2["Passport_File"].ToString().Trim();
            }
            if (r2["PAN_File"].ToString() != "")
            {
                lblPANCardNo.Text = r2["PAN_File"].ToString().Trim();
            }
            if (r2["BankAcc_File"].ToString() != "")
            {
                lblBankAccountStatement.Text = r2["BankAcc_File"].ToString().Trim();
            }
            if (r2["Driver_Photo"].ToString() != "")
            {
                lblPhoto.Text = r2["Driver_Photo"].ToString().Trim();
            }
            if (r2["Driver_BioData_File"].ToString() != "")
            {
                lblDriverBioData.Text = r2["Driver_BioData_File"].ToString().Trim();
            }
            if (r2["DriverVerified_File"].ToString() != "")
            {
                lbl_DLVerifiedDate.Text = r2["DriverVerified_File"].ToString().Trim();
            }

            txtDLVerifiedDate.Text = r2["DriverVerifiedDate"].ToString().Trim();
            lblDriverLicVerfiedByVal.Text = r2["DriverVerifiedBy"].ToString().Trim();
            txtPANCardNo.Text = r2["PANCardNo"].ToString().Trim();
            txtPassportNo.Text = r2["PassportNo"].ToString().Trim();
            txtRationCardNo.Text = r2["RationCardNo"].ToString().Trim();
            txtElectionCardNo.Text = r2["Election_Card_No"].ToString().Trim();
            txtAadharCardNo.Text = r2["Aadhar_Card_No"].ToString().Trim();

        }

    }
}