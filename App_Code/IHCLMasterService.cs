using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;
using System.Data;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IHCLMasterService" in both code and config file together.
[ServiceContract]
public interface IHCLMasterService
{
    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "GetBranch")]
    [return: MessageParameter(Name = "d")]
    List<AutoCompleteResult> GetBranch(string prefix);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "HCLEntry")]
    string HCLEntry(HCLDetail objHCLDetail);

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "IsBranchExist")]
    List<BranchResult> IsBranchExist(string BranchCode);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, UriTemplate = "IsBranchExistInMaster")]
    List<BranchResult> IsBranchExistInMaster(string BranchCode);


    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "HCLBillEntry")]
    string HCLBillEntry(HCLBillGenerationHeader oHCLBillGenerationHeader);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "HCLBillPayment")]
    Response HCLBillPayment(HCLBillPaymenentDetails oHCLBillPaymenentDetails);

    [OperationContract]
    [WebInvoke(Method = "POST", RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Bare, UriTemplate = "CheckDuplicateCheque")]
    string CheckDuplicateCheque(ChequeRequest oChequeRequest);
}
