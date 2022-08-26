using Microsoft.ApplicationBlocks.Data;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebX.Entity;
/// <summary>
/// Summary description for BillMRController
/// </summary>
public class BillMRController :Base
{
    public BillMRController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    
    public string GetClaimDetails(string claimno)
        {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@claimno", claimno);
            dtResult = ExecuteDataTable("Usp_GetClaimDetails", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return jsonUtility.DataTableToJSON(dtResult);
    }
	public string GetClaimNo(string BillNo)
    {
        DataTable dtResult = new DataTable();
        try
        {
            SqlParameter[] sqlParam = new SqlParameter[1];
            sqlParam[0] = new SqlParameter("@BillNo", BillNo);
            dtResult = ExecuteDataTable("USP_MaterialClaim_GetClaimNoFormBillNo", sqlParam);
        }
        catch (Exception)
        {
            throw;
        }
        return jsonUtility.DataTableToJSON(dtResult);
    }
}