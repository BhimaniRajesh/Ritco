using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for VehicleCPKMController
/// </summary>
[Serializable]
public class VehicleCPKMController : Base
{
    public string mVehicleNo { get; set; }
    public VehicleCPKMController()
    {
        mVehicleNo = "";
    }

    public DataTable CheckValidVehicleNo()
    {
        return ExecuteDataTable("Usp_CPKMADDVehicle_ValidVehicle", new SqlParameter[] { new SqlParameter("@VHNO", mVehicleNo)
                                                                                    });
    }
    public List<CPKMVenodorList> GetAllCPKMVendor(string prefix)
    {
        var lstResult = new List<CPKMVenodorList>();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Prefix", prefix);
            lstResult = ExecuteDataTable("Usp_Get_All_Active_CPKM_Vendor", sqlParam).ToList<CPKMVenodorList>();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetAllCPKMVendor");
            throw ex;
        }
        return lstResult;
    }
    public List<AutoCompleteResult> GetAllVehicleList(string prefix)
    {
        var lstResult = new List<AutoCompleteResult>();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Prefix", prefix);
            lstResult = ExecuteDataTable("Usp_Get_All_Vehicle_List", sqlParam).ToList<AutoCompleteResult>();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetAllVehicleList");
            throw ex;
        }
        return lstResult;
    }
    public List<AutoCompleteResult> GetAllFleetCenterList(string prefix)
    {
        var lstResult = new List<AutoCompleteResult>();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Prefix", prefix);
            lstResult = ExecuteDataTable("Usp_Get_Fleet_Center", sqlParam).ToList<AutoCompleteResult>();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetAllFleetCenterList");
            throw ex;
        }
        return lstResult;
    }
    public DataSet InsertVehicleCPKMDetails(List<VehicleCKPM> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[3];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
            sqlParam[2] = new SqlParameter("@Location", SessionUtilities.CurrentBranchCode);
            dsResult = ExecuteDataSet("Usp_VehicleCPKM_Insert", sqlParam, true);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->InsertVehicleCPKMDetails");
            throw ex;
        }
        return dsResult;
    }
    public DataTable GetVehicleCPKMDetails()
    {
        var dtResult = new DataTable();
        try
        {

            dtResult = ExecuteDataTable("Usp_GetVehicleCPKMDetails", null);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetVehicleCPKMDetails");
            throw ex;
        }
        return dtResult;
    }

    public DataTable GetBankDetails()
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Location", SessionUtilities.CurrentBranchCode);
            dtResult = ExecuteDataTable("Usp_BankDetail", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetVehicleCPKMDetails");
            throw ex;
        }
        return dtResult;
    }

    public DataSet RemoveVehicleFromCPKM(string vehicleNo, string FreezedKMs, string vendorCode)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[4];
            sqlParam[0] = new SqlParameter("@VehicleNo", vehicleNo);
            sqlParam[1] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
            sqlParam[2] = new SqlParameter("@FreezeKMs", FreezedKMs);
            sqlParam[3] = new SqlParameter("@VendorCode", vendorCode);
            dsResult = ExecuteDataSet("Usp_Remove_Vehicle_From_CPKM", sqlParam, true);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->RemoveVehicleFromCPKM");
            throw ex;
        }
        return dsResult;
    }
    public DataTable GetVehicleForRemoveFromCPKM(string vehicleNo, string fleetCenter)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@VehicleNo", vehicleNo);
            sqlParam[1] = new SqlParameter("@FleetLocation", fleetCenter);
            dtResult = ExecuteDataTable("Usp_Get_VehicleCPKMDetail_For_Remove", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "VehicleCPKMController->GetVehicleForRemoveFromCPKM");
            throw ex;
        }
        return dtResult;
    }

}