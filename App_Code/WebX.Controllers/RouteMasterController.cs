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
    /// Summary description for RouteMasterController
    /// </summary>
    public class RouteMasterController
    {
        #region Constructor
        public RouteMasterController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        #endregion

        #region Public Function[s]
        // insert new record into webx_STATE table
        public int insertRouteMaster(RouteMaster objectRouteMaster, string Flag)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_ROUTE_MASTER_Insert", saveRouteMasterParam(objectRouteMaster, Flag));
            return result;
        }

        // update new record into webx_STATE table
        public int updateRouteMaster(RouteMaster objectRouteMaster, string Flag)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_webx_ROUTE_MASTER_Update", saveRouteMasterParam(objectRouteMaster, Flag));
            return result;
        }

        // Get Route information from webx_rutmas By Route Code       
        public DataTable getRouteByRouteCode(string strRouteCode)
        {
            DataSet dsRouteInfo = new DataSet();
            dsRouteInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_rutmas WHERE RUTCD = '" + strRouteCode + "'");
            return dsRouteInfo.Tables[0];
        }

        // Get Route Transition information from webx_ruttran By Route Code       
        public DataTable getRouteTransitionByRouteCode(string strRouteCode)
        {
            DataSet dsRouteInfo = new DataSet();
            dsRouteInfo = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT * FROM webx_ruttran WHERE RUTCD = '" + strRouteCode + "' order by RUTNO");
            return dsRouteInfo.Tables[0];
        }

        // Get All Route from webx_rutmas by Route Mode       
        public DataTable getAllRouteByRouteMode(string strRouteMode)
        {
            DataSet dsRoute = new DataSet();
            if (strRouteMode == "All")
                dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd as RouteCode, rutcd + ' : ' + rutnm As Route FROM webx_rutmas ORDER BY rutnm");
            else
                dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd as RouteCode, rutcd + ' : ' + rutnm As Route FROM webx_rutmas WHERE rutmod='" + strRouteMode + "'  order by rutnm");

            return dsRoute.Tables[0];
        }

        // Get next Route code     
        public int getNextRouteCode(string routeCategory)
        {
            try
            {
                object obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT CAST(RIGHT(MAX(rutcd),4) AS integer) + 1 FROM webx_rutmas WHERE substring(rutcd,1,1)='" + routeCategory + "'");

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

        // delete record from webx_ruttran table
        public int deleteRouteMaster(int id, string strRouteCode)
        {
            int result;
            result = SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, "DELETE FROM webx_ruttran WHERE RUTNO='" + id + "' AND RUTCD='" + strRouteCode + "'");
            return result;
        }

        // Get All Route information from webx_rutmas       
        public DataTable getAllRoute()
        {
            DataSet dsRoute = new DataSet();
            dsRoute = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT rutcd,rutnm, CASE WHEN rutmod='S' THEN 'Road' WHEN rutmod='R' THEN 'Rail' WHEN rutmod='A' THEN 'Air' ELSE '' end as rutmod,rutkm,transhrs FROM webx_rutmas order by rutnm");
            return dsRoute.Tables[0];
        }

        #endregion             

        #region  Private Function[s]
        private SqlParameter[] saveRouteMasterParam(RouteMaster objectRouteMaster, string Flag)
        {
            SqlParameter[] arParms = {   
                                    new SqlParameter ("@RUTCD", SqlDbType.VarChar, 10),              
                                    new SqlParameter ("@RUTSTBR", SqlDbType.VarChar, 10),
                                    new SqlParameter ("@RUTENDBR", SqlDbType.VarChar, 10),
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
                                    new SqlParameter ("@ControlLoc", SqlDbType.VarChar, 10),
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

            arParms[0].Value = objectRouteMaster.RouteCode;
            arParms[1].Value = objectRouteMaster.RouteStBranch;
            arParms[2].Value = objectRouteMaster.RouteEdBranch;
            arParms[3].Value = objectRouteMaster.RouteCategory;
            arParms[4].Value = objectRouteMaster.RouteKM;
            arParms[5].Value = objectRouteMaster.RouteStDate;
            arParms[6].Value = objectRouteMaster.RouteEdDate;
            arParms[7].Value = objectRouteMaster.ActiveFlag;
            arParms[8].Value = objectRouteMaster.UpdateBy;
            arParms[9].Value = objectRouteMaster.UpdateOnDate;
            arParms[10].Value = objectRouteMaster.RouteName;
            arParms[11].Value = objectRouteMaster.RouteSchDepHour;
            arParms[12].Value = objectRouteMaster.RouteSchDepMin;
            arParms[13].Value = objectRouteMaster.STD_CONTAMT;
            arParms[14].Value = objectRouteMaster.RouteMode;
            arParms[15].Value = objectRouteMaster.ControlLocation;
            arParms[16].Value = objectRouteMaster.TransitionHour;
            arParms[17].Value = objectRouteMaster.RouteNumber;
            arParms[18].Value = objectRouteMaster.LocationCode;
            arParms[19].Value = objectRouteMaster.Distance;
            arParms[20].Value = objectRouteMaster.TRTIME_HR;
            arParms[21].Value = objectRouteMaster.TRTIME_MIN;
            arParms[22].Value = objectRouteMaster.STTIME_HR;
            arParms[23].Value = objectRouteMaster.STTIME_MIN;
            arParms[24].Value = Flag;

            return arParms;
        }
        #endregion
    }
}
