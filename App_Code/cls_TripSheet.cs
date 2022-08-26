using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using WebControls;
using WebX.Common;
using System.Collections.Generic;
using System.Runtime.Serialization;
/// <summary>
/// Summary description for cls_TyrePattern
/// </summary>
public class TripSheet : DataAccessLayer
{
    #region Private Declaration
    private string _Connection_String;
    protected bool _Is_Record_Found;
    private string _Manual_TripSheetNo;

    // TRY MAYANK START
    private string _Fuel_SlipNo;
    // TRY MAYANK END

    //Mayank
    //private string _Fuel_SlipNo;

    private string _Manual_Driver_Code;

    private string _Driver_Id;
    private string _Driver_Name;
    private string _License_No;
    private string _Valdity_dt;

    private string _City_Name;
    /// <summary>
    /// For Trip Rule Master
    private string _Vehicle_Selection;
    private string _End_Location;
    private string _IsSecondTrip_Approved;
    private string _Driver1_Manual;
    private string _Driver2_Manual;
    private string _Trip_Route_Selection;
    private string _THC_Attached;
    private string _Enter_By;
    private string _Vehicle_Filter;
    private string _UFL_Filter;
    private string _Auto_Vslip_Filter;
    private string _Fuel_Bill_Entry_TSWise;
    private string _ExternalUsage_Category;

    // For Transit Time Calculation in New Trip
    private string _Tot_Hour;
    private string _Tot_Min;

    //For Trip Route Bind
    private string _Vehicle_No, _Vehicle_Type;
    private string _Customer_Code, _Driver_Status;
    private string _Current_Km_Read, _VENDORTYPE, _BRCD;
    public string _VEHICLE_MODE, _DOCKET_WITH_TRIPSHEET, _LOCAL_CITY, _DOCKET_NO_LABEL;
    public string _TSWithVehicle_Valid, _TS_VehicleFilter_Loc, _Driver_WO_Vehicle, _THC_WO_Tripsheet, _Company_Code;
    public string _Checklist, _Checklist_Mandatory;
    public string _Driver_Photo_Rule, _Driver_License, _Settlement_Pending, _Tot_Tripsheet;
    public string _Retrieved_from_last_Trip, _Not_To_Be_Changed, _Editable_Can_Be_Change;
    public string _Diff_Bet_CloseKM_StartKM, _CloseKM_Greater_Than_StartKM;
    public string _Trip_Closure_Not_Zero, _Trip_Closure_Zero;
    public string _Fuel_Bill_Entry_Trip_Date, _Fuel_Bill_Entry_Trip_Close_Date, _Fuel_Bill_Entry_Trip_settlement_Date;
    public string _Advance_Entry_Settlement_Not_Done, _Advance_Entry_Tripsheet_Not_Closed;
    public string _TripSheet_Name, _JobSheet_Name;
    public string _TripSheet_DateRule;
    public string _TripAdvance_DateRule_3Days, _TripAdvance_DateRule_Equals_Tripsheet;
    public string _DriverSettlmt_DateRule_2Days, _DriverSettlmt_DateRule_Equals_CloseDate, _DriverSettlmt_DateRule_Equals_LastAdvanceDate;
    public string _TripSheet_Cancel, _TripSheet_Row;
    public string _VSlipNo;
    public string _License_Verified, _LicenseValditydtTripValidation, _LicenseVerifiedDtTripValidation, _DriverCashTripValidation, _License_Verified_Dt;
    public string _DOCKNO, _DOCKDT, _Org_Dest, _PKGSNO, _ACTUWT, _CHRGWT, _SubTotal, _DKTTOT;
    private string _VEHNO, _CONRTL_BRANCH, _MODEL, _CATEGORY, _DIESEL_AMT_CF, _DIESEL_QTY_CF, _CAPACITY, _CURLOC, _Driving_lic_File, _TripSheetNumber, _TripSheetDate, _TripSheetOCloseDate, _TripSheetCount,_AddBlue_AMT_CF, _AddBlue_QTY_CF;
    private string _Driver_Type_ID, _driver_status, _Vehicle_Status;

    private string _Driver2_Photo_Rule, _Driver2_License, _Driver2_Mandetory;
    private string _Cleaner_Mandetory, _Driver2_With_LocationFilter;
    private string _city_code;
    private string _Diesel_CF;

    public string _FuelSlipNo;
    public string _TripSheetNo;
    public string _SRNO;

    private string _oper_close_dt2, _Hour_Time, _Minute_Time, _AM_PM_Time, _oper_close_dt, _oper_close_dt3;
    private string _IOCL_YN;

    //added by anupam
    public string _Driver1NTFM;
    public string _Driver2NTFM;
    public string _CleanerNTFM;
    public string _FuelTypePD;
    public string _FuelTypePDRate;
    public string _FuelVendor;
    public string _FuelVendorNAme;
    //added by anupam

    public string _FUEL_SLIP_PROVIDED;
    public string _Vendor_Name;

    public string _Trip_Billing;
    public string _Trip_Billing_wise;
    public string _TripLogFromMaster;
    public string _FuelDetailsFromMaster;

    //added by ritesh singh
    public string _Insurance_Validity_Date;
    public string _Fitness_Validity_Date;
    public string _RoadTaxDt;
    public string _NationalPermitDt;
    public string _InsuranceValidityDateTripValidation, _FitnessValidityDateTripValidation, _NationalPermitDtTripValidation, _RoadTaxDtTripValidation, _FiveYearPermitDtTripValidation, _DieselLtrsTripValidation, _FiveYearPermitDt;


    //************* Mayank **************
    public string _TripNo;
    public string _TripDate;
    public string _InsuranceDays;
    public string _FitnessDays;
    public string _NationalPermitDays;
    public string _RoadTaxDays;
    public string _FiveYearPermitDays;
    public string _DriverLicenseDays;
    public string _DriverLicVerificationDays;
    public string _Flag;
    public string _RequestID;
    public string _RequestApprovedInsuranceDate;
    public string _RequestApprovedFitnessDate;
    public string _RequestApprovedNationalDate;
    public string _RequestApprovedRoadDate;
    public string _RequestApprovedFiveYearDate;
    public string _RequestApprovedDriverLicenseDate;
    public string _RequestApprovedDriverLicenseVerificationDate;
    public string _RequestDieselLtr;
    public string _RequestApprovedDriverCashVerificationDate;
    
    //***********************************

    /// </summary>

    #endregion

    #region Class Member Declarations

    private SqlDateTime _end_Date_Time, _start_Date_Time, _tripsheet_Date, _cancel_Date;
    private SqlInt32 _id, _driver_Id, _employee_Id;
    private SqlDecimal _to_City_Code, _start_KM_Read, _end_KM_Read, _from_City_Code;
    private SqlString _service_Level_Parameters, _customer_Code, _entry_By, _update_By, _vehicle_No, _tripsheet_No, _cancel_By, _category_Id;
    private SqlString _contract_Type_Id, _duration_Id, _vehicle_Mode_Id, _service_By_Id, _remarks, _outstation, _pickDrop_Id, _working_days;

    #endregion

    #region Class Member Declarations

    //Added BY anupam
    public string FuelSlipNo { get { return _FuelSlipNo; } set { _FuelSlipNo = value; } }
    public string TripSheetNo { get { return _TripSheetNo; } set { _TripSheetNo = value; } }
    public string SRNO { get { return _SRNO; } set { _SRNO = value; } }
    //public string FUEL_SLIP_PROVIDED { get { return _FUEL_SLIP_PROVIDED; } set { _FUEL_SLIP_PROVIDED = value; } }
    //public string Trip_Billing { get { return _Trip_Billing; } set { _Trip_Billing = value; } }
    //public string Trip_Billing_wise { get { return _Trip_Billing_wise; } set { _Trip_Billing_wise = value; } }

    public string oper_close_dt2 { get { return _oper_close_dt2; } set { _oper_close_dt2 = value; } }
    public string Hour_Time { get { return _Hour_Time; } set { _Hour_Time = value; } }
    public string Minute_Time { get { return _Minute_Time; } set { _Minute_Time = value; } }
    public string AM_PM_Time { get { return _AM_PM_Time; } set { _AM_PM_Time = value; } }
    public string oper_close_dt { get { return _oper_close_dt; } set { _oper_close_dt = value; } }
    public string oper_close_dt3 { get { return _oper_close_dt3; } set { _oper_close_dt3 = value; } }
    public string IOCL_YN { get { return _IOCL_YN; } set { _IOCL_YN = value; } }

    //public string Driver1NTFM { get { return _Driver1NTFM; } set { _Driver1NTFM = value; } }
    //public string Driver2NTFM { get { return _Driver2NTFM; } set { _Driver2NTFM = value; } }
    //public string CleanerNTFM { get { return _CleanerNTFM; } set { _CleanerNTFM = value; } }
    //public string FuelTypePD { get { return _FuelTypePD; } set { _FuelTypePD = value; } }
    //public string FuelTypePDRate { get { return _FuelTypePDRate; } set { _FuelTypePDRate = value; } }
    //public string FuelVendor { get { return _FuelVendor; } set { _FuelVendor = value; } }
    //public string FuelVendorNAme { get { return _FuelVendorNAme; } set { _FuelVendorNAme = value; } }
    //added by anupam

    public SqlDateTime end_Date_Time { get { return _end_Date_Time; } set { _end_Date_Time = value; } }
    public SqlDateTime start_Date_Time { get { return _start_Date_Time; } set { _start_Date_Time = value; } }
    public SqlDateTime tripsheet_Date { get { return _tripsheet_Date; } set { _tripsheet_Date = value; } }
    public SqlDateTime cancel_Date { get { return _cancel_Date; } set { _cancel_Date = value; } }

    public SqlDecimal to_City_Code { get { return _to_City_Code; } set { _to_City_Code = value; } }
    public SqlDecimal start_KM_Read { get { return _start_KM_Read; } set { _start_KM_Read = value; } }
    public SqlDecimal end_KM_Read { get { return _end_KM_Read; } set { _end_KM_Read = value; } }
    public SqlDecimal from_City_Code { get { return _from_City_Code; } set { _from_City_Code = value; } }

