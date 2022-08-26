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
    /// Summary description for VendorContractSummaryController
    /// </summary>
    public class VendorContractSummaryController
    {
        public VendorContractSummaryController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static VendorContractSummary FillObject(DataRow dr)
        {
            VendorContractSummary vcs = new VendorContractSummary();
            try
            {
                if (dr[(int)VendorContractSummary_Columns.VendorCode] != DBNull.Value)
                    vcs.VendorCode = dr[(int)VendorContractSummary_Columns.VendorCode].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorName] != DBNull.Value)
                    vcs.VendorName = dr[(int)VendorContractSummary_Columns.VendorName].ToString();
                if (dr[(int)VendorContractSummary_Columns.Vendor_Type] != DBNull.Value)
                    vcs.Vendor_Type = dr[(int)VendorContractSummary_Columns.Vendor_Type].ToString();
                if (dr[(int)VendorContractSummary_Columns.CONTRACTCD] != DBNull.Value)
                    vcs.CONTRACTCD = dr[(int)VendorContractSummary_Columns.CONTRACTCD].ToString();
                if (dr[(int)VendorContractSummary_Columns.ContractDt] != DBNull.Value)
                    vcs.ContractDt = Convert.ToDateTime(dr[(int)VendorContractSummary_Columns.ContractDt]);
                if (dr[(int)VendorContractSummary_Columns.Contract_loccode] != DBNull.Value)
                    vcs.Contract_loccode = dr[(int)VendorContractSummary_Columns.Contract_loccode].ToString();
                if (dr[(int)VendorContractSummary_Columns.Valid_uptodt] != DBNull.Value)
                    vcs.Valid_uptodt = Convert.ToDateTime(dr[(int)VendorContractSummary_Columns.Valid_uptodt]);
                if (dr[(int)VendorContractSummary_Columns.Start_Dt] != DBNull.Value)
                    vcs.Start_Dt = Convert.ToDateTime(dr[(int)VendorContractSummary_Columns.Start_Dt]);
                if (dr[(int)VendorContractSummary_Columns.VendorPerName] != DBNull.Value)
                    vcs.VendorPerName = dr[(int)VendorContractSummary_Columns.VendorPerName].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorPerDesg] != DBNull.Value)
                    vcs.VendorPerDesg = dr[(int)VendorContractSummary_Columns.VendorPerDesg].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorWitness] != DBNull.Value)
                    vcs.VendorWitness = dr[(int)VendorContractSummary_Columns.VendorWitness].ToString();
                if (dr[(int)VendorContractSummary_Columns.CompEmpName] != DBNull.Value)
                    vcs.CompEmpName = dr[(int)VendorContractSummary_Columns.CompEmpName].ToString();
                if (dr[(int)VendorContractSummary_Columns.CompEmpDesg] != DBNull.Value)
                    vcs.CompEmpDesg = dr[(int)VendorContractSummary_Columns.CompEmpDesg].ToString();
                if (dr[(int)VendorContractSummary_Columns.CompWitness] != DBNull.Value)
                    vcs.CompWitness = dr[(int)VendorContractSummary_Columns.CompWitness].ToString();
                if (dr[(int)VendorContractSummary_Columns.Vendor_Address] != DBNull.Value)
                    vcs.Vendor_Address = dr[(int)VendorContractSummary_Columns.Vendor_Address].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorCity] != DBNull.Value)
                    vcs.VendorCity = dr[(int)VendorContractSummary_Columns.VendorCity].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorPin] != DBNull.Value)
                    vcs.VendorPin = dr[(int)VendorContractSummary_Columns.VendorPin].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorCategory] != DBNull.Value)
                    vcs.VendorCategory = dr[(int)VendorContractSummary_Columns.VendorCategory].ToString();
                if (dr[(int)VendorContractSummary_Columns.VendorContractCat] != DBNull.Value)
                    vcs.VendorContractCat = dr[(int)VendorContractSummary_Columns.VendorContractCat].ToString();
                if (dr[(int)VendorContractSummary_Columns.TDSAppl_YN] != DBNull.Value)
                    vcs.TDSAppl_YN = dr[(int)VendorContractSummary_Columns.TDSAppl_YN].ToString();
                if (dr[(int)VendorContractSummary_Columns.TDS_Rate] != DBNull.Value)
                    vcs.TDS_Rate = Convert.ToDouble(dr[(int)VendorContractSummary_Columns.TDS_Rate]);
                if (dr[(int)VendorContractSummary_Columns.Security_deposit_chq] != DBNull.Value)
                    vcs.Security_deposit_chq = dr[(int)VendorContractSummary_Columns.Security_deposit_chq].ToString();
                if (dr[(int)VendorContractSummary_Columns.Security_deposit_date] != DBNull.Value)
                    vcs.Security_deposit_date = Convert.ToDateTime(dr[(int)VendorContractSummary_Columns.Security_deposit_date]);
                if (dr[(int)VendorContractSummary_Columns.Security_deposit_Amt] != DBNull.Value)
                    vcs.Security_deposit_Amt = Convert.ToDouble(dr[(int)VendorContractSummary_Columns.Security_deposit_Amt]);
                if (dr[(int)VendorContractSummary_Columns.Payment_interval] != DBNull.Value)
                    vcs.Payment_interval = dr[(int)VendorContractSummary_Columns.Payment_interval].ToString();
                if (dr[(int)VendorContractSummary_Columns.Payment_Basis] != DBNull.Value)
                    vcs.Payment_Basis = dr[(int)VendorContractSummary_Columns.Payment_Basis].ToString();
                if (dr[(int)VendorContractSummary_Columns.Payment_loc] != DBNull.Value)
                    vcs.Payment_loc = dr[(int)VendorContractSummary_Columns.Payment_loc].ToString();
                if (dr[(int)VendorContractSummary_Columns.Monthly_Phone_Charges] != DBNull.Value)
                    vcs.Monthly_Phone_Charges = Convert.ToDouble(dr[(int)VendorContractSummary_Columns.Monthly_Phone_Charges]);
                if (dr[(int)VendorContractSummary_Columns.EntryBy] != DBNull.Value)
                    vcs.EntryBy = dr[(int)VendorContractSummary_Columns.EntryBy].ToString();
                if (dr[(int)VendorContractSummary_Columns.EntryDt] != DBNull.Value)
                    vcs.EntryDt = Convert.ToDateTime(dr[(int)VendorContractSummary_Columns.EntryDt]);
                if (dr[(int)VendorContractSummary_Columns.UpdateBy] != DBNull.Value)
                    vcs.UpdateBy = dr[(int)VendorContractSummary_Columns.UpdateBy].ToString();
                if (dr[(int)VendorContractSummary_Columns.UpdateDt] != DBNull.Value)
                    vcs.UpdateDt = Convert.ToDateTime(dr[(int)VendorContractSummary_Columns.UpdateDt]);
                if (dr[(int)VendorContractSummary_Columns.MetrixType] != DBNull.Value)
                    vcs.MetrixType = dr[(int)VendorContractSummary_Columns.MetrixType].ToString();
                if (dr[(int)VendorContractSummary_Columns.Status] != DBNull.Value)
                    vcs.Status = dr[(int)VendorContractSummary_Columns.Status].ToString();
                if (dr[(int)VendorContractSummary_Columns.Default_Charge] != DBNull.Value)
                    vcs.Default_Charge = Convert.ToDouble(dr[(int)VendorContractSummary_Columns.Default_Charge]);
            }
            catch (Exception ex)
            { }
            return vcs;
        }

        public static string GenerateNewContractCode()
        {
            string ContractCode = "";
            string sp = "webx_Generate_Vendor_Contract_Code";
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp);
                if (obj != null)
                {
                    ContractCode = obj.ToString();
                }
            }
            catch (Exception ex)
            {
            }
            return ContractCode;
        }
        public static bool Insert(VendorContractSummary vcs)
        {
            bool bChk = false;
            SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
            conn.Open();
            SqlTransaction trn = conn.BeginTransaction();
            try
            {
                bChk = Insert(vcs, trn);
                if (bChk)
                    trn.Commit();
                else
                    trn.Rollback();
            }
            catch (Exception ex)
            {
                if (conn.State == ConnectionState.Open)
                    trn.Rollback();
                bChk = false;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            return bChk;
        }
        public static bool Insert(VendorContractSummary vcs, SqlTransaction trn)
        {
            bool bChk = false;
            string sp = "usp_Vendor_Contract_Summary_Ver1_Insert";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[35];
                if (!string.IsNullOrEmpty(vcs.VendorCode))
                    paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", vcs.VendorCode, SqlDbType.VarChar, 10);
                else
                    paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorName))
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@VendorName", vcs.VendorName, SqlDbType.VarChar, 50);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@VendorName", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Vendor_Type))
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@Vendor_Type", vcs.Vendor_Type, SqlDbType.VarChar, 10);
                else
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@Vendor_Type", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CONTRACTCD))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CONTRACTCD", vcs.CONTRACTCD, SqlDbType.VarChar, 10);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CONTRACTCD", DBNull.Value);
                if (vcs.ContractDt > DateTime.MinValue && vcs.ContractDt < DateTime.MaxValue)
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@ContractDt", vcs.ContractDt, SqlDbType.DateTime);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@ContractDt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Contract_loccode))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Contract_loccode", vcs.Contract_loccode, SqlDbType.VarChar, 10);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Contract_loccode", DBNull.Value);
                if (vcs.Valid_uptodt > DateTime.MinValue && vcs.Valid_uptodt < DateTime.MaxValue)
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Valid_uptodt", vcs.Valid_uptodt, SqlDbType.DateTime);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Valid_uptodt", DBNull.Value);
                if (vcs.Start_Dt > DateTime.MinValue && vcs.Start_Dt < DateTime.MaxValue)
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@Start_Dt", vcs.Start_Dt, SqlDbType.DateTime);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@Start_Dt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorPerName))
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@VendorPerName", vcs.VendorPerName, SqlDbType.VarChar, 50);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@VendorPerName", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorPerDesg))
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@VendorPerDesg", vcs.VendorPerDesg, SqlDbType.VarChar, 50);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@VendorPerDesg", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorWitness))
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@VendorWitness", vcs.VendorWitness, SqlDbType.VarChar, 100);
                else
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@VendorWitness", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CompEmpName))
                    paramsToStore[11] = ControllersHelper.GetSqlParameter("@CompEmpName", vcs.CompEmpName, SqlDbType.VarChar, 50);
                else
                    paramsToStore[11] = ControllersHelper.GetSqlParameter("@CompEmpName", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CompEmpDesg))
                    paramsToStore[12] = ControllersHelper.GetSqlParameter("@CompEmpDesg", vcs.CompEmpDesg, SqlDbType.VarChar, 50);
                else
                    paramsToStore[12] = ControllersHelper.GetSqlParameter("@CompEmpDesg", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CompWitness))
                    paramsToStore[13] = ControllersHelper.GetSqlParameter("@CompWitness", vcs.CompWitness, SqlDbType.VarChar, 100);
                else
                    paramsToStore[13] = ControllersHelper.GetSqlParameter("@CompWitness", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Vendor_Address))
                    paramsToStore[14] = ControllersHelper.GetSqlParameter("@Vendor_Address", vcs.Vendor_Address, SqlDbType.VarChar, 500);
                else
                    paramsToStore[14] = ControllersHelper.GetSqlParameter("@Vendor_Address", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorCity))
                    paramsToStore[15] = ControllersHelper.GetSqlParameter("@VendorCity", vcs.VendorCity, SqlDbType.VarChar, 50);
                else
                    paramsToStore[15] = ControllersHelper.GetSqlParameter("@VendorCity", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorPin))
                    paramsToStore[16] = ControllersHelper.GetSqlParameter("@VendorPin", vcs.VendorPin, SqlDbType.VarChar, 50);
                else
                    paramsToStore[16] = ControllersHelper.GetSqlParameter("@VendorPin", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorCategory))
                    paramsToStore[17] = ControllersHelper.GetSqlParameter("@VendorCategory", vcs.VendorCategory, SqlDbType.VarChar, 50);
                else
                    paramsToStore[17] = ControllersHelper.GetSqlParameter("@VendorCategory", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorContractCat))
                    paramsToStore[18] = ControllersHelper.GetSqlParameter("@VendorContractCat", vcs.VendorContractCat, SqlDbType.VarChar, 50);
                else
                    paramsToStore[18] = ControllersHelper.GetSqlParameter("@VendorContractCat", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.TDSAppl_YN))
                    paramsToStore[19] = ControllersHelper.GetSqlParameter("@TDSAppl_YN", vcs.TDSAppl_YN, SqlDbType.VarChar, 1);
                else
                    paramsToStore[19] = ControllersHelper.GetSqlParameter("@TDSAppl_YN", DBNull.Value);
                if (vcs.TDS_Rate > -1)
                    paramsToStore[20] = ControllersHelper.GetSqlParameter("@TDS_Rate", Convert.ToDecimal(vcs.TDS_Rate.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[20] = ControllersHelper.GetSqlParameter("@TDS_Rate", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Security_deposit_chq))
                    paramsToStore[21] = ControllersHelper.GetSqlParameter("@Security_deposit_chq", vcs.Security_deposit_chq, SqlDbType.VarChar, 150);
                else
                    paramsToStore[21] = ControllersHelper.GetSqlParameter("@Security_deposit_chq", DBNull.Value);
                if (vcs.Security_deposit_date > DateTime.MinValue && vcs.Security_deposit_date < DateTime.MaxValue)
                    paramsToStore[22] = ControllersHelper.GetSqlParameter("@Security_deposit_date", vcs.Security_deposit_date, SqlDbType.DateTime);
                else
                    paramsToStore[22] = ControllersHelper.GetSqlParameter("@Security_deposit_date", DBNull.Value);
                if (vcs.Security_deposit_Amt > -1)
                    paramsToStore[23] = ControllersHelper.GetSqlParameter("@Security_deposit_Amt", Convert.ToDecimal(vcs.Security_deposit_Amt.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[23] = ControllersHelper.GetSqlParameter("@Security_deposit_Amt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Payment_interval))
                    paramsToStore[24] = ControllersHelper.GetSqlParameter("@Payment_interval", vcs.Payment_interval, SqlDbType.VarChar, 50);
                else
                    paramsToStore[24] = ControllersHelper.GetSqlParameter("@Payment_interval", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Payment_Basis))
                    paramsToStore[25] = ControllersHelper.GetSqlParameter("@Payment_Basis", vcs.Payment_Basis, SqlDbType.VarChar, 50);
                else
                    paramsToStore[25] = ControllersHelper.GetSqlParameter("@Payment_Basis", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Payment_loc))
                    paramsToStore[26] = ControllersHelper.GetSqlParameter("@Payment_loc", vcs.Payment_loc, SqlDbType.VarChar, 50);
                else
                    paramsToStore[26] = ControllersHelper.GetSqlParameter("@Payment_loc", DBNull.Value);
                if (vcs.Monthly_Phone_Charges > -1)
                    paramsToStore[27] = ControllersHelper.GetSqlParameter("@Monthly_Phone_Charges", Convert.ToDecimal(vcs.Monthly_Phone_Charges.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[27] = ControllersHelper.GetSqlParameter("@Monthly_Phone_Charges", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.EntryBy))
                    paramsToStore[28] = ControllersHelper.GetSqlParameter("@EntryBy", vcs.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[28] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (vcs.EntryDt > DateTime.MinValue && vcs.EntryDt < DateTime.MaxValue)
                    paramsToStore[29] = ControllersHelper.GetSqlParameter("@EntryDt", vcs.EntryDt, SqlDbType.DateTime);
                else
                    paramsToStore[29] = ControllersHelper.GetSqlParameter("@EntryDt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.UpdateBy))
                    paramsToStore[30] = ControllersHelper.GetSqlParameter("@UpdateBy", vcs.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[30] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);
                if (vcs.UpdateDt > DateTime.MinValue && vcs.UpdateDt < DateTime.MaxValue)
                    paramsToStore[31] = ControllersHelper.GetSqlParameter("@UpdateDt", vcs.UpdateDt, SqlDbType.DateTime);
                else
                    paramsToStore[31] = ControllersHelper.GetSqlParameter("@UpdateDt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.MetrixType))
                    paramsToStore[32] = ControllersHelper.GetSqlParameter("@MetrixType", vcs.MetrixType, SqlDbType.VarChar, 10);
                else
                    paramsToStore[32] = ControllersHelper.GetSqlParameter("@MetrixType", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Status))
                    paramsToStore[33] = ControllersHelper.GetSqlParameter("@Status", vcs.Status, SqlDbType.VarChar, 1);
                else
                    paramsToStore[33] = ControllersHelper.GetSqlParameter("@Status", DBNull.Value);
                if (vcs.Default_Charge > -1)
                    paramsToStore[34] = ControllersHelper.GetSqlParameter("@Default_Charge", Convert.ToDecimal(vcs.Default_Charge.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[34] = ControllersHelper.GetSqlParameter("@Default_Charge", DBNull.Value);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, sp, paramsToStore);
                bChk = true;
            }
            catch (Exception excp)
            {
                bChk = false;
            }
            return bChk;
        }

        public static bool Update(VendorContractSummary vcs)
        {
            bool bChk = false;
            SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
            conn.Open();
            SqlTransaction trn = conn.BeginTransaction();
            try
            {
                bChk = Update(vcs, trn);
                if (bChk)
                    trn.Commit();
                else
                    trn.Rollback();
            }
            catch (Exception ex)
            {
                if (conn.State == ConnectionState.Open)
                    trn.Rollback();
                bChk = false;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            return bChk;
        }
        public static bool Update(VendorContractSummary vcs, SqlTransaction trn)
        {
            bool bChk = false;
            string sp = "usp_Vendor_Contract_Summary_Ver1_Update";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[35];
                if (!string.IsNullOrEmpty(vcs.VendorCode))
                    paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", vcs.VendorCode, SqlDbType.VarChar, 10);
                else
                    paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorName))
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@VendorName", vcs.VendorName, SqlDbType.VarChar, 50);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@VendorName", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Vendor_Type))
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@Vendor_Type", vcs.Vendor_Type, SqlDbType.VarChar, 10);
                else
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@Vendor_Type", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CONTRACTCD))
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CONTRACTCD", vcs.CONTRACTCD, SqlDbType.VarChar, 10);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@CONTRACTCD", DBNull.Value);
                if (vcs.ContractDt > DateTime.MinValue && vcs.ContractDt < DateTime.MaxValue)
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@ContractDt", vcs.ContractDt, SqlDbType.DateTime);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@ContractDt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Contract_loccode))
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Contract_loccode", vcs.Contract_loccode, SqlDbType.VarChar, 10);
                else
                    paramsToStore[5] = ControllersHelper.GetSqlParameter("@Contract_loccode", DBNull.Value);
                if (vcs.Valid_uptodt > DateTime.MinValue && vcs.Valid_uptodt < DateTime.MaxValue)
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Valid_uptodt", vcs.Valid_uptodt, SqlDbType.DateTime);
                else
                    paramsToStore[6] = ControllersHelper.GetSqlParameter("@Valid_uptodt", DBNull.Value);
                if (vcs.Start_Dt > DateTime.MinValue && vcs.Start_Dt < DateTime.MaxValue)
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@Start_Dt", vcs.Start_Dt, SqlDbType.DateTime);
                else
                    paramsToStore[7] = ControllersHelper.GetSqlParameter("@Start_Dt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorPerName))
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@VendorPerName", vcs.VendorPerName, SqlDbType.VarChar, 50);
                else
                    paramsToStore[8] = ControllersHelper.GetSqlParameter("@VendorPerName", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorPerDesg))
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@VendorPerDesg", vcs.VendorPerDesg, SqlDbType.VarChar, 50);
                else
                    paramsToStore[9] = ControllersHelper.GetSqlParameter("@VendorPerDesg", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorWitness))
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@VendorWitness", vcs.VendorWitness, SqlDbType.VarChar, 100);
                else
                    paramsToStore[10] = ControllersHelper.GetSqlParameter("@VendorWitness", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CompEmpName))
                    paramsToStore[11] = ControllersHelper.GetSqlParameter("@CompEmpName", vcs.CompEmpName, SqlDbType.VarChar, 50);
                else
                    paramsToStore[11] = ControllersHelper.GetSqlParameter("@CompEmpName", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CompEmpDesg))
                    paramsToStore[12] = ControllersHelper.GetSqlParameter("@CompEmpDesg", vcs.CompEmpDesg, SqlDbType.VarChar, 50);
                else
                    paramsToStore[12] = ControllersHelper.GetSqlParameter("@CompEmpDesg", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.CompWitness))
                    paramsToStore[13] = ControllersHelper.GetSqlParameter("@CompWitness", vcs.CompWitness, SqlDbType.VarChar, 100);
                else
                    paramsToStore[13] = ControllersHelper.GetSqlParameter("@CompWitness", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Vendor_Address))
                    paramsToStore[14] = ControllersHelper.GetSqlParameter("@Vendor_Address", vcs.Vendor_Address, SqlDbType.VarChar, 500);
                else
                    paramsToStore[14] = ControllersHelper.GetSqlParameter("@Vendor_Address", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorCity))
                    paramsToStore[15] = ControllersHelper.GetSqlParameter("@VendorCity", vcs.VendorCity, SqlDbType.VarChar, 50);
                else
                    paramsToStore[15] = ControllersHelper.GetSqlParameter("@VendorCity", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorPin))
                    paramsToStore[16] = ControllersHelper.GetSqlParameter("@VendorPin", vcs.VendorPin, SqlDbType.VarChar, 50);
                else
                    paramsToStore[16] = ControllersHelper.GetSqlParameter("@VendorPin", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorCategory))
                    paramsToStore[17] = ControllersHelper.GetSqlParameter("@VendorCategory", vcs.VendorCategory, SqlDbType.VarChar, 50);
                else
                    paramsToStore[17] = ControllersHelper.GetSqlParameter("@VendorCategory", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.VendorContractCat))
                    paramsToStore[18] = ControllersHelper.GetSqlParameter("@VendorContractCat", vcs.VendorContractCat, SqlDbType.VarChar, 50);
                else
                    paramsToStore[18] = ControllersHelper.GetSqlParameter("@VendorContractCat", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.TDSAppl_YN))
                    paramsToStore[19] = ControllersHelper.GetSqlParameter("@TDSAppl_YN", vcs.TDSAppl_YN, SqlDbType.VarChar, 1);
                else
                    paramsToStore[19] = ControllersHelper.GetSqlParameter("@TDSAppl_YN", DBNull.Value);
                if (vcs.TDS_Rate > -1)
                    paramsToStore[20] = ControllersHelper.GetSqlParameter("@TDS_Rate", Convert.ToDecimal(vcs.TDS_Rate.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[20] = ControllersHelper.GetSqlParameter("@TDS_Rate", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Security_deposit_chq))
                    paramsToStore[21] = ControllersHelper.GetSqlParameter("@Security_deposit_chq", vcs.Security_deposit_chq, SqlDbType.VarChar, 150);
                else
                    paramsToStore[21] = ControllersHelper.GetSqlParameter("@Security_deposit_chq", DBNull.Value);
                if (vcs.Security_deposit_date > DateTime.MinValue && vcs.Security_deposit_date < DateTime.MaxValue)
                    paramsToStore[22] = ControllersHelper.GetSqlParameter("@Security_deposit_date", vcs.Security_deposit_date, SqlDbType.DateTime);
                else
                    paramsToStore[22] = ControllersHelper.GetSqlParameter("@Security_deposit_date", DBNull.Value);
                if (vcs.Security_deposit_Amt > -1)
                    paramsToStore[23] = ControllersHelper.GetSqlParameter("@Security_deposit_Amt", Convert.ToDecimal(vcs.Security_deposit_Amt.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[23] = ControllersHelper.GetSqlParameter("@Security_deposit_Amt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Payment_interval))
                    paramsToStore[24] = ControllersHelper.GetSqlParameter("@Payment_interval", vcs.Payment_interval, SqlDbType.VarChar, 50);
                else
                    paramsToStore[24] = ControllersHelper.GetSqlParameter("@Payment_interval", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Payment_Basis))
                    paramsToStore[25] = ControllersHelper.GetSqlParameter("@Payment_Basis", vcs.Payment_Basis, SqlDbType.VarChar, 50);
                else
                    paramsToStore[25] = ControllersHelper.GetSqlParameter("@Payment_Basis", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Payment_loc))
                    paramsToStore[26] = ControllersHelper.GetSqlParameter("@Payment_loc", vcs.Payment_loc, SqlDbType.VarChar, 50);
                else
                    paramsToStore[26] = ControllersHelper.GetSqlParameter("@Payment_loc", DBNull.Value);
                if (vcs.Monthly_Phone_Charges > -1)
                    paramsToStore[27] = ControllersHelper.GetSqlParameter("@Monthly_Phone_Charges", Convert.ToDecimal(vcs.Monthly_Phone_Charges.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[27] = ControllersHelper.GetSqlParameter("@Monthly_Phone_Charges", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.EntryBy))
                    paramsToStore[28] = ControllersHelper.GetSqlParameter("@EntryBy", vcs.EntryBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[28] = ControllersHelper.GetSqlParameter("@EntryBy", DBNull.Value);
                if (vcs.EntryDt > DateTime.MinValue && vcs.EntryDt < DateTime.MaxValue)
                    paramsToStore[29] = ControllersHelper.GetSqlParameter("@EntryDt", vcs.EntryDt, SqlDbType.DateTime);
                else
                    paramsToStore[29] = ControllersHelper.GetSqlParameter("@EntryDt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.UpdateBy))
                    paramsToStore[30] = ControllersHelper.GetSqlParameter("@UpdateBy", vcs.UpdateBy, SqlDbType.VarChar, 50);
                else
                    paramsToStore[30] = ControllersHelper.GetSqlParameter("@UpdateBy", DBNull.Value);
                if (vcs.UpdateDt > DateTime.MinValue && vcs.UpdateDt < DateTime.MaxValue)
                    paramsToStore[31] = ControllersHelper.GetSqlParameter("@UpdateDt", vcs.UpdateDt, SqlDbType.DateTime);
                else
                    paramsToStore[31] = ControllersHelper.GetSqlParameter("@UpdateDt", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.MetrixType))
                    paramsToStore[32] = ControllersHelper.GetSqlParameter("@MetrixType", vcs.MetrixType, SqlDbType.VarChar, 10);
                else
                    paramsToStore[32] = ControllersHelper.GetSqlParameter("@MetrixType", DBNull.Value);
                if (!string.IsNullOrEmpty(vcs.Status))
                    paramsToStore[33] = ControllersHelper.GetSqlParameter("@Status", vcs.Status, SqlDbType.VarChar, 1);
                else
                    paramsToStore[33] = ControllersHelper.GetSqlParameter("@Status", DBNull.Value);
                if (vcs.Default_Charge > -1)
                    paramsToStore[34] = ControllersHelper.GetSqlParameter("@Default_Charge", Convert.ToDecimal(vcs.Default_Charge.ToString("0.00")), SqlDbType.Decimal);
                else
                    paramsToStore[34] = ControllersHelper.GetSqlParameter("@Default_Charge", DBNull.Value);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, sp, paramsToStore);
                bChk = true;
            }
            catch (Exception ex)
            {
                bChk = false;
            }
            return bChk;
        }

        public static VendorContractSummary GetByContractID(string ContractID)
        {
            VendorContractSummary vcs = null;
            string sp = "usp_Vendor_Contract_Summary_Ver1_GetByContractID";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@CONTRACTCD", ContractID, SqlDbType.VarChar, 10);
                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp, paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        vcs = VendorContractSummaryController.FillObject(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                vcs = null;
            }
            return vcs;
        }
        public static VendorContractSummary GetByContractID(string ContractID, SqlTransaction trn)
        {
            VendorContractSummary vcs = null;
            string sp = "usp_Vendor_Contract_Summary_Ver1_GetByContractID";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@CONTRACTCD", ContractID, SqlDbType.VarChar, 10);
                DataSet ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, sp, paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        vcs = VendorContractSummaryController.FillObject(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                vcs = null;
            }
            return vcs;
        }

        public static VendorContractSummary GetByVendorCode(string VendorCode, SqlTransaction trn)
        {
            VendorContractSummary vcs = null;
            string sp = "usp_Vendor_Contract_Summary_Ver1_GetByVendorCode";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", VendorCode, SqlDbType.VarChar, 10);
                DataSet ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, sp, paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        vcs = VendorContractSummaryController.FillObject(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                vcs = null;
            }
            return vcs;
        }
        public static VendorContractSummary GetByVendorCode(string VendorCode)
        {
            VendorContractSummary vcs = null;
            string sp = "usp_Vendor_Contract_Summary_Ver1_GetByVendorCode";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", VendorCode, SqlDbType.VarChar, 10);
                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sp, paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        vcs = VendorContractSummaryController.FillObject(ds.Tables[0].Rows[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                vcs = null;
            }
            return vcs;
        }

        public static List<VendorContractSummary> GetByMatrixAndStatus(string VendorCode, string MetrixType, string Status, SqlTransaction trn)
        {
            List<VendorContractSummary> ListVcs = new List<VendorContractSummary>();
            string sp = "usp_Vendor_Contract_Summary_Ver1_GetByMatrixAndStatus";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[3];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@VendorCode", VendorCode, SqlDbType.VarChar, 10);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@MetrixType", MetrixType, SqlDbType.VarChar, 10);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@Status", Status, SqlDbType.VarChar, 1);
                DataSet ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, sp, paramsToStore);
                if (ds.Tables.Count > 0)
                {
                    foreach(DataRow dr in ds.Tables[0].Rows)
                    {
                        VendorContractSummary vcs = VendorContractSummaryController.FillObject(dr);
                        if (vcs.CONTRACTCD != "")
                        {
                            ListVcs.Add(vcs);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ListVcs = new List<VendorContractSummary>();
            }
            return ListVcs;
        }
        public static List<VendorContractSummary> GetByMatrixAndStatus(string VendorCode, string MetrixType, string Status)
        {
            List<VendorContractSummary> ListVcs = new List<VendorContractSummary>();
            SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
            conn.Open();
            SqlTransaction trn = conn.BeginTransaction();
            try
            {
                ListVcs = GetByMatrixAndStatus(VendorCode, MetrixType, Status, trn);
                trn.Commit();
            }
            catch (Exception ex)
            {
                if (conn.State == ConnectionState.Open)
                    trn.Rollback();
                ListVcs = new List<VendorContractSummary>();
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
            return ListVcs;
        }
    }
}