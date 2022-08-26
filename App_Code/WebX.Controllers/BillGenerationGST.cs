using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using WebX.Common;

/// <summary>
/// Summary description for BillGenerationGST
/// </summary>
public class BillGenerationGST : Base
{
    public BillGenerationGST()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    /// <summary>
    /// Get Transaction Type
    /// </summary>
    /// <returns></returns>
    public DataTable GetTransactionType()
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            dataTable = objDbFactory.ExecuteDataTable("Usp_Billing_GetTransactionType", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }

    public DataTable GetSupplementaryBill_GetSACCategory()
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            //dataTable = objDbFactory.ExecuteDataTable("Usp_Billing_GetTransactionType", null);
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_SupplementaryBill_GetSACCategory", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }
    /// <summary>
    /// Get Business Type
    /// </summary>
    /// <returns></returns>
    public DataSet GetBusinessType()
    {
        DataSet dataSet;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            dataSet = objDbFactory.ExecuteDataSet("Usp_Billing_GetBusinessType", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataSet;
    }
    /// <summary>
    /// Get Freight Bill Customer Bill Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataSet GetCustomerBillDetail(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataSet dtResult = new DataSet();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[7];
            sqlParam[0] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.CustomerCode);
            sqlParam[1] = new SqlParameter("@Location", oBillGenerationGST_Entity.Location);
            sqlParam[2] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            sqlParam[3] = new SqlParameter("@ServiceType", oBillGenerationGST_Entity.ServiceType);
            sqlParam[4] = new SqlParameter("@ProductType", oBillGenerationGST_Entity.ProductType);
            sqlParam[5] = new SqlParameter("@SACType", oBillGenerationGST_Entity.SACType);
            sqlParam[6] = new SqlParameter("@StateCode", oBillGenerationGST_Entity.BillSubmissionState);
            dtResult = objDbFactory.ExecuteDataSet("Usp_Cust_BillDetails_GST", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }
    /// <summary>
    /// Get Freight Bill Customer Docket Details
    /// </summary>
    /// <param name="oBillGenerationsGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataSet GetCustomerDocketDetail(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataSet dtResult = new DataSet();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[15];
            sqlParam[0] = new SqlParameter("@FromDate", oBillGenerationGST_Entity.FromDate);
            sqlParam[1] = new SqlParameter("@ToDate", oBillGenerationGST_Entity.ToDate);
            sqlParam[2] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.CustomerCode);
            sqlParam[3] = new SqlParameter("@BillLocation", oBillGenerationGST_Entity.Location);
            sqlParam[4] = new SqlParameter("@Paybas", oBillGenerationGST_Entity.Paybas);
            sqlParam[5] = new SqlParameter("@ServiceType", oBillGenerationGST_Entity.ServiceType);
            sqlParam[6] = new SqlParameter("@ProductType", oBillGenerationGST_Entity.ProductType);
            sqlParam[7] = new SqlParameter("@SACType", oBillGenerationGST_Entity.SACType);
            sqlParam[8] = new SqlParameter("@InterState", oBillGenerationGST_Entity.InterState);
            sqlParam[9] = new SqlParameter("@ITC", oBillGenerationGST_Entity.ITC);
            sqlParam[10] = new SqlParameter("@GSTRate", oBillGenerationGST_Entity.GSTRate);
            sqlParam[11] = new SqlParameter("@StateCode", oBillGenerationGST_Entity.BillSubmissionState);
            sqlParam[12] = new SqlParameter("@LocationState", oBillGenerationGST_Entity.BillCollectionLocation);
            sqlParam[13] = new SqlParameter("@BusinessType", oBillGenerationGST_Entity.BusinessType);
            sqlParam[14] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dtResult = objDbFactory.ExecuteDataSet("USP_Get_Docket_Details_For_Bill_Generation", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Supplymentry Bill Customer Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataSet Get_SupplementaryBill_CustomerDetails(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataSet dtResult = new DataSet();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.CustomerCode);
            sqlParam[1] = new SqlParameter("@Location", oBillGenerationGST_Entity.Location);
            sqlParam[2] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dtResult = objDbFactory.ExecuteDataSet("Usp_GST_SupplementaryBill_CustomerDetails", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }
    /// <summary>
    /// Get GST Rate Service Wise
    /// </summary>
    /// <param name="strServiceType">Service Type</param>
    /// <returns></returns>
    public DataTable GetGstRate_FromServiceType(string strServiceType)
    {
        var objWh = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@ServiceType", strServiceType);

            dt = objWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_GetGstRate_FromServiceType", param);
        }
        finally
        {
            objWh.Dispose();
        }
        return dt;
    }

    /// <summary>
    /// Get GST Rate Service Wise
    /// </summary>
    /// <param name="strSacCode">SAC Code</param>
    /// <returns></returns>
    public DataTable GetGstRate_FromSACCode(string strSacCode)
    {
        var objWh = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@SACCode", strSacCode);

            dt = objWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_GetGstRate_FromSACCode", param);
        }
        finally
        {
            objWh.Dispose();
        }
        return dt;
    }
    /// <summary>
    /// Validate State
    /// </summary>
    /// <param name="strValidateState">State</param>
    /// <returns></returns>
    public DataTable ValidateState(string strValidateState)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@StateName", strValidateState.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "Usp_IsValidStateName", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }
    /// <summary>
    /// Validate City
    /// </summary>
    /// <param name="strCityName">City Code</param>
    /// <param name="strStateCode">City Name</param>
    /// <returns></returns>
    public DataTable ValidateCity(string strCityName, string strStateCode)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@CityName", strCityName.Trim());
            param[1] = new SqlParameter("@StateCode", strStateCode.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "Usp_IsValidCityName", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }
    /// <summary>
    /// Validate Account Code
    /// </summary>
    /// <param name="strAccCode">Account Code</param>
    /// <returns></returns>
    public DataTable ValidateAccCode(string strAccCode)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@AccCode", strAccCode.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "Usp_IsValidAccCode", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }
    /// <summary>
    /// Insert Freight Bill Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity"></param>
    /// <returns></returns>
    public string InsertFreightBillDetail(BillGenerationGST_Entity oBillGenerationGST_Entity, string billingAddress)
    {
        string strBillNo = "";
        try
        {
            var prm = new SqlParameter[]
             {
                 new SqlParameter("@XML", XmlUtility.XmlSerializeToString(oBillGenerationGST_Entity)),
                 new SqlParameter("@BillingAddress", billingAddress)
             };
            strBillNo = InsertHelper("Bill", "Usp_FreightBillGeneration", prm);
        }
        catch (Exception ex)
        {
            throw;
        }
        return strBillNo;
    }

    # region - GST Changes By Rajesh Bhimani
    /// <summary>
    /// Get Supplymentry Bill Company - State Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable Get_SupplementaryBill_Company_State_Details(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_SupplementaryBill_Company_State_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Supplymentry Bill Company - City Details
    /// </summary>
    /// <param name="CompanyState">State</param>
    /// <returns></returns>
    public DataTable Get_SupplementaryBill_Company_City_Details(String CompanyState)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@CompanyCode", SessionUtilities.DefaultCompanyCode.ToString());
            sqlParam[1] = new SqlParameter("@StateCode", CompanyState);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_SupplementaryBill_Company_City_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Supplymentry Bill Customer - City Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable Get_SupplementaryBill_Customer_State_Details(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.CustomerCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_SupplementaryBill_Customer_State_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Supplymentry Bill Customer - City Details
    /// </summary>
    /// <param name="CustomerCode">Customer Code</param>
    /// <param name="CustomerState">Customer State</param>
    /// <returns></returns>
    public DataTable Get_SupplementaryBill_Customer_City_Details(String CustomerCode, String CustomerState)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@CustomerCode", CustomerCode);
            sqlParam[1] = new SqlParameter("@StateCode", CustomerState);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_SupplementaryBill_Customer_City_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    public DataTable GetLedgerDetails(double grandtotal, double gsttotal, string customercode, string interstateyesno, string billingtype, string utState, string utStateSame,string businessType)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[8];
            param[0] = new SqlParameter("@Total", grandtotal);
            param[1] = new SqlParameter("@GSTTotal", gsttotal);
            param[2] = new SqlParameter("@CustomerCode", customercode.Trim());
            param[3] = new SqlParameter("@InterState", interstateyesno.Trim());
            param[4] = new SqlParameter("@BillingType", billingtype.Trim());
            param[5] = new SqlParameter("@UTState", utState.Trim());
            param[6] = new SqlParameter("@UTStateSame", utStateSame.Trim());
            param[7] = new SqlParameter("@BusinessType", businessType.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "USP_Summary_Of_Ledger_Posting", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }

    public DataTable GetGeneralBillLedgerDetails(double grandtotal, double gsttotal, string customercode, string interstateyesno, string billingtype, string utState, string utStateSame)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[7];
            param[0] = new SqlParameter("@Total", grandtotal);
            param[1] = new SqlParameter("@GSTTotal", gsttotal);
            param[2] = new SqlParameter("@CustomerCode", customercode.Trim());
            param[3] = new SqlParameter("@InterState", interstateyesno.Trim());
            param[4] = new SqlParameter("@BillingType", billingtype.Trim());
            param[5] = new SqlParameter("@UTState", utState.Trim());
            param[6] = new SqlParameter("@UTStateSame", utStateSame.Trim());

            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "USP_Summary_Of_Ledger_Posting", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }

    # endregion
    # region - Fright Bill GST Changes by Bipin Rupavatiya
    /// <summary>
    /// Get Freight Bill Company State Wise Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable GetFreightBillCompanyStateDetails(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_FreightBill_Company_State_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }
    /// <summary>
    /// Get Freight Bill Customer State Wise Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable GetFreightBillCustomerStateDetails(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.CustomerCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_FreightBill_Customer_State_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }
    /// <summary>
    /// Count Docket for Billing on Selection Page
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable GetDocketCount(BillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[15];
            sqlParam[0] = new SqlParameter("@FromDate", oBillGenerationGST_Entity.FromDate);
            sqlParam[1] = new SqlParameter("@ToDate", oBillGenerationGST_Entity.ToDate);
            sqlParam[2] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.CustomerCode);
            sqlParam[3] = new SqlParameter("@BillLocation", oBillGenerationGST_Entity.Location);
            sqlParam[4] = new SqlParameter("@Paybas", oBillGenerationGST_Entity.Paybas);
            sqlParam[5] = new SqlParameter("@ServiceType", oBillGenerationGST_Entity.ServiceType);
            sqlParam[6] = new SqlParameter("@ProductType", oBillGenerationGST_Entity.ProductType);
            sqlParam[7] = new SqlParameter("@SACType", oBillGenerationGST_Entity.SACType);
            sqlParam[8] = new SqlParameter("@InterState", oBillGenerationGST_Entity.InterState);
            sqlParam[9] = new SqlParameter("@ITC", oBillGenerationGST_Entity.ITC);
            sqlParam[10] = new SqlParameter("@GSTRate", oBillGenerationGST_Entity.GSTRate);
            sqlParam[11] = new SqlParameter("@StateCode", oBillGenerationGST_Entity.BillSubmissionState);
            sqlParam[12] = new SqlParameter("@LocationState", oBillGenerationGST_Entity.BillCollectionLocation);
            sqlParam[13] = new SqlParameter("@BusinessType", oBillGenerationGST_Entity.BusinessType);
            sqlParam[14] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dt = objDbFactory.ExecuteDataTable("USP_Get_Docket_Details_Count_For_Bill_Generation", sqlParam);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }
    # endregion

    public DataTable GeneralBill_Generation(BillGenerationGST_GeneralBill objBill)
    {
        var objWh = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dtResult = new DataTable();
        objWh.BeginTransaction();
        try
        {
            string xmlString = "";
            //if (objBill.EntryDate < DateTime.MinValue || objBill.EntryDate > DateTime.MaxValue)
            //    objBill.EntryDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

            //if (objBill.UpdateDate <= DateTime.MinValue || objBill.UpdateDate >= DateTime.MaxValue)
            //    objBill.UpdateDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

            XmlSerializer x = new XmlSerializer(objBill.GetType());
            MemoryStream stream = new MemoryStream();
            x.Serialize(stream, objBill);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            xmlString = xd.InnerXml;

            xmlString = xmlString.Replace("&", "&amp;");

            SqlParameter[] prm = new SqlParameter[3];
            prm[0] = new SqlParameter("@XML", SqlDbType.Xml);
            prm[0].Value = xmlString;
            prm[1] = new SqlParameter("@CompanyCode", SessionUtilities.DefaultCompanyCode.Trim());
            prm[2] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID.Trim());

            DataSet dsResult = objWh.ExecuteDataSet(CommandType.StoredProcedure, "USp_GeneralBill_Generation_GSTWise", prm);

            dtResult = dsResult.Tables[0];
            //dtXLS = dsResult.Tables[0];

            if (dtResult.Rows.Count > 0)
            {
                DataRow dr = dtResult.Rows[0];
                if (dr["Status"] != DBNull.Value)
                {
                    int status = Convert.ToInt32(dr["Status"]);
                    if (status == 0)
                    {
                        throw new Exception(dr["Message"].ToString());
                    }
                }
                else
                {
                    throw new Exception("Unknown Exception");
                }
            }
            objWh.CommitTransaction();
        }
        catch (Exception ex)
        {
            objWh.RollBackTransaction();
            throw new Exception(ex.Message);
        }
        finally
        {
            objWh.Dispose();
        }
        return dtResult;
    }
    /// <summary>
    /// Get State Customer Wise
    /// </summary>
    /// <param name="customerCode">Customer Code</param>
    /// <returns></returns>
    public DataTable GetStateCustomerWise(string customerCode)
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            var param = new SqlParameter[1];
            param[0] = new SqlParameter("@CustomerCode", customerCode);
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_CriteriaBill_Customer_State_Details", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }
    /// <summary>
    /// Get Customer Bill Generation Location State Wise
    /// </summary>
    /// <param name="stateCode">State Code</param>
    /// <param name="customerCode">Customer Code</param>
    /// <returns></returns>
    public DataTable GetCustomerBillGenerationLocation(string stateCode, string customerCode)
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            var param = new SqlParameter[3];
            param[0] = new SqlParameter("@StateCode", stateCode);
            param[1] = new SqlParameter("@CustomerCode", customerCode);
            param[2] = new SqlParameter("@CompanyCode", SessionUtilities.DefaultCompanyCode);
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_Freight_Bill_Generation_Location_On_State", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }
    /// <summary>
    /// Get Customer Bill Submission Location State Wise
    /// </summary>
    /// <param name="stateCode">State Code</param>
    /// <param name="customerCode">Customer Code</param>
    /// <returns></returns>
    public DataTable GetCustomerBillSubmissionLocation(string stateCode, string customerCode)
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            var param = new SqlParameter[3];
            param[0] = new SqlParameter("@StateCode", stateCode);
            param[1] = new SqlParameter("@CustomerCode", customerCode);
            param[2] = new SqlParameter("@CompanyCode", SessionUtilities.DefaultCompanyCode);
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_Freight_Bill_Submission_Location_On_State", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }
}