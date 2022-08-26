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
using WebX.Entity;


/// <summary>
/// Summary description for MRController
/// </summary>
public class ReportCounter
{
    public ReportCounter()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static DataSet InsertReportCounter(string ReportName,string EmpName,string BranchName)
    {
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[3];
       
        param[0] = ControllersHelper.GetSqlParameter("@ReportName", ReportName, SqlDbType.VarChar);
        param[1] = ControllersHelper.GetSqlParameter("@EmpName", EmpName, SqlDbType.VarChar);
        param[2] = ControllersHelper.GetSqlParameter("@BranchName", BranchName, SqlDbType.VarChar);
        try
        {
            ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Webx_InsertReport_Counter", param);
          
        }
              
        catch (Exception ex)
        {
            throw ex;
        }
        return ds;
    }
}
