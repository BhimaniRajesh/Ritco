using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for DriverController
/// </summary>
public class DriverController
{
	public DriverController()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Generate Import Booking Order
    /// </summary>
    /// <param name="objRequest">Import Booking Order Details</param>
    /// <returns></returns>
    public DataTable GenerateDriver_Insert(DriverEntity objRequest)
    {
        
        try
        {            
            DataTable dt = new DataTable();
            using (var oWebXHelper = new WebXHelper())
            {
                dt = oWebXHelper.ExecuteDataTable("USP_FLEET_Driver_INSERT", new[] {
                    new SqlParameter("@XML",XmlUtility.XmlSerializeToString(objRequest)) ,
                   new SqlParameter("@EntryBy",SessionUtilities.CurrentEmployeeID)
                    });
            }

            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /// <summary>
    /// Generate Import Booking Order
    /// </summary>
    /// <param name="objRequest">Import Booking Order Details</param>
    /// <returns></returns>
    public DataTable GenerateDriver_Edit(DriverEntity objRequest)
    {

        try
        {
            DataTable dt = new DataTable();
            using (var oWebXHelper = new WebXHelper())
            {
                dt = oWebXHelper.ExecuteDataTable("USP_FLEET_Driver_Edit", new[] {
                    new SqlParameter("@XML",XmlUtility.XmlSerializeToString(objRequest)) ,
                   new SqlParameter("@EntryBy",SessionUtilities.CurrentEmployeeID)
                    });
            }

            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetStateList()
    {

        try
        {
            DataTable dt = new DataTable();
            using (var oWebXHelper = new WebXHelper())
            {
                dt = oWebXHelper.ExecuteDataTable("USP_Fleet_GetStateList");
            }

            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}