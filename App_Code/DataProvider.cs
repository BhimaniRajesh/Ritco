using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;

/// <summary>
/// Summary description for DataProvider
/// </summary>
public class DataProvider
{
    public DataProvider()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// Gets DataTable of active route codes with name
    /// </summary>
    /// <returns>DataTable of route with name</returns>
    public static DataTable GetActiveRoutes()
    {
        string strsql = "SELECT rutcd AS code,rutnm AS codename FROM webx_rutmas WHERE ISNULL(activeflag,'N')='Y' ORDER BY rutnm";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    /// <summary>
    /// Gets DataTable of active vehicle types with type names
    /// </summary>
    /// <returns>DataTable of vehicel type with name</returns>
    public static DataTable GetActiveVehicleTypes()
    {
        string strsql = "SELECT type_code AS code,type_name AS codename FROM webx_vehicle_type WHERE ISNULL(activeflag,'N')='Y' ORDER BY type_name";
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    }

    /// <summary>
    /// Gets Name of Customer From Customer Master
    /// </summary>
    /// <returns></returns>
    public static string GetCustomerName(string custcode)
    {
        string strsql = "SELECT custnm AS custname FROM webx_custhdr ";
        strsql = strsql + " WHERE custcd='" + custcode + "'";
        try
        {
            return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static string GetNewMRCode(string loccode, string finyear4d, SqlTransaction trn)
    {
        string newmrno = "";

        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);
            newmrno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_GET_NEXT_MR_CODE", paramsToStore));
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return newmrno;
    }

    public static string GetNewDocumentCode(string doctype, string loccode, string finyear4d, SqlTransaction trn)
    {
        string newmrno = "";

        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[3];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@doctype", loccode, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);
            newmrno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_GET_NEXT_DOCUMENT_CODE", paramsToStore));
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return newmrno;
    }

    public static string GetNewBillCode(string billtype, string loccode, string flagbus, string businesstype, string finyear4d, SqlTransaction trn)
    {
        string newmrno = "";

        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[5];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@billtype", billtype, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@flagbustypewise", flagbus, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@businesstype", businesstype, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);

            newmrno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_GET_NEXT_BILL_CODE", paramsToStore));
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return newmrno;
    }

    public static string GetLocationString(string loccode)
    {
        string sqlstr = "SELECT UPPER(loccode) + ' : '+ UPPER(locname) AS location FROM webx_location WHERE loccode='" + loccode + "'";
        return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
    }

    /// <summary>
    /// Gets Server Date in [dd/MM/yyyy] Format
    /// </summary>
    /// <returns>string in [dd/MM/yyyy] format</returns>
    public static string GetServerDate()
    {
        string sqlstr = "SELECT TOP 1 date=CONVERT(VARCHAR,GETDATE(),103)";
        return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
    }

    /// <summary>
    /// Gets Server Hour in [hh] Format
    /// </summary>
    /// <returns>string in [hh] format</returns>
    public static string GetServerHour()
    {
        string sqlstr = "SELECT CONVERT(VARCHAR(2), GETDATE(), 108)";
        return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
    }

    public static string GetServerMinute()
    {
        string sqlstr = "SELECT SUBSTRING(CONVERT(VARCHAR, GETDATE(), 108),4,2)";
        return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
    }

    /// <summary>
    /// Get Billno From Docket Number and Payment Basis
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <param name="paybas">Payment Basis</param>
    /// <returns></returns>
    public static string GetDocketBillNo(string dockno, string paybas)
    {
        string sqlstr = "SELECT TOP 1 m.billno FROM webx_billdet d,webx_billmst m";
        sqlstr = sqlstr + " WHERE m.billno=d.billno AND ISNULL(m.bill_cancel,'N')='N'";
        sqlstr = sqlstr + " AND d.dockno='" + dockno + "' AND paybas='" + paybas.Substring(2, 1) + "'";
        string billno = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        return billno;
    }


    /// <summary>
    /// Gets Active Data From General Master based on Master Code
    /// </summary>
    /// <param name="codetype">Master Code</param>
    /// <returns>DataTable</returns>
    public static DataTable GetActiveGeneralMaster(string mastercode)
    {
        string strsql = "SELECT codeid,codedesc FROM webx_master_general ";
        strsql = strsql + " WHERE codetype='" + mastercode + "' AND statuscode='Y' ORDER BY CODEDESC";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        }
        catch (Exception ex)
        {
            dt.Columns.Add("codeid", typeof(string));
            dt.Columns.Add("codedesc", typeof(string));
        }
        return dt;
    }

    /// <summary>
    /// Gets Master Name From CodeTypeMaster Table for a Master Code
    /// </summary>
    /// <param name="codetype">Master Code</param>
    /// <returns>Master Name</returns>
    public static string GetCodeTypeName(string mastercode)
    {
        string strsql = "SELECT TOP 1 headerdesc FROM webx_master_codetypes";
        strsql = strsql + " WHERE headercode='" + mastercode + "'";

        try
        {
            return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    /// <summary>
    /// Get General Master Code description
    /// </summary>
    /// <param name="mastercode">mastercode</param>
    /// <param name="codeid">codeid</param>
    /// <returns>Master Description</returns>
    public static string GetGeneralMasterName(string mastercode, string codeid)
    {
        string strsql = "SELECT TOP 1 codedesc FROM webx_master_general";
        strsql = strsql + " WHERE codetype='" + mastercode + "' AND codeid='" + codeid + "'";

        try
        {
            return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        }
        catch (Exception ex)
        {
            return "";
        }
    }
    /// <summary>
    /// Gets Valid Data From General Master based on Master Code
    /// </summary>
    /// <param name="codetype">Master Code</param>
    /// <returns>DataTable</returns>
    public static DataTable GetValidGeneralMaster(string mastercode)
    {
        string strsql = "SELECT codeid,codedesc FROM webx_master_general ";
        strsql = strsql + " WHERE codetype='" + mastercode + "'";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        }
        catch (Exception ex)
        {
            dt.Columns.Add("codeid", typeof(string));
            dt.Columns.Add("codedesc", typeof(string));
        }
        return dt;
    }

    /// <summary>
    /// Gets Valid Data From General Master based on Master Code
    /// </summary>
    /// <param name="codetype">Master Code</param>
    /// <returns>DataTable</returns>
    public static DataTable GetValidAccounts()
    {
        string strsql = "SELECT acccode,accdesc FROM webx_acctinfo WHERE acccategory='BANK'";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        }
        catch (Exception ex)
        {
            dt.Columns.Add("acccode", typeof(string));
            dt.Columns.Add("accdesc", typeof(string));
        }
        return dt;
    }

    public static DataTable GetActiveAccounts()
    {
        string strsql = "SELECT acccode,accdesc FROM webx_acctinfo WHERE activeflag='Y'";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        }
        catch (Exception ex)
        {
            dt.Columns.Add("acccode", typeof(string));
            dt.Columns.Add("accdesc", typeof(string));
        }
        return dt;
    }

