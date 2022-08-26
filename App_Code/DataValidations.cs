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
public class DataValidations
{
    public DataValidations()
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
    public static bool IsValidState(string stateName)
    {
        string sqlstr = "SELECT COUNT(stcd) FROM webx_state WHERE stnm='" + stateName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }


    /// <summary>
    /// Checks For Acitve State from State Master
    /// </summary>
    /// <param name="stateName">State Name</param>
    /// <returns></returns>
    public static bool IsActiveState(string stateName)
    {
        string sqlstr = "SELECT COUNT(stcd) FROM webx_state WHERE stnm='" + stateName + "' AND activeflag='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For Active Location from Location Master
    /// </summary>
    /// <param name="loccode">Location Code</param>
    /// <returns></returns>
    public static bool IsActiveLocation(string loccode)
    {
        string sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + loccode + "'";
        sqlstr = sqlstr + " AND activeflag='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For Location from Location Master
    /// </summary>
    /// <param name="loccode">Location Code</param>
    /// <returns></returns>
    public static bool IsValidLocation(string loccode)
    {
        string sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + loccode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }


    /// <summary>
    /// Checks For Active Vehicle Number from webx_VEHICLE_HDR Master
    /// </summary>
    /// <param name="loccode">Location Code</param>
    /// <returns></returns>
    public static bool IsActiveVehicleNumber(string vehno)
    {
        string sqlstr = "SELECT COUNT(vehno) FROM webx_VEHICLE_HDR WHERE vehno='" + vehno + "'";
        sqlstr = sqlstr + " AND activeflag='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Vehicle Number from webx_VEHICLE_HDR Master
    /// </summary>
    /// <param name="loccode">Location Code</param>
    /// <returns></returns>
    public static bool IsValidVehicleNumber(string vehno)
    {
        string sqlstr = "SELECT COUNT(vehno) FROM webx_VEHICLE_HDR WHERE vehno='" + vehno + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For Location from Location Master
    /// </summary>
    /// <param name="loccode">Location Code</param>
    /// <returns></returns>
    public static bool IsComputerizedLocation(string loccode)
    {
        string sqlstr = "SELECT ISNULL(computerised,'N') FROM webx_location WHERE loccode='" + loccode + "' AND activeflag='Y'";
        if (Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)).CompareTo("Y") == 0)
            return true;
        else
            return false;
    }


    /// <summary>
    /// Checks For Vehicle Number from Vehicle Master
    /// </summary>
    /// <param name="loccode">Location Code</param>
    /// <returns></returns>

    /// <summary>
    /// Check for customer from CUSTOMER MASTER
    /// </summary>
    /// <param name="custcode">customer code</param>
    /// <returns>boolean</returns>
    public static bool IsValidCustomer(string custcode)
    {
        string sqlstr = "SELECT COUNT(custcd) FROM webx_custhdr WHERE custcd='" + custcode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active customer from CUSTOMER MASTER
    /// </summary>
    /// <param name="custcode"></param>
    /// <returns></returns>
    public static bool IsActiveCustomer(string custcode)
    {
        string sqlstr = "SELECT COUNT(custcd) FROM webx_custhdr WHERE custcd='" + custcode + "' AND cust_active='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }


    /// <summary>
    /// Checks For EmployeeID from webx_master_users Master
    /// </summary>
    /// <param name="EmpID">Employee Code</param>
    /// <returns></returns>
    public static bool IsValidEmployeeID(string EmpID)
    {
        string sqlstr = "SELECT COUNT(empid) FROM  webx_master_users WHERE EmpID='" + EmpID + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For EmployeeID from webx_master_users Master where it is active or not
    /// </summary>
    /// <param name="EmpID">Employee Code</param>
    /// <returns></returns>
    public static bool IsActiveEmployeeID(string EmpID)
    {
        string sqlstr = "SELECT COUNT(empid) FROM  webx_master_users WHERE Status = '100' and EmpID='" + EmpID + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For UserID from webx_master_users Master
    /// </summary>
    /// <param name="UserID">User Code</param>
    /// <returns></returns>
    public static bool IsValidUserID(string UserID)
    {
        string sqlstr = "SELECT COUNT(empid) FROM  webx_master_users WHERE UserID='" + UserID + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For UserID from webx_master_users Master where it is active or not
    /// </summary>
    /// <param name="UserID">User Code</param>
    /// <returns></returns>
    public static bool IsActiveUserID(string UserID)
    {
        string sqlstr = "SELECT COUNT(empid) FROM  webx_master_users WHERE Status = '100' and UserID='" + UserID + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For Customer code from webx_CUSTHDR Master
    /// </summary>
    /// <param name="CustomerCode">Customer Code</param>
    /// <returns></returns>
    public static bool IsValidCustomerCode(string CustomerCode)
    {
        string sqlstr = "SELECT count(custcd) FROM webx_CUSTHDR WHERE CUSTCd='" + CustomerCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Customer code from webx_CUSTHDR Master where it is active or not
    /// </summary>
    /// <param name="CustomerCode">Customer Code</param>
    /// <returns></returns>
    public static bool IsActiveCustomerCode(string CustomerCode)
    {
        string sqlstr = "SELECT count(custcd) FROM webx_CUSTHDR WHERE CUST_ACTIVE='Y' AND CUSTCd='" + CustomerCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for active customer having given location as customer location
    /// </summary>
    /// <param name="custcode">Customer Code</param>
    /// <param name="loccode">Customer Location</param>
    /// <returns>Boolean</returns>
    public static bool IsActiveCustomer(string custcode, string loccode)
    {
        string sqlstr = "SELECT COUNT(custcd) FROM webx_custhdr";
        sqlstr = sqlstr + " WHERE custcd='" + custcode + "' AND cust_active='Y'";
        sqlstr = sqlstr + " AND PATINDEx ('%" + loccode + "%',custloc)>0";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active Transport Mode from General Master
    /// </summary>
    /// <param name="transmode">Code of Tranport Mode</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveTransMode(string transmode)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='TRN' AND codeid='" + transmode + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks Active Service Type from General Master
    /// </summary>
    /// <param name="servicetype">Code of Service Type</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveServiceType(string servicetype)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='SVCTYP' AND codeid='" + servicetype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active Vehicle Type from General Master
    /// </summary>
    /// <param name="ftltype">Code of FTL Type</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveFTLType(string ftltype)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='FTLTYP' AND codeid='" + ftltype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active Product Type form General Master
    /// </summary>
    /// <param name="prodtype">Code of Product Type</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveProductType(string prodtype)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='PROD' AND codeid='" + prodtype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks for Packaging Type form General Master
    /// </summary>
    /// <param name="packtype"></param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActivePackagingType(string packtype)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='PKGS' AND codeid='" + packtype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active Business Type form General Master
    /// </summary>
    /// <param name="businesstype">Code of Business Type</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveBusinesstype(string businesstype)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='BUT' AND codeid='" + businesstype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }


    /// <summary>
    /// Checks for Active Load Type form General Master
    /// </summary>
    /// <param name="loadtype">Code of Load Type</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveLoadType(string loadtype)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='LOT' AND codeid='" + loadtype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active PickUp Delivery Type form General Master
    /// </summary>
    /// <param name="pickupdel">Code of PickUp Delivery Type</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActivePickUpDelivery(string pickupdel)
    {
        string sqlstr = "SELECT COUNT(codeid) FROM webx_master_general";
        sqlstr = sqlstr + " WHERE statuscode='Y' AND codetype='PKPDL' AND codeid='" + pickupdel + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active City form City Master
    /// </summary>
    /// <param name="cityname">Name of City</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveCity(string cityname)
    {
        string sqlstr = "SELECT COUNT(location) FROM webx_citymaster";
        sqlstr = sqlstr + " WHERE activeflag='Y' AND location='" + cityname + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for Active City Name under given location
    /// </summary>
    /// <param name="cityname">Name of City</param>
    /// <param name="loccode">Code of Location</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveCity(string cityname, string loccode)
    {
        string sqlstr = "SELECT COUNT(location) FROM webx_citymaster";
        sqlstr = sqlstr + " WHERE activeflag='Y' AND location='" + cityname + "' AND book_loc='" + loccode + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for valid City from City Master
    /// </summary>
    /// <param name="cityname">Name of City</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsValidCity(string cityname)
    {
        string sqlstr = "SELECT COUNT(location) FROM webx_citymaster";
        sqlstr = sqlstr + " WHERE location='" + cityname + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }


    /// <summary>
    /// Checks for a docket having an MR
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool HasDocketMR(string dockno)
    {
        string sqlstr = "SELECT COUNT(dockno) FROM webx_mr_hdr";
        sqlstr = sqlstr + " WHERE  mr_cancel='N' AND dockno='" + dockno + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for a docket having an MR, of given Type
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <param name="mrtype">Type Code of MR</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool HasDocketMR(string dockno, string mrtype)
    {
        string sqlstr = "SELECT COUNT(dockno) FROM webx_mr_hdr";
        sqlstr = sqlstr + " WHERE mr_cancel='N' AND mrstype='" + mrtype + "' AND dockno='" + dockno + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for a docket having an MR, of given Type
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <param name="mrtype">Type Code of MR</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool HasDocketBill(string dockno, string billtype)
    {
        string sqlstr = "SELECT COUNT(m.billno) FROM webx_billdet d,webx_billmst m";
        sqlstr = sqlstr + " WHERE m.billno=d.billno AND ISNULL(m.bill_cancel,'N')='N'";
        sqlstr = sqlstr + " AND d.dockno='" + dockno + "' AND paybas='" + billtype + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for an Active MR from MR header
    /// </summary>
    /// <param name="mrno">MR Number</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveMR(string mrno)
    {
        string sqlstr = "SELECT COUNT(dockno) FROM webx_mr_hdr";
        sqlstr = sqlstr + " WHERE  mr_cancel='N' AND mrsno='" + mrno + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Check for an active MR of given type
    /// </summary>
    /// <param name="mrno">MR Number</param>
    /// <param name="mrtype">Type Code of MR</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsActiveMR(string mrno, string mrtype)
    {
        string sqlstr = "SELECT COUNT(dockno) FROM webx_mr_hdr";
        sqlstr = sqlstr + " WHERE  mr_cancel='N' AND mrstype='" + mrtype + "' AND mrsno='" + mrno + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks for MR Finacially Closed having given MR type
    /// </summary>
    /// <param name="mrno">MR Number</param>
    /// <param name="mrtype">Type Code of MR</param>
    /// <returns>Boolean true if Exists</returns>
    public static bool IsMRClosed(string mrno, string mrtype)
    {
        string sqlstr = "SELECT COUNT(dockno) FROM webx_mr_hdr";
        sqlstr = sqlstr + " WHERE  mr_cancel='N' AND mrs_closed='Y' AND mrstype='" + mrtype + "' AND mrsno='" + mrno + "'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks Wether docket is delivered or not
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <returns>Boolean</returns>
    public static bool IsDocketDelivered(string dockno)
    {
        try
        {
            string sqlstr = "SELECT ISNULL(delivered,'N') AS delivered FROM webx_trans_docket_status WHERE dockno='" + dockno + "'";
            string strval = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            if (strval.CompareTo("Y") == 0)
                return true;
            else
                return false;
        }
        catch (Exception excp)
        {
            throw excp;
        }

    }



    /// <summary>
    /// Checks For Vendor code from webx_VENDOR_HDR Master
    /// </summary>
    /// <param name="VendorCode">Vendor Code</param>
    /// <returns></returns>
    public static bool IsValidVendorCode(string VendorCode)
    {
        string sqlstr = "SELECT COUNT(vendorcode) FROM webx_vendor_hdr WHERE vendorcode='" + VendorCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Vendor code from webx_VENDOR_HDR Master where it is active or not
    /// </summary>
    /// <param name="VendorCode">Vendor Code</param>
    /// <returns></returns>
    public static bool IsActiveVendorCode(string VendorCode)
    {
        string sqlstr = "SELECT COUNT(vendorcode) FROM webx_vendor_hdr WHERE Active='Y' AND vendorcode='" + VendorCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }



    #region Route
    /// <summary>
    /// Checks For Route from webx_rutmas Master where it is active or not
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <returns></returns>
    public static bool IsActiveRouteName(string RouteName)
    {
        string sqlstr = "SELET count(*) FROM webx_rutmas WHERE ActiveFlag = 'Y' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Route from webx_rutmas Master where it is valid or not
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <returns></returns>
    public static bool IsValidRouteName(string RouteName)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas WHERE rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Route from webx_rutmas Master where it is active or not by root mode
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <param name="RouteMode">Route Mode</param>
    /// <returns></returns>
    public static bool IsActiveRouteName(string RouteName, string RouteMode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas WHERE ActiveFlag = 'Y' AND rutmod='" + RouteMode + "' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Route from webx_rutmas Master where it is valid or not by root mode
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <param name="RouteMode">Route Mode</param>
    /// <returns></returns>
    public static bool IsValidRouteName(string RouteName, string RouteMode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas WHERE rutmod='" + RouteMode + "' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Route from webx_rutmas Master where it is active or not
    /// </summary>    
    /// <param name="RouteCode">Route Code</param>
    /// <returns></returns>
    public static bool IsActiveRouteCode(string RouteCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas WHERE ActiveFlag = 'Y' AND RUTCD='" + RouteCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Route from webx_rutmas Master where it is valid or not
    /// </summary>
    /// <param name="RouteCode">Route Code</param>
    /// <returns></returns>
    public static bool IsValidRouteCode(string RouteCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas WHERE RUTCD='" + RouteCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    #endregion

    #region City Route
    /// <summary>
    /// Checks For City Route from webx_rutmas_city Master where it is active or not
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <returns></returns>
    public static bool IsActiveCityRouteName(string RouteName)
    {
        string sqlstr = "SELET count(*) FROM webx_rutmas_city WHERE ActiveFlag = 'Y' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For City Route from webx_rutmas_city Master where it is valid or not
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <returns></returns>
    public static bool IsValidCityRouteName(string RouteName)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For City Route from webx_rutmas_city Master where it is active or not by root mode
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <param name="RouteMode">Route Mode</param>
    /// <returns></returns>
    public static bool IsActiveCityRouteName(string RouteName, string RouteMode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE ActiveFlag = 'Y' AND rutmod='" + RouteMode + "' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For City Route from webx_rutmas Master where it is valid or not by root mode
    /// </summary>
    /// <param name="RouteName">Route Name</param>
    /// <param name="RouteMode">Route Mode</param>
    /// <returns></returns>
    public static bool IsValidCityRouteName(string RouteName, string RouteMode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE rutmod='" + RouteMode + "' AND rutnm='" + RouteName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For City Route from webx_rutmas_city Master where it is active or not
    /// </summary>    
    /// <param name="RouteCode">Route Code</param>
    /// <returns></returns>
    public static bool IsActiveCityRouteCode(string RouteCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE ActiveFlag = 'Y' AND RUTCD='" + RouteCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For City Route from webx_rutmas Master where it is valid or not
    /// </summary>
    /// <param name="RouteCode">Route Code</param>
    /// <returns></returns>
    public static bool IsValidCityRouteCode(string RouteCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_rutmas_city WHERE RUTCD='" + RouteCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    #endregion

    #region Customer Group Name
    /// <summary>
    /// Checks For Customer Group Name from webx_GRPMST Master where it is active or not
    /// </summary>
    /// <param name="GroupName">Group Name</param>
    /// <returns></returns>
    public static bool IsActiveCustomerGroupName(string GroupName)
    {
        string sqlstr = "SELECT count(*)  FROM  webx_GRPMST WHERE ActiveFlag = 'Y' AND GRPNM='" + GroupName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Customer Group Name from webx_GRPMST Master where it is valid or not
    /// </summary>
    /// <param name="GroupName">Group Name</param>
    /// <returns></returns>
    public static bool IsValidCustomerGroupName(string GroupName)
    {
        string sqlstr = "SELECT count(*) FROM webx_GRPMST WHERE GRPNM='" + GroupName + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Customer Group Code from webx_GRPMST Master where it is active or not
    /// </summary>
    /// <param name="GroupCode">Group Code</param>
    /// <returns></returns>
    public static bool IsActiveCustomerGroupCode(string GroupCode)
    {
        string sqlstr = "SELECT count(*)  FROM  webx_GRPMST WHERE ActiveFlag = 'Y' AND GRPCD='" + GroupCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Customer Group Code from webx_GRPMST Master where it is valid or not
    /// </summary>
    /// <param name="GroupCode">Group Code</param>
    /// <returns></returns>
    public static bool IsValidCustomerGroupCode(string GroupCode)
    {
        string sqlstr = "SELECT count(*) FROM webx_GRPMST WHERE GRPCD='" + GroupCode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    #endregion

    #region GeneralMaster
    public static bool IsActiveGeneralMaster(string mastercode, string datacode)
    {
        string strsql = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='" + mastercode + "' AND codeid='" + datacode + "'";
        strsql = strsql + " AND statuscode='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql)) == 0)
            return false;
        else
            return true;
    }

    public static bool IsValidGeneralMaster(string mastercode, string datacode)
    {
        string strsql = "SELECT COUNT(codeid) FROM webx_master_general WHERE codetype='" + mastercode + "' AND codeid='" + datacode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql)) == 0)
            return false;
        else
            return true;
    }
    #endregion

    #region Vehicle Type
    /// <summary>
    /// Checks For Active Vehicle Type from webx_Vehicle_Type Master
    /// </summary>
    /// <param name="TypeCode">Type Code</param>
    /// <returns></returns>
    public static bool IsActiveVehicleType(string TypeCode)
    {
        string sqlstr = "SELECT Type_Name as Name,Type_Code  as Code FROM webx_Vehicle_Type WHERE Type_Code='" + TypeCode.Trim() + "'";
        sqlstr = sqlstr + " AND ActiveFlag='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Valid Vehicle Type from webx_Vehicle_Type Master
    /// </summary>
    /// <param name="TypeCode">Type Code</param>
    /// <returns></returns>
    public static bool IsValidVehicleType(string TypeCode)
    {
        string sqlstr = "SELECT Type_Name as Name,Type_Code  as Code FROM webx_Vehicle_Type WHERE Type_Code='" + TypeCode.Trim() + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    #endregion

    #region Pincode
    /// <summary>
    /// Checks For Active Pincode from webx_pincode_master Master
    /// </summary>
    /// <param name="Pincode">Pincode</param>
    /// <returns></returns>
    public static bool IsActivePincode(int Pincode)
    {
        string sqlstr = "SELECT COUNT(*) AS cnt FROM webx_pincode_master WHERE pincode='" + Pincode + "'";
        sqlstr = sqlstr + " AND ActiveFlag='Y'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    /// <summary>
    /// Checks For Valid Pincode from webx_pincode_loc_master Master
    /// </summary> 
    /// <param name="Pincode">Pincode</param>
    /// <returns></returns>
    public static bool IsValidPincodeLoc(int Pincode)
    {
        string sqlstr = "SELECT COUNT(*) AS cnt FROM webx_pincode_loc_master WHERE pincode='" + Pincode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For Valid Pincode from webx_pincode_master Master
    /// </summary> 
    /// <param name="Pincode">Pincode</param>
    /// <returns></returns>
    public static bool IsValidPincode(int Pincode)
    {
        string sqlstr = "SELECT COUNT(*) AS cnt FROM webx_pincode_master WHERE pincode='" + Pincode + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
    #endregion

    /// <summary>
    /// Checks Head Office Active Location from Location Master
    /// </summary>   
    /// <returns></returns>
    public static bool IsHeadOfficeLocation()
    {
        string sqlstr = "SELECT COUNT(Loc_level) FROM webx_location WHERE Loc_level = '1' AND ActiveFlag = 'Y'";

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For EmployeeID from webx_master_users Master
    /// </summary>
    /// <param name="EmpID">Employee Code</param>
    /// <returns></returns>
    public static bool IsValidEmployeeIDOrUserID(string EmpID)
    {
        string sqlstr = "SELECT COUNT(empid) FROM  webx_master_users WHERE EmpID='" + EmpID.Trim() + "' or UserID = '" + EmpID.Trim() + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    // <summary>
    /// Checks For Optimum Route
    /// </summary>
    /// <param name="Origin Location">Origin Location</param>
    /// <param name="Delivery Location">Delivery Location</param>
    /// <param name="Transport Mode">Transport Mode</param>
    /// <returns></returns>
    public static bool IsValidOptimumRoute(string OriginLocation, string DeliveryLocation, string TransportMode)
    {
        string sqlstr = "SELECT COUNT(OptimumRouteCode) FROM  Webx_master_OptimumRouteMaster WHERE OriginLocation='" + OriginLocation.Trim() + "' AND DeliveryLocation = '" + DeliveryLocation.Trim() + "' AND TransportMode = '" + TransportMode.Trim() + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    /// <summary>
    /// Checks For Optimum Route
    /// </summary>
    /// <param name="Origin Location">Origin Location</param>
    /// <param name="Delivery Location">Delivery Location</param>
    /// <param name="Transport Mode">Transport Mode</param>
    /// <returns></returns>
    public static bool IsValidOptimumRoute(string OptimumRouteCode, string OriginLocation, string DeliveryLocation, string TransportMode)
    {
        string sqlstr = "SELECT COUNT(OptimumRouteCode) FROM  Webx_master_OptimumRouteMaster WHERE OriginLocation='" + OriginLocation.Trim() + "' AND DeliveryLocation = '" + DeliveryLocation.Trim() + "' AND TransportMode = '" + TransportMode.Trim() + "' AND OptimumRouteCode != '" + OptimumRouteCode.Trim() + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }

    public static bool IsValidCheque(string chequeno, DateTime chequedate)
    {
        string sqlstr = "SELECT COUNT(chqno) FROM webX_chq_det WHERE chqno='" + chequeno + "' AND chqdt='" + chequedate.ToString("dd MMM yyyy") + "'";
        int cnt = 0;
        try
        {
            cnt = Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        if (cnt == 0)
            return false;
        else
            return true;
    }

    public static bool IsActiveAccount(string acccode)
    {
        string sqlstr = "SELECT COUNT(acccode) FROM webx_acctinfo WHERE acccode='" + acccode + "' AND activeflag='Y'";
        int cnt = 0;
        try
        {
            cnt = Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        if (cnt == 0)
            return false;
        else
            return true;
    }

    public static bool IsActiveAccount(string acccode, string acccategory)
    {
        string sqlstr = "SELECT COUNT(acccode) FROM webx_acctinfo ";
        sqlstr = sqlstr + " WHERE acccode='" + acccode + "' AND acccategory='" + acccategory + "' AND activeflag='Y'";
        int cnt = 0;
        try
        {
            cnt = Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        if (cnt == 0)
            return false;
        else
            return true;
    }

    public static bool IsValidCustAddManualCode(string strManualCode)
    {
        string sqlstr = "SELECT COUNT(AddID) FROM webx_master_CustAddresses ";
        sqlstr = sqlstr + " WHERE AddID='" + strManualCode.Trim() + "'";
        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
	
	public static bool IsValidManualStateCode(string stateCode,string stcd)
    {
        string sqlstr = "";
        if (stcd == "")
        {
            sqlstr = "SELECT COUNT(StateCode) FROM webx_state WHERE StateCode='" + stateCode + "'";
        }
        else {
            sqlstr = "SELECT COUNT(StateCode) FROM webx_state WHERE stcd != '" + stcd + "' AND StateCode='" + stateCode + "'";
        }

        if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
            return false;
        else
            return true;
    }
}
