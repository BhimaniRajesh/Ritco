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
    public class RouteMasterCityController
    {
        #region Constructor
        public RouteMasterCityController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]
        // insert new record into webx_STATE table
        public int insertRouteMasterCity(RouteMasterCity objectRouteMasterCity, string Flag)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_ROUTE_MASTER_CITY_Insert", saveRouteMasterCityParam(objectRouteMasterCity, Flag));
            return result;
        }

        // update new record into webx_STATE table
        public int updateRouteMasterCity(RouteMasterCity objectRouteMasterCity, string Flag)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_ROUTE_MASTER_CITY_Update", saveRouteMasterCityParam(objectRouteMasterCity, Flag));
            return result;
        }

        // Get City Route information from webx_rutmas_city By Route Code       
        public DataTable getCityRouteByRouteCode(string strRouteCode)
        {
            DataSet dsRouteInfo = new DataSet();
            dsRouteInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_rutmas_city WHERE RUTCD = '" + strRouteCode + "'");
            return dsRouteInfo.Tables[0];
        }

        // Get City Route Transition information from webx_ruttran_city By Route Code       
        public DataTable getRouteTransitionByRouteCode(string strRouteCode)
        {
            DataSet dsRouteInfo = new DataSet();
            dsRouteInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_ruttran_city WHERE RUTCD = '" + strRouteCode + "' order by RUTNO");
            return dsRouteInfo.Tables[0];
        }

        // Get All City Route from webx_rutmas_city by Route Mode       
        public DataTable getAllCityRouteByRouteMode(string strRouteMode)
        {
            DataSet dsRoute = new DataSet();
            if (strRouteMode == "All")
                dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd as RouteCode, rutcd + ' : ' + rutnm As Route FROM webx_rutmas_city ORDER BY rutnm");
            else
                dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd as RouteCode, rutcd + ' : ' + rutnm As Route FROM webx_rutmas_city WHERE rutmod='" + strRouteMode + "'  order by rutnm");

            return dsRoute.Tables[0];
        }

        // Get next Route code     
        public int getNextCityRouteCode(string routeCategory)
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CAST(RIGHT(MAX(rutcd),4) AS integer) + 1 FROM webx_rutmas_city WHERE substring(rutcd,1,1)='" + routeCategory + "'");

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

        // delete record from webx_ruttran_city table
        public int deleteCityRouteMaster(int id, string strRouteCode)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, "DELETE FROM webx_ruttran_city WHERE RUTNO='" + id + "' AND RUTCD='" + strRouteCode + "'");
            return result;
        }

        // Get All City Route information from webx_rutmas_city       
        public DataTable getAllCityRoute()
        {
            DataSet dsRoute = new DataSet();
            dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd,rutnm, CASE WHEN rutmod='S' THEN 'Road' WHEN rutmod='R' THEN 'Rail' WHEN rutmod='A' THEN 'Air' ELSE '' end as rutmod,rutkm,transhrs FROM webx_rutmas_city order by rutnm");
            return dsRoute.Tables[0];
        }

        #endregion             

        #region  Private Function[s]
        private SqlParameter[] saveRouteMasterCityParam(RouteMasterCity objectRouteMasterCity, string Flag)
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
                                    new SqlParameter ("@Flag", SqlDbType.VarChar, 2)                 
                                 };

            arParms[0].Value = objectRouteMasterCity.RouteCode;
            arParms[1].Value = objectRouteMasterCity.RouteStBranch;
            arParms[2].Value = objectRouteMasterCity.RouteEdBranch;
            arParms[3].Value = objectRouteMasterCity.RouteCategory;
            arParms[4].Value = objectRouteMasterCity.RouteKM;
            arParms[5].Value = objectRouteMasterCity.RouteStDate;
            arParms[6].Value = objectRouteMasterCity.RouteEdDate;
            arParms[7].Value = objectRouteMasterCity.ActiveFlag;
            arParms[8].Value = objectRouteMasterCity.UpdateBy;
            arParms[9].Value = objectRouteMasterCity.UpdateOnDate;
            arParms[10].Value = objectRouteMasterCity.RouteName;
            arParms[11].Value = objectRouteMasterCity.RouteSchDepHour;
            arParms[12].Value = objectRouteMasterCity.RouteSchDepMin;
            arParms[13].Value = objectRouteMasterCity.STD_CONTAMT;
            arParms[14].Value = objectRouteMasterCity.RouteMode;
            arParms[15].Value = objectRouteMasterCity.ControlLocation;
            arParms[16].Value = objectRouteMasterCity.TransitionHour;
            arParms[17].Value = objectRouteMasterCity.RouteNumber;
            arParms[18].Value = objectRouteMasterCity.LocationCode;
            arParms[19].Value = objectRouteMasterCity.Distance;
            arParms[20].Value = objectRouteMasterCity.TRTIME_HR;
            arParms[21].Value = objectRouteMasterCity.TRTIME_MIN;
            arParms[22].Value = objectRouteMasterCity.STTIME_HR;
            arParms[23].Value = objectRouteMasterCity.STTIME_MIN;
            arParms[24].Value = Flag;

            return arParms;
        }
        #endregion
    }
}
