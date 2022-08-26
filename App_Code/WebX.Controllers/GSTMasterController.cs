using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for GSTMasterController
/// </summary>
public class GSTMasterController : Base
{

    public GSTMasterController()
    {
        //
        // TODO: Add constructor logic here
        //

    }
    public DataSet GetCustomerGSTDetail(string CustomerCode)
    {
        DataSet dtResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CustomerCode", CustomerCode);
            dtResult = ExecuteDataSet("Usp_Master_GetCustomerGSTDetail", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }
    //public DataTable ValidateCustomer(string CustomerCode)
    //{
    //    DataTable dtResult = new DataTable();
    //    try
    //    {
    //        SqlParameter[] sqlParam = new SqlParameter[1];
    //        sqlParam[0] = new SqlParameter("@CustomerCode", CustomerCode);
    //        dtResult = ExecuteDataTable("Usp_Master_IsValidGSTCustomer", sqlParam);
    //    }
    //    catch (Exception)
    //    {
    //        throw;
    //    }
    //    return dtResult;
    //}

    public DataTable InsertCustomerGSTDetail(GSTCustomerMasterEntity oGSTCustomerMasterEntity)
    {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@XML", XmlUtility.XmlSerializeToString(oGSTCustomerMasterEntity));
            dtResult = ExecuteDataTable("Usp_Master_GSTCustomerDetailEntry", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    #region SAC GST Master & SAC Product Mapping Master
    public string SaveGSTSacRate(List<GSTSacMasterEntity> objGSTSacMaster)
    {
        try
        {
            var prm = new SqlParameter[]
             {
                 new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objGSTSacMaster))
             };

            return InsertHelper("GSTSAC", "Usp_Master_SaveSACGSTRates", prm);
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    public DataTable GetSACGSTDetails()
    {
        try
        {
            return ExecuteDataTable("Usp_Master_GetSACGSTDetails");
        }
        catch (Exception)
        {
            throw;
        }
    }
    public DataTable GetSACGSTProductMappingDetails()
    {
        try
        {
            return ExecuteDataTable("Usp_Master_GetSACGSTProductMappingDetails");
        }
        catch (Exception)
        {
            throw;
        }
    }
    public string SaveGSTSacProductMapping(List<GSTSacProductMappingMasterEntity> objGSTSacMaster)
    {
        try
        {
            var prm = new SqlParameter[]
             {
                 new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objGSTSacMaster))
             };

            return InsertHelper("SACProductMapping", "Usp_Master_SaveGSTSACProductMapping", prm);
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    #endregion

    #region Company GST Master

    public DataSet GetCompanyGSTDetail(string CompanyCode)
    {
        DataSet dtResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@CompanyCode", CompanyCode);
            dtResult = ExecuteDataSet("Usp_Master_GetCompanyGSTDetail", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    //public DataTable ValidateCompany(string CompanyCode)
    //{
    //    DataTable dtResult = new DataTable();
    //    try
    //    {
    //        SqlParameter[] sqlParam = new SqlParameter[1];
    //        sqlParam[0] = new SqlParameter("@CompanyCode", CompanyCode);
    //        dtResult = ExecuteDataTable("Usp_Master_IsValidGSTCompany", sqlParam);
    //    }
    //    catch (Exception)
    //    {
    //        throw;
    //    }
    //    return dtResult;
    //}
    public DataTable InsertCompanyGSTDetail(GSTCompanyMasterEntity oGSTCompanyMasterEntity)
    {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@XML", XmlUtility.XmlSerializeToString(oGSTCompanyMasterEntity));
            dtResult = ExecuteDataTable("Usp_Master_GSTCompanyDetailEntry", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }


    #endregion

    #region Vendor GST Master

    public DataSet GetVendorGSTDetail(string VendorCode)
    {
        DataSet dtResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@VendorCode", VendorCode);
            dtResult = ExecuteDataSet("Usp_Master_GetVendorGSTDetail", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    //public DataTable ValidateVendor(string VendorCode)
    //{
    //    DataTable dtResult = new DataTable();
    //    try
    //    {
    //        SqlParameter[] sqlParam = new SqlParameter[1];
    //        sqlParam[0] = new SqlParameter("@VendorCode", VendorCode);
    //        dtResult = ExecuteDataTable("Usp_Master_IsValidGSTVendor", sqlParam);
    //    }
    //    catch (Exception)
    //    {
    //        throw;
    //    }
    //    return dtResult;
    //}
    public DataTable InsertVendorGSTDetail(GSTVendorMasterEntity oGSTVendorMasterEntity)
    {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@XML", XmlUtility.XmlSerializeToString(oGSTVendorMasterEntity));
            dtResult = ExecuteDataTable("Usp_Master_GSTVendorDetailEntry", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return dtResult;
    }

    #endregion

    #region ProductServiceMapping Master
    public DataSet GetProductServiceMappingDetails()
    {
        DataSet dtResult = new DataSet();
        try
        {
            dtResult = ExecuteDataSet("Usp_Master_GetGSTProductServiceMappingDetails", null);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return dtResult;
    }


    public string SaveProductSerivceMapping(List<ProductServiceMappingMasterEntity> objMapping)
    {
        try
        {
            var prm = new SqlParameter[]
             {
                 new SqlParameter("@XML", XmlUtility.XmlSerializeToString(objMapping))
             };

            return InsertHelper("SACProductMapping", "Usp_Master_SaveGSTProductServiceMapping", prm);
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    #endregion

}