using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;
using WebX.Entity;

/// <summary>
/// Summary description for HappayFuelWalletController
/// </summary>
namespace WebX.Controllers
{
    public class HappayFuelWalletController : Base
    {
        public HappayFuelWalletController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataSet GetBankDetails()
        {
            DataSet ds = new DataSet();
            ds = ExecuteDataSet("USP_HappayFuelWallet_GetBankDetails");
            return ds;
        }

        public void InsertBankFuelMapping(List<BankFuelTypeRequest> obj)
        {
            try
            {
                ExecuteDataSet("USP_BankFuelType_InsertBankFuelType", new SqlParameter[] {
                    new SqlParameter("@XML", WebX.Common.XmlUtility.XmlSerializeToString(obj)),
                    new SqlParameter("@Location", SessionUtilities.CurrentBranchCode),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
                }, true);
            }
            catch (Exception ex)
            {
                ExceptionUtils.LogException(ex, "Insert BankFuelType Mapping");
            }
        }

        public DataTable GetBankList(string SerchText)
        {
            DataTable dt = new DataTable();
            dt = ExecuteDataSet("USP_BankFuelType_GetBankList", new SqlParameter[] {
                    new SqlParameter("@SerchText", SerchText) }).Tables[0];
            return dt;
        }

        public DataSet GetBankDetailsByBankName(string bankname)
        {
            DataSet ds = new DataSet();
            ds = ExecuteDataSet("USP_BankFuelType_GetBankDetailsList", new SqlParameter[] {
                    new SqlParameter("@BankName", bankname) });
            return ds;
        }

        public void UpdateBankFuelMapping(List<BankFuelTypeRequest> obj)
        {
            try
            {
                ExecuteDataSet("USP_BankFuelType_UpdateBankFuelType", new SqlParameter[] {
                    new SqlParameter("@XML", WebX.Common.XmlUtility.XmlSerializeToString(obj)),
                    new SqlParameter("@UpdateBy", SessionUtilities.CurrentEmployeeID)
                }, true);
            }
            catch (Exception ex)
            {
                ExceptionUtils.LogException(ex, "Update BankFuelType Mapping");
            }
        }

        public DataSet GetBankFuelMapping(string WalletType)
        {
            DataSet ds = new DataSet();
            try
            {

                ds = ExecuteDataSet("USP_BankFuelType_GetBankFuelType", new SqlParameter[] {
                    new SqlParameter("@WalletType", WalletType)
                });

            }
            catch (Exception ex)
            {
                ExceptionUtils.LogException(ex, "Get BankFuelType Mapping");
            }
            return ds;
        }
    }
}