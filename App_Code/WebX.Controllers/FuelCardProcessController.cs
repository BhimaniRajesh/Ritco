using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;
using System.Globalization;
using System.Runtime.Serialization;

/// <summary>
/// Summary description for HCLMasterController
/// </summary>
public class FuelCardProcessController : Base
{
    public FuelCardProcessController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public List<AutoCompleteResult> GetTripSheetNoList(string prefixText)
    {
        return ExecuteDataTable("Usp_AutoComplate_GetTripSheetNoList", new SqlParameter[]
        {
                    new SqlParameter("@SearchText", prefixText)}).ToList<AutoCompleteResult>();

    }
    public List<AutoCompleteResult> GetCityList(string prefixText)
    {

        return ExecuteDataTable("Usp_AutoComplate_GetCityList", new SqlParameter[]
        {
                    new SqlParameter("@SearchText", prefixText)}).ToList<AutoCompleteResult>();

    }
    public List<AutoCompleteResult> GetVehicleList(string prefixText)
    {

        return ExecuteDataTable("Usp_AutoComplate_GetVehicleList", new SqlParameter[]
        {
                    new SqlParameter("@SearchText", prefixText)}).ToList<AutoCompleteResult>();

    }
    public List<FuelCardProcessData> GetTripSheetDetail(string TripSheetNo,string VehicleNo)
    {
        return ExecuteDataTable("Usp_TripSheet_GetTripSheetDetail", new SqlParameter[]
        {
                    new SqlParameter("@TripSheetNo", TripSheetNo),new SqlParameter("@VehicleNo",VehicleNo)}).ToList<FuelCardProcessData>();

    }

    public DataTable InsertFuelCardProcessDetail(FuelCardProcessData objFuelCardProcessData)
    {

        var obj = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dtResult = new DataTable();
        obj.BeginTransaction();
        try
        {
            SqlParameter[] prm = new SqlParameter[12];
            prm[0] = new SqlParameter("@VehicleNo", objFuelCardProcessData.VehicleNo);
            prm[1] = new SqlParameter("@TripSheetNo", objFuelCardProcessData.TripSheetNo);
            prm[2] = new SqlParameter("@FuelCardNo", objFuelCardProcessData.FuelCardNo);
            prm[3] = new SqlParameter("@FuelType", objFuelCardProcessData.FuelType);
            prm[4] = new SqlParameter("@SwappingDate", DateTime.ParseExact(objFuelCardProcessData.SwappingDate, "dd MMM yyyy", CultureInfo.InvariantCulture));

            prm[5] = new SqlParameter("@City", objFuelCardProcessData.City);
            prm[6] = new SqlParameter("@QTY", objFuelCardProcessData.QTY);
            prm[7] = new SqlParameter("@Rate", objFuelCardProcessData.Rate);
            prm[8] = new SqlParameter("@Amount", objFuelCardProcessData.Amount);

            prm[9] = new SqlParameter("@TransactionId", objFuelCardProcessData.TransactionId);
            prm[10] = new SqlParameter("@Remarks", objFuelCardProcessData.Remarks);
            prm[11] = new SqlParameter("@EntryBy", objFuelCardProcessData.EntryBy);



            DataSet dsResult = obj.ExecuteDataSet(CommandType.StoredProcedure, "Usp_FuelCardProcess_InsertFuelCardProcessDetail", prm);

            dtResult = dsResult.Tables[0];

            obj.CommitTransaction();
        }
        catch (Exception ex)
        {
            obj.RollBackTransaction();
            throw new Exception(ex.Message);
        }
        finally
        {
            obj.Dispose();
        }
        return dtResult;
    }
	 public DataTable InsertFuelCardProcessDetailV1(List<FuelCardProcessData> objFuelCardProcessData)
    {

        var obj = new WebXHelper(SessionUtilities.ConnectionString);
        DataTable dtResult = new DataTable();
        obj.BeginTransaction();
        try
        {
            
             SqlParameter[] prm = new SqlParameter[4];
            prm[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objFuelCardProcessData));
			prm[1] = new SqlParameter("@BRCD", SessionUtilities.CurrentBranchCode);
			prm[2] = new SqlParameter("@Finyear", SessionUtilities.FinYear);
			prm[3] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
            DataSet dsResult = obj.ExecuteDataSet(CommandType.StoredProcedure, "Usp_FuelCardProcess_InsertFuelCardProcessDetailV1", prm);

            dtResult = dsResult.Tables[0];

            obj.CommitTransaction();
        }
        catch (Exception ex)
        {
            obj.RollBackTransaction();
            throw new Exception(ex.Message);
        }
        finally
        {
            obj.Dispose();
        }
        return dtResult;
    }

  /*  public bool CheckFuelCardAlreadyAdded(string TripSheetNo, string VehicleNo)
    {
       DataTable dt= ExecuteDataTable("Usp_FuelCardProcess_CheckFuelCardAlreadyAdded", new SqlParameter[]
        {
                    new SqlParameter("@TripSheetNo", TripSheetNo), new SqlParameter("@VehicleNo", VehicleNo)});
        if (dt.Rows.Count > 0)
        {
            if (Convert.ToInt32(dt.Rows[0][0].ToString()) > 0)
            {
                return true;
            }
            else
            {

                return false;
            }
        }
        else {
            return true;
        }
    }
*/

}