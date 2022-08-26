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
/// Summary description for VendorBillGenerationGST
/// </summary>
public class VendorBillGenerationGST : Base
{
    public VendorBillGenerationGST()
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
            //var param = new SqlParameter[1];
            //param[0] = new SqlParameter("@BranchCode", branchCode);
            dataTable = objDbFactory.ExecuteDataTable("Usp_Billing_GetTransactionType", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }

    public DataTable GetVendorBill_GetSACCategory()
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_GetSACCategory", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }

    /// <summary>
    /// Get Freight Bill Customer Bill Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataSet GetCustomerBillDetail(VendorBillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataSet dtResult = new DataSet();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[7];
            sqlParam[0] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.VendorCode);
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
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataSet GetCustomerDocketDetail(VendorBillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataSet dtResult = new DataSet();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[13];
            sqlParam[0] = new SqlParameter("@FromDate", oBillGenerationGST_Entity.FromDate);
            sqlParam[1] = new SqlParameter("@ToDate", oBillGenerationGST_Entity.ToDate);
            sqlParam[2] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.VendorCode);
            sqlParam[3] = new SqlParameter("@BillLocation", oBillGenerationGST_Entity.Location);
            sqlParam[4] = new SqlParameter("@Paybas", oBillGenerationGST_Entity.Paybas);
            sqlParam[5] = new SqlParameter("@ServiceType", oBillGenerationGST_Entity.ServiceType);
            sqlParam[6] = new SqlParameter("@ProductType", oBillGenerationGST_Entity.ProductType);
            sqlParam[7] = new SqlParameter("@SACType", oBillGenerationGST_Entity.SACType);
            sqlParam[8] = new SqlParameter("@InterState", oBillGenerationGST_Entity.InterState);
            sqlParam[9] = new SqlParameter("@ITC", oBillGenerationGST_Entity.ITC);
            sqlParam[10] = new SqlParameter("@GSTRate", oBillGenerationGST_Entity.GSTRate);
            sqlParam[11] = new SqlParameter("@StateCode", oBillGenerationGST_Entity.BillSubmissionState);
            sqlParam[12] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dtResult = objDbFactory.ExecuteDataSet("USP_Get_Docket_Details_For_Bill_Generation", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Vendor Bill Vendor Details
    /// </summary>
    /// <param name="oBill">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataSet Get_VendorBill_VendorDetails(VendorBillGenerationGST_Entity oBill)
    {
        DataSet dtResult = new DataSet();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[5];
            sqlParam[0] = new SqlParameter("@VendorCode", oBill.VendorCode);
            sqlParam[1] = new SqlParameter("@Location", oBill.Location);
            sqlParam[2] = new SqlParameter("@CompanyCode", oBill.CompanyCode);
            sqlParam[3] = new SqlParameter("@SupplyState", oBill.SupplyState);
            sqlParam[4] = new SqlParameter("@BookingState", oBill.BookingState);
            dtResult = objDbFactory.ExecuteDataSet("Usp_GST_VendorBill_VendorDetails", sqlParam);
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
    /// <param name="strSacCode">SAC Code</param>
    /// <param name="strIsRegister">Register Y or N</param>
    /// <returns></returns>
    public DataTable GetGstRate_FromSACCode(string strSacCode, string strIsRegister)
    {
        var objWh = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@SACCode", strSacCode);
            param[1] = new SqlParameter("@RegisteredYN", strIsRegister);
            dt = objWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_GST_VendorBill_GetGstRate_FromSACCode", param);
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
    public string InsertFreightBillDetail(VendorBillGenerationGST_Entity oBillGenerationGST_Entity, string billingAddress)
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

    
    /// <summary>
    /// Get Vendor Bill Company - State Details
    /// </summary>
    /// <param name="oBill">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable Get_VendorBill_Company_State_Details(VendorBillGenerationGST_Entity oBill)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CompanyCode", oBill.CompanyCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_Company_State_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Vendor Bill Company - State Details
    /// </summary>
    /// <param name="oBill">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable Get_VendorBill_Get_SupplyCity_Details(VendorBillGenerationGST_Entity oBill)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@VendorCode", oBill.VendorCode);
            sqlParam[1] = new SqlParameter("@StateCode", oBill.SupplyState);
            sqlParam[2] = new SqlParameter("@RegisteredYN", oBill.RegisteredYN);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_Get_SupplyCity_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    public DataTable Get_VendorBill_Get_BookingCity_Details(VendorBillGenerationGST_Entity oBill)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@CompanyCode", oBill.CompanyCode);
            sqlParam[1] = new SqlParameter("@StateCode", oBill.BookingState);
            sqlParam[2] = new SqlParameter("@RegisteredYN", oBill.RegisteredYN);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_Get_BookingCity_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    public DataTable GetSupplyCityDetails_FromCityCode(string strVendorCode, string strStateCode, string strCityCode)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@VendorCode", strVendorCode);
            sqlParam[1] = new SqlParameter("@StateCode", strStateCode);
            sqlParam[2] = new SqlParameter("@CityCode", strCityCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_GetSupplyCityDetails_FromCityCode", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    public DataTable GetBookingCityDetails_FromCityCode(string strCompanyCode, string strStateCode, string strCityCode)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@CompanyCode", strCompanyCode);
            sqlParam[1] = new SqlParameter("@StateCode", strStateCode);
            sqlParam[2] = new SqlParameter("@CityCode", strCityCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_GetBookingCityDetails_FromCityCode", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Vendor Bill Company - City Details
    /// </summary>
    /// <param name="strCompanyState">State</param>
    /// <returns></returns>
    public DataTable Get_VendorBill_Company_City_Details(string strCompanyState)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@CompanyCode", SessionUtilities.DefaultCompanyCode.ToString());
            sqlParam[1] = new SqlParameter("@StateCode", strCompanyState);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_Company_City_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Vendor Bill Vendor - City Details
    /// </summary>
    /// <param name="oBill">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable Get_VendorBill_Vendor_State_Details(VendorBillGenerationGST_Entity oBill)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@VendorCode", oBill.VendorCode);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_Vendor_State_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    /// <summary>
    /// Get Vendor Bill Vendor - City Details
    /// </summary>
    /// <param name="strVendorCode">Customer Code</param>
    /// <param name="strVendorState">Customer State</param>
    /// <returns></returns>
    public DataTable Get_VendorBill_Vendor_City_Details(string strVendorCode, string strVendorState)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@VendorCode", strVendorCode);
            sqlParam[1] = new SqlParameter("@StateCode", strVendorState);
            dtResult = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_Vendor_City_Details", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    public DataTable GetVendorLedgerDetails(double grandtotal, double gsttotal, string vendorcode, string interstateyesno, string billingtype, string utState, string utStateSame, double tdsAmount, string tdsSection)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[9];
            param[0] = new SqlParameter("@Total", grandtotal);
            param[1] = new SqlParameter("@GSTTotal", gsttotal);
            param[2] = new SqlParameter("@VendorCode", vendorcode.Trim());
            param[3] = new SqlParameter("@InterState", interstateyesno.Trim());
            param[4] = new SqlParameter("@BillingType", billingtype.Trim());
            param[5] = new SqlParameter("@UTState", utState.Trim());
            param[6] = new SqlParameter("@UTStateSame", utStateSame.Trim());
            param[7] = new SqlParameter("@TDSAmount", tdsAmount);
            param[8] = new SqlParameter("@TDSSection", tdsSection);
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "USP_Vendor_Summary_Of_Ledger_Posting", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }

    
    # region - Fright Bill GST Changes by Bipin Rupavatiya
    /// <summary>
    /// Get Freight Bill Company State Wise Details
    /// </summary>
    /// <param name="oBillGenerationGST_Entity">Bill Generation GST Entity</param>
    /// <returns></returns>
    public DataTable GetFreightBillCompanyStateDetails(VendorBillGenerationGST_Entity oBillGenerationGST_Entity)
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
    public DataTable GetFreightBillCustomerStateDetails(VendorBillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        DataTable dtResult = new DataTable();
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.VendorCode);
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
    public DataTable GetDocketCount(VendorBillGenerationGST_Entity oBillGenerationGST_Entity)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[13];
            sqlParam[0] = new SqlParameter("@FromDate", oBillGenerationGST_Entity.FromDate);
            sqlParam[1] = new SqlParameter("@ToDate", oBillGenerationGST_Entity.ToDate);
            sqlParam[2] = new SqlParameter("@CustomerCode", oBillGenerationGST_Entity.VendorCode);
            sqlParam[3] = new SqlParameter("@BillLocation", oBillGenerationGST_Entity.Location);
            sqlParam[4] = new SqlParameter("@Paybas", oBillGenerationGST_Entity.Paybas);
            sqlParam[5] = new SqlParameter("@ServiceType", oBillGenerationGST_Entity.ServiceType);
            sqlParam[6] = new SqlParameter("@ProductType", oBillGenerationGST_Entity.ProductType);
            sqlParam[7] = new SqlParameter("@SACType", oBillGenerationGST_Entity.SACType);
            sqlParam[8] = new SqlParameter("@InterState", oBillGenerationGST_Entity.InterState);
            sqlParam[9] = new SqlParameter("@ITC", oBillGenerationGST_Entity.ITC);
            sqlParam[10] = new SqlParameter("@GSTRate", oBillGenerationGST_Entity.GSTRate);
            sqlParam[11] = new SqlParameter("@StateCode", oBillGenerationGST_Entity.BillSubmissionState);
            sqlParam[12] = new SqlParameter("@CompanyCode", oBillGenerationGST_Entity.CompanyCode);
            dt = objDbFactory.ExecuteDataTable("USP_Get_Docket_Details_Count_For_Bill_Generation", sqlParam);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }
    # endregion

    public DataTable GeneralBill_Generation(VendorBillGenerationGST_GeneralBill objBill)
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

            DataSet dsResult = objWh.ExecuteDataSet(CommandType.StoredProcedure, "USp_VendorOtherBill_Generation_GSTWise", prm);

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
    /// Get State Vendor Wise
    /// </summary>
    /// <param name="strVendorCode">Vendor Code</param>
    /// <param name="strGstChargeCode">GST Charge Code</param>
    /// <returns></returns>
    public DataTable GetSupplyState(string strVendorCode, string strGstChargeCode)
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@VendorCode", strVendorCode);
            param[1] = new SqlParameter("@GstChargeCode", strGstChargeCode);
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_GetSupplyState", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }

    /// <summary>
    /// Get State Vendor Wise
    /// </summary>
    /// <param name="strVendorCompanyCode">Vendor/Company Code</param>
    /// <param name="strGstChargeCode">GST Charge Code</param>
    /// <returns></returns>
    public DataTable GetBookingState(string strVendorCompanyCode, string strGstChargeCode)
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@VendorCompanyCode", strVendorCompanyCode);
            param[1] = new SqlParameter("@GstChargeCode", strGstChargeCode);
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_GetBookingState", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }

    /// <summary>
    /// Added TDS Section
    /// </summary>
    /// <returns></returns>
    public DataTable GetTdsSection()
    {
        return ExecuteDataTable("Usp_GetTdsSection");
    }
}