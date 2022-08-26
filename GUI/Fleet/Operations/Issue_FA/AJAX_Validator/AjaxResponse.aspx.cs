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
using WebX.Controllers;

public partial class AjaxResponse : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "FillStandardAmt") { Response.Write(FillStandardAmt()); }
        if (Request.QueryString["Function"] == "CheckValidManualTS") { Response.Write(CheckValidManualTS()); }

        // TRY
        if (Request.QueryString["Function"] == "CheckValidSlipNo") { Response.Write(CheckValidSlipNo()); }
        // TRY

        if (Request.QueryString["Function"] == "GetDriverDetails") { Response.Write(GetDriverDetails()); }
        if (Request.QueryString["Function"] == "FillPolarity") { Response.Write(FillPolarity()); }
        if (Request.QueryString["Function"] == "CheckTripRule") { Response.Write(CheckTripRule()); }
        if (Request.QueryString["Function"] == "CheckDriver1ManualCode") { Response.Write(CheckDriver1ManualCode()); }
        if (Request.QueryString["Function"] == "CheckValidCity") { Response.Write(CheckValidCity()); }
        if (Request.QueryString["Function"] == "CheckValidCityCode") { Response.Write(CheckValidCityCode()); }
        if (Request.QueryString["Function"] == "CheckValidBranchCode") { Response.Write(CheckValidBranchCode()); }
        if (Request.QueryString["Function"] == "OnChangeRoute") { Response.Write(OnChangeRoute()); }
        if (Request.QueryString["Function"] == "CheckVehicleNumber") { Response.Write(CheckVehicleNumber()); }
        if (Request.QueryString["Function"] == "CheckCustomerCode") { Response.Write(CheckCustomerCode()); }
        if (Request.QueryString["Function"] == "CheckVehicleNumber1") { Response.Write(CheckVehicleNumber1()); }
        if (Request.QueryString["Function"] == "FillDriverBalance") { Response.Write(FillDriverBalance()); }
        if (Request.QueryString["Function"] == "GetAdvTripDate") { Response.Write(GetAdvTripDate()); }
        if (Request.QueryString["Function"] == "CheckTransitTime") { Response.Write(CheckTransitTime()); }
        if (Request.QueryString["Function"] == "CheckIdleTime") { Response.Write(CheckIdleTime()); }
        if (Request.QueryString["Function"] == "CheckValidCheckList") { Response.Write(CheckValidCheckList()); }
        if (Request.QueryString["Function"] == "GetTripSheetCancelDetails") { Response.Write(GetTripSheetCancelDetails()); }
        if (Request.QueryString["Function"] == "GetCancelDate") { Response.Write(GetCancelDate()); }
        if (Request.QueryString["Function"] == "CheckTripsheetNo") { Response.Write(CheckTripsheetNo()); }
        if (Request.QueryString["Function"] == "CheckTrip") { Response.Write(CheckTrip()); }
        if (Request.QueryString["Function"] == "GetVehicleNo") { Response.Write(GetVehicleNo()); }
        if (Request.QueryString["Function"] == "GetNewVehicleNo") { Response.Write(GetNewVehicleNo()); }
        if (Request.QueryString["Function"] == "GetNewControllingBranch") { Response.Write(GetNewControllingBranch()); }
        if (Request.QueryString["Function"] == "GetTransferDate") { Response.Write(GetTransferDate()); }
        if (Request.QueryString["Function"] == "GetCnoteDetails") { Response.Write(GetCnoteDetails()); }
        if (Request.QueryString["Function"] == "FillVehicleDetails") { Response.Write(FillVehicleDetails()); }
        if (Request.QueryString["Function"] == "FillVehicleDetailsMaster") { Response.Write(FillVehicleDetailsMaster()); }

        //******************
        if (Request.QueryString["Function"] == "FillTripsheetVehicleDetails") { Response.Write(FillTripsheetVehicleDetails()); }
        //******************

        if (Request.QueryString["Function"] == "GetNewDriverDetails") { Response.Write(GetNewDriverDetails()); }
        if (Request.QueryString["Function"] == "GetDriverDetailsVehicleWise") { Response.Write(GetDriverDetailsVehicleWise()); }
        if (Request.QueryString["Function"] == "GetNewDriverDetailsMaster") { Response.Clear(); Response.Write(GetNewDriverDetailsMaster()); Response.End(); }
        if (Request.QueryString["Function"] == "GetDriverDetailsVehicleWiseMaster") { Response.Write(GetDriverDetailsVehicleWiseMaster()); }
        if (Request.QueryString["Function"] == "CheckFuelSlipNo") { Response.Write(CheckFuelSlipNo()); }
        if (Request.QueryString["Function"] == "CheckValidCityCodeFUEL") { Response.Write(CheckValidCityCodeFUEL()); }
        if (Request.QueryString["Function"] == "GetAdvanceAmtCheck") { Response.Write(GetAdvanceAmtCheck()); }

        if (Request.QueryString["Function"] == "CheckValidFuelSlipNo") { Response.Write(CheckValidFuelSlipNo()); }
        if (Request.QueryString["Function"] == "FillDriverBalanceVer1") { Response.Write(FillDriverBalanceVer1()); }



    }
    private string GetAdvanceAmtCheck()
    {
        MyFunctions fn = new MyFunctions();
        string Cnt = "";
        string mAdvAmt = Request.QueryString["AdvAmt"].ToString();
        string mAdvance_Date = Request.QueryString["AdvDate"].ToString();
        Cnt = VendorPayment_Utility.DR_VR_Trn_Halt(Convert.ToDouble(mAdvAmt.ToString()), fn.Mydate1(mAdvance_Date.ToString()));
        return Cnt + "~";
    }
    private string CheckValidCheckList()
    {
        cls_CheckList_Mst objCheckList = new cls_CheckList_Mst(str_Connection_String);

        objCheckList.Chk_ID = Request.QueryString["Chk_ID"].ToString();
        objCheckList.Chk_Cat = Request.QueryString["Chk_Cat"].ToString();
        objCheckList.Chk_Desc = Request.QueryString["Chk_Desc"].ToString();

        if (Request.QueryString["Chk_ID"].ToString() != "")
        {
            objCheckList.Chk_ID = Request.QueryString["Chk_ID"].ToString();
            objCheckList.CheckValidCheckList();
        }
        else
        {
            objCheckList.Chk_ID = strNullVal;
            objCheckList.CheckValidCheckList();
        }
        if (objCheckList.IsRecordFound == true)
        {
            return "Y~" + objCheckList.Chk_ID + "~" + objCheckList.Chk_Cat + "~" + objCheckList.Chk_Desc + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckTransitTime()
    {
        cls_VehicleLogEntry objVehLog = new cls_VehicleLogEntry(str_Connection_String);

        objVehLog.StartDateTime = Request.QueryString["StartDateTime"].ToString();
        objVehLog.EndDateTime = Request.QueryString["EndDateTime"].ToString();

        objVehLog.CheckTransitTime();

        if (objVehLog.IsRecordFound == true) { return "Y~" + objVehLog.Hours + "~" + objVehLog.Minute + "~"; } else { return "N~"; }
    }
    private string CheckIdleTime()
    {
        cls_VehicleLogEntry objVehLog = new cls_VehicleLogEntry(str_Connection_String);

        objVehLog.StartDateTime = Request.QueryString["EndDateTime"].ToString();
        objVehLog.EndDateTime = Request.QueryString["StartDateTime"].ToString();

        objVehLog.CheckIdleTime();

        if (objVehLog.IsRecordFound == true) { return "Y~" + objVehLog.Hours + "~" + objVehLog.Minute + "~"; } else { return "N~"; }
    }
    private string GetAdvTripDate()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Manual_TripSheetNo = Request.QueryString["TripsheetNo"].ToString();
        objTs.GetAdvTripDate();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Valdity_dt + "~"; } else { return "N~"; }
    }
    private string FillDriverBalance()
    {
        DriverBalance DBalance = new DriverBalance();
        DateFunction DtFun = new DateFunction();
        string mToDt = DtFun.return_date(Request.QueryString["txtDate"].ToString());
        string mDBVal = "";
        mDBVal = DBalance.GetDriverBalanceAmt(Request.QueryString["Driver1"].ToString(), mToDt);
        return "Y~" + mDBVal + "~";
    }

    private string FillDriverBalanceVer1()
    {
        string mDBVal = "";
        var obj = new TripApprovalController();
        mDBVal = obj.GetDriverBalance(Request.QueryString["Driver1"].ToString());
        return "Y~" + mDBVal + "~";
    }
    private string CheckCustomerCode()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Customer_Code = Request.QueryString["CustCode"].ToString();
        objTs.CheckCustomerCode();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string CheckVehicleNumber()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Vehicle_No = Request.QueryString["VehicleNo"].ToString();
        objTs.CheckVehicleNumber();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Current_Km_Read + "~"; } else { return "N~"; }
    }
    private string CheckVehicleNumber1()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Vehicle_No = Request.QueryString["VehicleNo"].ToString();
        objTs.CheckVehicleNumber1();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }

    private string OnChangeRoute()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        if (Request.QueryString["RutCd"] != null)
        {
            objTs.OnChangeRoute(Request.QueryString["RutCd"].ToString());
        }
        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Tot_Hour + "~" + objTs.Tot_Min + "~"; } else { return "N~"; }
    }
    private string CheckValidBranchCode()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        if (Request.QueryString["BranchCode"] != null)
        {
            objTs.CheckValidBranchCode(Request.QueryString["BranchCode"].ToString());
        }
        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string CheckTripRule()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.CheckTripRule();
        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Vehicle_Selection + "~" + objTs.Driver1_Manual + "~" + objTs.Driver2_Manual + "~" + objTs.Trip_Route_Selection + "~" + objTs.THC_Attached + "~" + objTs.Vehicle_Filter + "~" + objTs.UFL_Filter + "~" + objTs.Auto_Vslip_Filter + "~" + objTs.ExternalUsage_Category + "~" + objTs.VEHICLE_MODE + "~"; } else { return "N~"; }
    }

    private string CheckValidCity()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.City_Name = Request.QueryString["CityName"].ToString();
        objTs.CheckValidCity();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }

    private string CheckValidCityCode()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.City_Name = Request.QueryString["CityName"].ToString();
        objTs.CheckValidCityCode();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.city_code + "~"; } else { return "N~"; }
    }

    private string CheckValidCityCodeFUEL()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.City_Name = Request.QueryString["CityName"].ToString();
        objTs.FuelTypePD = Request.QueryString["ddlFuelTypePD"].ToString();
        objTs.FuelVendor = Request.QueryString["ddlFuelVendor"].ToString();
        objTs.CheckValidCityCodeFUEL();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.city_code + "~" + objTs.FuelTypePDRate + "~"; } else { return "N~"; }
    }

    private string FillStandardAmt()
    {
        cls_TripRouteExp objTRE = new cls_TripRouteExp(str_Connection_String);

        objTRE.ROUTE_CODE = Request.QueryString["RouteCode"].ToString();
        objTRE.FULEXP_CODE = Request.QueryString["ExpCode"].ToString();
        objTRE.VEHNO = Request.QueryString["Vehno"].ToString();
        objTRE.FillStandardAmt();

        if (objTRE.IsRecordFound == true) { return "Y~" + objTRE.STANDARD_RATE + "~"; } else { return "N~"; }
    }
    private string FillPolarity()
    {
        cls_TripRouteExp objTRE = new cls_TripRouteExp(str_Connection_String);

        objTRE.FULEXP_CODE = Request.QueryString["ExpCode"].ToString();
        objTRE.FillPolarity();

        if (objTRE.IsRecordFound == true) { return "Y~" + objTRE.Polarity + "~"; } else { return "N~"; }
    }
    private string CheckValidManualTS()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Manual_TripSheetNo = Request.QueryString["ManualTSNo"].ToString();
        objTs.CheckValidManualTS();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }

    // TRY MAYANK START
    private string CheckValidSlipNo()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Fuel_SlipNo = Request.QueryString["SlipNo"].ToString();
        objTs.CheckValidSlipNo();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    // TRY MAYANK END



    //Mayank
    private string CheckValidFuelSlipNo()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.FuelSlipNo = Request.QueryString["FuelSlipNo"].ToString();
        objTs.CheckValidFuelSlipNo();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }


    private string GetDriverDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.GetDriverDetails();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~" + objTs.DriverLicenseDays + "~" + objTs.DriverLicVerificationDays + "~"; } else { return "N~"; }
    }

    private string CheckDriver1ManualCode()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Manual_Driver_Code = Request.QueryString["DriverManualCode"].ToString();
        objTs.CheckDriver1ManualCode();

        //if (objTs.IsRecordFound == true) { return "Y~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Id + "~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Driver_Status + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~"; } else { return "N~"; }
        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Id + "~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Driver_Status + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~" + objTs.License_Verified + "~"; } else { return "N~"; }
    }
    private string GetTripSheetCancelDetails()
    {
        cls_TripSheetCancel TripSheetCancel = new cls_TripSheetCancel(str_Connection_String);

        TripSheetCancel.VSlipNo = Request.QueryString["VSlipNo"].ToString();
        TripSheetCancel.Manual_TripSheetNo = Request.QueryString["Manual_TripSheetNo"].ToString();
        TripSheetCancel.TripSheet_Row = Request.QueryString["TripSheet_Row"].ToString();
        if (TripSheetCancel.TripSheet_Row == "N")
        {
            TripSheetCancel.GetTripSheetNo();
            if (TripSheetCancel.IsRecordFound == true)
            {
                //return "Y~" + TripSheetCancel.VSlipNo + "~" + TripSheetCancel.Manual_TripSheetNo + "~" + TripSheetCancel.VSlipDt + "~" + TripSheetCancel.VEHNO + "~" + TripSheetCancel.Category + "~" + TripSheetCancel.THC_Attached_YN + "~" + TripSheetCancel.Status + "~" + TripSheetCancel.Cancel_Status + "~" + TripSheetCancel.TripsheetNo + "~" + TripSheetCancel.Cancel_Dt + "~" + TripSheetCancel.Cancel_Entry_dt + "~" + TripSheetCancel.Driver1 + "~";
                return "Y~" + TripSheetCancel.Manual_TripSheetNo + "~" + TripSheetCancel.VSlipNo + "~" + TripSheetCancel.VSlipDt + "~" + TripSheetCancel.VEHNO + "~" + TripSheetCancel.Category + "~" + TripSheetCancel.THC_Attached_YN + "~" + TripSheetCancel.Status + "~" + TripSheetCancel.Cancel_Status + "~" + TripSheetCancel.TripsheetNo + "~" + TripSheetCancel.Cancel_Dt + "~" + TripSheetCancel.Cancel_Entry_dt + "~" + TripSheetCancel.Driver1 + "~";
            }
            else
            {
                return "N~";
            }
        }
        else
        {
            TripSheetCancel.GetTripSheetNo();
            if (TripSheetCancel.IsRecordFound == true)
            {
                return "Y~" + TripSheetCancel.Manual_TripSheetNo + "~" + TripSheetCancel.VSlipNo + "~" + TripSheetCancel.VSlipDt + "~" + TripSheetCancel.VEHNO + "~" + TripSheetCancel.Category + "~" + TripSheetCancel.THC_Attached_YN + "~" + TripSheetCancel.Status + "~" + TripSheetCancel.Cancel_Status + "~" + TripSheetCancel.TripsheetNo + "~" + TripSheetCancel.Cancel_Dt + "~" + TripSheetCancel.Cancel_Entry_dt + "~" + TripSheetCancel.Driver1 + "~";
            }
            else
            {
                return "N~";
            }
        }
    }

    private string GetCancelDate()
    {
        cls_TripSheetCancel canceldate = new cls_TripSheetCancel(str_Connection_String);
        canceldate.VSlipNo = Request.QueryString["VSlipNo"].ToString();
        canceldate.Manual_TripSheetNo = Request.QueryString["Manual_TripSheetNo"].ToString();
        canceldate.TripSheet_Row = Request.QueryString["TripSheet_Row"].ToString();
        canceldate.Cancel_Dt = Request.QueryString["CancelDt"].ToString();

        canceldate.GetTripCancelDate();
        if (canceldate.IsRecordFound == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }

    private string CheckTripsheetNo()
    {
        cls_Fuel_TripEdit trip = new cls_Fuel_TripEdit(str_Connection_String);

        trip.TripsheetNo = Request.QueryString["TripsheetNo"].ToString();

        trip.GetTripsheetNo();

        if (trip.IsRecordFound == true) { return "Y~" + trip.TripsheetNo + "~" + trip.driversettledt + "~" + trip.Cancel_Status + "~"; } else { return "N~"; }
    }

    private string CheckTrip()
    {
        cls_Fuel_TripEdit trip = new cls_Fuel_TripEdit(str_Connection_String);

        trip.TripsheetNo = Request.QueryString["TripsheetNo"].ToString();

        trip.GetTrip();

        if (trip.IsRecordFound == true) { return "Y~" + trip.TripsheetNo + "~" + trip.driversettledt + "~" + trip.Cancel_Status + "~"; } else { return "N~"; }
    }


    private string GetVehicleNo()
    {
        cls_VehicleTransfer objTs = new cls_VehicleTransfer(str_Connection_String);

        objTs.VEHNO = Request.QueryString["VEHNO"].ToString();
        objTs.GetVehicleNo();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.VEHNO + "~" + objTs.VEH_INTERNAL_NO + "~" + objTs.Conrtl_branch + "~" + objTs.Current_KM_Read + "~" + objTs.Vehicle_Status + "~" + objTs.JS_Maintainance_Status + "~"; } else { return "N~"; }
    }
    private string GetNewVehicleNo()
    {
        cls_VehicleTransfer objTs = new cls_VehicleTransfer(str_Connection_String);

        objTs.VEHNO = Request.QueryString["NEW_VEHNO"].ToString();
        objTs.GetNewVehicleNo();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string GetNewControllingBranch()
    {
        cls_VehicleTransfer objTs = new cls_VehicleTransfer(str_Connection_String);

        objTs.LocCode = Request.QueryString["LocCode"].ToString();
        objTs.GetNewControllingBranch();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string GetTransferDate()
    {
        cls_VehicleTransfer objTs = new cls_VehicleTransfer(str_Connection_String);

        objTs.VEHNO = Request.QueryString["VEHNO"].ToString();
        objTs.VEHREGNO = Request.QueryString["TransferDate"].ToString();
        objTs.GetTransferDate();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }


    private string GetCnoteDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.DOCKNO = Request.QueryString["CnoteNo"].ToString();
        objTs.GetCnoteDetails();

        if (objTs.IsRecordFound == true)
        {
            return "Y~" + objTs.DOCKNO + "~" + objTs.DOCKDT + "~" + objTs.Org_Dest + "~" + objTs.PKGSNO + "~" + objTs.ACTUWT + "~" + objTs.CHRGWT + "~" + objTs.SubTotal + "~" + objTs.DKTTOT + "~";
        }
        else
        {
            return "N~";
        }
    }

    private string FillVehicleDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Vehicle_No = Request.QueryString["Vehno"].ToString();
        objTs.GetVehicleDetails_New_Ver1();

        if (objTs.IsRecordFound == true)
        {
            //return "Y~" + objTs.VEHNO + "~" + objTs.CONRTL_BRANCH + "~" + objTs.MODEL + "~" + objTs.CATEGORY + "~" + objTs.CAPACITY + "~" + objTs.Current_Km_Read + "~" + objTs.DIESEL_AMT_CF + "~" + objTs.DIESEL_QTY_CF + "~" + objTs.CONRTL_BRANCH + "~" + objTs.Vehicle_Status + "~" + objTs.Vendor_Name + "~";
            return "Y~" + objTs.VEHNO + "~" + objTs.CONRTL_BRANCH + "~" + objTs.MODEL + "~" + objTs.CATEGORY + "~" + objTs.CAPACITY + "~" + objTs.Current_Km_Read + "~" + objTs.DIESEL_AMT_CF + "~" + objTs.DIESEL_QTY_CF + "~" + objTs.CONRTL_BRANCH + "~" + objTs.Vehicle_Status + "~" + objTs.Vendor_Name + "~" + objTs.Insurance_Validity_Date + "~" + objTs.Fitness_Validity_Date + "~" + objTs.RoadTaxDt + "~" + objTs.NationalPermitDt + "~" + objTs.InsuranceValidityDateTripValidation + "~" + objTs.FitnessValidityDateTripValidation + "~" + objTs.NationalPermitDtTripValidation + "~" + objTs.RoadTaxDtTripValidation + "~" + objTs.FiveYearPermitDtTripValidation + "~" + objTs.DieselLtrsTripValidation + "~" + objTs.FiveYearPermitDt + "~";
        }
        else
        {
            return "N~";
        }
    }

    private string FillVehicleDetailsMaster()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Vehicle_No = Request.QueryString["Vehno"].ToString();
        objTs.GetVehicleDetails_New_Ver1();

        if (objTs.IsRecordFound == true)
        {
            //return "Y~" + objTs.VEHNO + "~" + objTs.CONRTL_BRANCH + "~" + objTs.MODEL + "~" + objTs.CATEGORY + "~" + objTs.CAPACITY + "~" + objTs.Current_Km_Read + "~" + objTs.DIESEL_AMT_CF + "~" + objTs.DIESEL_QTY_CF + "~" + objTs.CONRTL_BRANCH + "~" + objTs.Vehicle_Status + "~" + objTs.Vendor_Name + "~";
            return "Y~" + objTs.VEHNO + "~" + objTs.CONRTL_BRANCH + "~" + objTs.MODEL + "~" + objTs.CATEGORY + "~" + objTs.CAPACITY + "~" + objTs.Current_Km_Read + "~" + objTs.DIESEL_AMT_CF + "~" + objTs.DIESEL_QTY_CF + "~" + objTs.CONRTL_BRANCH + "~" + objTs.Vehicle_Status + "~" + objTs.Vendor_Name + "~" + objTs.Insurance_Validity_Date + "~" + objTs.Fitness_Validity_Date + "~" + objTs.RoadTaxDt + "~" + objTs.NationalPermitDt + "~" + objTs.InsuranceValidityDateTripValidation + "~" + objTs.FitnessValidityDateTripValidation + "~" + objTs.NationalPermitDtTripValidation + "~" + objTs.RoadTaxDtTripValidation + "~" + objTs.FiveYearPermitDtTripValidation + "~" + objTs.DieselLtrsTripValidation + "~" + objTs.FiveYearPermitDt + "~" + objTs.InsuranceDays + "~" + objTs.FitnessDays + "~" + objTs.NationalPermitDays + "~" + objTs.RoadTaxDays + "~" + objTs.FiveYearPermitDays + "~" + objTs.Flag + "~" + objTs.RequestID + "~" + objTs.RequestApprovedInsuranceDate + "~" + objTs.RequestApprovedFitnessDate + "~" + objTs.RequestApprovedNationalDate + "~" + objTs.RequestApprovedRoadDate + "~" + objTs.RequestApprovedFiveYearDate + "~" + objTs.TripSheetNumber + "~" +
                objTs.TripSheetDate + "~" + objTs.TripSheetOCloseDate + "~" + objTs.TripSheetCount + "~" + objTs.RequestDieselLtr + "~" + objTs.AddBlue_AMT_CF + "~" + objTs.AddBlue_QTY_CF + "~";
        }
        else
        {
            return "N~";
        }
    }


    //************* Mayank **************
    private string FillTripsheetVehicleDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);
        objTs.Vehicle_No = Request.QueryString["VehicleNo"].ToString();
        objTs.GetTripsheetVehicleDetails();

        if (objTs.IsRecordFound == true)
        {
            return "Y~" + objTs.TripNo + "~" + objTs.TripDate + "~";
        }
        else
        {
            return "N~";
        }
    }
    //*******************************

    private string GetNewDriverDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.Vehicle_No = Request.QueryString["VEHNO"].ToString();
        objTs.GetDriverDetails();

        //if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~" + objTs.Driving_lic_File + "~" + objTs.Driver_Type_ID + "~" + objTs.Driver_Status + "~"; } else { return "N~"; }
        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~" + objTs.Driving_lic_File + "~" + objTs.Driver_Type_ID + "~" + objTs.Driver_Status + "~" + objTs.License_Verified + "~" + objTs.LicenseValditydtTripValidation + "~" + objTs.LicenseVerifiedDtTripValidation + "~" + objTs.DriverCashTripValidation + "~" + objTs.License_Verified_Dt + "~"; } else { return "N~"; }
    }

    private string GetDriverDetailsVehicleWise()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.Vehicle_No = Request.QueryString["VEHNO"].ToString();

        objTs.GetDriverDetailsVehicleWise();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.VEHNO + "~"; } else { return "N~"; }
    }

    private string GetNewDriverDetailsMaster()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.Vehicle_No = Request.QueryString["VEHNO"].ToString();
        objTs.GetDriverDetails();

        //if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~" + objTs.Driving_lic_File + "~" + objTs.Driver_Type_ID + "~" + objTs.Driver_Status + "~"; } else { return "N~"; }
        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~" + objTs.Driving_lic_File + "~" + objTs.Driver_Type_ID + "~" + objTs.Driver_Status + "~" + objTs.License_Verified + "~" + objTs.LicenseValditydtTripValidation + "~" + objTs.LicenseVerifiedDtTripValidation + "~" + objTs.DriverCashTripValidation + "~" + objTs.License_Verified_Dt + "~" + objTs.DriverLicenseDays + "~" + objTs.DriverLicVerificationDays + "~" + objTs.Flag + "~" + objTs.RequestID + "~" + objTs.RequestApprovedDriverLicenseDate + "~" + objTs.RequestApprovedDriverLicenseVerificationDate + "~" + objTs.RequestApprovedDriverCashVerificationDate + "~"; } else { return "N~"; }
    }

    private string GetDriverDetailsVehicleWiseMaster()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.Vehicle_No = Request.QueryString["VEHNO"].ToString();

        objTs.GetDriverDetailsVehicleWise();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.VEHNO + "~"; } else { return "N~"; }
    }

    private string CheckFuelSlipNo()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.FuelSlipNo = Request.QueryString["FuelSlipNo"].ToString();
        objTs.SRNO = Request.QueryString["SRNO"].ToString();
        objTs.GetFuelSlipNo();

        if (objTs.IsRecordFound == true)
        {
            return "Y~" + objTs.FuelSlipNo + "~" + objTs.TripSheetNo + "~";
        }
        else
        {
            return "N~";
        }
    }

}
