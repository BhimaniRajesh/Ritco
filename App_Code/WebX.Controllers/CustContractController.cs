using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

/// <summary>
/// Summary description for CustContractController
/// </summary>
public class CustContractController
{
    public CustContractController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void CopyContract(string oldcontractid, string newcontractid, string newcustcode, string newcontracttype, DateTime dtstart, DateTime dtend, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[6];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@oldcontractid", oldcontractid, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@newcontractid", newcontractid, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@newcustcode", newcustcode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@newcontracttype", newcontracttype, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@startdate", dtstart.ToString("dd MMM yyyy"), SqlDbType.VarChar);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@enddate", dtend.ToString("dd MMM yyyy"), SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_COPY_CONTRACT", paramsToStore);

        }
        catch (Exception excp)
        {
            throw excp;
        }


    }
}
