using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

using WebX.Common;
using System.Data.SqlClient;

/// <summary>
/// Summary description for GeneralMasterUtilities
/// </summary>
public class GeneralMasterUtilities : Base
{
    public GeneralMasterUtilities()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    

    public static DataTable GetGeneralMaster(string strDocumentType)
    {
        var dt = new DataTable();
        using (var oWebXHelper = new WebXHelper())
        {
            dt = oWebXHelper.ExecuteDataTable(CommandType.StoredProcedure, "USP_GetGeneralMasterByCodeType", new SqlParameter[] { new SqlParameter("@CodeType", strDocumentType) });
        }
        return dt;
    }
}
