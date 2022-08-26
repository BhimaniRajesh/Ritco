using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for VendorCPKMBillController
/// </summary>
public class VendorCPKMBillController : Base
{
    public VendorCPKMBillController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable GetCPKMBillList(string fromDate, string toDate, string vendorCode, string billNo)
    {
        var dtResult = new DataTable();
        try
        {

            SqlParameter[] sqlParam = new SqlParameter[9];
            sqlParam[0] = new SqlParameter("@BranchCode", SessionUtilities.CurrentBranchCode);
            sqlParam[1] = new SqlParameter("@VendorCode", vendorCode);
            sqlParam[2] = new SqlParameter("@VehicleNo", "");
            sqlParam[3] = new SqlParameter("@FromDate", fromDate);
            sqlParam[4] = new SqlParameter("@ToDate", toDate);
            sqlParam[5] = new SqlParameter("@Month", "0");
            sqlParam[6] = new SqlParameter("@Year", "0");
            sqlParam[7] = new SqlParameter("@BillNo", billNo);
            sqlParam[8] = new SqlParameter("@Billtype", "A");
            dtResult = ExecuteDataTable("Usp_VendorCPKM_Gen_Approv_Payment_List", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VendorCPKMBillController->GetCPKMBillList");
            throw ex;
        }
        return dtResult;
    }
    public DataTable GetCPKMBillPaymentList(string fromDate, string toDate, string vendorCode, string billNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[4];
            sqlParam[0] = new SqlParameter("@FromDate", fromDate);
            sqlParam[1] = new SqlParameter("@ToDate", toDate);
            sqlParam[2] = new SqlParameter("@VendorCode", vendorCode);
            sqlParam[3] = new SqlParameter("@Billno", billNo);
            dtResult = ExecuteDataTable("Usp_Get_Vendor_CPKM_BillList_ForPayment", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VendorCPKMBillController->GetCPKMBillList");
            throw ex;
        }
        return dtResult;
    }


    public DataTable GetrateFromVendorConftract(string vendorCode)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@vendorCode", vendorCode);
            sqlParam[1] = new SqlParameter("@Location", SessionUtilities.CurrentBranchCode);
            dtResult = ExecuteDataTable("Usp_Get_Vendor_CPKM_ContractRate", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetVendorCPKMContractRate");
            throw ex;
        }
        return dtResult;
    }

    public DataTable GetVendorCPKMBillDetailsForApproval(string billNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@BillNo", billNo);
            dtResult = ExecuteDataTable("Usp_Get_Vendor_CPKM_BillDetails_ForApproval", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetVendorCPKMBillDetailsForApproval");
            throw ex;
        }
        return dtResult;
    }

