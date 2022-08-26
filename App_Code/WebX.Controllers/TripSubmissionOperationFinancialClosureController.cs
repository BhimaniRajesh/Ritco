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
using Newtonsoft.Json;
namespace WebX.Controllers
{

    /// <summary>
    /// This controller will use to perfom opration on ETHC Payment
    /// </summary>
    public class TripSubmissionOperationFinancialClosureController : Base
    {
        public TripSubmissionOperationFinancialClosureController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable GetTripsheetHeaderDetails(string TripsheetNo)
        {

            return ExecuteDataSet("USP_Get_TripSubmissionByHeaderDetailsTripSheetNo",
                new SqlParameter[] { 
                    new SqlParameter("@TripsheetNo", TripsheetNo) 
            }, false).Tables[0];

        }

        public DataTable GetTripsheetFuelSlipDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_Get_TripSubmissionByTripSheetNoVer1",
                new SqlParameter[] { 
                    new SqlParameter("@TripSheetNo", TripsheetNo) 
            }, false).Tables[0];
        }

        public DataSet GetTripsheetEmptyKM_Detention(string TripsheetNo)
        {
            return ExecuteDataSet("USP_TripSubmission_GetEmptyKM_DetentionDetails",
                new SqlParameter[] { 
                    new SqlParameter("@TripSheetNo", TripsheetNo) 
            }, false);
        }

        public string IsTripSubmissionAlreadyDone(string TripsheetNo)
        {
            return ExecuteScalar("USP_TripSubmission_IsTripsubmissionDone",
                new SqlParameter[] { 
                    new SqlParameter("@TripSheetNo", TripsheetNo) 
            }).ToString(); ;
        }

        public DataTable GetTripsheetVehicleDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_tripsheet_TripsheetVehicleDetails",
                new SqlParameter[] { 
                    new SqlParameter("@TripsheetNo", TripsheetNo) 
            }, false).Tables[0];
        }

        public DataSet GetTripsheetViewPrint(string TripsheetNo)
        {

            return ExecuteDataSet("USP_Tripsheet_ViewPrint",
                new SqlParameter[] { 
                    new SqlParameter("@TripsheetNo", TripsheetNo) 
            }, false);

        }

        public DataSet CancelFuelSlip(string id, string module, string tripsheetno)
        {

            return ExecuteDataSet("USP_Tripsubmission_CancelFuelSlip",
                new SqlParameter[] { 
                    new SqlParameter("@SrNo", id) ,
                     new SqlParameter("@Module", module) ,
                     new SqlParameter("@TripsheetNo", tripsheetno) ,
                     new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID) 
            }, true);

        }

        public string GetRateFillingDateWise(string FillingDate, string VendorCode, string FuelType)
        {
            string strRate = "";
            DataTable dt = ExecuteDataSet("USP_TripSubmision_GetVendorRateFillingDateWise",
                new SqlParameter[] { 
                    new SqlParameter("@VendorCode", VendorCode) ,
                     new SqlParameter("@Product", FuelType) ,
                     new SqlParameter("@FillingDate", FillingDate) 
            }).Tables[0];

            if (dt.Rows.Count > 0)
            {
                strRate = dt.Rows[0]["Rate"].ToString();
            }
            return strRate;
        }

        public DataTable GetPreviouseCarryForwardDetails(string TripsheetNo)
        {

            return ExecuteDataSet("USP_Tripsubmmision_GetPreviouseCarryForwardDetails",
                new SqlParameter[] {
                    new SqlParameter("@TripsheetNo", TripsheetNo)
            }, false).Tables[0];

        }

        public DataTable GetTripSubmissionValidation(string TripsheetNo)
        {

            return ExecuteDataSet("USP_TripSubmission_Validation",
                new SqlParameter[] {
                    new SqlParameter("@TripsheetNo", TripsheetNo)
            }, false).Tables[0];

        }

        //public  DataTable InsertETHCPaymentDetail(string Xml_ETHCPaymentDetail,string Xml_PaymentDetail)
        //{
        //    try
        //    {
        //        SqlParameter[] paramsToStore = new SqlParameter[5];
        //        paramsToStore[0] = ControllersHelper.GetSqlParameter("@XMLETHCPaymentDetail", Xml_ETHCPaymentDetail, SqlDbType.VarChar);
        //        paramsToStore[1] = ControllersHelper.GetSqlParameter("@XMLPaymentDetail", Xml_PaymentDetail, SqlDbType.VarChar);
        //        paramsToStore[2] = ControllersHelper.GetSqlParameter("@CurrentBranchCode", SessionUtilities.CurrentBranchCode, SqlDbType.VarChar);
        //        paramsToStore[3] = ControllersHelper.GetSqlParameter("@FinYear", SessionUtilities.FinYear, SqlDbType.VarChar);
        //        paramsToStore[4] = ControllersHelper.GetSqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
        //        DataTable dtETHCPayment = ExecuteDataSet("", paramsToStore,true).Tables[0];
        //        return dtETHCPayment;
        //    }
        //    catch (Exception excp)
        //    {
        //        ExceptionUtility.LogException(excp, HttpContext.Current.Request.Url.AbsoluteUri);
        //        throw excp;
        //    }


        //}
    }
}