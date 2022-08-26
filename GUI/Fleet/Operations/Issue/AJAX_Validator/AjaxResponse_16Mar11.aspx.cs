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

public partial class AjaxResponse : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "FillStandardAmt") { Response.Write(FillStandardAmt()); }
        if (Request.QueryString["Function"] == "CheckValidManualTS") { Response.Write(CheckValidManualTS()); }
        if (Request.QueryString["Function"] == "GetDriverDetails") { Response.Write(GetDriverDetails()); }
        if (Request.QueryString["Function"] == "FillPolarity") { Response.Write(FillPolarity()); }
        if (Request.QueryString["Function"] == "CheckTripRule") { Response.Write(CheckTripRule()); }
        if (Request.QueryString["Function"] == "CheckDriver1ManualCode") { Response.Write(CheckDriver1ManualCode()); }
        if (Request.QueryString["Function"] == "CheckValidCity") { Response.Write(CheckValidCity()); }
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
		if (Request.QueryString["Function"] == "CheckTripsheetNo") { Response.Write(CheckTripsheetNo()); }
        if (Request.QueryString["Function"] == "CheckTrip") { Response.Write(CheckTrip()); }
		if (Request.QueryString["Function"] == "GetVehicleNo") { Response.Write(GetVehicleNo()); }
        if (Request.QueryString["Function"] == "GetNewVehicleNo") { Response.Write(GetNewVehicleNo()); }
        if (Request.QueryString["Function"] == "GetNewControllingBranch") { Response.Write(GetNewControllingBranch()); }
        if (Request.QueryString["Function"] == "GetTransferDate") { Response.Write(GetTransferDate()); }
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
    private string GetDriverDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.GetDriverDetails();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~"; } else { return "N~"; }
    }

    private string CheckDriver1ManualCode()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Manual_Driver_Code = Request.QueryString["DriverManualCode"].ToString();
        objTs.CheckDriver1ManualCode();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Manual_Driver_Code + "~" + objTs.Driver_Id + "~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Driver_Status + "~" + objTs.Driver_Photo + "~" + objTs.Trip_Count + "~"; } else { return "N~"; }
    }
	private string CheckTripsheetNo()
    {
        cls_Fuel_TripEdit trip = new cls_Fuel_TripEdit(str_Connection_String);

        trip.TripsheetNo = Request.QueryString["TripsheetNo"].ToString();

        trip.GetTripsheetNo();

        if (trip.IsRecordFound == true) { return "Y~" + trip.TripsheetNo + "~" + trip.driversettledt + "~"; } else { return "N~"; }
    }

    private string CheckTrip()
    {
        cls_Fuel_TripEdit trip = new cls_Fuel_TripEdit(str_Connection_String);

        trip.TripsheetNo = Request.QueryString["TripsheetNo"].ToString();

        trip.GetTrip();

        if (trip.IsRecordFound == true) { return "Y~" + trip.TripsheetNo + "~" + trip.driversettledt + "~"; } else { return "N~"; }
    }
	
	
    private string GetVehicleNo()
    {
        cls_VehicleTransfer VehTrans = new cls_VehicleTransfer(str_Connection_String);

        VehTrans.VEHNO = Request.QueryString["VEHNO"].ToString();
        VehTrans.GetVehicleNo();

        if (VehTrans.IsRecordFound == true) { return "Y~" + VehTrans.VEHNO + "~" + VehTrans.VEH_INTERNAL_NO + "~" + VehTrans.Conrtl_branch + "~" + VehTrans.Current_KM_Read + "~"; } else { return "N~"; }
    }
    private string GetNewVehicleNo()
    {
        cls_VehicleTransfer VehTrans = new cls_VehicleTransfer(str_Connection_String);

        VehTrans.VEHNO = Request.QueryString["NEW_VEHNO"].ToString();
        VehTrans.GetNewVehicleNo();

        if (VehTrans.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string GetNewControllingBranch()
    {
        cls_VehicleTransfer VehTrans = new cls_VehicleTransfer(str_Connection_String);

        VehTrans.LocCode = Request.QueryString["LocCode"].ToString();
        VehTrans.GetNewControllingBranch();

        if (VehTrans.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string GetTransferDate()
    {
        cls_VehicleTransfer VehTrans = new cls_VehicleTransfer(str_Connection_String);

        VehTrans.VEHNO = Request.QueryString["VEHNO"].ToString();
        VehTrans.VEHREGNO = Request.QueryString["TransferDate"].ToString();
        VehTrans.GetTransferDate();

        if (VehTrans.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }  
	
}
