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

    public class TripApprovalController : Base
    {
        public TripApprovalController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable GetTripsheetForApprovalAndFinacialClosure(string TripsheetNo, string Type, DateTime FromDate, DateTime ToDate, string FleetCenter, string Module)
        {
            //return ExecuteDataSet("USP_TripApproval_GetTripsheetList",
            return ExecuteDataSet("USP_TripApprovalFinclosure_GetTripsheetList",
                new SqlParameter[] {
                    new SqlParameter("@FromDate", FromDate) ,
                    new SqlParameter("@ToDate", ToDate),
                    new SqlParameter("@FleetCentre", FleetCenter) ,
                    new SqlParameter("@Type", Type) ,
                    new SqlParameter("@Module", Module) ,
                    new SqlParameter("@TripsheetNo_VehicleNo", TripsheetNo)
            }, false).Tables[0];

        }

        public DataTable GetTripsheetEnRouteExpenseDetails(string TripsheetNo, string route, string VehicleNo)
        {

            return ExecuteDataSet("USP_TripApproval_GetEnRouteDetails",
                new SqlParameter[] {
                    new SqlParameter("@Route", route) ,
                    new SqlParameter("@VehicleNo", VehicleNo),
                    new SqlParameter("@TripSheetNo", TripsheetNo)
            }, false).Tables[0];

        }

        public DataSet GetTripsheetExtraExpenseDetails(string TripsheetNo)
        {
            return ExecuteDataSet("USP_TripApproval_GetTripsheetFuleAddBlueTollExpenseDetail",
                new SqlParameter[] {
                    new SqlParameter("@TripsheetNo", TripsheetNo)
            }, false);

        }

        public DataSet TripsheetApprovalEntry(string TripsheetNo, string XML, string EnrouteFuelFixedPerXML, string Fuel_CF, 
            string FixedPerKM_Type, string FixedPerKM_Value, string ApprovedFuelTotal, string ApprovedFuelTotalRemark, string ProtsahanRashiXML,
            string AddBlue_CF, string AddBlueFixedPerKM_Type, string AddBlueFixedPerKM_Value, string ApprovedAddBlueTotal, string ApprovedAddBlueTotalRemark)
        {
            return ExecuteDataSet("USP_TripApproval_Entry",
                new SqlParameter[] {
                    new SqlParameter("@XML", XML),
                    new SqlParameter("@TripsheetNo", TripsheetNo),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID) ,
                    new SqlParameter("@ExpenseFuelXml", EnrouteFuelFixedPerXML) ,
                    new SqlParameter("@FixedPerKM_Type", FixedPerKM_Type) ,
                    new SqlParameter("@FixedPerKM_Value", FixedPerKM_Value) ,
                    new SqlParameter("@Fuel_Proposed",ApprovedFuelTotal) ,
                    new SqlParameter("@Fuel_CF",Fuel_CF) ,
                    new SqlParameter("@Fuel_Remark", ApprovedFuelTotalRemark),
                    new SqlParameter("@AddBlueFixedPerKM_Type", AddBlueFixedPerKM_Type) ,
                    new SqlParameter("@AddBlueFixedPerKM_Value", AddBlueFixedPerKM_Value) ,
                    new SqlParameter("@AddBlue_Proposed",ApprovedAddBlueTotal) ,
                    new SqlParameter("@AddBlue_CF",AddBlue_CF) ,
                    new SqlParameter("@AddBlue_Remark", ApprovedAddBlueTotalRemark),
                    new SqlParameter("@ProtsahanRashiXML", ProtsahanRashiXML)
            }, true);
        }


        public DataSet TripsheetReconsiderationEntry(string TripsheetNo, string remark)
        {
            return ExecuteDataSet("USP_TripFinancialClosure_TripSheetReconsiderationEntry",
                new SqlParameter[] {
                    new SqlParameter("@Remark", remark),
                    new SqlParameter("@TripSheetNo", TripsheetNo),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
            }, true);
        }

        public DataSet TripsheetFinancialClosureEntry(string TripsheetNo)
        {
            return ExecuteDataSet("USP_TripFinancialClosure_Entry",
                new SqlParameter[] {
                    new SqlParameter("@TripSheetNo", TripsheetNo),
                    new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
            }, true);
        }


        public DataSet TripsheetFinancialClosureResultData(string TripsheetNo)
        {
            return ExecuteDataSet("USP_TripFinancialClosure_ResultData",
                new SqlParameter[] {
                    new SqlParameter("@TripSheetNo", TripsheetNo)
            }, true);
        }

        public DataSet GetFleetCenter()
        {
            return ExecuteDataSet("USP_GetFeetCenter", null, false);

        }

        public DataSet VehicleViewPrintDetail(string vehicleno)
        {
            return ExecuteDataSet("USP_VehicleMaster_ViewPrint",
              new SqlParameter[] {
                    new SqlParameter("@VehicleNo", vehicleno)
            }, true);

        }

        public DataSet DriverViewPrintDetail(string driverid)
        {
            return ExecuteDataSet("USP_DriverMaster_ViewPrint",
              new SqlParameter[] {
                    new SqlParameter("@DriverID", driverid)
            }, true);

        }

        public string GetDriverBalance(string driverid)
        {
            string Bal = "0";
            var dt = new DataTable();
            dt = ExecuteDataSet("USP_Tripsheet_GetDriverBalance",
              new SqlParameter[] {
                    new SqlParameter("@DriverID", driverid)
            }, false).Tables[0];

            if (dt.Rows.Count > 0)
            {
                Bal = dt.Rows[0]["BalanceToDriverLedger"].ToString();
            }
            return Bal;
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


        public DataSet TripsubmissionCancellation(string TripsheetNo)
        {
            return ExecuteDataSet("USP_TripsubmissionException_CancelTripsubmissionOnApproval",
                new SqlParameter[] {
                    new SqlParameter("@TripsheetNo", TripsheetNo),
                    new SqlParameter("@RejectedBy", SessionUtilities.CurrentEmployeeID)
            }, true);

        }

    }
}