    public DataTable GetVendorCPKMBillDetailsForGeneration(string VendorCode, string Month, string Year, string FromDate, string ToDate)
    {
        var dtResult = new DataTable();
        try
        {

            SqlParameter[] sqlParam = new SqlParameter[9];
            sqlParam[0] = new SqlParameter("@BranchCode", SessionUtilities.CurrentBranchCode);
            sqlParam[1] = new SqlParameter("@VendorCode", VendorCode);
            sqlParam[2] = new SqlParameter("@VehicleNo", "");
            sqlParam[3] = new SqlParameter("@FromDate", FromDate);
            sqlParam[4] = new SqlParameter("@ToDate", ToDate);
            sqlParam[5] = new SqlParameter("@Month", Month);
            sqlParam[6] = new SqlParameter("@Year", Year);
            sqlParam[7] = new SqlParameter("@BillNo", "");
            sqlParam[8] = new SqlParameter("@Billtype", "G");
            dtResult = ExecuteDataTable("Usp_VendorCPKM_Gen_Approv_Payment_List", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetVendorCPKMBillDetailsForApproval");
            throw ex;
        }
        return dtResult;
    }

    public DataTable CPKMBillGeneration(cls_VehicleCPKM_BillGeneration objcls_VehicleCPKM_BillGeneration, List<cls_VehicleCPKM_BillGeneration> oList, string strXML)
    {
        return ExecuteDataTable("Usp_VendorCPKM_BillGeneration", new SqlParameter[] { 
                                                                                    new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objcls_VehicleCPKM_BillGeneration)), 
                                                                                    new SqlParameter("@detailXML", XmlUtility.XmlSerializeToString(oList)), 
                                                                                    new SqlParameter("@MIscXML", strXML), 
                                                                                    new SqlParameter("@FinYear", SessionUtilities.FinYear),
                                                                                    new SqlParameter("@Location", SessionUtilities.CurrentBranchCode)});
    }


    public DataTable CPKMBillPayment(cls_VehicleCPKM_BillPayment objcls_VehicleCPKM_BillGeneration, List<cls_VehicleCPKM_BillPayment> oList)
    {
        return ExecuteDataTable("Usp_VendorCPKM_BillPayment", new SqlParameter[] { 
                                                                                    new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objcls_VehicleCPKM_BillGeneration)), 
                                                                                    new SqlParameter("@detailXML", XmlUtility.XmlSerializeToString(oList)), 
                                                                                    new SqlParameter("@FinYear", SessionUtilities.FinYear),
                                                                                    new SqlParameter("@Location", SessionUtilities.CurrentBranchCode)});
    }

	public DataTable GetTDSDetailsByBillNo(string billNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@BillNo", billNo);
            dtResult = ExecuteDataTable("Usp_Get_TDSDetails", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetTDSDetailsByBillNo");
            throw ex;
            //}

        }
        return dtResult;
    }
	
    public DataTable GetMiscChargeByBillNo(string billNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@BillNo", billNo);
            dtResult = ExecuteDataTable("Usp_Get_Bill_Misc_Charges", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetMiscChargeByBillNo");
            throw ex;
            //}

        }
        return dtResult;
    }
    public DataSet CPKMBillApprove(string billNo, string strXml,string strMiscXMl)
    {
        return ExecuteDataSet("Usp_VendorCPKM_Bill_Approve_Reject",
             new SqlParameter[] { 
            new SqlParameter("@BillNo", billNo), 
            new SqlParameter("@StrXMl", strXml), 
            new SqlParameter("@StrMiscXMl", strMiscXMl),
            new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)}, true);
    }


    public DataTable GetListForCreditKmsForApproval(string fromDate, string toDate, string FleetCenter, string VehicleNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[4];
            sqlParam[0] = new SqlParameter("@VehicleNo", VehicleNo);
            sqlParam[1] = new SqlParameter("@FromDate", fromDate);
            sqlParam[2] = new SqlParameter("@ToDate", toDate);
            sqlParam[3] = new SqlParameter("@FleetCenter", FleetCenter);
            dtResult = ExecuteDataTable("Usp_VendorCPKM_Approval_CreditKmsList", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VendorCPKMBillController->GetListForCreditKmsForApproval");
            throw ex;
        }
        return dtResult;
    }
     public DataSet GetListForCreditKmsVehicleTyreDetail(string VehicleNo, string TotalValue, string CreditKms)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@VehicleNo", VehicleNo);
            sqlParam[1] = new SqlParameter("@TotalValue", TotalValue);
            sqlParam[2] = new SqlParameter("@CreditKms", CreditKms);
            dsResult = ExecuteDataSet("Usp_VendorCPKM_Approval_CreditKmsVehicleTyreDetailList", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VendorCPKMBillController->GetListForCreditKmsVehicleTyreDetail");
            throw ex;
        }
        return dsResult;
    }
    public DataTable InsertCreditKmsVehicleTyreDetail(List<cls_VendorCPKMBilling_Approval> oList, string isAccept)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@XML", XmlUtility.XmlSerializeToString(oList));
            sqlParam[1] = new SqlParameter("@IsAccept", isAccept);
            dtResult = ExecuteDataTable("Usp_VendorCPKM_InsertCreditKmsVehicleTyreDetail", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VendorCPKMBillController->InsertCreditKmsVehicleTyreDetail");
            throw ex;
        }
        return dtResult;
    }
    public DataTable GetFleetCenterList()
    {
        return ExecuteDataTable("Usp_GetFleetCenterList");
    }
}
