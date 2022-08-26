using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using WebX.Entity;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IVehicleMasterService" in both code and config file together.
[ServiceContract]
public interface IVehicleMasterService
{
    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetState")]
    [return: MessageParameter(Name = "d")]
    List<AutoCompleteResult> GetState(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "IsStateExist")]
    List<StateResult> IsStateExist(string StateCode);
}
