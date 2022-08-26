using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Common;

/// <summary>
/// Summary description for FixedExpenseController
/// </summary>
public class FixedExpenseController : Base
{
    public FixedExpenseController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataSet InsertUpdateFixedExpenseDetails(List<FixedExpense> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
            dsResult = ExecuteDataSet("Usp_FixedExpense_Insert_Update", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "FixedExpenseController->InsertUpdateFixedExpenseDetails");
            throw ex;
        }
        return dsResult;
    }

    public DataSet GetOptionByFixedExpenseDetails(string Option)
    {
        try
        {
            return ExecuteDataSet("Usp_FixedExpense_GetDetailsByOption", new[]{new SqlParameter("@Option",Option)});
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "FixedExpenseController->GetOptionByFixedExpenseDetails");
            throw ex;
        }
    }

    public DataSet UpdateFixedExpenseDetails(List<FixedExpense> objRequest)
    {
        var dsResult = new DataSet();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[2];
            sqlParam[0] = new SqlParameter("@strXML", XmlUtility.XmlSerializeToString(objRequest));
            sqlParam[1] = new SqlParameter("@UpdateBy", SessionUtilities.CurrentEmployeeID);
            dsResult = ExecuteDataSet("Usp_FixedExpense_Update", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "FixedExpenseController->UpdateFixedExpenseDetails");
            throw ex;
        }
        return dsResult;
    }

    public DataTable GetBranchWiseVehicleDetails(string BranchCode)
    {
        var dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@ControlBranch", BranchCode);
            dtResult = ExecuteDataTable("Usp_FixedExpense_GetVehicleDetails", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "FixedExpenseController->GetBranchWiseVehicleDetails");
            throw ex;
        }
        return dtResult;
    }

    public DataSet GetFixedExpenseAllDetails(string Location, string VehicleNo, string Option)
    {
        DataSet ds = new DataSet();
        try
        {
            ds = ExecuteDataSet("USP_FixedExpense_GetAllDetails", new SqlParameter[] {
                    new SqlParameter("@Location", Location),
                    new SqlParameter("@VehicleNo", VehicleNo),
                    new SqlParameter("@Option", Option)
                });
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetFixedExpenseAllDetails");
        }
        return ds;
    }

    public string CheckOptionIsMapped(string Option)
    {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@Option", Option);
            dtResult = ExecuteDataTable("USP_FixedExpense_Option_IsExist", sqlParam);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "FixedExpenseController->CheckOptionIsMapped");
            throw ex;
        }
        return JsonConvert.SerializeObject(dtResult);
    }
}