using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for VehicleTollMappingController
/// </summary>
public class VehicleTollMappingController:Base
{
    public VehicleTollMappingController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataTable GetVehicleTollDetails(string VehNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@VehNo", VehNo);
            dtResult = ExecuteDataTable("Usp_GetVehicleTollDetails", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleTollMappingController->GetVehicleFuelDetails");
            throw ex;
        }
        return dtResult;
    }

    public DataTable GetFuelWallet()
    {
        var dtResult = new DataTable();
        try
        {
            dtResult = ExecuteDataTable("USP_Vehicle_FuelMapping_GetFuelWallet");
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleTollMappingController->GetFuelWallet");
            throw ex;
        }
        return dtResult;
    }

    public DataTable GetTollWallet()
    {
        var dtResult = new DataTable();
        try
        {
            dtResult = ExecuteDataTable("USP_Vehicle_FuelMapping_GetTollWallet");
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleTollMappingController->GetFuelWallet");
            throw ex;
        }
        return dtResult;
    }

    public DataSet InsertVehicleTollDetails(List<VehicleToll> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
            dsResult = ExecuteDataSet("Usp_VehicleMapping_TollCard_Insert", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleTollMappingController->InsertVehicleFuelDetails");
            throw ex;
        }
        return dsResult;
    }

    public DataSet GetTollCardMappingView(string VehicleNo)
    {
        DataSet ds = new DataSet();
        try
        {

            ds = ExecuteDataSet("USP_TollCardMapping_GetAllDetails", new SqlParameter[] {
                    new SqlParameter("@VehicleNo", VehicleNo)
                });

        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "VehicleTollMappingController->GetFuelCardMappingView");
        }
        return ds;
    }

    public DataSet UpdateVehicleTollDetails(List<VehicleToll> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@UpdateBy", SessionUtilities.CurrentEmployeeID);
            dsResult = ExecuteDataSet("Usp_VehicleMapping_TollCard_Update", sqlParam, true);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleTollMappingController->InsertVehicleFuelDetails");
            throw ex;
        }
        return dsResult;
    }

    public string CheckVehicleWithTollCard(string VehicleNo,string FuelWallet)
    {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@VehNo", VehicleNo);
            sqlParam[1] = new SqlParameter("@FuelWallet", FuelWallet);
            dtResult = ExecuteDataTable("USP_Vehicle_TollMapping_IsExist",sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleTollMappingController->CheckVehicleWithTollCard");
            throw ex;
        }
        return JsonConvert.SerializeObject(dtResult);
    }   
}
