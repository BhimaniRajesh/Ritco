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
using WebX.Entity;

/// <summary>
/// Summary description for ChargeMasterController
/// </summary>
public class ChargeMasterController
{
    public ChargeMasterController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string GetChargeSubRule(string chargetype, string chargerule, string basecode)
    {

        string sqlstr = "SELECT ISNULL(chargesubrule,'NONE') FROM WEBX_CHARGE_BASE ";
        sqlstr = sqlstr + "WHERE chargetype='" + chargetype + "' AND chargerule='" + chargerule + "' AND basecode='" + basecode + "'";
        string subrule = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        if (subrule.CompareTo("") == 0)
            subrule = "NONE";
        return subrule;
    }

    public static string GetChargeName(string chargetype, string chargecode, string chargerule, string basecode,string chargeinstance)
    {
        string sqlstr = "SELECT chargename FROM webx_master_charge ";
        sqlstr = sqlstr + " WHERE chargetype='" + chargetype + "' AND chargecode='" + chargecode + "' AND basedon='" + chargerule + "'";
        sqlstr = sqlstr + " AND basecode='" + basecode + "'";
        if(chargeinstance.CompareTo("BKG")==0)
            sqlstr = sqlstr + " AND booktimeflag='Y'";
        else if(chargeinstance.CompareTo("DEL")==0)
            sqlstr = sqlstr + " AND deltimeflag='Y'";
        string chargename = "";
        try
        {
            chargename = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return chargename;
    }
}