    public SqlString service_Level_Parameters { get { return _service_Level_Parameters; } set { _service_Level_Parameters = value; } }
    public SqlString customer_Code { get { return _customer_Code; } set { _customer_Code = value; } }
    public SqlString entry_By { get { return _entry_By; } set { _entry_By = value; } }
    public SqlString update_By { get { return _update_By; } set { _update_By = value; } }
    public SqlString vehicle_No { get { return _vehicle_No; } set { _vehicle_No = value; } }
    public SqlString tripsheet_No { get { return _tripsheet_No; } set { _tripsheet_No = value; } }
    public SqlString cancel_By { get { return _cancel_By; } set { _cancel_By = value; } }
    public SqlString category_Id { get { return _category_Id; } set { _category_Id = value; } }
    public SqlString contract_Type_Id { get { return _contract_Type_Id; } set { _contract_Type_Id = value; } }
    public SqlString duration_Id { get { return _duration_Id; } set { _duration_Id = value; } }
    public SqlString vehicle_Mode_Id { get { return _vehicle_Mode_Id; } set { _vehicle_Mode_Id = value; } }
    public SqlString service_By_Id { get { return _service_By_Id; } set { _service_By_Id = value; } }
    public SqlString remarks { get { return _remarks; } set { _remarks = value; } }
    public SqlString outstation { get { return _outstation; } set { _outstation = value; } }
    public SqlString pickDrop_Id { get { return _pickDrop_Id; } set { _pickDrop_Id = value; } }
    public SqlString working_days { get { return _working_days; } set { _working_days = value; } }

    #endregion

    #region Properties

    //added by anupam
    public string Driver1NTFM { get { return _Driver1NTFM; } set { _Driver1NTFM = value; } }
    public string Driver2NTFM { get { return _Driver2NTFM; } set { _Driver2NTFM = value; } }
    public string CleanerNTFM { get { return _CleanerNTFM; } set { _CleanerNTFM = value; } }
    public string FuelTypePD { get { return _FuelTypePD; } set { _FuelTypePD = value; } }
    public string FuelTypePDRate { get { return _FuelTypePDRate; } set { _FuelTypePDRate = value; } }
    public string FuelVendor { get { return _FuelVendor; } set { _FuelVendor = value; } }
    public string FuelVendorNAme { get { return _FuelVendorNAme; } set { _FuelVendorNAme = value; } }

