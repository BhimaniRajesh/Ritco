using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.Data.Sql;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;
/// <summary>
/// Summary description for VendorCrossingContractController
/// </summary>
public class VendorCrossingContractController
{
	public VendorCrossingContractController()
	{
		
	}

    public static VendorCorssingContract FillObject(DataRow dr)
    {
        VendorCorssingContract vcc = new VendorCorssingContract();
        if (dr["ContractID"] != DBNull.Value)
            vcc.ContractID = dr["ContractID"].ToString();
        if (dr["VendorCode"] != DBNull.Value)
            vcc.VendorCode = dr["VendorCode"].ToString();
        if (dr["ActiveFlag"] != DBNull.Value)
            vcc.ActiveFlag = dr["ActiveFlag"].ToString();
        if (dr["EntryBy"] != DBNull.Value)
            vcc.EntryBy = dr["EntryBy"].ToString();
        if (dr["EntryDate"] != DBNull.Value)
            vcc.EntryDate = Convert.ToDateTime(dr["EntryDate"]);
        if (dr["UpdatedBy"] != DBNull.Value)
            vcc.UpdatedBy = dr["UpdatedBy"].ToString();
        if (dr["UpdatedDate"] != DBNull.Value)
            vcc.UpdatedDate = Convert.ToDateTime(dr["UpdatedDate"]);
        vcc.Details = new List<VendorCorssingContractDet>();
        return vcc;
    }

