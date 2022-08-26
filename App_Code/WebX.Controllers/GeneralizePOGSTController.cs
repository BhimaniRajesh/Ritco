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
public class GeneralizePOGSTController : Base
{
    public GeneralizePOGSTController()
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
    /// Validate Account Code
    /// </summary>
    /// <param name="strDocNo">Account Code</param>
    /// <param name="strDocType">Account Code</param>
    /// <returns></returns>
    public DataTable ValidateDocumentNumber(string strDocNo, string strDocType)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[2];
            param[0] = new SqlParameter("@DocNo", strDocNo.Trim());
            param[1] = new SqlParameter("@DocType", strDocType.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "Usp_IsValidDocumentNumber", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
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

    public DataTable GetVendorBill_GetHSNCode()
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            dataTable = objDbFactory.ExecuteDataTable("Usp_GST_VendorBill_GetHSNCode", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
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
            dt = objWh.ExecuteDataTable(CommandType.StoredProcedure, "Usp_GST_GeneralizePO_GetGstRate_FromSACCode", param);
        }
        finally
        {
            objWh.Dispose();
        }
        return dt;
    }

    public DataTable GetPOGenerationLedgerDetails(string materialcategory, double grandtotal, double gsttotal, string vendorcode, string interstateyesno, string billingtype, string utState, string utStateSame)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[8];
            param[0] = new SqlParameter("@MaterialCategory ", materialcategory);
            param[1] = new SqlParameter("@Total", grandtotal);
            param[2] = new SqlParameter("@GSTTotal", gsttotal);
            param[3] = new SqlParameter("@VendorCode", vendorcode.Trim());
            param[4] = new SqlParameter("@InterState", interstateyesno.Trim());
            param[5] = new SqlParameter("@BillingType", billingtype.Trim());
            param[6] = new SqlParameter("@UTState", utState.Trim());
            param[7] = new SqlParameter("@UTStateSame", utStateSame.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "USP_PO_Generation_Summary_Of_Ledger_Posting", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }

    public DataTable FixedAssetLedgerDetails(string materialcategory, string assetcd, double itemsubtotal, string vendorcode)
    {
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dt;
        try
        {
            var param = new SqlParameter[4];
            param[0] = new SqlParameter("@MaterialCategory ", materialcategory);
            param[1] = new SqlParameter("@ASSETCD", assetcd);
            param[2] = new SqlParameter("@Total", itemsubtotal);
            param[3] = new SqlParameter("@VendorCode", vendorcode.Trim());
            dt = objDbFactory.ExecuteDataTable(CommandType.StoredProcedure, "USP_PO_Generation_FixedAssetSummary_Of_Ledger_Posting", param);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dt;
    }

    public DataTable GetGstExemptedCategory()
    {
        DataTable dataTable;
        var objDbFactory = new WebXHelper(SessionUtilities.ConnectionString);
        try
        {
            dataTable = objDbFactory.ExecuteDataTable("Usp_VendorBilling_GetGstExemptedCategory", null);
        }
        finally
        {
            objDbFactory.Dispose();
        }
        return dataTable;
    }

    public DataTable GeneralizePOGST_Generation(GeneralizePOGST_PoHeader objPo)
    {
        var objWh = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dtResult = new DataTable();
        objWh.BeginTransaction();
        try
        {
            string xmlString = "";
            //if (objPo.EntryDate < DateTime.MinValue || objPo.EntryDate > DateTime.MaxValue)
            //    objPo.EntryDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

            //if (objBill.UpdateDate <= DateTime.MinValue || objBill.UpdateDate >= DateTime.MaxValue)
            //    objBill.UpdateDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

            XmlSerializer x = new XmlSerializer(objPo.GetType());
            MemoryStream stream = new MemoryStream();
            x.Serialize(stream, objPo);
            stream.Position = 0;
            XmlDocument xd = new XmlDocument();
            xd.Load(stream);
            xmlString = xd.InnerXml;

            xmlString = xmlString.Replace("&", "&amp;");

            SqlParameter[] prm = new SqlParameter[5];
            prm[0] = new SqlParameter("@XML", SqlDbType.Xml);
            prm[0].Value = xmlString;
            prm[1] = new SqlParameter("@Brcd", SessionUtilities.CurrentBranchCode.Trim());
            prm[2] = new SqlParameter("@CompanyCode", SessionUtilities.DefaultCompanyCode.Trim());
            prm[3] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID.Trim());
            prm[4] = new SqlParameter("@Finyear", SessionUtilities.FinYear.Trim());

            DataSet dsResult = objWh.ExecuteDataSet(CommandType.StoredProcedure, "usp_Generate_PO_Asset_Details_GSTWise", prm);

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
}