    //added by anupam
    public string FUEL_SLIP_PROVIDED { get { return _FUEL_SLIP_PROVIDED; } set { _FUEL_SLIP_PROVIDED = value; } }
    public string Trip_Billing { get { return _Trip_Billing; } set { _Trip_Billing = value; } }
    public string Trip_Billing_wise { get { return _Trip_Billing_wise; } set { _Trip_Billing_wise = value; } }
    public string TripLogFromMaster { get { return _TripLogFromMaster; } set { _TripLogFromMaster = value; } }
    public string FuelDetailsFromMaster { get { return _FuelDetailsFromMaster; } set { _FuelDetailsFromMaster = value; } }

    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }

    public string VENDORTYPE { get { return _VENDORTYPE; } set { _VENDORTYPE = value; } }
    public string BRCD { get { return _BRCD; } set { _BRCD = value; } }

    public string Tot_Hour { get { return _Tot_Hour; } set { _Tot_Hour = value; } }
    public string Tot_Min { get { return _Tot_Min; } set { _Tot_Min = value; } }
    public string Manual_TripSheetNo { get { return _Manual_TripSheetNo; } set { _Manual_TripSheetNo = value; } }


    //TRY MAYANK START
    public string Fuel_SlipNo { get { return _Fuel_SlipNo; } set { _Fuel_SlipNo = value; } }
    // TRY MAYANK END

    //Mayank
    //public string Fuel_SlipNo { get { return _Fuel_SlipNo; } set { _Fuel_SlipNo = value; } }

    public string Manual_Driver_Code { get { return _Manual_Driver_Code; } set { _Manual_Driver_Code = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    public string Vehicle_No { get { return _Vehicle_No; } set { _Vehicle_No = value; } }
    public string Vehicle_Type { get { return _Vehicle_Type; } set { _Vehicle_Type = value; } }

    public string Customer_Code { get { return _Customer_Code; } set { _Customer_Code = value; } }
    public string Driver_Status { get { return _Driver_Status; } set { _Driver_Status = value; } }

    public string Current_Km_Read { get { return _Current_Km_Read; } set { _Current_Km_Read = value; } }

    public string VEHICLE_MODE { get { return _VEHICLE_MODE; } set { _VEHICLE_MODE = value; } }
    public string DOCKET_WITH_TRIPSHEET { get { return _DOCKET_WITH_TRIPSHEET; } set { _DOCKET_WITH_TRIPSHEET = value; } }
    public string LOCAL_CITY { get { return _LOCAL_CITY; } set { _LOCAL_CITY = value; } }
    public string DOCKET_NO_LABEL { get { return _DOCKET_NO_LABEL; } set { _DOCKET_NO_LABEL = value; } }

    public string UFL_Filter { get { return _UFL_Filter; } set { _UFL_Filter = value; } }

    public string City_Name { get { return _City_Name; } set { _City_Name = value; } }

    public string Driver_Id { get { return _Driver_Id; } set { _Driver_Id = value; } }
    public string Driver_Name { get { return _Driver_Name; } set { _Driver_Name = value; } }
    public string License_No { get { return _License_No; } set { _License_No = value; } }
    public string Valdity_dt { get { return _Valdity_dt; } set { _Valdity_dt = value; } }
    public string Vendor_Name { get { return _Vendor_Name; } set { _Vendor_Name = value; } }


    public string Insurance_Validity_Date { get { return _Insurance_Validity_Date; } set { _Insurance_Validity_Date = value; } }
    public string Fitness_Validity_Date { get { return _Fitness_Validity_Date; } set { _Fitness_Validity_Date = value; } }
    public string RoadTaxDt { get { return _RoadTaxDt; } set { _RoadTaxDt = value; } }
    public string NationalPermitDt { get { return _NationalPermitDt; } set { _NationalPermitDt = value; } }

    public string InsuranceValidityDateTripValidation { get { return _InsuranceValidityDateTripValidation; } set { _InsuranceValidityDateTripValidation = value; } }
    public string FitnessValidityDateTripValidation { get { return _FitnessValidityDateTripValidation; } set { _FitnessValidityDateTripValidation = value; } }
    public string NationalPermitDtTripValidation { get { return _NationalPermitDtTripValidation; } set { _NationalPermitDtTripValidation = value; } }
    public string RoadTaxDtTripValidation { get { return _RoadTaxDtTripValidation; } set { _RoadTaxDtTripValidation = value; } }
    public string FiveYearPermitDtTripValidation { get { return _FiveYearPermitDtTripValidation; } set { _FiveYearPermitDtTripValidation = value; } }
    public string DieselLtrsTripValidation { get { return _DieselLtrsTripValidation; } set { _DieselLtrsTripValidation = value; } }
    public string FiveYearPermitDt { get { return _FiveYearPermitDt; } set { _FiveYearPermitDt = value; } }


    /// <summary>
    /// For Trip Rule Master

    public string Auto_Vslip_Filter { get { return _Auto_Vslip_Filter; } set { _Auto_Vslip_Filter = value; } }
    public string Vehicle_Selection { get { return _Vehicle_Selection; } set { _Vehicle_Selection = value; } }
    public string End_Location { get { return _End_Location; } set { _End_Location = value; } }
    public string SecondTrip_Approved { get { return _IsSecondTrip_Approved; } set { _IsSecondTrip_Approved = value; } }
    public string Driver1_Manual { get { return _Driver1_Manual; } set { _Driver1_Manual = value; } }
    public string Driver2_Manual { get { return _Driver2_Manual; } set { _Driver2_Manual = value; } }
    public string Trip_Route_Selection { get { return _Trip_Route_Selection; } set { _Trip_Route_Selection = value; } }
    public string THC_Attached { get { return _THC_Attached; } set { _THC_Attached = value; } }
    public string Enter_By { get { return _Enter_By; } set { _Enter_By = value; } }
    public string Vehicle_Filter { get { return _Vehicle_Filter; } set { _Vehicle_Filter = value; } }
    public string Fuel_Bill_Entry_TSWise { get { return _Fuel_Bill_Entry_TSWise; } set { _Fuel_Bill_Entry_TSWise = value; } }
    public string ExternalUsage_Category { get { return _ExternalUsage_Category; } set { _ExternalUsage_Category = value; } }

    public string TSWithVehicle_Valid { get { return _TSWithVehicle_Valid; } set { _TSWithVehicle_Valid = value; } }
    public string TS_VehicleFilter_Loc { get { return _TS_VehicleFilter_Loc; } set { _TS_VehicleFilter_Loc = value; } }
    public string Driver_WO_Vehicle { get { return _Driver_WO_Vehicle; } set { _Driver_WO_Vehicle = value; } }
    public string THC_WO_Tripsheet { get { return _THC_WO_Tripsheet; } set { _THC_WO_Tripsheet = value; } }
    public string Checklist { get { return _Checklist; } set { _Checklist = value; } }
    public string Checklist_Mandatory { get { return _Checklist_Mandatory; } set { _Checklist_Mandatory = value; } }

    public string Driver_Photo_Rule { get { return _Driver_Photo_Rule; } set { _Driver_Photo_Rule = value; } }
    public string Driver_License { get { return _Driver_License; } set { _Driver_License = value; } }
    public string Settlement_Pending { get { return _Settlement_Pending; } set { _Settlement_Pending = value; } }
    public string Tot_Tripsheet { get { return _Tot_Tripsheet; } set { _Tot_Tripsheet = value; } }
    public string Retrieved_from_last_Trip { get { return _Retrieved_from_last_Trip; } set { _Retrieved_from_last_Trip = value; } }
    public string Not_To_Be_Changed { get { return _Not_To_Be_Changed; } set { _Not_To_Be_Changed = value; } }
    public string Editable_Can_Be_Change { get { return _Editable_Can_Be_Change; } set { _Editable_Can_Be_Change = value; } }

    public string Diff_Bet_CloseKM_StartKM { get { return _Diff_Bet_CloseKM_StartKM; } set { _Diff_Bet_CloseKM_StartKM = value; } }
    public string CloseKM_Greater_Than_StartKM { get { return _CloseKM_Greater_Than_StartKM; } set { _CloseKM_Greater_Than_StartKM = value; } }

    public string Trip_Closure_Not_Zero { get { return _Trip_Closure_Not_Zero; } set { _Trip_Closure_Not_Zero = value; } }
    public string Trip_Closure_Zero { get { return _Trip_Closure_Zero; } set { _Trip_Closure_Zero = value; } }
    public string Fuel_Bill_Entry_Trip_Date { get { return _Fuel_Bill_Entry_Trip_Date; } set { _Fuel_Bill_Entry_Trip_Date = value; } }
    public string Fuel_Bill_Entry_Trip_Close_Date { get { return _Fuel_Bill_Entry_Trip_Close_Date; } set { _Fuel_Bill_Entry_Trip_Close_Date = value; } }
    public string Fuel_Bill_Entry_Trip_settlement_Date { get { return _Fuel_Bill_Entry_Trip_settlement_Date; } set { _Fuel_Bill_Entry_Trip_settlement_Date = value; } }

    public string Advance_Entry_Settlement_Not_Done { get { return _Advance_Entry_Settlement_Not_Done; } set { _Advance_Entry_Settlement_Not_Done = value; } }
    public string Advance_Entry_Tripsheet_Not_Closed { get { return _Advance_Entry_Tripsheet_Not_Closed; } set { _Advance_Entry_Tripsheet_Not_Closed = value; } }

    public string TripSheet_Name { get { return _TripSheet_Name; } set { _TripSheet_Name = value; } }
    public string JobSheet_Name { get { return _JobSheet_Name; } set { _JobSheet_Name = value; } }

    public string TripSheet_DateRule { get { return _TripSheet_DateRule; } set { _TripSheet_DateRule = value; } }
    public string TripAdvance_DateRule_3Days { get { return _TripAdvance_DateRule_3Days; } set { _TripAdvance_DateRule_3Days = value; } }
    public string TripAdvance_DateRule_Equals_Tripsheet { get { return _TripAdvance_DateRule_Equals_Tripsheet; } set { _TripAdvance_DateRule_Equals_Tripsheet = value; } }
    public string DriverSettlmt_DateRule_2Days { get { return _DriverSettlmt_DateRule_2Days; } set { _DriverSettlmt_DateRule_2Days = value; } }
    public string DriverSettlmt_DateRule_Equals_CloseDate { get { return _DriverSettlmt_DateRule_Equals_CloseDate; } set { _DriverSettlmt_DateRule_Equals_CloseDate = value; } }
    public string DriverSettlmt_DateRule_Equals_LastAdvanceDate { get { return _DriverSettlmt_DateRule_Equals_LastAdvanceDate; } set { _DriverSettlmt_DateRule_Equals_LastAdvanceDate = value; } }
    public string TripSheet_Cancel { get { return _TripSheet_Cancel; } set { _TripSheet_Cancel = value; } }
    public string TripSheet_Row { get { return _TripSheet_Row; } set { _TripSheet_Row = value; } }
    public string VSlipNo { get { return _VSlipNo; } set { _VSlipNo = value; } }
    public string License_Verified { get { return _License_Verified; } set { _License_Verified = value; } }

    public string LicenseValditydtTripValidation { get { return _LicenseValditydtTripValidation; } set { _LicenseValditydtTripValidation = value; } }
    public string LicenseVerifiedDtTripValidation { get { return _LicenseVerifiedDtTripValidation; } set { _LicenseVerifiedDtTripValidation = value; } }
    public string DriverCashTripValidation { get { return _DriverCashTripValidation; } set { _DriverCashTripValidation = value; } }
    public string License_Verified_Dt { get { return _License_Verified_Dt; } set { _License_Verified_Dt = value; } }


    public string DOCKNO { get { return _DOCKNO; } set { _DOCKNO = value; } }
    public string DOCKDT { get { return _DOCKDT; } set { _DOCKDT = value; } }
    public string Org_Dest { get { return _Org_Dest; } set { _Org_Dest = value; } }
    public string PKGSNO { get { return _PKGSNO; } set { _PKGSNO = value; } }
    public string ACTUWT { get { return _ACTUWT; } set { _ACTUWT = value; } }
    public string CHRGWT { get { return _CHRGWT; } set { _CHRGWT = value; } }
    public string SubTotal { get { return _SubTotal; } set { _SubTotal = value; } }
    public string DKTTOT { get { return _DKTTOT; } set { _DKTTOT = value; } }

    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string CONRTL_BRANCH { get { return _CONRTL_BRANCH; } set { _CONRTL_BRANCH = value; } }
    public string MODEL { get { return _MODEL; } set { _MODEL = value; } }
    public string CATEGORY { get { return _CATEGORY; } set { _CATEGORY = value; } }
    public string DIESEL_AMT_CF { get { return _DIESEL_AMT_CF; } set { _DIESEL_AMT_CF = value; } }
    public string DIESEL_QTY_CF { get { return _DIESEL_QTY_CF; } set { _DIESEL_QTY_CF = value; } }
    public string AddBlue_AMT_CF { get { return _AddBlue_AMT_CF; } set { _AddBlue_AMT_CF = value; } }
    public string AddBlue_QTY_CF { get { return _AddBlue_QTY_CF; } set { _AddBlue_QTY_CF = value; } }
    public string CAPACITY { get { return _CAPACITY; } set { _CAPACITY = value; } }
    public string CURLOC { get { return _CURLOC; } set { _CURLOC = value; } }
    public string Driving_lic_File { get { return _Driving_lic_File; } set { _Driving_lic_File = value; } }
    public string Driver_Type_ID { get { return _Driver_Type_ID; } set { _Driver_Type_ID = value; } }
    public string driver_status { get { return _driver_status; } set { _driver_status = value; } }
    public string Vehicle_Status { get { return _Vehicle_Status; } set { _Vehicle_Status = value; } }

    public string Driver2_Photo_Rule { get { return _Driver2_Photo_Rule; } set { _Driver2_Photo_Rule = value; } }
    public string Driver2_License { get { return _Driver2_License; } set { _Driver2_License = value; } }
    public string Driver2_Mandetory { get { return _Driver2_Mandetory; } set { _Driver2_Mandetory = value; } }
    public string Cleaner_Mandetory { get { return _Cleaner_Mandetory; } set { _Cleaner_Mandetory = value; } }
    public string Driver2_With_LocationFilter { get { return _Driver2_With_LocationFilter; } set { _Driver2_With_LocationFilter = value; } }

    public string city_code { get { return _city_code; } set { _city_code = value; } }
    public string Diesel_CF { get { return _Diesel_CF; } set { _Diesel_CF = value; } }

    //public string FuelSlipNo { get { return _FuelSlipNo; } set { _FuelSlipNo = value; } }
    //public string TripSheetNo { get { return _TripSheetNo; } set { _TripSheetNo = value; } }
    //public string SRNO { get { return _SRNO; } set { _SRNO = value; } }

    //public string oper_close_dt2 { get { return _oper_close_dt2; } set { _oper_close_dt2 = value; } }
    //public string Hour_Time { get { return _Hour_Time; } set { _Hour_Time = value; } }
    //public string Minute_Time { get { return _Minute_Time; } set { _Minute_Time = value; } }
    //public string AM_PM_Time { get { return _AM_PM_Time; } set { _AM_PM_Time = value; } }
    //public string oper_close_dt { get { return _oper_close_dt; } set { _oper_close_dt = value; } }
    //public string oper_close_dt3 { get { return _oper_close_dt3; } set { _oper_close_dt3 = value; } }
    //public string IOCL_YN { get { return _IOCL_YN; } set { _IOCL_YN = value; } }



    //****** Mayank *******
    public string TripNo { get { return _TripNo; } set { _TripNo = value; } }
    public string TripDate { get { return _TripDate; } set { _TripDate = value; } }
    public string InsuranceDays { get { return _InsuranceDays; } set { _InsuranceDays = value; } }
    public string FitnessDays { get { return _FitnessDays; } set { _FitnessDays = value; } }
    public string NationalPermitDays { get { return _NationalPermitDays; } set { _NationalPermitDays = value; } }
    public string RoadTaxDays { get { return _RoadTaxDays; } set { _RoadTaxDays = value; } }
    public string FiveYearPermitDays { get { return _FiveYearPermitDays; } set { _FiveYearPermitDays = value; } }
    public string DriverLicenseDays { get { return _DriverLicenseDays; } set { _DriverLicenseDays = value; } }
    public string DriverLicVerificationDays { get { return _DriverLicVerificationDays; } set { _DriverLicVerificationDays = value; } }
    public string Flag { get { return _Flag; } set { _Flag = value; } }
    public string RequestID { get { return _RequestID; } set { _RequestID = value; } }
    public string RequestApprovedInsuranceDate { get { return _RequestApprovedInsuranceDate; } set { _RequestApprovedInsuranceDate = value; } }
    public string RequestApprovedFitnessDate { get { return _RequestApprovedFitnessDate; } set { _RequestApprovedFitnessDate = value; } }
    public string RequestApprovedNationalDate { get { return _RequestApprovedNationalDate; } set { _RequestApprovedNationalDate = value; } }
    public string RequestApprovedRoadDate { get { return _RequestApprovedRoadDate; } set { _RequestApprovedRoadDate = value; } }
    public string RequestApprovedFiveYearDate { get { return _RequestApprovedFiveYearDate; } set { _RequestApprovedFiveYearDate = value; } }
    public string RequestApprovedDriverLicenseDate { get { return _RequestApprovedDriverLicenseDate; } set { _RequestApprovedDriverLicenseDate = value; } }
    public string RequestApprovedDriverLicenseVerificationDate { get { return _RequestApprovedDriverLicenseVerificationDate; } set { _RequestApprovedDriverLicenseVerificationDate = value; } }
    public string TripSheetNumber { get { return _TripSheetNumber; } set { _TripSheetNumber = value; } }
    public string TripSheetDate { get { return _TripSheetDate; } set { _TripSheetDate = value; } }
    public string TripSheetOCloseDate { get { return _TripSheetOCloseDate; } set { _TripSheetOCloseDate = value; } }
    public string TripSheetCount { get { return _TripSheetCount; } set { _TripSheetCount = value; } }
    public string RequestDieselLtr { get { return _RequestDieselLtr; } set { _RequestDieselLtr = value; } }
    public string RequestApprovedDriverCashVerificationDate { get { return _RequestApprovedDriverCashVerificationDate; } set { _RequestApprovedDriverCashVerificationDate = value; } }
    

    //*********************
    /// </summary>


    #endregion

    public TripSheet(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }
    public void CheckValidManualNewTS()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select * from [Webx_Fleet_Tripsheet] where Customer_Code='" + Customer_Code.Trim() + "' And Company_Code='" + Company_Code.Trim() + "' And Location='" + BRCD.Trim() + "' And Manual_TripSheetNo='" + Manual_TripSheetNo + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckValidManualTS()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select * from WEBX_FLEET_VEHICLE_ISSUE where Manual_TripSheetNo='" + Manual_TripSheetNo + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    // TRY MAYANK START
    public void CheckValidSlipNo()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT * FROM Webx_Fuel_Issue_Slip Where UserSlipNo='" + Fuel_SlipNo + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    // TRY MAYANK END


    /// <summary>

    /// </summary>
    ////Mayank
    public void CheckValidFuelSlipNo()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select * from WEBX_FLEET_VEHICLE_ISSUE where Manual_TripSheetNo='" + Manual_TripSheetNo + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }



    public void BindVehicleDropdown(DropDownList ddl)
    {
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@VEHNO", Vehicle_No);
        prm[1] = new SqlParameter("@BRCD", BRCD);
        prm[2] = new SqlParameter("@VENDORTYPE", VENDORTYPE);

        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.StoredProcedure, "USP_VALID_VEHICLE", prm);
    }

    public void BindDriverDropdown(DropDownList ddl, string strFlag)
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@Driver_Name", Driver_Name);
        prm[1] = new SqlParameter("@BRCD", BRCD);
        prm[2] = new SqlParameter("@FLAG", strFlag);
        prm[3] = new SqlParameter("@Vehicle_No", Vehicle_No);

        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.StoredProcedure, "USP_VALID_Driver", prm);
    }

    public void BindRouteDropdown(DropDownList ddl)
    {
        ddl.Items.Clear();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@Vehilcle_No", Vehicle_No);
        prm[1] = new SqlParameter("@LocCode", SessionUtilities.CurrentBranchCode.Trim());

        DataControlManager dcm = new DataControlManager(_Connection_String);
        //dcm.DataBind(ddl, CommandType.StoredProcedure, "USP_TRIPROUTE_Tripsheet", prm);
        dcm.DataBind(ddl, CommandType.StoredProcedure, "USP_FLEET_TRIP_NEW_TRIPROUTE_Tripsheet", prm);
    }


    public void CheckVehicleNumber()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@VEHNO", Vehicle_No);
        prm[1] = new SqlParameter("@BRCD", SessionUtilities.CurrentBranchCode.ToString());

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_VALID_VEHICLE", prm);

        if (dt.Rows.Count > 0) { IsRecordFound = true; Current_Km_Read = dt.Rows[0]["Current_Km_Read"].ToString(); } else { IsRecordFound = false; }
    }
    public void CheckVehicleNumber1()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "select vehicleno,count(*) from webx_fleet_vehicle_issue where Oper_Close_Dt is null and end_dt_tm is  null and vehicleno='" + Vehicle_No + "' group by vehicleno having count(*)>0 ");

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void GetAdvTripDate()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select top 1 convert(varchar,AdvDate,103) as ADate from WEBX_TRIPSHEET_ADVEXP  where TripsheetNo = '" + Manual_TripSheetNo.Trim() + "' order by AdvDate desc");
        if (dt.Rows.Count > 0) { IsRecordFound = true; Valdity_dt = dt.Rows[0]["ADate"].ToString(); } else { IsRecordFound = false; }
    }
    public void CheckCustomerCode()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select * from webx_CUSTHDR where CUST_ACTIVE='Y' and custcd='" + Customer_Code + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public DataSet GetDsRoute()
    {
        DataSet ds = new DataSet();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@Vehilcle_No", Vehicle_No);
        ds = ExecuteDataSet(CommandType.StoredProcedure, "USP_TRIPROUTE_Tripsheet", prm);
        return ds;
    }

    public decimal GetCityCode(string CityName)
    {
        decimal cityCode;
        DataControlManager dcm = new DataControlManager(_Connection_String);
        object obj;
        obj = ExecuteScalar(CommandType.Text, "Select city_code From Webx_CityMaster Where Location='" + CityName + "'");
        cityCode = Convert.ToDecimal(obj.ToString());
        return cityCode;
    }
    public string GetDocumentNo()
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        GetFinancialYear objFinYear = new GetFinancialYear(_Connection_String);
        string YearVal = objFinYear.FinancialYear();
        string strTripsheetNo = "";
        object obj;
        SqlParameter[] prm = new SqlParameter[3];
        prm[0] = new SqlParameter("@LocCode", SessionUtilities.CurrentBranchCode.ToUpper().Trim());
        prm[1] = new SqlParameter("@FinYear", YearVal.Substring(0, 2).Trim());
        prm[2] = new SqlParameter("@Document", "NTS");
        obj = ExecuteScalar(CommandType.StoredProcedure, "WebX_SP_GetNextDocumentCode", prm);
        strTripsheetNo = obj.ToString();
        return strTripsheetNo;
    }

    public void InsertWebxFleetTripsheet()
    {
        SqlParameter[] prm = new SqlParameter[35];

        prm[0] = new SqlParameter("@sTripsheet_No", tripsheet_No);
        prm[1] = new SqlParameter("@daTripsheet_Date", tripsheet_Date);
        prm[2] = new SqlParameter("@daStart_Date_Time", start_Date_Time);
        prm[3] = new SqlParameter("@daEnd_Date_Time", end_Date_Time);
        prm[4] = new SqlParameter("@sCustomer_Code", customer_Code);
        prm[5] = new SqlParameter("@sService_By_Id", service_By_Id);

        prm[6] = new SqlParameter("@sContract_Type_Id", contract_Type_Id);
        prm[7] = new SqlParameter("@sCategory_Id", category_Id);
        prm[8] = new SqlParameter("@sPickDrop_Id", pickDrop_Id);
        prm[9] = new SqlParameter("@dcFrom_City_Code", from_City_Code);
        prm[10] = new SqlParameter("@dcTo_City_Code", to_City_Code);

        prm[11] = new SqlParameter("@sDuration_Id", duration_Id);
        prm[12] = new SqlParameter("@sVehicle_Mode_Id", vehicle_Mode_Id);
        prm[13] = new SqlParameter("@sVehicle_No", vehicle_No);
        prm[14] = new SqlParameter("@iDriver_Id", Driver_Id);
        prm[15] = new SqlParameter("@sOutstation", outstation);

        prm[16] = new SqlParameter("@dcStart_KM_Read", start_KM_Read);
        prm[17] = new SqlParameter("@dcEnd_KM_Read", end_KM_Read);
        prm[18] = new SqlParameter("@sRemarks", remarks);
        prm[19] = new SqlParameter("@sService_Level_Parameters", service_Level_Parameters);
        prm[20] = new SqlParameter("@sEntry_By", entry_By);
        prm[21] = new SqlParameter("@sLocaton", SessionUtilities.CurrentBranchCode);
        prm[22] = new SqlParameter("@sCompany_Code", SessionUtilities.DefaultCompanyCode);
        prm[23] = new SqlParameter("@sManual_TripSheetNo", Manual_TripSheetNo);
        prm[24] = new SqlParameter("@sWorking_Days", working_days);

        prm[25] = new SqlParameter("@sRUTCD", sRUTCD);
        prm[26] = new SqlParameter("@sVeh_Category_Id", sVeh_Category_Id);
        prm[27] = new SqlParameter("@sOneTwo_Way", sOneTwo_Way);
        prm[28] = new SqlParameter("@dStd_Reckoner_KM", dStd_Reckoner_KM);
        prm[29] = new SqlParameter("@dVeh_KM_Reading", dVeh_KM_Reading);
        prm[30] = new SqlParameter("@sTotal_Hours", sTotal_Hours);
        prm[31] = new SqlParameter("@sStd_Hours", sStd_Hours);
        prm[32] = new SqlParameter("@dAmount", dAmount);
        prm[33] = new SqlParameter("@dToll_Charges", dToll_Charges);
        prm[34] = new SqlParameter("@dParking_Charges", dParking_Charges);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Fleet_Webx_Fleet_Tripsheet", prm);
    }

    private string _sRUTCD, _sVeh_Category_Id, _sOneTwo_Way, _sTotal_Hours, _sStd_Hours;
    private decimal _dStd_Reckoner_KM, _dVeh_KM_Reading, _dAmount, _dToll_Charges, _dParking_Charges;

    public string sRUTCD { get { return _sRUTCD; } set { _sRUTCD = value; } }
    public string sVeh_Category_Id { get { return _sVeh_Category_Id; } set { _sVeh_Category_Id = value; } }
    public string sOneTwo_Way { get { return _sOneTwo_Way; } set { _sOneTwo_Way = value; } }
    public string sTotal_Hours { get { return _sTotal_Hours; } set { _sTotal_Hours = value; } }
    public string sStd_Hours { get { return _sStd_Hours; } set { _sStd_Hours = value; } }

    public decimal dStd_Reckoner_KM { get { return _dStd_Reckoner_KM; } set { _dStd_Reckoner_KM = value; } }
    public decimal dVeh_KM_Reading { get { return _dVeh_KM_Reading; } set { _dVeh_KM_Reading = value; } }
    public decimal dAmount { get { return _dAmount; } set { _dAmount = value; } }
    public decimal dToll_Charges { get { return _dToll_Charges; } set { _dToll_Charges = value; } }
    public decimal dParking_Charges { get { return _dParking_Charges; } set { _dParking_Charges = value; } }



    private string _Emp_Code, _Emp_Name, _Department, _From_Area, _To_Area;

    public string Emp_Code { get { return _Emp_Code; } set { _Emp_Code = value; } }
    public string Emp_Name { get { return _Emp_Name; } set { _Emp_Name = value; } }
    public string Department { get { return _Department; } set { _Department = value; } }
    public string From_Area { get { return _From_Area; } set { _From_Area = value; } }
    public string To_Area { get { return _To_Area; } set { _To_Area = value; } }

    public void InsertWebxFleetTSEmployeeMst()
    {
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@Emp_Code", Emp_Code);
        prm[1] = new SqlParameter("@Emp_Name", Emp_Name);
        prm[2] = new SqlParameter("@Department", Department);
        prm[3] = new SqlParameter("@From_Area", From_Area);
        prm[4] = new SqlParameter("@To_Area", To_Area);
        prm[5] = new SqlParameter("@Tripsheet_No", tripsheet_No);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_TS_Employee_Mst", prm);
    }

    public void CheckValidManualDriverCode()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select Driver_Id,Driver_Name,License_No,convert(varchar,Valdity_dt,103) as  Valdity_dt from WEBX_FLEET_DRIVERMST where Manual_Driver_Code='" + Manual_Driver_Code + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckValidCity()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select Location from webx_citymaster where Location='" + City_Name + "' and ActiveFlag='Y'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    public void CheckValidCityCode()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select Location,city_code from webx_citymaster where Location='" + City_Name + "' and ActiveFlag='Y'");

        if (dt.Rows.Count > 0)
        {
            city_code = dt.Rows[0]["city_code"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }


    public void CheckValidCityCodeFUEL()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select from_cityCode,Location,Fuel_Type,Rate from  FuelRateMSTCheck where Location='" + City_Name + "' AND Vend_Code='" + FuelVendor + "' AND Fuel_Type='" + FuelTypePD + "'");

        if (dt.Rows.Count > 0)
        {
            city_code = dt.Rows[0]["from_cityCode"].ToString();
            FuelTypePDRate = dt.Rows[0]["Rate"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckValidBranchCode(string mBranchCode)
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select  * from webx_Location  where loccode='" + mBranchCode.Trim() + "'");
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    public void OnChangeRoute(string strRutCd)
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "select SUM(CONVERT(NUMERIC(18,0),TRTIME_HR)) +  SUM(CONVERT(NUMERIC(18,0),STTIME_HR))  AS Tot_Hour,SUM(CONVERT(NUMERIC(18,0),TRTIME_MIN))+SUM(CONVERT(NUMERIC(18,0),STTIME_MIN))  AS Tot_Min  FROM webx_trip_ruttran GROUP BY RUTCD HAVING RUTCD='" + strRutCd.ToString().Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            Tot_Hour = dt.Rows[0]["Tot_Hour"].ToString();
            Tot_Min = dt.Rows[0]["Tot_Min"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public DataTable GetEnrouteExpense(string Route, string VehicleNo)
    {
        return ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_ENRoute_Details",
            new SqlParameter[] { new SqlParameter("@Route", Route),
                                 new SqlParameter("@VehicleNo", VehicleNo),
                                 new SqlParameter("@Location", SessionUtilities.CurrentBranchCode) });
    }
	
	public DataTable GetEnrouteExpenseVer1(string Route, string VehicleNo)
    {
        return ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_ENRoute_Details_Ver1",
            new SqlParameter[] { new SqlParameter("@Route", Route),
                                 new SqlParameter("@VehicleNo", VehicleNo),
                                 new SqlParameter("@Location", SessionUtilities.CurrentBranchCode) });
    }
	
    public DataTable GetEnrouteExpenseByTripSheetNo(string TripSheetNo)
    {
        return ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_ENRoute_Details_By_TripSheetNo",
            new SqlParameter[] { new SqlParameter("@TripSheetNo", TripSheetNo) });
    }
    public DataTable GetFinancialClosureByTripSheetNo(string TripSheetNo)
    {
        return ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_Financial_Closure_By_TripSheetNo",
            new SqlParameter[] { new SqlParameter("@TripSheetNo", TripSheetNo) });
    }
    public void CheckTripRule()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select *  From Webx_Fleet_Triprule");

        if (dt.Rows.Count > 0)
        {
            Vehicle_Selection = dt.Rows[0]["Vehicle_Selection"].ToString();
            End_Location = dt.Rows[0]["EndLocation"].ToString();
            SecondTrip_Approved = dt.Rows[0]["SecondTripApproved"].ToString();
            Driver1_Manual = dt.Rows[0]["Driver1_Manual"].ToString();
            Driver2_Manual = dt.Rows[0]["Driver2_Manual"].ToString();
            Trip_Route_Selection = dt.Rows[0]["Trip_Route_Selection"].ToString();
            THC_Attached = dt.Rows[0]["THC_Attached"].ToString().Trim();
            Vehicle_Filter = dt.Rows[0]["Vehicle_Filter"].ToString().Trim();
            UFL_Filter = dt.Rows[0]["UFL_Filter"].ToString().Trim();
            Auto_Vslip_Filter = dt.Rows[0]["Auto_Vslip_Filter"].ToString().Trim();
            ExternalUsage_Category = dt.Rows[0]["ExternalUsage_Category"].ToString().Trim();
            Fuel_Bill_Entry_TSWise = dt.Rows[0]["Fuel_Bill_Entry_TSWise"].ToString().Trim();
            VEHICLE_MODE = dt.Rows[0]["VEHICLE_MODE"].ToString().Trim();
            DOCKET_WITH_TRIPSHEET = dt.Rows[0]["DOCKET_WITH_TRIPSHEET"].ToString().Trim();
            LOCAL_CITY = dt.Rows[0]["LOCAL_CITY"].ToString().Trim();
            DOCKET_NO_LABEL = dt.Rows[0]["DOCKET_NO_LABEL"].ToString().Trim();
            TSWithVehicle_Valid = dt.Rows[0]["TSWithVehicle_Valid"].ToString().Trim();
            //TS_VehicleFilter_Loc = dt.Rows[0]["TS_VehicleFilter_Loc"].ToString().Trim();
            Driver_WO_Vehicle = dt.Rows[0]["Driver_WO_Vehicle"].ToString().Trim();
            THC_WO_Tripsheet = dt.Rows[0]["THC_WO_Tripsheet"].ToString().Trim();
            Checklist = dt.Rows[0]["Checklist"].ToString().Trim();
            Checklist_Mandatory = dt.Rows[0]["Checklist_Mandatory"].ToString().Trim();
            Driver_Photo_Rule = dt.Rows[0]["Driver_Photo_Rule"].ToString().Trim();
            Driver_License = dt.Rows[0]["Driver_License"].ToString().Trim();
            Settlement_Pending = dt.Rows[0]["Settlement_Pending"].ToString().Trim();
            Tot_Tripsheet = dt.Rows[0]["Tot_Tripsheet"].ToString().Trim();
            Retrieved_from_last_Trip = dt.Rows[0]["Retrieved_from_last_Trip"].ToString().Trim();
            Not_To_Be_Changed = dt.Rows[0]["Not_To_Be_Changed"].ToString().Trim();
            Editable_Can_Be_Change = dt.Rows[0]["Editable_Can_Be_Change"].ToString().Trim();
            Diff_Bet_CloseKM_StartKM = dt.Rows[0]["Diff_Bet_CloseKM_StartKM"].ToString().Trim();
            CloseKM_Greater_Than_StartKM = dt.Rows[0]["CloseKM_Greater_Than_StartKM"].ToString().Trim();
            Trip_Closure_Not_Zero = dt.Rows[0]["Trip_Closure_Not_Zero"].ToString().Trim();
            Trip_Closure_Zero = dt.Rows[0]["Trip_Closure_Zero"].ToString().Trim();
            Fuel_Bill_Entry_Trip_Date = dt.Rows[0]["Fuel_Bill_Entry_Trip_Date"].ToString().Trim();
            Fuel_Bill_Entry_Trip_Close_Date = dt.Rows[0]["Fuel_Bill_Entry_Trip_Close_Date"].ToString().Trim();
            Fuel_Bill_Entry_Trip_settlement_Date = dt.Rows[0]["Fuel_Bill_Entry_Trip_settlement_Date"].ToString().Trim();
            Advance_Entry_Settlement_Not_Done = dt.Rows[0]["Advance_Entry_Settlement_Not_Done"].ToString().Trim();
            Advance_Entry_Tripsheet_Not_Closed = dt.Rows[0]["Advance_Entry_Tripsheet_Not_Closed"].ToString().Trim();
            TripSheet_Name = dt.Rows[0]["TripSheet_Name"].ToString().Trim();
            JobSheet_Name = dt.Rows[0]["JobSheet_Name"].ToString().Trim();
            //TripSheet_DateRule = dt.Rows[0]["TripSheet_DateRule"].ToString().Trim();
            //TripAdvance_DateRule_3Days = dt.Rows[0]["TripAdvance_DateRule_3Days"].ToString().Trim();
            //TripAdvance_DateRule_Equals_Tripsheet = dt.Rows[0]["TripAdvance_DateRule_Equals_Tripsheet"].ToString().Trim();
            DriverSettlmt_DateRule_2Days = dt.Rows[0]["DriverSettlmt_DateRule_2Days"].ToString().Trim();
            DriverSettlmt_DateRule_Equals_CloseDate = dt.Rows[0]["DriverSettlmt_DateRule_Equals_CloseDate"].ToString().Trim();
            DriverSettlmt_DateRule_Equals_LastAdvanceDate = dt.Rows[0]["DriverSettlmt_DateRule_Equals_LastAdvanceDate"].ToString().Trim();
            TripSheet_Cancel = dt.Rows[0]["TripSheet_Cancel"].ToString().Trim();
            TripSheet_Row = dt.Rows[0]["TripSheet_Row"].ToString().Trim();

            Driver2_Photo_Rule = dt.Rows[0]["Driver2_Photo_Rule"].ToString().Trim();
            Driver2_License = dt.Rows[0]["Driver2_License"].ToString().Trim();
            Driver2_Mandetory = dt.Rows[0]["Driver2_Mandetory"].ToString().Trim();
            Cleaner_Mandetory = dt.Rows[0]["Cleaner_Mandetory"].ToString().Trim();
            Driver2_With_LocationFilter = dt.Rows[0]["Driver2_With_LocationFilter"].ToString().Trim();
            Diesel_CF = dt.Rows[0]["Diesel_CF"].ToString().Trim();
            IOCL_YN = dt.Rows[0]["IOCL_YN"].ToString().Trim();
            Driver1NTFM = dt.Rows[0]["Driver1NTFM"].ToString().Trim();
            Driver2NTFM = dt.Rows[0]["Driver2NTFM"].ToString().Trim();
            CleanerNTFM = dt.Rows[0]["CleanerNTFM"].ToString().Trim();
            FUEL_SLIP_PROVIDED = dt.Rows[0]["FUEL_SLIP_PROVIDED"].ToString().Trim();

            Trip_Billing = dt.Rows[0]["Trip_Billing"].ToString().Trim();
            Trip_Billing_wise = dt.Rows[0]["Trip_Billing_wise"].ToString().Trim();
            TripLogFromMaster = dt.Rows[0]["TripLogFromMaster"].ToString().Trim();
            FuelDetailsFromMaster = dt.Rows[0]["FuelDetailsFromMaster"].ToString().Trim();


            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void UpdateTripRule()
    {
        SqlParameter[] prm = new SqlParameter[43];

        prm[0] = new SqlParameter("@Vehicle_Selection", Vehicle_Selection);
        prm[1] = new SqlParameter("@Driver1_Manual", Driver1_Manual);
        prm[2] = new SqlParameter("@Driver2_Manual", Driver2_Manual);
        prm[3] = new SqlParameter("@Trip_Route_Selection", Trip_Route_Selection);
        prm[4] = new SqlParameter("@THC_Attached", THC_Attached);
        prm[5] = new SqlParameter("@Enter_By", Enter_By);
        prm[6] = new SqlParameter("@Vehicle_Filter", Vehicle_Filter);
        prm[7] = new SqlParameter("@UFL_Filter", UFL_Filter);
        prm[8] = new SqlParameter("@Auto_Vslip_Filter", Auto_Vslip_Filter);
        prm[9] = new SqlParameter("@ExternalUsage_Category", ExternalUsage_Category);
        prm[10] = new SqlParameter("@Fuel_Bill_Entry_TSWise", Fuel_Bill_Entry_TSWise);
        prm[11] = new SqlParameter("@VEHICLE_MODE", VEHICLE_MODE);
        prm[12] = new SqlParameter("@DOCKET_WITH_TRIPSHEET", DOCKET_WITH_TRIPSHEET);
        prm[13] = new SqlParameter("@LOCAL_CITY", LOCAL_CITY);
        prm[14] = new SqlParameter("@DOCKET_NO_LABEL", DOCKET_NO_LABEL);
        prm[15] = new SqlParameter("@TSWithVehicle_Valid", TSWithVehicle_Valid);
        //prm[16] = new SqlParameter("@TS_VehicleFilter_Loc", TS_VehicleFilter_Loc);
        prm[16] = new SqlParameter("@Driver_WO_Vehicle", Driver_WO_Vehicle);
        prm[17] = new SqlParameter("@THC_WO_Tripsheet", THC_WO_Tripsheet);
        prm[18] = new SqlParameter("@Checklist", Checklist);
        prm[19] = new SqlParameter("@Checklist_Mandatory", Checklist_Mandatory);
        prm[20] = new SqlParameter("@Driver_Photo_Rule", Driver_Photo_Rule);
        prm[21] = new SqlParameter("@Driver_License", Driver_License);
        prm[22] = new SqlParameter("@Settlement_Pending", Settlement_Pending);
        prm[23] = new SqlParameter("@Tot_Tripsheet", Tot_Tripsheet);
        prm[24] = new SqlParameter("@Retrieved_from_last_Trip", Retrieved_from_last_Trip);
        prm[25] = new SqlParameter("@Not_To_Be_Changed", Not_To_Be_Changed);
        prm[26] = new SqlParameter("@Editable_Can_Be_Change", Editable_Can_Be_Change);
        prm[27] = new SqlParameter("@Diff_Bet_CloseKM_StartKM", Diff_Bet_CloseKM_StartKM);
        prm[28] = new SqlParameter("@CloseKM_Greater_Than_StartKM", CloseKM_Greater_Than_StartKM);
        prm[29] = new SqlParameter("@Trip_Closure_Not_Zero", Trip_Closure_Not_Zero);
        prm[30] = new SqlParameter("@Trip_Closure_Zero", Trip_Closure_Zero);
        prm[31] = new SqlParameter("@Fuel_Bill_Entry_Trip_Date", Fuel_Bill_Entry_Trip_Date);
        prm[32] = new SqlParameter("@Fuel_Bill_Entry_Trip_Close_Date", Fuel_Bill_Entry_Trip_Close_Date);
        prm[33] = new SqlParameter("@Fuel_Bill_Entry_Trip_settlement_Date", Fuel_Bill_Entry_Trip_settlement_Date);
        prm[34] = new SqlParameter("@Advance_Entry_Settlement_Not_Done", Advance_Entry_Settlement_Not_Done);
        prm[35] = new SqlParameter("@Advance_Entry_Tripsheet_Not_Closed", Advance_Entry_Tripsheet_Not_Closed);
        prm[36] = new SqlParameter("@TripSheet_Name", TripSheet_Name);
        prm[37] = new SqlParameter("@JobSheet_Name", JobSheet_Name);
        //prm[38] = new SqlParameter("@TripSheet_DateRule", TripSheet_DateRule);
        //prm[39] = new SqlParameter("@TripAdvance_DateRule_3Days", TripAdvance_DateRule_3Days);
        //prm[40] = new SqlParameter("@TripAdvance_DateRule_Equals_Tripsheet", TripAdvance_DateRule_Equals_Tripsheet);
        prm[38] = new SqlParameter("@DriverSettlmt_DateRule_2Days", DriverSettlmt_DateRule_2Days);
        prm[39] = new SqlParameter("@DriverSettlmt_DateRule_Equals_CloseDate", DriverSettlmt_DateRule_Equals_CloseDate);
        prm[40] = new SqlParameter("@DriverSettlmt_DateRule_Equals_LastAdvanceDate", DriverSettlmt_DateRule_Equals_LastAdvanceDate);
        prm[41] = new SqlParameter("@SecondTripApproved", SecondTrip_Approved);
        prm[42] = new SqlParameter("@EndLocation", End_Location);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_Webx_Fleet_Triprule", prm);
    }
    //public void CheckTripRule()
    //{
    //    DataTable dt = new DataTable();
    //    dt = ExecuteDataTable(CommandType.Text, "Select *  From Webx_Fleet_Triprule");

    //    if (dt.Rows.Count > 0)
    //    {
    //        Vehicle_Selection = dt.Rows[0]["Vehicle_Selection"].ToString();
    //        Driver1_Manual = dt.Rows[0]["Driver1_Manual"].ToString();
    //        Driver2_Manual = dt.Rows[0]["Driver2_Manual"].ToString();
    //        Trip_Route_Selection = dt.Rows[0]["Trip_Route_Selection"].ToString();
    //        THC_Attached = dt.Rows[0]["THC_Attached"].ToString().Trim();
    //        Vehicle_Filter = dt.Rows[0]["Vehicle_Filter"].ToString().Trim();
    //        UFL_Filter = dt.Rows[0]["UFL_Filter"].ToString().Trim();
    //        Auto_Vslip_Filter = dt.Rows[0]["Auto_Vslip_Filter"].ToString().Trim();
    //        ExternalUsage_Category = dt.Rows[0]["ExternalUsage_Category"].ToString().Trim();
    //        Fuel_Bill_Entry_TSWise = dt.Rows[0]["Fuel_Bill_Entry_TSWise"].ToString().Trim();
    //        VEHICLE_MODE = dt.Rows[0]["VEHICLE_MODE"].ToString().Trim();
    //        DOCKET_WITH_TRIPSHEET = dt.Rows[0]["DOCKET_WITH_TRIPSHEET"].ToString().Trim();
    //        LOCAL_CITY = dt.Rows[0]["LOCAL_CITY"].ToString().Trim();
    //        DOCKET_NO_LABEL = dt.Rows[0]["DOCKET_NO_LABEL"].ToString().Trim();
    //        TSWithVehicle_Valid = dt.Rows[0]["TSWithVehicle_Valid"].ToString().Trim();
    //        //TS_VehicleFilter_Loc = dt.Rows[0]["TS_VehicleFilter_Loc"].ToString().Trim();
    //        Driver_WO_Vehicle = dt.Rows[0]["Driver_WO_Vehicle"].ToString().Trim();
    //        THC_WO_Tripsheet = dt.Rows[0]["THC_WO_Tripsheet"].ToString().Trim();
    //        Checklist = dt.Rows[0]["Checklist"].ToString().Trim();
    //        Checklist_Mandatory = dt.Rows[0]["Checklist_Mandatory"].ToString().Trim();

    //        IsRecordFound = true;
    //    }
    //    else
    //    {
    //        IsRecordFound = false;
    //    }
    //}

    //public void UpdateTripRule()
    //{
    //    SqlParameter[] prm = new SqlParameter[20];

    //    prm[0] = new SqlParameter("@Vehicle_Selection", Vehicle_Selection);
    //    prm[1] = new SqlParameter("@Driver1_Manual", Driver1_Manual);
    //    prm[2] = new SqlParameter("@Driver2_Manual", Driver2_Manual);
    //    prm[3] = new SqlParameter("@Trip_Route_Selection", Trip_Route_Selection);
    //    prm[4] = new SqlParameter("@THC_Attached", THC_Attached);
    //    prm[5] = new SqlParameter("@Enter_By", Enter_By);
    //    prm[6] = new SqlParameter("@Vehicle_Filter", Vehicle_Filter);
    //    prm[7] = new SqlParameter("@UFL_Filter", UFL_Filter);
    //    prm[8] = new SqlParameter("@Auto_Vslip_Filter", Auto_Vslip_Filter);
    //    prm[9] = new SqlParameter("@ExternalUsage_Category", ExternalUsage_Category);
    //    prm[10] = new SqlParameter("@Fuel_Bill_Entry_TSWise", Fuel_Bill_Entry_TSWise);
    //    prm[11] = new SqlParameter("@VEHICLE_MODE", VEHICLE_MODE);
    //    prm[12] = new SqlParameter("@DOCKET_WITH_TRIPSHEET", DOCKET_WITH_TRIPSHEET);
    //    prm[13] = new SqlParameter("@LOCAL_CITY", LOCAL_CITY);
    //    prm[14] = new SqlParameter("@DOCKET_NO_LABEL", DOCKET_NO_LABEL);
    //    prm[15] = new SqlParameter("@TSWithVehicle_Valid", TSWithVehicle_Valid);
    //    //prm[16] = new SqlParameter("@TS_VehicleFilter_Loc", TS_VehicleFilter_Loc);
    //    prm[16] = new SqlParameter("@Driver_WO_Vehicle", Driver_WO_Vehicle);
    //    prm[17] = new SqlParameter("@THC_WO_Tripsheet", THC_WO_Tripsheet);
    //    prm[18] = new SqlParameter("@Checklist", Checklist);
    //    prm[19] = new SqlParameter("@Checklist_Mandatory", Checklist_Mandatory);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_Webx_Fleet_Triprule", prm);
    //}
    public void BindDropDown(DropDownList ddl, string strSQL)
    {
        // = "select * from WEBX_FLEET_DRIVERMST where ActiveFlag='Y'  and (Driver_Status='Available' OR Driver_Status is null) Order by Driver_Name";
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, strSQL);
    }
    public DataTable ExecuteSql(string strSQL)
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, strSQL);
        return dt;
    }
    public void GetDockets(CheckBoxList ChkLst)
    {
        DataSet ds = new DataSet();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ds = ExecuteDataSet(CommandType.Text, "declare @DOCKNO varchar(8000)  select @DOCKNO='' select @DOCKNO=@DOCKNO+','+ isnull(DOCKNO,'') from webx_fleet_Vehicle_issue select DOCKNO as [Value],DOCKNO as [Text] from Webx_Master_Docket Where PAYBAS='P05' And DOCKNO not in (select items from split(@DOCKNO,','))");

        ChkLst.DataSource = ds;

        ChkLst.DataTextField = "Text";
        ChkLst.DataValueField = "Value";

        ChkLst.DataBind();
    }

    public void ExecuteNonQry(string strSQL)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ExecuteNonQuery(CommandType.Text, strSQL);
    }

    public void GetVehicleDetails()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select (Select Type_Name  From Webx_Vehicle_Type  where Type_Code=Vehicle_Type) as Type_Name, isnull(Current_Km_Read,0) as Current_Km_Read,(Select VendorName From webx_VENDOR_HDR Where VendorCode=webx_vehicle_hdr.VendorCode) as VendorName From Webx_VEHICLE_HDR Where VEHNO='" + Vehicle_No.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Vehicle_Type = dt.Rows[0]["Type_Name"].ToString();
            Current_Km_Read = dt.Rows[0]["Current_Km_Read"].ToString();
            Vendor_Name = dt.Rows[0]["VendorName"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }


    private string _Driver_Photo, _Trip_Count;

    public string Driver_Photo { get { return _Driver_Photo; } set { _Driver_Photo = value; } }
    public string Trip_Count { get { return _Trip_Count; } set { _Trip_Count = value; } }

    public void GetDriverDetails()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Driver_Id", Driver_Id);
        //prm[1] = new SqlParameter("@VEHNO", Vehicle_No);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_GetDriverDetails_New_TS", prm);
        //dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_Fleet_New_GetDriverDetails_New_TS", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Driver_Name = dt.Rows[0]["Driver_Name"].ToString();
            License_No = dt.Rows[0]["License_No"].ToString();
            Valdity_dt = dt.Rows[0]["Valdity_dt"].ToString();
            Manual_Driver_Code = dt.Rows[0]["Manual_Driver_Code"].ToString();
            Driver_Photo = dt.Rows[0]["Driver_Photo"].ToString();
            Trip_Count = dt.Rows[0]["Trip_Count"].ToString();
            Driving_lic_File = dt.Rows[0]["Driving_lic_File"].ToString();
            Driver_Type_ID = dt.Rows[0]["Driver_Type_ID"].ToString();
            Driver_Status = dt.Rows[0]["Driver_Status"].ToString();
            License_Verified = dt.Rows[0]["License_Verified"].ToString();
            LicenseValditydtTripValidation = dt.Rows[0]["LicenseValditydtTripValidation"].ToString();
            LicenseVerifiedDtTripValidation = dt.Rows[0]["LicenseVerifiedDtTripValidation"].ToString();
            DriverCashTripValidation = dt.Rows[0]["DriverCashTripValidation"].ToString();
            License_Verified_Dt = dt.Rows[0]["License_Verified_Dt"].ToString();
            DriverLicenseDays = dt.Rows[0]["DriverLicenseDays"].ToString();
            DriverLicVerificationDays = dt.Rows[0]["DriverLicVerificationDays"].ToString();
            Flag = dt.Rows[0]["Flag"].ToString();
            RequestID = dt.Rows[0]["RequestID"].ToString();
            RequestApprovedDriverLicenseDate = dt.Rows[0]["RequestApprovedDriverLicenseDate"].ToString();
            RequestApprovedDriverLicenseVerificationDate = dt.Rows[0]["RequestApprovedDriverLicenseVerificationDate"].ToString();
            RequestApprovedDriverCashVerificationDate = dt.Rows[0]["RequestApprovedDriverCashVerificationDate"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }


    public void GetDriverDetailsVehicleWise()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Driver_Id", Driver_Id);
        //prm[1] = new SqlParameter("@VEHNO", Vehicle_No);

        //dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_GetDriverDetails_New_TS", prm);
        dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_Fleet_New_GetDriverDetails_New_TS", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Driver_Name = dt.Rows[0]["Driver_Name"].ToString();
            VEHNO = dt.Rows[0]["VEHNO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckCityName()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select Location from webx_Citymaster Where activeflag='Y' And Location='" + City_Name.Trim() + "'");
        if (dt.Rows.Count > 0) { City_Name = dt.Rows[0][0].ToString(); IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckDriver1ManualCode()
    {
        DataTable dt = new DataTable();

        //dt = ExecuteDataTable(CommandType.Text, "select * from VW_FLEET_DRIVER_PHOTO_LIC_CHECK where MANUAL_DRIVER_CODE='" + Manual_Driver_Code.ToString().Trim() + "' group by License_No,Valdity_dt,Driver_Id,Driver_Name,MANUAL_DRIVER_CODE,Driver_Status,Driver_Photo,Trip_Count ORDER BY License_No,Valdity_dt,Driver_Id,Driver_Name,MANUAL_DRIVER_CODE,Driver_Status,Driver_Photo,Trip_Count");
        dt = ExecuteDataTable(CommandType.Text, "select * from VW_FLEET_DRIVER_PHOTO_LIC_CHECK where MANUAL_DRIVER_CODE='" + Manual_Driver_Code.ToString().Trim() + "' group by License_No,Valdity_dt,Driver_Id,Driver_Name,MANUAL_DRIVER_CODE,Driver_Status,Driver_Photo,Trip_Count,License_Verified ORDER BY License_No,Valdity_dt,Driver_Id,Driver_Name,MANUAL_DRIVER_CODE,Driver_Status,Driver_Photo,Trip_Count,License_Verified");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Driver_Id = dt.Rows[0]["Driver_Id"].ToString();
            Manual_Driver_Code = dt.Rows[0]["MANUAL_DRIVER_CODE"].ToString();
            Driver_Name = dt.Rows[0]["Driver_Name"].ToString();
            License_No = dt.Rows[0]["License_No"].ToString();
            Valdity_dt = dt.Rows[0]["Valdity_dt"].ToString();
            Driver_Status = dt.Rows[0]["Driver_Status"].ToString();
            Driver_Photo = dt.Rows[0]["Driver_Photo"].ToString();
            Trip_Count = dt.Rows[0]["Trip_Count"].ToString();
            VSlipNo = dt.Rows[0]["VSlipNo"].ToString();
            License_Verified = dt.Rows[0]["License_Verified"].ToString();


        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void BindCheckList(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.Text, "Select * from VW_Fleet_CheckList_Module");
    }
    public void GetCnoteDetails()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT A.DOCKNO,Convert(varchar,A.DOCKDT,106) as DOCKDT,(A.ORGNCD + ' - ' + A.DESTCD) AS Org_Dest,A.PKGSNO,A.ACTUWT,A.CHRGWT,B.SubTotal,B.DKTTOT FROM WebX_Master_Docket A inner join WebX_Master_Docket_Charges B on A.DOCKNO = B.DOCKNO where A.DOCKNO='" + DOCKNO.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            DOCKNO = dt.Rows[0]["DOCKNO"].ToString();
            DOCKDT = dt.Rows[0]["DOCKDT"].ToString();
            Org_Dest = dt.Rows[0]["Org_Dest"].ToString();
            PKGSNO = dt.Rows[0]["PKGSNO"].ToString();
            ACTUWT = dt.Rows[0]["ACTUWT"].ToString();
            CHRGWT = dt.Rows[0]["CHRGWT"].ToString();
            SubTotal = dt.Rows[0]["SubTotal"].ToString();
            DKTTOT = dt.Rows[0]["DKTTOT"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetVehicleDetails_New()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT * FROM VW_FLEET_TRIP_NEW_VEHICLE_DETAILS Where VEHNO='" + Vehicle_No.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            CONRTL_BRANCH = dt.Rows[0]["CONRTL_BRANCH"].ToString();
            MODEL = dt.Rows[0]["MODEL"].ToString();
            CATEGORY = dt.Rows[0]["CATEGORY"].ToString();
            CAPACITY = dt.Rows[0]["CAPACITY"].ToString();
            Current_Km_Read = dt.Rows[0]["CURRENT_KM_READ"].ToString();
            DIESEL_AMT_CF = dt.Rows[0]["DIESEL_AMT_CF"].ToString();
            DIESEL_QTY_CF = dt.Rows[0]["DIESEL_QTY_CF"].ToString();
            AddBlue_AMT_CF = dt.Rows[0]["AddBlue_AMT_CF"].ToString();
            AddBlue_QTY_CF = dt.Rows[0]["AddBlue_QTY_CF"].ToString();
            CURLOC = dt.Rows[0]["CURLOC"].ToString();
            Vehicle_Status = dt.Rows[0]["Vehicle_Status"].ToString();
            Vendor_Name = dt.Rows[0]["VENDORNAME"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetVehicleDetails_New_Ver1()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT * FROM VW_FLEET_TRIP_NEW_VEHICLE_DETAILS_FA Where VEHNO='" + Vehicle_No.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            CONRTL_BRANCH = dt.Rows[0]["CONRTL_BRANCH"].ToString();
            MODEL = dt.Rows[0]["MODEL"].ToString();
            CATEGORY = dt.Rows[0]["CATEGORY"].ToString();
            CAPACITY = dt.Rows[0]["CAPACITY"].ToString();
            Current_Km_Read = dt.Rows[0]["CURRENT_KM_READ"].ToString();
            DIESEL_AMT_CF = dt.Rows[0]["DIESEL_AMT_CF"].ToString();
            DIESEL_QTY_CF = dt.Rows[0]["DIESEL_QTY_CF"].ToString();
            AddBlue_AMT_CF = dt.Rows[0]["AddBlue_AMT_CF"].ToString();
            AddBlue_QTY_CF = dt.Rows[0]["AddBlue_QTY_CF"].ToString();
            CURLOC = dt.Rows[0]["CURLOC"].ToString();
            Vehicle_Status = dt.Rows[0]["Vehicle_Status"].ToString();
            Vendor_Name = dt.Rows[0]["VENDORNAME"].ToString();
            Insurance_Validity_Date = dt.Rows[0]["Insurance_Validity_Date"].ToString();
            Fitness_Validity_Date = dt.Rows[0]["Fitness_Validity_Date"].ToString();
            RoadTaxDt = dt.Rows[0]["RoadTaxDt"].ToString();
            NationalPermitDt = dt.Rows[0]["NationalPermitDt"].ToString();
            InsuranceValidityDateTripValidation = dt.Rows[0]["InsuranceValidityDateTripValidation"].ToString();
            FitnessValidityDateTripValidation = dt.Rows[0]["FitnessValidityDateTripValidation"].ToString();
            NationalPermitDtTripValidation = dt.Rows[0]["NationalPermitDtTripValidation"].ToString();
            RoadTaxDtTripValidation = dt.Rows[0]["RoadTaxDtTripValidation"].ToString();
            FiveYearPermitDtTripValidation = dt.Rows[0]["FiveYearPermitDtTripValidation"].ToString();
            DieselLtrsTripValidation = dt.Rows[0]["DieselLtrsTripValidation"].ToString();
            FiveYearPermitDt = dt.Rows[0]["FiveYearPermitDt"].ToString();
            InsuranceDays = dt.Rows[0]["InsuranceDays"].ToString();
            FitnessDays = dt.Rows[0]["FitnessDays"].ToString();
            NationalPermitDays = dt.Rows[0]["NationalPermitDays"].ToString();
            RoadTaxDays = dt.Rows[0]["RoadTaxDays"].ToString();
            FiveYearPermitDays = dt.Rows[0]["FiveYearPermitDays"].ToString();
            Flag = dt.Rows[0]["Flag"].ToString();
            RequestID = dt.Rows[0]["RequestID"].ToString();
            RequestApprovedInsuranceDate = dt.Rows[0]["RequestApprovedInsuranceDate"].ToString();
            RequestApprovedFitnessDate = dt.Rows[0]["RequestApprovedFitnessDate"].ToString();
            RequestApprovedNationalDate = dt.Rows[0]["RequestApprovedNationalDate"].ToString();
            RequestApprovedRoadDate = dt.Rows[0]["RequestApprovedRoadDate"].ToString();
            RequestApprovedFiveYearDate = dt.Rows[0]["RequestApprovedFiveYearDate"].ToString();
            TripSheetNumber = dt.Rows[0]["TripSheetNumber"].ToString();
            TripSheetDate = dt.Rows[0]["TripSheetDate"].ToString();
            TripSheetOCloseDate = dt.Rows[0]["TripSheetOCloseDate"].ToString();
            TripSheetCount = dt.Rows[0]["TripSheetCount"].ToString();
            RequestDieselLtr = dt.Rows[0]["RequestDieselLtr"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    //************* Mayank ********************
    public void GetTripsheetVehicleDetails()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT VSlipNo, convert(varchar, VSlipDt, 103) as VSlipDt  from WEBX_FLEET_VEHICLE_ISSUE Where VehicleNo='" + Vehicle_No.Trim() + "'AND Oper_Close_Dt IS NULL order by VSlipDt desc");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TripNo = dt.Rows[0]["VSlipNo"].ToString();
            TripDate = dt.Rows[0]["VSlipDt"].ToString();

            //VEHNO = dt.Rows[0]["VEHNO"].ToString();
            //CONRTL_BRANCH = dt.Rows[0]["CONRTL_BRANCH"].ToString();
            //MODEL = dt.Rows[0]["MODEL"].ToString();
            //CATEGORY = dt.Rows[0]["CATEGORY"].ToString();
            //CAPACITY = dt.Rows[0]["CAPACITY"].ToString();
            //Current_Km_Read = dt.Rows[0]["CURRENT_KM_READ"].ToString();
            //DIESEL_AMT_CF = dt.Rows[0]["DIESEL_AMT_CF"].ToString();
            //DIESEL_QTY_CF = dt.Rows[0]["DIESEL_QTY_CF"].ToString();
            //CURLOC = dt.Rows[0]["CURLOC"].ToString();
            //Vehicle_Status = dt.Rows[0]["Vehicle_Status"].ToString();
            //Vendor_Name = dt.Rows[0]["VENDORNAME"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    //*****************************************

    public void GetFuelSlipNo()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "SELECT TRIPSHEETNO,FUELSLIPNO,SRNO FROM WEBX_FLEET_TRIPSHEET_FUEL_SLIPNO WHERE FUELSLIPNO='" + FuelSlipNo.ToString().Trim() + "' and SRNO<>'" + SRNO.ToString().Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            FuelSlipNo = dt.Rows[0]["FUELSLIPNO"].ToString();
            TripSheetNo = dt.Rows[0]["TRIPSHEETNO"].ToString();
            SRNO = dt.Rows[0]["SRNO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetOperCloseDate(string VEHNO)
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "SELECT top 1 (convert(varchar, oper_close_dt, 103) + LEFT(RIGHT(convert(varchar, oper_close_dt, 100), 8), 6) + ' ' + RIGHT(convert(varchar, oper_close_dt, 100), 2)) as oper_close_dt,convert(varchar,oper_close_dt,103) as oper_close_dt2,convert(varchar,oper_close_dt + 1,103) as oper_close_dt3,substring(convert(varchar(14), oper_close_dt, 9), 13, 5) as Hour_Time,substring(convert(varchar(17), oper_close_dt, 9), 16, 5) + 01 as Minute_Time,substring(convert(varchar(30), oper_close_dt, 9), 25, 2) as AM_PM_Time FROM WEBX_FLEET_VEHICLE_ISSUE where oper_close_dt is not null and vehicleno='" + VEHNO.ToString().Trim() + "' order by WEBX_FLEET_VEHICLE_ISSUE.oper_close_dt desc");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            oper_close_dt = dt.Rows[0]["oper_close_dt"].ToString();
            oper_close_dt2 = dt.Rows[0]["oper_close_dt2"].ToString();
            oper_close_dt3 = dt.Rows[0]["oper_close_dt3"].ToString();
            Hour_Time = dt.Rows[0]["Hour_Time"].ToString();
            Minute_Time = dt.Rows[0]["Minute_Time"].ToString();
            AM_PM_Time = dt.Rows[0]["AM_PM_Time"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void BindLegID(DropDownList ddl, string mmTripSheetNo)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@tripsheetno", mmTripSheetNo);

        dcm.DataBind(ddl, CommandType.StoredProcedure, "USP_FLEET_NEW_LEG_TYPE_CNOTE", prm);
    }
    public void BindGridEtNo(GridView gvEtNo, string EtNo)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@EtNo", EtNo);
        wcb.DataBind(gvEtNo, CommandType.StoredProcedure, "UspFleetBindEtNo", prm);
    }
}

// <summary>
/// Summary description for PushVehicleDriverRequest
/// </summary>
[DataContract]
public class PushVehicleDriverRequest : Base
{
    [DataMember]
    public string RequestID { get; set; }
    [DataMember]
    public int RequestOrder { get; set; }
    [DataMember]
    public string RequestDate { get; set; }
    [DataMember]
    public string RequestType { get; set; }
    [DataMember]
    public string Branch { get; set; }
    [DataMember]
    public string ControllingLocation { get; set; }
    [DataMember]
    public string IsCancelled { get; set; }
    [DataMember]
    public string RejectedBy { get; set; }
    [DataMember]
    public string VehicleDriverID { get; set; }
    [DataMember]
    public string DocumentName { get; set; }
    [DataMember]
    public string ExpiryDate { get; set; }
    [DataMember]
    public string GraceDays { get; set; }
    [DataMember]
    public string NewExpiryDate { get; set; }
    [DataMember]
    public string NewGraceDays { get; set; }
    [DataMember]
    public string Value { get; set; }
    [DataMember]
    public string NewValue { get; set; }
    [DataMember]
    public bool IsValidate { get; set; }
    [DataMember]
    public string ValidatedBy { get; set; }
    [DataMember]
    public string Document { get; set; }
    [DataMember]
    public string ForcedYN { get; set; }
    [DataMember]
    public string Remarks { get; set; }

    #region Constructor
    public PushVehicleDriverRequest()
    {

    }
    #endregion

    public List<PushVehicleDriverRequest> Details { get; set; }

    /// <summary>
    /// Vehicle Driver Request Insert
    /// </summary>
    public string VehicleDriverRequestInsert(List<PushVehicleDriverRequest> listPushVehicleDriverRequestDataJson)
    {
        var sResult = "";
        using (var oWh = new WebXHelper())
        {
            oWh.BeginTransaction();
            try
            {
                sResult = (string)oWh.ExecuteScalar("Usp_Webx_Fleet_Request_Approval_Insert", new[]
                                    {
                                        new SqlParameter("@XmlData", XmlUtility.XmlSerializeToString(listPushVehicleDriverRequestDataJson)),
                                        new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID),
                                        new SqlParameter("@Location", SessionUtilities.CurrentBranchCode),
                                        new SqlParameter("@FinYear", SessionUtilities.FinYear)
                                    });
                oWh.CommitTransaction();
            }
            catch (Exception ex)
            {
                oWh.RollBackTransaction();
                sResult = "Error: " + ex.Message;
              
            }
        }
        return sResult;
    }
    /// <summary>
    /// Get Repuest for Cancellation and Aprroval
    /// </summary>
    /// <param name="stFromDate"></param>
    /// <param name="stToDate"></param>
    /// <param name="stLocation"></param>
    /// <returns></returns>
    public DataTable GetListingForCancellation(string stFromDate, string stToDate, string stLocation)
    {
        return ExecuteDataTable("Usp_Listing_Request_Details_Cancellation",
            new SqlParameter[] { new SqlParameter("@FromDate", stFromDate),
                                 new SqlParameter("@ToDate", stToDate),
                                 new SqlParameter("@Location", stLocation) });
    }
    /// <summary>
    /// Get Repuest for Cancellation and Aprroval on Request No
    /// </summary>
    /// <param name="stFromDate"></param>
    /// <param name="stToDate"></param>
    /// <param name="stLocation"></param>
    /// <returns></returns>
    public DataTable GetListingForCancellationonRequestNo(string stRequestNo)
    {
        return ExecuteDataTable("Usp_Listing_Request_Details_Cancellation_On_RequestNo",
            new SqlParameter[] { new SqlParameter("@RequestNo", stRequestNo) });
    }
    /// <summary>
    /// Vehicle Driver Request Insert
    /// </summary>
    public string VehicleDriverRequestUpdate(List<PushVehicleDriverRequest> listPushVehicleDriverRequest)
    {
        var sResult = "";
        using (var oWh = new WebXHelper())
        {
            oWh.BeginTransaction();
            try
            {
                sResult = (string)oWh.ExecuteScalar("Usp_Webx_Fleet_Request_Approval_Update", new[]
                                    {
                                        new SqlParameter("@XmlData", XmlUtility.XmlSerializeToString(listPushVehicleDriverRequest)),
                                        new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
                                    });
                oWh.CommitTransaction();
            }
            catch (Exception ex)
            {
                oWh.RollBackTransaction();
                throw ex;
            }
        }
        return sResult;
    }
    /// <summary>
    /// Cancel Request
    /// </summary>
    public string CancelRequest(string stRequestNumber)
    {
        string stRequestNo = string.Empty;
        try
        {
            stRequestNo = InsertHelper("Request", "USP_Cancel_Vehicle_Driver_Request",
                new SqlParameter[] {new SqlParameter("@RequestID", stRequestNumber),
                                    new SqlParameter("@CancelledBy", SessionUtilities.CurrentEmployeeID) });
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "Request Cancellation");
        }
        return stRequestNo;
    }
    /// <summary>
    /// List Reuest Approved
    /// </summary>
    /// <param name="stRequestNo"></param>
    /// <returns></returns>
    public DataTable GetListingForCancellationonRequestNo(string stRequestNo, string stRequestOrder, string Flag)
    {
        return ExecuteDataTable("Usp_List_Request_Approval_Cancel_Done",
            new SqlParameter[] { new SqlParameter("@RequestNo", stRequestNo),
            new SqlParameter("@RequestOrder", stRequestOrder),
            new SqlParameter("@Flag", Flag)});
    }
}