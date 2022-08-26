using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for HCLMasterController
/// </summary>
public class HCLMasterController : Base
{
    public HCLMasterController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public List<BranchResult> GetBranch(string prefixText, string isCheck)
    {
        try
        {
            return ExecuteDataTable("Usp_Master_GetBranch", new SqlParameter[]
            {
                    new SqlParameter("@SearchText", prefixText),
                    new SqlParameter("@IsCheck", isCheck) }).ToList<BranchResult>();
        }
        catch (Exception)
        {
            throw;
        }
    }
    public List<BranchResult> GetHCLDetails(string BranchCode, string isCheck)
    {
        try
        {
            return ExecuteDataTable("USP_GetDataForHCLLabourDetails", new SqlParameter[]
            {
                    new SqlParameter("@BranchCode", BranchCode),
                    new SqlParameter("@IsCheck", isCheck) }).ToList<BranchResult>();
        }
        catch (Exception)
        {
            throw;
        }
    }
    public DataTable IsBranchExist(string BranchCode)
    {
        try
        {
            return ExecuteDataTable("USP_Master_IsBranchExist", new[]
            {
                new SqlParameter("@BranchCode",BranchCode)
                });
        }
        catch (Exception)
        {
            throw;
        }
    }
    public string HCLEntry(HCLDetail objHCLDetail)
    {
        try
        {
            return InsertHelper("", "USP_AddHCLLabourEntry", new SqlParameter[]
            {
                    new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objHCLDetail))
            });
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    public DataSet GetDataForHCLEdit(string BranchCode)
    {
        try
        {
            return ExecuteDataSet("USP_GetDataForHCLLabourEdit", new[]
                {
                new SqlParameter("@BranchCode",BranchCode),
              });
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    public DataSet GetDataForHCLView(string BranchCode)
    {
        try
        {
            return ExecuteDataSet("USP_GetDataForHCLLabourView", new[]
                {
                new SqlParameter("@BranchCode",BranchCode),
              });
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public DataTable UpdateHCLDetails(HCLUpdateDetail objHCLDetail)
    {

        var obj = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dtResult = new DataTable();
        obj.BeginTransaction();
        try
        {
            SqlParameter[] prm = new SqlParameter[18];
            prm[0] = new SqlParameter("@BranchCode", objHCLDetail.BranchCode);
            prm[1] = new SqlParameter("@OutgoingThcType", objHCLDetail.OutgoingThcType);
            prm[2] = new SqlParameter("@OutgoingThcRate", objHCLDetail.OutgoingThcRate);
            prm[3] = new SqlParameter("@OutgoingThcFromDate", objHCLDetail.OutgoingThcFromDate);
            prm[4] = new SqlParameter("@OutgoingThcToDate", objHCLDetail.OutgoingThcToDate);

            prm[5] = new SqlParameter("@IncomingThcType", objHCLDetail.IncomingThcType);
            prm[6] = new SqlParameter("@IncomingThcRate", objHCLDetail.IncomingThcRate);
            prm[7] = new SqlParameter("@IncomingThcFromDate", objHCLDetail.IncomingThcFromDate);
            prm[8] = new SqlParameter("@IncomingThcToDate", objHCLDetail.IncomingThcToDate);

            prm[9] = new SqlParameter("@DDMRType", objHCLDetail.DDMRType);
            prm[10] = new SqlParameter("@DDMRRate", objHCLDetail.DDMRRate);
            prm[11] = new SqlParameter("@DDMRFromDate", objHCLDetail.DDMRFromDate);
            prm[12] = new SqlParameter("@DDMRToDate", objHCLDetail.DDMRToDate);

            prm[13] = new SqlParameter("@MRType", objHCLDetail.MRType);
            prm[14] = new SqlParameter("@MRRate", objHCLDetail.MRRate);
            prm[15] = new SqlParameter("@MRFromDate", objHCLDetail.MRFromDate);
            prm[16] = new SqlParameter("@MRToDate", objHCLDetail.MRToDate);
            prm[17] = new SqlParameter("@UpdateBy", objHCLDetail.UpdateBy);


            DataSet dsResult = obj.ExecuteDataSet(CommandType.StoredProcedure, "USP_UpdateHCLLabourDetails", prm);

            dtResult = dsResult.Tables[0];

            obj.CommitTransaction();
        }
        catch (Exception ex)
        {
            obj.RollBackTransaction();
            throw new Exception(ex.Message);
        }
        finally
        {
            obj.Dispose();
        }
        return dtResult;
    }
    public DataTable UpdateHCLBillApprovalDetails(HCLBillApprovalDetail objHCLApprovalDetails)
    {

        var obj = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dtResult = new DataTable();
        obj.BeginTransaction();
        try
        {
            SqlParameter[] prm = new SqlParameter[6];
            prm[0] = new SqlParameter("@BillNo", objHCLApprovalDetails.BillNo);
            prm[1] = new SqlParameter("@ApprovedAmount", objHCLApprovalDetails.ApprovedAmount);
            prm[2] = new SqlParameter("@Discount", objHCLApprovalDetails.Discount);
            prm[3] = new SqlParameter("@RejectRemarks", objHCLApprovalDetails.RejectRemarks);
            prm[4] = new SqlParameter("@ApprovalFlag", objHCLApprovalDetails.ApprovalFlag);
            prm[5] = new SqlParameter("@ApprovedBy", SessionUtilities.CurrentEmployeeID);

            DataSet dsResult = obj.ExecuteDataSet(CommandType.StoredProcedure, "Usp_HCLBillApprovalUpdate", prm);

            dtResult = dsResult.Tables[0];

            obj.CommitTransaction();
        }
        catch (Exception ex)
        {
            obj.RollBackTransaction();
            throw new Exception(ex.Message);
        }
        finally
        {
            obj.Dispose();
        }
        return dtResult;
    }
    public DataSet GetRateType()
    {
        return ExecuteDataSet("Usp_GetHCLRateTypes");
    }
    public DataTable GetDocListForHCLBilling(string FromDate, string ToDate)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ExecuteDataTable("Usp_HCLBillGeneration_GetDocList", new[] {
            new SqlParameter("@Fromdt", Convert.ToDateTime(FromDate)) ,
            new SqlParameter("@Todt", Convert.ToDateTime(ToDate)),
            new SqlParameter("@locCode", SessionUtilities.CurrentBranchCode)
            });
            return dt;
        }
        catch
        {
            throw;
        }
    }

    public DataTable GetListForHCLBillApproval(string FromDate, string ToDate, string BillNo, string BranchCode)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ExecuteDataTable("Usp_GetListForHCLBillApproval", new[] {
            new SqlParameter("@Fromdt", Convert.ToDateTime(FromDate)) ,
            new SqlParameter("@Todt", Convert.ToDateTime(ToDate)),
            new SqlParameter("@BillNo",BillNo),
            new SqlParameter("@BranchCode",BranchCode)
            //new SqlParameter("@locCode", SessionUtilities.CurrentBranchCode)
            });
            return dt;
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public DataSet GetListForHCLBillApprovalList(string BillNo,string BranchCode)
    {
        try
        {
            DataSet ds = new DataSet();
            ds = ExecuteDataSet("Usp_GetListForHCLBillApproval_Billwise", new[] {
            new SqlParameter("@BillNo",BillNo),
            new SqlParameter("@Loccode",BranchCode),

            });
            return ds;
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    public string HCLBillEntry(HCLBillGenerationHeader oHCLBillGenerationHeader)
    {
        var BillNo = "";
        try
        {
            if (BillNo != null)
            {
                BillNo = InsertHelper("HCLBill", "Usp_HCLBillGeneration_InsertBill", new SqlParameter[] { 
                                                                   new SqlParameter("@BillXML", WebX.Common.XmlUtility.XmlSerializeToString(oHCLBillGenerationHeader)) });
            }
        }
        catch (Exception ex)
        {
            WebX.Common.ExceptionUtils.LogException(ex, "HCL Bill Generation");
        }
        return BillNo;
    }

    public DataTable GetBillListForHCLBillPayment(string FromDate, string ToDate, string BillNo)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ExecuteDataTable("Usp_HCLBillPayment_GetBillList", new[] {
            new SqlParameter("@Fromdt", Convert.ToDateTime(FromDate)) ,
            new SqlParameter("@Todt", Convert.ToDateTime(ToDate)),
            new SqlParameter("@locCode", SessionUtilities.CurrentBranchCode),
            new SqlParameter("@BillNo", BillNo)
            });
            return dt;
        }
        catch
        {
            throw;
        }
    }

    public DataTable GetBankList()
    {
        try
        {
            DataTable dt = new DataTable();
            dt = ExecuteDataTable("Usp_HCLBillPayment_GetBankList", new[] {
            new SqlParameter("@locCode", SessionUtilities.CurrentBranchCode)
            });
            return dt;
        }
        catch
        {
            throw;
        }
    }
    public DataTable HCLBillPayment(HCLBillPaymenentDetails oHCLBillPaymenentDetails)
    {
        var ds = new DataSet();
        try
        {
                ds = ExecuteDataSet("Usp_HCLBillPayment", new SqlParameter[] { 
                                                                   new SqlParameter("@BillXML", WebX.Common.XmlUtility.XmlSerializeToString(oHCLBillPaymenentDetails)) }, true);
        }
        catch (Exception ex)
        {
            WebX.Common.ExceptionUtils.LogException(ex, "HCL Bill Payment");
        }
        return ds.Tables[1];
    }
    public string CheckDuplicateCheque(ChequeRequest oChequeRequest)
    {
        try
        {
            string Cnt = VendorPayment_Utility.Duplicate_ChqNO(oChequeRequest.chequeNo, oChequeRequest.chequedate);
            return Cnt;
        }
        catch
        {
            throw;
        }
    }
    public DataTable IsBranchExistInMaster(string BranchCode)
    {
        try
        {
            return ExecuteDataTable("USP_CheckHCLEntryInMaster", new[]
            {
                new SqlParameter("@BranchCode",BranchCode)
                });
        }
        catch (Exception)
        {
            throw;
        }
    }
    public DataTable getdonepagedetails(string voucherNo)
    {
        try
        {
            return ExecuteDataTable("Usp_BillPayment_GetBillDetailsforDonepage", new[]
            {
                new SqlParameter("@voucherNo",voucherNo)
                });
        }
        catch (Exception)
        {
            throw;
        }
    }

}