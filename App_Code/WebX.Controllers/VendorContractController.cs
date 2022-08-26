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
using WebX.Controllers;
using WebX.Entity;
using Microsoft.ApplicationBlocks.Data;

/// <summary>
/// Summary description for VendorContractController
/// </summary>
public class VendorContractController
{
    public VendorContractController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static bool InsertRoadRouteChargeCityBased(VendorContractCharges vcc, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[18];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@vendorcode", vcc.VendorCode, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@contractid", vcc.ContractID, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@matrixcode", vcc.MatrixCode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@vehicletype", vcc.VehicleType, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@routecode", vcc.RouteCode, SqlDbType.VarChar);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@slabfrom", vcc.SlabFrom, SqlDbType.Decimal);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@slabto", vcc.SlabTo, SqlDbType.Decimal);
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@slabvalue", vcc.SlabValue, SqlDbType.Decimal);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@slabrate", vcc.SlabRate, SqlDbType.Decimal);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@chargebasis", vcc.ChargeBasis, SqlDbType.VarChar);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@chargetype", vcc.ChargeType, SqlDbType.VarChar);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@docname", vcc.DocumentName, SqlDbType.VarChar);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@fixed_yn", vcc.Fixed_YN, SqlDbType.VarChar);
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@rate_yn", vcc.Rate_YN, SqlDbType.VarChar);
            paramsToStore[14] = ControllersHelper.GetSqlParameter("@minvalue", vcc.MinValue, SqlDbType.Decimal);
            paramsToStore[15] = ControllersHelper.GetSqlParameter("@maxvalue", vcc.MaxValue, SqlDbType.Decimal);
            paramsToStore[16] = ControllersHelper.GetSqlParameter("@callmethod", vcc.CallMethod, SqlDbType.VarChar);
            paramsToStore[17] = ControllersHelper.GetSqlParameter("@veh_ftl", vcc.Veh_FTL, SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_insert_vendor_routerate_citybased", paramsToStore);

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return true;
    }
}
