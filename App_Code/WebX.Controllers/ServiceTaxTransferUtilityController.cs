using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using WebX.Entity;
using System.Linq;
/// <summary>
/// Summary description for ServiceTaxTransferUtilityController
/// </summary>
public class ServiceTaxTransferUtilityController : Base
{
    public ServiceTaxTransferUtilityController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    /// <summary>
    /// Get Division List 
    /// </summary>
    /// <returns>Return Division List</returns>
    public DataTable GetDivisionList()
    {
        return ExecuteDataTable("Usp_ServiceTaxTransferUtility_GetDivisionList");
    }
    /// <summary>
    /// Get Location List
    /// </summary>
    /// <returns>Return Location List</returns>
    public DataTable GetLocationList()
    {
        return ExecuteDataTable("Usp_ServiceTaxTransferUtility_GetLocationList");
    }
    //public DataTable GetCustomerList()
    //{
    //    return ExecuteDataTable("Usp_ServiceTaxTransferUtility_GetCustomerList");
    //}
    /// <summary>
    /// Get MR Details List
    /// </summary>
    /// <param name="objMRCriteria">Parameter of MRCriteria Class</param>
    /// <returns>Return MR Details List</returns>
    public DataTable GetMRDetailsList(MRCriteria objMRCriteria)
    {
        return ExecuteDataTable("Usp_ServiceTaxTransferUtility_GetMRDetails", new[] 
        { 
            new SqlParameter("@CustomerCode", objMRCriteria.CustomerCode),
            new SqlParameter("@Location", objMRCriteria.Location),
            new SqlParameter("@FromDate", objMRCriteria.FromDate),
            new SqlParameter("@ToDate", objMRCriteria.ToDate),
            new SqlParameter("@Division", objMRCriteria.Division),
            new SqlParameter("@GRNo", objMRCriteria.GRNo),
            new SqlParameter("@MRNo", objMRCriteria.MRNo),
            new SqlParameter("@Finyear", objMRCriteria.FinYear)
        });
    }
    /// <summary>
    /// Get Leger List
    /// </summary>
    /// <param name="searchText">searchText</param>
    /// <returns>Return Leger List</returns>
    public List<LegerList> GetLegerList(string searchText)
    {
        return ExecuteDataTable("Usp_ServiceTaxTransferUtility_GetLegerList", new SqlParameter[] 
            { 
                new SqlParameter("@Leger",searchText)              
            }).ToList<LegerList>();
    }
    /// <summary>
    /// Check Leger is exist or not
    /// </summary>
    /// <param name="LegerName">LegerName</param>
    /// <returns>return Leger Code</returns>
    public string IsExistLeger(string LegerName)
    {
        return Convert.ToString(ExecuteScalar("Usp_ServiceTaxTransferUtility_IsExistLeger", new[]
            { 
                new SqlParameter("@Leger",LegerName)
            }));
    }
    /// <summary>
    /// Insert Details 
    /// </summary>
    /// <param name="objMRHeader">Parameter of MRHeader class</param>
    public void ServiceTaxTransferUtilityInsert(MRHeader objMRHeader)
    {
        try
        {
            InsertHelper("Usp_ServiceTaxTransferUtility_Insert", new SqlParameter[] 
            { 
                    new SqlParameter("@XML", WebX.Common.XmlUtility.XmlSerializeToString(objMRHeader))
            });
        }
        catch (Exception ex)
        {
            WebX.Common.ExceptionUtils.LogException(ex, "Service Tax Transfer Utility", SessionUtilities.CurrentEmployeeID, "ServiceTaxTransferUtility.aspx");
        }
    }
    /// <summary>
    /// Get Customer List
    /// </summary>
    /// <param name="searchText">searchText</param>
    /// <returns>Return Customer List</returns>
    public List<CustomerList> GetCustomerList(string searchText)
    {
        return ExecuteDataTable("Usp_ServiceTaxTransferUtility_GetCustomerList", new SqlParameter[] 
            { 
                new SqlParameter("@Customer",searchText)              
            }).ToList<CustomerList>();
    }
    /// <summary>
    /// Check Customer exist or not
    /// </summary>
    /// <param name="customerName">customerName</param>
    /// <returns>Return Customer Code</returns>
    public string IsExistCustomer(string customerName)
    {
        return Convert.ToString(ExecuteScalar("Usp_ServiceTaxTransferUtility_IsExistCustomer", new[]
            { 
                new SqlParameter("@Customer",customerName)
            }));
    }
}