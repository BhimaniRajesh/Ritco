using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;

public partial class GUI_Fleet_Reports_DriverTracking_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            System.DateTime righnow = System.DateTime.Today;
            hfDate.Value = righnow.ToString("dd MMM yy");
        }

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (txtDriverID.Text != "" && txt_DriverName.Text != "")
        {

            string strDriverId = "";
            strDriverId = txtDriverID.Text;

            string strConnStr = Convert.ToString(Session["SqlProvider"]);
            //string strConnStr = "Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt";

            DataSet ds = new DataSet();
            ds = GetDriverInfo(strConnStr, strDriverId);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblDriverName.Text = ds.Tables[0].Rows[0]["Driver_Name"].ToString();
                lblFatherName.Text = ds.Tables[0].Rows[0]["DFather_Name"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["Driver_Location"].ToString();
                lblContactNo.Text = ds.Tables[0].Rows[0]["TelNo"].ToString();
                lbl_P_Addr.Text = ds.Tables[0].Rows[0]["P_Address"].ToString();
                lbl_P_City_Pincode.Text = ds.Tables[0].Rows[0]["P_City_Pincode"].ToString();
                lbl_C_Addr.Text = ds.Tables[0].Rows[0]["C_Address"].ToString();
                lbl_C_City_Pincode.Text = ds.Tables[0].Rows[0]["C_City_Pincode"].ToString();
                ImgPhoto.Visible = true;
                ImgPhoto.ImageUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Driver_Photo"].ToString();

                lbl_Manual_Driver_Code.Text = ds.Tables[0].Rows[0]["Manual_Driver_Code"].ToString();
                lbl_VehicleNo.Text = ds.Tables[0].Rows[0]["Vehno"].ToString();
                lbl_LicenseNo.Text = ds.Tables[0].Rows[0]["License_No"].ToString();
                lbl_ValidityDt.Text = ds.Tables[0].Rows[0]["Valdity_dt"].ToString();
                lbl_IssuedByRTO.Text = ds.Tables[0].Rows[0]["Issue_By_RTO"].ToString();
                lblGuarrantorName.Text = ds.Tables[0].Rows[0]["Guarantor_Name"].ToString();
                lblActive.Text = ds.Tables[0].Rows[0]["ActiveFlag"].ToString();
                lbl_DriverStatus.Text = ds.Tables[0].Rows[0]["Driver_Status"].ToString();

                DriverBalance db = new DriverBalance();
                lbl_Balance.Text = db.GetDriverBalanceAmt(ds.Tables[0].Rows[0]["Manual_Driver_Code"].ToString(), hfDate.Value);

                lbl_ElectricityBill.Text = ds.Tables[0].Rows[0]["Electricity_Bill_YN"].ToString();
                hfEleBillFile.Value = ds.Tables[0].Rows[0]["Electricity_Bill_File"].ToString();
                if (lbl_ElectricityBill.Text == "Y")
                {
                    hyperEleBill.Visible = true;
                    hyperEleBill.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Electricity_Bill_File"].ToString();
                }
                else
                {
                    hyperEleBill.Visible = false;
                }
                lbl_TelephoneBill.Text = ds.Tables[0].Rows[0]["Telephone_Bill_YN"].ToString();
                hfTelBill.Value = ds.Tables[0].Rows[0]["Telephone_Bill_File"].ToString();
                if (lbl_TelephoneBill.Text == "Y")
                {
                    HyperTelBill.Visible = true;
                    HyperTelBill.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Telephone_Bill_File"].ToString();
                }
                else
                {
                    HyperTelBill.Visible = false;
                }
                lbl_BankStatement.Text = ds.Tables[0].Rows[0]["BankAcc_YN"].ToString();
                hfBankStatement.Value = ds.Tables[0].Rows[0]["BankAcc_File"].ToString();
                if (lbl_BankStatement.Text == "Y")
                {
                    HyperBankStatement.Visible = true;
                    HyperBankStatement.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["BankAcc_File"].ToString();
                }
                else
                {
                    HyperBankStatement.Visible = false;
                }
                lbl_Passport.Text = ds.Tables[0].Rows[0]["Passport_YN"].ToString();
                hfPassport.Value = ds.Tables[0].Rows[0]["Passport_File"].ToString();
                if (lbl_Passport.Text == "Y")
                {
                    HyperPassport.Visible = true;
                    HyperPassport.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Passport_File"].ToString();
                }
                else
                {
                    HyperPassport.Visible = false;
                }
                lbl_RationCard.Text = ds.Tables[0].Rows[0]["Rationcard_YN"].ToString();
                hfrationCard.Value = ds.Tables[0].Rows[0]["Rationcard_File"].ToString();
                if (lbl_RationCard.Text == "Y")
                {
                    HyperrationCard.Visible = true;
                    HyperrationCard.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Rationcard_File"].ToString();
                }
                else
                {
                    HyperrationCard.Visible = false;
                }
                lblRegForm.Text = ds.Tables[0].Rows[0]["Driver_Registration_Form_YN"].ToString();
                hfRegForm.Value = ds.Tables[0].Rows[0]["Driver_Registration_Form_File"].ToString();
                if (lblRegForm.Text == "Y")
                {
                    HyperRegForm.Visible = true;
                    HyperRegForm.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Driver_Registration_Form_File"].ToString();
                }
                else
                {
                    HyperRegForm.Visible = false;
                }

                lbl_PassportID.Text = ds.Tables[0].Rows[0]["ID_Passport_YN"].ToString();
                hfPassportID.Value = ds.Tables[0].Rows[0]["ID_Passport_File"].ToString();
                if (lbl_PassportID.Text == "Y")
                {
                    HyperPassportID.Visible = true;
                    HyperPassportID.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["ID_Passport_File"].ToString();
                }
                else
                {
                    HyperPassportID.Visible = false;
                }
                lbl_DrivingLicense.Text = ds.Tables[0].Rows[0]["Driving_Lic_YN"].ToString();
                hfDrivingLicense.Value = ds.Tables[0].Rows[0]["Driving_Lic_File"].ToString();
                if (lbl_DrivingLicense.Text == "Y")
                {
                    HyperDrivingLicense.Visible = true;
                    HyperDrivingLicense.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Driving_Lic_File"].ToString();
                }
                else
                {
                    HyperDrivingLicense.Visible = false;
                }
                lbl_VotersID.Text = ds.Tables[0].Rows[0]["VoterId_YN"].ToString();
                hfVotersID.Value = ds.Tables[0].Rows[0]["VoterId_File"].ToString();
                if (lbl_VotersID.Text == "Y")
                {
                    HyperVotersID.Visible = true;
                    HyperVotersID.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["VoterId_File"].ToString();
                }
                else
                {
                    HyperVotersID.Visible = false;
                }
                lbl_PanCard.Text = ds.Tables[0].Rows[0]["Pan_YN"].ToString();
                hfPANcard.Value = ds.Tables[0].Rows[0]["PAN_File"].ToString();
                if (lbl_PanCard.Text == "Y")
                {
                    HyperPANcard.Visible = true;
                    HyperPANcard.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["PAN_File"].ToString();
                }
                else
                {
                    HyperPANcard.Visible = false;
                }
                lbl_ThumbImp.Text = ds.Tables[0].Rows[0]["Thumb_Impression_YN"].ToString();
                hfThumbImp.Value = ds.Tables[0].Rows[0]["Thumb_Impression_File"].ToString();
                if (lbl_ThumbImp.Text == "Y")
                {
                    HyperThumbImp.Visible = true;
                    HyperThumbImp.NavigateUrl = "~//UploadedImages//" + ds.Tables[0].Rows[0]["Thumb_Impression_File"].ToString();
                }
                else
                {
                    HyperThumbImp.Visible = false;
                }


                BindGrid(strConnStr, "SELECT top 10 * FROM VW_DRIVER_FUEL_REGISTER WHERE Driver_Id='" + strDriverId + "' order by Date_of_Filling desc ", gvFuelRegister);
                BindGrid(strConnStr, "select top 5 * from VW_DRIVER_TRIPSHEET_DETAILS WHERE Driver_Id='" + strDriverId + "' order by EntryDt desc ", gvTripsheet);
                BindGrid(strConnStr, "SELECT top 5 * FROM VW_DRIVER_VEHICLE_USED where Driver1='" + strDriverId + "' order by TripSheet_Count desc ", gvVehicleUsed);

                lblError.Text = "";
            }
            else
            {
                lblDriverName.Text = "";
                lblFatherName.Text = "";
                lblLocation.Text = "";
                lblContactNo.Text = "";
                lbl_P_Addr.Text = "";
                lbl_P_City_Pincode.Text = "";
                lbl_C_Addr.Text = "";
                lbl_C_City_Pincode.Text = "";
                ImgPhoto.Visible = false;
                ImgPhoto.ImageUrl = "";

                lbl_Manual_Driver_Code.Text = "";
                lbl_VehicleNo.Text = "";
                lbl_LicenseNo.Text = "";
                lbl_ValidityDt.Text = "";
                lbl_IssuedByRTO.Text = "";
                lblGuarrantorName.Text = "";
                lblActive.Text = "";
                lbl_DriverStatus.Text = "";

                lbl_Balance.Text = "";

                lbl_ElectricityBill.Text = "";
                lbl_TelephoneBill.Text = "";
                lbl_BankStatement.Text = "";
                lbl_Passport.Text = "";
                lbl_RationCard.Text = "";
                lblRegForm.Text = "";

                lbl_PassportID.Text = "";
                lbl_DrivingLicense.Text = "";
                lbl_VotersID.Text = "";
                lbl_PanCard.Text = "";
                lbl_ThumbImp.Text = "";

                BindGrid(strConnStr, "SELECT top 10 * FROM VW_DRIVER_FUEL_REGISTER WHERE Driver_Id='" + strDriverId + "' order by Date_of_Filling desc", gvFuelRegister);
                BindGrid(strConnStr, "select top 5 * from VW_DRIVER_TRIPSHEET_DETAILS WHERE Driver_Id='" + strDriverId + "' order by vslipdt desc ", gvTripsheet);
                BindGrid(strConnStr, "SELECT top 5 * FROM VW_DRIVER_VEHICLE_USED WHERE Driver1='" + strDriverId + "' order by TripSheet_Count desc ", gvVehicleUsed);

                lblError.Text = "Please Check Driver Name!!!";
            }

        }
        else
        {
            lblDriverName.Text = "";
            lblFatherName.Text = "";
            lblLocation.Text = "";
            lblContactNo.Text = "";
            lbl_P_Addr.Text = "";
            lbl_P_City_Pincode.Text = "";
            lbl_C_Addr.Text = "";
            lbl_C_City_Pincode.Text = "";
            ImgPhoto.Visible = false;
            ImgPhoto.ImageUrl = "";

            lbl_Manual_Driver_Code.Text = "";
            lbl_VehicleNo.Text = "";
            lbl_LicenseNo.Text = "";
            lbl_ValidityDt.Text = "";
            lbl_IssuedByRTO.Text = "";
            lblGuarrantorName.Text = "";
            lblActive.Text = "";
            lbl_DriverStatus.Text = "";

            lbl_Balance.Text = "";

            lbl_ElectricityBill.Text = "";
            lbl_TelephoneBill.Text = "";
            lbl_BankStatement.Text = "";
            lbl_Passport.Text = "";
            lbl_RationCard.Text = "";
            lblRegForm.Text = "";

            lbl_PassportID.Text = "";
            lbl_DrivingLicense.Text = "";
            lbl_VotersID.Text = "";
            lbl_PanCard.Text = "";
            lbl_ThumbImp.Text = "";

            //BindGrid(strConnStr, "SELECT top 10 * FROM VW_DRIVER_FUEL_REGISTER WHERE Driver_Id='" + strDriverId + "' order by Date_of_Filling desc", gvFuelRegister);
            //BindGrid(strConnStr, "select top 5 * from VW_DRIVER_TRIPSHEET_DETAILS WHERE Driver_Id='" + strDriverId + "' order by vslipdt desc ", gvTripsheet);
            //BindGrid(strConnStr, "SELECT top 5 * FROM VW_DRIVER_VEHICLE_USED WHERE Driver1='" + strDriverId + "' order by TripSheet_Count desc ", gvVehicleUsed);

            lblError.Text = "Please Check Driver Name!!!";
        }
    }

    public DataSet GetDriverInfo(string strConnStr, string strDriverId)
    {
        SqlDataAdapter adp = new SqlDataAdapter("Select top 1 * From VW_DRIVER_FINAL_INFO Where Driver_Id='" + strDriverId + "' order by EntryDt desc", strConnStr);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        return ds;
    }
    public void BindGrid(string strConnStr, string strSQL, GridView gv)
    {
        SqlDataAdapter adp = new SqlDataAdapter(strSQL, strConnStr);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        gv.DataSource = ds;
        gv.DataBind();
    }
}
