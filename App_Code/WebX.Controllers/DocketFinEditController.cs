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

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for DocketFinEdit
    /// </summary>
    /// 
    public class DocketFinEditController
    {
        public DocketFinEditController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        /// <summary>
        /// return true if Docket is delivered or DRS is generated
        /// </summary>
        /// <returns>Boolean</returns>
        public static bool CheckDRS(string dockno)
        {
            string sqlstr = "";
            sqlstr = "SELECT COUNT(dockno) FROM webx_trans_docket_status ";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND (drs IS NOT NULL OR delivered='Y')";
            int cnt = Convert.ToInt32(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));

            if (cnt == 0)
                return false;
            else
                return true;
        }

        public static string GetEditDateRule()
        {
            string daterule = "N|";
            try
            {
                DateTime dtfinstart = new DateTime(DocketController.ToInteger(SessionUtilities.FinYear), 4, 1);
                DateTime dtfinend = new DateTime(DocketController.ToInteger(SessionUtilities.FinYear) + 1, 3, 31);
                daterule = "Y|B_T," + dtfinstart.ToString("dd/MM/yyyy") + "|A_T," + dtfinend.ToString("dd/MM/yyyy");
                return daterule;
            }
            catch (Exception ex) { return "N|"; }
        }

        public static DataRow GetFinEditStep1(string dockno)
        {
            string strsql = "SELECT convert(varchar,dockdt,106) as dockdate,convert(varchar,dockdt,103) as ddmmyydockdt,";
            strsql = strsql + " party_code,bacode,paybas,orgncd AS orgnloc,reassign_destcd AS delloc,";
            strsql = strsql + " party_as,stax_exmpt_yn,doctype,insuyn AS risktype,editinfo";
			strsql = strsql + " , GSTState , SACCode , GSTExempted , GSTExemptionCategory , PlaceOfSupply ";
            strsql = strsql + " FROM webx_master_docket a WHERE dockno='" + dockno + "' AND docksf='.'";
            DataRow dtsetp1 = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0].Rows[0];

            return dtsetp1;
        }

        public static DataRow GetFinEditStep2(string dockno)
        {
            string strsql = "SELECT trn_mod AS transmode,service_class AS servicetype,ftl_types AS ftltype,";
            strsql = strsql + "pickup_dely AS pickupdel,from_loc AS fromcity,to_loc AS tocity,pkgsty AS packtype,";
            strsql = strsql + "prodcd AS prodtype,spl_svc_req AS remarks,cft_yn AS flagvolumetric,cod_dod AS flagcoddod,";
            strsql = strsql + "diplomat AS flagoda,localcn_yn AS flaglocal,loadtype,businesstype,dacc_yn AS flagdacc,";
            strsql = strsql + "permit_yn AS flagpermit,multipickup_yn AS flagmultipickup,";
            strsql = strsql + "sourcedockno,multidelivery_yn AS flagmultidelivery";
            strsql = strsql + "";
            strsql = strsql + "";
            strsql = strsql + " FROM webx_master_docket a WHERE dockno='" + dockno + "' AND docksf='.'";
            DataRow dtsetp2 = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0].Rows[0];

            return dtsetp2;
        }

        public static DataRow GetFinEditStep3(string dockno)
        {
            string strsql = "SELECT insuyn AS risktype,chrgwt,actuwt,pkgsno,CSGNCd,CSGNNM,CSGECd,CSGENM";
            strsql = strsql + "";
            strsql = strsql + "";
            strsql = strsql + " FROM webx_master_docket a WHERE dockno='" + dockno + "' AND docksf='.'";
            return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0].Rows[0];

        }

        public static DataTable GetFinEditStep4(string dockno)
        {
            string strsql = "SELECT edd='',billedat='',staxregno='',stax_paidby='',billedat='',* FROM webx_master_docket_charges";
            strsql = strsql + " WHERE dockno='" + dockno + "'";
            DataTable dtcharge = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            strsql = "SELECT CONVERT(VARCHAR,cdeldt,103) AS edd,fincmplbr AS billedat,stax_regno AS staxregno,stax_paidby";
            strsql = strsql + " FROM webx_master_docket WHERE dockno='" + dockno + "' AND docksf='.'";
            DataRow dtrdocket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0].Rows[0];

            dtcharge.Rows[0]["edd"] = dtrdocket["edd"].ToString();
            dtcharge.Rows[0]["billedat"] = dtrdocket["billedat"].ToString();
            dtcharge.Rows[0]["staxregno"] = dtrdocket["staxregno"].ToString();
            dtcharge.Rows[0]["stax_paidby"] = dtrdocket["stax_paidby"].ToString();
            dtcharge.Rows[0]["billedat"] = dtrdocket["billedat"].ToString();
            return dtcharge;
        }

        public static DataTable GetInvoiceTable(string dockno)
        {
            string sqlstr = "SELECT srno,invno,CONVERT(VARCHAR,invdt,103) AS invdt,declval,pkgsno,actuwt,vol_l,vol_b,vol_h,tot_cft FROM webx_master_docket_invoice WHERE dockno='" + dockno + "'";
            return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
        }

        /// <summary>
        /// Checks Whether Booking Year and Delivery Year are Same Financial Year or Not
        /// </summary>
        /// <param name="dockno">Docket Number</param>
        /// <returns>Boolean</returns>
        public static bool IsBookDelyDiff(string dockno)
        {
            int cnt = -1;
            string sqlstr = "SELECT YEAR_DIFF=(CASE WHEN MONTH(ISNULL(dely_date,'01 jan 2006'))>=4 THEN ";
            sqlstr = sqlstr + " YEAR(dely_date) ELSE YEAR(ISNULL(dely_date,'01 jan 2006'))-1 END) - ";
            sqlstr = sqlstr + " (CASE WHEN MONTH(dockdt)>=4 THEN YEAR(dockdt) ELSE YEAR(dockdt)-1 END) ";
            sqlstr = sqlstr + " FROM webx_Trans_docket_status s,webx_master_docket d ";
            sqlstr = sqlstr + " WHERE s.dockno=d.dockno AND d.dockno='" + dockno + "'";
            try
            {
                cnt = Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            { cnt = -1; }

            if (cnt == 0)
                return false;
            else
                return true;
        }

        public static DateTime GetDRSDate(string dockno)
        {
            DateTime dt;
            string sqlstr = "SELECT CONVERT(VARCHAR,dely_date,106) AS deldate FROM webx_trans_docket_status ";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND docksf='.'";
            try
            {
                dt = Convert.ToDateTime(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)));
            }
            catch (Exception ex)
            {
                dt = new DateTime(1900, 1, 1);
            }
            return dt;
        }

        public static DateTime GetDRSDate(string dockno, SqlTransaction trn)
        {
            DateTime dt;
            string sqlstr = "SELECT CONVERT(VARCHAR,dely_date,106) AS deldate FROM webx_trans_docket_status ";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "' AND docksf='.'";
            try
            {
                dt = Convert.ToDateTime(Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.Text, sqlstr)));
            }
            catch (Exception ex)
            {
                dt = new DateTime(1900, 1, 1);
            }
            return dt;
        }

        public static DataTable GetEditComments(string dockno)
        {
            DataTable dt;
            string sqlstr = "SELECT c.dockno,u.name AS entryby,c.entrydate AS editdate,c.comment FROM webx_master_docket_comments c ";
            sqlstr = sqlstr + "INNER JOIN webx_master_users u ON u.userid=c.entryby";
            sqlstr = sqlstr + " WHERE c.dockno='" + dockno + "' ORDER BY c.entrydate DESC";
            try
            {
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        #region DataSavers
        public static void BackUpDocket(string dockno, string employee, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@employee", employee, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_BACKUP_DOCKET", paramsToStore);
            }
            catch (Exception excp)
            {
                throw excp;
            }
        }

        public static void UpdateDocket(Docket dkt, DocketCharges dktcharges, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[39];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dkt.DockNo, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@dockdate", dkt.DockDate, SqlDbType.DateTime);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@paybas", dkt.PayBase, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@partycode", dkt.PartyCode, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@delloc", dkt.DelLoc, SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@transmode", dkt.TransMode, SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@servicetype", dkt.ServiceType, SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@ftltype", dkt.FTLType, SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@fromloc", dkt.FromCity, SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@toloc", dkt.ToCity, SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@businesstype", dkt.BusinessType, SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@loadtype", dkt.LoadType, SqlDbType.VarChar);
                paramsToStore[12] = ControllersHelper.GetSqlParameter("@flagcoddod", dkt.FlagCODDOD, SqlDbType.VarChar);
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@flagdacc", dkt.FlagDACC, SqlDbType.VarChar);
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@flagoda", dkt.FlagODA, SqlDbType.VarChar);
                paramsToStore[15] = ControllersHelper.GetSqlParameter("@flaglocal", dkt.FlagLocal, SqlDbType.VarChar);
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@remarks", dkt.Remarks, SqlDbType.VarChar);
                paramsToStore[17] = ControllersHelper.GetSqlParameter("@risktype", dkt.RiskType, SqlDbType.VarChar);
                paramsToStore[18] = ControllersHelper.GetSqlParameter("@chargedweight", dkt.ChargedWeight, SqlDbType.Decimal);
                paramsToStore[19] = ControllersHelper.GetSqlParameter("@actualweight", dkt.ActualWeight, SqlDbType.Decimal);
                paramsToStore[20] = ControllersHelper.GetSqlParameter("@noofpkgs", dkt.NoOfPkgs);
                paramsToStore[21] = ControllersHelper.GetSqlParameter("@staxpaidby", dkt.STaxPaidBy, SqlDbType.VarChar);
                paramsToStore[22] = ControllersHelper.GetSqlParameter("@codamt", dkt.CODDODAmount, SqlDbType.Decimal);
                paramsToStore[23] = ControllersHelper.GetSqlParameter("@edd", dkt.EDD, SqlDbType.DateTime);
                paramsToStore[24] = ControllersHelper.GetSqlParameter("@billedat", dkt.BilledAt, SqlDbType.VarChar);
                paramsToStore[25] = ControllersHelper.GetSqlParameter("@freightcharge", dktcharges.Freight, SqlDbType.Decimal);
                paramsToStore[26] = ControllersHelper.GetSqlParameter("@subtotal", dktcharges.SubTotal, SqlDbType.Decimal);
                paramsToStore[27] = ControllersHelper.GetSqlParameter("@servicetax", dktcharges.ServiceTax, SqlDbType.Decimal);
                paramsToStore[28] = ControllersHelper.GetSqlParameter("@educess", dktcharges.EduCess, SqlDbType.Decimal);
                paramsToStore[29] = ControllersHelper.GetSqlParameter("@heducess", dktcharges.HEduCess, SqlDbType.Decimal);
                paramsToStore[30] = ControllersHelper.GetSqlParameter("@dockettotal", dktcharges.DocketTotal, SqlDbType.Decimal);
                paramsToStore[31] = ControllersHelper.GetSqlParameter("@edited", "Y", SqlDbType.VarChar);
                paramsToStore[32] = ControllersHelper.GetSqlParameter("@lasteditby", dkt.EntryBy, SqlDbType.VarChar);
                paramsToStore[33] = ControllersHelper.GetSqlParameter("@lasteditdate", dkt.EntryDate, SqlDbType.DateTime);
                paramsToStore[34] = ControllersHelper.GetSqlParameter("@partyas", dkt.PartyAs, SqlDbType.VarChar);
                paramsToStore[35] = ControllersHelper.GetSqlParameter("@flagstaxempt", dkt.FlagStaxExmpt, SqlDbType.VarChar);
                paramsToStore[36] = ControllersHelper.GetSqlParameter("@prodtype", dkt.ProdType, SqlDbType.VarChar);
                paramsToStore[37] = ControllersHelper.GetSqlParameter("@PackType", dkt.PackType, SqlDbType.VarChar);
                paramsToStore[38] = ControllersHelper.GetSqlParameter("@PickUpDel", dkt.PickUpDel, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_DOCKET_UPDATE", paramsToStore);

            }
            catch (Exception excp)
            {
                throw excp;
            }
        }

        public static void UpdateDocketCharges(DocketCharges dktcharges, SqlTransaction trn)
        {
            string sqlstr = "UPDATE webx_master_docket_charges SET ";
            sqlstr = sqlstr + "rate_type='" + dktcharges.RateType + "',";
            sqlstr = sqlstr + "frt_rate=" + dktcharges.FreightRate.ToString() + ",";
            sqlstr = sqlstr + "freight=" + dktcharges.Freight.ToString() + ",";
            string chrgname = "";
            for (int i = 1; i < 24; i++)
            {
                chrgname = "SCHG" + i.ToString().PadLeft(2, '0');
                if (i == 1)
                    sqlstr = sqlstr + chrgname + "=" + dktcharges.Charges[i].ToString();
                else
                    sqlstr = sqlstr + "," + chrgname + "=" + dktcharges.Charges[i].ToString();
            }

            for (int i = 1; i < 11; i++)
            {
                chrgname = "UCHG" + i.ToString().PadLeft(2, '0');
                sqlstr = sqlstr + "," + chrgname + "=" + dktcharges.Charges[23 + i].ToString();
            }

            sqlstr = sqlstr + ",fov=" + dktcharges.Charges[11].ToString() + ",";
            sqlstr = sqlstr + "svctax=" + dktcharges.ServiceTax.ToString() + ",";
			sqlstr = sqlstr + "ServiceTaxRate=" + dktcharges.ServiceTaxRate.ToString() + ",";
            sqlstr = sqlstr + "cess=" + dktcharges.EduCess.ToString() + ",";
            sqlstr = sqlstr + "hedu_cess=" + dktcharges.HEduCess.ToString() + ",";
            sqlstr = sqlstr + "subtotal=" + dktcharges.SubTotal.ToString() + ",";
            sqlstr = sqlstr + "dkttot=" + dktcharges.DocketTotal.ToString() + ",";
            sqlstr = sqlstr + "SbcRate=" + dktcharges.SbcRate.ToString() + ",";
            sqlstr = sqlstr + "SBCess=" + dktcharges.SBCess.ToString() + ",";
            sqlstr = sqlstr + "KKCessRate=" + dktcharges.KKCessRate.ToString() + ",";
            sqlstr = sqlstr + "KKCess=" + dktcharges.KKCess.ToString() + "";
            sqlstr = sqlstr + " WHERE dockno='" + dktcharges.DockNo + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

        }

        public static void UpdateDocketGSTWise(Docket dkt, DocketCharges dktcharges, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[52];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dkt.DockNo, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@dockdate", dkt.DockDate, SqlDbType.DateTime);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@paybas", dkt.PayBase, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@partycode", dkt.PartyCode, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@delloc", dkt.DelLoc, SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@transmode", dkt.TransMode, SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@servicetype", dkt.ServiceType, SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@ftltype", dkt.FTLType, SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@fromloc", dkt.FromCity, SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@toloc", dkt.ToCity, SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@businesstype", dkt.BusinessType, SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@loadtype", dkt.LoadType, SqlDbType.VarChar);
                paramsToStore[12] = ControllersHelper.GetSqlParameter("@flagcoddod", dkt.FlagCODDOD, SqlDbType.VarChar);
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@flagdacc", dkt.FlagDACC, SqlDbType.VarChar);
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@flagoda", dkt.FlagODA, SqlDbType.VarChar);
                paramsToStore[15] = ControllersHelper.GetSqlParameter("@flaglocal", dkt.FlagLocal, SqlDbType.VarChar);
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@remarks", dkt.Remarks, SqlDbType.VarChar);
                paramsToStore[17] = ControllersHelper.GetSqlParameter("@risktype", dkt.RiskType, SqlDbType.VarChar);
                paramsToStore[18] = ControllersHelper.GetSqlParameter("@chargedweight", dkt.ChargedWeight, SqlDbType.Decimal);
                paramsToStore[19] = ControllersHelper.GetSqlParameter("@actualweight", dkt.ActualWeight, SqlDbType.Decimal);
                paramsToStore[20] = ControllersHelper.GetSqlParameter("@noofpkgs", dkt.NoOfPkgs);
                paramsToStore[21] = ControllersHelper.GetSqlParameter("@staxpaidby", dkt.STaxPaidBy, SqlDbType.VarChar);
                paramsToStore[22] = ControllersHelper.GetSqlParameter("@codamt", dkt.CODDODAmount, SqlDbType.Decimal);
                paramsToStore[23] = ControllersHelper.GetSqlParameter("@edd", dkt.EDD, SqlDbType.DateTime);
                paramsToStore[24] = ControllersHelper.GetSqlParameter("@billedat", dkt.BilledAt, SqlDbType.VarChar);
                paramsToStore[25] = ControllersHelper.GetSqlParameter("@freightcharge", dktcharges.Freight, SqlDbType.Decimal);
                paramsToStore[26] = ControllersHelper.GetSqlParameter("@subtotal", dktcharges.SubTotal, SqlDbType.Decimal);
                paramsToStore[27] = ControllersHelper.GetSqlParameter("@servicetax", dktcharges.ServiceTax, SqlDbType.Decimal);
                paramsToStore[28] = ControllersHelper.GetSqlParameter("@educess", dktcharges.EduCess, SqlDbType.Decimal);
                paramsToStore[29] = ControllersHelper.GetSqlParameter("@heducess", dktcharges.HEduCess, SqlDbType.Decimal);
                paramsToStore[30] = ControllersHelper.GetSqlParameter("@dockettotal", dktcharges.DocketTotal, SqlDbType.Decimal);
                paramsToStore[31] = ControllersHelper.GetSqlParameter("@edited", "Y", SqlDbType.VarChar);
                paramsToStore[32] = ControllersHelper.GetSqlParameter("@lasteditby", dkt.EntryBy, SqlDbType.VarChar);
                paramsToStore[33] = ControllersHelper.GetSqlParameter("@lasteditdate", dkt.EntryDate, SqlDbType.DateTime);
                paramsToStore[34] = ControllersHelper.GetSqlParameter("@partyas", dkt.PartyAs, SqlDbType.VarChar);
                paramsToStore[35] = ControllersHelper.GetSqlParameter("@flagstaxempt", dkt.FlagStaxExmpt, SqlDbType.VarChar);
                paramsToStore[36] = ControllersHelper.GetSqlParameter("@prodtype", dkt.ProdType, SqlDbType.VarChar);
                paramsToStore[37] = ControllersHelper.GetSqlParameter("@PackType", dkt.PackType, SqlDbType.VarChar);
                paramsToStore[38] = ControllersHelper.GetSqlParameter("@PickUpDel", dkt.PickUpDel, SqlDbType.VarChar);
                paramsToStore[39] = ControllersHelper.GetSqlParameter("@GSTParty", dkt.GSTParty, SqlDbType.VarChar);
                paramsToStore[40] = ControllersHelper.GetSqlParameter("@GSTState", dkt.GSTState, SqlDbType.VarChar);
                paramsToStore[41] = ControllersHelper.GetSqlParameter("@GSTIN", dkt.GSTIN, SqlDbType.VarChar);
                paramsToStore[42] = ControllersHelper.GetSqlParameter("@SACCategory", dkt.SACCategory, SqlDbType.VarChar);
                paramsToStore[43] = ControllersHelper.GetSqlParameter("@GSTServiceType", dkt.GSTServiceType, SqlDbType.VarChar);
                paramsToStore[44] = ControllersHelper.GetSqlParameter("@ISRCMApplicable", dkt.ISRCMApplicable, SqlDbType.VarChar);
                paramsToStore[45] = ControllersHelper.GetSqlParameter("@IsGSTPartyRegistered", dkt.IsGSTPartyRegistered, SqlDbType.VarChar);
                paramsToStore[46] = ControllersHelper.GetSqlParameter("@IsGStDocumentScan", dkt.IsGStDocumentScan, SqlDbType.VarChar);
                paramsToStore[47] = ControllersHelper.GetSqlParameter("@GSTRemark", dkt.GSTRemark, SqlDbType.VarChar);
				paramsToStore[48] = ControllersHelper.GetSqlParameter("@SACCode", dkt.SACCode, SqlDbType.VarChar);
				paramsToStore[49] = ControllersHelper.GetSqlParameter("@GSTExempted", dkt.GSTExempted, SqlDbType.VarChar);
				paramsToStore[50] = ControllersHelper.GetSqlParameter("@GSTExemptionCategory", dkt.GSTExemptionCategory, SqlDbType.VarChar);
				paramsToStore[51] = ControllersHelper.GetSqlParameter("@PlaceOfSupply", dkt.PlaceOfSupply, SqlDbType.VarChar);
                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_DOCKET_UPDATE_GSTWise", paramsToStore);

            }
            catch (Exception excp)
            {
                throw excp;
            }
        }

        public static void UpdateDocketChargesGSTWise(DocketCharges dktcharges, SqlTransaction trn)
        {
            string sqlstr = "UPDATE webx_master_docket_charges SET ";
            sqlstr = sqlstr + "rate_type='" + dktcharges.RateType + "',";
            sqlstr = sqlstr + "frt_rate=" + dktcharges.FreightRate.ToString() + ",";
            sqlstr = sqlstr + "freight=" + dktcharges.Freight.ToString() + ",";
            string chrgname = "";
            for (int i = 1; i < 24; i++)
            {
                chrgname = "SCHG" + i.ToString().PadLeft(2, '0');
                if (i == 1)
                    sqlstr = sqlstr + chrgname + "=" + dktcharges.Charges[i].ToString();
                else
                    sqlstr = sqlstr + "," + chrgname + "=" + dktcharges.Charges[i].ToString();
            }

            for (int i = 1; i < 11; i++)
            {
                chrgname = "UCHG" + i.ToString().PadLeft(2, '0');
                sqlstr = sqlstr + "," + chrgname + "=" + dktcharges.Charges[23 + i].ToString();
            }

            sqlstr = sqlstr + ",fov=" + dktcharges.Charges[11].ToString() + ",";
            sqlstr = sqlstr + "svctax=" + dktcharges.ServiceTax.ToString() + ",";
            sqlstr = sqlstr + "ServiceTaxRate=" + dktcharges.ServiceTaxRate.ToString() + ",";
            sqlstr = sqlstr + "cess=" + dktcharges.EduCess.ToString() + ",";
            sqlstr = sqlstr + "hedu_cess=" + dktcharges.HEduCess.ToString() + ",";
            sqlstr = sqlstr + "subtotal=" + dktcharges.SubTotal.ToString() + ",";
            sqlstr = sqlstr + "dkttot=" + dktcharges.DocketTotal.ToString() + ",";
            sqlstr = sqlstr + "SbcRate=" + dktcharges.SbcRate.ToString() + ",";
            sqlstr = sqlstr + "SBCess=" + dktcharges.SBCess.ToString() + ",";
            sqlstr = sqlstr + "KKCessRate=" + dktcharges.KKCessRate.ToString() + ",";
            sqlstr = sqlstr + "KKCess=" + dktcharges.KKCess.ToString() + ",";
            sqlstr = sqlstr + "GSTRate=" + dktcharges.GSTRate.ToString() + ",";
            sqlstr = sqlstr + "GSTAmount=" + dktcharges.GSTAmount.ToString() + ",";
            sqlstr = sqlstr + "GSTCharged=" + dktcharges.GSTCharged.ToString() + "";
            sqlstr = sqlstr + " WHERE dockno='" + dktcharges.DockNo + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

        }


        public static void UpdateDocketInvoice(DocketInvoice[] dktinv, SqlTransaction trn)
        {
            string sqlstr = "DELETE FROM webx_master_docket_invoice WHERE dockno='" + dktinv[0].DockNo + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

            for (int i = 0; i < dktinv.Length; i++)
            {
                DocketController.InvoiceEntry(dktinv[i], trn);
            }
        }

        public static void PaidAccountCancellation(string dockno, string finyear, string employee, SqlTransaction trn)
        {

            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transNo", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docNo", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@entryby1", employee, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@NextVoucherNo", "", SqlDbType.VarChar);

                SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_PAIDMR_CANCEL_TRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void TBBAccountCancellation(string dockno, string finyear, string employee, SqlTransaction trn)
        {

            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transNo", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docNo", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@entryby1", employee, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@NextVoucherNo", "", SqlDbType.VarChar);

                SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_TBB_CANCEL_TRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void ToPayAccountCancellation(string dockno, string finyear, string employee, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[6];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transNo", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docNo", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@docsf", ".", SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@entryby1", employee, SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@NextVoucherNo", "", SqlDbType.VarChar);

                SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_TOPAYMR_CANCEL_TRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void DocketAccountCancellation(string dockno, string finperiod, SqlTransaction trn)
        {
            try
            {
                string sqlstr = "UPDATE webx_acctrans_" + finperiod + " SET Voucher_Cancel='Y' WHERE docno='" + dockno + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
            }
            catch (Exception ex) { throw ex; }
        }

        public static void DocketAccountReversal(string dockno, string finyear4d, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transno", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docno", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear4d, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Acc_Instance", "01", SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@Entry_Cancel", "C", SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_DOCKET_TRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void BillCancellation(string dockno, string billtype, string comment, string employee, SqlTransaction trn)
        {
            string sqlstr = "UPDATE webx_billmst SET bill_cancel='Y',billstatus='BILL CANCELLED',";
            sqlstr = sqlstr + " bcanempcd='" + employee + "',bcandt=GETDATE(),cancomment='" + comment + "'";
            sqlstr = sqlstr + " FROM webx_billmst m,webx_billdet d ";
            sqlstr = sqlstr + " WHERE m.billno=d.billno AND d.dockno='" + dockno + "'";
            sqlstr = sqlstr + " AND paybas='" + billtype + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

            sqlstr = "UPDATE webx_trans_docket_status SET billed='N' WHERE dockno='" + dockno + "' AND docksf='.'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
        }

        public static void BillUpdation(string dockno, string editby, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@editby", editby, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_PAIDTOPAY_BILL_UPDATE", paramsToStore);
            }
            catch (Exception excp)
            {
                throw excp;
            }
        }

        public static bool CheckDocketEditEligible(string dockno, string finyear)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", dockno, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);

                if (Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_DOCKET_EDIT_ELIGIBLE", paramsToStore)).CompareTo("Y") == 0)
                    return true;
                else
                    return false;
            }
            catch (Exception excp)
            {
                throw excp;
            }
        }

        #endregion

    }
}
