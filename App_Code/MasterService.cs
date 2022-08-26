using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel.Activation;
using WebX.Common;
using WebX.Entity;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "MasterService" in code, svc and config file together.
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class MasterService : IMasterService
{
    /// <summary>
    /// Get Leger List
    /// </summary>
    /// <param name="prefix">prefix</param>
    /// <returns>Return Leger List</returns>
    public List<AutoCompleteResult> GetLegerList(string prefix)
    {
        var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
        return objServiceTaxTransferUtilityController.GetLegerList(prefix).Select(s => new AutoCompleteResult { Value = s.LegerCode, Name = s.LegerName }).ToList();
    }
    /// <summary>
    /// Check Leger is exist or not
    /// </summary>
    /// <param name="LegerName">LegerName</param>
    /// <returns>return Leger Code</returns>
    public string IsExistLeger(string legerName)
    {
        var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
        return objServiceTaxTransferUtilityController.IsExistLeger(legerName);
    }
    /// <summary>
    /// Get Customer List
    /// </summary>
    /// <param name="prefix">prefix</param>
    /// <returns>Return Customer List</returns>
    public List<AutoCompleteResult> GetCustomerList(string prefix)
    {
        var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
        return objServiceTaxTransferUtilityController.GetCustomerList(prefix).Select(s => new AutoCompleteResult { Value = s.CustomerCode, Name = s.CustomerName }).ToList();
    }
    /// <summary>
    /// Check Customer exist or not
    /// </summary>
    /// <param name="customerName">customerName</param>
    /// <returns>Return Customer Code</returns>
    public string IsExistCustomer(string customerName)
    {
        var objServiceTaxTransferUtilityController = new ServiceTaxTransferUtilityController();
        return objServiceTaxTransferUtilityController.IsExistCustomer(customerName);
    }

    public List<AutoCompleteResult> GetLocationList(string prefix)
    {
        var objIndentController = new IndentController();
        return objIndentController.GetLocationList(prefix).Select(s => new AutoCompleteResult { Value = s.LocationCode, Name = s.LocationName }).ToList();
    }

    public string IsExistLocation(string LocationName)
    {
        var objIndentController = new IndentController();
        return objIndentController.IsExistLocation(LocationName);
    }


    public string VehicleDriverRequestInsert(List<PushVehicleDriverRequest> listPushVehicleDriverRequestDataJson)
    {
        var oPushVehicleDriverRequest = new PushVehicleDriverRequest();
        return oPushVehicleDriverRequest.VehicleDriverRequestInsert(listPushVehicleDriverRequestDataJson);

    }

    public List<AutoCompleteResult> GetCPKMVendor(AutoCompleteRequest request)
    {
        var objVehicleCPKMController = new VehicleCPKMController();
        return objVehicleCPKMController.GetAllCPKMVendor(request.Prefix).Select(s => new AutoCompleteResult { Value = s.VENDORCODE, Name = s.VENDORNAME }).ToList();
    }
    public List<AutoCompleteResult> GetCPKMVehicle(AutoCompleteRequest request)
    {
        var objVehicleCPKMController = new VehicleCPKMController();
        return objVehicleCPKMController.GetAllVehicleList(request.Prefix);
    }
    public List<AutoCompleteResult> GetFleetCenter(AutoCompleteRequest request)
    {
        var objVehicleCPKMController = new VehicleCPKMController();
        return objVehicleCPKMController.GetAllFleetCenterList(request.Prefix);
    }
    public List<AutoCompleteResult> GetVehicleList(string prefix)
    {
        try
        {
            var objFuelCardProcessController = new FuelCardProcessController();
            return objFuelCardProcessController.GetVehicleList(prefix).Select(s => new AutoCompleteResult { Value = s.Value, Name = s.Name }).ToList();
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetVehicleList Autocomplate service");
            return null;
        }
    }
    public List<AutoCompleteResult> GetCityList(string prefix)
    {
        try
        {
            var objFuelCardProcessController = new FuelCardProcessController();
            return objFuelCardProcessController.GetCityList(prefix).Select(s => new AutoCompleteResult { Value = s.Value, Name = s.Name }).ToList();
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetCityList Autocomplate service");
            return null;
        }
    }
    public List<AutoCompleteResult> GetTripSheetNoList(string prefix)
    {
        try
        {
            var objFuelCardProcessController = new FuelCardProcessController();
            return objFuelCardProcessController.GetTripSheetNoList(prefix).Select(s => new AutoCompleteResult { Value = s.Value, Name = s.Name }).ToList();
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetTripSheetNoList Autocomplate service");
            return null;
        }
    }

    public List<FuelCardProcessData> GetTripSheetDetail(string TripSheetNo, string VehicleNo)
    {
        try
        {
            var objFuelCardProcessController = new FuelCardProcessController();
            return objFuelCardProcessController.GetTripSheetDetail(TripSheetNo, VehicleNo);
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetTripSheetDetail Autocomplate service");
            return null;
        }
    }
    public Response InsertFuelCardProcessDetail(FuelCardProcessData oFuelCardProcessData)
    {
        var objFuelCardProcessController = new FuelCardProcessController();
        DataTable dt = objFuelCardProcessController.InsertFuelCardProcessDetail(oFuelCardProcessData);
        if (dt != null && dt.Rows.Count > 0)
        {
            return new Response() { IsSuccess = true, ErrorMessage = "Sucessfully inserted.!" };
        }
        return new Response();
    }
    /*
	public string CheckFuelCardAlreadyAdded(string TripSheetNo,string VehicleNo)
    {
        var objFuelCardProcessController = new FuelCardProcessController();
        bool data = objFuelCardProcessController.CheckFuelCardAlreadyAdded(TripSheetNo,VehicleNo);
        if (data==true)
        {
            return "Fule card is already exist with same vehicle number and Trip Sheet.!";
        }else{
			
			return "False";
		}
      
    }*/
}
