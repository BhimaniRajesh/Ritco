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
using System.Xml;
namespace WebX.Controllers
{

    /// <summary>
    /// This controller will use to perfom opration on ETHC Payment
    /// </summary>
    public class ETHCController:Base
    {
        public ETHCController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        
        public DataTable GetExternalTHCListForPendingOtherAdvance(string ETHCNo, string FromDate, string ToDate,string Location,string Customer)
        {
            DataTable dtTHCList = new DataTable();
            SqlParameter[] param = new SqlParameter[5];

            param[0] = ControllersHelper.GetSqlParameter("@ETHCNo", ETHCNo, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@FromDate", Convert.ToDateTime(FromDate), SqlDbType.DateTime);
            param[2] = ControllersHelper.GetSqlParameter("@ToDate", Convert.ToDateTime(ToDate), SqlDbType.DateTime);
            param[3] = ControllersHelper.GetSqlParameter("@Location", Location, SqlDbType.VarChar);
            param[4] = ControllersHelper.GetSqlParameter("@Customer", Customer, SqlDbType.VarChar);
            

            try
            {
                dtTHCList = ExecuteDataSet( "Usp_ExternalTHC_GetExternalTHCListForPendingOtherAdvance", param).Tables[0];
            }
            catch (Exception ex)
            {
                ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
                throw ex;
            }
            return dtTHCList;
        }

   
        public  DataTable InsertETHCPaymentDetail(string Xml_ETHCPaymentDetail,string Xml_PaymentDetail)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ETHCXML", Xml_ETHCPaymentDetail, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@ChqXml", Xml_PaymentDetail, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@Location", SessionUtilities.CurrentBranchCode, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@FinYear", SessionUtilities.FinYear, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
                DataTable dtETHCPayment = ExecuteDataSet("USP_ETHCModule_OtherAdvancePaymentEntry", paramsToStore,true).Tables[0];
                return dtETHCPayment;
            }
            catch (Exception excp)
            {
                ExceptionUtility.LogException(excp, HttpContext.Current.Request.Url.AbsoluteUri);
                throw excp;
            }


        }
    }
}