using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_Webadmin_Driver_DriverDetVer1 : System.Web.UI.Page
{
	SqlConnection conn = new SqlConnection();//(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

	string DriverId = "", Mode = "", AddEditMode = "";
	string DataFound = "N";
	string AadharCard_File = "", ElectionCard_File = "", RationCard_File = "", Passport_File = "", PANCard_File = "", BankAccountStatement_File = "", Photo_File = "", DriverBioData_File = "", DLVerifiedDate_File = "", AgreementCopy_File = "";
	string List1 = "", List2 = "", List3 = "", List4 = "", List5 = "", List6 = "", List7 = "", List8 = "", List9 = "", List10 = "", List11 = "", List12 = "", List13 = "", List14 = "";
	string[] selvaluesArr1; string[] selvaluesArr2; string[] selvaluesArr3; string[] selvaluesArr4; string[] selvaluesArr5;
	string[] selvaluesArr6; string[] selvaluesArr7; string[] selvaluesArr8; string[] selvaluesArr9; string[] selvaluesArr10;
	string[] selvaluesArr11; string[] selvaluesArr12;
	string mAadharCard_FileName = "", mElectionCard_FileName = "", mRationCard_FileName = "", mPassport_FileName = "", mPANCard_FileName = "", mBankAccountStatement_FileName = "", mPhoto_FileName = "", mDriverBioData_FileName = "", mDLVerifiedDate_FileName = "", mAgreementCopy_FileName = "";
	string AadharCard_File_Name = "", ElectionCard_File_Name = "", RationCard_File_Name = "", Passport_File_Name = "", PANCard_File_Name = "", BankAccountStatement_File_Name = "", Photo_File_Name = "", DriverBioData_File_Name = "", DLVerifiedDate_File_Name = "", AgreementCopy_File_Name = "";
	protected void Page_Load(object sender, EventArgs e)
	{
		addLocation();
		BindState();

		if (!string.IsNullOrEmpty(Convert.ToString(Request.QueryString["id"])))
		{

			DriverId = Request.QueryString["id"];
			if (DriverId != "")
			{
				AddEditMode = "U";
				ViewState["AddEditMode"] = AddEditMode;
			}
		}
		else
		{
			AddEditMode = "I";
			ViewState["AddEditMode"] = AddEditMode;
		}

		if (!IsPostBack)
		{
			System.DateTime righnow = System.DateTime.Today;
			string strrightnow = righnow.ToString("dd/MM/yyyy");
			hfTodayDate.Value = righnow.ToString("dd/MM/yyyy");
			if (DriverId != "")
			{
				Inetialized();
			}
		}
	}
	public void Inetialized()
	{
		SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		string sql = "usp_DriverAdd_List_FA";
		SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
		sqlcmd2.CommandType = CommandType.StoredProcedure;
		conn.Open();

		string mFlag = "", mLocation = "", mLicenceCategory = "", mState = "";
		sqlcmd2.Parameters.Add("@DriverID", SqlDbType.VarChar).Value = DriverId;

		SqlDataReader r2 = sqlcmd2.ExecuteReader();

		while (r2.Read())
		{
			txtDriverName.Text = r2["Driver_Name"].ToString().Trim();
			txtMDCode.Text = r2["Manual_Driver_Code"].ToString().Trim();
			txtFather.Text = r2["DFather_Name"].ToString().Trim();
			txtVehicleNo.Text = r2["VEHNO"].ToString().Trim();

			ddlLocation.SelectedValue = r2["Driver_Location"].ToString().Trim();
			hdfLocation.Value = r2["Driver_Location"].ToString().Trim();

			txtContact.Text = r2["Telno"].ToString().Trim();
			txtCAddress.Text = r2["C_Address"].ToString().Trim();
			txtDOB.Text = r2["D_DOB"].ToString().Trim();
			txtLicNo.Text = r2["License_No"].ToString().Trim();
			txtValDt.Text = r2["ValdityDt"].ToString().Trim();
			txtLicIssueDate.Text = r2["D_Lic_Initial_Issuance_Date"].ToString().Trim();
			txtissueDate.Text = r2["D_Lic_Initial_Issuance_Date"].ToString().Trim();
			txtRTO.Text = r2["Issue_By_RTO"].ToString().Trim();
			cboStatus.SelectedValue = r2["ActiveFlag"].ToString().Trim();
			hdfStatus.Value = r2["ActiveFlag"].ToString().Trim();
			ddlLicCategory.SelectedValue = r2["LicenceCategory"].ToString().Trim();
			txtAddressVerfiedBy.Text = r2["AddressVerifiedBy"].ToString().Trim(); ;
			txtAddressVerfiedDate.Text = r2["AddressVerifiedDate"].ToString().Trim(); ;
			txtVillageName.Text = r2["Village_Name"].ToString().Trim();
			txtTahseel.Text = r2["Tahseel"].ToString().Trim();
			txtPS.Text = r2["PS"].ToString().Trim();
			txtPO.Text = r2["PO"].ToString().Trim();
			txtDist.Text = r2["Dist"].ToString().Trim();
			ddlstate.SelectedValue = r2["DriverStateCode"].ToString().Trim();
			hdfState.Value = r2["DriverStateCode"].ToString().Trim();
			txtVillageMobileNo.Text = r2["Village_MobileNo"].ToString().Trim();
			txtAlternativeMobileNo.Text = r2["Alternative_MobileNo"].ToString().Trim();
			txtReferenceName.Text = r2["Reference_By"].ToString().Trim();
			txtReferenceMobileNo.Text = r2["ReferenceByMobileNo"].ToString().Trim();

			txtAadharCardNo.Text = r2["Aadhar_Card_No"].ToString().Trim();
			txtPANCardNo.Text = r2["PANCardNo"].ToString().Trim();
			txtBankAccountStatement.Text = r2["BankAccountStatement"].ToString().Trim();
			txtPassportNo.Text = r2["PassportNo"].ToString().Trim();
			txtElectionCardNo.Text = r2["Election_Card_No"].ToString().Trim();
			txtRationCardNo.Text = r2["RationCardNo"].ToString().Trim();
			//txtDLVerifiedDate.Text = r2["License_Verified_Dt"].ToString().Trim();
			txtDLVerifiedDate.Text = r2["DriverVerifiedDate"].ToString().Trim();
			txtDriverLicVerfiedBy.Text = r2["driververifiedby"].ToString().Trim();

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
			if (r2["AgreementCopy_File"].ToString() != "")
			{
				lblAgreementCopyUpload.Text = r2["AgreementCopy_File"].ToString().Trim();
			}
		}
		r2.Close();
		conn.Close();
	}
	protected void txtMDCode_TextChanged(object sender, EventArgs e)
	{
		SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		conn.Open();
		lblCheckCode.Text = "";
		lblCheckCode.Visible = false;
		string STR = "select *  from WEBX_FLEET_DRIVERMST where Manual_Driver_Code='" + txtMDCode.Text.Trim() + "' ";
		SqlCommand cmd = new SqlCommand(STR, conn);
		SqlDataReader dr = cmd.ExecuteReader();
		if (dr.HasRows)
		{
			while (dr.Read())
			{
				DataFound = "Y";

			}
		}
		dr.Close();
		conn.Close();
		if (DataFound == "Y")
		{
			lblCheckCode.Visible = true;
			lblCheckCode.Text = "Please Check! Duplicate Driver code!";
		}
		else
		{
			lblCheckCode.Text = "";
			lblCheckCode.Visible = false;
		}
	}
	protected void txtVehicleNo_TextChanged(object sender, EventArgs e)
	{
		if (txtVehicleNo.Text.ToString().Trim() != "")
		{
			SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
			conn.Open();
			string STR = "select ISNULL(DM.VEHNO,'') AS VehicleNo, Driver_Name AS DriverName, Driver_Id AS DriverId FROM webx_VEHICLE_HDR VH INNER JOIN WEBX_FLEET_DRIVERMST DM WITH(NOLOCK) ON DM.VEHNO = VH.VEHNO  WHERE DM.VEHNO='" + txtVehicleNo.Text.ToString().Trim() + "' AND ISNULL(IsPrivateVehicle,'N') != 'Y' AND DM.ACTIVEFLAG='Y' AND Driver_Name!='" + txtDriverName.Text + "'";
			string DataFound = "N";
			string DriverName = "", DriverId = "";
			SqlCommand cmd = new SqlCommand(STR, conn);
			SqlDataReader dr = cmd.ExecuteReader();
			if (dr.HasRows)
			{
				while (dr.Read())
				{
					DataFound = "Y";
					DriverName = dr["DriverName"].ToString();
					DriverId = dr["DriverId"].ToString();
				}
			}
			dr.Close();
			conn.Close();
			if (DataFound == "Y")
			{
				lblCheck.Visible = true;
				lblCheck.Text = "This Vehicle No. linked with " + DriverName + " : " + DriverId;
				txtVehicleNo.Text = "";
			}
			else
			{
				string VehicleNo = txtVehicleNo.Text.ToString().Trim();
				conn.Open();
				SqlCommand cmd1 = new SqlCommand("Usp_DriverMaster_TripsheetPendingforFinancialClose", conn);
				cmd1.CommandType = CommandType.StoredProcedure;
				cmd1.Parameters.AddWithValue("@VehNo", VehicleNo);

				SqlDataReader dr1 = cmd1.ExecuteReader();
				if (dr1.HasRows)
				{
					while (dr1.Read())
					{
						DataFound = "Y";
						DriverName = dr1["DriverName"].ToString();
						DriverId = dr1["DriverId"].ToString();
					}
				}
				dr1.Close();
				conn.Close();
				if (DataFound == "Y")
				{
					lblCheck.Visible = true;
					lblCheck.Text = "This Vehicle with Tripsheet Pending for Financial close " + DriverName + " : " + DriverId;
					txtVehicleNo.Text = "";
				}
				else
				{
					lblCheck.Visible = false;
					//lblCheck.Text = "Invalid Vehicle Number!";
				}

			}
		}
	}

	public void addLocation()
	{

		SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		// string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
		string STR = "select LocCode,LocName from webx_location where ActiveFlag='Y'";
		conn.Open();
		SqlCommand cmd = new SqlCommand(STR, conn);
		SqlDataReader dr = cmd.ExecuteReader();
		ddlLocation.Items.Add(new ListItem("Select"));

		if (dr.HasRows)
		{
			while (dr.Read())
			{

				ddlLocation.Items.Add(new ListItem(Convert.ToString(dr["LocName"]), Convert.ToString(dr["LocCode"])));
			}
		}

		dr.Close();
		conn.Close();

	}
	protected void cmdSubmit_Click(object sender, EventArgs e)
	{
		SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		if (txtVehicleNo.Text.Trim() == "")
		{
			lblCheck.Visible = true;
			lblCheck.Text = "Please Enter  Vehicle No.";
			return;
		}
		if (txtVehicleNo.Text.ToString().Trim() != "")
		{
			conn.Open();
			string STR = "select ISNULL(DM.VEHNO,'') AS VehicleNo, Driver_Name AS DriverName, Driver_Id AS DriverId FROM webx_VEHICLE_HDR VH INNER JOIN WEBX_FLEET_DRIVERMST DM WITH(NOLOCK) ON DM.VEHNO = VH.VEHNO  WHERE DM.VEHNO='" + txtVehicleNo.Text.ToString().Trim() + "' AND ISNULL(IsPrivateVehicle,'N') != 'Y' AND DM.ACTIVEFLAG='Y' AND  Driver_Name!='" + txtDriverName.Text + "'";
			string DataFound = "N";
			string DriverName = "", DriverId = "";
			SqlCommand cmd = new SqlCommand(STR, conn);
			SqlDataReader dr = cmd.ExecuteReader();
			if (dr.HasRows)
			{
				while (dr.Read())
				{
					if(cboStatus.SelectedValue =="Y"){
					DataFound = "Y";
					DriverName = dr["DriverName"].ToString();
					DriverId = dr["DriverId"].ToString();
					}
				}
			}
			dr.Close();
			conn.Close();
			if (DataFound == "Y" )
			{
				lblCheck.Visible = true;
				lblCheck.Text = "This Vehicle No. linked with " + DriverName + " : " + DriverId;
				txtVehicleNo.Text = "";
				return;
			}
			else
			{
				string VehicleNo = txtVehicleNo.Text.ToString().Trim();
				conn.Open();
				SqlCommand cmd1 = new SqlCommand("Usp_DriverMaster_TripsheetPendingforFinancialClose", conn);
				cmd1.CommandType = CommandType.StoredProcedure;
				cmd1.Parameters.AddWithValue("@VehNo", VehicleNo);

				SqlDataReader dr1 = cmd1.ExecuteReader();
				if (dr1.HasRows)
				{
					while (dr1.Read())
					{
						DataFound = "Y";
						DriverName = dr1["DriverName"].ToString();
						DriverId = dr1["DriverId"].ToString();
					}
				}
				dr1.Close();
				conn.Close();
				if (DataFound == "Y")
				{
					lblCheck.Visible = true;
					lblCheck.Text = "This Vehicle with Tripsheet Pending for Financial close " + DriverName + " : " + DriverId;
					txtVehicleNo.Text = "";
					return;
				}
				else
				{
					lblCheck.Visible = false;
					//lblCheck.Text = "Invalid Vehicle Number!";
					//return;
				}

			}
		}
				
		conn.Open();
		lblAdharCard.Text = "";
		lblAdharCard.Visible = false;
		if (txtAadharCardNo.Text.Trim() == "")
		{
			lblAdharCard.Visible = true;
			lblAdharCard.Text = "Please Enter Aadhar Card No";
			return;
		}
		else if (txtAadharCardNo.Text.Length != 12)
		{
			lblAdharCard.Visible = true;
			lblAdharCard.Text = "Please Enter Valid Aadhar Card No";
			txtAadharCardNo.Text = "";
			return;
		}
		else
		{
			string STR = "select ISNULL(Aadhar_Card_No,'') AS AadharCard, Driver_Name AS DriverName, Driver_Id AS DriverId from WEBX_FLEET_DRIVERMST where Aadhar_Card_No='" + txtAadharCardNo.Text.Trim() + "' AND Driver_Name!='" + txtDriverName.Text + "'";
			SqlCommand cmd = new SqlCommand(STR, conn);
			SqlDataReader dr = cmd.ExecuteReader();
			string DriverName = "", DriverId = "";
			if (dr.HasRows)
			{
				while (dr.Read())
				{
					DataFound = "Y";
					DriverName = dr["DriverName"].ToString();
					DriverId = dr["DriverId"].ToString();
				}
			}
			if (DataFound == "Y")
			{
				lblAdharCard.Visible = true;
				lblAdharCard.Text = "This Aadhar No. linked with " + DriverName + " : " + DriverId;
				txtAadharCardNo.Text = "";
				return;
			}
			else
			{
				lblAdharCard.Text = "";
				lblAdharCard.Visible = false;
			}
			dr.Close();
			conn.Close();
		}


		string IsValidationOccure = "";
		if (txtVehicleNo.Text.ToString().Trim() != "")
		{
			string VehicleNo = txtVehicleNo.Text.ToString().Trim();
			conn.Open();
			SqlCommand cmd1 = new SqlCommand("USP_DriverMaster_VehicleWithPendingBalance_Details", conn);
			cmd1.CommandType = CommandType.StoredProcedure;
			cmd1.Parameters.AddWithValue("@VehNo", VehicleNo);

			SqlDataReader dr1 = cmd1.ExecuteReader();
			if (dr1.HasRows)
			{
				while (dr1.Read())
				{
					DataFound = "Y";
				}
			}
			dr1.Close();
			conn.Close();
			if (DataFound == "Y")
			{
				IsValidationOccure = "Y";
				//SqlCommand cmd2 = new SqlCommand("Usp_DriverMaster_InsertDriverValidation", conn);
				//cmd2.CommandType = CommandType.StoredProcedure;
				//cmd2.Parameters.AddWithValue("@DriverID", VehicleNo);
				//cmd2.Parameters.AddWithValue("@VehicleNo", VehicleNo);
				//cmd2.Parameters.AddWithValue("@PendingBalanceAmount", VehicleNo);
				//cmd2.Parameters.AddWithValue("@EntryBy", VehicleNo);
				//lblCheck.Visible = true;
				//lblCheck.Text = "This Vehicle with Tripsheet Pending for Financial close " + DriverName + " : " + DriverId;
				//txtVehicleNo.Text = "";
				//return;
			}
			else
			{
				IsValidationOccure = "N";
			}
			//else
			//{
			//    //lblCheck.Visible = false;
			//    //lblCheck.Text = "Invalid Vehicle Number!";
			//    //return;
			//}

		}

		lblErrMsg.Text = "";
		//SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		conn.Open();
		int mFileSizeLimit = 1048576;//1 MB
		int mFileSizeLimit_KB = 1048576 / 1024;
		string path = Server.MapPath("~/UploadedImages/");
		if (fileAadharCardNo.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = fileAadharCardNo.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = fileAadharCardNo.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				AadharCard_File = path + fileAadharCardNo.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Aadhar Card No. File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}

		if (FileElectionCardNo.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FileElectionCardNo.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FileElectionCardNo.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				ElectionCard_File = path + FileElectionCardNo.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Election Card No. File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}
		if (FileRationCardNo.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FileRationCardNo.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FileRationCardNo.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				RationCard_File = path + FileRationCardNo.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Ration Card No. File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}
		if (FilePassportNo.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FilePassportNo.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FilePassportNo.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				Passport_File = path + FilePassportNo.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Passport No. File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}
		if (FilePANCardNo.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FilePANCardNo.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FilePANCardNo.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				PANCard_File = path + FilePANCardNo.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "PAN Card No. File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}
		if (FileBankAccountStatement.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FileBankAccountStatement.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FileBankAccountStatement.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				BankAccountStatement_File = path + FileBankAccountStatement.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Bank Account Statement File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}

		if (FilePhoto.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FilePhoto.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FilePhoto.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				Photo_File = path + FilePhoto.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Driver Photo File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}

		if (FileDriverBioData.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FileDriverBioData.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FileDriverBioData.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				DriverBioData_File = path + FileDriverBioData.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Driver Bio Data File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}

		if (FileDLVerifiedDate.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FileDLVerifiedDate.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FileDLVerifiedDate.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				DLVerifiedDate_File = path + FileDLVerifiedDate.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "D/L Verified File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}

		if (FileAgreementCopyUpload.PostedFile != null)
		{
			// Get a reference to PostedFile object
			HttpPostedFile myFile = FileAgreementCopyUpload.PostedFile;
			// Get size of uploaded file
			int nFileLen = myFile.ContentLength;
			// make sure the size of the file is > 0
			if (nFileLen > 0 && nFileLen < mFileSizeLimit)
			{
				string picname = FileAgreementCopyUpload.PostedFile.FileName;
				string c = System.IO.Path.GetFileName(picname);
				AgreementCopy_File = path + FileAgreementCopyUpload.FileName;
			}
			if (nFileLen > mFileSizeLimit)
			{
				lblErrMsg.Text = "Agreement Copy File Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
			}
		}

		if (fileAadharCardNo.PostedFile.FileName != "")
		{
			selvaluesArr1 = fileAadharCardNo.FileName.Split(new char[] { '.' });
			int maxarr1 = selvaluesArr1.GetUpperBound(0);
			for (int i = 0; i <= maxarr1; i++)
			{
				List1 = selvaluesArr1[1].ToString().Trim();
			}
		}
		if (FileElectionCardNo.PostedFile.FileName != "")
		{
			selvaluesArr2 = FileElectionCardNo.FileName.Split(new char[] { '.' });
			int maxarr2 = selvaluesArr2.GetUpperBound(0);
			for (int i = 0; i <= maxarr2; i++)
			{
				List2 = selvaluesArr2[1].ToString().Trim();
			}
		}
		if (FileRationCardNo.PostedFile.FileName != "")
		{
			selvaluesArr3 = FileRationCardNo.FileName.Split(new char[] { '.' });
			int maxarr3 = selvaluesArr3.GetUpperBound(0);
			for (int i = 0; i <= maxarr3; i++)
			{
				List3 = selvaluesArr3[1].ToString().Trim();
			}
		}
		if (FilePassportNo.PostedFile.FileName != "")
		{
			selvaluesArr4 = FilePassportNo.FileName.Split(new char[] { '.' });
			int maxarr4 = selvaluesArr4.GetUpperBound(0);
			for (int i = 0; i <= maxarr4; i++)
			{
				List4 = selvaluesArr4[1].ToString().Trim();
			}
		}
		if (FilePANCardNo.PostedFile.FileName != "")
		{
			selvaluesArr5 = FilePANCardNo.FileName.Split(new char[] { '.' });
			int maxarr5 = selvaluesArr5.GetUpperBound(0);
			for (int i = 0; i <= maxarr5; i++)
			{
				List5 = selvaluesArr5[1].ToString().Trim();
			}
		}
		if (FileBankAccountStatement.PostedFile.FileName != "")
		{
			selvaluesArr6 = FileBankAccountStatement.FileName.Split(new char[] { '.' });
			int maxarr6 = selvaluesArr6.GetUpperBound(0);
			for (int i = 0; i <= maxarr6; i++)
			{
				List6 = selvaluesArr6[1].ToString().Trim();
			}
		}
		if (FilePhoto.PostedFile.FileName != "")
		{
			selvaluesArr7 = FilePhoto.FileName.Split(new char[] { '.' });
			int maxarr7 = selvaluesArr7.GetUpperBound(0);
			for (int i = 0; i <= maxarr7; i++)
			{
				List7 = selvaluesArr7[1].ToString().Trim();
			}
		}
		if (FileDriverBioData.PostedFile.FileName != "")
		{
			selvaluesArr8 = FileDriverBioData.FileName.Split(new char[] { '.' });
			int maxarr8 = selvaluesArr8.GetUpperBound(0);
			for (int i = 0; i <= maxarr8; i++)
			{
				List8 = selvaluesArr8[1].ToString().Trim();
			}
		}
		if (FileDLVerifiedDate.PostedFile.FileName != "")
		{
			selvaluesArr9 = FileDLVerifiedDate.FileName.Split(new char[] { '.' });
			int maxarr9 = selvaluesArr9.GetUpperBound(0);
			for (int i = 0; i <= maxarr9; i++)
			{
				List9 = selvaluesArr9[1].ToString().Trim();
			}
		}
		if (FileAgreementCopyUpload.PostedFile.FileName != "")
		{
			selvaluesArr10 = FileAgreementCopyUpload.FileName.Split(new char[] { '.' });
			int maxarr10 = selvaluesArr10.GetUpperBound(0);
			for (int i = 0; i <= maxarr10; i++)
			{
				List10 = selvaluesArr10[1].ToString().Trim();
			}
		}

		if (lblErrMsg.Text == "")
		{
			SqlCommand sqlc = new SqlCommand("usp_createFileName_FA", conn);
			sqlc.CommandType = CommandType.StoredProcedure;
			sqlc.Parameters.Add("@Electricity_Bill_File", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@Telephone_Bill_File", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@BankAcc_File", SqlDbType.VarChar).Value = BankAccountStatement_File.ToString();
			sqlc.Parameters.Add("@Passport_File", SqlDbType.VarChar).Value = Passport_File.ToString().Trim();
			sqlc.Parameters.Add("@Rationcard_File", SqlDbType.VarChar).Value = RationCard_File.ToString();
			sqlc.Parameters.Add("@ID_Passport_File", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@Driving_lic_File", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@VoterId_File", SqlDbType.VarChar).Value = ElectionCard_File.ToString();
			sqlc.Parameters.Add("@PAN_File", SqlDbType.VarChar).Value = PANCard_File;
			sqlc.Parameters.Add("@Photo", SqlDbType.VarChar).Value = Photo_File.ToString();
			sqlc.Parameters.Add("@DriverRegistrationForm", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@ThumbImpression", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@Form_File", SqlDbType.VarChar).Value = "";
			sqlc.Parameters.Add("@DriverBioData_File", SqlDbType.VarChar).Value = DriverBioData_File.ToString();
			sqlc.Parameters.Add("@AadharCard_File", SqlDbType.VarChar).Value = AadharCard_File.ToString();
			sqlc.Parameters.Add("@DriverVerified_File", SqlDbType.VarChar).Value = DLVerifiedDate_File.ToString();
			sqlc.Parameters.Add("@AgreementCopy_File", SqlDbType.VarChar).Value = AgreementCopy_File.ToString();
			SqlDataReader sdr = sqlc.ExecuteReader();
			if (sdr.HasRows)
			{
				while (sdr.Read())
				{

					mBankAccountStatement_FileName = Convert.ToString(sdr["BStat"]).ToString();
					mPassport_FileName = Convert.ToString(sdr["Passport"]).ToString();
					mRationCard_FileName = Convert.ToString(sdr["RCard"]).ToString();
					mElectionCard_FileName = Convert.ToString(sdr["VoteID"]).ToString();
					mPANCard_FileName = Convert.ToString(sdr["PCard"]).ToString();
					mPhoto_FileName = Convert.ToString(sdr["Photo"]).ToString();
					mDriverBioData_FileName = Convert.ToString(sdr["BioData"]).ToString();
					mAadharCard_FileName = Convert.ToString(sdr["AadharCard"]).ToString();
					mDLVerifiedDate_FileName = Convert.ToString(sdr["DriverVerified"]).ToString();
					mAgreementCopy_FileName = Convert.ToString(sdr["AgreementCopyFile"]).ToString();
				}
			}
			sdr.Close();
			if (fileAadharCardNo.PostedFile.FileName != "")
			{
				string fileAadharCardNoName = mAadharCard_FileName + '.' + List1;
				fileAadharCardNo.PostedFile.SaveAs(path + fileAadharCardNoName);
				AadharCard_File_Name = fileAadharCardNoName;
			}
			if (FileElectionCardNo.PostedFile.FileName != "")
			{
				string FileElectionCardNoName = mElectionCard_FileName + '.' + List2;
				FileElectionCardNo.PostedFile.SaveAs(path + FileElectionCardNoName);
				ElectionCard_File_Name = FileElectionCardNoName;
			}
			if (FileRationCardNo.PostedFile.FileName != "")
			{
				string FileRationCardNoName = mRationCard_FileName + '.' + List3;
				FileRationCardNo.PostedFile.SaveAs(path + FileRationCardNoName);
				RationCard_File_Name = FileRationCardNoName;
			}
			if (FilePassportNo.PostedFile.FileName != "")
			{
				string FilePassportNoName = mPassport_FileName + '.' + List4;
				FilePassportNo.PostedFile.SaveAs(path + FilePassportNoName);
				Passport_File_Name = FilePassportNoName;
			}
			if (FilePANCardNo.PostedFile.FileName != "")
			{
				string FilePANCardNoName = mPANCard_FileName + '.' + List5;
				FilePANCardNo.PostedFile.SaveAs(path + FilePANCardNoName);
				PANCard_File_Name = FilePANCardNoName;
			}
			if (FileBankAccountStatement.PostedFile.FileName != "")
			{
				string FileBankAccountStatementName = mBankAccountStatement_FileName + '.' + List6;
				FileBankAccountStatement.PostedFile.SaveAs(path + FileBankAccountStatementName);
				BankAccountStatement_File_Name = FileBankAccountStatementName;
			}
			if (FilePhoto.PostedFile.FileName != "")
			{
				string FilePhotoName = mPhoto_FileName + '.' + List7;
				FilePhoto.PostedFile.SaveAs(path + FilePhotoName);
				Photo_File_Name = FilePhotoName;
			}
			if (FileDriverBioData.PostedFile.FileName != "")
			{
				string FileDriverBioDataName = mDriverBioData_FileName + '.' + List8;
				FileDriverBioData.PostedFile.SaveAs(path + FileDriverBioDataName);
				DriverBioData_File_Name = FileDriverBioDataName;
			}
			if (FileDLVerifiedDate.PostedFile.FileName != "")
			{
				string FileDLVerifiedDateName = mDLVerifiedDate_FileName + '.' + List9;
				FileDLVerifiedDate.PostedFile.SaveAs(path + FileDLVerifiedDateName);
				DLVerifiedDate_File_Name = FileDLVerifiedDateName;
			}
			if (FileAgreementCopyUpload.PostedFile.FileName != "")
			{
				string FileAgreementCopyUploadName = mAgreementCopy_FileName + '.' + List10;
				FileAgreementCopyUpload.PostedFile.SaveAs(path + FileAgreementCopyUploadName);
				AgreementCopy_File_Name = FileAgreementCopyUploadName;
			}


			DataTable dt = new DataTable();
			DriverEntity objDriverEntity = new DriverEntity();
			DriverController objDriverController = new DriverController();
			if (AddEditMode == "U")
			{
				objDriverEntity.DriverId = Convert.ToInt32(DriverId);
			}
			objDriverEntity.DriverName = Convert.ToString(txtDriverName.Text);
			objDriverEntity.MenualCode = Convert.ToString(txtMDCode.Text);
			objDriverEntity.FatherName = Convert.ToString(txtFather.Text);
			objDriverEntity.VehicleNo = Convert.ToString(txtVehicleNo.Text);
			objDriverEntity.LocCode = Convert.ToString(hdfLocation.Value);
			objDriverEntity.DriverMobileNo = Convert.ToString(txtContact.Text);
			objDriverEntity.Address = Convert.ToString(txtCAddress.Text);
			objDriverEntity.DOB = Convert.ToString(txtDOB.SelectedDate.ToString("yyyy-MM-dd") == "0001-01-01" ? "1900-01-01" : txtDOB.SelectedDate.ToString("yyyy-MM-dd"));
			objDriverEntity.DriverLicenceValidity = Convert.ToString(txtValDt.SelectedDate.ToString("yyyy-MM-dd"));
			objDriverEntity.DriverLicenceNo = Convert.ToString(txtLicNo.Text);
			objDriverEntity.LicenceIssueDate = Convert.ToString(txtLicIssueDate.SelectedDate.ToString("yyyy-MM-dd") == "0001-01-01" ? "1900-01-01" : txtLicIssueDate.SelectedDate.ToString("yyyy-MM-dd"));
			objDriverEntity.RTO = Convert.ToString(txtRTO.Text);
			//objDriverEntity.status = Convert.ToString(hdfStatus.Value);
			objDriverEntity.status = Convert.ToString(cboStatus.SelectedValue);
			objDriverEntity.LicenceCategory = Convert.ToString(ddlLicCategory.SelectedValue);
			objDriverEntity.AddressVerifiedBy = Convert.ToString(txtAddressVerfiedBy.Text);
			objDriverEntity.AddressVerifiedDate = Convert.ToString(txtAddressVerfiedDate.SelectedDate.ToString("yyyy-MM-dd") == "0001-01-01" ? "1900-01-01" : txtAddressVerfiedDate.SelectedDate.ToString("yyyy-MM-dd"));
			objDriverEntity.Vilage = Convert.ToString(txtVillageName.Text);
			objDriverEntity.Tehseel = Convert.ToString(txtTahseel.Text);
			objDriverEntity.Po = Convert.ToString(txtPO.Text);
			objDriverEntity.PS = Convert.ToString(txtPS.Text);
			objDriverEntity.Dist = Convert.ToString(txtDist.Text);
			objDriverEntity.State = Convert.ToString(hdfState.Value);
			objDriverEntity.VilageMobileNo = Convert.ToString(txtVillageMobileNo.Text);
			objDriverEntity.alternativeMobile = Convert.ToString(txtAlternativeMobileNo.Text);
			objDriverEntity.RefName = Convert.ToString(txtReferenceName.Text);
			objDriverEntity.RefMobileNo = Convert.ToString(txtReferenceMobileNo.Text);
			objDriverEntity.AadharCardNo = Convert.ToString(txtAadharCardNo.Text);
			objDriverEntity.ElectionCardNo = Convert.ToString(txtElectionCardNo.Text);
			objDriverEntity.RationCardNo = Convert.ToString(txtRationCardNo.Text);
			objDriverEntity.PassportNo = Convert.ToString(txtPassportNo.Text);
			objDriverEntity.PANCardNo = Convert.ToString(txtPANCardNo.Text);
			objDriverEntity.BankAccountStatement = Convert.ToString(txtBankAccountStatement.Text);
			objDriverEntity.DriverVerifiedBy = Convert.ToString(txtDriverLicVerfiedBy.Text);
			objDriverEntity.DriverVerifiedDate = Convert.ToString(txtDLVerifiedDate.SelectedDate.ToString("yyyy-MM-dd") == "0001-01-01" ? "1900-01-01" : txtDLVerifiedDate.SelectedDate.ToString("yyyy-MM-dd"));

			objDriverEntity.AadharCard_File_Name = Convert.ToString(AadharCard_File_Name.Trim());
			objDriverEntity.ElectionCard_File_Name = Convert.ToString(ElectionCard_File_Name.Trim());
			objDriverEntity.RationCard_File_Name = Convert.ToString(RationCard_File_Name.Trim());
			objDriverEntity.Passport_File_Name = Convert.ToString(Passport_File_Name.Trim());
			objDriverEntity.PANCard_File_Name = Convert.ToString(PANCard_File_Name.Trim());
			objDriverEntity.BankAccountStatement_File_Name = Convert.ToString(BankAccountStatement_File_Name.Trim());
			objDriverEntity.Photo_File_Name = Convert.ToString(Photo_File_Name.Trim());
			objDriverEntity.DriverBioData_File_Name = Convert.ToString(DriverBioData_File_Name.Trim());
			objDriverEntity.DLVerifiedDate_File_Name = Convert.ToString(DLVerifiedDate_File_Name.Trim());
			objDriverEntity.AgreementCopy_File_Name = Convert.ToString(AgreementCopy_File_Name.Trim());
			objDriverEntity.IsValidationOccure = IsValidationOccure;
			try
			{
				if (AddEditMode.ToString().Trim() == "I")
				{
					dt = objDriverController.GenerateDriver_Insert(objDriverEntity);
				}
				else
				{
					dt = objDriverController.GenerateDriver_Edit(objDriverEntity);
				}
			}
			catch (Exception exp)
			{
				throw exp;
			}


			if (dt.Rows.Count > 0)
			{
				DataRow ResultDtlRow = dt.Rows[0];
				if (ResultDtlRow["IsSuccess"] != DBNull.Value)
				{
					int status = Convert.ToInt32(ResultDtlRow["IsSuccess"]);
					if (status == 1)
					{
						Response.Redirect("~/GUI/Fleet/Webadmin/Driver/DriverResult.aspx?driver=" + txtDriverName.Text + "&Fname=" + txtFather.Text, true);
					}
					else
					{
						lblErrMsg.Visible = true;
						lblErrMsg.Text = "Sorry,Driver already Exists !!!";
						//Response.End();
					}
				}
			}
			else
			{
				lblErrMsg.Visible = true;
				lblErrMsg.Text = "Sorry,Driver already Exists !!!";
				//Response.End();
			}
		}

		conn.Close();

	}
	public void BindState()
	{
		try
		{
			var objDriverController = new DriverController();
			ddlstate.DataSource = objDriverController.GetStateList();
			ddlstate.DataTextField = "STNAME";
			ddlstate.DataValueField = "STCODE";
			ddlstate.DataBind();

		}
		catch (Exception e)
		{

		}
	}
	protected void txtAadharCardNo_TextChanged(object sender, EventArgs e)
	{
		SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		conn.Open();
		lblAdharCard.Text = "";
		lblAdharCard.Visible = false;
		if (txtAadharCardNo.Text.Trim() == "")
		{
			lblAdharCard.Visible = true;
			lblAdharCard.Text = "Please Enter Aadhar Card No";
		}
		else if (txtAadharCardNo.Text.Length != 12)
		{
			lblAdharCard.Visible = true;
			lblAdharCard.Text = "Please Enter Valid Aadhar Card No";
			txtAadharCardNo.Text = "";
		}
		else
		{
			string STR = "select ISNULL(Aadhar_Card_No,'') AS AadharCard, Driver_Name AS DriverName, Driver_Id AS DriverId from WEBX_FLEET_DRIVERMST where Aadhar_Card_No='" + txtAadharCardNo.Text.Trim() + "' AND Driver_Name!='"+txtDriverName.Text+"'";
			SqlCommand cmd = new SqlCommand(STR, conn);
			SqlDataReader dr = cmd.ExecuteReader();
			string DriverName = "", DriverId = "";
			if (dr.HasRows)
			{
				while (dr.Read())
				{
					DataFound = "Y";
					DriverName = dr["DriverName"].ToString();
					DriverId = dr["DriverId"].ToString();
				}
			}
			if (DataFound == "Y")
			{
				lblAdharCard.Visible = true;
				lblAdharCard.Text = "This Aadhar No. linked with " + DriverName + " : " + DriverId;
				txtAadharCardNo.Text = "";
			}
			else
			{
				lblAdharCard.Text = "";
				lblAdharCard.Visible = false;
			}
			dr.Close();
			conn.Close();
		}
	}

	protected void txtLicNo_TextChanged(object sender, EventArgs e)
	{
		SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
		conn.Open();
		lblLicNo.Text = "";
		lblLicNo.Visible = false;
		string STR = "select ISNULL(License_No,'') AS LicenseNo, Driver_Name AS DriverName, Driver_Id AS DriverId from WEBX_FLEET_DRIVERMST where License_No='" + txtLicNo.Text.Trim() + "' AND Driver_Name!='" + txtDriverName.Text + "'";
		SqlCommand cmd = new SqlCommand(STR, conn);
		SqlDataReader dr = cmd.ExecuteReader();
		string DriverName = "", DriverId = "";
		if (dr.HasRows)
		{
			while (dr.Read())
			{
				DataFound = "Y";
				DriverName = dr["DriverName"].ToString();
				DriverId = dr["DriverId"].ToString();
			}
		}
		if (DataFound == "Y")
		{
			lblLicNo.Visible = true;
			lblLicNo.Text = "This License No. linked with " + DriverName + " : " + DriverId;
			txtLicNo.Text = "";
		}
		else
		{
			lblLicNo.Text = "";
			lblLicNo.Visible = false;
		}
		dr.Close();
		conn.Close();
	}

	protected void cboStatus_SelectedIndexChanged(object sender, EventArgs e)
	{
		if (txtVehicleNo.Text.ToString().Trim() != "")
		{
			if (cboStatus.SelectedValue.ToString() == "N")
			{
				SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
				string VehicleNo = txtVehicleNo.Text.ToString().Trim();
				conn.Open();
				SqlCommand cmd1 = new SqlCommand("Usp_DriverMaster_TripsheetPendingforFinancialClose", conn);
				cmd1.CommandType = CommandType.StoredProcedure;
				cmd1.Parameters.AddWithValue("@VehNo", VehicleNo);
				string DriverName = "", DriverId = "";
				SqlDataReader dr = cmd1.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						DataFound = "Y";
						DriverName = dr["DriverName"].ToString();
						DriverId = dr["DriverId"].ToString();
					}
				}
				dr.Close();
				conn.Close();
				if (DataFound == "Y")
				{
					lblStatus.Visible = true;
					lblStatus.Text = "Driver can't deactivate!! tripsheet is pending for Financial Close";
					return;
				}
				else
				{
					lblStatus.Visible = false;
					//lblCheck.Text = "Invalid Vehicle Number!";
					//return;
				}
			}
		}

	}
}