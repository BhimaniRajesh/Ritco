using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;
using WebX.Controllers;

/// <summary>
/// Summary description for ChequeController
/// </summary>
namespace WebX.Controllers
{
    public class ChequeController
    {
        public ChequeController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static void ChequeEntry(Cheque chq, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[18];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@chequeno", chq.ChequeNo, SqlDbType.VarChar);
                if (chq.ChequeDate > DateTime.MinValue && chq.ChequeDate < DateTime.MaxValue)
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@chequedate", chq.ChequeDate, SqlDbType.DateTime);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@chequedate", DBNull.Value);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@chequeamt", chq.ChequeAmount, SqlDbType.Decimal);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@collamt", chq.CollAmount, SqlDbType.Decimal);

                paramsToStore[4] = ControllersHelper.GetSqlParameter("@adjustamt", chq.AdjustAmount, SqlDbType.Decimal);

                paramsToStore[5] = ControllersHelper.GetSqlParameter("@depobankcode", chq.DepoBankCode, SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@bankbrcd", chq.BankBranchCode, SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@issuebank", chq.IssueBank, SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@voucherno", chq.VoucherNo, SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@documentno", chq.DocumentNo, SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@partycode", chq.PartyCode, SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@partyname", chq.PartyName, SqlDbType.VarChar);
                paramsToStore[12] = ControllersHelper.GetSqlParameter("@flagonacc", chq.FlagOnAcc, SqlDbType.VarChar);
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@flagdeposited", chq.FlagDeposited, SqlDbType.VarChar);
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@flagowncust", chq.FlagOwnCust, SqlDbType.VarChar);
                paramsToStore[15] = ControllersHelper.GetSqlParameter("@doctype", chq.DocType, SqlDbType.VarChar);
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@comments", chq.Comments, SqlDbType.VarChar);
                paramsToStore[17] = ControllersHelper.GetSqlParameter("@entryby", chq.EntryBy, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_CHEQUE_ENTRY", paramsToStore);

            }
            catch (Exception excp)
            {
                throw excp;
            }
        }

    }
}
