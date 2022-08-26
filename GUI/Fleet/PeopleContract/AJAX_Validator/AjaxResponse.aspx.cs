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
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckCustomerCode") { Response.Write(CheckCustomerCode()); }
        if (Request.QueryString["Function"] == "CheckCityName") { Response.Write(CheckCityName()); }
        if (Request.QueryString["Function"] == "GetDriverDetails") { Response.Write(GetDriverDetails()); }
        if (Request.QueryString["Function"] == "GetVehicleDetails") { Response.Write(GetVehicleDetails()); }
        if (Request.QueryString["Function"] == "CheckValidManualTS") { Response.Write(CheckValidManualTS()); }
        if (Request.QueryString["Function"] == "CheckVehicleType") { Response.Write(CheckVehicleType()); }
        if (Request.QueryString["Function"] == "OnChangeRoute") { Response.Write(OnChangeRoute()); }
        if (Request.QueryString["Function"] == "CalculateHours") { Response.Write(CalculateHours()); }
        if (Request.QueryString["Function"] == "CheckContractExist") { Response.Write(CheckContractExist()); }
        if (Request.QueryString["Function"] == "OnChangeContract") { Response.Write(OnChangeContract()); }
    }
    private string OnChangeContract()
    {
        People_Contract objPM = new People_Contract(str_Connection_String);
        
        objPM.Customer_Code = Request.QueryString["Customer_Code"].ToString();
        objPM.Contract_Type_Id = Request.QueryString["Contract_Type"].ToString();
        objPM.VehicleNo = Request.QueryString["VehicleNo"].ToString();
        objPM.OnChangeContract();

        if (objPM.IsRecordFound == true) { return "Y~" + objPM.Duration_Id + "~" + objPM.Category_Id + "~" + objPM.RUTCD + "~" + objPM.RUTKM + "~" + objPM.Tot_Hour + "~" + objPM.Tot_Min + "~"; } else { return "N~"; }
    }
    private string CheckContractExist()
    {
        People_Contract objPM = new People_Contract(str_Connection_String);

        objPM.Customer_Code = Request.QueryString["Customer_Code"].ToString();
        objPM.Contract_To_Dt_S = Request.QueryString["ToDt"].ToString();
        objPM.Contract_From_Dt_S = Request.QueryString["FromDt"].ToString();
        objPM.Contract_Type_Id = Request.QueryString["Contract_Type"].ToString();  
        objPM.CheckContractExist();

        if (objPM.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string CalculateHours()
    {
        People_Contract objPM = new People_Contract(str_Connection_String);
        objPM.CalculateHours(Request.QueryString["SDT"].ToString(), Request.QueryString["EDT"].ToString());
        if (objPM.IsRecordFound == true) { return "Y~" + objPM.sHrs + "~" + objPM.sMin + "~"; } else { return "N~"; }
    }

    private string OnChangeRoute()
    {
        People_Contract objPM = new People_Contract(str_Connection_String);
        if (Request.QueryString["RutCd"] != null)
        {
            objPM.OnChangeRoute(Request.QueryString["RutCd"].ToString());
        }
        if (objPM.IsRecordFound == true) { return "Y~" + objPM.RUTKM + "~" + objPM.Tot_Hour + "~" + objPM.Tot_Min + "~"; } else { return "N~"; }
    }
    private string CheckVehicleType()
    {
        People_Contract objPM = new People_Contract(str_Connection_String);

        objPM.Vehicle_Type = Request.QueryString["VehicleType"].ToString();
        objPM.CheckVehicleType();

        if (objPM.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string CheckValidManualTS()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Manual_TripSheetNo = Request.QueryString["ManualTSNo"].ToString();
        //objTs.Customer_Code = Request.QueryString["Customer_Code"].ToString();
        //objTs.BRCD = Request.QueryString["Branch_Code"].ToString();
        objTs.Company_Code = Request.QueryString["Company_Code"].ToString();
        objTs.CheckValidManualNewTS();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string GetVehicleDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Vehicle_No = Request.QueryString["VehNo"].ToString();
        objTs.GetVehicleDetails();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Vehicle_Type + "~" + objTs.Current_Km_Read + "~" + objTs.Vendor_Name + "~"; } else { return "N~"; }
    }
    private string GetDriverDetails()
    {
        TripSheet objTs = new TripSheet(str_Connection_String);

        objTs.Driver_Id = Request.QueryString["DriverId"].ToString();
        objTs.GetDriverDetails();

        if (objTs.IsRecordFound == true) { return "Y~" + objTs.Driver_Name + "~" + objTs.License_No + "~" + objTs.Valdity_dt + "~" + objTs.Manual_Driver_Code + "~"; } else { return "N~"; }
    }
    private string CheckCityName()
    {
        TripSheet objTripSheet = new TripSheet(str_Connection_String);

        objTripSheet.City_Name = Request.QueryString["CityName"].ToString();
        objTripSheet.CheckCityName();

        if (objTripSheet.IsRecordFound == true) { return "Y~" + objTripSheet.City_Name + "~"; } else { return "N~"; }
    }
    private string CheckCustomerCode()
    {
        Secondary_Contract objSecContract = new Secondary_Contract(str_Connection_String);

        objSecContract.Customer_Code = Request.QueryString["CustCode"].ToString();
        objSecContract.CheckCustomerCode();

        if (objSecContract.IsRecordFound == true) { return "Y~" + objSecContract.Customer_Name + "~"; } else { return "N~"; }
    }

}
