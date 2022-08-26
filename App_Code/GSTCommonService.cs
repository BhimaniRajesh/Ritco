using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;
using WebX.Common;

/// <summary>
/// Summary description for WebxCommonService
/// </summary>
[WebService(Namespace = "http://Webxpress.in/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class GSTCommonService : System.Web.Services.WebService
{

    public GSTCommonService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

      [WebMethod(EnableSession = true)]
    public string BranchAutoComplate(string prefixText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@Location", prefixText);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "USP_Location_AutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }

    #region  GST Methost

    [WebMethod(EnableSession = true)]
    public string CustomerAutoComplate(string searchText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@CustName", searchText);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetGSTCustomerListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }
    [WebMethod(EnableSession = true)]
    public string StateAutoComplate(string searchText, string StateType)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@StateName", searchText);
            param[1] = new SqlParameter("@StateType", StateType);


            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetGSTStateListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }

    [WebMethod(EnableSession = true)]
    public string CityAutoComplate(string searchText, string StateId)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@CityName", searchText);
            param[1] = new SqlParameter("@StateID", StateId);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetGSTCityListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }

    [WebMethod(EnableSession = true)]
    public string LocationAutoComplate(string searchText, string StateCode)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@LocationName", searchText);
            param[1] = new SqlParameter("@StateCode", StateCode);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetGSTLocationListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }
	
	 [WebMethod(EnableSession = true)]
    public string LocationAutoComplateReport(string searchText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@LocationName", searchText);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetLocationListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string CompanyAutoComplate(string searchText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@CompanyName", searchText.Trim());

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetGSTCompanyListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }

    [WebMethod(EnableSession = true)]
    public string VendorAutoComplate(string searchText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@VendorName", searchText.Trim());

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GetGSTVendorListForAutoComplate", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }


    [WebMethod(EnableSession = true)]
    public string ValidateCompanyExist(string CompanyName)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@CompanyName", CompanyName);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateCompanyExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateCustomerExist(string CustomerName)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@CustomerName", CustomerName);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateCustomerExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateVendorExist(string VendorName)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@VendorName", VendorName);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateVendorExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateStateExist(string stateName, string stateType)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@stateName", stateName);
            param[1] = new SqlParameter("@StateType", stateType);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateStateExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateCityExist(string CityName, string StateCode)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@CityName", CityName);
            param[1] = new SqlParameter("@StateCode", StateCode);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateCityExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateLocationExist(string LocationName)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@LocationName", LocationName);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateLocationExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateCGSTNumberExist(string CGSTNumber, string Category, string Code)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[3];
            param[0] = new SqlParameter("@CGSTNumber", CGSTNumber);
            param[1] = new SqlParameter("@Category", Category.ToUpper());
            param[2] = new SqlParameter("@Code", Code);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateCustomerCGSTNoExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    [WebMethod(EnableSession = true)]
    public string ValidateIGSTNumberExist(string IGSTNumber, string Category, string Code)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[3];
            param[0] = new SqlParameter("@IGSTNumber", IGSTNumber);
            param[1] = new SqlParameter("@Category", Category.ToUpper());
            param[2] = new SqlParameter("@Code", Code);
            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Master_GSTValidateCustomerIGSTNoExist", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }
	[WebMethod(EnableSession = true)]
    public string GetClaimNo(string searchText,string BillingParty)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@SearchText", searchText.Trim());
            param[1] = new SqlParameter("@BillingParty", BillingParty);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_GetClaimNoList", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }
    #endregion
}