    public static string Insert(VendorCorssingContract vcc, SqlTransaction trn)
    {
        string strRet = "";
        try
        {          
            SqlParameter[] paramsToStore = new SqlParameter[7];

            paramsToStore[0] = new SqlParameter("@ContractID", SqlDbType.VarChar);
            paramsToStore[0].Value = vcc.ContractID;
            paramsToStore[0].Size = 50;
            //paramsToStore[0].Direction = ParameterDirection.Output;
            paramsToStore[1] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
            paramsToStore[1].Value = vcc.VendorCode.Trim();
            paramsToStore[1].Size = 50;
            paramsToStore[2] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            paramsToStore[2].Value = vcc.ActiveFlag;
            paramsToStore[2].Size = 50;
            paramsToStore[3] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
            paramsToStore[3].Size = 50;
            if (vcc.EntryBy != "")
                paramsToStore[3].Value = vcc.EntryBy;
            else
                paramsToStore[3].Value = DBNull.Value;            
            paramsToStore[4] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
            if (vcc.EntryDate < DateTime.MaxValue && vcc.EntryDate > DateTime.MinValue)
                paramsToStore[4].Value = vcc.EntryDate;
            else
                paramsToStore[4].Value = DBNull.Value;            
            paramsToStore[5] = new SqlParameter("@UpdatedBy", SqlDbType.VarChar);
            paramsToStore[5].Size = 50;
            if (vcc.UpdatedBy != "")
                paramsToStore[5].Value = vcc.UpdatedBy;
            else
                paramsToStore[5].Value = DBNull.Value;
            paramsToStore[6] = new SqlParameter("@UpdatedDate", SqlDbType.DateTime);            
            if (vcc.UpdatedDate < DateTime.MaxValue && vcc.UpdatedDate > DateTime.MinValue)
                paramsToStore[6].Value = vcc.UpdatedDate;
            else
                paramsToStore[6].Value = DBNull.Value;

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_HDR_Insert", paramsToStore);
            strRet = vcc.ContractID;

            if (vcc.Details != null)
            {
                foreach (VendorCorssingContractDet vcd in vcc.Details)
                {
                    vcd.ContractID = strRet;
                    VendorCrossingContractDetailController.Insert(vcd, trn);
                }
            }
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return strRet;
    }
    public static string Insert(VendorCorssingContract vcc)
    {
        string strRet = "";
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            strRet = Insert(vcc, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();
            strRet = "";
            throw excp;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return strRet;
    }

    public static bool Update(VendorCorssingContract vcc, SqlTransaction trn)
    {
        bool bchk = false;
        try
        {            
            SqlParameter[] paramsToStore = new SqlParameter[5];

            paramsToStore[0] = new SqlParameter("@ContractID", SqlDbType.VarChar);
            paramsToStore[0].Value = vcc.ContractID;
            paramsToStore[0].Size = 50;
            
            paramsToStore[1] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
            paramsToStore[1].Value = vcc.VendorCode;
            paramsToStore[1].Size = 50;
            paramsToStore[2] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
            paramsToStore[2].Value = vcc.ActiveFlag;
            paramsToStore[2].Size = 50;            
            paramsToStore[3] = new SqlParameter("@UpdatedBy", SqlDbType.VarChar);
            paramsToStore[3].Value = vcc.UpdatedBy;
            paramsToStore[3].Size = 50;
            paramsToStore[4] = new SqlParameter("@UpdatedDate", SqlDbType.DateTime);
            paramsToStore[4].Value = vcc.UpdatedDate;

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_HDR_Update", paramsToStore);
            if (vcc.Details != null)
            {
                foreach (VendorCorssingContractDet vcd in vcc.Details)
                {
                    if (vcd.Deleted)
                    {
                        VendorCrossingContractDetailController.Delete(vcd, trn);
                    }
                    else
                    {
                        if (vcd.ID <= 0)
                            VendorCrossingContractDetailController.Insert(vcd, trn);
                        else
                            VendorCrossingContractDetailController.Update(vcd, trn);
                        //if (!VendorCrossingContractDetailController.IsExist(vcd, trn))
                        //    VendorCrossingContractDetailController.Insert(vcd, trn);
                        //else
                        //    VendorCrossingContractDetailController.Update(vcd, trn);
                    }
                }
            }
            
            bchk = true;
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return bchk;
    }
    public static bool Update(VendorCorssingContract vcc)
    {
        bool bchk = false;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            bchk = Update(vcc, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();
            throw excp;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return bchk;
    }

    public static string GenerateNewCode()
    {
        string strRet = "";
        string sp = "webx_Generate_VendorCrossing_ContractCode";

        object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp);
        if (obj != null)
            strRet = obj.ToString();
        return strRet;
    }
    public static string GenerateNewCode(SqlTransaction trn)
    {
        string strRet = "";
        string sp = "webx_Generate_VendorCrossing_ContractCode";

        object obj = SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, sp);
        if (obj != null)
            strRet = obj.ToString();
        return strRet;
    }

    public static VendorCorssingContract GetByVendorCode(string VendorCode)
    {
        VendorCorssingContract vcc = new VendorCorssingContract();
        try
        {
            string strsql = "SELECT TOP 1 * FROM webx_vendor_Crossing_Contract_HDR WHERE isnull(ActiveFlag,'N')='Y' AND VendorCode='" + VendorCode.Trim() + "'";
            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["ContractID"].ToString() != "")
                    {
                        vcc = FillObject(dr);
                        vcc.Details = VendorCrossingContractDetailController.GetByContractID(vcc.ContractID);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            vcc = new VendorCorssingContract();
            throw ex;
        }
        return vcc;
    }
    public static VendorCorssingContract GetByVendorCode(string VendorCode, SqlTransaction trn)
    {
        VendorCorssingContract vcc = new VendorCorssingContract();
        try
        {
            string strsql = "SELECT TOP 1 * FROM webx_vendor_Crossing_Contract_HDR WHERE isnull(ActiveFlag,'N')='Y' AND VendorCode='" + VendorCode + "'";

            DataSet ds = SqlHelper.ExecuteDataset(trn, CommandType.Text, strsql);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["ContractID"].ToString() != "")
                    {
                        vcc = FillObject(dr);
                        vcc.Details = VendorCrossingContractDetailController.GetByContractID(vcc.ContractID,trn);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            vcc = new VendorCorssingContract();
            throw ex;
        }
        return vcc;
    }

    private static bool IsExist(VendorCorssingContract vcc,  SqlTransaction trn)
    {
        bool bchk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];
            paramsToStore[0] = new SqlParameter("@ContractID", SqlDbType.VarChar);
            if (vcc.ContractID != "")
                paramsToStore[0].Value = vcc.ContractID;
            else
                paramsToStore[0].Value = DBNull.Value;
            paramsToStore[0].Size = 50;
            paramsToStore[1] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
            if (vcc.VendorCode != "")
                paramsToStore[1].Value = vcc.VendorCode;
            else
                paramsToStore[1].Value = DBNull.Value;
            paramsToStore[1].Size = 50;

            object obj = SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_HDR_IsExist", paramsToStore);
            if(obj != null)
            {
                int cnt = Convert.ToInt32(obj);
                if (cnt > 0)
                    bchk = true;
            }
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return bchk;
    }
    public static bool IsExist(VendorCorssingContract vcc)
    {
        bool bchk = false;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            bchk = IsExist(vcc, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();
            throw excp;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return bchk;
    }
   
}
public class VendorCrossingContractDetailController
{
    public VendorCrossingContractDetailController()
    {

    }

    public static VendorCorssingContractDet FillObject(DataRow dr)
    {
        VendorCorssingContractDet vcc = new VendorCorssingContractDet();
        if (dr["ID"] != DBNull.Value)
            vcc.ID = Convert.ToDouble(dr["ID"]);
        if (dr["ContractID"] != DBNull.Value)
            vcc.ContractID = dr["ContractID"].ToString();
        if (dr["VendorCode"] != DBNull.Value)
            vcc.VendorCode = dr["VendorCode"].ToString();
        if (dr["Origin"] != DBNull.Value)
            vcc.Origin = dr["Origin"].ToString();
        if (dr["DestCity"] != DBNull.Value)
            vcc.DestCity = dr["DestCity"].ToString();
        if (dr["Ratetype"] != DBNull.Value)
            vcc.RateType = dr["Ratetype"].ToString();
        if (dr["Rate"] != DBNull.Value)
            vcc.Rate = Convert.ToDouble(dr["Rate"]);
        if (dr["doordeliveryCharge"] != DBNull.Value)
            vcc.DoorDeliveryCharge = Convert.ToDouble(dr["doordeliveryCharge"]);
        if (dr["otherCharge"] != DBNull.Value)
            vcc.OtherCharge = Convert.ToDouble(dr["otherCharge"]);
        if (dr["ActiveFlag"] != DBNull.Value)
            vcc.ActiveFlag = dr["ActiveFlag"].ToString();
        if (dr["EntryBy"] != DBNull.Value)
            vcc.EntryBy = dr["EntryBy"].ToString();
        if (dr["EntryDate"] != DBNull.Value)
            vcc.EntryDate = Convert.ToDateTime(dr["EntryDate"]);
        if (dr["UpdatedBy"] != DBNull.Value)
            vcc.UpdatedBy = dr["UpdatedBy"].ToString();
        if (dr["UpdatedDate"] != DBNull.Value)
            vcc.UpdatedDate = Convert.ToDateTime(dr["UpdatedDate"]);
        return vcc;
    }

    public static double Insert(VendorCorssingContractDet cr, SqlTransaction trn)
    {
        double iRet = -1;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[14];
            
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@ID", Convert.ToDecimal(cr.ID), SqlDbType.Decimal, ParameterDirection.Output);
            if( cr.ContractID != "")
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@ContractID", cr.ContractID, SqlDbType.VarChar, 50);
            else
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@ContractID", DBNull.Value);
            if (cr.VendorCode != "")
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@VendorCode", cr.VendorCode.Trim(), SqlDbType.VarChar, 50);
            else
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@VendorCode", DBNull.Value);
            if (cr.Origin != "")
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Origin", cr.Origin, SqlDbType.VarChar, 50);
            else
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Origin", DBNull.Value);
            if (cr.DestCity != "")
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@DestCity", cr.DestCity, SqlDbType.VarChar, 50);
            else
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@DestCity", DBNull.Value);
            if (cr.RateType != "")
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@Ratetype", cr.RateType, SqlDbType.VarChar, 50);
            else
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@Ratetype", DBNull.Value);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@Rate", Convert.ToDecimal(cr.Rate), SqlDbType.Decimal);            
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@DoordeliveryCharge", Convert.ToDecimal(cr.DoorDeliveryCharge), SqlDbType.Decimal);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@OtherCharge", Convert.ToDecimal(cr.OtherCharge), SqlDbType.Decimal);
            if (cr.ActiveFlag != "")
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@ActiveFlag", cr.ActiveFlag, SqlDbType.VarChar, 50);
            else
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@ActiveFlag", "Y", SqlDbType.VarChar, 50);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@EntryBy", cr.EntryBy, SqlDbType.VarChar, 50);
            if(cr.EntryDate < DateTime.MaxValue && cr.EntryDate > DateTime.MinValue)
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@EntryDate", cr.EntryDate, SqlDbType.DateTime);
            else
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@UpdatedBy", cr.UpdatedBy, SqlDbType.VarChar, 50);
            if (cr.UpdatedDate < DateTime.MaxValue && cr.UpdatedDate > DateTime.MinValue)
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@UpdatedDate", cr.UpdatedDate, SqlDbType.DateTime);
            else
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@UpdatedDate", DBNull.Value);            
            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_Det_Insert", paramsToStore);
            iRet = Convert.ToDouble(paramsToStore[0].Value);
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return iRet;
    }
    public static double Insert(VendorCorssingContractDet cr)
    {
        double iRet = -1;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            iRet = Insert(cr, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();
            iRet = -1;
            throw excp;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return iRet;
    }

    public static bool Update(VendorCorssingContractDet cr, SqlTransaction trn)
    {
        bool bRet = false;
        try
        {
             SqlParameter[] paramsToStore = new SqlParameter[14];
             
             paramsToStore[0] = new SqlParameter("@ID", SqlDbType.Decimal);
             paramsToStore[0].Value = cr.ID;
             paramsToStore[1] = new SqlParameter("@ContractID", SqlDbType.VarChar);
             paramsToStore[1].Value = cr.ContractID;
             paramsToStore[1].Size=50;
             paramsToStore[2] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
             paramsToStore[2].Value = cr.VendorCode;
             paramsToStore[2].Size=50;
             paramsToStore[3] = new SqlParameter("@Origin", SqlDbType.VarChar);
             paramsToStore[3].Value = cr.Origin;
             paramsToStore[3].Size=50;
             paramsToStore[4] = new SqlParameter("@DestCity", SqlDbType.VarChar);
             paramsToStore[4].Value = cr.DestCity;
             paramsToStore[4].Size=50;
             paramsToStore[5] = new SqlParameter("@Ratetype", SqlDbType.VarChar);
             paramsToStore[5].Value = cr.RateType;
             paramsToStore[5].Size=50;
             paramsToStore[6] = new SqlParameter("@Rate", SqlDbType.Decimal);
             paramsToStore[6].Value = cr.Rate;
             paramsToStore[7] = new SqlParameter("@DoordeliveryCharge", SqlDbType.Decimal);
             paramsToStore[7].Value = cr.DoorDeliveryCharge;
             paramsToStore[8] = new SqlParameter("@OtherCharge", SqlDbType.Decimal);
             paramsToStore[8].Value = cr.OtherCharge;
             paramsToStore[9] = new SqlParameter("@ActiveFlag", SqlDbType.VarChar);
             paramsToStore[9].Value = cr.ActiveFlag;
             paramsToStore[9].Size=50;
             paramsToStore[10] = new SqlParameter("@EntryBy", SqlDbType.VarChar);
             paramsToStore[10].Value = cr.EntryBy;
             paramsToStore[10].Size=50;
             paramsToStore[11] = new SqlParameter("@EntryDate", SqlDbType.DateTime);
             paramsToStore[11].Value = cr.EntryDate;
             paramsToStore[12] = new SqlParameter("@UpdatedBy", SqlDbType.VarChar);
             paramsToStore[12].Value = cr.UpdatedBy;
             paramsToStore[12].Size=50;
             paramsToStore[13] = new SqlParameter("@UpdatedDate", SqlDbType.DateTime);
             paramsToStore[13].Value = cr.UpdatedDate;
             SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_Det_Update", paramsToStore);

             bRet = true; 
        }
        catch (Exception excp)
        {
            bRet = false;
            throw excp;
        }
        return bRet;
    }
    public static bool Update(VendorCorssingContractDet cr)
    {
        bool bRet = false;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            bRet = Update(cr, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();                
            bRet = false;
            throw excp;
        }
        finally 
        {
            if (conn.State == ConnectionState.Open)           
                conn.Close();
            conn.Dispose();
        }
        return bRet;
    }

    public static List<VendorCorssingContractDet> GetByContractID(string ContractID, SqlTransaction trn)
    {
        string sp = "SELECT * FROM webx_vendor_Crossing_Contract_Det WHERE isnull(ActiveFlag,'N')='Y' AND ContractID='" + ContractID + "'";
        List<VendorCorssingContractDet> ListRet = new List<VendorCorssingContractDet>();
        try
        {
            DataSet ds = SqlHelper.ExecuteDataset(trn, CommandType.Text, sp);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["ContractID"].ToString() != "")
                        ListRet.Add(FillObject(dr));
                }
            }
        }
        catch (Exception ex)
        {
            ListRet = new List<VendorCorssingContractDet>();
            throw ex;
        }
        return ListRet;
    }
    public static List<VendorCorssingContractDet> GetByContractID(string ContractID)
    {
        string sp = "SELECT * FROM webx_vendor_Crossing_Contract_Det WHERE isnull(ActiveFlag,'N')='Y' AND ContractID='" + ContractID + "'";
        List<VendorCorssingContractDet> ListRet = new List<VendorCorssingContractDet>();
        try
        {
            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sp);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["ContractID"].ToString() != "")
                        ListRet.Add(FillObject(dr));
                }
            }
        }
        catch (Exception ex)
        {
            ListRet = new List<VendorCorssingContractDet>();
            throw ex;
        }
        return ListRet;
    }
    public static List<VendorCorssingContractDet> GetByVendorCode(string VendorCode)
    {
        string sp = "usp_Vendor_Contract_Crossing_GetByVendorCode";
        List<VendorCorssingContractDet> ListRet = new List<VendorCorssingContractDet>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", VendorCode, SqlDbType.VarChar, 50);

            DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp, paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["ContractID"].ToString() != "")
                        ListRet.Add(FillObject(dr));
                }
            }
        }
        catch (Exception ex)
        {
            ListRet = new List<VendorCorssingContractDet>();
            throw ex;
        }
        return ListRet;
    }
    public static List<VendorCorssingContractDet> GetByVendorCode(string VendorCode, SqlTransaction trn)
    {
        string sp = "usp_Vendor_Contract_Crossing_GetByVendorCode";
        List<VendorCorssingContractDet> ListRet = new List<VendorCorssingContractDet>();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", VendorCode, SqlDbType.VarChar, 50);

            DataSet ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, sp, paramsToStore);
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["ContractID"].ToString() != "")
                        ListRet.Add(FillObject(dr));
                }
            }
        }
        catch (Exception ex)
        {
            ListRet = new List<VendorCorssingContractDet>();
            throw ex;
        }
        return ListRet;
    }

    public static bool IsExist(VendorCorssingContractDet vcd, SqlTransaction trn)
    {
        bool bchk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[5];

            paramsToStore[0] = new SqlParameter("@ContractID", SqlDbType.VarChar);
            paramsToStore[0].Value = vcd.ContractID;
            paramsToStore[0].Size = 50;
            paramsToStore[1] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
            paramsToStore[1].Value = vcd.VendorCode;
            paramsToStore[1].Size = 50;
            paramsToStore[2] = new SqlParameter("@Origin", SqlDbType.VarChar);
            paramsToStore[2].Value = vcd.Origin;
            paramsToStore[2].Size = 50;
            paramsToStore[3] = new SqlParameter("@DestCity", SqlDbType.VarChar);
            paramsToStore[3].Value = vcd.DestCity;
            paramsToStore[3].Size = 100;
            paramsToStore[4] = new SqlParameter("@RateType", SqlDbType.VarChar);
            paramsToStore[4].Value = vcd.RateType;
            paramsToStore[4].Size = 50;

            object obj = SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_DET_IsExist", paramsToStore);
            if (obj != null)
            {
                int cnt = Convert.ToInt32(obj);
                if (cnt > 0)
                    bchk = true;
            }
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return bchk;
    }
    public static bool IsExist(VendorCorssingContractDet vcd)
    {
        bool bchk = false;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            bchk = IsExist(vcd, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();
            throw excp;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return bchk;
    }

    public static bool Delete(VendorCorssingContractDet vcd, SqlTransaction trn)
    {
        bool bchk = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[5];

            paramsToStore[0] = new SqlParameter("@ContractID", SqlDbType.VarChar);
            paramsToStore[0].Value = vcd.ContractID;
            paramsToStore[0].Size = 50;
            paramsToStore[1] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
            paramsToStore[1].Value = vcd.VendorCode;
            paramsToStore[1].Size = 50;
            paramsToStore[2] = new SqlParameter("@Origin", SqlDbType.VarChar);
            paramsToStore[2].Value = vcd.Origin;
            paramsToStore[2].Size = 50;
            paramsToStore[3] = new SqlParameter("@DestCity", SqlDbType.VarChar);
            paramsToStore[3].Value = vcd.DestCity;
            paramsToStore[3].Size = 100;
            paramsToStore[4] = new SqlParameter("@RateType", SqlDbType.VarChar);
            paramsToStore[4].Value = vcd.RateType;
            paramsToStore[4].Size = 50;

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "webx_vendor_Crossing_Contract_DET_Delete", paramsToStore);
            bchk = true;
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return bchk;
    }
    public static bool Delete(VendorCorssingContractDet vcd)
    {
        bool bchk = false;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        try
        {
            bchk = Delete(vcd, trn);
        }
        catch (Exception excp)
        {
            if (conn.State == ConnectionState.Open)
                trn.Rollback();
            throw excp;
        }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return bchk;
    }
}
