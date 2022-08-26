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
/// Summary description for BillController
/// </summary>
namespace WebX.Controllers
{
    public class BillController
    {
        public BillController()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        public static void BillEntry(Bill bill, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[30];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@billno", bill.BillNo, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@dockno", bill.DocketNo, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@billbranch", bill.BillBranch, SqlDbType.VarChar);
                if (bill.BillGenDate > DateTime.MinValue && bill.BillGenDate < DateTime.MaxValue)
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@billgendate", bill.BillGenDate, SqlDbType.DateTime);
                else
                    paramsToStore[3] = ControllersHelper.GetSqlParameter("@billgendate", DBNull.Value);
                if (bill.BillDueDate > DateTime.MinValue && bill.BillDueDate < DateTime.MaxValue)
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@billduedate", bill.BillDueDate, SqlDbType.DateTime);
                else
                    paramsToStore[4] = ControllersHelper.GetSqlParameter("@billduedate", DBNull.Value);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@billgenloc", bill.BillBranch, SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@billsubloc", bill.BillSubBRCD, SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@billcolloc", bill.BillColBRCD, SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@billtype", bill.BillType, SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@partycode", bill.PartyCode, SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@partyname", bill.PartyName, SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@partyaddress", bill.PartyAddress, SqlDbType.VarChar);
                paramsToStore[12] = ControllersHelper.GetSqlParameter("@partyphone", bill.PartyPhoneNo, SqlDbType.VarChar);
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@partyemail", bill.PartyEmail, SqlDbType.VarChar);
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@businesstype", bill.BusinessType, SqlDbType.VarChar);
                paramsToStore[15] = ControllersHelper.GetSqlParameter("@billamount", bill.BillAmount, SqlDbType.Decimal);
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@pendingamount", bill.PendingAmount, SqlDbType.Decimal);
                paramsToStore[17] = ControllersHelper.GetSqlParameter("@servicetax", bill.ServiceTax, SqlDbType.Decimal);
                paramsToStore[18] = ControllersHelper.GetSqlParameter("@educess", bill.ServiceTaxRate, SqlDbType.Decimal);
                paramsToStore[19] = ControllersHelper.GetSqlParameter("@heducess", bill.HEduCess, SqlDbType.Decimal);
                paramsToStore[20] = ControllersHelper.GetSqlParameter("@servicetaxrate", bill.ServiceTaxRate, SqlDbType.Decimal);
                paramsToStore[21] = ControllersHelper.GetSqlParameter("@educessrate", bill.EduCessRate, SqlDbType.Decimal);
                paramsToStore[22] = ControllersHelper.GetSqlParameter("@heducessrate", bill.HEduCessRate, SqlDbType.Decimal);
                paramsToStore[23] = ControllersHelper.GetSqlParameter("@billstatus", bill.BillStatus, SqlDbType.VarChar);
                paramsToStore[24] = ControllersHelper.GetSqlParameter("@flagbillclose", bill.FlagBillClose, SqlDbType.VarChar);
                paramsToStore[25] = ControllersHelper.GetSqlParameter("@billgenempcode", bill.BillGenEmpCode, SqlDbType.VarChar);
                paramsToStore[26] = ControllersHelper.GetSqlParameter("@flagbillcancel", bill.FlagBillCancel, SqlDbType.VarChar);
                if (bill.FinCloseDate > DateTime.MinValue && bill.FinCloseDate < DateTime.MaxValue)
                    paramsToStore[27] = ControllersHelper.GetSqlParameter("@finclosedate", bill.FinCloseDate, SqlDbType.DateTime);
                else
                    paramsToStore[27] = ControllersHelper.GetSqlParameter("@finclosedate", DBNull.Value);
                paramsToStore[28] = ControllersHelper.GetSqlParameter("@remarks", bill.Remark, SqlDbType.VarChar);
                paramsToStore[29] = ControllersHelper.GetSqlParameter("@doctype", bill.DocType, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_BILL_ENTRY", paramsToStore);

            }
            catch (Exception excp)
            {
                throw excp;
            }


        }
    }

}
