using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for PasswordPolicyController
    /// </summary>
    public class PasswordPolicyController
    {
        public PasswordPolicyController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static PasswordPolicy FillObject(DataRow dr)
        {
            PasswordPolicy pp = new PasswordPolicy();
            try
            {
                if (dr[(int)PasswordPolicy_Columns.ID] != DBNull.Value)
                    pp.ID = Convert.ToInt32(dr[(int)PasswordPolicy_Columns.ID]);
                if (dr[(int)PasswordPolicy_Columns.CodeID] != DBNull.Value)
                    pp.CodeID = dr[(int)PasswordPolicy_Columns.CodeID].ToString();
                if (dr[(int)PasswordPolicy_Columns.CodeDesc] != DBNull.Value)
                    pp.CodeDesc = dr[(int)PasswordPolicy_Columns.CodeDesc].ToString();
                if (dr[(int)PasswordPolicy_Columns.DefaultValue] != DBNull.Value)
                    pp.DefaultValue = dr[(int)PasswordPolicy_Columns.DefaultValue].ToString();
                if (dr[(int)PasswordPolicy_Columns.SetValue] != DBNull.Value)
                    pp.SetValue = dr[(int)PasswordPolicy_Columns.SetValue].ToString();
                if (dr[(int)PasswordPolicy_Columns.Active] != DBNull.Value)
                    pp.Active = dr[(int)PasswordPolicy_Columns.Active].ToString();
                if (dr[(int)PasswordPolicy_Columns.EntryBy] != DBNull.Value)
                    pp.EntryBy = dr[(int)PasswordPolicy_Columns.EntryBy].ToString();
                if (dr[(int)PasswordPolicy_Columns.EntryDate] != DBNull.Value)
                    pp.EntryDate = Convert.ToDateTime(dr[(int)PasswordPolicy_Columns.EntryDate]);
                if (dr[(int)PasswordPolicy_Columns.UpdateBy] != DBNull.Value)
                    pp.UpdateBy = dr[(int)PasswordPolicy_Columns.UpdateBy].ToString();
                if (dr[(int)PasswordPolicy_Columns.UpdateDate] != DBNull.Value)
                    pp.UpdateDate = Convert.ToDateTime(dr[(int)PasswordPolicy_Columns.UpdateDate]);              
            }
            catch (Exception ex)
            { }
            return pp;
        }

        public static int Insert(PasswordPolicy objPP)
        {
            int iRet = 0;
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[10];               
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ID", SqlDbType.Int, ParameterDirection.Output);
                if (!string.IsNullOrEmpty(objPP.CodeID.Trim()))
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@CodeID", objPP.CodeID, SqlDbType.VarChar, 50);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@CodeID", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.CodeDesc.Trim()))
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@CodeDesc", objPP.CodeDesc, SqlDbType.VarChar, 200);
                else
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@CodeDesc", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.DefaultValue.Trim()))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@DefaultValue", objPP.DefaultValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@DefaultValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.SetValue.Trim()))
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@SetValue", objPP.SetValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@SetValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.Active.Trim()))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Active", objPP.Active, SqlDbType.VarChar, 1);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Active", DBNull.Value);
                if (objPP.EntryDate > DateTime.MinValue && objPP.EntryDate < DateTime.MaxValue)
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@EntryDate", objPP.EntryDate, SqlDbType.DateTime);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.EntryBy.Trim()))
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryBy", objPP.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (objPP.UpdateDate > DateTime.MinValue && objPP.UpdateDate < DateTime.MaxValue)
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@UpdateDate", objPP.UpdateDate, SqlDbType.DateTime);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@UpdateDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.UpdateBy.Trim()))
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateBy", objPP.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);

                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Insert", paramsToStore);
                objPP.ID = Convert.ToInt32(paramsToStore[0].Value);
                iRet = objPP.ID;
            }
            catch (Exception excp)
            {
            }
            return iRet;
        }
        public static bool Update(PasswordPolicy objPP)
        {
            bool bChk = false;
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[11];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ID", objPP.ID, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@CodeID", objPP.CodeID, SqlDbType.VarChar, 50);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@OriginalCodeID", objPP.CodeID, SqlDbType.VarChar, 50);               

                if (!string.IsNullOrEmpty(objPP.CodeDesc.Trim()))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CodeDesc", objPP.CodeDesc, SqlDbType.VarChar, 200);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CodeDesc", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.DefaultValue.Trim()))
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@DefaultValue", objPP.DefaultValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@DefaultValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.SetValue.Trim()))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@SetValue", objPP.SetValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@SetValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.Active.Trim()))
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Active", objPP.Active, SqlDbType.VarChar, 1);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Active", DBNull.Value);
                if (objPP.EntryDate > DateTime.MinValue && objPP.EntryDate < DateTime.MaxValue)
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryDate", objPP.EntryDate, SqlDbType.DateTime);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.EntryBy.Trim()))
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@EntryBy", objPP.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (objPP.UpdateDate > DateTime.MinValue && objPP.UpdateDate < DateTime.MaxValue)
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateDate", objPP.UpdateDate, SqlDbType.DateTime);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.UpdateBy.Trim()))
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@UpdateBy", objPP.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);

                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Update", paramsToStore);
                bChk = true;
            }
            catch (Exception excp)
            { 
            }
            return bChk;
        }
        public static List<PasswordPolicy> Find(PasswordPolicy objPP, bool searchUsingOR)
        {
            List<PasswordPolicy> listPP = new List<PasswordPolicy>();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[11];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@SearchUsingOR", searchUsingOR, SqlDbType.Bit);
                if (objPP.ID > 0)
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@ID", objPP.ID, SqlDbType.Int);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@ID", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.CodeDesc.Trim()))
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@CodeID", objPP.CodeID, SqlDbType.VarChar, 50);
                else
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@CodeID", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.CodeDesc.Trim()))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CodeDesc", objPP.CodeDesc, SqlDbType.VarChar, 200);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CodeDesc", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.DefaultValue.Trim()))
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@DefaultValue", objPP.DefaultValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@DefaultValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.SetValue.Trim()))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@SetValue", objPP.SetValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@SetValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.Active.Trim()))
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Active", objPP.Active, SqlDbType.VarChar, 1);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Active", DBNull.Value);
                if (objPP.EntryDate > DateTime.MinValue && objPP.EntryDate < DateTime.MaxValue)
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryDate", objPP.EntryDate, SqlDbType.DateTime);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.EntryBy.Trim()))
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@EntryBy", objPP.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (objPP.UpdateDate > DateTime.MinValue && objPP.UpdateDate < DateTime.MaxValue)
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateDate", objPP.UpdateDate, SqlDbType.DateTime);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.UpdateBy.Trim()))
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@UpdateBy", objPP.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);

                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Find", paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        PasswordPolicy p = FillObject(dr);
                        if (p.ID > 0)
                            listPP.Add(p);
                    }
                }
            }
            catch (Exception excp)
            {
            }
            return listPP;
        }
        public static bool Delete(string codeID)
        {
            bool bChk = false;
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@CodeID",codeID, SqlDbType.VarChar,50);

                SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Delete", paramsToStore);
                bChk = true;
            }
            catch (Exception excp)
            { }
            return bChk;
        }
        public static List<PasswordPolicy> GetAll()
        {
            List<PasswordPolicy> listPP = new List<PasswordPolicy>();
            try
            {                
                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Get_List");
                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        PasswordPolicy p = FillObject(dr);
                        if (p.ID > 0)
                            listPP.Add(p);
                    }
                }
            }
            catch (Exception excp)
            {
            }
            return listPP;
        }
        public static List<PasswordPolicy> Get(string WhereClause, string OrderBy)
        {
            List<PasswordPolicy> listPP = new List<PasswordPolicy>();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@WhereClause", WhereClause, SqlDbType.VarChar, 2000);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@OrderBy", OrderBy, SqlDbType.VarChar, 2000);

                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Get", paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        PasswordPolicy p = FillObject(dr);
                        if (p.ID > 0)
                            listPP.Add(p);
                    }
                }
            }
            catch (Exception excp)
            {
            }
            return listPP;
        }
        public static PasswordPolicy GetByCodeID(string codeID)
        {
            PasswordPolicy pp = new PasswordPolicy();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@CodeID", codeID, SqlDbType.VarChar, 50);

                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_GetByCodeID", paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                        pp = FillObject(ds.Tables[0].Rows[0]);
                }
            }
            catch (Exception excp)
            {}
            return pp;
        }
        public static List<PasswordPolicy> GetPaged(string WhereClause, string OrderBy, int PageIndex, int PageSize)
        {
            List<PasswordPolicy> listPP = new List<PasswordPolicy>();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[4];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@WhereClause", WhereClause, SqlDbType.VarChar, 2000);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@OrderBy", OrderBy, SqlDbType.VarChar, 2000);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@PageIndex", PageIndex, SqlDbType.Int);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@PageSize", PageSize, SqlDbType.Int);

                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_WebX_Password_Policy_GetPaged", paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        PasswordPolicy p = FillObject(dr);
                        if (p.ID > 0)
                            listPP.Add(p);
                    }
                }
            }
            catch (Exception excp)
            {
            }
            return listPP;
        }
        
        public static int Insert(PasswordPolicy objPP, SqlTransaction trans)
        {
            int iRet = 0;
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[10];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ID", SqlDbType.Int, ParameterDirection.Output);
                if (!string.IsNullOrEmpty(objPP.CodeID.Trim()))
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@CodeID", objPP.CodeID, SqlDbType.VarChar, 50);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@CodeID", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.CodeDesc.Trim()))
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@CodeDesc", objPP.CodeDesc, SqlDbType.VarChar, 200);
                else
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@CodeDesc", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.DefaultValue.Trim()))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@DefaultValue", objPP.DefaultValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@DefaultValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.SetValue.Trim()))
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@SetValue", objPP.SetValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@SetValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.Active.Trim()))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Active", objPP.Active, SqlDbType.VarChar, 1);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Active", DBNull.Value);
                if (objPP.EntryDate > DateTime.MinValue && objPP.EntryDate < DateTime.MaxValue)
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@EntryDate", objPP.EntryDate, SqlDbType.DateTime);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.EntryBy.Trim()))
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryBy", objPP.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (objPP.UpdateDate > DateTime.MinValue && objPP.UpdateDate < DateTime.MaxValue)
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@UpdateDate", objPP.UpdateDate, SqlDbType.DateTime);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@UpdateDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.UpdateBy.Trim()))
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateBy", objPP.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);

                SqlHelper.ExecuteNonQuery(trans, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Insert", paramsToStore);
                objPP.ID = Convert.ToInt32(paramsToStore[0].Value);
                iRet = objPP.ID;
            }
            catch (Exception excp)
            {
                throw excp;
            }
            return iRet;
        }
        public static bool Update(PasswordPolicy objPP, SqlTransaction trans)
        {
            bool bChk = false;
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[11];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ID", objPP.ID, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@CodeID", objPP.CodeID, SqlDbType.VarChar, 50);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@OriginalCodeID", objPP.CodeID, SqlDbType.VarChar, 50);

                if (!string.IsNullOrEmpty(objPP.CodeDesc.Trim()))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CodeDesc", objPP.CodeDesc, SqlDbType.VarChar, 200);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CodeDesc", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.DefaultValue.Trim()))
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@DefaultValue", objPP.DefaultValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@DefaultValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.SetValue.Trim()))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@SetValue", objPP.SetValue, SqlDbType.VarChar, 500);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@SetValue", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.Active.Trim()))
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Active", objPP.Active, SqlDbType.VarChar, 1);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Active", DBNull.Value);
                if (objPP.EntryDate > DateTime.MinValue && objPP.EntryDate < DateTime.MaxValue)
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryDate", objPP.EntryDate, SqlDbType.DateTime);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.EntryBy.Trim()))
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@EntryBy", objPP.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (objPP.UpdateDate > DateTime.MinValue && objPP.UpdateDate < DateTime.MaxValue)
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateDate", objPP.UpdateDate, SqlDbType.DateTime);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@UpdateDate", DBNull.Value);
                if (!string.IsNullOrEmpty(objPP.UpdateBy.Trim()))
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@UpdateBy", objPP.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);

                SqlHelper.ExecuteNonQuery(trans, CommandType.StoredProcedure, "sp_WebX_Password_Policy_Update", paramsToStore);
                bChk = true;
            }
            catch (Exception excp)
            {
                throw excp;
            }
            return bChk;
        }

        public static bool EncryptDecryptPass(bool isEncrypt)
        {
            bool bchk = false;
            string cmd = "SELECT * FROM WEBX_MASTER_USERS";
            SqlConnection cn = new SqlConnection(SessionUtilities.ConnectionString);
            cn.Open();
            SqlTransaction trans = cn.BeginTransaction();
            try
            {
                bchk = EncryptDecryptPass(isEncrypt, trans);
                trans.Commit();
            }
            catch (Exception ex)
            {
                trans.Rollback();
                bchk = false;
                throw ex;
            }
            finally
            {
                if (cn.State == ConnectionState.Open)
                    cn.Close();
            }
            return bchk;
        }
        public static bool EncryptDecryptPass(bool isEncrypt, SqlTransaction trans)
        {
            bool bchk = false;
            string cmd = "SELECT * FROM WEBX_MASTER_USERS";
            try
            {
                DataTable dt = SqlHelper.ExecuteDataset(trans, CommandType.Text, cmd).Tables[0];
                foreach (DataRow dr in dt.Rows)
                {
                    if (isEncrypt)
                    {
                        if (dr["IsPassEncrypted"].ToString() == "N")
                        {
                            string userid = dr["UserID"].ToString();
                            string oldPwd = dr["UserPwd"].ToString();
                            string lstPass = "";
                            string encPass = SSTCryptographer.Encrypt(oldPwd, ConfigurationManager.AppSettings["PasswordSult"].ToString());
                            if (dr["LastPwd"] != DBNull.Value)
                            {
                                lstPass = dr["LastPwd"].ToString();
                                lstPass = SSTCryptographer.Encrypt(lstPass, ConfigurationManager.AppSettings["PasswordSult"].ToString());
                                cmd = "Update WEBX_MASTER_USERS set UserPwd='" + encPass + "',LastPwd='" + lstPass + "',IsPassEncrypted='Y' where UserID='" + userid + "'";
                            }
                            else
                                cmd = "Update WEBX_MASTER_USERS set UserPwd='" + encPass + "',IsPassEncrypted='Y' where UserID='" + userid + "'";
                            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, cmd);
                        }
                    }
                    else
                    {
                        if (dr["IsPassEncrypted"].ToString() == "Y")
                        {
                            string userid = dr["UserID"].ToString();
                            string encPwd = dr["UserPwd"].ToString();
                            string lstPass = "";
                            string decPass = SSTCryptographer.Decrypt(encPwd, ConfigurationManager.AppSettings["PasswordSult"].ToString());
                            if (dr["LastPwd"] != DBNull.Value)
                            {
                                lstPass = dr["LastPwd"].ToString();
                                lstPass = SSTCryptographer.Decrypt(lstPass, ConfigurationManager.AppSettings["PasswordSult"].ToString());
                                cmd = "Update WEBX_MASTER_USERS set UserPwd='" + decPass + "',LastPwd='" + lstPass + "',IsPassEncrypted='N' where UserID='" + userid + "'";
                            }
                            else
                                cmd = "Update WEBX_MASTER_USERS set UserPwd='" + decPass + "',IsPassEncrypted='N' where UserID='" + userid + "'";
                            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, cmd);
                        }
                    }
                }
                bchk = true;
            }
            catch (Exception ex)
            {
                bchk = false;
                throw ex;
            }
            return bchk;
        }
    }
}
