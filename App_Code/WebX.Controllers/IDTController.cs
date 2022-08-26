using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebX.Controllers;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

/// <summary>
/// Summary description for IDTController
/// </summary>
public class IDTController
{
    public IDTController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void IDTAccountEntry(string idtno, DateTime transdate, string entryby, string finyear, string accinstance, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[6];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@idtno", idtno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@transdate", transdate, SqlDbType.DateTime);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@entryby", entryby, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@acc_instance", accinstance, SqlDbType.VarChar);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@entrymode", "E");

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_IDT_TRANSACTION", paramsToStore);
        }
        catch (Exception excp)
        {
            throw excp;
        }

    }

    public static void IDTAccountCancellation()
    {

    }

}
