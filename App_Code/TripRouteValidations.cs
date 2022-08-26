using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;
/// <summary>
/// Summary description for DataValidations
/// </summary>
public class TripRouteValidations
{
    public TripRouteValidations()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// Checks For State from State Master
    /// </summary>
    /// <param name="stateName">State Name</param>
    /// <returns></returns>
    /// 
    public static bool IsValidRouteName(string RouteName, string RouteMode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas WHERE rutmod='" + RouteMode + "' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    public static bool IsValidCityRouteName(string RouteName, string RouteMode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE rutmod='" + RouteMode + "' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    public static bool IsValidLocCode(string LocationName)
    {
        //string sqlstr = "SELECT count(*) FROM WEBX_LOCATION WHERE LocName='" + LocationName + "'";
        string sqlstr = "SELECT count(*) FROM webx_citymaster WHERE activeflag='Y' and location='" + LocationName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    public static bool IsValidLocaton(string cityname)
    {
        string sqlstr = "SELECT Count(LocName) FROM [webx_location] where LocName='" + cityname + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    public static bool IsValidCity(string cityname)
    {
        string sqlstr = "SELECT COUNT(location) FROM webx_citymaster where location='" + cityname + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    public static bool IsValidCityRouteCode(string RouteCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE RUTCD='" + RouteCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    public static bool IsValidTripRouteCode(string RouteCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_trip_rutmas WHERE RUTCD='" + RouteCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
}
