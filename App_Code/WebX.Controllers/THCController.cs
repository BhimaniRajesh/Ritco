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
    /// Summary description for THCController
    /// </summary>
    public class THCController:Base
    {
        public THCController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        /// <summary>
        /// Gets Necessary Details to Load THC Query Page For THC From Docket
        /// </summary>
        /// <param name="loccode"></param>
        /// <returns></returns>
        public static DataSet GetQueryDetails()
        {
            DataSet ds = new DataSet();            
            try
            {
                ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_QueryPage_Details");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        /// <summary>
        /// Gets Necessary Details to Load THC Query Page For THC From Docket
        /// </summary>
        /// <param name="loccode"></param>
        /// <returns></returns>
        public static DataSet GetStep1Details()
        {
            DataSet ds = new DataSet();
            try
            {
                ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_QueryStep1_Details");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }
        public static DataSet GetAirLineDetail(string BranchCode)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[1];

            param[0] = ControllersHelper.GetSqlParameter("@Branch", BranchCode, SqlDbType.VarChar);
            try
            {
                ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_AirLine_Details", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public static DataSet GetAirPortDetail()
        {
            DataSet ds = new DataSet();

            try
            {
                ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_Airport_Details");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }
        public static DataSet GetFlightDetail(string AirportCode,string AirLine)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];

            param[0] = ControllersHelper.GetSqlParameter("@AirPortCode", AirportCode, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@AirLineCode", AirLine, SqlDbType.VarChar);
            try
            {
                ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_Flight_Details", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public static DataSet GetFlightTimeDetail(string AirportCode, string FlightCode)
        {
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];

            param[0] = ControllersHelper.GetSqlParameter("@AirPortCode", AirportCode, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@FlightCode", FlightCode, SqlDbType.VarChar);
            try
            {
                ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_FlightSchedule_Details", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        public static DataTable GetRouteFromRouteMode(string BranchCode, string RouteMode, bool IsEmptyVehicle)
        {
            DataTable RouteDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[3];

            param[0] = ControllersHelper.GetSqlParameter("@brcd", BranchCode, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@routemode", RouteMode, SqlDbType.VarChar);
            param[2] = ControllersHelper.GetSqlParameter("@IsEmptyRoot",WebXConvert.ToY_N(IsEmptyVehicle), SqlDbType.VarChar);
            try
            {
                RouteDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_RouteNames_For_THC", param).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RouteDetails;
        }

        public static DataTable GetVendorTypesRouteMode(string RouteMode)
        {
            DataTable VendorTypeDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[1];
           
            param[0] = ControllersHelper.GetSqlParameter("@route_mode", RouteMode, SqlDbType.VarChar);
 
            try
            {
                VendorTypeDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Vendor_Types", param).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return VendorTypeDetails;
        }

        public static DataTable GetVendorFromVendorTypes(string BranchCode, string VendorType)
        {
            DataTable VendorDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[2];

            param[0] = ControllersHelper.GetSqlParameter("@vendor_type", VendorType, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@brcd", BranchCode, SqlDbType.VarChar);

            try
            {
                VendorDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Vendors", param).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return VendorDetails;
        }

        public static DataTable GetVehivleFromVendor(string VendorType, string Vendor)
        {
            DataTable VehivleDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[2];

            param[0] = ControllersHelper.GetSqlParameter("@vendortype", VendorType, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@vendorcode", Vendor, SqlDbType.VarChar);

            try
            {
                VehivleDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Vendor_Vehicles", param).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return VehivleDetails;
        }

        public static DataSet GetVehivleDetails(string Vehicle)
        {
            DataSet VehivleDetails = new DataSet();
            SqlParameter[] param = new SqlParameter[1];

            param[0] = ControllersHelper.GetSqlParameter("@vehno", Vehicle, SqlDbType.VarChar);
           
            try
            {
                VehivleDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_Vehicles", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return VehivleDetails;
        }
        public static DataSet GetVehivleTypeDetails(string VehicleType)
        {
            DataSet VehivleDetails = new DataSet();
            SqlParameter[] param = new SqlParameter[1];

            param[0] = ControllersHelper.GetSqlParameter("@VehType", VehicleType, SqlDbType.VarChar);

            try
            {
                VehivleDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_VehicleType_Capacity", param);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return VehivleDetails;
        }

        public static DataSet GetTHCGenerationRule()
        {
            DataSet THCRuleDetails = new DataSet();
          
            try
            {
                THCRuleDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_Rules_For_THC_generation");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return THCRuleDetails;
        }

        public static DataTable GetDocketdetails(string BranchCode, string Destination, string LocType, string DateType, string FromDate, string ToDate, string PayBasis, string TrnMode,string BookingType,string BusinessType)
        {
            DataTable DocketDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[10];

            param[0] = ControllersHelper.GetSqlParameter("@BranchCode", BranchCode, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@Destination", Destination, SqlDbType.VarChar);
            param[2] = ControllersHelper.GetSqlParameter("@LocType", LocType, SqlDbType.VarChar);
            param[3] = ControllersHelper.GetSqlParameter("@DateType", DateType, SqlDbType.VarChar);
            param[4] = ControllersHelper.GetSqlParameter("@FromDate", FromDate, SqlDbType.VarChar);
            param[5] = ControllersHelper.GetSqlParameter("@ToDate", ToDate, SqlDbType.VarChar);
            param[6] = ControllersHelper.GetSqlParameter("@PayBasis", PayBasis, SqlDbType.VarChar);
            param[7] = ControllersHelper.GetSqlParameter("@TrnMode", TrnMode, SqlDbType.VarChar);
            param[8] = ControllersHelper.GetSqlParameter("@BookingType", BookingType, SqlDbType.VarChar);
            param[9] = ControllersHelper.GetSqlParameter("@BusinessType", BusinessType, SqlDbType.VarChar);

            try
            {
                DocketDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_DocketList_For_THC_Generation", param).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return DocketDetails;
        }


        public static DataTable THCGenerate(string BranchCode, string mfdt, string xmlTCHDR, string xmlTCTRN, string xmlWTDS, string HDR_DETAILS, string DET_DETAILS, string findetval, string THCTYPE)
        {
            DataTable DocketDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[10];

            param[0] = ControllersHelper.GetSqlParameter("@brcd", BranchCode, SqlDbType.VarChar, 50);
            param[1] = ControllersHelper.GetSqlParameter("@mfdt", mfdt, SqlDbType.VarChar, 250);
            param[2] = ControllersHelper.GetSqlParameter("@xmlTCHDR", xmlTCHDR, SqlDbType.VarChar, 8000);
            param[3] = ControllersHelper.GetSqlParameter("@xmlTCTRN", xmlTCTRN, SqlDbType.Text);
            param[4] = ControllersHelper.GetSqlParameter("@xmlWTDS", xmlWTDS, SqlDbType.VarChar, 8000);
            param[5] = ControllersHelper.GetSqlParameter("@FinYear", SessionUtilities.FinYear.ToString().Trim().Substring(0, 4), SqlDbType.VarChar);
            param[6] = ControllersHelper.GetSqlParameter("@Str_HDR", HDR_DETAILS, SqlDbType.VarChar, 8000);
            param[7] = ControllersHelper.GetSqlParameter("@Str_DET", DET_DETAILS, SqlDbType.VarChar, 8000);
            param[8] = ControllersHelper.GetSqlParameter("@FINDET", findetval, SqlDbType.VarChar, 8000);
            param[9] = ControllersHelper.GetSqlParameter("@THCTYPE", THCTYPE, SqlDbType.VarChar, 8);

            try
            {
                DocketDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_Generate_ver5", param).Tables[1];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return DocketDetails;
        }

        public static DataTable GetPaymentDetails(string PaymentType)
        {
            DataTable DocketDetails = new DataTable();
            SqlParameter[] param = new SqlParameter[1];

            param[0] = ControllersHelper.GetSqlParameter("@TYP", PaymentType, SqlDbType.VarChar);


            try
            {
                DocketDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "WebxNet_CLList_Of_FinDet", param).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return DocketDetails;
        }
        /// <summary>
        /// GetTHCListForAudit This method is use to get data from thc audit
        /// </summary>
        /// <param name="THCNumber"></param>
        /// <param name="FromDate"></param>
        /// <param name="ToDate"></param>
        /// <returns></returns>
        public static DataTable GetTHCListForAudit(string THCNumber, string FromDate,string ToDate,string Location)
        {
            DataTable dtTHCList = new DataTable();
            SqlParameter[] param = new SqlParameter[4];

            param[0] = ControllersHelper.GetSqlParameter("@THCNumber", THCNumber, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@FromDate", Convert.ToDateTime(FromDate), SqlDbType.DateTime);
            param[2] = ControllersHelper.GetSqlParameter("@ToDate", Convert.ToDateTime(ToDate), SqlDbType.DateTime);
            param[3] = ControllersHelper.GetSqlParameter("@Location", Location, SqlDbType.VarChar);

            try
            {
                dtTHCList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_GetTHCListForAudit", param).Tables[0];
            }
            catch (Exception ex)
            {
                ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
                throw ex;
            }
            return dtTHCList;
        }
        /// <summary>
        /// GetTHCListForDeviationAudit This method is use to get data from thc audit which are deviation
        /// </summary>
        /// <param name="THCNumber"></param>
        /// <param name="FromDate"></param>
        /// <param name="ToDate"></param>
        /// <returns></returns>
        public static DataTable GetTHCListForDeviationAudit(string THCNumber, string FromDate, string ToDate,string Location)
        {
            DataTable dtTHCList = new DataTable();
            SqlParameter[] param = new SqlParameter[4];

            param[0] = ControllersHelper.GetSqlParameter("@THCNumber", THCNumber, SqlDbType.VarChar);
            param[1] = ControllersHelper.GetSqlParameter("@FromDate", Convert.ToDateTime(FromDate), SqlDbType.DateTime);
            param[2] = ControllersHelper.GetSqlParameter("@ToDate", Convert.ToDateTime(ToDate), SqlDbType.DateTime);
            param[3] = ControllersHelper.GetSqlParameter("@Location", Location, SqlDbType.VarChar);


            try
            {
                dtTHCList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_THC_GetTHCListForDeviationAudit", param).Tables[0];
            }
            catch (Exception ex)
            {
                ExceptionUtility.LogException(ex, HttpContext.Current.Request.Url.AbsoluteUri);
                throw ex;
            }
            return dtTHCList;
        }

        public void UpdateAuditedTHC(DataTable dtTHCAudit)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@THCAuditType", dtTHCAudit, SqlDbType.Structured);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@UpdatedBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);

                InsertHelper("Usp_THC_UpdateAuditedTHC", paramsToStore);
               
            }
            catch (Exception excp)
            {
                ExceptionUtility.LogException(excp, HttpContext.Current.Request.Url.AbsoluteUri);
                throw excp;
            }


        }
        public void UpdateDeviationTHC(DataTable dtTHCAudit)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[3];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@THCAuditType", dtTHCAudit, SqlDbType.Structured);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@UpdatedBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@DeviationBy", SessionUtilities.CurrentEmployeeID, SqlDbType.VarChar);
                InsertHelper("Usp_THC_UpdateDeviationTHC", paramsToStore);

            }
            catch (Exception excp)
            {
                ExceptionUtility.LogException(excp, HttpContext.Current.Request.Url.AbsoluteUri);
                throw excp;
            }


        }
    }
}