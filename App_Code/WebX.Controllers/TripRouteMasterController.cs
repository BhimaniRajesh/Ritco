using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

using WebX.Entity;

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for RouteMasterCityController
    /// </summary>
    public class TripRouteMasterController
    {
        #region Constructor
        public TripRouteMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion
        // Get Route Details for XLS Download     
        public DataTable getRouteHdrDetails()
        {
            DataSet dsRouteHdrDetails = new DataSet();
            dsRouteHdrDetails = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT (select codedesc from webx_master_general where codetype='ROUTE' and codeid=rm.rutmod) as ROUTEMODE,rm.* FROM webx_trip_rutmas as rm order by rm.rutcd");
            return dsRouteHdrDetails.Tables[0];
        }
        public DataTable getRouteDet(string sRutcd)
        {
            DataSet dsRouteDet = new DataSet();
            dsRouteDet = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT (SELECT location FROM webx_citymaster where convert(varchar,city_code)=webx_trip_ruttran.LOCCD) AS LOCNAME,* FROM [webx_trip_ruttran] Where Rutcd='" + sRutcd.Trim() + "'");
            return dsRouteDet.Tables[0];
        }
        #region Public Function[s]
        // insert new record into webx_STATE table
        public int insertRouteMasterCity(TripRouteMaster  objectTripRouteMaster, string Flag)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_TRIP_ROUTE_MASTER_Insert", saveTripRouteMasterParam(objectTripRouteMaster, Flag));
            return result;
        }

        // update new record into webx_STATE table
        public int updateRouteMasterCity(TripRouteMaster objectTripRouteMaster, string Flag)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_TRIP_ROUTE_MASTER_Update", saveTripRouteMasterParam(objectTripRouteMaster, Flag));
            return result;
        }
        public string GetLastRoucdCode()
        {
            object obj;
            obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select max(rutcd) as rutcd from webx_trip_rutmas");

            return Convert.ToString(obj);
        }
        // Get City Route information from webx_rutmas_city By Route Code       
        public DataTable getCityRouteByRouteCode(string strRouteCode)
        {
            DataSet dsRouteInfo = new DataSet();
            dsRouteInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_trip_rutmas WHERE RUTCD = '" + strRouteCode + "'");
            return dsRouteInfo.Tables[0];
        }

        // Get City Route Transition information from webx_ruttran_city By Route Code       
        public DataTable getRouteTransitionByRouteCode(string strRouteCode)
        {
            DataSet dsRouteInfo = new DataSet();
            dsRouteInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT (SELECT location FROM webx_citymaster where convert(varchar,city_code)=webx_trip_ruttran.LOCCD) AS LOCNAME,* FROM webx_trip_ruttran WHERE RUTCD = '" + strRouteCode + "' order by RUTNO");
            return dsRouteInfo.Tables[0];
        }

        // Get All City Route from webx_rutmas_city by Route Mode       
        public DataTable getAllCityRouteByRouteMode(string strRouteMode)
        {
            DataSet dsRoute = new DataSet();
            if (strRouteMode == "All")
                dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd as RouteCode, rutcd + ' : ' + rutnm As Route FROM webx_trip_rutmas ORDER BY rutnm");
            else
                dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd as RouteCode, rutcd + ' : ' + rutnm As Route FROM webx_trip_rutmas WHERE rutmod='" + strRouteMode + "'  order by rutnm");

            return dsRoute.Tables[0];
        }

        // Get next Route code     
        // Get next Route code     
        
        public int getNextRouteCode(string routeCategory)
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CAST(RIGHT(MAX(rutcd),4) AS integer) + 1 FROM webx_trip_rutmas WHERE substring(rutcd,1,1)='" + routeCategory + "'");

                if (obj is DBNull)
                    return 1;
                else
                    return (int)obj;
            }
            catch (Exception Exc)
            {
                return 1;
            }
        }
        public string getLocName(string strLocCode)
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT location FROM webx_citymaster WHERE activeflag='Y' and city_code ='" + strLocCode + "'");

                if (obj is DBNull)
                    return "";
                else
                    return (string)obj;
            }
            catch (Exception Exc)
            {
                return "";
            }
        }

        // delete record from webx_ruttran_city table
        public int deleteCityRouteMaster(int id, string strRouteCode)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, "DELETE FROM webx_trip_ruttran WHERE RUTNO='" + id + "' AND RUTCD='" + strRouteCode + "'");
            return result;
        }

        // Get All City Route information from webx_rutmas_city       
        public DataTable getAllCityRoute()
        {
            DataSet dsRoute = new DataSet();
            dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd,rutnm, CASE WHEN rutmod='S' THEN 'Road' WHEN rutmod='R' THEN 'Rail' WHEN rutmod='A' THEN 'Air' ELSE '' end as rutmod,rutkm,transhrs FROM webx_trip_rutmas order by rutnm");
            return dsRoute.Tables[0];
        }

        #endregion             

        #region  Private Function[s]
        private SqlParameter[] saveTripRouteMasterParam(TripRouteMaster objectTripRouteMaster, string Flag)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@RUTCD", SqlDbType.VarChar, 5),              
                                    new SqlParameter ("@RUTSTBR", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@RUTENDBR", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@RUTCAT", SqlDbType.VarChar, 6),
                                    new SqlParameter ("@RUTKM", SqlDbType.Decimal),                            
                                    new SqlParameter ("@RUTSTDT", SqlDbType.DateTime),
                                    new SqlParameter ("@RUTENDDT", SqlDbType.DateTime),
                                    new SqlParameter ("@ACTIVEFLAG", SqlDbType.VarChar, 1),
                                    new SqlParameter ("@UPDTBY", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@UPDTON", SqlDbType.DateTime),
                                    new SqlParameter ("@RUTNM", SqlDbType.VarChar, 50),                                   
                                    new SqlParameter ("@SCHDEP_HR", SqlDbType.Decimal),
                                    new SqlParameter ("@SCHDEP_MIN", SqlDbType.Decimal),               
                                    new SqlParameter ("@STD_CONTAMT", SqlDbType.Decimal),
                                    new SqlParameter ("@RUTMOD", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@ControlLoc", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@TransHrs", SqlDbType.Decimal),                            
                                    new SqlParameter ("@RUTNO", SqlDbType.Int),
                                    new SqlParameter ("@LOCCD", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@DIST_KM", SqlDbType.Decimal),
                                    new SqlParameter ("@TRTIME_HR", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@TRTIME_MIN", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@STTIME_HR", SqlDbType.VarChar, 25),                                   
                                    new SqlParameter ("@STTIME_MIN", SqlDbType.VarChar, 25),
                                    new SqlParameter ("@Flag", SqlDbType.VarChar, 2),
                                    new SqlParameter ("@ONW_RET", SqlDbType.VarChar, 50),
                                    new SqlParameter ("@RUTDESC", SqlDbType.VarChar, 5000),
                                    new SqlParameter ("@ROUND_TRIP", SqlDbType.VarChar, 1)
                                 };

            arParms[0].Value = objectTripRouteMaster.RouteCode;
            arParms[1].Value = objectTripRouteMaster.RouteStBranch;
            arParms[2].Value = objectTripRouteMaster.RouteEdBranch;
            arParms[3].Value = objectTripRouteMaster.RouteCategory;
            arParms[4].Value = objectTripRouteMaster.RouteKM;
            arParms[5].Value = objectTripRouteMaster.RouteStDate;
            arParms[6].Value = objectTripRouteMaster.RouteEdDate;
            arParms[7].Value = objectTripRouteMaster.ActiveFlag;
            arParms[8].Value = objectTripRouteMaster.UpdateBy;
            arParms[9].Value = objectTripRouteMaster.UpdateOnDate;
            arParms[10].Value = objectTripRouteMaster.RouteName;
            arParms[11].Value = objectTripRouteMaster.RouteSchDepHour;
            arParms[12].Value = objectTripRouteMaster.RouteSchDepMin;
            arParms[13].Value = objectTripRouteMaster.STD_CONTAMT;
            arParms[14].Value = objectTripRouteMaster.RouteMode;
            arParms[15].Value = objectTripRouteMaster.ControlLocation;
            arParms[16].Value = objectTripRouteMaster.TransitionHour;
            arParms[17].Value = objectTripRouteMaster.RouteNumber;
            arParms[18].Value = objectTripRouteMaster.LocationCode;
            arParms[19].Value = objectTripRouteMaster.Distance;
            arParms[20].Value = objectTripRouteMaster.TRTIME_HR;
            arParms[21].Value = objectTripRouteMaster.TRTIME_MIN;
            arParms[22].Value = objectTripRouteMaster.STTIME_HR;
            arParms[23].Value = objectTripRouteMaster.STTIME_MIN;
            arParms[24].Value = Flag;
            arParms[25].Value = objectTripRouteMaster.ONW_RET;
            arParms[26].Value = objectTripRouteMaster.RUTDESC;
            arParms[27].Value = objectTripRouteMaster.ROUND_TRIP;
            return arParms;
        }
        #endregion
    }
}
