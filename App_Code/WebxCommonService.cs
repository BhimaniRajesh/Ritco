using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;
using AjaxControlToolkit;
using Microsoft.ApplicationBlocks.Data;
using Newtonsoft.Json;
using WebX.Common;
using AjaxControlToolkit;

/// <summary>
/// Summary description for WebxCommonService
/// </summary>
[WebService(Namespace = "http://Webxpress.in/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebxCommonService : System.Web.Services.WebService
{

    public WebxCommonService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string GetDocketListForBillGeneration(DateTime dtFromDate, DateTime dtToDate, string strPartyCode, string strTrnMode, string strLocation, string strBusinessType)
    {
        var oBillHeader = new BillHeader();
        oBillHeader.FromDate = dtFromDate;
        oBillHeader.ToDate = dtToDate;
        oBillHeader.PartyCode = strPartyCode;
        oBillHeader.TrnMode = strTrnMode;
        oBillHeader.Location = strLocation;
        oBillHeader.BusinessType = strBusinessType;
        var dt = oBillHeader.GetDocketList();
        return JsonConvert.SerializeObject(dt);
    }

    [WebMethod(EnableSession = true)]
    public string GetCustomer(string prefixText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@Customer", prefixText);
            param[1] = new SqlParameter("@IsCheck", "0");

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Get_Cusotomer_For_Auto_Complete", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }

    [WebMethod(EnableSession = true)]
    public string CheckValidCustomer(string customerId)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@Customer", customerId);
            param[1] = new SqlParameter("@IsCheck", "1");

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Get_Cusotomer_For_Auto_Complete", param);
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
    public string GetVendor(string searchText)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@Vendor", searchText.Trim());
            param[1] = new SqlParameter("@IsCheck", "0");

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Get_Vendor_For_Auto_Complete", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }

    [WebMethod(EnableSession = true)]
    public string CheckValidVendor(string vendorId)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@Vendor", vendorId);
            param[1] = new SqlParameter("@IsCheck", "1");

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_Get_Vendor_For_Auto_Complete", param);
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
    public string[] GetAccCodeValueNameDetail(string prefixText, int count, string contextKey)
    {
        List<string> items = new List<string>();
        if (count == 0)
        {
            count = 10;
        }
        JavaScriptSerializer Serializer = new JavaScriptSerializer();
        string strSql = " SELECT TOP " + count.ToString() + "  Value=Acccode, Name=Accdesc, Display=(Acccode +' : '+ Accdesc) From webx_acctinfo " +
                     " Where Activeflag = 'Y' AND (Acccode Like '" + prefixText + "'+'%' or Accdesc Like '" + prefixText + "'+'%') " +
                     " Order By Acccode,Accdesc";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSql);

        List<AutoComplete.NameValue> Codes = GetValueNameDisplayList(ds);

        foreach (AutoComplete.NameValue c in Codes)
        {
            items.Add(AutoCompleteExtender.CreateAutoCompleteItem(c.Display, Serializer.Serialize(c)));
        }

        return items.ToArray();

    }

    private List<AutoComplete.NameValue> GetValueNameDisplayList(DataSet dsResult)
    {
        var isEmpty = true;
        var lstCodes = new List<AutoComplete.NameValue>();
        if (dsResult.Tables.Count > 0)
        {
            if (dsResult.Tables[0].Rows.Count > 0)
            {
                isEmpty = false;
                foreach (DataRow dRow in dsResult.Tables[0].Rows)
                {
                    var nameValue = new AutoComplete.NameValue { Name = dRow["Name"].ToString(), Value = dRow["Value"].ToString(), Display = dRow["Display"].ToString() };
                    //nameValue.Display = nameValue.Name;
                    lstCodes.Add(nameValue);
                }
            }
        }
        if (isEmpty)
        {
            var nameValue = new AutoComplete.NameValue { Name = "", Value = "", Display = "No record found..." };
            lstCodes.Add(nameValue);
        }
        return lstCodes;
    }

    [WebMethod]
    public string PushVehicleRequest(List<PushVehicleDriverRequest> listPushVehicleDriverRequest)
    {
        try
        {
            var oPushVehicleDriverRequest = new PushVehicleDriverRequest();
            return oPushVehicleDriverRequest.VehicleDriverRequestInsert(listPushVehicleDriverRequest);
        }
        catch (Exception ex)
        {
            return "";
        }

    }
	
	[WebMethod(EnableSession = true)]
    public string CustomerMasterAutoComplate(string searchText, string GroupCode)
    {
        var dt = new DataTable();

        using (var oWh = new WebXHelper())
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@CustomerName", searchText);
            param[1] = new SqlParameter("@GroupCode", GroupCode);

            dt = oWh.ExecuteDataTable(CommandType.StoredProcedure, "USP_CustomerMaster_GetCustomerListByGroupCode", param);
        }

        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;

    }
	[WebMethod(EnableSession = true)]
    public string[] GetBankDetail(string prefixText, int count, string contextKey)
    {
        List<string> items = new List<string>();
        if (count == 0)
        {
            count = 10;
        }
        JavaScriptSerializer Serializer = new JavaScriptSerializer();
        string strSql = " SELECT TOP " + count.ToString() + "  Value=Acccode, Name=Accdesc, Display=(Acccode +' : '+ Accdesc) From webx_acctinfo " +
                     " Where  ACCCATEGORY='BANK' AND Activeflag = 'Y' AND (Acccode Like '" + prefixText + "'+'%' or Accdesc Like '" + prefixText + "'+'%') " +
                     " Order By Acccode,Accdesc";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSql);

        List<AutoComplete.NameValue> Codes = GetValueNameDisplayList(ds);

        foreach (AutoComplete.NameValue c in Codes)
        {
            items.Add(AutoCompleteExtender.CreateAutoCompleteItem(c.Display, Serializer.Serialize(c)));
        }

        return items.ToArray();

    }
    #endregion
}
