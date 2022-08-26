using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using WebX.Entity;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IMasterService" in both code and config file together.
[ServiceContract]
public interface IMasterService
{
    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetLegerList")]
    List<AutoCompleteResult> GetLegerList(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "IsExistLeger")]
    string IsExistLeger(string legerName);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCustomerList")]
    List<AutoCompleteResult> GetCustomerList(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "IsExistCustomer")]
    string IsExistCustomer(string customerName);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetLocationList")]
    List<AutoCompleteResult> GetLocationList(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "IsExistLocation")]
    string IsExistLocation(string LocationName);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "VehicleDriverRequestInsert")]
    string VehicleDriverRequestInsert(List<PushVehicleDriverRequest> listPushVehicleDriverRequestDataJson);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCPKMVendor")]
    List<AutoCompleteResult> GetCPKMVendor(AutoCompleteRequest request);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
        BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCPKMVehicle")]
    List<AutoCompleteResult> GetCPKMVehicle(AutoCompleteRequest request);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
        BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetFleetCenter")]
    List<AutoCompleteResult> GetFleetCenter(AutoCompleteRequest request);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetVehicleList")]
    List<AutoCompleteResult> GetVehicleList(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetCityList")]
    List<AutoCompleteResult> GetCityList(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetTripSheetNoList")]
    List<AutoCompleteResult> GetTripSheetNoList(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate = "GetTripSheetDetail")]
    List<FuelCardProcessData> GetTripSheetDetail(string TripSheetNo, string VehicleNo);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "InsertFuelCardProcessDetail")]
    Response InsertFuelCardProcessDetail(FuelCardProcessData oFuelCardProcessData);
    /*
	[OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "CheckFuelCardAlreadyAdded")]
    string CheckFuelCardAlreadyAdded(string TripSheetNo,string VehicleNo);*/
}

