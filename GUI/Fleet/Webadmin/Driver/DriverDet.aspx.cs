using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using ApplicationManager;

public partial class admin_DriverDet : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection();//(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    string DriverId = ""; string DataFoundFlag = "N",AddEditMode="",sql="",codevalue="",Photo="";

    string Electricity_Bill_YN = "", EBill_Name = "", Telephone_Bill_YN = "", TPhone_Name = "", Bank_Acc_YN = "", Electricity_Bill_Name = "", Bank_Acc_Name = "", Passport_YN = "", Passport_Name = "", Rationcard_YN = "", Rationcard_Name = "", ID_Passport_YN = "", ID_Passport_Name = "", Photo_YN="";

    string DataFound = "N";
    string E_Bill_Name = "", T_Bill_Name = "", B_Acc_Name = "", Pass_Name = "", Rcard_Name = "", ID_Pass_Name = "", PAN_N = "", VId_Name = "", D_lic_Name = "", Photo_Name = "";
    string Driving_lic_YN = "", Driving_lic_Name = "", Telephone_Bill_Name="", VoterId_YN = "", VoterId_Name = "", PAN_YN = "", PAN_Name = "";
    string Driver_Registration_YN = "", Driver_Registration_Name = "", Thumb_YN = "", Thumb_Name = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        DriverId = Request.QueryString["id"];
        lblCheck.Text = "";
        addLocation();
        addDriverCategory();
        addEthnicity();
        if (!IsPostBack)
        {
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            hfTodayDate.Value = righnow.ToString("dd/MM/yyyy");

            if (DriverId != "" && DriverId != null)
            {
                Inetialized();
               AddEditMode = "U";
                ViewState["AddEditMode"] = AddEditMode;
            }
            else
            {
                AddEditMode = "I";
                ViewState["AddEditMode"] = AddEditMode;
            }
        }
    }

    public void addLocation()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
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
  public void addDriverCategory()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select Codedes from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select CodeId,CodeDesc  from Webx_Master_General where codetype = 'DRVCAT' and StatusCode='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        DdlCategory.Items.Add(new ListItem("Select"));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                DdlCategory.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }

        }

        dr.Close();
        conn.Close();

    }
    public void addEthnicity()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //   string STR = "select VEHNO from webx_VEHICLE_HDR  where ActiveFlag='Y'   and  Vendor_Own='O' order by VEHNO";
        string STR = "select CodeId,CodeDesc from Webx_Master_General where codetype  = 'DRVETH' and StatusCode='Y'";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        DdlCity.Items.Add(new ListItem("Select"));

        if (dr.HasRows)
        {
            while (dr.Read())
            {

                DdlCity.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }

        }

        dr.Close();
        conn.Close();

    }

    //protected void doOnDataBound(object sender, EventArgs e)
    //{
    //    DropDownList cbo = (DropDownList)sender;
    //    cbo.Items.Insert(0, "");
    //    cbo.Items[0].Text = "Select";
    //    cbo.Items[0].Value = "";
    //    //cbo.Items[0].Selected = true;
    //    doSub(sender);
    //}



    public void Inetialized()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "usp_DriverAdd_List";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        sqlcmd2.CommandType = CommandType.StoredProcedure;
        conn.Open();

        string mFlag = "", mLocation="";
        sqlcmd2.Parameters.Add("@DriverID", SqlDbType.VarChar).Value = DriverId;

        SqlDataReader r2 = sqlcmd2.ExecuteReader();
         
        while (r2.Read())
        {
          
            txtDriverName.Text = r2["Driver_Name"].ToString().Trim();
            // txtBrandName.ReadOnly = true;



            mLocation = r2["Driver_Location"].ToString().Trim();
            for (int i = 0; i < ddlLocation.Items.Count; i++)
            {
                if (mLocation == ddlLocation.Items[i].Value)
                {
                    ddlLocation.SelectedIndex = i;
                }
            }

            txtMDCode.Text = r2["Manual_Driver_Code"].ToString().Trim();
                                    
            txtFather.Text = r2["DFather_Name"].ToString().Trim();
            txtVehicleNo.Text = r2["VEHNO"].ToString().Trim();
            txtContact.Text = r2["Telno"].ToString().Trim();
            // txtBrandName.ReadOnly = true;
            txtPAddress.Text = r2["P_Address"].ToString().Trim();
            txtCity.Text = r2["P_City"].ToString().Trim();
            txtPin.Text = r2["P_Pincode"].ToString().Trim();

            txtCAddress.Text = r2["C_Address"].ToString().Trim();
            txtCity1.Text = r2["C_City"].ToString().Trim();
            txtPin1.Text = r2["C_Pincode"].ToString().Trim();

            txtLicNo.Text = r2["License_No"].ToString().Trim();
            txtValDt.Text = r2["ValdityDt"].ToString().Trim();
            txtRTO.Text = r2["Issue_By_RTO"].ToString().Trim();
            tb_Guarantor_Name.Text = r2["Guarantor_Name"].ToString().Trim();
            DdlCategory.Text = r2["D_category"].ToString().Trim();
            txtDOB.Text = r2["D_DOB"].ToString().Trim();
            DdlCity.Text = r2["D_Ethnicity_Id"].ToString().Trim();
            txtInitialDate.Text = r2["D_Lic_Initial_Issuance_Date"].ToString().Trim();
            txtCurrentDate.Text = r2["D_Lic_Current_Issuance_Date"].ToString().Trim();
            if (r2["License_Verified"].ToString().Trim() == "Y")
            {
                chkLicVerified.Checked = true;
            }
            else
            {
                chkLicVerified.Checked = false;
            }
            if (r2["Address_Verified"].ToString().Trim() == "Y")
            {
                chkAddVerified.Checked = true;
            }
            else
            {
                chkAddVerified.Checked = false;
            }
            txtLicVerifiedDate.Text = r2["License_Verified_Dt"].ToString().Trim();
            //Driver_Photo
            if (r2["Driver_Photo"].ToString() != "")
            {
                LblDriverPhoto.Text = r2["Driver_Photo"].ToString().Trim();
            }
            else
            {
                LblDriverPhoto.Text = "";
            }

       
            mFlag = r2["ActiveFlag"].ToString().Trim();
           for (int i = 0; i < cboStatus.Items.Count ; i++)
         {
                if (mFlag == cboStatus.Items[i].Value)
            {
                cboStatus.SelectedIndex = i;
            }
         }

         if (r2["Electricity_Bill_YN"].ToString() == "Y")
         {
             chkEBill.Checked = true;
             LblEBill.Text = r2["Electricity_Bill_File"].ToString() ;

         }
         else
         {

             chkEBill.Checked = false;
             LblEBill.Text = "";


         }

         if (r2["Telephone_Bill_YN"].ToString() == "Y")
         {
             chkTelBill.Checked = true;
             LblTelBill.Text = r2["Telephone_Bill_File"].ToString();

         }
         else
         {

             chkTelBill.Checked = false;
             LblTelBill.Text = "";


         }

         if (r2["BankAcc_YN"].ToString() == "Y")
         {
             chkBAStat.Checked = true;
             LblBAStat.Text = r2["BankAcc_File"].ToString();

         }
         else
         {

             chkBAStat.Checked = false;
             LblBAStat.Text = "";

         }

         if (r2["Passport_YN"].ToString() == "Y")
         {
             chkPassport.Checked = true;
             LblPassport.Text = r2["Passport_File"].ToString();

         }
         else
         {

             chkPassport.Checked = false;


         }

         if (r2["Rationcard_YN"].ToString() == "Y")
         {
             chkRationCard.Checked = true;
             LblRationCard.Text = r2["Rationcard_File"].ToString();

         }
         else
         {

             chkRationCard.Checked = false;
             LblRationCard.Text = "";


         }

         if (r2["ID_Passport_YN"].ToString() == "Y")
         {
             chkPass.Checked = true;
             LblPass.Text = r2["ID_Passport_File"].ToString();

         }
         else
         {

             chkPass.Checked = false;
             LblPass.Text = "";


         }






         if (r2["Driving_lic_YN"].ToString() == "Y")
         {
             chkDLiscense.Checked = true;
             LblDLiscense.Text = r2["Driving_lic_File"].ToString();

         }
         else
         {

             chkDLiscense.Checked = false;
             LblDLiscense.Text = "";


         }



         if (r2["VoterId_YN"].ToString() == "Y")
         {
             chkVotersID.Checked = true;
             LblVotersID.Text = r2["VoterId_File"].ToString();

         }
         else
         {

             chkVotersID.Checked = false;
             LblVotersID.Text = "";


         }



         if (r2["PAN_YN"].ToString() == "Y")
         {
             chkPCard.Checked = true;
             LblPCard.Text = r2["PAN_File"].ToString();

         }
         else
         {

             chkPCard.Checked = false;
             LblPCard.Text = "";


         }
         lblThumb.Text = r2["PAN_File"].ToString();

         if (r2["Driver_Registration_Form_YN"].ToString() == "Y")
         {
             chkDriverRegistration.Checked = true;
             LblRegistrationForm.Text = r2["Driver_Registration_Form_File"].ToString();
         }
         else
         {
             chkDriverRegistration.Checked = false;
             LblRegistrationForm.Text = "";
         }
         //fileEBill.PostedFile.FileName = r2["Electricity_Bill_File"].ToString();
         //fileTelBill.PostedFile.FileName = r2["Telephone_Bill_File"].ToString();
         //fileBAStat.PostedFile.FileName = r2["BankAcc_File"].ToString();
         //filePassport.PostedFile.FileName = r2["Passport_File"].ToString();
         //fileRationCard.PostedFile.FileName = r2["Rationcard_File"].ToString();
         //filePass.PostedFile.FileName = r2["ID_Passport_File"].ToString();
         //fileDLiscense.PostedFile.FileName = r2["Driving_lic_File"].ToString();
         //fileVotersID.PostedFile = r2["VoterId_File"].ToString();
         //filePCard.PostedFile.FileName = r2["PAN_File"].ToString();

         //filePhoto.PostedFile.FileName = r2["Driver_Photo"].ToString();







        }
        r2.Close();
        conn.Close();
    }

   


    public void AddEditDriver()
    {

        string[] selvaluesArr1; string[] selvaluesArr2; string[] selvaluesArr3; string[] selvaluesArr4; string[] selvaluesArr5;
        string[] selvaluesArr6; string[] selvaluesArr7; string[] selvaluesArr8; string[] selvaluesArr9; string[] selvaluesArr10;
        string[] selvaluesArr11; string[] selvaluesArr12; 
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        AddEditMode = ViewState["AddEditMode"].ToString();
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        if (AddEditMode.ToString().Trim() == "I")
        {
            
            sql = "usp_DriverCheck";
            SqlCommand sqlcmd1 = new SqlCommand(sql, conn);
            sqlcmd1.CommandType = CommandType.StoredProcedure;            

            //if (DriverId != null)
            //{
            //    sqlcmd1.Parameters.Add("@DriverId", SqlDbType.VarChar).Value = DriverId;
            //}
            //else
            //{
            //    sqlcmd1.Parameters.Add("@DriverId", SqlDbType.VarChar).Value = ;
            //}
            sqlcmd1.Parameters.Add("@DriverName", SqlDbType.VarChar).Value = txtDriverName.Text.ToString().Trim();
            sqlcmd1.Parameters.Add("@FatherName", SqlDbType.VarChar).Value = txtFather.Text.ToString().Trim();
            
            sqlcmd1.Parameters.Add("@LicNo", SqlDbType.VarChar).Value = txtLicNo.Text.ToString();
            //sqlcmd1.Parameters.Add("@ValidityDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtValDt.Text.ToString().Trim(), dtfi);
            //sqlcmd1.Parameters.Add("@RTO", SqlDbType.VarChar).Value = txtRTO.Text.ToString();

            

            SqlDataReader r2 = sqlcmd1.ExecuteReader();

            while (r2.Read())
            {
                DataFoundFlag = "Y";
            }
            r2.Close();
        }


        if (chkEBill.Checked == true) { Electricity_Bill_YN = "Y"; } else { Electricity_Bill_YN = "N"; }
        if (chkTelBill.Checked == true) { Telephone_Bill_YN = "Y"; } else { Telephone_Bill_YN = "N"; }
        if (chkBAStat.Checked == true) { Bank_Acc_YN = "Y"; } else { Bank_Acc_YN = "N"; }
        if (chkPassport.Checked == true) { Passport_YN = "Y"; } else { Passport_YN = "N"; }
        if (chkRationCard.Checked == true) { Rationcard_YN = "Y"; } else { Rationcard_YN = "N"; }
        if (chkPass.Checked == true) { ID_Passport_YN = "Y"; } else { ID_Passport_YN = "N"; }
        if (chkDLiscense.Checked == true) { Driving_lic_YN = "Y"; } else { Driving_lic_YN = "N"; }
        if (chkVotersID.Checked == true) { VoterId_YN = "Y"; } else { VoterId_YN = "N"; }
        if (chkPCard.Checked == true) { PAN_YN = "Y"; } else { PAN_YN = "N"; }
        if (chkDriverRegistration.Checked == true) { Driver_Registration_YN = "Y"; } else { Driver_Registration_YN = "N"; }

        //if (chkPhoto.Checked == true)
        //{
        //    Photo_YN = "Y";
        //}
        //else
        //{
        //    Photo_YN = "N";
        //}
       
        //changed by Jiten on 28Apr10
        //int mFileSizeLimit = 50000;//50 kb
        int mFileSizeLimit = 1048576;//1 MB
        //int mFileSizeLimit_KB = 50000 / 1000;
        int mFileSizeLimit_KB = 1048576 / 1024;

        string path = Server.MapPath("~/UploadedImages/");
        if (fileEBill.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileEBill.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileEBill.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                Electricity_Bill_Name = path + fileEBill.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Electricity Bill Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }
        if (fileTelBill.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileTelBill.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileTelBill.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //fileTelBill.PostedFile.SaveAs(path + fileTelBill.FileName);
                Telephone_Bill_Name = path + fileTelBill.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Telephone Bill Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB) !!! Please Check.";
            }
        }
        if (fileBAStat.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileBAStat.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileBAStat.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

                //string path = Server.MapPath("~/UploadedImages/");
                //fileBAStat.PostedFile.SaveAs(path + fileBAStat.FileName);
                Bank_Acc_Name = path + fileBAStat.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Bank Statement Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }

        if (filePassport.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = filePassport.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = filePassport.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //filePassport.PostedFile.SaveAs(path + filePassport.FileName);
                Passport_Name = path + filePassport.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Passport Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!!  Please Check.";
            }
        }
        if (fileRationCard.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileRationCard.PostedFile;

            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;

            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileRationCard.PostedFile.FileName;

                string c = System.IO.Path.GetFileName(picname);

                //string path = Server.MapPath("~/UploadedImages/");
                //fileRationCard.PostedFile.SaveAs(path + fileRationCard.FileName);
                Rationcard_Name = path + fileRationCard.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Ration card Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }
        if (filePass.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = filePass.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = filePass.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //filePass.PostedFile.SaveAs(path + filePass.FileName);
                ID_Passport_Name = path + filePass.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Passport Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }
        if (fileDLiscense.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileDLiscense.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileDLiscense.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //fileDLiscense.PostedFile.SaveAs(path + fileDLiscense.FileName);
                Driving_lic_Name = path + fileDLiscense.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Drivinh license Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }
        if (fileVotersID.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileVotersID.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileVotersID.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //fileVotersID.PostedFile.SaveAs(path + fileVotersID.FileName);
                VoterId_Name = path + fileVotersID.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Voter's ID Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }
        if (filePCard.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = filePCard.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = filePCard.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //filePCard.PostedFile.SaveAs(path + filePCard.FileName);
                PAN_Name = path + filePCard.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "PAN Card Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB) !!! Please Check.";
            }
        }
        if (filePhoto.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = filePhoto.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = filePhoto.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                //string path = Server.MapPath("~/UploadedImages/");
                //filePhoto.PostedFile.SaveAs(path + filePhoto.FileName);
                Photo = path + filePhoto.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Driver Photo Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit.ToString() + " KB) !!! Please Check.";
            }
        }
        if (fileDriverRegistration.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileDriverRegistration.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileDriverRegistration.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                Driver_Registration_Name = path + fileDriverRegistration.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Driver Registration Form Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }
        if (fileThumb.PostedFile != null)
        {
            // Get a reference to PostedFile object
            HttpPostedFile myFile = fileThumb.PostedFile;
            // Get size of uploaded file
            int nFileLen = myFile.ContentLength;
            // make sure the size of the file is > 0
            if (nFileLen > 0 && nFileLen < mFileSizeLimit)
            {
                string picname = fileThumb.PostedFile.FileName;
                string c = System.IO.Path.GetFileName(picname);
                Thumb_Name = path + fileThumb.FileName;
            }
            if (nFileLen > mFileSizeLimit)
            {
                lblErrMsg.Text = "Thumb Impression Upload File exceeds the desired size limit ( i.e " + mFileSizeLimit_KB.ToString() + " KB)  !!! Please Check.";
            }
        }

        string mPhotoFileName = "", mEBillFileName = "", mTeleBillName = "", mBankFileName = "", mPassportFileName = "", mRCardFileName = "", mIDPassFileName = "", mDLicFileName = "", mVoteFileName = "", mPANFileName = "", mDriverRegistration = "", mThumb = "";
        string List1 = "", List2 = "", List3 = "", List4 = "", List5 = "", List6 = "", List7 = "", List8 = "", List9 = "", List10 = "", List11 = "", List12 = "";
        //  string mFileName = "";
        //fileEBill.FileName=mFileName+""
        if (fileEBill.PostedFile.FileName != "")
        {
            selvaluesArr1 = fileEBill.FileName.Split(new char[] { '.' });
            int maxarr1 = selvaluesArr1.GetUpperBound(0);
            for (int i = 0; i <= maxarr1; i++)
            {
                List1 = selvaluesArr1[1].ToString().Trim();
            }
        }
        if (fileTelBill.PostedFile.FileName != "")
        {
            selvaluesArr2 = fileTelBill.FileName.Split(new char[] { '.' });
            int maxarr2 = selvaluesArr2.GetUpperBound(0);
            for (int i = 0; i <= maxarr2; i++)
            {
                List2 = selvaluesArr2[1].ToString().Trim();
            }
        }
        if (fileBAStat.PostedFile.FileName != "")
        {
            selvaluesArr3 = fileBAStat.FileName.Split(new char[] { '.' });
            int maxarr3 = selvaluesArr3.GetUpperBound(0);
            for (int i = 0; i <= maxarr3; i++)
            {
                List3 = selvaluesArr3[1].ToString().Trim();
            }
        }
        if (filePassport.PostedFile.FileName != "")
        {
            selvaluesArr4 = filePassport.FileName.Split(new char[] { '.' });
            int maxarr4 = selvaluesArr4.GetUpperBound(0);
            for (int i = 0; i <= maxarr4; i++)
            {
                List4 = selvaluesArr4[1].ToString().Trim();
            }
        }
        if (fileRationCard.PostedFile.FileName != "")
        {
            selvaluesArr5 = fileRationCard.FileName.Split(new char[] { '.' });
            int maxarr5 = selvaluesArr5.GetUpperBound(0);
            for (int i = 0; i <= maxarr5; i++)
            {
                List5 = selvaluesArr5[1].ToString().Trim();
            }
        }
        if (filePass.PostedFile.FileName != "")
        {
            selvaluesArr6 = filePass.FileName.Split(new char[] { '.' });
            int maxarr6 = selvaluesArr6.GetUpperBound(0);
            for (int i = 0; i <= maxarr6; i++)
            {
                List6 = selvaluesArr6[1].ToString().Trim();
            }
        }
        if (fileDLiscense.PostedFile.FileName != "")
        {
            selvaluesArr7 = fileDLiscense.FileName.Split(new char[] { '.' });
            int maxarr7 = selvaluesArr7.GetUpperBound(0);
            for (int i = 0; i <= maxarr7; i++)
            {
                List7 = selvaluesArr7[1].ToString().Trim();
            }
        }
        if (fileVotersID.PostedFile.FileName != "")
        {
            selvaluesArr8 = fileVotersID.FileName.Split(new char[] { '.' });
            int maxarr8 = selvaluesArr8.GetUpperBound(0);
            for (int i = 0; i <= maxarr8; i++)
            {
                List8 = selvaluesArr8[1].ToString().Trim();
            }
        }
        if (filePCard.PostedFile.FileName != "")
        {
            selvaluesArr9 = filePCard.FileName.Split(new char[] { '.' });
            int maxarr9 = selvaluesArr9.GetUpperBound(0);
            for (int i = 0; i <= maxarr9; i++)
            {
                List9 = selvaluesArr9[1].ToString().Trim();
            }
        }
        if (filePhoto.PostedFile.FileName != "")
        {
            selvaluesArr10 = filePhoto.FileName.Split(new char[] { '.' });
            int maxarr10 = selvaluesArr10.GetUpperBound(0);
            for (int i = 0; i <= maxarr10; i++)
            {
                List10 = selvaluesArr10[1].ToString().Trim();
            }
        }

        if (fileDriverRegistration.PostedFile.FileName != "")
        {
            selvaluesArr11 = fileDriverRegistration.FileName.Split(new char[] { '.' });
            int maxarr11 = selvaluesArr11.GetUpperBound(0);
            for (int i = 0; i <= maxarr11; i++)
            {
                List11 = selvaluesArr11[1].ToString().Trim();
            }
        }
        if (fileThumb.PostedFile.FileName != "")
        {
            selvaluesArr12 = fileThumb.FileName.Split(new char[] { '.' });
            int maxarr12 = selvaluesArr12.GetUpperBound(0);
            for (int i = 0; i <= maxarr12; i++)
            {
                List12 = selvaluesArr12[1].ToString().Trim();
            }
        }

        if (lblErrMsg.Text=="")
        {
            SqlCommand sqlc = new SqlCommand("usp_createFileName", conn);
            sqlc.CommandType = CommandType.StoredProcedure;
            sqlc.Parameters.Add("@Electricity_Bill_File", SqlDbType.VarChar).Value = Electricity_Bill_Name.ToString().Trim();
            sqlc.Parameters.Add("@Telephone_Bill_File", SqlDbType.VarChar).Value = Telephone_Bill_Name.ToString().Trim();
            sqlc.Parameters.Add("@BankAcc_File", SqlDbType.VarChar).Value = Bank_Acc_Name.ToString();
            sqlc.Parameters.Add("@Passport_File", SqlDbType.VarChar).Value = Passport_Name.ToString().Trim();
            sqlc.Parameters.Add("@Rationcard_File", SqlDbType.VarChar).Value = Rationcard_Name.ToString();
            sqlc.Parameters.Add("@ID_Passport_File", SqlDbType.VarChar).Value = ID_Passport_Name.ToString();
            sqlc.Parameters.Add("@Driving_lic_File", SqlDbType.VarChar).Value = Driving_lic_Name.ToString();
            sqlc.Parameters.Add("@VoterId_File", SqlDbType.VarChar).Value = VoterId_Name.ToString();
            sqlc.Parameters.Add("@PAN_File", SqlDbType.VarChar).Value = PAN_Name.ToString();
            sqlc.Parameters.Add("@Photo", SqlDbType.VarChar).Value = Photo.ToString();
            sqlc.Parameters.Add("@DriverRegistrationForm", SqlDbType.VarChar).Value = Driver_Registration_Name.ToString();
            sqlc.Parameters.Add("@ThumbImpression", SqlDbType.VarChar).Value = Thumb_Name.ToString();
                
            SqlDataReader sdr = sqlc.ExecuteReader();
            if (sdr.HasRows)
            {
                while (sdr.Read())
                {
                    mEBillFileName = Convert.ToString(sdr["EBill"]).ToString();
                    mTeleBillName = Convert.ToString(sdr["TBill"]).ToString();
                    mBankFileName = Convert.ToString(sdr["BStat"]).ToString();
                    mPassportFileName = Convert.ToString(sdr["Passport"]).ToString();
                    mRCardFileName = Convert.ToString(sdr["RCard"]).ToString();
                    mIDPassFileName = Convert.ToString(sdr["IDPass"]).ToString();
                    mDLicFileName = Convert.ToString(sdr["DLic"]).ToString();
                    mVoteFileName = Convert.ToString(sdr["VoteID"]).ToString();
                    mPANFileName = Convert.ToString(sdr["PCard"]).ToString();
                    mPhotoFileName = Convert.ToString(sdr["Photo"]).ToString();
                    mDriverRegistration = Convert.ToString(sdr["RegistrationForm"]).ToString();
                    mThumb = Convert.ToString(sdr["Thumb"]).ToString(); 
                }
            }
            sdr.Close();
            if (fileEBill.PostedFile.FileName != "")
            {
                string EBillFileName = mEBillFileName + '.' + List1;
                fileEBill.PostedFile.SaveAs(path + EBillFileName);
                E_Bill_Name = EBillFileName;
            }
            if (fileTelBill.PostedFile.FileName != "")
            {
                string TeleBillName = mTeleBillName + '.' + List2;
                fileTelBill.PostedFile.SaveAs(path + TeleBillName);
                T_Bill_Name = TeleBillName;
            }
            if (fileBAStat.PostedFile.FileName != "")
            {
                string BankFileName = mBankFileName + '.' + List3;
                fileBAStat.PostedFile.SaveAs(path + BankFileName);
                B_Acc_Name = BankFileName;
            }
            if (filePassport.PostedFile.FileName != "")
            {
                string PassportFileName = mPassportFileName + '.' + List4;
                filePassport.PostedFile.SaveAs(path + PassportFileName);
                Pass_Name = PassportFileName;
            }
            if (fileRationCard.PostedFile.FileName != "")
            {
                string RCardFileName = mRCardFileName + '.' + List5;
                fileRationCard.PostedFile.SaveAs(path + RCardFileName);
                Rcard_Name = RCardFileName;
            }
            if (filePass.PostedFile.FileName != "")
            {
                string IDPassFileName = mIDPassFileName + '.' + List6;
                filePass.PostedFile.SaveAs(path + IDPassFileName);
                ID_Pass_Name = IDPassFileName;
            }
            if (fileDLiscense.PostedFile.FileName != "")
            {
                string DLicFileName = mDLicFileName + '.' + List7;
                fileDLiscense.PostedFile.SaveAs(path + DLicFileName);
                D_lic_Name = DLicFileName;
            }
            if (fileVotersID.PostedFile.FileName != "")
            {
                string VoteFileName = mVoteFileName + '.' + List8;
                fileVotersID.PostedFile.SaveAs(path + VoteFileName);
                VId_Name = VoteFileName;
            }
            if (filePCard.PostedFile.FileName != "")
            {
                string PANFileName = mPANFileName + '.' + List9;
                filePCard.PostedFile.SaveAs(path + PANFileName);
                PAN_N = PANFileName;
            }
            if (filePhoto.PostedFile.FileName != "")
            {
                string PhotoFileName = mPhotoFileName + '.' + List10;
                filePhoto.PostedFile.SaveAs(path + PhotoFileName);
                Photo_Name = PhotoFileName;
            }
            if (fileDriverRegistration.PostedFile.FileName != "")
            {
                string DriverReg = mDriverRegistration + '.' + List11;
                fileDriverRegistration.PostedFile.SaveAs(path + DriverReg);
                Driver_Registration_Name = DriverReg;
            }
            if (fileThumb.PostedFile.FileName != "")
            {
                string ThumbName = mThumb + '.' + List12;
                fileThumb.PostedFile.SaveAs(path + ThumbName);
                Thumb_Name = ThumbName;
            }

            if (DataFoundFlag.ToString().Trim() == "N" && DataFound.ToString().Trim() == "N" && (AddEditMode.ToString().Trim() == "I" || AddEditMode.ToString().Trim() == "U"))
            {
                if (AddEditMode.ToString().Trim() == "I")
                {
                //  gBrandId = hPrevBrandID.Value;
                    sql = "usp_Driver_InsertUpdate";
                    SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
                    sqlcmd2.CommandType = CommandType.StoredProcedure;
                    sqlcmd2.Parameters.Add("@DriverId", SqlDbType.VarChar).Value = "";
                    sqlcmd2.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
                    sqlcmd2.Parameters.Add("@DriverName", SqlDbType.VarChar).Value = txtDriverName.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@ManualDCode", SqlDbType.VarChar).Value = txtMDCode.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@FatherName", SqlDbType.VarChar).Value = txtFather.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehicleNo.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@LicNo", SqlDbType.VarChar).Value = txtLicNo.Text.ToString();
                    sqlcmd2.Parameters.Add("@ValidityDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtValDt.Text.ToString().Trim(), dtfi);
                    sqlcmd2.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboStatus.SelectedItem.Value.ToString();
                    sqlcmd2.Parameters.Add("@RTO", SqlDbType.VarChar).Value = txtRTO.Text.ToString();
                    sqlcmd2.Parameters.Add("@Location", SqlDbType.VarChar).Value = ddlLocation.SelectedItem.Value.ToString().Trim();
                    sqlcmd2.Parameters.Add("@ContactNo", SqlDbType.VarChar).Value = txtContact.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@PAddress", SqlDbType.VarChar).Value = txtPAddress.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@PCity", SqlDbType.VarChar).Value = txtCity.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@PPin", SqlDbType.VarChar).Value = txtPin.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@CAddress", SqlDbType.VarChar).Value = txtCAddress.Text.ToString();
                    sqlcmd2.Parameters.Add("@CCity", SqlDbType.VarChar).Value = txtCity1.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@CPin", SqlDbType.VarChar).Value = txtPin1.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Categoty", SqlDbType.VarChar).Value = DdlCategory.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@DOb", SqlDbType.VarChar).Value =  txtDOB.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Ecity", SqlDbType.VarChar).Value = DdlCity.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Lic_Dt", SqlDbType.VarChar).Value = txtInitialDate.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Lic_Current_Dt", SqlDbType.VarChar).Value =  txtCurrentDate.Text.ToString().Trim();
                    if (chkLicVerified.Checked == true)
                    {
                        sqlcmd2.Parameters.Add("@License_Verified", SqlDbType.VarChar).Value = "Y";
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@License_Verified", SqlDbType.VarChar).Value = "N";
                    }
                    if (chkAddVerified.Checked == true)
                    {
                        sqlcmd2.Parameters.Add("@Address_Verified", SqlDbType.VarChar).Value = "Y";

                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Address_Verified", SqlDbType.VarChar).Value = "N";
                    }
                    sqlcmd2.Parameters.Add("@License_Verified_Dt", SqlDbType.VarChar).Value = txtLicVerifiedDate.Text.ToString().Trim();
                    if (LblDriverPhoto.Text == "")
                    {
                        sqlcmd2.Parameters.Add("@Photo", SqlDbType.VarChar).Value = Photo_Name.ToString();
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Photo", SqlDbType.VarChar).Value = LblDriverPhoto.ToString();
                    }
                    sqlcmd2.Parameters.Add("@Electricity_Bill_YN", SqlDbType.VarChar).Value = Electricity_Bill_YN.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Electricity_Bill_File", SqlDbType.VarChar).Value = E_Bill_Name.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Telephone_Bill_YN", SqlDbType.VarChar).Value = Telephone_Bill_YN.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Telephone_Bill_File", SqlDbType.VarChar).Value = T_Bill_Name.ToString().Trim();
                    sqlcmd2.Parameters.Add("@BankAcc_YN", SqlDbType.VarChar).Value = Bank_Acc_YN.ToString();
                    sqlcmd2.Parameters.Add("@BankAcc_File", SqlDbType.VarChar).Value = B_Acc_Name.ToString();
                    sqlcmd2.Parameters.Add("@Passport_YN", SqlDbType.VarChar).Value = Passport_YN.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Passport_File", SqlDbType.VarChar).Value = Pass_Name.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Rationcard_YN", SqlDbType.VarChar).Value = Rationcard_YN.ToString();
                    sqlcmd2.Parameters.Add("@Rationcard_File", SqlDbType.VarChar).Value = Rcard_Name.ToString();
                    sqlcmd2.Parameters.Add("@ID_Passport_YN", SqlDbType.VarChar).Value = ID_Passport_YN.ToString();
                    sqlcmd2.Parameters.Add("@ID_Passport_File", SqlDbType.VarChar).Value = ID_Pass_Name.ToString();
                    sqlcmd2.Parameters.Add("@Driving_lic_YN", SqlDbType.VarChar).Value = Driving_lic_YN.ToString();
                    sqlcmd2.Parameters.Add("@Driving_lic_File", SqlDbType.VarChar).Value = D_lic_Name.ToString();
                    sqlcmd2.Parameters.Add("@VoterId_YN", SqlDbType.VarChar).Value = VoterId_YN.ToString();
                    sqlcmd2.Parameters.Add("@VoterId_File", SqlDbType.VarChar).Value = VId_Name.ToString();
                    sqlcmd2.Parameters.Add("@PAN_YN", SqlDbType.VarChar).Value = PAN_YN.ToString();
                    sqlcmd2.Parameters.Add("@PAN_File", SqlDbType.VarChar).Value = PAN_N.ToString();
                    //sqlcmd2.Parameters.Add("@EBill", SqlDbType.VarChar).Value = Electricity_Bill_Name.ToString();
                    //sqlcmd2.Parameters.Add("@TBill", SqlDbType.VarChar).Value = Telephone_Bill_Name.ToString();
                    //sqlcmd2.Parameters.Add("@BankAcc", SqlDbType.VarChar).Value = Bank_Acc_Name.ToString();
                    //sqlcmd2.Parameters.Add("@Passport", SqlDbType.VarChar).Value = Passport_Name.ToString();
                    //sqlcmd2.Parameters.Add("@RationCard", SqlDbType.VarChar).Value = Rationcard_Name.ToString();
                    //sqlcmd2.Parameters.Add("@IDPassport", SqlDbType.VarChar).Value = ID_Passport_Name.ToString();
                    //sqlcmd2.Parameters.Add("@DLicense", SqlDbType.VarChar).Value = Driving_lic_Name.ToString();
                    //sqlcmd2.Parameters.Add("@VoteId", SqlDbType.VarChar).Value = VoterId_Name.ToString();
                    //sqlcmd2.Parameters.Add("@PAN", SqlDbType.VarChar).Value = PAN_Name.ToString();
                    sqlcmd2.Parameters.Add("@Guarantor_Name", SqlDbType.VarChar).Value = tb_Guarantor_Name.Text.Trim();

                    sqlcmd2.Parameters.Add("@Thumb_Impression_YN", SqlDbType.VarChar).Value = Thumb_YN.ToString().Trim(); 
                    sqlcmd2.Parameters.Add("@Thumb_Impression_File", SqlDbType.VarChar).Value = Thumb_Name.ToString().Trim();

                    sqlcmd2.Parameters.Add("@Driver_Registration_Form_YN", SqlDbType.VarChar).Value = Driver_Registration_YN.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Driver_Registration_Form_File", SqlDbType.VarChar).Value = Driver_Registration_Name.ToString().Trim();
                    sqlcmd2.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    sqlcmd2.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    sqlcmd2.Parameters.Add("@UpdatedDt", SqlDbType.VarChar).Value = DTM.ConvertToDate(hfTodayDate.Value.ToString());
                    
                    sqlcmd2.ExecuteNonQuery();
                }
                else
                {
                    sql = "usp_Driver_InsertUpdate";
                    SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
                    sqlcmd2.CommandType = CommandType.StoredProcedure;
                    sqlcmd2.Parameters.Add("@DriverId", SqlDbType.VarChar).Value = DriverId.ToString();
                    sqlcmd2.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
                    sqlcmd2.Parameters.Add("@DriverName", SqlDbType.VarChar).Value = txtDriverName.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@ManualDCode", SqlDbType.VarChar).Value = txtMDCode.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@FatherName", SqlDbType.VarChar).Value = txtFather.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehicleNo.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@LicNo", SqlDbType.VarChar).Value = txtLicNo.Text.ToString();
                    sqlcmd2.Parameters.Add("@ValidityDt", SqlDbType.DateTime).Value = Convert.ToDateTime(txtValDt.Text.ToString().Trim(), dtfi);
                    sqlcmd2.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboStatus.SelectedItem.Value.ToString();
                    sqlcmd2.Parameters.Add("@RTO", SqlDbType.VarChar).Value = txtRTO.Text.ToString();
                    sqlcmd2.Parameters.Add("@Location", SqlDbType.VarChar).Value = ddlLocation.SelectedItem.Value.ToString().Trim();
                    sqlcmd2.Parameters.Add("@ContactNo", SqlDbType.VarChar).Value = txtContact.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@PAddress", SqlDbType.VarChar).Value = txtPAddress.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@PCity", SqlDbType.VarChar).Value = txtCity.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@PPin", SqlDbType.VarChar).Value = txtPin.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@CAddress", SqlDbType.VarChar).Value = txtCAddress.Text.ToString();
                    sqlcmd2.Parameters.Add("@CCity", SqlDbType.VarChar).Value = txtCity1.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@CPin", SqlDbType.VarChar).Value = txtPin1.Text.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Categoty", SqlDbType.VarChar).Value = DdlCategory.SelectedItem.Value.ToString().Trim();
                    sqlcmd2.Parameters.Add("@DOb", SqlDbType.VarChar).Value = txtDOB.Text.ToString().Trim(); 
                    sqlcmd2.Parameters.Add("@Ecity", SqlDbType.VarChar).Value = DdlCity.SelectedItem.Value.ToString().Trim();
                    sqlcmd2.Parameters.Add("@Lic_Dt", SqlDbType.VarChar).Value = txtInitialDate.Text.ToString().Trim(); 
                    sqlcmd2.Parameters.Add("@Lic_Current_Dt", SqlDbType.VarChar).Value = txtCurrentDate.Text.ToString().Trim();
                    if (chkLicVerified.Checked == true)
                    {
                        sqlcmd2.Parameters.Add("@License_Verified", SqlDbType.VarChar).Value = "Y";
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@License_Verified", SqlDbType.VarChar).Value = "N";
                    }
                    if (chkAddVerified.Checked == true)
                    {
                        sqlcmd2.Parameters.Add("@Address_Verified", SqlDbType.VarChar).Value = "Y";

                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Address_Verified", SqlDbType.VarChar).Value = "N";
                    }

                    sqlcmd2.Parameters.Add("@License_Verified_Dt", SqlDbType.VarChar).Value = txtLicVerifiedDate.Text.ToString().Trim();
                    //sqlcmd2.Parameters.Add("@Photo", SqlDbType.VarChar).Value = Photo_Name.ToString();
                    if (Photo_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Photo", SqlDbType.VarChar).Value = Photo_Name.ToString();
                        if (LblDriverPhoto.Text != "")
                        {
                            File.Delete(path + LblDriverPhoto.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Photo", SqlDbType.VarChar).Value = LblDriverPhoto.Text.ToString();
                    }

                    sqlcmd2.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    sqlcmd2.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                    sqlcmd2.Parameters.Add("@UpdatedDt", SqlDbType.VarChar).Value = DTM.ConvertToDate(hfTodayDate.Value.ToString());

                    sqlcmd2.Parameters.Add("@Electricity_Bill_YN", SqlDbType.VarChar).Value = Electricity_Bill_YN.ToString().Trim();
                    if (E_Bill_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Electricity_Bill_File", SqlDbType.VarChar).Value = E_Bill_Name.ToString().Trim();
                        if (LblEBill.Text != "")
                        {
                            File.Delete(path + LblEBill.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Electricity_Bill_File", SqlDbType.VarChar).Value = LblEBill.Text.ToString().Trim();
                        if (Electricity_Bill_YN == "N")
                        {
                            if (LblEBill.Text != "")
                            {
                                File.Delete(path + LblEBill.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@Telephone_Bill_YN", SqlDbType.VarChar).Value = Telephone_Bill_YN.ToString().Trim();
                    if (T_Bill_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Telephone_Bill_File", SqlDbType.VarChar).Value = T_Bill_Name.ToString().Trim();
                        if (LblTelBill.Text != "")
                        {
                            File.Delete(path + LblTelBill.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Telephone_Bill_File", SqlDbType.VarChar).Value = LblTelBill.Text.ToString().Trim();
                        if (Telephone_Bill_YN == "N")
                        {
                            if (LblTelBill.Text != "")
                            {
                                File.Delete(path + LblTelBill.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@BankAcc_YN", SqlDbType.VarChar).Value = Bank_Acc_YN.ToString();
                    if (B_Acc_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@BankAcc_File", SqlDbType.VarChar).Value = B_Acc_Name.ToString();
                        if (LblBAStat.Text != "")
                        {
                            File.Delete(path + LblBAStat.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@BankAcc_File", SqlDbType.VarChar).Value = LblBAStat.Text.ToString();
                        if (Bank_Acc_YN == "N")
                        {
                            if (LblBAStat.Text != "")
                            {
                                File.Delete(path + LblBAStat.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@Passport_YN", SqlDbType.VarChar).Value = Passport_YN.ToString().Trim();
                    if (Pass_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Passport_File", SqlDbType.VarChar).Value = Pass_Name.ToString().Trim();
                        if (LblPassport.Text != "")
                        {
                            File.Delete(path + LblPassport.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Passport_File", SqlDbType.VarChar).Value = LblPassport.Text.ToString().Trim();
                        if (Passport_YN == "N")
                        {
                            if (LblPassport.Text != "")
                            {
                                File.Delete(path + LblPassport.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@Rationcard_YN", SqlDbType.VarChar).Value = Rationcard_YN.ToString();
                    if (Rcard_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Rationcard_File", SqlDbType.VarChar).Value = Rcard_Name.ToString();
                        if (LblRationCard.Text != "")
                        {
                            File.Delete(path + LblRationCard.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Rationcard_File", SqlDbType.VarChar).Value = LblRationCard.Text.ToString();
                        if (Rationcard_YN == "N")
                        {
                            if (LblRationCard.Text != "")
                            {
                                File.Delete(path + LblRationCard.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@ID_Passport_YN", SqlDbType.VarChar).Value = ID_Passport_YN.ToString();
                    if (ID_Pass_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@ID_Passport_File", SqlDbType.VarChar).Value = ID_Pass_Name.ToString();
                        if (LblPass.Text != "")
                        {
                            File.Delete(path + LblPass.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@ID_Passport_File", SqlDbType.VarChar).Value = LblPass.Text.ToString();
                        if (ID_Passport_YN == "N")
                        {
                            if (LblPass.Text != "")
                            {
                                File.Delete(path + LblPass.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@Driving_lic_YN", SqlDbType.VarChar).Value = Driving_lic_YN.ToString();
                    if (D_lic_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Driving_lic_File", SqlDbType.VarChar).Value = D_lic_Name.ToString();
                        if (LblDLiscense.Text != "")
                        {
                            File.Delete(path + LblDLiscense.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Driving_lic_File", SqlDbType.VarChar).Value = LblDLiscense.Text.ToString();
                        if (Driving_lic_YN == "N")
                        {
                            if (LblDLiscense.Text != "")
                            {
                                File.Delete(path + LblDLiscense.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@VoterId_YN", SqlDbType.VarChar).Value = VoterId_YN.ToString();
                    if (VId_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@VoterId_File", SqlDbType.VarChar).Value = VId_Name.ToString();
                        if (LblVotersID.Text != "")
                        {
                            File.Delete(path + LblVotersID.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@VoterId_File", SqlDbType.VarChar).Value = LblVotersID.Text.ToString();
                        if (VoterId_YN == "N")
                        {
                            if (LblVotersID.Text != "")
                            {
                                File.Delete(path + LblVotersID.Text);
                            }
                        }
                    }
                    sqlcmd2.Parameters.Add("@PAN_YN", SqlDbType.VarChar).Value = PAN_YN.ToString();

                    if (PAN_N != "")
                    {
                        sqlcmd2.Parameters.Add("@PAN_File", SqlDbType.VarChar).Value = PAN_N.ToString();
                        if (LblPCard.Text != "")
                        {
                            File.Delete(path + LblPCard.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@PAN_File", SqlDbType.VarChar).Value = LblPCard.Text.ToString();
                        if (PAN_YN == "N")
                        {
                            if (LblPCard.Text != "")
                            {
                                File.Delete(path + LblPCard.Text);
                            }
                        }
                    }

                    sqlcmd2.Parameters.Add("@Guarantor_Name", SqlDbType.VarChar).Value = tb_Guarantor_Name.Text.Trim();

                    sqlcmd2.Parameters.Add("@Thumb_Impression_YN", SqlDbType.VarChar).Value = Thumb_YN.ToString().Trim();
                    if (Thumb_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Thumb_Impression_File", SqlDbType.VarChar).Value = Thumb_Name.ToString().Trim();
                        if (lblThumb.Text != "")
                        {
                            File.Delete(path + lblThumb.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Thumb_Impression_File", SqlDbType.VarChar).Value = Thumb_Name.ToString().Trim();
                        if (Thumb_YN == "N")
                        {
                            if (lblThumb.Text != "")
                            {
                                File.Delete(path + lblThumb.Text);
                            }
                        }
                    }

                    //sqlcmd2.Parameters.Add("@Thumb_Impression_File", SqlDbType.VarChar).Value = Thumb_Name.ToString().Trim();

                    sqlcmd2.Parameters.Add("@Driver_Registration_Form_YN", SqlDbType.VarChar).Value = Driver_Registration_YN.ToString().Trim();
                    if (Driver_Registration_Name != "")
                    {
                        sqlcmd2.Parameters.Add("@Driver_Registration_Form_File", SqlDbType.VarChar).Value = LblRegistrationForm.Text.Trim();//Driver_Registration_Name.ToString().Trim();
                        if (LblRegistrationForm.Text != "")
                        {
                            File.Delete(path + LblRegistrationForm.Text);
                        }
                    }
                    else
                    {
                        sqlcmd2.Parameters.Add("@Driver_Registration_Form_File", SqlDbType.VarChar).Value = Driver_Registration_Name.ToString().Trim();
                        if (Thumb_YN == "N")
                        {
                            if (LblRegistrationForm.Text != "")
                            {
                                File.Delete(path + LblRegistrationForm.Text);
                            }
                        }
                    }

                    //sqlcmd2.Parameters.Add("@Driver_Registration_Form_File", SqlDbType.VarChar).Value = Driver_Registration_Name.ToString().Trim();  

                    sqlcmd2.ExecuteNonQuery();
                }
            }
            else
            {
                lblErrMsg.Visible = true;
                lblErrMsg.Text = "Sorry,Driver already Exists !!!";
                //Response.End();
            }
        }    
        //Close the connection
        conn.Close();
    }
    protected void OnSubmit(object sender, EventArgs e)
    {
        lblErrMsg.Text = "";
        AddEditDriver();
        string driver = txtDriverName.Text;
        if (DataFoundFlag.ToString().Trim() == "N" && lblErrMsg.Text=="")
        {
            //~/GUI/Fleet/Webadmin/Driver/
            Response.Redirect("~/GUI/Fleet/Webadmin/Driver/DriverResult.aspx?driver=" + driver, true);
        }
    }
    protected void txtVehicleNo_TextChanged(object sender, EventArgs e)
    {
        if (txtVehicleNo.Text.ToString().Trim() != "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string STR = "select * from webx_VEHICLE_HDR where  VEHNO='" + txtVehicleNo.Text.ToString().Trim() + "'";
            string DataFound = "N";
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
            if (DataFound == "N")
            {
                lblCheck.Visible = true;
                lblCheck.Text = "Invalid Vehicle Number!";
            }
            else
            {
                lblCheck.Text = "";
            }
        }
    }
    protected void txtMDCode_TextChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        lblCheckCode.Text = "";
        lblCheckCode.Visible = false;
        string STR = "select *  from WEBX_FLEET_DRIVERMST where Manual_Driver_Code='"+txtMDCode.Text.Trim()+"' ";
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
            lblCheckCode.Text="";
            lblCheckCode.Visible = false;
        }
    }
}
