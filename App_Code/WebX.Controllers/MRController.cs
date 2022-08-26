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
public class MRController
{
    public MRController()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static bool MREntry(MR mr, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[40];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@mrno", mr.MRNo, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@mrsf", mr.MRSF, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@mrbr", mr.MRBr, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@mrtype", mr.MRType, SqlDbType.VarChar);
            if (mr.MRDate > DateTime.MinValue && mr.MRDate < DateTime.MaxValue)
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@mrdate", mr.MRDate, SqlDbType.DateTime);
            else
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@mrdate", DBNull.Value);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@dockno", mr.DockNo, SqlDbType.VarChar);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@docksf", mr.DockSF, SqlDbType.VarChar);
            if (mr.DockDate > DateTime.MinValue && mr.DockDate < DateTime.MaxValue)
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@dockdate", mr.DockDate, SqlDbType.DateTime);
            else
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@dockdate", DBNull.Value);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@orgnloc", mr.OrgnLoc, SqlDbType.VarChar);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@delloc", mr.DelLoc, SqlDbType.VarChar);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@paybas", mr.PayBas, SqlDbType.VarChar);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@ptcd", mr.PartyCode, SqlDbType.VarChar);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@ptname", mr.PartyName, SqlDbType.VarChar);
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@ptpincode", mr.PartyPinCode, SqlDbType.VarChar);
            paramsToStore[14] = ControllersHelper.GetSqlParameter("@ptphone", mr.PartyPhone, SqlDbType.VarChar);
            paramsToStore[15] = ControllersHelper.GetSqlParameter("@ptaddr", mr.PartyAddress, SqlDbType.VarChar);
            if (mr.EDD > DateTime.MinValue && mr.EDD < DateTime.MaxValue)
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@edd", mr.EDD, SqlDbType.DateTime);
            else
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@edd", DBNull.Value);
            paramsToStore[17] = ControllersHelper.GetSqlParameter("@bacode", mr.BACode, SqlDbType.VarChar);
            paramsToStore[18] = ControllersHelper.GetSqlParameter("@noofpkgs", Convert.ToDecimal(mr.NoOfPkgs), SqlDbType.Decimal);
            paramsToStore[19] = ControllersHelper.GetSqlParameter("@chargedweight", Convert.ToDecimal(mr.ChargedWeight), SqlDbType.Decimal);
            paramsToStore[20] = ControllersHelper.GetSqlParameter("@freight", Convert.ToDecimal(mr.Freight), SqlDbType.Decimal);
            paramsToStore[21] = ControllersHelper.GetSqlParameter("@octamount", Convert.ToDecimal(mr.OctroiAmount), SqlDbType.Decimal);
            paramsToStore[22] = ControllersHelper.GetSqlParameter("@octprocesscharge", Convert.ToDecimal(mr.OctroiProcessCharge), SqlDbType.Decimal);
            paramsToStore[23] = ControllersHelper.GetSqlParameter("@servicetax", Convert.ToDecimal(mr.ServiceTax), SqlDbType.Decimal);
            paramsToStore[24] = ControllersHelper.GetSqlParameter("@educess", Convert.ToDecimal(mr.EduCess), SqlDbType.Decimal);
            paramsToStore[25] = ControllersHelper.GetSqlParameter("@heducess", Convert.ToDecimal(mr.HEduCess), SqlDbType.Decimal);
            paramsToStore[26] = ControllersHelper.GetSqlParameter("@mramount", Convert.ToDecimal(mr.MRAmount), SqlDbType.Decimal);
            paramsToStore[27] = ControllersHelper.GetSqlParameter("@staxrate", Convert.ToDecimal(mr.STaxRate), SqlDbType.Decimal);
            paramsToStore[28] = ControllersHelper.GetSqlParameter("@cessrate", Convert.ToDecimal(mr.EduCessRate), SqlDbType.Decimal);
            paramsToStore[29] = ControllersHelper.GetSqlParameter("@hcessrate", Convert.ToDecimal(mr.HEduCessRate), SqlDbType.Decimal);
            paramsToStore[30] = ControllersHelper.GetSqlParameter("@flagmrclose", mr.FlagMRClose, SqlDbType.VarChar);
            paramsToStore[31] = ControllersHelper.GetSqlParameter("@paymode", mr.PayMode, SqlDbType.VarChar);
            paramsToStore[32] = ControllersHelper.GetSqlParameter("@cashamount", Convert.ToDecimal(mr.CashAmount), SqlDbType.Decimal);
            paramsToStore[33] = ControllersHelper.GetSqlParameter("@chequeno", mr.ChequeNo, SqlDbType.VarChar);
            paramsToStore[34] = ControllersHelper.GetSqlParameter("@chequeamount", Convert.ToDecimal(mr.ChequeAmount), SqlDbType.Decimal);
            if (mr.ChequeDate > DateTime.MinValue && mr.ChequeDate < DateTime.MaxValue)
                paramsToStore[35] = ControllersHelper.GetSqlParameter("@chequedate", mr.ChequeDate, SqlDbType.DateTime);
            else
                paramsToStore[35] = ControllersHelper.GetSqlParameter("@chequedate", DBNull.Value);
            paramsToStore[36] = ControllersHelper.GetSqlParameter("@depobankcode", mr.DepositeBankCode, SqlDbType.VarChar);
            paramsToStore[37] = ControllersHelper.GetSqlParameter("@issuebank", mr.IssueBankName, SqlDbType.VarChar);
            paramsToStore[38] = ControllersHelper.GetSqlParameter("@flagrebook", mr.FlagReBook, SqlDbType.VarChar);
            paramsToStore[39] = ControllersHelper.GetSqlParameter("@entryby", mr.EntryBy, SqlDbType.VarChar);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_MR_ENTRY", paramsToStore);

            string strsql = "UPDATE webx_trans_docket_status SET mr='Y' WHERE dockno='" + mr.DockNo + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return true;
    }

    public static bool ChargesDifferenceEntry(MRCharges mrcharges, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[37];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@mrno", mrcharges.MRNo, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@mrsf", mrcharges.MRSF, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@dockno", mrcharges.DockNo, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@freight", mrcharges.Freight, SqlDbType.Decimal);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@SCHG01", mrcharges.Charges[1], SqlDbType.Decimal);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@SCHG02", mrcharges.Charges[2], SqlDbType.Decimal);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@SCHG03", mrcharges.Charges[3], SqlDbType.Decimal);
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@SCHG04", mrcharges.Charges[4], SqlDbType.Decimal);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@SCHG05", mrcharges.Charges[5], SqlDbType.Decimal);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@SCHG06", mrcharges.Charges[6], SqlDbType.Decimal);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@SCHG07", mrcharges.Charges[7], SqlDbType.Decimal);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@SCHG08", mrcharges.Charges[8], SqlDbType.Decimal);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@SCHG09", mrcharges.Charges[9], SqlDbType.Decimal);
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@SCHG10", mrcharges.Charges[10], SqlDbType.Decimal);
            paramsToStore[14] = ControllersHelper.GetSqlParameter("@SCHG11", mrcharges.Charges[11], SqlDbType.Decimal);
            paramsToStore[15] = ControllersHelper.GetSqlParameter("@SCHG12", mrcharges.Charges[12], SqlDbType.Decimal);
            paramsToStore[16] = ControllersHelper.GetSqlParameter("@SCHG13", mrcharges.Charges[13], SqlDbType.Decimal);
            paramsToStore[17] = ControllersHelper.GetSqlParameter("@SCHG14", mrcharges.Charges[14], SqlDbType.Decimal);
            paramsToStore[18] = ControllersHelper.GetSqlParameter("@SCHG15", mrcharges.Charges[15], SqlDbType.Decimal);
            paramsToStore[19] = ControllersHelper.GetSqlParameter("@SCHG16", mrcharges.Charges[16], SqlDbType.Decimal);
            paramsToStore[20] = ControllersHelper.GetSqlParameter("@SCHG17", mrcharges.Charges[17], SqlDbType.Decimal);
            paramsToStore[21] = ControllersHelper.GetSqlParameter("@SCHG18", mrcharges.Charges[18], SqlDbType.Decimal);
            paramsToStore[22] = ControllersHelper.GetSqlParameter("@SCHG19", mrcharges.Charges[19], SqlDbType.Decimal);
            paramsToStore[23] = ControllersHelper.GetSqlParameter("@SCHG20", mrcharges.Charges[20], SqlDbType.Decimal);
            paramsToStore[24] = ControllersHelper.GetSqlParameter("@SCHG21", mrcharges.Charges[21], SqlDbType.Decimal);
            paramsToStore[25] = ControllersHelper.GetSqlParameter("@SCHG22", mrcharges.Charges[22], SqlDbType.Decimal);
            paramsToStore[26] = ControllersHelper.GetSqlParameter("@SCHG23", mrcharges.Charges[23], SqlDbType.Decimal);
            paramsToStore[27] = ControllersHelper.GetSqlParameter("@UCHG01", mrcharges.Charges[24], SqlDbType.Decimal);
            paramsToStore[28] = ControllersHelper.GetSqlParameter("@UCHG02", mrcharges.Charges[25], SqlDbType.Decimal);
            paramsToStore[29] = ControllersHelper.GetSqlParameter("@UCHG03", mrcharges.Charges[26], SqlDbType.Decimal);
            paramsToStore[30] = ControllersHelper.GetSqlParameter("@UCHG04", mrcharges.Charges[27], SqlDbType.Decimal);
            paramsToStore[31] = ControllersHelper.GetSqlParameter("@UCHG05", mrcharges.Charges[28], SqlDbType.Decimal);
            paramsToStore[32] = ControllersHelper.GetSqlParameter("@UCHG06", mrcharges.Charges[29], SqlDbType.Decimal);
            paramsToStore[33] = ControllersHelper.GetSqlParameter("@UCHG07", mrcharges.Charges[30], SqlDbType.Decimal);
            paramsToStore[34] = ControllersHelper.GetSqlParameter("@UCHG08", mrcharges.Charges[31], SqlDbType.Decimal);
            paramsToStore[35] = ControllersHelper.GetSqlParameter("@UCHG09", mrcharges.Charges[32], SqlDbType.Decimal);
            paramsToStore[36] = ControllersHelper.GetSqlParameter("@UCHG10", mrcharges.Charges[33], SqlDbType.Decimal);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_delmr_diff_entry", paramsToStore);

        }
        catch (Exception excp)
        {
            throw excp;
        }


        return true;
    }

    public static bool MRChargesEntry(MRCharges mrcharges, SqlTransaction trn)
    {
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[43];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@mrno", mrcharges.MRNo, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@mrsf", mrcharges.MRSF, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@dockno", mrcharges.DockNo, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@freight", mrcharges.Freight, SqlDbType.Decimal);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@freight_diff", mrcharges.FreightDifference, SqlDbType.Decimal);
            paramsToStore[5] = ControllersHelper.GetSqlParameter("@SCHG01", mrcharges.Charges[1], SqlDbType.Decimal);
            paramsToStore[6] = ControllersHelper.GetSqlParameter("@SCHG02", mrcharges.Charges[2], SqlDbType.Decimal);
            paramsToStore[7] = ControllersHelper.GetSqlParameter("@SCHG03", mrcharges.Charges[3], SqlDbType.Decimal);
            paramsToStore[8] = ControllersHelper.GetSqlParameter("@SCHG04", mrcharges.Charges[4], SqlDbType.Decimal);
            paramsToStore[9] = ControllersHelper.GetSqlParameter("@SCHG05", mrcharges.Charges[5], SqlDbType.Decimal);
            paramsToStore[10] = ControllersHelper.GetSqlParameter("@SCHG06", mrcharges.Charges[6], SqlDbType.Decimal);
            paramsToStore[11] = ControllersHelper.GetSqlParameter("@SCHG07", mrcharges.Charges[7], SqlDbType.Decimal);
            paramsToStore[12] = ControllersHelper.GetSqlParameter("@SCHG08", mrcharges.Charges[8], SqlDbType.Decimal);
            paramsToStore[13] = ControllersHelper.GetSqlParameter("@SCHG09", mrcharges.Charges[9], SqlDbType.Decimal);
            paramsToStore[14] = ControllersHelper.GetSqlParameter("@SCHG10", mrcharges.Charges[10], SqlDbType.Decimal);
            paramsToStore[15] = ControllersHelper.GetSqlParameter("@SCHG11", mrcharges.Charges[11], SqlDbType.Decimal);
            paramsToStore[16] = ControllersHelper.GetSqlParameter("@SCHG12", mrcharges.Charges[12], SqlDbType.Decimal);
            paramsToStore[17] = ControllersHelper.GetSqlParameter("@SCHG13", mrcharges.Charges[13], SqlDbType.Decimal);
            paramsToStore[18] = ControllersHelper.GetSqlParameter("@SCHG14", mrcharges.Charges[14], SqlDbType.Decimal);
            paramsToStore[19] = ControllersHelper.GetSqlParameter("@SCHG15", mrcharges.Charges[15], SqlDbType.Decimal);
            paramsToStore[20] = ControllersHelper.GetSqlParameter("@SCHG16", mrcharges.Charges[16], SqlDbType.Decimal);
            paramsToStore[21] = ControllersHelper.GetSqlParameter("@SCHG17", mrcharges.Charges[17], SqlDbType.Decimal);
            paramsToStore[22] = ControllersHelper.GetSqlParameter("@SCHG18", mrcharges.Charges[18], SqlDbType.Decimal);
            paramsToStore[23] = ControllersHelper.GetSqlParameter("@SCHG19", mrcharges.Charges[19], SqlDbType.Decimal);
            paramsToStore[24] = ControllersHelper.GetSqlParameter("@SCHG20", mrcharges.Charges[20], SqlDbType.Decimal);
            paramsToStore[25] = ControllersHelper.GetSqlParameter("@SCHG21", mrcharges.Charges[21], SqlDbType.Decimal);
            paramsToStore[26] = ControllersHelper.GetSqlParameter("@SCHG22", mrcharges.Charges[22], SqlDbType.Decimal);
            paramsToStore[27] = ControllersHelper.GetSqlParameter("@SCHG23", mrcharges.Charges[23], SqlDbType.Decimal);
            paramsToStore[28] = ControllersHelper.GetSqlParameter("@UCHG01", mrcharges.Charges[24], SqlDbType.Decimal);
            paramsToStore[29] = ControllersHelper.GetSqlParameter("@UCHG02", mrcharges.Charges[25], SqlDbType.Decimal);
            paramsToStore[30] = ControllersHelper.GetSqlParameter("@UCHG03", mrcharges.Charges[26], SqlDbType.Decimal);
            paramsToStore[31] = ControllersHelper.GetSqlParameter("@UCHG04", mrcharges.Charges[27], SqlDbType.Decimal);
            paramsToStore[32] = ControllersHelper.GetSqlParameter("@UCHG05", mrcharges.Charges[28], SqlDbType.Decimal);
            paramsToStore[33] = ControllersHelper.GetSqlParameter("@UCHG06", mrcharges.Charges[29], SqlDbType.Decimal);
            paramsToStore[34] = ControllersHelper.GetSqlParameter("@UCHG07", mrcharges.Charges[30], SqlDbType.Decimal);
            paramsToStore[35] = ControllersHelper.GetSqlParameter("@UCHG08", mrcharges.Charges[31], SqlDbType.Decimal);
            paramsToStore[36] = ControllersHelper.GetSqlParameter("@UCHG09", mrcharges.Charges[32], SqlDbType.Decimal);
            paramsToStore[37] = ControllersHelper.GetSqlParameter("@UCHG10", mrcharges.Charges[33], SqlDbType.Decimal);
            paramsToStore[38] = ControllersHelper.GetSqlParameter("@subtotal", mrcharges.SubTotal, SqlDbType.Decimal);
            paramsToStore[39] = ControllersHelper.GetSqlParameter("@servicetax", mrcharges.ServiceTax, SqlDbType.Decimal);
            paramsToStore[40] = ControllersHelper.GetSqlParameter("@educess", mrcharges.EduCess, SqlDbType.Decimal);
            paramsToStore[41] = ControllersHelper.GetSqlParameter("@heducess", mrcharges.HEduCess, SqlDbType.Decimal);
            paramsToStore[42] = ControllersHelper.GetSqlParameter("@mramount", mrcharges.MRAmount, SqlDbType.Decimal);

            SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_mr_charges_entry", paramsToStore);

        }
        catch (Exception excp)
        {
            throw excp;
        }


        return true;
    }

    public static bool MRFinUpdation(MR mr, SqlTransaction trn)
    {
        try
        {
            string sqlstr = "UPDATE webx_mr_hdr SET ";
            sqlstr = sqlstr + "chrgwt=" + mr.ChargedWeight + ",";
            sqlstr = sqlstr + "dockdt='" + mr.MRDate.ToString("dd MMM yyyy") + "',";
            sqlstr = sqlstr + "mrsamt=CONVERT(NUMERIC(12)," + mr.MRAmount + "),";
            sqlstr = sqlstr + "netamt=" + mr.MRAmount + ",";
            sqlstr = sqlstr + "col_frt=" + mr.Freight + ",";
            sqlstr = sqlstr + "col_stax=" + mr.ServiceTax + ",";
            sqlstr = sqlstr + "col_cess=" + mr.EduCess + ",";
            sqlstr = sqlstr + "col_h_cess=" + mr.HEduCess + ",";
            sqlstr = sqlstr + "svctax_rate=" + mr.STaxRate;
            sqlstr = sqlstr + " WHERE dockno='" + mr.DockNo + "' AND mrstype='" + mr.MRType + "' AND ISNULL(mr_cancel,'N')='N'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return true;
    }

    public static bool SetMRCancelFlag(string dockno, string mrtype, string comment, string canceldate, string cancelemp, SqlTransaction trn)
    {
        try
        {
            string sqlstr = "UPDATE webx_mr_hdr SET ";
            sqlstr = "UPDATE webx_mr_hdr SET mr_cancel='Y',";
            sqlstr = sqlstr + "cancomment='" + comment + "',";
            sqlstr = sqlstr + "bcandt='" + WebXConvert.ToDateTime(canceldate,"en-GB").ToString("dd MMM yyyy") + "',";
            sqlstr = sqlstr + "bcanempcd='" + cancelemp + "'";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND mrstype='" + mrtype + "' AND ISNULL(mr_cancel,'N')='N'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return true;
    }

    public static string GetDeliveryInstance(string businesstype, string servicetype)
    {
        string strsql = "SELECT delyprocesscode FROM webx_deliveryProcessmap";
        strsql = strsql + " WHERE businesstype='" + businesstype + "' AND serviceclass='" + servicetype + "'";
        string delinstance = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        return delinstance;
    }

    /// <summary>
    /// Executes Accounting Transactions
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <param name="entryby">DataEntry Person</param>
    /// <param name="finyear4d">Financial Year 4 digits</param>
    /// <param name="flagentry">Flag for Entry or Cancel</param>
    /// <param name="trn">Sql Transaction</param>
    public static string DelMRAccountTransaction(string dockno,string docksf, string entryby, string finyear4d, SqlTransaction trn)
    {
        string voucherno = "";
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[5];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@docksf", docksf, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@entryby", entryby, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);
            paramsToStore[4] = ControllersHelper.GetSqlParameter("@entry_cancel", "E", SqlDbType.VarChar);

            voucherno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_DELMR_TRANSACTION", paramsToStore));
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return voucherno;
    }

    /// <summary>
    /// Checks whether docket is eligble for Delivery MR 
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <param name="docksf">Docket Suffix</param>
    /// <param name="loccode">Current Location</param>
    /// <param name="finyear4d">Current Financial Year</param>
    public static bool IsDocketEligibleForDelMR(string dockno, string docksf, string loccode, string finyear4d)
    {
        bool flag = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@docksf", docksf, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);

            flag = WebXConvert.ToBoolean(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_DOCKET_DELMR_ELIGIBLE", paramsToStore)));

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return flag;
    }
    public static bool IsDocketEligibleForSeperateDelMR(string dockno, string docksf, string loccode, string finyear4d)
    {
        bool flag = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@docksf", docksf, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);

            flag = WebXConvert.ToBoolean(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_DOCKET_DELMR_ELIGIBLE_TEST", paramsToStore)));

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return flag;
    }
    public static bool IsDocketEligibleForSeperateDelMR(string dockno, string docksf, string loccode, string finyear4d, SqlTransaction trans)
    {
        bool flag = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@docksf", docksf, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);

            flag = WebXConvert.ToBoolean(Convert.ToString(SqlHelper.ExecuteScalar(trans, CommandType.StoredProcedure, "USP_DOCKET_DELMR_ELIGIBLE_CHECK_FOR_Duplication", paramsToStore)));

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return flag;
    }

    /// <summary>
    /// Checks whether docket is eligble for Delivery MR 
    /// </summary>
    /// <param name="dockno">Docket Number</param>
    /// <param name="docksf">Docket Suffix</param>
    /// <param name="loccode">Current Location</param>
    /// <param name="finyear4d">Current Financial Year</param>
    /// <param name="finyear4d">Current Financial Year</param>
    public static bool IsDocketEligibleForDelMR(string dockno, string docksf, string loccode, string finyear4d, SqlTransaction trn)
    {
        bool flag = false;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[4];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@docksf", docksf, SqlDbType.VarChar);
            paramsToStore[2] = ControllersHelper.GetSqlParameter("@loccode", loccode, SqlDbType.VarChar);
            paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.VarChar);

            flag = WebXConvert.ToBoolean(Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_DOCKET_DELMR_ELIGIBLE", paramsToStore)));

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return flag;
    }
    public static DataTable GetMrGatePassLocationDetail(string Dockno, string Docksf)
    {
        DataTable MrDetail;
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[2];

            paramsToStore[0] = ControllersHelper.GetSqlParameter("@Dockno", Dockno, SqlDbType.VarChar);
            paramsToStore[1] = ControllersHelper.GetSqlParameter("@Docksf", Docksf, SqlDbType.VarChar);

            MrDetail = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_MR_GATEPASS_LOCATION_DETAILS", paramsToStore).Tables[0];
        }
        catch (Exception excp)
        {
            throw excp;
        }
        return MrDetail;
    }
}
