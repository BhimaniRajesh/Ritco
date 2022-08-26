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
/// Summary description for CrossingController
/// </summary>
public class CrossingController
{
    public CrossingController()
    {

    }
    public static bool CrossingDetailEntry(Crossing cr, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[17];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@DockNo", cr.DockNo, SqlDbType.VarChar);
            if (cr.DockDate > DateTime.MinValue && cr.DockDate < DateTime.MaxValue)
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@DockDate", cr.DockDate, SqlDbType.DateTime);
            else
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@DockDate", DBNull.Value);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@Origin", cr.Origin, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@Destination", cr.Destination, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@Paybas", cr.Paybas, SqlDbType.VarChar);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@Pkgs", Convert.ToDecimal(cr.Pkgs), SqlDbType.Decimal);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@ActuWeight", Convert.ToDecimal(cr.ActuWeight), SqlDbType.Decimal);
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@DKTTOT", Convert.ToDecimal(cr.DKTTOT), SqlDbType.Decimal);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@Ratetype", cr.Ratetype, SqlDbType.VarChar);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@VendorRate", Convert.ToDecimal(cr.VendorRate), SqlDbType.Decimal);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@CrossingChrg", Convert.ToDecimal(cr.CrossingChrg), SqlDbType.Decimal);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@DoorDelyChrg", Convert.ToDecimal(cr.DoorDelyChrg), SqlDbType.Decimal);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@BulkyChrg", Convert.ToDecimal(cr.BulkyCharge), SqlDbType.Decimal);
            
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@EntryBY", cr.EntryBY, SqlDbType.VarChar);
            if (cr.EntryDate > DateTime.MinValue && cr.EntryDate < DateTime.MaxValue)
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@EntryDate", cr.EntryDate, SqlDbType.DateTime);
            else
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@EntryDate", DBNull.Value);
            paramsToStore[15] = ControllersHelper.GetSqlParameter("@Cancel", cr.Cancel, SqlDbType.VarChar);
            paramsToStore[16] = ControllersHelper.GetSqlParameter("@CrossingChallanNo", cr.CrossingChallanNo, SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "Webx_Crossing_DocketEntry", paramsToStore);

            //string strsql = "UPDATE webx_trans_docket_status SET Delivered='Y',CrossingchallanNo='" + cr.CrossingChallanNo + "' WHERE dockno='" + cr.DockNo + "'";
            string strsql = "UPDATE webx_trans_docket_status SET Delivered='Y',CrossingchallanNo='" + cr.CrossingChallanNo + "',CrossingchallanNoDate=getdate(),dely_date=getdate(),Op_Status=' Delivered @'+Curr_Loc+' On '+CONVERT(VARCHAR,getdate(),106) WHERE dockno='" + cr.DockNo + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);
        }
        catch (Exception excp)
        {
            throw excp;
        }

        return true;
    }

    public static string CrossingMasterEntry(Crossing cr, SqlTransaction trn, string FinYear)
    {
        string strRet = "";
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[17];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@CrossingChallanNo", cr.CrossingChallanNo, SqlDbType.VarChar, 50,ParameterDirection.Output);
            if (cr.ChallanDate > DateTime.MinValue && cr.ChallanDate < DateTime.MaxValue)
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@ChallanDate", cr.ChallanDate, SqlDbType.DateTime);
            else
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@ChallanDate", DBNull.Value);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@ChallanLocCode", cr.ChallanLocCode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@VehicleNo", cr.VehicleNo, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@VendorCode", cr.VendorCode, SqlDbType.VarChar);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@VendorName", cr.VendorName, SqlDbType.VarChar);

            paramsToStore[6] = ControllersHelper.GetSqlParameter("@TotalToPay", Convert.ToDecimal(cr.TotalToPay), SqlDbType.Decimal);
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@TotalCrossing", Convert.ToDecimal(cr.TotalCrossing), SqlDbType.Decimal);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@TotalDoorDelyChrg", Convert.ToDecimal(cr.TotalDoorDelyChrg), SqlDbType.Decimal);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@TotalBulkyChrg", Convert.ToDecimal(cr.TotalBulkyCharge), SqlDbType.Decimal);

            paramsToStore[10] = ControllersHelper.GetSqlParameter("@TruckFreight", Convert.ToDecimal(cr.TotalTruckFreight), SqlDbType.Decimal);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@AdvanceFreight", Convert.ToDecimal(cr.TotalAdvanceFreight), SqlDbType.Decimal);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@BalanceFreight", Convert.ToDecimal(cr.TotalBalance), SqlDbType.Decimal);
           
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@NetPayable", Convert.ToDecimal(cr.NetPayable), SqlDbType.Decimal);

            paramsToStore[14] = ControllersHelper.GetSqlParameter("@Cancel", cr.Cancel, SqlDbType.VarChar);
            paramsToStore[15] = ControllersHelper.GetSqlParameter("@PaymentFlag", cr.PaymentFlag, SqlDbType.VarChar);
            paramsToStore[16] = ControllersHelper.GetSqlParameter("@FinYear", FinYear, SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "Webx_Crossing_ChallanEntry", paramsToStore);
            cr.CrossingChallanNo = paramsToStore[0].Value.ToString();
            strRet = cr.CrossingChallanNo;
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return strRet;
    }
    /*
    public static void CrossingDetailEntry(Crossing cr, SqlTransaction trn)
    {
        string sqlCrossingEntry = "INSERT INTO Webx_Crossing_Docket_Detail(DockNo,DockDate,Origin,Destination,Paybas,Pkgs,ActuWeight,";
        sqlCrossingEntry += "DKTTOT,Ratetype,VendorRate,CrossingChrg,DoorDelyChrg,EntryBY,EntryDate,Cancel,CrossingChallan) VALUES";
        sqlCrossingEntry += "('" + cr.DockNo + "','" + cr.DockDate.ToString("yyyy-MM-dd hh:mm:ss") + "','" + cr.Origin + "','" + cr.Destination + "','" + cr.Paybas + "',";
        sqlCrossingEntry += "" + cr.Pkgs + "," + cr.ActuWeight + "," + cr.DKTTOT + ",'" + cr.Ratetype + "'," + cr.VendorRate + ",";
        sqlCrossingEntry += "" + cr.CrossingChrg + "," + cr.DoorDelyChrg + ",'" + cr.EntryBY + "','" + cr.EntryDate.ToString("yyyy-MM-dd hh:mm:ss") + "','" + cr.Cancel + "','" + cr.CrossingChallanNo + "')";
        SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlCrossingEntry);
    }
    public static void CrossingMasterEntry(Crossing cr, SqlTransaction trn)
    {
        string sqlCrossingEntry = "INSERT INTO Webx_Crossing_Docket_Master(CrossingChallanNo,ChallanDate,ChallanLocCode,VehicleNo,VendorCode,VendorName,TotalToPay,TotalCrossing,TotalDoorDelyChrg,NetPayable,Cancel)";
        sqlCrossingEntry += "VALUES ('" + cr.CrossingChallanNo + "','" + cr.ChallanDate.ToString("yyyy-MM-dd hh:mm:ss") + "','" + cr.ChallanLocCode + "','" + cr.VehicleNo + "','" + cr.VendorCode + "',";
        sqlCrossingEntry += "'" + cr.VendorName + "'," + cr.TotalToPay + "," + cr.TotalCrossing + ",'" + cr.TotalDoorDelyChrg + "'," + cr.NetPayable + ",'" + cr.Cancel + "')";
        SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlCrossingEntry);
    }
    */
}
