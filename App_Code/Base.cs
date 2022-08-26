using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Runtime.Serialization;
using WebX.Common;

[DataContract]
public class Base
{
    public Base()
    {
        DocumentNo = "";
        Location = ""; EntryBy = ""; FinYear = "";
        EntryDate = DateTime.Now;
    }

    [DataMember(Name = "DocumentNo")]
    public string DocumentNo { get; set; }

    [DataMember(Name = "Location")]
    public string Location { get; set; }

    [DataMember(Name = "FinYear")]
    public string FinYear { get; set; }

    [DataMember(Name = "EntryBy")]
    public string EntryBy { get; set; }

    [DataMember(Name = "EntryDate")]
    public DateTime EntryDate { get; set; }

    /// <summary>
    /// Extension for ExecuteDataTable method using Sql Transaction for Insert/Update/Delete
    /// </summary>
    /// <param name="documentType">Document Type</param>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <param name="sqlParameterList">Sql Parameter List</param>
    /// <returns>Document No</returns>
    public string InsertHelper(string documentType, string strProcedureName, SqlParameter[] sqlParameterList)
    {
        var strDocumentNo = "";
        using (var oWebXHelper = new WebXHelper())
        {
            oWebXHelper.BeginTransaction();
            try
            {
                var dtResult = oWebXHelper.ExecuteDataTable(CommandType.StoredProcedure, strProcedureName, sqlParameterList);

                if (dtResult.Rows.Count > 0)
                {
                    var drResult = dtResult.Rows[0];
                    if (drResult["Status"] != DBNull.Value)
                    {
                        int status = Convert.ToInt32(drResult["Status"]);
                        if (status == 0)
                            throw new Exception(drResult["Message"].ToString());
                        else if (status == 1)
                            strDocumentNo = drResult[documentType.ToString() + "No"].ToString();
                    }
                    else
                        throw new Exception("Unknown Exception");
                }
                oWebXHelper.CommitTransaction();
            }
            catch
            {
                oWebXHelper.RollBackTransaction();
                throw;
            }
        }
        return strDocumentNo;
    }

    /// <summary>
    /// Extension for ExecuteNonQuery method using Sql Transaction
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <param name="sqlParameterList">Sql Parameter List</param>
    public void InsertHelper(string strProcedureName, SqlParameter[] sqlParameterList)
    {
        using (var oWebXHelper = new WebXHelper())
        {
            oWebXHelper.BeginTransaction();
            try
            {
                oWebXHelper.ExecuteNonQuery(CommandType.StoredProcedure, strProcedureName, sqlParameterList);
                oWebXHelper.CommitTransaction();
            }
            catch
            {
                oWebXHelper.RollBackTransaction();
                throw;
            }
        }
    }

    /// <summary>
    /// Extension for ExecuteDataSet method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <param name="sqlParameterList">Sql Parameter List</param>
    /// <returns>DataSet</returns>
    public DataSet ExecuteDataSet(string strProcedureName, SqlParameter[] sqlParameterList, bool isWithTransaction)
    {
        var ds = new DataSet();
        using (var oWebXHelper = new WebXHelper())
        {
            if (isWithTransaction)
                oWebXHelper.BeginTransaction();
            try
            {
                ds = oWebXHelper.ExecuteDataSet(CommandType.StoredProcedure, strProcedureName, sqlParameterList);
                if (isWithTransaction)
                    oWebXHelper.CommitTransaction();
            }
            catch (Exception)
            {
                if (isWithTransaction)
                    oWebXHelper.RollBackTransaction();
                throw;
            }
        }
        return ds;
    }

    /// <summary>
    /// Extension for ExecuteDataSet method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <param name="sqlParameterList">Sql Parameter List</param>
    /// <returns>DataSet</returns>
    public DataSet ExecuteDataSet(string strProcedureName, SqlParameter[] sqlParameterList)
    {
        return ExecuteDataSet(strProcedureName, sqlParameterList, false);
    }
    /// <summary>
    /// Extension for ExecuteDataSet method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <returns>DataSet</returns>
    public DataSet ExecuteDataSet(string strProcedureName)
    {
        return ExecuteDataSet(strProcedureName, (SqlParameter[])null, false);
    }
    /// <summary>
    /// Extension for ExecuteDataTable method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <param name="sqlParameterList">Sql Parameter List</param>
    /// <returns>DataTable</returns>
    public DataTable ExecuteDataTable(string strProcedureName, SqlParameter[] sqlParameterList)
    {
        var dt = new DataTable();
        using (var oWebXHelper = new WebXHelper())
        {
            dt = oWebXHelper.ExecuteDataTable(CommandType.StoredProcedure, strProcedureName, sqlParameterList);
        }
        return dt;
    }

    /// <summary>
    /// Extension for ExecuteDataTable method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <returns>DataTable</returns>
    public DataTable ExecuteDataTable(string strProcedureName)
    {
        return ExecuteDataTable(strProcedureName, (SqlParameter[])null);
    }

    /// <summary>
    /// Extension for ExecuteScalar method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <param name="sqlParameterList">Sql Parameter List</param>
    /// <returns>object</returns>
    public object ExecuteScalar(string strProcedureName, SqlParameter[] sqlParameterList)
    {
        object obj;
        using (var oWebXHelper = new WebXHelper())
        {
            obj = oWebXHelper.ExecuteScalar(CommandType.StoredProcedure, strProcedureName, sqlParameterList);
        }
        return obj;
    }

    /// <summary>
    /// Extension for ExecuteScalar method
    /// </summary>
    /// <param name="strProcedureName">Store Procedure Name</param>
    /// <returns>object</returns>
    public object ExecuteScalar(string strProcedureName)
    {
        return ExecuteScalar(strProcedureName, (SqlParameter[])null);
    }

    protected DateTime ParseDateTime(string strDate)
    {
        return strDate == null ? default(DateTime) : DateTime.ParseExact(strDate, "dd MMM yyyy HH:mm", CultureInfo.InvariantCulture);
    }
    protected DateTime ParseDateTime(string strDate, string format)
    {
        return strDate == null ? default(DateTime) : DateTime.ParseExact(strDate, format, CultureInfo.InvariantCulture);
    }
    protected string ConvertDate(DateTime dt)
    {
        return dt.ToString("dd MMM yyyy HH:mm", CultureInfo.InvariantCulture);
    }
}
