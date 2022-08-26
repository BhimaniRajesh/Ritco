using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for VehicleFuelMappingController
/// </summary>
public class VehicleFuelMappingController : Base
{
    public VehicleFuelMappingController()
    {
      
    }

    public DataTable GetVehicleFuelDetails(string VehNo)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@VehNo", VehNo);
            dtResult = ExecuteDataTable("Usp_GetVehicleFuelDetails", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleFuelMappingController->GetVehicleFuelDetails");
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
            ExceptionUtility.LogException(ex, "VehicleFuelMappingController->GetFuelWallet");
            throw ex;
        }
        return dtResult;
    }

    public DataSet InsertVehicleFuelDetails(List<VehicleFuel> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
            dsResult = ExecuteDataSet("Usp_VehicleMapping_FuelCard_Insert", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleFuelMappingController->InsertVehicleFuelDetails");
            throw ex;
        }
        return dsResult;
    }

    public DataSet GetFuelCardMappingView(string VehicleNo)
    {
        DataSet ds = new DataSet();
        try
        {

            ds = ExecuteDataSet("USP_FuelCardMapping_GetAllDetails", new SqlParameter[] {
                    new SqlParameter("@VehicleNo", VehicleNo)
                });

        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetFuelCardMappingView");
        }
        return ds;
    }

    public DataSet UpdateVehicleFuelDetails(List<VehicleFuel> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@UpdateBy", SessionUtilities.CurrentEmployeeID);
            dsResult = ExecuteDataSet("Usp_VehicleMapping_FuelCard_Update", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleFuelMappingController->InsertVehicleFuelDetails");
            throw ex;
        }
        return dsResult;
    }

}


