using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Activation;
using WebX.Common;
using System.Data;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "HCLMasterService" in code, svc and config file together.
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]

public class HCLMasterService : IHCLMasterService
{
    public List<AutoCompleteResult> GetBranch(string prefix)
    {
        try
        {
            var objHCLMasterController = new HCLMasterController();
            return objHCLMasterController.GetBranch(prefix, "0").Select(s => new AutoCompleteResult { Value = s.BranchCode, Name = s.BranchCode }).ToList();
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetBranch");
            return null;
        }
    }
    public List<BranchResult> IsBranchExist(string BranchCode)
    {
        var objHCLMasterController = new HCLMasterController();
        DataTable dt = objHCLMasterController.IsBranchExist(BranchCode);
        return (from DataRow dr in dt.Rows
                select new BranchResult()
                {
                    IsBranchExist = dr["IsBranchExist"].ToString(),
                    BranchCode = dr["BranchCode"].ToString(),
                }).ToList();
    }

    public List<BranchResult> IsBranchExistInMaster(string BranchCode)
    {
        var objHCLMasterController = new HCLMasterController();
        DataTable dt = objHCLMasterController.IsBranchExistInMaster(BranchCode);
        return (from DataRow dr in dt.Rows
                select new BranchResult()
                {
                    IsBranchExist = dr["IsBranchExist"].ToString(),
                    BranchCode = dr["BranchCode"].ToString(),
                }).ToList();
    }
    public string HCLEntry(HCLDetail objHCLDetail)
    {
        try
        {
            var objHCLMasterController = new HCLMasterController();
            return objHCLMasterController.HCLEntry(objHCLDetail);
        }
        catch (Exception ex)
        {

            return null;
        }
    }
    public string HCLBillEntry(HCLBillGenerationHeader oHCLBillGenerationHeader)
    {
        var objHCLMasterController = new HCLMasterController();
        return objHCLMasterController.HCLBillEntry(oHCLBillGenerationHeader);
    }

    public Response HCLBillPayment(HCLBillPaymenentDetails oHCLBillPaymenentDetails)
    {
        var objHCLMasterController = new HCLMasterController();
        //return objHCLMasterController.HCLBillPayment(oHCLBillPaymenentDetails);
        DataTable dt = objHCLMasterController.HCLBillPayment(oHCLBillPaymenentDetails);
        if (dt != null && dt.Rows.Count > 0)
        {
            return new Response() { IsSuccess = Convert.ToBoolean(dt.Rows[0]["Status"]), VoucherNo = Convert.ToString(dt.Rows[0]["VoucherNo"]), ErrorMessage = Convert.ToString(dt.Rows[0]["Message"]) };
        }
        return new Response();
    }
    public string CheckDuplicateCheque(ChequeRequest oChequeRequest)
    {
        var objHCLMasterController = new HCLMasterController();
        var cnt = objHCLMasterController.CheckDuplicateCheque(oChequeRequest);
        return cnt;
    }
    public List<AutoCompleteResult> GetHCLDetails(string BranchCode)
    {
        try
        {
            var objHCLMasterController = new HCLMasterController();
            return objHCLMasterController.GetHCLDetails(BranchCode, "0").Select(s => new AutoCompleteResult { Value = s.BranchCode, Name = s.BranchCode }).ToList();
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetHCLDetails");
            return null;
        }
    }
}
