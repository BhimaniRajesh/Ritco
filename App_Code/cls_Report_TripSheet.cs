using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for cls_Report_JobsheeetRegister
/// </summary>
public class cls_Report_TripSheet
{

    public static string strCompany="",strTripsheetNo = "", strTripsheetStartDate = "", strTripsheetEndDate = "", strStartLocation = "";
    public static string strEndLocation = "", strFromCity = "", strToCity = "", strCategory = "", strTotalKms = "", strVehicleNo = "";
    public static string strVehicleCateGory = "", strDriverName = "", strStatus = "", strStartingKM = "";
    public static string strClosingKM = "", strTotalKM = "", strApprovedKMPL = "", strActualKMPL = "";
    public static string strDieselQuantity = "", strBillPrepared = "", strBillNo = "", strThcAttached = "";
    public static string strCustomername = "", strTotalTHCAmount = "";

    public static string strRTO = "", strBorderCheckPost = "", strToll = "", strSalesTaxseal = "";
    public static string strEscorts = "", strOctroi = "", strLoading = "", strUnloading = "";
    public static string strEnrouteRapairs = "", strPenalty = "", strTyrePuncture = "", strWeighBridgeExpenses = "";
    public static string strParking = "", strTelephone = "", strTemporaryPermit = "", strDriverDailyAllowance = ""; 
    public static string strIncentivePayable = "", strOtherExpense = "", strBrokerCommission = "";

    public static string strAdvance = "", strRepair = "", strClaims = "", strFuel = "", strIncded = "", strSpare = "";

    public static string strTRIPSHEET_INCOME="",strACTUAL_EXP = "", strACTUAL_LOADUNLOAD = "", strACTUAL_BROKERAGE = "", strACTUAL_REPAIR = "";
    public static  string strACTUAL_OCTROI = "", strACTUAL_DRIVERALLOWANCE = "", strACTUAL_ClaimsAmt = "", strACTUAL_TOT_EXP = "";

    public static string strDateFrom="",strDateTo = "", strStatus1 = "", strBranch = "", strVehicleNo1 = "";
    public static string strDriver="",strManual = "", strTripsheet= "", strDateGNorCL = "";

    public static string strDriverName1 = "", strDriverName2="";

    public static string strPrevDriver1 = "", strPrevDriver2 = "", strDRIVER_SETTLE_STATUS = "", strDRIVER_SETTLE_DT = "";


    public static string strhdn = "";
        

        
    public cls_Report_TripSheet()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
