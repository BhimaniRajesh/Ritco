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
        if (Request.QueryString["Function"] == "CheckVehicleNumber") { Response.Write(CheckVehicleNumber()); }
        if (Request.QueryString["Function"] == "CheckVehicleType") { Response.Write(CheckVehicleType()); }
        if (Request.QueryString["Function"] == "CheckCustomerName") { Response.Write(CheckCustomerName()); }
        if (Request.QueryString["Function"] == "CheckContractExist") { Response.Write(CheckContractExist()); }
        if (Request.QueryString["Function"] == "CheckLocation") { Response.Write(CheckLocation()); }
    }
    private string CheckCustomerCode()
    {
        Secondary_Contract objSecContract = new Secondary_Contract(str_Connection_String);

        objSecContract.Customer_Code = Request.QueryString["CustCode"].ToString();
        objSecContract.CheckCustomerCode();

        if (objSecContract.IsRecordFound == true) { return "Y~" + objSecContract.Customer_Name + "~"; } else { return "N~"; }
    }
    private string CheckCustomerName()
    {
        Secondary_Contract objSecContract = new Secondary_Contract(str_Connection_String);

        objSecContract.Customer_Name = Request.QueryString["Customer_Name"].ToString();
        objSecContract.CheckCustomerName();

        if (objSecContract.IsRecordFound == true) { return "Y~" + objSecContract.Customer_Code + "~"; } else { return "N~"; }
    }
    private string CheckContractExist()
    {
        Secondary_Contract objSecContract = new Secondary_Contract(str_Connection_String);

        objSecContract.Customer_Code = Request.QueryString["Customer_Code"].ToString();
        objSecContract.Contract_To_Dt_S = Request.QueryString["ToDt"].ToString();
        objSecContract.Contract_From_Dt_S = Request.QueryString["FromDt"].ToString(); 
        objSecContract.CheckContractExist();

        if (objSecContract.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    
    private string CheckVehicleNumber()
    {
        Secondary_Contract objTs = new Secondary_Contract(str_Connection_String);

        objTs.Vehicle_No = Request.QueryString["VehicleNo"].ToString();
        objTs.CheckVehicleNumber();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    private string CheckLocation()
    {
        Secondary_Contract objTs = new Secondary_Contract(str_Connection_String);

        objTs.Loc_Code = Request.QueryString["Location"].ToString();
        objTs.CheckLocation();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
    
    private string CheckVehicleType()
    {
        Secondary_Contract objTs = new Secondary_Contract(str_Connection_String);

        objTs.Vehicle_Type = Request.QueryString["VehicleType"].ToString();
        objTs.CheckVehicleType();

        if (objTs.IsRecordFound == true) { return "Y~"; } else { return "N~"; }
    }
}
