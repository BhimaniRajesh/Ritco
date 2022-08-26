using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using AjaxControlToolkit;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Xml;
using System.Text;
using ApplicationManager;


public partial class GUI_Fleet_PeopleContract_PeopleTripsheet : System.Web.UI.Page
{
    ds_Tripsheet.Webx_Fleet_TS_Employee_MstDataTable dt_Emp_Det = new ds_Tripsheet.Webx_Fleet_TS_Employee_MstDataTable();

    public void BindGrid()
    {
        gv_Employee_Det.DataSource = dt_Emp_Det;
        gv_Employee_Det.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CreateXML();

        if (!IsPostBack)
        {
            //Button1.Attributes.Add("onclick", "javascript:checkValidation(" + Editor1.ClientID + ");");
            txtCustCode.Attributes.Add("Onblur", "javascript:CheckCustomerCode(this," + lbl_Cust_Err.ClientID.ToString() + ");");
            //tb_Manual_TS.Attributes.Add("OnBlur", "javascript:CheckValidManualTS(this," + lbl_Trip_Error.ClientID.ToString() + "," + SessionUtilities.DefaultCompanyCode.Trim() + "," + SessionUtilities.CurrentBranchCode.Trim() + "," + txtCustCode.Text.Trim() + ");");

            tb_Manual_TS.Attributes.Add("OnBlur", "javascript:CheckValidManualTS(this," + lbl_Trip_Error.ClientID.ToString() + ",'" + SessionUtilities.DefaultCompanyCode.Trim() + "');");
            //tb_Manual_TS.Attributes.Add("OnBlur", "javascript:CheckValidManualTS(this," + lbl_Trip_Error.ClientID.ToString() + ");");


            TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());
            objTripSheet.BindDropDown(ddl_Service_By, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('SERCAT') And StatusCode='Y'");
            objTripSheet.BindDropDown(ddl_Contract_Type, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('CNTYP') And StatusCode='Y'");
            objTripSheet.BindDropDown(ddl_Category, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('TSCAT') And StatusCode='Y'");
            objTripSheet.BindDropDown(ddl_Duration, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('TSDUR') And StatusCode='Y'");
            objTripSheet.BindDropDown(ddl_Pickup_Drop, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('PKDRP') And StatusCode='Y'");
            ddl_Vehicle_No.Attributes.Add("OnChange", "javascript:GetVehicleDetails(this);");
            ddl_Driver.Attributes.Add("OnChange", "javascript:GetDriverDetails(this);");

            tb_TS_Date.Text = System.DateTime.Now.Date.ToString("dd/MM/yyyy");

            tb_Start_Date.Text = System.DateTime.Now.Date.ToString("dd/MM/yyyy");
            tb_Start_Time.Text = System.DateTime.Now.Date.ToString("HH:MM");

            tb_End_Date.Text = System.DateTime.Now.Date.ToString("dd/MM/yyyy");
            tb_End_Time.Text = System.DateTime.Now.Date.ToString("HH:MM");

            People_Contract objPeopleContract = new People_Contract(Session["SqlProvider"].ToString());
            objPeopleContract.BindDropDown(ddl_Route, "Select RUTCD,RUTCD + ':' +RUTDESC From [webx_trip_rutmas] Where ActiveFlag='Y'");
            objTripSheet.BindDropDown(ddl_Way, "Select CodeId,CodeDesc from webx_master_General where CodeType in ('VEHWAY') And StatusCode='Y'");
            objPeopleContract.BindDropDown(ddl_Vehicle_Category, "Select CodeId,CodeDesc from Webx_Master_General Where CodeType='FLTCAT' And StatusCode='Y'");

            ddl_Route.Attributes.Add("OnChange", "javascript:OnChangeRoute('9999999',this);");
            ddl_Contract_Type.Attributes.Add("OnChange", "javascript:OnChangeContract(this);");
            ddl_Way.Attributes.Add("OnChange", "javascript:OnChangeWay(this);");

            tb_Vendor_Name.Attributes.Add("readonly", "readonly"); 
            tb_Vehicle_Type.Attributes.Add("readonly", "readonly"); 
            tb_Licno.Attributes.Add("readonly", "readonly"); 
            tb_Validity_Date.Attributes.Add("readonly", "readonly"); 
            tb_Standard_KM_Rec.Attributes.Add("readonly", "readonly"); 
            tb_Current_KM_Read.Attributes.Add("readonly", "readonly");
            txtCustName.Attributes.Add("readonly", "readonly");
            tb_Total_Hours.Attributes.Add("readonly", "readonly");
            tb_Total_KM.Attributes.Add("readonly", "readonly");
            tb_Total_Amt.Attributes.Add("readonly", "readonly");
        }
    }

    public void CreateXML()
    {
        TripSheet objTS = new TripSheet(SessionUtilities.ConnectionString);
        DataTable dtVehMode = new DataTable();
        DataTable dtVehicle = new DataTable();
        DataTable dtDriver = new DataTable();

        dtVehMode = objTS.ExecuteSql("select  CodeId,CodeDesc from webx_master_General where StatusCode='Y' And  codetype = 'VENDTY' And CODEID IN ('01','05')");
        dtVehicle = objTS.ExecuteSql("select VEHNO,VEHNO,VENDORTYPE from webx_VEHICLE_HDR  where ACTIVEFLAG='Y'");
        dtDriver = objTS.ExecuteSql("select Driver_Id,Driver_Name,VEHNO  from Webx_Fleet_Drivermst where ActiveFlag='Y'");

        string strXML = "<?xml version='1.0' encoding='utf-8' ?><DropDownWebService>";

        if (dtVehMode.Rows.Count > 0)
        {
            for (int i = 0; i < dtVehMode.Rows.Count; i++)
            {
                strXML += "<vehmode name='" + dtVehMode.Rows[i][1].ToString() + "' value='" + dtVehMode.Rows[i][0].ToString() + "'>";
                for (int j = 0; j < dtVehicle.Rows.Count; j++)
                {
                    if (dtVehMode.Rows[i][0].ToString() == dtVehicle.Rows[j][2].ToString())
                    {
                        strXML += "<vehicle name='" + dtVehicle.Rows[j][0].ToString() + "' value='" + dtVehicle.Rows[j][1].ToString() + "'>";
                        for (int k = 0; k < dtDriver.Rows.Count; k++)
                        {
                            if (dtVehicle.Rows[j][1].ToString() == dtDriver.Rows[k][2].ToString())
                            {
                                strXML += "<driver name='" + dtDriver.Rows[k][1].ToString() + "' value='" + dtDriver.Rows[k][0].ToString() + "' />";
                            }
                        }
                        strXML += "</vehicle>";
                    }
                }
                strXML += "</vehmode>";
            }
        }
        strXML += "</DropDownWebService>";
        string path = Server.MapPath(@"~/App_Data/DropDownWebService.xml");
        // Delete the file if it exists.
        if (File.Exists(path)) { File.Delete(path); }
        // Create the file.
        using (FileStream fs = File.Create(path, 1024))
        {
            Byte[] info = new UTF8Encoding(true).GetBytes(strXML);
            // Add some information to the file.
            fs.Write(info, 0, info.Length);
        }
    }

    [WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static CascadingDropDownNameValue[] GetDropDownContentsPageMethod(string knownCategoryValues, string category)
    {
        return new DropDownWebService().GetDropDownContents(knownCategoryValues, category);
    }

    protected void tb_Row_No_TextChanged(object sender, EventArgs e)
    {
        dt_Emp_Det.Clear();

        if ((tb_Row_No.Text == "") || (tb_Row_No.Text == "0")) tb_Row_No.Text = "1";

        foreach (GridViewRow gvr in gv_Employee_Det.Rows)
        {
            TextBox tb_Emp_Code = (TextBox)gvr.FindControl("tb_Emp_Code");
            TextBox tb_Emp_Name = (TextBox)gvr.FindControl("tb_Emp_Name");
            TextBox tb_Department = (TextBox)gvr.FindControl("tb_Department");
            TextBox tb_From_Area = (TextBox)gvr.FindControl("tb_From_Area");
            TextBox tb_To_Area = (TextBox)gvr.FindControl("tb_To_Area");

            dt_Emp_Det.AddWebx_Fleet_TS_Employee_MstRow(tb_Emp_Code.Text, tb_Emp_Name.Text, tb_Department.Text, tb_From_Area.Text, tb_To_Area.Text);
        }

        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_Emp_Det.AddWebx_Fleet_TS_Employee_MstRow("", "", "", "", "");
        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void gv_Employee_Details_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        dt_Emp_Det.Clear();

        foreach (GridViewRow gvr in gv_Employee_Det.Rows)
        {
            TextBox tb_Emp_Code = (TextBox)gvr.FindControl("tb_Emp_Code");
            TextBox tb_Emp_Name = (TextBox)gvr.FindControl("tb_Emp_Name");
            TextBox tb_Department = (TextBox)gvr.FindControl("tb_Department");
            TextBox tb_From_Area = (TextBox)gvr.FindControl("tb_From_Area");
            TextBox tb_To_Area = (TextBox)gvr.FindControl("tb_To_Area");

            dt_Emp_Det.AddWebx_Fleet_TS_Employee_MstRow(tb_Emp_Code.Text, tb_Emp_Name.Text, tb_Department.Text, tb_From_Area.Text, tb_To_Area.Text);
            //if (gvr.RowIndex == e.RowIndex)
            //{
            //    if (((HiddenField)gvr.FindControl("hf_Id")).Value != "")
            //    {
            //        Secondary_Contract objSecContract = new Secondary_Contract(Convert.ToString(Session["SqlProvider"]));
            //        objSecContract.ExecureQry("Delete From [Webx_Fleet_Hourly_Based_Slot] Where Id = " + ((HiddenField)gvr.FindControl("hf_Id")).Value);
            //    }
            //}
        }

        dt_Emp_Det.Rows[e.RowIndex].Delete();
        for (int i = 0; i < Convert.ToInt32(tb_Row_No.Text); i++) dt_Emp_Det.AddWebx_Fleet_TS_Employee_MstRow("", "", "", "", "");
        tb_Row_No.Text = "0";

        BindGrid();
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        TripSheet objTripSheet = new TripSheet(Session["SqlProvider"].ToString());
        bool IsCommitted = false;

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();

        string strTSdate = tb_TS_Date.Text + " " + tm_TS.Hour + ":" + tm_TS.Minute + " " + tm_TS.AmPm;
        string strStartdate = tb_Start_Date.Text + " " + tb_Start_Time.Text;
        string strEnddate = tb_End_Date.Text + " " + tb_End_Time.Text;

        decimal from_City, to_City;
        string strTSno = "";

        //from_City = objTripSheet.GetCityCode(tb_From_City.Text.Trim());
        //to_City = objTripSheet.GetCityCode(tb_To_City.Text.Trim());
        from_City = 0;
        to_City = 0;

        strTSno = objTripSheet.GetDocumentNo();

        objTripSheet.BeginTransaction();

        objTripSheet.tripsheet_No = strTSno.ToString();

        objTripSheet.Manual_TripSheetNo = tb_Manual_TS.Text.Trim();
        objTripSheet.tripsheet_Date = DTM.ConvertToDate(strTSdate.ToString().Trim());
        objTripSheet.customer_Code = txtCustCode.Text.Trim();
        objTripSheet.service_By_Id = ddl_Service_By.SelectedValue;
        objTripSheet.contract_Type_Id = ddl_Contract_Type.SelectedValue;
        objTripSheet.category_Id = ddl_Category.SelectedValue;
        objTripSheet.pickDrop_Id = ddl_Pickup_Drop.SelectedValue;

        objTripSheet.from_City_Code = from_City;
        objTripSheet.to_City_Code = to_City;

        objTripSheet.duration_Id = ddl_Duration.SelectedValue;

        objTripSheet.vehicle_Mode_Id = ddl_Vehicle_Mode.SelectedValue;
        objTripSheet.vehicle_No = ddl_Vehicle_No.SelectedValue;
        objTripSheet.Driver_Id = ddl_Driver.SelectedValue;
        objTripSheet.outstation = rblst_Out_Station.SelectedValue;
        objTripSheet.working_days = rblst_Working_Days.SelectedValue;

        objTripSheet.start_Date_Time = DTM.ConvertToDate(strStartdate.ToString().Trim());
        //objTripSheet.end_Date_Time = Convert.ToDateTime(strEnddate.ToString().Trim(), dtfi);

        objTripSheet.end_Date_Time = DTM.ConvertToDate(strEnddate.ToString().Trim());
        objTripSheet.start_KM_Read = Convert.ToDecimal(tb_Start_KM_Read.Text.Trim());
        objTripSheet.end_KM_Read = Convert.ToDecimal(tb_End_KM_Read.Text.Trim());
        objTripSheet.remarks = tb_Remarks.Text;
        objTripSheet.service_Level_Parameters = tb_Service_level.Text.Trim();
        objTripSheet.Company_Code = SessionUtilities.DefaultCompanyCode.Trim();
        objTripSheet.Manual_TripSheetNo = tb_Manual_TS.Text.Trim();
        objTripSheet.entry_By = SessionUtilities.CurrentEmployeeID.ToUpper().Trim();

        objTripSheet.sRUTCD = ddl_Route.SelectedValue;
        objTripSheet.sVeh_Category_Id = ddl_Vehicle_Category.SelectedValue;
        objTripSheet.sOneTwo_Way = ddl_Way.SelectedValue;
        objTripSheet.dStd_Reckoner_KM = tb_Standard_KM_Rec.Text != "" ? Convert.ToDecimal(tb_Standard_KM_Rec.Text) : 0;
        objTripSheet.dVeh_KM_Reading = tb_Standard_KM_Rec.Text != "" ? Convert.ToDecimal(tb_Standard_KM_Rec.Text) : 0;
        objTripSheet.sTotal_Hours = tb_Total_Hours.Text;
        objTripSheet.sStd_Hours = tb_Std_Hrs.Text;
        objTripSheet.dAmount = tb_Logsheet_Amt.Text != "" ? Convert.ToDecimal(tb_Logsheet_Amt.Text) : 0;
        objTripSheet.dToll_Charges = tb_Toll_Charge.Text != "" ? Convert.ToDecimal(tb_Toll_Charge.Text) : 0;
        objTripSheet.dParking_Charges = tb_Parking_Charges.Text != "" ? Convert.ToDecimal(tb_Parking_Charges.Text) : 0;

        try
        {
            objTripSheet.InsertWebxFleetTripsheet();

            foreach (GridViewRow gvr in gv_Employee_Det.Rows)
            {
                TextBox tb_Emp_Code = (TextBox)gvr.FindControl("tb_Emp_Code");
                TextBox tb_Emp_Name = (TextBox)gvr.FindControl("tb_Emp_Name");
                TextBox tb_Department = (TextBox)gvr.FindControl("tb_Department");
                TextBox tb_From_Area = (TextBox)gvr.FindControl("tb_From_Area");
                TextBox tb_To_Area = (TextBox)gvr.FindControl("tb_To_Area");

                objTripSheet.Emp_Code = tb_Emp_Code.Text.Trim();
                objTripSheet.Emp_Name = tb_Emp_Name.Text.Trim();
                objTripSheet.Department = tb_Department.Text.Trim();
                objTripSheet.From_Area = tb_From_Area.Text.Trim();
                objTripSheet.To_Area = tb_To_Area.Text.Trim();
                objTripSheet.tripsheet_No = strTSno.ToString();

                objTripSheet.InsertWebxFleetTSEmployeeMst();
            }
            IsCommitted = objTripSheet.CommitTransaction();
        }
        catch (Exception e1)
        {
            objTripSheet.RollBackTransaction();
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + e1.Message.Replace('\n', '_'));
        }

        if (IsCommitted)
        {
            Response.Redirect("TripsheetResult.aspx?VSlipId=" + strTSno.ToString() + "&TripSheetType=D", true);
        }
    }
}