    /// <summary>
    /// Returns Table of Accounts, Filtered by Account Category
    /// </summary>
    /// <param name="Acccat">Account Category</param>
    /// <returns>Table of Account</returns>
    public static DataTable GetActiveAccounts(string acccat)
    {
        string strsql = "SELECT acccode,accdesc FROM webx_acctinfo WHERE acccategory='" + acccat + "' AND activeflag='Y'";
        DataTable dt = new DataTable();
        try
        {
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        }
        catch (Exception ex)
        {
            dt.Columns.Add("acccode", typeof(string));
            dt.Columns.Add("accdesc", typeof(string));
        }
        return dt;
    }

    public static string GetBillStatus(string billno)
    {
        string sqlstr = "SELECT UPPER(billstatus) AS billstatus FROM webx_billmst WHERE billno='" + billno + "'";
        string status = "";
        try
        {
            status = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return status;
    }

    public static DataTable GetCustLocAddress(string custcode, string loccode)
    {
        string strsql = " SELECT DISTINCT addid,(ADDRESS + '~' + city + '~' + CONVERT(VARCHAR,pincode) + '~' +";
        strsql = strsql + " CONVERT(VARCHAR,phoneno) + '~' + email) AS address";
        strsql = strsql + " FROM webx_location l,webx_master_custaddresses ca";
        strsql = strsql + " WHERE ca.city=l.loccity AND custcd='" + custcode + "' AND L.loccode='" + loccode + "'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        return dt;
    }


    public static DataTable GetCustCityAddress(string custcode, string cityname)
    {
        string strsql = " SELECT DISTINCT addid,(ADDRESS + '~' + city + '~' + CONVERT(VARCHAR,pincode) + '~' +";
        strsql = strsql + " CONVERT(VARCHAR,phoneno) + '~' + email) AS address";
        strsql = strsql + " FROM webx_master_custaddresses ";
        strsql = strsql + " WHERE custcd='" + custcode + "' AND city='" + cityname + "'";
        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
        return dt;
    }


}
