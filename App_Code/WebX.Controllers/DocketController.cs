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
using WebX.Entity;
using WebX.Common;
using System.Collections.Generic;
namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for DocketController
    /// </summary>
    public class DocketController
    {
        public DocketController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static DataTable BindMaster(string code, DropDownList ddl)
        {
            DataTable dt = new DataTable();

            string strsql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='{0}' AND statuscode='Y' ORDER BY codedesc";
            strsql = string.Format(strsql, code);
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
            ddl.DataTextField = "codedesc";
            ddl.DataValueField = "codeid";
            ddl.DataSource = dt;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Select", "0"));

            return dt;
        }
        public static void BindDCRBusinessTransMode(DropDownList cmbtransmode, string businesstype)
        {
            string sqlstr = "";
            sqlstr = "SELECT * FROM webx_dcr_business_transmode WHERE businesstype='" + businesstype + "'";
            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            string defaultval = "";
            bool road_yn = false, air_yn = false, train_yn = false, express_yn = false, enabled = false;
            bool _road_yn = false, _air_yn = false, _train_yn = false, _express_yn = false;

            for (int i = 0; i < cmbtransmode.Items.Count; i++)
            {
                if (cmbtransmode.Items[i].Value.CompareTo("1") == 0)
                    _air_yn = true;

                if (cmbtransmode.Items[i].Value.CompareTo("2") == 0)
                    _road_yn = true;

                if (cmbtransmode.Items[i].Value.CompareTo("3") == 0)
                    _train_yn = true;

                if (cmbtransmode.Items[i].Value.CompareTo("4") == 0)
                    _express_yn = true;
            }

            while (dr.Read())
            {
                if (dr["air_yn"].ToString().ToUpper().CompareTo("Y") == 0 && _air_yn)
                {
                    air_yn = true;
                }
                if (dr["road_yn"].ToString().ToUpper().CompareTo("Y") == 0 && _road_yn)
                {
                    road_yn = true;
                }
                if (dr["train_yn"].ToString().ToUpper().CompareTo("Y") == 0 && _train_yn)
                {
                    train_yn = true;
                }

                if (dr["express_yn"].ToString().ToUpper().CompareTo("Y") == 0 && _express_yn)
                {
                    express_yn = true;
                }

                if (dr["enabled"].ToString().ToUpper().CompareTo("Y") == 0)
                {
                    enabled = true;
                }
                defaultval = dr["defaultvalue"].ToString();

            }
            dr.Close();

            DocketController.BindTransMode(air_yn, road_yn, train_yn, express_yn, cmbtransmode);
            cmbtransmode.SelectedValue = defaultval;
            cmbtransmode.Enabled = enabled;
        }
        #region Binders

        public static bool BindTransMode(bool air_yn, bool road_yn, bool rail_yn, bool express_yn, DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("Select", "0"));
            string sqlstr = "SELECT * FROM webx_master_general WHERE codetype='TRN' AND statuscode='Y' ORDER BY codeid";
            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            while (dr.Read())
            {
                if (Convert.ToString(dr["codeid"]).CompareTo("1") == 0)
                {
                    if (air_yn)
                        ddl.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
                }
                if (Convert.ToString(dr["codeid"]).CompareTo("2") == 0)
                {
                    if (road_yn)
                        ddl.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
                }
                if (Convert.ToString(dr["codeid"]).CompareTo("3") == 0)
                {
                    if (rail_yn)
                        ddl.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
                }
                if (Convert.ToString(dr["codeid"]).CompareTo("4") == 0)
                {
                    if (express_yn)
                        ddl.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
                }
            }
            dr.Close();
            return true;
        }

        public static bool BindServiceType(bool sundry_yn, bool ftl_yn, DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("Select", "0"));
            string sqlstr = "SELECT * FROM webx_master_general WHERE codetype='SVCTYP' AND statuscode='Y' ORDER BY codeid";
            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            while (dr.Read())
            {
                if (Convert.ToString(dr["codeid"]).CompareTo("1") == 0)
                {
                    if (sundry_yn)
                        ddl.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
                }
                if (Convert.ToString(dr["codeid"]).CompareTo("2") == 0)
                {
                    if (ftl_yn)
                        ddl.Items.Add(new ListItem(dr["codedesc"].ToString(), dr["codeid"].ToString()));
                }
            }
            dr.Close();
            return true;
        }

        public static bool BindFTLType(string contractid, DropDownList ddl)
        {
            //Filling FTL Types
            string strsql = "";
            string flag_ftlfilter = DocketRules.GetDefaultValue("FLAG_FTL_FILTER");

            strsql = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y'";
            if (contractid.CompareTo("") != 0 && contractid.CompareTo("P018888") != 0 && contractid.CompareTo("P028888") != 0 && contractid.CompareTo("P038888") != 0 && contractid.CompareTo("P048888") != 0 && flag_ftlfilter.CompareTo("Y") == 0)
            {
                strsql = strsql + " AND codeid IN (SELECT ftltype FROM webx_custcontract_frtmatrix_ftlslabhdr ";
                strsql = strsql + " WHERE contractid='" + contractid + "')";
            }
            DataTable dt = new DataTable();
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
            ddl.DataSource = dt;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Select", "0"));
            return true;
        }

        public static bool BindPickUpDel(string pickupdel, DropDownList ddl)
        {
            // PickUp/Delivery Types
            string[] arrdly = new string[4];
            arrdly = pickupdel.Split(',');
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("Select", "0"));
            for (int i = 0; i < arrdly.Length; i++)
            {
                if (arrdly[i].Trim().ToUpper().CompareTo("GG") == 0)
                    ddl.Items.Add(new ListItem("Godown Pickup - Godown Delivery", "1"));
                else if (arrdly[i].Trim().ToUpper().CompareTo("GD") == 0)
                    ddl.Items.Add(new ListItem("Godown Pickup - Door Delivery", "2"));
                else if (arrdly[i].Trim().ToUpper().CompareTo("DG") == 0)
                    ddl.Items.Add(new ListItem("Door Pickup - Godown Delivery", "3"));
                else if (arrdly[i].Trim().ToUpper().CompareTo("DD") == 0)
                    ddl.Items.Add(new ListItem("Door Pickup - Door Delivery", "4"));
            }
            return true;
        }

        /// <summary>
        /// Gets Location Wise Other Charges
        /// </summary>
        /// <param name="_param_othercharge_req">Parameter List</param>
        /// <returns></returns>
        /// 
        public static double GetOtherCharge(string[] _param_othercharge_req)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[15];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@chargecode", _param_othercharge_req[0], SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@chargetype", _param_othercharge_req[1], SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@basedon1", _param_othercharge_req[2], SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@basecode1", _param_othercharge_req[3], SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@basedon2", _param_othercharge_req[4], SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@basecode2", _param_othercharge_req[5], SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@contractid", _param_othercharge_req[6], SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@fromcity", _param_othercharge_req[7], SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@tocity", _param_othercharge_req[8], SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@fromloc", _param_othercharge_req[9], SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@toloc", _param_othercharge_req[10], SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@transmode", _param_othercharge_req[11], SqlDbType.VarChar);
                try
                {
                    paramsToStore[12] = ControllersHelper.GetSqlParameter("@chargedweight", DocketController.ToDouble(_param_othercharge_req[12]), SqlDbType.Decimal);
                }
                catch (Exception ex)
                {
                    paramsToStore[12].Value = 0;
                }
                try
                {
                    paramsToStore[13] = ControllersHelper.GetSqlParameter("@noofpkgs", DocketController.ToDouble(_param_othercharge_req[13]), SqlDbType.Decimal);
                }
                catch (Exception ex)
                {
                    paramsToStore[13].Value = 0;
                }
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@pkgtyp", _param_othercharge_req[14], SqlDbType.VarChar);
                DataTable dt = new DataTable();
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_GET_OTHERCHARGE", paramsToStore).Tables[0];

                return Convert.ToDouble(dt.Rows[0]["charge"].ToString());
            }
            catch (Exception excp)
            {
                return 0;
            }
        }
        /// <summary>
        /// Gets Location Wise Demurrage Charges 
        ///add by dipak on date 15 apr 2015
        /// </summary>
        /// <param name="_param_othercharge_req">Parameter List</param>
        /// <returns></returns>
        /// 
        public static double GetDemurrageCharge(string[] _param_othercharge_req)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[16];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@chargecode", _param_othercharge_req[0], SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@chargetype", _param_othercharge_req[1], SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@basedon1", _param_othercharge_req[2], SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@basecode1", _param_othercharge_req[3], SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@basedon2", _param_othercharge_req[4], SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@basecode2", _param_othercharge_req[5], SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@contractid", _param_othercharge_req[6], SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@fromcity", _param_othercharge_req[7], SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@tocity", _param_othercharge_req[8], SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@fromloc", _param_othercharge_req[9], SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@toloc", _param_othercharge_req[10], SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@transmode", _param_othercharge_req[11], SqlDbType.VarChar);
                try
                {
                    paramsToStore[12] = ControllersHelper.GetSqlParameter("@chargedweight", DocketController.ToDouble(_param_othercharge_req[12]), SqlDbType.Decimal);
                }
                catch (Exception ex)
                {
                    paramsToStore[12].Value = 0;
                }
                try
                {
                    paramsToStore[13] = ControllersHelper.GetSqlParameter("@noofpkgs", DocketController.ToDouble(_param_othercharge_req[13]), SqlDbType.Decimal);
                }
                catch (Exception ex)
                {
                    paramsToStore[13].Value = 0;
                }
                try
                {
                    paramsToStore[14] = ControllersHelper.GetSqlParameter("@noofday", DocketController.ToDouble(_param_othercharge_req[14]), SqlDbType.Decimal);
                }
                catch (Exception ex)
                {
                    paramsToStore[14].Value = 0;
                }
                paramsToStore[15] = ControllersHelper.GetSqlParameter("@ProdType", _param_othercharge_req[15], SqlDbType.VarChar);
                DataTable dt = new DataTable();
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_GET_DemurrageCHARGE", paramsToStore).Tables[0];

                return Convert.ToDouble(dt.Rows[0]["charge"].ToString());
            }
            catch (Exception excp)
            {
                return 0;
            }
        }
        public static DataTable GetChargeTable(string chargerule, string basecode, string paybas)
        {
            string sqlstr = "";
            sqlstr = "SELECT chargecode,chargename,chargevalue=0,operator,enabled,c.activeflag,c.varybyloc ";
            sqlstr = sqlstr + " FROM webx_master_charge c ";
            sqlstr = sqlstr + " LEFT OUTER JOIN webx_rules_docket r ON c.chargecode=SUBSTRING(r.code,len(r.code)-5,len(r.code))";
            sqlstr = sqlstr + " AND r.code LIKE '" + chargerule + "," + basecode + ",%' AND r.paybas='" + paybas + "'";
            sqlstr = sqlstr + " WHERE c.activeflag='Y' AND c.basedon='" + chargerule + "'";
            sqlstr = sqlstr + " AND c.basecode='" + basecode + "' AND c.booktimeflag='Y' AND c.chargetype='DKT'";
            sqlstr = sqlstr + " AND c.chargecode NOT IN('SCHG11','SCHG12','SCHG13')";

            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            DataTable dtcharges = new DataTable();
            dtcharges.Columns.Add("chargecode1", typeof(string));
            dtcharges.Columns.Add("chargename1", typeof(string));
            dtcharges.Columns.Add("chargevalue1", typeof(string));
            dtcharges.Columns.Add("operator1", typeof(string));
            dtcharges.Columns.Add("varybyloc1", typeof(string));
            dtcharges.Columns.Add("enabled1", typeof(string));
            dtcharges.Columns.Add("activeflag1", typeof(string));
            dtcharges.Columns.Add("chargecode2", typeof(string));
            dtcharges.Columns.Add("chargename2", typeof(string));
            dtcharges.Columns.Add("chargevalue2", typeof(string));
            dtcharges.Columns.Add("activeflag2", typeof(string));
            dtcharges.Columns.Add("operator2", typeof(string));
            dtcharges.Columns.Add("varybyloc2", typeof(string));
            dtcharges.Columns.Add("enabled2", typeof(string));
            if (dt.Rows.Count % 2 != 0)
                dt.Rows.Add();

            int rwscnt = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dtcharges.Rows.Add();
                dtcharges.Rows[rwscnt]["chargecode1"] = dt.Rows[i]["chargecode"].ToString();
                dtcharges.Rows[rwscnt]["chargename1"] = dt.Rows[i]["chargename"].ToString();
                dtcharges.Rows[rwscnt]["chargevalue1"] = dt.Rows[i]["chargevalue"].ToString();
                dtcharges.Rows[rwscnt]["activeflag1"] = dt.Rows[i]["activeflag"].ToString();
                dtcharges.Rows[rwscnt]["operator1"] = dt.Rows[i]["operator"].ToString();
                dtcharges.Rows[rwscnt]["varybyloc1"] = dt.Rows[i]["varybyloc"].ToString();
                dtcharges.Rows[rwscnt]["enabled1"] = dt.Rows[i]["enabled"].ToString();
                i++;
                dtcharges.Rows[rwscnt]["chargecode2"] = dt.Rows[i]["chargecode"].ToString();
                dtcharges.Rows[rwscnt]["chargename2"] = dt.Rows[i]["chargename"].ToString();
                dtcharges.Rows[rwscnt]["chargevalue2"] = dt.Rows[i]["chargevalue"].ToString();
                dtcharges.Rows[rwscnt]["activeflag2"] = dt.Rows[i]["activeflag"].ToString();
                dtcharges.Rows[rwscnt]["operator2"] = dt.Rows[i]["operator"].ToString();
                dtcharges.Rows[rwscnt]["varybyloc2"] = dt.Rows[i]["varybyloc"].ToString();
                dtcharges.Rows[rwscnt]["enabled2"] = dt.Rows[i]["enabled"].ToString();
                rwscnt++;
            }

            return dtcharges;
        }

        public static DataTable GetContractFlatOtherCharges(string foundcontract, string chargerule, string basecode1, string subrule, string basecode2, string contractid, DataTable dtcharges)
        {
            string sqlstr = "";
            if (foundcontract.CompareTo("C") == 0 || foundcontract.CompareTo("D") == 0)
            {
                sqlstr = "SELECT * FROM webx_custcontract_charges WHERE contractid='" + contractid + "'";
                sqlstr = sqlstr + " AND basedon1='" + chargerule + "' AND basecode1='" + basecode1 + "'";
                sqlstr = sqlstr + " AND basedon2='" + subrule + "' AND basecode2='" + basecode2 + "'";
                sqlstr = sqlstr + " AND chargetype='BKG'";
            }
            else
            {   // FOC HAS NO CONTRACT NO VALUE SO THEY ARE ZERO
                sqlstr = "SELECT SCHG01=0,SCHG02=0,SCHG03=0,SCHG04=0,SCHG05=0,SCHG06=0,SCHG07=0,SCHG08=0,SCHG09=0,SCHG10=0,";
                sqlstr = sqlstr + "SCHG11=0,SCHG12=0,SCHG13=0,SCHG14=0,SCHG15=0,SCHG16=0,SCHG17=0,SCHG18=0,SCHG19=0,SCHG20=0,";
                sqlstr = sqlstr + "SCHG21=0,SCHG22=0,SCHG23=0,UCHG01=0,UCHG02=0,UCHG03=0,UCHG04=0,UCHG05=0,UCHG06=0,UCHG07=0,";
                sqlstr = sqlstr + "UCHG08=0,UCHG09=0,UCHG10=0";
            }

            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            if (dr.Read())
            {
                for (int i = 0; i < dtcharges.Rows.Count; i++)
                {
                    try
                    {
                        dtcharges.Rows[i]["chargevalue1"] = Convert.ToDouble(Convert.ToString(dr[Convert.ToString(dtcharges.Rows[i]["chargecode1"])])).ToString("F2");
                    }
                    catch (Exception ex) { dtcharges.Rows[i]["chargevalue1"] = "0.00"; }
                    try
                    {
                        dtcharges.Rows[i]["chargevalue2"] = Convert.ToDouble(Convert.ToString(dr[Convert.ToString(dtcharges.Rows[i]["chargecode2"])])).ToString("F2");
                    }
                    catch (Exception ex)
                    {
                        if (i != dtcharges.Rows.Count - 1)
                        {
                            dr.Close();
                            string exmess = ex.Message.ToString().Replace('\n', '_');
                            return null;
                        }
                        else
                        {
                            dtcharges.Rows[i]["chargevalue2"] = "0.00";
                        }
                    }
                }
            } // charges dr
            dr.Close();

            return dtcharges;
        }

        /// <summary>
        /// Gets Document Details for Docket,to be transported from one state to another
        /// </summary>
        /// <param name="fromcity">From City</param>
        /// <param name="tocity">To City</param>
        /// <param name="fromloc">From Branch</param>
        /// <param name="toloc">To Branch</param>
        /// <param name="grv">GridView Control to Bind</param>
        public static void GetDocumentDetails(string fromcity, string tocity, string fromloc, string toloc, GridView grv)
        {

            string strsql = "", fromstate = "", tostate = "";
            if (fromcity.CompareTo("") != 0)
            {
                strsql = "SELECT state FROM webx_citymaster WHERE location='" + fromcity + "' AND activeflag='Y'";
                fromstate = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
            }

            if (fromstate.CompareTo("") == 0)
            {
                strsql = "SELECT locstate FROM webx_location WHERE loccode='" + fromloc + "' AND activeflag='Y'";
                fromstate = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
            }

            if (tocity.CompareTo("") != 0)
            {
                strsql = "SELECT state FROM webx_citymaster WHERE location='" + tocity + "' AND activeflag='Y'";
                tostate = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
            }
            if (tostate.CompareTo("") == 0)
            {
                strsql = "SELECT locstate FROM webx_location WHERE loccode='" + toloc + "' AND activeflag='Y'";
                tostate = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
            }

            strsql = "(SELECT stform,ISNULL(stcstreq,'N') AS stcstreq,stnm,srno as  Doc_srno FROM webx_state WHERE stcd='" + tostate + "' AND inoutbound='I' AND activeflag='Y')";
            strsql = strsql + " UNION (SELECT  stform,ISNULL(stcstreq,'N') AS stcstreq,stnm,srno as  Doc_srno  FROM webx_state WHERE stcd='" + fromstate + "' AND inoutbound='O' AND activeflag='Y')";
            DataTable dt = new DataTable();
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            grv.DataSource = dt;
            grv.DataBind();

        }

        #endregion

        #region Misclinous

        public static string GetChargeSubRule(string chargerule, string basecode)
        {
            string sqlstr = "SELECT ISNULL(chargesubrule,'NONE') FROM webx_charge_base";
            sqlstr = sqlstr + " WHERE chargetype='DKT' AND chargerule='" + chargerule + "'";
            sqlstr = sqlstr + " AND basecode='" + basecode + "'";
            return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }

        public static string GetStaxPayer(string contractid)
        {
            string sqlstr = "SELECT stax_paidby FROM webx_custcontract_hdr";
            sqlstr = sqlstr + " WHERE contractid='" + contractid + "'";
            return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }

        public static double[] GetStaxRateTable()
        {
            double[] staxrate = new double[3];
            string sqlstr = "SELECT TOP 1 servicetax,edu_cess_rate,hedu_cess_rate FROM webx_chargemst";
            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            while (dr.Read())
            {
                staxrate[0] = DocketController.ToDouble(dr["servicetax"].ToString());
                staxrate[1] = DocketController.ToDouble(dr["edu_cess_rate"].ToString());
                staxrate[2] = DocketController.ToDouble(dr["hedu_cess_rate"].ToString());
            }
            dr.Close();
            return staxrate;
        }

        public static bool GetODAFlag(string tocity)
        {
            string sqlstr = "SELECT UPPER(ISNULL(oda_yn,'N')) FROM webx_citymaster WHERE location='" + tocity + "'";
            if (Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)).CompareTo("Y") == 0)
                return true;
            else
                return false;
        }

        public static bool IsBookingLocation(string loccode)
        {
            string sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + loccode + "'";
            sqlstr = sqlstr + " AND activeflag='Y' AND loc_level NOT IN ('1','2')";
            if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
                return false;
            else
                return true;
        }

        public static bool IsDeliveryLocation(string loccode)
        {
            string sqlstr = "SELECT COUNT(loccode) FROM webx_location WHERE loccode='" + loccode + "'";
            sqlstr = sqlstr + " AND activeflag='Y' AND loc_level NOT IN ('1','2')";
            if (Convert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)) == 0)
                return false;
            else
                return true;
        }

        public static void BindComputerisedBusinessType(DropDownList cmbbusinesstype)
        {
            string sqlstr = "";
            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='BUT' AND statuscode='Y'";
            sqlstr = sqlstr + " AND codeid IN (SELECT businesstype FROM webx_dcr_business_transmode WHERE ";
            sqlstr = sqlstr + " computerised='Y')";
            DataTable dt = new DataTable();
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            cmbbusinesstype.DataSource = dt;
            cmbbusinesstype.DataBind();
            cmbbusinesstype.Items.Insert(0, new ListItem("Select", "0"));
        }


        public static string ValidateStep1(string entrytype, string dockno, string bookdate, string paybas, string partycode, string orgnloc, string delloc, string contractsets, string bookdaterule)
        {
            // CHECKING FOR DOCKET NO IN SERIES
            if (entrytype.CompareTo("N") == 0)
            {
                string strvalidate = DocketController.TestAvailbleDockNo(dockno, orgnloc);
                if (strvalidate.CompareTo("TRUE") != 0)
                {
                    return strvalidate;
                }
            }
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            DateTime dtdockbook = Convert.ToDateTime(bookdate, enGB);
            /* Add GST wise Change */
            string IsGSTApplicable = DocketRules.GetEnableValue("GSTEND");
            if (IsGSTApplicable == "Y")
            {
                if (dtdockbook >= DateTime.Parse(DocketRules.GetDefaultValue("GSTEND")))
                {
                    return "Out of Range or Invalid Booking Date";
                }
            }

            // CHECKING FOR DOCKET DATE LIES IN CURRENT FIN YEAR
            if (!IsBookDateAllowed(bookdate, bookdaterule))
            {
                return "Out of Range or Invalid Booking Date";
            }

            if (paybas.CompareTo("") == 0 || paybas.CompareTo("0") == 0)
            {
                return "Payment Basis Type Not Entered Properly";
            }


            string[] arrsets = contractsets.Split(',');
            switch (paybas)
            {
                case "P01":
                    if (arrsets[0].CompareTo("C") == 0)
                    {
                        if (partycode.CompareTo("") == 0)
                        {
                            return "Billing Party Not Entered";
                        }

                        if (!DataValidations.IsActiveCustomer(partycode, orgnloc))
                        {
                            return "Billing Party Not From Customer Master ";
                        }
                    }
                    break;
                case "P02":
                    if (partycode.CompareTo("") == 0)
                    {
                        return "Billing Party Not Entered";
                    }

                    if (!DataValidations.IsActiveCustomer(partycode, orgnloc))
                    {
                        return "Billing Party Not From Cutomer Master ";
                    }
                    break;
                case "P03":
                    if (arrsets[2].CompareTo("C") == 0)
                    {
                        if (partycode.CompareTo("") == 0)
                        {
                            return "Billing Party Not Entered";
                        }

                        if (!DataValidations.IsActiveCustomer(partycode, orgnloc))
                        {
                            return "Billing Party Not From Master ";
                        }
                    }
                    break;
            }

            if (!IsBookingLocation(orgnloc))
            {
                return "Origin Location Not From Location Master ";
            }


            if (!IsDeliveryLocation(delloc))
            {
                return "Delivery Location Not From Location Master ";
            }

            return "TRUE";
        }

		public static string ValidateStep1(string entrytype, string dockno, string bookdate, string paybas, string partycode, string orgnloc, string delloc, string contractsets, string bookdaterule,string entryFrom)
        {
            // CHECKING FOR DOCKET NO IN SERIES
            if (entrytype.CompareTo("N") == 0)
            {
                string strvalidate = DocketController.TestAvailbleDockNo(dockno, orgnloc);
                if (strvalidate.CompareTo("TRUE") != 0)
                {
                    return strvalidate;
                }
            }
			System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
			DateTime dtdockbook = Convert.ToDateTime(bookdate, enGB);
			/* Add GST wise Change */
            string IsGSTApplicable = DocketRules.GetEnableValue("GSTSTART");
            if (IsGSTApplicable == "Y")
            {
                if (entryFrom == "GSTE" || entryFrom == "GSTQC")
                {
                    if (dtdockbook < DateTime.Parse(DocketRules.GetDefaultValue("GSTSTART")))
                    {
                        return "Out of Range or Invalid Booking Date";
                    }
                }
                else
                {
                    if (dtdockbook >= DateTime.Parse(DocketRules.GetDefaultValue("GSTEND")))
                    {
                        return "Out of Range or Invalid Booking Date";
                    }
                }
            }
            /* Add GST wise Change */

            // CHECKING FOR DOCKET DATE LIES IN CURRENT FIN YEAR
            if (!IsBookDateAllowed(bookdate, bookdaterule))
            {
                return "Out of Range or Invalid Booking Date";
            }

            if (paybas.CompareTo("") == 0 || paybas.CompareTo("0") == 0)
            {
                return "Payment Basis Type Not Entered Properly";
            }


            string[] arrsets = contractsets.Split(',');
            switch (paybas)
            {
                case "P01":
                    if (arrsets[0].CompareTo("C") == 0)
                    {
                        if (partycode.CompareTo("") == 0)
                        {
                            return "Billing Party Not Entered";
                        }

                        if (!DataValidations.IsActiveCustomer(partycode, orgnloc))
                        {
                            return "Billing Party Not From Customer Master ";
                        }
                    }
                    break;
                case "P02":
                    if (partycode.CompareTo("") == 0)
                    {
                        return "Billing Party Not Entered";
                    }

                    if (!DataValidations.IsActiveCustomer(partycode, orgnloc))
                    {
                        return "Billing Party Not From Cutomer Master ";
                    }
                    break;
                case "P03":
                    if (arrsets[2].CompareTo("C") == 0)
                    {
                        if (partycode.CompareTo("") == 0)
                        {
                            return "Billing Party Not Entered";
                        }

                        if (!DataValidations.IsActiveCustomer(partycode, orgnloc))
                        {
                            return "Billing Party Not From Master ";
                        }
                    }
                    break;
            }

            if (!IsBookingLocation(orgnloc))
            {
                return "Origin Location Not From Location Master ";
            }


            if (!IsDeliveryLocation(delloc))
            {
                return "Delivery Location Not From Location Master ";
            }

            return "TRUE";
        }

        public static string ValidateStep2(string orgnloc, string delloc, string transmode, string servicetype, string ftltype, string fromcity, string tocity, string pickupdel, string prodtype, string packtype, string businesstype, string loadtype, bool flagmultipickupdel, string sourcedockno)
        {
            string rule_from = "Y", rule_to = "Y";

            if (!DataValidations.IsActiveTransMode(transmode))
            {
                return "Transport Mode not from Master";
            }

            if (!DataValidations.IsActiveServiceType(servicetype))
            {
                return "Service Type not from Master";
            }

            if (servicetype.CompareTo("2") == 0)
            {
                if (!DataValidations.IsActiveFTLType(ftltype))
                {
                    return "FTL Type Not From Master";
                }

                if (tocity.CompareTo("") == 0)
                {
                    return "Please Enter To City as it is FTL " + SessionUtilities.DocketCalledAs;
                }
            }

            if (!DataValidations.IsActivePickUpDelivery(pickupdel))
            {
                return "PickUp Delivery Type Not from Master";
            }

            rule_from = DocketRules.GetDefaultValue("FCITY_MSTR");
            rule_to = DocketRules.GetDefaultValue("TCITY_MSTR");

            if (rule_from.CompareTo("Y") == 0)
            {
                if (fromcity.CompareTo("") != 0)
                {
                    if (!DataValidations.IsActiveCity(fromcity))
                    {
                        return "From City not from City Master";
                    }
                }
            }

            if (rule_to.CompareTo("Y") == 0)
            {
                if (tocity.CompareTo("") != 0)
                {
                    if (!DataValidations.IsActiveCity(tocity))
                    {
                        return "To City not from City Master";
                    }
                }
            }

            if (delloc.CompareTo(orgnloc) == 0)
            {
                if (fromcity.CompareTo("") == 0)
                {
                    return "From City Can't be Blank As Origin=Destination";
                }

                if (tocity.CompareTo("") == 0)
                {
                    return "To City Can't be Blank As Origin=Destination";
                }
            }

            if (tocity.CompareTo(fromcity) == 0 && fromcity.CompareTo("") != 0)
            {
                return "From City and To City Can't be Same";
            }


            if (!DataValidations.IsActivePackagingType(packtype))
            {
                return "Packaging Type not from General Master";
            }

            if (!DataValidations.IsActiveProductType(prodtype))
            {
                return "Product Type not from General Master";
            }


            if (!DataValidations.IsActiveBusinesstype(businesstype))
            {
                return "Business Type not from General Master";
            }

            if (DocketRules.GetDefaultValue("FLAG_LOT").CompareTo("Y") == 0)
            {
                if (!DataValidations.IsActiveLoadType(loadtype))
                {
                    return "Load Type is not from General Master";
                }
            }

            if (flagmultipickupdel == true)
            {
                if (sourcedockno.CompareTo("") == 0)
                {
                    return "Please Entry Source " + SessionUtilities.DocketCalledAs + " No";
                }
            }

            return "TRUE";
        }

        public static string ValidateStep3(bool flagedit, string[] arrcsgn, string[] arrcsge, double chargedweight, double nopkgs, double declaredvalue, GridView grvinvoice)
        {
            if (!flagedit)
            {
                if (arrcsgn[0].CompareTo("") == 0 && arrcsgn[1].CompareTo("") == 0)
                {
                    return "Consignor Code or Name not Found";
                }

                if (arrcsge[0].CompareTo("") == 0 && arrcsge[1].CompareTo("") == 0)
                {
                    return "Consignee Code or Name not Found";
                }

                if (arrcsgn[0].CompareTo("") == 0)
                {
                    if (arrcsgn[2].CompareTo("") == 0)
                    {
                        return "Consignor Address not Found";
                    }

                    if (arrcsgn[3].CompareTo("") == 0)
                    {
                        return "Consignor City not Found";
                    }

                    if (arrcsgn[4].CompareTo("") == 0)
                    {
                        return "Consignor PinCode Not Found";
                    }

                    if (arrcsgn[5].CompareTo("") == 0)
                    {
                        return "Consignor Phone Number Not Found";
                    }
                }

                if (arrcsge[0].CompareTo("") == 0)
                {
                    if (arrcsge[2].CompareTo("") == 0)
                    {
                        return "Consignee Address Not Found";
                    }

                    if (arrcsge[3].CompareTo("") == 0)
                    {
                        return "Consignee City Not Found";
                    }

                    if (arrcsge[4].CompareTo("") == 0)
                    {
                        return "Consignee PinCode Not Found.";
                    }

                    if (arrcsge[5].CompareTo("") == 0)
                    {
                        return "Consignee Phone Number Not Found";
                    }
                }
            }

            if (chargedweight == 0)
            {
                return "Total Charged Weight is zero";
            }

            if (nopkgs == 0)
            {
                return "No of Packages are 0";
            }

            if (declaredvalue < 1)
            {
                return "Total Declared Value is Zero";
            }

            if (grvinvoice.Rows.Count <= 0)
            {
                return "Invoice Entry not Found";
            }


            foreach (GridViewRow grv in grvinvoice.Rows)
            {
                TextBox txtinvoiceno = (TextBox)grv.FindControl("txtinvoiceno");
                TextBox txtinvoicedate = (TextBox)grv.FindControl("txtinvoicedate");
                TextBox txtdeclval = (TextBox)grv.FindControl("txtdeclval");
                TextBox txtnopkgs = (TextBox)grv.FindControl("txtnopkgs");
                TextBox txtactualweight = (TextBox)grv.FindControl("txtactualweight");

                if (txtinvoiceno.Text.CompareTo("") == 0)
                {
                    return "Invoice No not found. Row No." + grv.RowIndex;
                }

                if (txtinvoicedate.Text.CompareTo("") == 0)
                {
                    return "Invoice Date not found. Row No." + grv.RowIndex;
                }

                if (DocketController.ToDouble(txtdeclval.Text) == 0)
                {
                    return "Invoice Declared Value is zero. Row No." + grv.RowIndex;
                }

                if (DocketController.ToDouble(txtnopkgs.Text) == 0)
                {
                    return "Invoice No of Packages are zero. Row No." + grv.RowIndex;
                }

                if (DocketController.ToDouble(txtactualweight.Text) == 0)
                {
                    return "Invoice Actual Weight is zero. Row No." + grv.RowIndex;
                }
            }

            return "TRUE";
        }

        public static string ValidateStep3(bool flagedit, bool flagaddman, string[] arrcsgn, string[] arrcsge, double chargedweight, double nopkgs, double declaredvalue, GridView grvinvoice)
        {
            if (!flagedit)
            {
                if (arrcsgn[0].CompareTo("") == 0 && arrcsgn[1].CompareTo("") == 0)
                {
                    return "Consignor Code or Name not Found";
                }

                if (arrcsge[0].CompareTo("") == 0 && arrcsge[1].CompareTo("") == 0)
                {
                    return "Consignee Code or Name not Found";
                }

                if (flagaddman)
                {
                    if (arrcsgn[0].CompareTo("") == 0)
                    {
                        if (arrcsgn[2].CompareTo("") == 0)
                        {
                            return "Consignor Address not Found";
                        }

                        if (arrcsgn[3].CompareTo("") == 0)
                        {
                            return "Consignor City not Found";
                        }

                        if (arrcsgn[4].CompareTo("") == 0)
                        {
                            return "Consignor PinCode Not Found";
                        }

                        if (arrcsgn[5].CompareTo("") == 0)
                        {
                            return "Consignor Phone Number Not Found";
                        }
                    }


                    if (arrcsge[0].CompareTo("") == 0)
                    {
                        if (arrcsge[2].CompareTo("") == 0)
                        {
                            return "Consignee Address Not Found";
                        }

                        if (arrcsge[3].CompareTo("") == 0)
                        {
                            return "Consignee City Not Found";
                        }

                        if (arrcsge[4].CompareTo("") == 0)
                        {
                            return "Consignee PinCode Not Found.";
                        }

                        if (arrcsge[5].CompareTo("") == 0)
                        {
                            return "Consignee Phone Number Not Found";
                        }
                    }
                }
            }

            if (chargedweight == 0)
            {
                return "Total Charged Weight is zero";
            }

            if (nopkgs == 0)
            {
                return "No of Packages are 0";
            }

            if (declaredvalue < 1)
            {
                return "Total Declared Value is Zero";
            }

            if (grvinvoice.Rows.Count <= 0)
            {
                return "Invoice Entry not Found";
            }


            foreach (GridViewRow grv in grvinvoice.Rows)
            {
                TextBox txtinvoiceno = (TextBox)grv.FindControl("txtinvoiceno");
                TextBox txtinvoicedate = (TextBox)grv.FindControl("txtinvoicedate");
                TextBox txtdeclval = (TextBox)grv.FindControl("txtdeclval");
                TextBox txtnopkgs = (TextBox)grv.FindControl("txtnopkgs");
                TextBox txtactualweight = (TextBox)grv.FindControl("txtactualweight");

                if (txtinvoiceno.Text.CompareTo("") == 0)
                {
                    return "Invoice No not found. Row No." + grv.RowIndex;
                }

                if (txtinvoicedate.Text.CompareTo("") == 0)
                {
                    return "Invoice Date not found. Row No." + grv.RowIndex;
                }

                if (DocketController.ToDouble(txtdeclval.Text) == 0)
                {
                    return "Invoice Declared Value is zero. Row No." + grv.RowIndex;
                }

                if (DocketController.ToDouble(txtnopkgs.Text) == 0)
                {
                    return "Invoice No of Packages are zero. Row No." + grv.RowIndex;
                }

                if (DocketController.ToDouble(txtactualweight.Text) == 0)
                {
                    return "Invoice Actual Weight is zero. Row No." + grv.RowIndex;
                }
            }

            return "TRUE";
        }

        /// <summary>
        /// Checks Docket Date against Booking Date Rule
        /// </summary>
        /// <param name="strdockbook">Docket Date</param>
        /// <param name="daterule">Booking Date Rule String</param>
        /// <returns></returns>
        public static bool IsBookDateAllowed(string strdockbook, string daterule)
        {
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            DateTime dtdockbook = Convert.ToDateTime(strdockbook, enGB);

            string[] arrtmp = new string[3];
            string[] arrblwrule = new string[2];
            string[] arrabvrule = new string[2];
            try
            {
                arrtmp = daterule.Split('|');

                if (arrtmp[0].CompareTo("Y") != 0)
                    return false;

                arrblwrule = arrtmp[1].Split(',');
                arrabvrule = arrtmp[2].Split(',');

                DateTime dtblwcompare = Convert.ToDateTime(arrblwrule[1], enGB);
                if (dtdockbook.CompareTo(dtblwcompare) < 0)
                    return false;

                DateTime dtabvcompare = Convert.ToDateTime(arrabvrule[1], enGB);
                if (dtdockbook.CompareTo(dtabvcompare) > 0)
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// Gets the Booking Date Rule String
        /// </summary>
        /// <returns></returns>
        public static string GetBookDateRule()
        {
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");

            string dbdaterule = DocketRules.GetDefaultValue("RANGE_DKTDT");
            string daterule = "N|";
            string[] arrtmp = new string[2];
            string[] arrdaterule = new string[7];
            DateTime dtcompare;
            arrtmp = dbdaterule.Split('|');
            arrdaterule = arrtmp[0].Split(',');
            DateTime dtfinstart = new DateTime(DocketController.ToInteger(SessionUtilities.FinYear), 4, 1);
            DateTime dtfinend = new DateTime(DocketController.ToInteger(SessionUtilities.FinYear) + 1, 3, 31);

            // [0]=Y MEANS RULE FOR DATE APPLIES
            if (arrdaterule[0].CompareTo("Y") == 0)
            {
                daterule = "Y|";
                if (arrdaterule[1].CompareTo("B_D") == 0)
                {
                    int days = DocketController.ToInteger(arrdaterule[3]);
                    dtcompare = Convert.ToDateTime(DataProvider.GetServerDate(), enGB);
                    dtcompare = dtcompare.AddDays(0 - days);
                    daterule = daterule + arrdaterule[1] + "," + dtcompare.ToString("dd/MM/yyyy");

                }
                else if (arrdaterule[1].CompareTo("B_T") == 0)
                {
                    dtcompare = Convert.ToDateTime(arrdaterule[5], enGB);
                    daterule = daterule + arrdaterule[1] + "," + dtcompare.ToString("dd/MM/yyyy");
                }
                else
                {
                    daterule = "N|";
                }


                daterule = daterule + "|";
                // [2] MEANS WHICH RULE FOR ABOVE DATE
                if (arrdaterule[2].CompareTo("A_D") == 0)
                {
                    int days = DocketController.ToInteger(arrdaterule[4]);
                    dtcompare = Convert.ToDateTime(DataProvider.GetServerDate(), enGB);
                    dtcompare = dtcompare.AddDays(days);
                    daterule = daterule + arrdaterule[2] + "," + dtcompare.ToString("dd/MM/yyyy");
                }
                else if (arrdaterule[2].CompareTo("A_T") == 0)
                {
                    dtcompare = Convert.ToDateTime(arrdaterule[6], enGB);
                    daterule = daterule + arrdaterule[2] + "," + dtcompare.ToString("dd/MM/yyyy");
                }
                else
                {
                    daterule = "N|";
                }

            }

            return daterule;
        }

        public static int GetTRDaysTransitZoneMaster(string orgnloc, string delloc, string transmode)
        {
            string strfromzone = "", strtozone = "";
            int trdays = 0;

            string sqlstr = "SELECT locregion FROM webx_location WHERE loccode='" + orgnloc + "'";
            strfromzone = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));

            sqlstr = "SELECT locregion FROM webx_location WHERE loccode='" + delloc + "'";
            strtozone = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));

            sqlstr = "SELECT TOP 1 * FROM webx_trms_zone WHERE trorgn_zone='" + strfromzone + "' AND trdest_zone='" + strtozone + "'";
            SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            if (dr.Read())
            {
                try
                {
                    if (transmode.CompareTo("1") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays_air"]);
                    }
                    else if (transmode.CompareTo("2") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays"]);
                    }
                    else if (transmode.CompareTo("3") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays_rail"]);
                    }
                    else if (transmode.CompareTo("4") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays_exp"]);
                    }
                }
                catch (Exception ex) { }
            }
            dr.Close();

            return trdays;

        } // IF RECORD NOT FOUND THEN FROM ZONE MASTER}

        public static int GetTRDaysTransitMaster(string orgnloc, string delloc, string transmode)
        {
            string sqlstr = "";
            SqlDataReader dr;
            int trdays = 0;
            sqlstr = "SELECT TOP 1 * FROM webx_trms WHERE trorgn='" + orgnloc + "' AND trdest='" + delloc + "'";
            dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            if (dr.Read())
            {
                try
                {
                    if (transmode.CompareTo("1") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays_air"]);
                    }
                    else if (transmode.CompareTo("2") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays"]);
                    }
                    else if (transmode.CompareTo("3") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays_rail"]);
                    }
                    else if (transmode.CompareTo("4") == 0)
                    {
                        trdays = Convert.ToInt16(dr["trdays_exp"]);
                    }
                }
                catch (Exception ex) { }
            }
            dr.Close();

            return trdays;
        }

        public static void SetExternalBusinessType(string doctype, string dockno, DropDownList cmbtransmode, DropDownList cmbbusinesstype)
        {
            string dcr_business = "N", dcr_transmode = "N";
            dcr_business = DocketRules.GetDefaultValue("DCR_BUSINESS");
            dcr_transmode = DocketRules.GetDefaultValue("DCR_TRANSMODE");
            if (doctype.CompareTo("DKT") == 0)
            {
                DocketController.BindMaster("BUT", cmbbusinesstype);
                if (dcr_business.CompareTo("Y") == 0)
                {
                    DocketController.SelectDCRBusinessType(dockno, cmbbusinesstype);
                }

                if (dcr_business.CompareTo("Y") == 0 && dcr_transmode.CompareTo("Y") == 0)
                {
                    DocketController.BindDCRBusinessTransMode(cmbtransmode, cmbbusinesstype.SelectedValue);
                }
            }
            else if (doctype.CompareTo("CMP") == 0)
            {
                DocketController.BindComputerisedBusinessType(cmbbusinesstype);
            }
        }

        public static void SelectDCRBusinessType(string dockno, DropDownList cmbbusinesstype)
        {
            string sqlstr = "";
            sqlstr = "SELECT business_type_id FROM webx_dcr_header WHERE '" + dockno + "' BETWEEN doc_sr_from AND doc_sr_to";
            sqlstr = sqlstr + " AND LEN('" + dockno + "')=LEN(doc_sr_from)";
            string businesstype = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            try
            {
                cmbbusinesstype.SelectedValue = businesstype;
                if (cmbbusinesstype.SelectedValue.CompareTo("") == 0 || cmbbusinesstype.SelectedValue.CompareTo("0") == 0)
                    cmbbusinesstype.Enabled = true;
                else
                    cmbbusinesstype.Enabled = false;
            }
            catch (Exception ex)
            {
                cmbbusinesstype.Enabled = true;
            }
        }

        public static ContractServices GetContractServices(string contractid)
        {
            ContractServices cser = new ContractServices();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];

                paramsToStore[0] = new SqlParameter("@contractid", SqlDbType.VarChar);
                paramsToStore[0].Value = contractid;
                paramsToStore[0].Size = 30;

                SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_GET_CONTRACT_FLAGS", paramsToStore);

                if (dr.Read())
                {
                    cser.FlagFound = Convert.ToString(dr["FLAG_REC"]).CompareTo("Y") == 0 ? true : false;
                    if (cser.FlagFound == true)
                    {
                        cser.FlagAir = Convert.ToString(dr["FLAG_AIR"]).CompareTo("Y") == 0 ? true : false;
                        cser.FlagRoad = Convert.ToString(dr["FLAG_ROAD"]).CompareTo("Y") == 0 ? true : false;
                        cser.FlagTrain = Convert.ToString(dr["FLAG_TRAIN"]).CompareTo("Y") == 0 ? true : false;
                        cser.FlagExpress = Convert.ToString(dr["FLAG_EXPRESS"]).CompareTo("Y") == 0 ? true : false;

                        cser.FlagSundry = Convert.ToString(dr["FLAG_SUNDRY"]).CompareTo("Y") == 0 ? true : false;
                        cser.FlagFTL = Convert.ToString(dr["FLAG_FTL"]).CompareTo("Y") == 0 ? true : false;

                        cser.FlagVolumetric = Convert.ToString(dr["FLAG_VOLUMETRIC"]).CompareTo("Y") == 0 ? true : false;
                        cser.FlagCODDODEnable = Convert.ToString(dr["FLAG_CODDOD"]).CompareTo("Y") == 0 ? true : false;
                        cser.FlagDACCEnable = Convert.ToString(dr["FLAG_DACC"]).CompareTo("Y") == 0 ? true : false;

                        cser.PickUpDel = Convert.ToString(dr["PICKUP_DEL"]);

                        cser.FOVType = Convert.ToString(dr["FOVTYPE"]);
                        cser.RiskType = Convert.ToString(dr["RISKTYPE"]);
                        cser.VolMeasureType = Convert.ToString(dr["CFTMEASURE"]);
                        cser.CFT2KG = ToDouble(Convert.ToString(dr["CFT2KG"]));
                        cser.FOVCarrierRate = ToDouble(Convert.ToString(dr["CARRIERRISK_RATE"]));
                        cser.FOVOwnerRate = ToDouble(Convert.ToString(dr["OWNERRISK_RATE"]));
                        cser.FOVCharge = ToDouble(Convert.ToString(dr["FOVCHARGE"]));
                        cser.CODDODCharged = ToDouble(Convert.ToString(dr["CODDODCHARGE"]));
                        cser.DACCCharged = ToDouble(Convert.ToString(dr["DACCCHARGE"]));
                        cser.BillingLoc = Convert.ToString(dr["BILLINGLOC"]);
                    }
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return cser;
        }

        public static string TestAvailbleDockNo(string dockno, string orgnloc)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@DocketNo", SqlDbType.VarChar);
            param[0].Value = dockno;
            param[0].Size = 20;

            param[1] = new SqlParameter("@LocCode", SqlDbType.VarChar);
            param[1].Value = orgnloc;
            param[1].Size = 20;

            string flag = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "usp_validate_docket_entry", param));
            if (flag.CompareTo("") == 0)
            {
                return "ErrorPage.aspx?heading=Free " + SessionUtilities.DocketCalledAs + " Check Rejected.&detail1=Step 1 Validation&detail2=&suggestion1=Docket Entry Module";
            }

            if (flag.CompareTo("0") == 0)
            {
                return "ErrorPage.aspx?heading=" + SessionUtilities.DocketCalledAs + " is not in Series&detail1=Rejection from " + SessionUtilities.DocketCalledAs + " No validation&detail2=&suggestion1=Docket Entry Module";
            }
            else
            {
                try
                {
                    string strserial = "N";
                    strserial = DocketRules.GetDefaultValue("DCR_SERIAL");
                    if (strserial.CompareTo("Y") == 0)
                    {
                        param = new SqlParameter[1];
                        param[0] = new SqlParameter("@dockno", SqlDbType.VarChar);
                        param[0].Value = dockno;
                        param[0].Size = 20;

                        string forceflag = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "sp_forced_serial", param));
                        if (forceflag.ToUpper().CompareTo("N") == 0)
                        {
                            return "ErrorPage.aspx?heading=" + SessionUtilities.DocketCalledAs + " Number is not Serial Wise&detail1=Step 1 Validation&detail2=&suggestion1=Docket Entry Module";
                        }
                    }


                    string strflagvoid = DocketRules.GetDefaultValue("FLAG_VOID");
                    if (strflagvoid.CompareTo("Y") == 0)
                    {
                        string strsql = "SELECT docno FROM webx_document_void WHERE doc_type='DOCKET' AND docno='" + dockno + "'";
                        string strvoid = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));

                        if (strvoid.ToUpper().CompareTo("") != 0)
                        {
                            return "ErrorPage.aspx?heading=" + SessionUtilities.DocketCalledAs + " is Void. Can not Enter " + SessionUtilities.DocketCalledAs + "&detail1=Step 1 Validation&detail2=&suggestion1=Docket Entry Module";
                        }
                    }
                    return "TRUE";
                }
                catch (Exception ex)
                {
                    return "ErrorPage.aspx?heading=Session Expired or DB problem&detail1=Session TimeOut Occured in " + SessionUtilities.DocketCalledAs + "&detail2=" + ex.Message.Replace('\n', '_') + "&suggestion1=Docket Entry Module";

                }

            }
            return "TRUE";
        }

        public static string GetContractID(string partycode, string paybas, string dockdate)
        {
            string sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE contract_type='" + paybas + "'";
            sqlstr = sqlstr + " AND custcode='" + partycode + "'";
            sqlstr = sqlstr + " AND activeflag='Y' AND '" + dockdate + "' BETWEEN contract_effectdate AND contract_eddate";

            try
            {
                return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                return "";
            }
        }

        public static string GetBACode(string dockno)
        {
            string sqlstr = "SELECT TOP 1 assignto AS bacode FROM vw_dcr_series_new ";
            sqlstr = sqlstr + " WHERE assignto NOT IN (SELECT loccode FROM webx_location)";
            sqlstr = sqlstr + "AND ( assignto IN (SELECT userid FROM webx_master_users )";
            sqlstr = sqlstr + " OR assignto IN (SELECT vendorcode FROM webx_vendor_hdr WHERE vendor_type='08' ))";
            sqlstr = sqlstr + " AND '" + dockno + "' BETWEEN series_from AND series_to";
            sqlstr = sqlstr + " AND LEN(RTRIM(LTRIM('" + dockno + "'))) = LEN(series_from)";
            return Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
        }

        /// <summary>
        /// Get Consignor Information like code,name,address,etc from docket.
        /// </summary>
        /// <param name="csgncd">Consignor Code</param>
        /// <returns>DataTable</returns>
        public static DataRow GetCSGNInfo(string dockno)
        {
            DataTable dt;
            string sqlstr = "SELECT csgncd,csgnnm,csgnaddr,csgncity,csgnpincode,csgnteleno,csgnemail FROM webx_master_docket";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "'";
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            if (dt.Rows[0]["csgncd"].ToString().CompareTo("") == 0 || dt.Rows[0]["csgncd"].ToString().CompareTo("8888") == 0)
                return dt.Rows[0];
            else
            {
                sqlstr = "SELECT custcd AS csgncd,custnm AS csgnnm,custaddress AS csgnaddr,city AS csgncity,";
                sqlstr = sqlstr + " pincode AS csgnpincode,telno AS csgnteleno,emailids AS csgnemail";
                sqlstr = sqlstr + " FROM webx_custhdr";
                sqlstr = sqlstr + " WHERE custcd='" + dt.Rows[0]["csgncd"].ToString() + "'";
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
                return dt.Rows[0];
            }
        }


        /// <summary>
        /// Get Consignee Information like code,name,address,etc from docket.
        /// </summary>
        /// <param name="csgnecd">Consignee Code</param>
        /// <returns>DataTable</returns>
        public static DataRow GetCSGEInfo(string dockno)
        {
            DataTable dt;
            string sqlstr = "SELECT csgecd,csgenm,csgeaddr,csgecity,csgepincode,csgeteleno,csgeemail FROM webx_master_docket";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "'";
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            if (dt.Rows[0]["csgecd"].ToString().CompareTo("") == 0 || dt.Rows[0]["csgecd"].ToString().CompareTo("8888") == 0)
                return dt.Rows[0];
            else
            {
                sqlstr = "SELECT custcd AS csgecd,custnm AS csgenm,custaddress AS csgeaddr,city AS csgecity,";
                sqlstr = sqlstr + " pincode AS csgepincode,telno AS csgeteleno,emailids AS csgeemail";
                sqlstr = sqlstr + " FROM webx_custhdr";
                sqlstr = sqlstr + " WHERE custcd='" + dt.Rows[0]["csgecd"].ToString() + "'";
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
                return dt.Rows[0];
            }
        }

        /// <summary>
        /// Get Consignor Information like code,name,address,etc from docket.
        /// </summary>
        /// <param name="csgncd">Consignor Code</param>
        /// <returns>DataTable</returns>
        public static DataRow GetCSGNInfo(string dockno, SqlTransaction trn)
        {
            DataTable dt;
            string sqlstr = "SELECT csgncd,csgnnm,csgnaddr,csgncity,csgnpincode,csgnteleno,csgnemail FROM webx_master_docket";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "'";
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            if (dt.Rows[0]["csgncd"].ToString().CompareTo("") == 0 || dt.Rows[0]["csgncd"].ToString().CompareTo("8888") == 0)
                return dt.Rows[0];
            else
            {
                sqlstr = "SELECT custcd AS csgncd,custnm AS csgnnm,custaddress AS csgnaddr,city AS csgncity,";
                sqlstr = sqlstr + " pincode AS csgnpincode,telno AS csgnteleno,emailids AS csgnemail";
                sqlstr = sqlstr + " FROM webx_master_docket";
                sqlstr = sqlstr + " WHERE dockno='" + dt.Rows[0]["csgncd"].ToString() + "'";
                dt = SqlHelper.ExecuteDataset(trn, CommandType.Text, sqlstr).Tables[0];
                return dt.Rows[0];
            }
        }


        /// <summary>
        /// Get Consignee Information like code,name,address,etc from docket.
        /// </summary>
        /// <param name="csgnecd">Consignee Code</param>
        /// <returns>DataTable</returns>
        public static DataRow GetCSGEInfo(string dockno, SqlTransaction trn)
        {
            DataTable dt;
            string sqlstr = "SELECT csgecd,csgenm,csgeaddr,csgecity,csgepincode,csgeteleno,csgeemail FROM webx_master_docket";
            sqlstr = sqlstr + " WHERE dockno='" + dockno + "'";
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

            if (dt.Rows[0]["csgecd"].ToString().CompareTo("") == 0 || dt.Rows[0]["csgecd"].ToString().CompareTo("8888") == 0)
                return dt.Rows[0];
            else
            {
                sqlstr = "SELECT custcd AS csgecd,custnm AS csgenm,custaddress AS csgeaddr,city AS csgecity,";
                sqlstr = sqlstr + " pincode AS csgepincode,telno AS csgeteleno,emailids AS csgeemail";
                sqlstr = sqlstr + " FROM webx_master_docket";
                sqlstr = sqlstr + " WHERE custcd='" + dt.Rows[0]["csgecd"].ToString() + "'";
                dt = SqlHelper.ExecuteDataset(trn, CommandType.Text, sqlstr).Tables[0];
                return dt.Rows[0];
            }
        }

        public static string GetComputerizedDockNo(string branchcode, SqlTransaction trn)
        {
            string strsql = "";
            strsql = "SELECT ISNULL(locid,'N') FROM webx_location WHERE loccode='" + branchcode + "'";
            string strlocid = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.Text, strsql));

            if (strlocid.CompareTo("") == 0)
            {
                return "";
            }

            strlocid = strlocid.PadLeft(3, '0');

            strsql = "SELECT MAX(SUBSTRING(dockno,3,8)) FROM webx_master_docket WHERE orgncd='" + branchcode + "' AND LEN(dockno)>9";
            string strmax = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.Text, strsql));
            string maxid = "0";
            try
            {
                maxid = strmax.Substring(3, strmax.Length - 3);
            }
            catch (Exception ex)
            {
                maxid = "0";
            }

            Int64 dockno = 0;
            try
            {
                dockno = Convert.ToInt64(maxid);
            }
            catch (Exception ex)
            { dockno = 0; }
            dockno++;

            string strdockno = dockno.ToString().PadLeft(7, '0');

            return strlocid + strdockno;
        }

        /// <summary>
        /// Returns Maximum capacity of FTL
        /// </summary>
        /// <param name="ftltype">Type code of FTL</param>
        /// <returns>maximum capacity</returns>
        public static double GetFTLMaxCapacity(string ftltype)
        {
            double maxcapacity = 0.0;
            string sqlstr = "SELECT ISNULL(maxcapacity,0) AS maxcapacity FROM webx_master_ftlcapacity WHERE ftltype='" + ftltype + "'";
            maxcapacity = DocketController.ToDouble(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr)));

            return maxcapacity;
        }

        public static double GetProRataCharge(double freightcharge, double chargedweight, double maxcapacity)
        {
            double diff = 0.00, proratacharge = 0.0;
            diff = chargedweight - maxcapacity;
            if (diff > 0)
            {
                try
                {
                    proratacharge = diff * freightcharge / maxcapacity;
                }
                catch (Exception ex) { }
            }

            return proratacharge;
        }
        public static double ToDouble(object num)
        {
            if (num.ToString().CompareTo("") == 0 || num is DBNull)
            {
                num = "0";
            }

            try
            {
                return Convert.ToDouble(num);
            }
            catch (Exception ex)
            {
                return 0.00;
            }
        }
        public static double ToDouble(string num)
        {
            if (num.ToString().CompareTo("") == 0 || num is DBNull)
            {
                num = "0";
            }

            try
            {
                return Convert.ToDouble(num);
            }
            catch (Exception ex)
            {
                return 0.00;
            }
        }
        public static int ToInteger(string num)
        {
            if (num.ToString().CompareTo("") == 0 || num is DBNull)
            {
                num = "0";
            }

            try
            {
                return Convert.ToInt16(num);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        #endregion

        #region SpecialCharges

        public static FOVTable BindFOVCharge(FOVTable fovtbl)
        {
            string sqlstr = "SELECT activeflag FROM webx_master_charge WHERE chargecode='SCHG11'";
            sqlstr = sqlstr + " AND basedon='" + fovtbl.ChargeRule + "'";
            sqlstr = sqlstr + " AND basecode='" + fovtbl.BaseCode + "'";
            sqlstr = sqlstr + " AND activeflag='Y' AND chargetype='DKT'";
            fovtbl.FlagFOV = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));

            if (fovtbl.FOVType.CompareTo("RS") == 0)
            {
                fovtbl.FOVRate = 0.00;
            }
            else if (fovtbl.FOVType.CompareTo("%") == 0)
            {
                if (fovtbl.RiskType.CompareTo("C") == 0)
                {
                    fovtbl.FOVRate = fovtbl.CarrierRate;
                    fovtbl.FOVCharge = fovtbl.DeclareValue * fovtbl.CarrierRate / 100;
                }
                else if (fovtbl.RiskType.CompareTo("O") == 0)
                {
                    fovtbl.FOVRate = fovtbl.OwenerRate;
                    fovtbl.FOVCharge = fovtbl.DeclareValue * fovtbl.OwenerRate / 100;
                }
            }

            if (fovtbl.FlagFOV.CompareTo("Y") != 0)
            {
                fovtbl.FOVCharge = 0.00;
                fovtbl.FOVRate = 0.00;
            }
            return fovtbl;
        }

        public static double[] BindODACharge(string contractid, string tocity, double chargedweight, double nopkgs, int trdays)
        {
            double[] oda = new double[2];
            double odakm = 0.00, minodacharge = 0.00;
            int odadays = 0;

            string sqlstr = "", slabcode = "", esscode = "", matrixtype = "";
            SqlDataReader dr;

            sqlstr = "SELECT ISNULL(odakm,0) FROM webx_citymaster WHERE location='" + tocity + "'";
            odakm = ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).ToString());

            // THIS WILL FIND APPROPRIATE SLAB CODE FROM CONTRACT
            sqlstr = "SELECT slab_code,matrix_type FROM webx_custcontract_odamatrix_slabhdr";
            sqlstr = sqlstr + " WHERE contractid='" + contractid + "'";
            sqlstr = sqlstr + " AND CONVERT(NUMERIC,(CASE WHEN matrix_type='W' THEN '" + chargedweight.ToString("F2");
            sqlstr = sqlstr + "' ELSE '" + nopkgs.ToString("F0") + "' END),106) BETWEEN slab_from AND slab_to";
            dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
            while (dr.Read())
            {
                slabcode = Convert.ToString(dr["slab_code"]);
                matrixtype = Convert.ToString(dr["matrix_type"]);
            }
            dr.Close();


            // UPON SLABCODE FINDING ESSCODE
            if (slabcode.CompareTo("") != 0)
            {
                sqlstr = "SELECT ess_code,min_odachrg FROM webx_custcontract_odamatrix_disthdr";
                sqlstr = sqlstr + " WHERE contractid='" + contractid + "' AND " + odakm.ToString();
                sqlstr = sqlstr + " BETWEEN ess_from AND ess_to";
                dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
                while (dr.Read())
                {
                    esscode = Convert.ToString(dr["ess_code"]);
                    minodacharge = ToDouble(Convert.ToString(dr["min_odachrg"]));
                }
                dr.Close();

                // Actual Finding of ODA charge
                sqlstr = "SELECT " + slabcode + " as odacharge,trdays FROM webx_custcontract_odamatrix_charge";
                sqlstr = sqlstr + " WHERE  contractid='" + contractid + "' AND  ess_code='" + esscode + "'";
                dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sqlstr);
                while (dr.Read())
                {
                    oda[0] = ToDouble(Convert.ToString(dr["odacharge"]));
                    odadays = ToInteger(Convert.ToString(dr["trdays"]));
                }
                dr.Close();

                // Adding ODA days into Total trdays
                oda[1] = trdays + odadays;


                if (matrixtype.CompareTo("W") == 0)
                    oda[0] = oda[0] * chargedweight;
                else if (matrixtype.CompareTo("P") == 0)
                    oda[0] = oda[0] * nopkgs;
                else if (matrixtype.CompareTo("T") == 0)
                    oda[0] = oda[0] * chargedweight / 1000;

                // Checking for Minimum ODA Charge
                if (minodacharge > oda[0])
                    oda[0] = minodacharge;
            }
            else
            {
                oda[0] = 0.00;
            }
            return oda;
        }


        #endregion

        public static bool SetManualEntry(TextBox txtfreightcharge, TextBox txtfreightrate, DropDownList cmbratetype, TextBox txtbilledat, TextBox txtedd, double freightcharge, double freightrate, string paybas)
        {
            try
            {
                string flag_freight, flag_rate, flag_ratetype, flag_billedat, flag_edd;
                flag_freight = DocketRules.GetEnableValue("F_CHRG", paybas);
                flag_rate = DocketRules.GetEnableValue("F_RATE", paybas);
                flag_ratetype = DocketRules.GetEnableValue("F_RATETYPE", paybas);
                flag_billedat = DocketRules.GetEnableValue("BILLEDAT", paybas);
                flag_edd = DocketRules.GetEnableValue("EDD", paybas);

                if (flag_freight.CompareTo("D") == 0)
                    txtfreightcharge.Enabled = false;
                else if (flag_freight.CompareTo("E") == 0)
                    txtfreightcharge.Enabled = true;
                else if (flag_freight.CompareTo("NE") == 0 && freightcharge == 0)
                    txtfreightcharge.Enabled = true;
                else
                    txtfreightcharge.Enabled = false;

                if (flag_rate.CompareTo("D") == 0)
                    txtfreightrate.Enabled = false;
                else if (flag_rate.CompareTo("E") == 0)
                    txtfreightrate.Enabled = true;
                else if (flag_rate.CompareTo("NE") == 0 && freightrate == 0)
                    txtfreightrate.Enabled = true;
                else
                    txtfreightrate.Enabled = false;

                if (flag_ratetype.CompareTo("D") == 0)
                    cmbratetype.Enabled = false;
                else if (flag_ratetype.CompareTo("E") == 0)
                    cmbratetype.Enabled = true;
                else if (flag_ratetype.CompareTo("NE") == 0 && cmbratetype.Items.Count <= 0)
                    cmbratetype.Enabled = true;
                else
                    cmbratetype.Enabled = false;

                if (flag_billedat.CompareTo("D") == 0)
                    txtbilledat.Enabled = false;
                else if (flag_billedat.CompareTo("E") == 0)
                    txtbilledat.Enabled = true;
                else if (flag_billedat.CompareTo("NE") == 0 && txtbilledat.Text.CompareTo("") == 0)
                    txtbilledat.Enabled = true;

                if (flag_edd.CompareTo("D") == 0)
                    txtedd.Enabled = false;
                else if (flag_edd.CompareTo("E") == 0)
                    txtedd.Enabled = true;
                else if (flag_edd.CompareTo("NE") == 0 && txtedd.Text.CompareTo("") == 0)
                    txtedd.Enabled = true;
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        public static DocketServiceTax GetServiceTax(DocketServiceTax dst)
        {
            double rebateper = 0;
            TaxRate trate = new TaxRate();
            trate.Date = dst.Date;
            trate = TaxRateController.GetTaxObject(trate);

            dst.StdSTaxRate = trate.ServiceTaxRate;
            dst.StdEduCessRate = trate.EduCessRate;
            dst.StdHEduCessRate = trate.HEduCessRate;
            dst.StdSbCessRate = trate.SbcRate;
            dst.StdKKCessRate = trate.KKCessRate;

            dst.STaxRate = trate.ServiceTaxRate;
            dst.EduCessRate = trate.EduCessRate;
            dst.HEduCessRate = trate.HEduCessRate;
            rebateper = trate.AfterRebatePer;
            dst.RebatePercentage = rebateper;

            /* SB Cess*/
            dst.SbcRate = trate.SbcRate;
            /* SB Cess*/
            /* KK Cess*/
            dst.KKCessRate = trate.KKCessRate;
            /* KK Cess*/

            // FOR ROAD MODE TRANSPORTER GETS 75% REBET
            double tmp_staxrate = 0;
            /* SB Cess*/
            double tmp_SbcRate = 0;
            /* SB Cess*/
            /* KK Cess*/
            double tmp_KKCessRate = 0;
            /* KK Cess*/
            if (dst.TransMode.CompareTo("2") == 0 || dst.TransMode.CompareTo("4") == 0)
            {
                dst.STaxRate = trate.ServiceTaxRate * rebateper;
                /* SB Cess*/
                dst.SbcRate = trate.SbcRate * rebateper;
                /* SB Cess*/
                /* KK Cess*/
                dst.KKCessRate = trate.KKCessRate * rebateper;
                /* KK Cess*/
                //if (dst.ServiceType.CompareTo("1") == 0 && dst.SubTotal > 750)
                //{
                //    tmp_staxrate = dst.STaxRate;
                //    tmp_SbcRate = dst.SbcRate;
                //    tmp_KKCessRate = dst.KKCessRate;
                //}
                //else if (dst.ServiceType.CompareTo("2") == 0 && dst.SubTotal > 1500)
                //{
                //    tmp_staxrate = dst.STaxRate;
                //    tmp_SbcRate = dst.SbcRate;
                //    tmp_KKCessRate = dst.KKCessRate;
                //}
                //else
                //{
                //    tmp_staxrate = 0;
                //    tmp_SbcRate = 0;
                //    tmp_KKCessRate = 0;
                //}
                tmp_staxrate = dst.STaxRate;
                tmp_SbcRate = dst.SbcRate;
                tmp_KKCessRate = dst.KKCessRate;
            }
            
            //if (dst.ServiceType == "1")
            //    dst.ExceedAmount = 750;
            //else if (dst.ServiceType == "2")
            //    dst.ExceedAmount = 1500;

            if (dst.StaxPayer.CompareTo("T") == 0)
            {
                dst.ServiceTax = dst.SubTotal * tmp_staxrate / 100;

                /* SB Cess*/
                dst.SBCess = dst.SubTotal * tmp_SbcRate / 100;
                /* SB Cess*/
                /* KK Cess*/
                dst.KKCess = dst.SubTotal * tmp_KKCessRate / 100;
                /* KK Cess*/

                dst.EduCess = dst.ServiceTax * dst.EduCessRate / 100;
                dst.HEduCess = dst.ServiceTax * dst.HEduCessRate / 100;
            }
            else
            {
                dst.ServiceTax = 0;

                /* SB Cess*/
                dst.SBCess = 0;
                /* SB Cess*/

                /* KK Cess*/
                dst.KKCess = 0;
                /* KK Cess*/
                dst.EduCess = 0;
                dst.HEduCess = 0;
            }

            return dst;
        }

        #region FreightContractExecuters
        public static ContractKeys ExecuteFreightContract(ContractKeys ckeys)
        {
            string contracttype = DocketRules.GetDefaultValue(ckeys.PayBase + "CONTRACT");

            if (contracttype.CompareTo("C") == 0)
            {
                if (ckeys.ContractID.CompareTo(ckeys.PayBase + "8888") != 0 && ckeys.ContractID.CompareTo("") != 0)
                {
                    ckeys = ExecuteContractLocationFreight(ckeys);
                }
                else
                {
                    string proceed = DocketRules.GetDefaultValue(ckeys.PayBase + "PROCEED", ckeys.PayBase);
                    if (proceed.CompareTo("S") == 0 || proceed.CompareTo("T") == 0)
                    {
                        ckeys.Status = "NIL_CONTRACT";
                        ckeys.Description = "Contract ID is NIL in Customer Wise Contract. Can't Enter ";
                        return ckeys;
                    }
                    else
                    {
                        ckeys.ContractID = ckeys.PayBase + "8888";
                        ckeys = ExecuteContractLocationFreight(ckeys);
                        ckeys.FoundContract = "D";
                    }
                }
                ckeys.FoundContract = "C";
            }
            else if (contracttype.CompareTo("CD") == 0)
            {
                if (ckeys.ContractID.CompareTo(ckeys.PayBase + "8888") != 0 && ckeys.ContractID.CompareTo("") != 0)
                {
                    ckeys = ExecuteContractLocationFreight(ckeys);
                    ckeys.FoundContract = "C";
                }

                if (ckeys.FreightCharge == 0 || ckeys.FreightRate == 0)
                {
                    ckeys.ContractID = ckeys.PayBase + "8888";
                    ckeys = ExecuteContractLocationFreight(ckeys);
                    ckeys.FoundContract = "D";
                }
            }
            else if (contracttype.CompareTo("D") == 0)
            {
                ckeys.ContractID = ckeys.PayBase + "8888";
                ckeys = ExecuteContractLocationFreight(ckeys);
                ckeys.FoundContract = "D";
            }
            else if (contracttype.CompareTo("W") == 0)
            {
                ckeys.FoundContract = "W";
                ckeys.MinFreightBaseRate = 0.00;
                ckeys.FreightCharge = 0;
                ckeys.FreightRate = 0;
            }

            return ckeys;

        }
        protected static ContractKeys ExecuteContractLocationFreight(ContractKeys ckeys)
        {
            string sqlstr = "";
            if (ckeys.Depth.CompareTo("C") == 0)
                sqlstr = "USP_GET_CITY_FREIGHT";
            else if (ckeys.Depth.CompareTo("L") == 0)
                sqlstr = "USP_GET_LOCATION_FREIGHT";
            else if (ckeys.Depth.CompareTo("R") == 0 || ckeys.Depth.CompareTo("M") == 0)
                sqlstr = "USP_GET_REGIONAL_FREIGHT";
            DataTable dt;
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[15];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@contractid", ckeys.ContractID, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@basedon1", ckeys.BasedOn1, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@basecode1", ckeys.BaseCode1, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@basedon2", ckeys.BasedOn2, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@basecode2", ckeys.BaseCode2, SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@fromcity", ckeys.FromCity, SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@tocity", ckeys.ToCity, SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@orgnloc", ckeys.OrgnLoc, SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@delloc", ckeys.DelLoc, SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@servicetype", ckeys.ServiceType, SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@ftltype", ckeys.FTLType, SqlDbType.VarChar);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@transmode", ckeys.TransMode, SqlDbType.VarChar);
                paramsToStore[12] = ControllersHelper.GetSqlParameter("@chargedweight", ckeys.ChargedWeight, SqlDbType.Decimal);
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@noofpkgs", ckeys.NoOfPkgs, SqlDbType.Decimal);
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@dockdate", ckeys.DockDt, SqlDbType.DateTime);
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sqlstr, paramsToStore).Tables[0];

                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    try
                    {
                        ckeys.FreightCharge = Convert.ToDouble(dr["freightcharge"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.FreightRate = Convert.ToDouble(dr["freightrate"]);
                    }
                    catch (Exception ex) { }

                    try
                    {
                        ckeys.RateType = Convert.ToString(dr["ratetype"]);
                    }
                    catch (Exception ex) { ckeys.RateType = "W"; }
                    try
                    {
                        ckeys.TRDays = Convert.ToInt16(dr["trdays"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.DiscountAmount = Convert.ToDouble(dr["DiscountAmount"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.DiscountType = Convert.ToString(dr["DiscountType"]);
                    }
                    catch (Exception ex) { }

                    try
                    {
                        ckeys.DiscountRate = Convert.ToDouble(dr["DiscountRate"]);
                    }
                    catch (Exception ex) { }
                    // SETTING PRORATA FLAG
                    if (Convert.ToString(dr["ratetype"]).CompareTo("F") == 0)
                        ckeys.FlagProrata = "Y";
                    else
                        ckeys.FlagProrata = "N";
                }
                else
                {
                    ckeys.FreightCharge = 0;
                    ckeys.FreightRate = 0;
                    ckeys.RateType = "W";
                    ckeys.TRDays = 0;
                }


            }
            catch (Exception excp)
            {
                ckeys.FlagProceed = "EXC_CNT_LOC_FRT";
                ckeys.Description = "Execption in ExecuteContractLocationFreight&" + excp.Message.Replace('\n', '_');
                return ckeys;
            }

            ckeys = ExecuteContractMinimumFreight(ckeys);

            if (ckeys.FlagProceed.CompareTo("NT") == 0)
            {
                if (ckeys.FreightCharge == 0 || ckeys.FreightRate == 0)
                {
                    ckeys.FlagProceed = "NIL_CNT_LOC_FRT";
                    ckeys.Description = "Contract Freight Charge Location-Location is not Found. Can't Enter " + SessionUtilities.DocketCalledAs;
                    return ckeys;
                }
            }

            return ckeys;
        }


        protected static ContractKeys ExecuteDefaultLocationFreight(ContractKeys ckeys)
        {
            string sqlstr = "";
            double rate_perkg = 0, rate_perpkg = 0;

            if (ckeys.Depth.ToUpper().CompareTo("L") == 0)
                sqlstr = "USP_GET_DEFAULT_LOCATION_FREIGHT";
            else if (ckeys.Depth.ToUpper().CompareTo("R") == 0 || ckeys.Depth.ToUpper().CompareTo("M") == 0)
                sqlstr = "USP_GET_DEFAULT_REGIONAL_FREIGHT";

            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[6];

                paramsToStore[0] = new SqlParameter("@paybas", SqlDbType.VarChar);
                paramsToStore[0].Value = ckeys.PayBase;
                paramsToStore[0].Size = 5;
                paramsToStore[1] = new SqlParameter("@orgnloc", SqlDbType.VarChar);
                paramsToStore[1].Value = ckeys.OrgnLoc;
                paramsToStore[1].Size = 50;
                paramsToStore[2] = new SqlParameter("@delloc", SqlDbType.VarChar);
                paramsToStore[2].Value = ckeys.DelLoc;
                paramsToStore[2].Size = 50;
                paramsToStore[3] = new SqlParameter("@transmode", SqlDbType.VarChar);
                paramsToStore[3].Value = ckeys.TransMode;
                paramsToStore[3].Size = 5;
                paramsToStore[4] = new SqlParameter("@chargedweight", SqlDbType.Decimal);
                paramsToStore[4].Value = ckeys.ChargedWeight;
                paramsToStore[5] = new SqlParameter("@noofpkgs", SqlDbType.Decimal);
                paramsToStore[5].Value = ckeys.NoOfPkgs;
                SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sqlstr, paramsToStore);
                if (dr.Read())
                {
                    try
                    {
                        rate_perkg = Convert.ToDouble(dr["RATE_PER_KG"]);
                    }
                    catch (Exception ex) { rate_perkg = 0; }
                    try
                    {
                        rate_perpkg = Convert.ToDouble(dr["RATE_PER_PKG"]);
                    }
                    catch (Exception ex) { rate_perpkg = 0; }
                    try
                    {
                        ckeys.TRDays = Convert.ToInt16(dr["TRDAYS"]);
                    }
                    catch (Exception ex) { ckeys.TRDays = 0; }
                }
                else
                {
                    ckeys.FreightCharge = 0.00;
                    ckeys.FreightRate = 0.00;
                    ckeys.RateType = "W";
                    ckeys.TRDays = 0;
                }
                dr.Close();
            }
            catch (Exception excp)
            {
                ckeys.Status = "EXC_DEF_LOC_FRT";
                ckeys.Description = "Execption in ExecuteDefaultLocationFreight&" + excp.Message.Replace('\n', '_');
                return ckeys;
            }

            if (rate_perkg != 0)
            {
                ckeys.FreightRate = rate_perkg;
                ckeys.FreightCharge = rate_perkg * ckeys.ChargedWeight;
                ckeys.RateType = "W";
            }
            else
            {
                ckeys.FreightRate = 0.00;
                ckeys.FreightCharge = 0.00;
                ckeys.RateType = "W";
            }

            if (ckeys.FlagProceed.CompareTo("NT") == 0)
            {
                if (ckeys.FreightCharge == 0 || ckeys.FreightRate == 0)
                {
                    ckeys.FlagProceed = "NIL_DEF_LOC_FRT";
                    ckeys.Description = "Default Freight Charge Location-Location is not Found. Can't Enter " + SessionUtilities.DocketCalledAs;
                    return ckeys;
                }
            }


            ckeys = ExecuteContractMinimumFreight(ckeys);

            return ckeys;
        }
        protected static ContractKeys ExecuteContractMinimumFreight(ContractKeys ckeys)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[2];

                paramsToStore[0] = new SqlParameter("@contractid", SqlDbType.VarChar);
                paramsToStore[0].Value = ckeys.ContractID;
                paramsToStore[0].Size = 30;
                paramsToStore[1] = new SqlParameter("@transmode", SqlDbType.VarChar);
                paramsToStore[1].Value = ckeys.TransMode;
                paramsToStore[1].Size = 10;

                SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USP_GET_MINIMUM_FREIGHT", paramsToStore);

                while (dr.Read())
                {

                    try
                    {
                        ckeys.MinFreightType = Convert.ToString(dr["minfreighttype"]);
                    }
                    catch (Exception ex) { ckeys.MinFreightType = "B"; }
                    ckeys.MinFreightBase = Convert.ToString(dr["minfreightbas"]);

                    try
                    {
                        ckeys.MinFreightBaseRate = Convert.ToDouble(dr["minfreightbasrate"]);
                    }
                    catch (Exception ex) { ckeys.MinFreightBaseRate = 0; }

                    try
                    {
                        ckeys.MinFreightRate = Convert.ToDouble(dr["minfreightrate"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.FreightRateLowerLimit = Convert.ToDouble(dr["freightratelowerlimit"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.FreightRateUpperLimit = Convert.ToDouble(dr["freightrateupperlimit"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.MinSubTotal = Convert.ToDouble(dr["minsubtotal"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.SubTotalLowerLimit = Convert.ToDouble(dr["subtotallowerlimit"]);
                    }
                    catch (Exception ex) { }
                    try
                    {
                        ckeys.SubTotalUpperLimit = Convert.ToDouble(dr["subtotalupperlimit"]);
                    }
                    catch (Exception ex) { }
                    try
                    {

                        ckeys.FlagFreight = Convert.ToString(dr["flag_freight"]);
                    }
                    catch (Exception ex) { ckeys.FlagFreight = "N"; }
                    try
                    {
                        ckeys.FlagSutotal = Convert.ToString(dr["flag_subtotal"]);
                    }
                    catch (Exception ex) { ckeys.FlagSutotal = "N"; }
                }
                dr.Close();

            }
            catch (Exception excp)
            {
                ckeys.Status = "EXC_MIN_FRT";
                ckeys.Description = "Exeption in ExecuteContractMinimumFreight" + excp.Message.Replace('\n', '_');
            }

            return ckeys;
        }
        #endregion

        #region DataSavers

        public static bool MasterDocketEntry(Docket dkt, DocketCharges charges, DocketDocument[] dockdoc, DocketInvoice[] dockinv, string finyear4d, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[6];

                if (dkt.DockDate < DateTime.MinValue || dkt.DockDate > DateTime.MaxValue)
                    dkt.DockDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.EDD <= DateTime.MinValue || dkt.EDD >= DateTime.MaxValue)
                    dkt.EDD = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitDate <= DateTime.MinValue || dkt.PermitDate >= DateTime.MaxValue)
                    dkt.PermitDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitRecieveDate <= DateTime.MinValue || dkt.PermitRecieveDate >= DateTime.MaxValue)
                    dkt.PermitRecieveDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitValidityDate <= DateTime.MinValue || dkt.PermitValidityDate >= DateTime.MaxValue)
                    dkt.PermitValidityDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PolicyDate <= DateTime.MinValue || dkt.PolicyDate >= DateTime.MaxValue)
                    dkt.PolicyDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.InvoiceDate <= DateTime.MinValue || dkt.InvoiceDate >= DateTime.MaxValue)
                    dkt.InvoiceDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                string strXMLMasterEntry = "", strXMLChargesEntry = "", strXMLDocumentEntry = "", strXMLInvoiceEntry = "";
                strXMLMasterEntry = "<root><master_entry>"
                + "<dockno>" + dkt.DockNo + "</dockno>"
                + "<docksf>.</docksf>"
                + "<dockdt>" + dkt.DockDate.ToString("dd MMM yyyy") + "</dockdt>"
                + "<orgncd>" + dkt.OrgnLoc + "</orgncd>"
                + "<destcd>" + dkt.DelLoc + "</destcd>"
                + "<reassign_destcd>" + dkt.DelLoc + "</reassign_destcd>"
                + "<from_loc>" + dkt.FromCity + "</from_loc>"
                + "<to_loc>" + dkt.ToCity + "</to_loc>"
                + "<cdeldt>" + dkt.EDD.ToString("dd MMM yyyy") + "</cdeldt>"
                + "<paybas>" + dkt.PayBase + "</paybas>"
                + "<pkgsno>" + dkt.NoOfPkgs.ToString("F0") + "</pkgsno>"
                + "<actuwt>" + dkt.ActualWeight.ToString("F0") + "</actuwt>"
                + "<chrgwt>" + dkt.ChargedWeight.ToString("F0") + "</chrgwt>"
                + "<prodcd>" + dkt.ProdType + "</prodcd>"
                + "<spl_svc_req>" + dkt.Remarks + "</spl_svc_req>"
                + "<stax_paidby>" + dkt.STaxPaidBy + "</stax_paidby>"
                + "<stax_regno>" + dkt.STaxRegNo + "</stax_regno>"
                + "<service_class>" + dkt.ServiceType + "</service_class>"
                + "<ftl_types>" + dkt.FTLType + "</ftl_types>"
                + "<fincmplbr>" + dkt.BilledAt + "</fincmplbr>"
                + "<csgncd>" + dkt.ConsignorCode + "</csgncd>"
                + "<csgnnm>" + dkt.ConsignorName + "</csgnnm>"
                + "<csgnaddr>" + dkt.ConsignorAddress + "</csgnaddr>"
                + "<csgncity>" + dkt.ConsignorCity + "</csgncity>"
                + "<csgnpincode>" + dkt.ConsignorPinCode + "</csgnpincode>"
                + "<csgnteleno>" + dkt.ConsignorPhone + "</csgnteleno>"
                + "<csgnemail>" + dkt.ConsignorEmail + "</csgnemail>"
                + "<csgecd>" + dkt.ConsigneeCode + "</csgecd>"
                + "<csgenm>" + dkt.ConsigneeName + "</csgenm>"
                + "<csgeaddr>" + dkt.ConsigneeAddress + "</csgeaddr>"
                + "<csgecity>" + dkt.ConsigneeCity + "</csgecity>"
                + "<csgepincode>" + dkt.ConsigneePinCode + "</csgepincode>"
                + "<csgeteleno>" + dkt.ConsigneePhone + "</csgeteleno>"
                + "<csgeemail>" + dkt.ConsigneeEmail + "</csgeemail>"
                + "<party_code>" + dkt.PartyCode + "</party_code>"
                + "<privatemark>" + dkt.PrivateMark + "</privatemark>"
                + "<tpnumber>" + dkt.TPNumber + "</tpnumber>"
                + "<trn_mod>" + dkt.TransMode + "</trn_mod>"
                + "<cod_dod>" + dkt.FlagCODDOD + "</cod_dod>"
                + "<cft_yn>" + dkt.FlagVolumetric + "</cft_yn>"
                + "<diplomat>" + dkt.FlagODA + "</diplomat>"
                + "<dacc_yn>" + dkt.FlagDACC + "</dacc_yn>"
                + "<localcn_yn>" + dkt.FlagLocal + "</localcn_yn>"
                + "<pickup_dely>" + dkt.PickUpDel + "</pickup_dely>"
                + "<permit_yn>" + dkt.FlagPermit + "</permit_yn>"
                + "<permit_recvd_at>" + dkt.PermitRecievedAt + "</permit_recvd_at>"
                + "<permitdt>" + dkt.PermitDate.ToString("dd MMM yyyy") + "</permitdt>"
                + "<permit_recvd_dt>" + dkt.PermitRecieveDate.ToString("dd MMM yyyy") + "</permit_recvd_dt>"
                + "<permit_no>" + dkt.PermitNo + "</permit_no>"
                + "<permit_validity_dt>" + dkt.PermitValidityDate.ToString("dd MMM yyyy") + "</permit_validity_dt>"
                + "<entryby>" + dkt.EntryBy + "</entryby>"
                + "<pkgsty>" + dkt.PackType + "</pkgsty>"
                + "<insuyn>" + dkt.RiskType + "</insuyn>"
                + "<insupl>" + dkt.PolicyNo + "</insupl>"
                + "<insupldt>" + dkt.PolicyDate.ToString("dd MMM yyyy") + "</insupldt>"
                + "<ctr_no>" + dkt.CustomerRefNo + "</ctr_no>"
                + "<tot_modvat>" + dkt.ModvatCovers.ToString("F0") + "</tot_modvat>"
                + "<tot_covers>" + dkt.InternalCovers.ToString("F0") + "</tot_covers>"
                + "<codamt>" + dkt.CODDODAmount + "</codamt>"
                + "<businesstype>" + dkt.BusinessType + "</businesstype>"
                + "<loadtype>" + dkt.LoadType + "</loadtype>"
                + "<entrysheetno>" + dkt.EntrySheetNo + "</entrysheetno>"
                + "<obdno>" + dkt.OBDNo + "</obdno>"
                + "<bacode>" + dkt.BACode + "</bacode>"
                + "<dopino>" + dkt.DopiNo + "</dopino>"
                + "<edited>N</edited>"
                + "<editinfo></editinfo>"
                + "<stax_exmpt_yn>" + dkt.FlagStaxExmpt + "</stax_exmpt_yn>"
                + "<party_as>" + dkt.PartyAs + "</party_as>"
                + "<multipickup_yn>" + dkt.FlagMultiPickUp + "</multipickup_yn>"
                + "<multidelivery_yn>" + dkt.FlagMultiDelivery + "</multidelivery_yn>"
                + "<sourcedockno>" + dkt.SourceDockNo + "</sourcedockno>"
                + "<doctype>" + dkt.DocType + "</doctype>"
                + "<ctr_gpno>" + dkt.CustRefGPNo + "</ctr_gpno>"
                + "<ctr_delno>" + dkt.CustRefDelNo + "</ctr_delno>"
                + "<invno>" + dkt.InvoiceNo + "</invno>"
                + "<invdt>" + dkt.InvoiceDate.ToString("dd MMM yyyy") + "</invdt>"
                + "<invamt>" + dkt.InvoiceAmount.ToString("F0") + "</invamt>"
                + "</master_entry></root>";


                strXMLChargesEntry = "<root><master_charges_entry>"
                + "<DOCKNO>" + charges.DockNo + "</DOCKNO>"
                + "<RATE_TYPE>" + charges.RateType + "</RATE_TYPE>"
                + "<FRT_RATE>" + charges.FreightRate + "</FRT_RATE>"
                + "<FREIGHT_CALC>" + charges.Freight.ToString("F2") + "</FREIGHT_CALC>"
                + "<FREIGHT>" + charges.Freight.ToString("F2") + "</FREIGHT>"
                + "<FOV>" + charges.Charges[11].ToString("F2") + "</FOV>"
                + "<SCHG01>" + charges.Charges[1].ToString("F2") + "</SCHG01>"
                + "<SCHG02>" + charges.Charges[2].ToString("F2") + "</SCHG02>"
                + "<SCHG03>" + charges.Charges[3].ToString("F2") + "</SCHG03>"
                + "<SCHG04>" + charges.Charges[4].ToString("F2") + "</SCHG04>"
                + "<SCHG05>" + charges.Charges[5].ToString("F2") + "</SCHG05>"
                + "<SCHG06>" + charges.Charges[6].ToString("F2") + "</SCHG06>"
                + "<SCHG07>" + charges.Charges[7].ToString("F2") + "</SCHG07>"
                + "<SCHG08>" + charges.Charges[8].ToString("F2") + "</SCHG08>"
                + "<SCHG09>" + charges.Charges[9].ToString("F2") + "</SCHG09>"
                + "<SCHG10>" + charges.Charges[10].ToString("F2") + "</SCHG10>"
                + "<SCHG11>" + charges.Charges[11].ToString("F2") + "</SCHG11>"
                + "<SCHG12>" + charges.Charges[12].ToString("F2") + "</SCHG12>"
                + "<SCHG13>" + charges.Charges[13].ToString("F2") + "</SCHG13>"
                + "<SCHG14>" + charges.Charges[14].ToString("F2") + "</SCHG14>"
                + "<SCHG15>" + charges.Charges[15].ToString("F2") + "</SCHG15>"
                + "<SCHG16>" + charges.Charges[16].ToString("F2") + "</SCHG16>"
                + "<SCHG17>" + charges.Charges[17].ToString("F2") + "</SCHG17>"
                + "<SCHG18>" + charges.Charges[18].ToString("F2") + "</SCHG18>"
                + "<SCHG19>" + charges.Charges[19].ToString("F2") + "</SCHG19>"
                + "<SCHG20>" + charges.Charges[20].ToString("F2") + "</SCHG20>"
                + "<SCHG21>" + charges.Charges[21].ToString("F2") + "</SCHG21>"
                + "<SCHG22>" + charges.Charges[22].ToString("F2") + "</SCHG22>"
                + "<SCHG23>" + charges.Charges[23].ToString("F2") + "</SCHG23>"
                + "<UCHG01>" + charges.Charges[24].ToString("F2") + "</UCHG01>"
                + "<UCHG02>" + charges.Charges[25].ToString("F2") + "</UCHG02>"
                + "<UCHG03>" + charges.Charges[26].ToString("F2") + "</UCHG03>"
                + "<UCHG04>" + charges.Charges[27].ToString("F2") + "</UCHG04>"
                + "<UCHG05>" + charges.Charges[28].ToString("F2") + "</UCHG05>"
                + "<UCHG06>" + charges.Charges[29].ToString("F2") + "</UCHG06>"
                + "<UCHG07>" + charges.Charges[30].ToString("F2") + "</UCHG07>"
                + "<UCHG08>" + charges.Charges[31].ToString("F2") + "</UCHG08>"
                + "<UCHG09>" + charges.Charges[32].ToString("F2") + "</UCHG09>"
                + "<UCHG10>" + charges.Charges[33].ToString("F2") + "</UCHG10>"
                + "<SUBTOTAL>" + charges.SubTotal.ToString("F2") + "</SUBTOTAL>"
                + "<SVCTAX>" + charges.ServiceTax.ToString("F2") + "</SVCTAX>"
				+ "<ServiceTaxRate>" + charges.ServiceTaxRate.ToString("F2") + "</ServiceTaxRate>"
                + "<CESS>" + charges.EduCess.ToString("F2") + "</CESS>"
                + "<HEDU_CESS>" + charges.HEduCess.ToString("F2") + "</HEDU_CESS>"
                + "<DKTTOT>" + charges.DocketTotal.ToString("F2") + "</DKTTOT>"
                    /* SB Cess */
                + "<SbcRate>" + charges.SbcRate.ToString("F2") + "</SbcRate>"
                + "<SBCess>" + charges.SBCess.ToString("F2") + "</SBCess>"
                    /* SB Cess */
                    /* KK Cess */
                 + "<KKCessRate>" + charges.KKCessRate.ToString("F2") + "</KKCessRate>"
                 + "<KKCess>" + charges.KKCess.ToString("F2") + "</KKCess>"
                    /* KK Cess */
                + "</master_charges_entry></root>";


                //, strXMLInvoiceEntry = "";
                strXMLDocumentEntry = "<root><master_document_entry>";
                for (int i = 0; i < dockdoc.Length; i++)
                {
                    strXMLDocumentEntry += "<document>"
                    + "<dockno>" + dockdoc[i].DockNo + "</dockno>"
                    + "<docksf>" + dockdoc[i].DockSF + "</docksf>"
                    + "<srno>1</srno>"
                    + "<documentno>" + dockdoc[i].DocumentNo + "</documentno></document>";
                }
                strXMLDocumentEntry += "</master_document_entry></root>";


                strXMLInvoiceEntry = "";
                strXMLInvoiceEntry = "<root><master_invoice_entry>";
                for (int i = 0; i < dockinv.Length; i++)
                {
                    strXMLInvoiceEntry += "<invoice>"
                    + "<dockno>" + dockinv[i].DockNo + "</dockno>"
                    + "<invno>" + dockinv[i].InvoiceNo + "</invno>";

                    if (dockinv[i].InvoiceDate <= DateTime.MinValue || dockinv[i].InvoiceDate >= DateTime.MaxValue)
                        dockinv[i].InvoiceDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                    strXMLInvoiceEntry += "<invdt>" + dockinv[i].InvoiceDate.ToString("dd MMM yyyy") + "</invdt>"
                        + "<declval>" + dockinv[i].DeclaredValue.ToString("F0") + "</declval>"
                        + "<pkgsno>" + dockinv[i].NoOfPkgs.ToString("F0") + "</pkgsno>"
                        + "<actuwt>" + dockinv[i].ActualWeight.ToString("F0") + "</actuwt>"
                        + "<vol_l>" + dockinv[i].Vol_Length.ToString("F0") + "</vol_l>"
                        + "<vol_b>" + dockinv[i].Vol_Breadth.ToString("F0") + "</vol_b>"
                        + "<vol_h>" + dockinv[i].Vol_Height.ToString("F0") + "</vol_h>"
                        + "<tot_cft>" + dockinv[i].Vol_CFT.ToString("F0") + "</tot_cft></invoice>";
                }
                strXMLInvoiceEntry += "</master_invoice_entry></root>";

                strXMLMasterEntry = strXMLMasterEntry.Replace("&", "&amp;");
                strXMLChargesEntry = strXMLChargesEntry.Replace("&", "&amp;");
                strXMLDocumentEntry = strXMLDocumentEntry.Replace("&", "&amp;");
                strXMLInvoiceEntry = strXMLInvoiceEntry.Replace("&", "&amp;");

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLdocketMasterEntry", strXMLMasterEntry, SqlDbType.NVarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@strXMLdocketChargesEntry", strXMLChargesEntry, SqlDbType.NVarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@strXMLdocketDocumentEntry", strXMLDocumentEntry, SqlDbType.NVarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@strXMLdocketInvoiceEntry", strXMLInvoiceEntry, SqlDbType.NVarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@dockno", dkt.DockNo, SqlDbType.NVarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.NVarChar);
                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_DOCKET_ENTRY", paramsToStore);
            }
            catch (Exception excp)
            {
                throw excp;
            }
            return true;
        }

        public static DataTable MasterDocketEntry(Docket dkt, DocketCharges charges, DocketDocument[] dockdoc, DocketInvoice[] dockinv, string finyear4d)
        {
            DataTable dt = new DataTable();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[6];

                if (dkt.DockDate < DateTime.MinValue || dkt.DockDate > DateTime.MaxValue)
                    dkt.DockDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.EDD <= DateTime.MinValue || dkt.EDD >= DateTime.MaxValue)
                    dkt.EDD = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitDate <= DateTime.MinValue || dkt.PermitDate >= DateTime.MaxValue)
                    dkt.PermitDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitRecieveDate <= DateTime.MinValue || dkt.PermitRecieveDate >= DateTime.MaxValue)
                    dkt.PermitRecieveDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitValidityDate <= DateTime.MinValue || dkt.PermitValidityDate >= DateTime.MaxValue)
                    dkt.PermitValidityDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PolicyDate <= DateTime.MinValue || dkt.PolicyDate >= DateTime.MaxValue)
                    dkt.PolicyDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.InvoiceDate <= DateTime.MinValue || dkt.InvoiceDate >= DateTime.MaxValue)
                    dkt.InvoiceDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                string strXMLMasterEntry = "", strXMLChargesEntry = "", strXMLDocumentEntry = "", strXMLInvoiceEntry = "";
                strXMLMasterEntry = "<root><master_entry>"
                + "<dockno>" + dkt.DockNo + "</dockno>"
                + "<docksf>.</docksf>"
                + "<dockdt>" + dkt.DockDate.ToString("dd MMM yyyy") + "</dockdt>"
                + "<orgncd>" + dkt.OrgnLoc + "</orgncd>"
                + "<destcd>" + dkt.DelLoc + "</destcd>"
                + "<reassign_destcd>" + dkt.DelLoc + "</reassign_destcd>"
                + "<from_loc>" + dkt.FromCity + "</from_loc>"
                + "<to_loc>" + dkt.ToCity + "</to_loc>"
                + "<cdeldt>" + dkt.EDD.ToString("dd MMM yyyy") + "</cdeldt>"
                + "<paybas>" + dkt.PayBase + "</paybas>"
                + "<pkgsno>" + dkt.NoOfPkgs.ToString("F0") + "</pkgsno>"
                + "<actuwt>" + dkt.ActualWeight.ToString("F0") + "</actuwt>"
                + "<chrgwt>" + dkt.ChargedWeight.ToString("F0") + "</chrgwt>"
                + "<prodcd>" + dkt.ProdType + "</prodcd>"
                + "<spl_svc_req>" + dkt.Remarks + "</spl_svc_req>"
                + "<stax_paidby>" + dkt.STaxPaidBy + "</stax_paidby>"
                + "<stax_regno>" + dkt.STaxRegNo + "</stax_regno>"
                + "<service_class>" + dkt.ServiceType + "</service_class>"
                + "<ftl_types>" + dkt.FTLType + "</ftl_types>"
                + "<fincmplbr>" + dkt.BilledAt + "</fincmplbr>"
                + "<csgncd>" + dkt.ConsignorCode + "</csgncd>"
                + "<csgnnm>" + dkt.ConsignorName + "</csgnnm>"
                + "<csgnaddr>" + dkt.ConsignorAddress + "</csgnaddr>"
                + "<csgncity>" + dkt.ConsignorCity + "</csgncity>"
                + "<csgnpincode>" + dkt.ConsignorPinCode + "</csgnpincode>"
                + "<csgnteleno>" + dkt.ConsignorPhone + "</csgnteleno>"
                + "<csgnemail>" + dkt.ConsignorEmail + "</csgnemail>"
                + "<csgecd>" + dkt.ConsigneeCode + "</csgecd>"
                + "<csgenm>" + dkt.ConsigneeName + "</csgenm>"
                + "<csgeaddr>" + dkt.ConsigneeAddress + "</csgeaddr>"
                + "<csgecity>" + dkt.ConsigneeCity + "</csgecity>"
                + "<csgepincode>" + dkt.ConsigneePinCode + "</csgepincode>"
                + "<csgeteleno>" + dkt.ConsigneePhone + "</csgeteleno>"
                + "<csgeemail>" + dkt.ConsigneeEmail + "</csgeemail>"
                + "<party_code>" + dkt.PartyCode + "</party_code>"
                + "<privatemark>" + dkt.PrivateMark + "</privatemark>"
                + "<tpnumber>" + dkt.TPNumber + "</tpnumber>"
                + "<trn_mod>" + dkt.TransMode + "</trn_mod>"
                + "<cod_dod>" + dkt.FlagCODDOD + "</cod_dod>"
                + "<cft_yn>" + dkt.FlagVolumetric + "</cft_yn>"
                + "<diplomat>" + dkt.FlagODA + "</diplomat>"
                + "<dacc_yn>" + dkt.FlagDACC + "</dacc_yn>"
                + "<localcn_yn>" + dkt.FlagLocal + "</localcn_yn>"
                + "<pickup_dely>" + dkt.PickUpDel + "</pickup_dely>"
                + "<permit_yn>" + dkt.FlagPermit + "</permit_yn>"
                + "<permit_recvd_at>" + dkt.PermitRecievedAt + "</permit_recvd_at>"
                + "<permitdt>" + dkt.PermitDate.ToString("dd MMM yyyy") + "</permitdt>"
                + "<permit_recvd_dt>" + dkt.PermitRecieveDate.ToString("dd MMM yyyy") + "</permit_recvd_dt>"
                + "<permit_no>" + dkt.PermitNo + "</permit_no>"
                + "<permit_validity_dt>" + dkt.PermitValidityDate.ToString("dd MMM yyyy") + "</permit_validity_dt>"
                + "<entryby>" + dkt.EntryBy + "</entryby>"
                + "<pkgsty>" + dkt.PackType + "</pkgsty>"
                + "<insuyn>" + dkt.RiskType + "</insuyn>"
                + "<insupl>" + dkt.PolicyNo + "</insupl>"
                + "<insupldt>" + dkt.PolicyDate.ToString("dd MMM yyyy") + "</insupldt>"
                + "<ctr_no>" + dkt.CustomerRefNo + "</ctr_no>"
                + "<tot_modvat>" + dkt.ModvatCovers.ToString("F0") + "</tot_modvat>"
                + "<tot_covers>" + dkt.InternalCovers.ToString("F0") + "</tot_covers>"
                + "<codamt>" + dkt.CODDODAmount + "</codamt>"
                + "<businesstype>" + dkt.BusinessType + "</businesstype>"
                + "<loadtype>" + dkt.LoadType + "</loadtype>"
                + "<entrysheetno>" + dkt.EntrySheetNo + "</entrysheetno>"
                + "<obdno>" + dkt.OBDNo + "</obdno>"
                + "<bacode>" + dkt.BACode + "</bacode>"
                + "<dopino>" + dkt.DopiNo + "</dopino>"
                + "<edited>N</edited>"
                + "<editinfo></editinfo>"
                + "<stax_exmpt_yn>" + dkt.FlagStaxExmpt + "</stax_exmpt_yn>"
                + "<party_as>" + dkt.PartyAs + "</party_as>"
                + "<multipickup_yn>" + dkt.FlagMultiPickUp + "</multipickup_yn>"
                + "<multidelivery_yn>" + dkt.FlagMultiDelivery + "</multidelivery_yn>"
                + "<sourcedockno>" + dkt.SourceDockNo + "</sourcedockno>"
                + "<doctype>" + dkt.DocType + "</doctype>"
                + "<ctr_gpno>" + dkt.CustRefGPNo + "</ctr_gpno>"
                + "<ctr_delno>" + dkt.CustRefDelNo + "</ctr_delno>"
                + "<invno>" + dkt.InvoiceNo + "</invno>"
                + "<invdt>" + dkt.InvoiceDate.ToString("dd MMM yyyy") + "</invdt>"
                + "<invamt>" + dkt.InvoiceAmount.ToString("F0") + "</invamt>"
                + "</master_entry></root>";


                strXMLChargesEntry = "<root><master_charges_entry>"
                + "<DOCKNO>" + charges.DockNo + "</DOCKNO>"
                + "<RATE_TYPE>" + charges.RateType + "</RATE_TYPE>"
                + "<FRT_RATE>" + charges.FreightRate + "</FRT_RATE>"
                + "<FREIGHT_CALC>" + charges.Freight.ToString("F2") + "</FREIGHT_CALC>"
                + "<FREIGHT>" + charges.Freight.ToString("F2") + "</FREIGHT>"
                + "<FOV>" + charges.Charges[11].ToString("F2") + "</FOV>"
                + "<SCHG01>" + charges.Charges[1].ToString("F2") + "</SCHG01>"
                + "<SCHG02>" + charges.Charges[2].ToString("F2") + "</SCHG02>"
                + "<SCHG03>" + charges.Charges[3].ToString("F2") + "</SCHG03>"
                + "<SCHG04>" + charges.Charges[4].ToString("F2") + "</SCHG04>"
                + "<SCHG05>" + charges.Charges[5].ToString("F2") + "</SCHG05>"
                + "<SCHG06>" + charges.Charges[6].ToString("F2") + "</SCHG06>"
                + "<SCHG07>" + charges.Charges[7].ToString("F2") + "</SCHG07>"
                + "<SCHG08>" + charges.Charges[8].ToString("F2") + "</SCHG08>"
                + "<SCHG09>" + charges.Charges[9].ToString("F2") + "</SCHG09>"
                + "<SCHG10>" + charges.Charges[10].ToString("F2") + "</SCHG10>"
                + "<SCHG11>" + charges.Charges[11].ToString("F2") + "</SCHG11>"
                + "<SCHG12>" + charges.Charges[12].ToString("F2") + "</SCHG12>"
                + "<SCHG13>" + charges.Charges[13].ToString("F2") + "</SCHG13>"
                + "<SCHG14>" + charges.Charges[14].ToString("F2") + "</SCHG14>"
                + "<SCHG15>" + charges.Charges[15].ToString("F2") + "</SCHG15>"
                + "<SCHG16>" + charges.Charges[16].ToString("F2") + "</SCHG16>"
                + "<SCHG17>" + charges.Charges[17].ToString("F2") + "</SCHG17>"
                + "<SCHG18>" + charges.Charges[18].ToString("F2") + "</SCHG18>"
                + "<SCHG19>" + charges.Charges[19].ToString("F2") + "</SCHG19>"
                + "<SCHG20>" + charges.Charges[20].ToString("F2") + "</SCHG20>"
                + "<SCHG21>" + charges.Charges[21].ToString("F2") + "</SCHG21>"
                + "<SCHG22>" + charges.Charges[22].ToString("F2") + "</SCHG22>"
                + "<SCHG23>" + charges.Charges[23].ToString("F2") + "</SCHG23>"
                + "<UCHG01>" + charges.Charges[24].ToString("F2") + "</UCHG01>"
                + "<UCHG02>" + charges.Charges[25].ToString("F2") + "</UCHG02>"
                + "<UCHG03>" + charges.Charges[26].ToString("F2") + "</UCHG03>"
                + "<UCHG04>" + charges.Charges[27].ToString("F2") + "</UCHG04>"
                + "<UCHG05>" + charges.Charges[28].ToString("F2") + "</UCHG05>"
                + "<UCHG06>" + charges.Charges[29].ToString("F2") + "</UCHG06>"
                + "<UCHG07>" + charges.Charges[30].ToString("F2") + "</UCHG07>"
                + "<UCHG08>" + charges.Charges[31].ToString("F2") + "</UCHG08>"
                + "<UCHG09>" + charges.Charges[32].ToString("F2") + "</UCHG09>"
                + "<UCHG10>" + charges.Charges[33].ToString("F2") + "</UCHG10>"
                + "<SUBTOTAL>" + charges.SubTotal.ToString("F2") + "</SUBTOTAL>"
                + "<SVCTAX>" + charges.ServiceTax.ToString("F2") + "</SVCTAX>"
                + "<ServiceTaxRate>" + charges.ServiceTaxRate.ToString("F2") + "</ServiceTaxRate>"
				+ "<CESS>" + charges.EduCess.ToString("F2") + "</CESS>"
                + "<HEDU_CESS>" + charges.HEduCess.ToString("F2") + "</HEDU_CESS>"
                + "<DKTTOT>" + charges.DocketTotal.ToString("F2") + "</DKTTOT>"
                + "<Discount>" + charges.Discount.ToString("F2") + "</Discount>"
                + "<DiscountType>" + charges.DiscountType + "</DiscountType>"
                + "<DiscountRate>" + charges.DiscountRate.ToString("F2") + "</DiscountRate>"
				+ "<ServiceTaxRate>" + charges.ServiceTaxRate.ToString("F2") + "</ServiceTaxRate>"
                    /* SB Cess */
                + "<SbcRate>" + charges.SbcRate.ToString("F2") + "</SbcRate>"
                + "<SBCess>" + charges.SBCess.ToString("F2") + "</SBCess>"
                    /* SB Cess */
                    /* KK Cess */
                + "<KKCessRate>" + charges.KKCessRate.ToString("F2") + "</KKCessRate>"
                + "<KKCess>" + charges.KKCess.ToString("F2") + "</KKCess>"
                    /* KK Cess */
                + "</master_charges_entry></root>";

                //, strXMLInvoiceEntry = "";
                strXMLDocumentEntry = "<root><master_document_entry>";
                for (int i = 0; i < dockdoc.Length; i++)
                {
                    strXMLDocumentEntry += "<document>"
                    + "<dockno>" + dockdoc[i].DockNo + "</dockno>"
                    + "<docksf>" + dockdoc[i].DockSF + "</docksf>"
                    + "<srno>1</srno>"
                    + "<documentno>" + dockdoc[i].DocumentNo + "</documentno></document>";
                }
                strXMLDocumentEntry += "</master_document_entry></root>";


                strXMLInvoiceEntry = "";
                strXMLInvoiceEntry = "<root><master_invoice_entry>";
                for (int i = 0; i < dockinv.Length; i++)
                {
                    strXMLInvoiceEntry += "<invoice>"
                    + "<dockno>" + dockinv[i].DockNo + "</dockno>"
                    + "<invno>" + dockinv[i].InvoiceNo + "</invno>";

                    if (dockinv[i].InvoiceDate <= DateTime.MinValue || dockinv[i].InvoiceDate >= DateTime.MaxValue)
                        dockinv[i].InvoiceDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                    strXMLInvoiceEntry += "<invdt>" + dockinv[i].InvoiceDate.ToString("dd MMM yyyy") + "</invdt>"
                        + "<declval>" + dockinv[i].DeclaredValue.ToString("F0") + "</declval>"
                        + "<pkgsno>" + dockinv[i].NoOfPkgs.ToString("F0") + "</pkgsno>"
                        + "<actuwt>" + dockinv[i].ActualWeight.ToString("F0") + "</actuwt>"
                        + "<vol_l>" + dockinv[i].Vol_Length.ToString("F0") + "</vol_l>"
                        + "<vol_b>" + dockinv[i].Vol_Breadth.ToString("F0") + "</vol_b>"
                        + "<vol_h>" + dockinv[i].Vol_Height.ToString("F0") + "</vol_h>"
                        + "<tot_cft>" + dockinv[i].Vol_CFT.ToString("F0") + "</tot_cft></invoice>";
                }
                strXMLInvoiceEntry += "</master_invoice_entry></root>";

                strXMLMasterEntry = strXMLMasterEntry.Replace("&", "&amp;");
                strXMLChargesEntry = strXMLChargesEntry.Replace("&", "&amp;");
                strXMLDocumentEntry = strXMLDocumentEntry.Replace("&", "&amp;");
                strXMLInvoiceEntry = strXMLInvoiceEntry.Replace("&", "&amp;");

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLdocketMasterEntry", strXMLMasterEntry, SqlDbType.NVarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@strXMLdocketChargesEntry", strXMLChargesEntry, SqlDbType.NVarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@strXMLdocketDocumentEntry", strXMLDocumentEntry, SqlDbType.NVarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@strXMLdocketInvoiceEntry", strXMLInvoiceEntry, SqlDbType.NVarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@dockno", dkt.DockNo, SqlDbType.NVarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.NVarChar);

                SqlConnection con;
                try
                {
                    con = new SqlConnection(SessionUtilities.ConnectionString);
                }
                catch (Exception ex)
                {
                    Exception excp = new Exception("Session Expired.");
                    throw excp;
                }

                con.Open();
                SqlTransaction trn = con.BeginTransaction();
                DataSet ds = new DataSet();
                try
                {
                    ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, "USP_DOCKET_ENTRY", paramsToStore);
                }
                catch (Exception excp)
                {
                    trn.Rollback();
                    con.Close();
                    con.Dispose();
                    throw excp;
                }

                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                }

                trn.Commit();
                con.Close();
                con.Dispose();
            }
            catch (Exception excp)
            {
                throw excp;
            }

            return dt;
        }

        public static DataTable MasterDocketEntryGSTWise(Docket dkt, DocketCharges charges, DocketDocument[] dockdoc, DocketInvoice[] dockinv, string finyear4d)
        {
            DataTable dt = new DataTable();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[6];

                if (dkt.DockDate < DateTime.MinValue || dkt.DockDate > DateTime.MaxValue)
                    dkt.DockDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.EDD <= DateTime.MinValue || dkt.EDD >= DateTime.MaxValue)
                    dkt.EDD = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitDate <= DateTime.MinValue || dkt.PermitDate >= DateTime.MaxValue)
                    dkt.PermitDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitRecieveDate <= DateTime.MinValue || dkt.PermitRecieveDate >= DateTime.MaxValue)
                    dkt.PermitRecieveDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PermitValidityDate <= DateTime.MinValue || dkt.PermitValidityDate >= DateTime.MaxValue)
                    dkt.PermitValidityDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.PolicyDate <= DateTime.MinValue || dkt.PolicyDate >= DateTime.MaxValue)
                    dkt.PolicyDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                if (dkt.InvoiceDate <= DateTime.MinValue || dkt.InvoiceDate >= DateTime.MaxValue)
                    dkt.InvoiceDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                string strXMLMasterEntry = "", strXMLChargesEntry = "", strXMLDocumentEntry = "", strXMLInvoiceEntry = "";
                strXMLMasterEntry = "<root><master_entry>"
                + "<dockno>" + dkt.DockNo + "</dockno>"
                + "<docksf>.</docksf>"
                + "<dockdt>" + dkt.DockDate.ToString("dd MMM yyyy") + "</dockdt>"
                + "<orgncd>" + dkt.OrgnLoc + "</orgncd>"
                + "<destcd>" + dkt.DelLoc + "</destcd>"
                + "<reassign_destcd>" + dkt.DelLoc + "</reassign_destcd>"
                + "<from_loc>" + dkt.FromCity + "</from_loc>"
                + "<to_loc>" + dkt.ToCity + "</to_loc>"
                + "<cdeldt>" + dkt.EDD.ToString("dd MMM yyyy") + "</cdeldt>"
                + "<paybas>" + dkt.PayBase + "</paybas>"
                + "<pkgsno>" + dkt.NoOfPkgs.ToString("F0") + "</pkgsno>"
                + "<actuwt>" + dkt.ActualWeight.ToString("F0") + "</actuwt>"
                + "<chrgwt>" + dkt.ChargedWeight.ToString("F0") + "</chrgwt>"
                + "<prodcd>" + dkt.ProdType + "</prodcd>"
                + "<spl_svc_req>" + dkt.Remarks + "</spl_svc_req>"
                + "<stax_paidby>" + dkt.STaxPaidBy + "</stax_paidby>"
                + "<stax_regno>" + dkt.STaxRegNo + "</stax_regno>"
                + "<service_class>" + dkt.ServiceType + "</service_class>"
                + "<ftl_types>" + dkt.FTLType + "</ftl_types>"
                + "<fincmplbr>" + dkt.BilledAt + "</fincmplbr>"
                + "<csgncd>" + dkt.ConsignorCode + "</csgncd>"
                + "<csgnnm>" + dkt.ConsignorName + "</csgnnm>"
                + "<csgnaddr>" + dkt.ConsignorAddress + "</csgnaddr>"
                + "<csgncity>" + dkt.ConsignorCity + "</csgncity>"
                + "<csgnpincode>" + dkt.ConsignorPinCode + "</csgnpincode>"
                + "<csgnteleno>" + dkt.ConsignorPhone + "</csgnteleno>"
                + "<csgnemail>" + dkt.ConsignorEmail + "</csgnemail>"
                + "<csgecd>" + dkt.ConsigneeCode + "</csgecd>"
                + "<csgenm>" + dkt.ConsigneeName + "</csgenm>"
                + "<csgeaddr>" + dkt.ConsigneeAddress + "</csgeaddr>"
                + "<csgecity>" + dkt.ConsigneeCity + "</csgecity>"
                + "<csgepincode>" + dkt.ConsigneePinCode + "</csgepincode>"
                + "<csgeteleno>" + dkt.ConsigneePhone + "</csgeteleno>"
                + "<csgeemail>" + dkt.ConsigneeEmail + "</csgeemail>"
                + "<party_code>" + dkt.PartyCode + "</party_code>"
                + "<privatemark>" + dkt.PrivateMark + "</privatemark>"
                + "<tpnumber>" + dkt.TPNumber + "</tpnumber>"
                + "<trn_mod>" + dkt.TransMode + "</trn_mod>"
                + "<cod_dod>" + dkt.FlagCODDOD + "</cod_dod>"
                + "<cft_yn>" + dkt.FlagVolumetric + "</cft_yn>"
                + "<diplomat>" + dkt.FlagODA + "</diplomat>"
                + "<dacc_yn>" + dkt.FlagDACC + "</dacc_yn>"
                + "<localcn_yn>" + dkt.FlagLocal + "</localcn_yn>"
                + "<pickup_dely>" + dkt.PickUpDel + "</pickup_dely>"
                + "<permit_yn>" + dkt.FlagPermit + "</permit_yn>"
                + "<permit_recvd_at>" + dkt.PermitRecievedAt + "</permit_recvd_at>"
                + "<permitdt>" + dkt.PermitDate.ToString("dd MMM yyyy") + "</permitdt>"
                + "<permit_recvd_dt>" + dkt.PermitRecieveDate.ToString("dd MMM yyyy") + "</permit_recvd_dt>"
                + "<permit_no>" + dkt.PermitNo + "</permit_no>"
                + "<permit_validity_dt>" + dkt.PermitValidityDate.ToString("dd MMM yyyy") + "</permit_validity_dt>"
                + "<entryby>" + dkt.EntryBy + "</entryby>"
                + "<pkgsty>" + dkt.PackType + "</pkgsty>"
                + "<insuyn>" + dkt.RiskType + "</insuyn>"
                + "<insupl>" + dkt.PolicyNo + "</insupl>"
                + "<insupldt>" + dkt.PolicyDate.ToString("dd MMM yyyy") + "</insupldt>"
                + "<ctr_no>" + dkt.CustomerRefNo + "</ctr_no>"
                + "<tot_modvat>" + dkt.ModvatCovers.ToString("F0") + "</tot_modvat>"
                + "<tot_covers>" + dkt.InternalCovers.ToString("F0") + "</tot_covers>"
                + "<codamt>" + dkt.CODDODAmount + "</codamt>"
                + "<businesstype>" + dkt.BusinessType + "</businesstype>"
                + "<loadtype>" + dkt.LoadType + "</loadtype>"
                + "<entrysheetno>" + dkt.EntrySheetNo + "</entrysheetno>"
                + "<obdno>" + dkt.OBDNo + "</obdno>"
                + "<bacode>" + dkt.BACode + "</bacode>"
                + "<dopino>" + dkt.DopiNo + "</dopino>"
                + "<edited>N</edited>"
                + "<editinfo></editinfo>"
                + "<stax_exmpt_yn>" + dkt.FlagStaxExmpt + "</stax_exmpt_yn>"
                + "<party_as>" + dkt.PartyAs + "</party_as>"
                + "<multipickup_yn>" + dkt.FlagMultiPickUp + "</multipickup_yn>"
                + "<multidelivery_yn>" + dkt.FlagMultiDelivery + "</multidelivery_yn>"
                + "<sourcedockno>" + dkt.SourceDockNo + "</sourcedockno>"
                + "<doctype>" + dkt.DocType + "</doctype>"
                + "<ctr_gpno>" + dkt.CustRefGPNo + "</ctr_gpno>"
                + "<ctr_delno>" + dkt.CustRefDelNo + "</ctr_delno>"
                + "<invno>" + dkt.InvoiceNo + "</invno>"
                + "<invdt>" + dkt.InvoiceDate.ToString("dd MMM yyyy") + "</invdt>"
                + "<invamt>" + dkt.InvoiceAmount.ToString("F0") + "</invamt>"
                /* Add GST wise Change */
               + "<GSTParty>" + dkt.GSTParty + "</GSTParty>"
               + "<GSTState>" + dkt.GSTState + "</GSTState>"
               + "<GSTIN>" + dkt.GSTIN + "</GSTIN>"
               + "<SACCategory>" + dkt.SACCategory + "</SACCategory>"
               + "<GSTServiceType>" + dkt.GSTServiceType + "</GSTServiceType>"
               + "<ISRCMApplicable>" + dkt.ISRCMApplicable + "</ISRCMApplicable>"
               + "<IsGSTPartyRegistered>" + dkt.IsGSTPartyRegistered + "</IsGSTPartyRegistered>"
               + "<IsGStDocumentScan>" + dkt.IsGStDocumentScan + "</IsGStDocumentScan>"
               + "<GSTRemark>" + dkt.GSTRemark + "</GSTRemark>"
               + "<SACCode>" + dkt.SACCode + "</SACCode>"
			   + "<GSTExempted>" + dkt.GSTExempted + "</GSTExempted>"
			   + "<GSTExemptionCategory>" + dkt.GSTExemptionCategory + "</GSTExemptionCategory>"
			   + "<PlaceOfSupply>" + dkt.PlaceOfSupply + "</PlaceOfSupply>"
               + "<EntryFrom>" + dkt.EntryFrom + "</EntryFrom>"
                /* Add GST wise Change */
                + "</master_entry></root>";


                strXMLChargesEntry = "<root><master_charges_entry>"
                + "<DOCKNO>" + charges.DockNo + "</DOCKNO>"
                + "<RATE_TYPE>" + charges.RateType + "</RATE_TYPE>"
                + "<FRT_RATE>" + charges.FreightRate + "</FRT_RATE>"
                + "<FREIGHT_CALC>" + charges.Freight.ToString("F2") + "</FREIGHT_CALC>"
                + "<FREIGHT>" + charges.Freight.ToString("F2") + "</FREIGHT>"
                + "<FOV>" + charges.Charges[11].ToString("F2") + "</FOV>"
                + "<SCHG01>" + charges.Charges[1].ToString("F2") + "</SCHG01>"
                + "<SCHG02>" + charges.Charges[2].ToString("F2") + "</SCHG02>"
                + "<SCHG03>" + charges.Charges[3].ToString("F2") + "</SCHG03>"
                + "<SCHG04>" + charges.Charges[4].ToString("F2") + "</SCHG04>"
                + "<SCHG05>" + charges.Charges[5].ToString("F2") + "</SCHG05>"
                + "<SCHG06>" + charges.Charges[6].ToString("F2") + "</SCHG06>"
                + "<SCHG07>" + charges.Charges[7].ToString("F2") + "</SCHG07>"
                + "<SCHG08>" + charges.Charges[8].ToString("F2") + "</SCHG08>"
                + "<SCHG09>" + charges.Charges[9].ToString("F2") + "</SCHG09>"
                + "<SCHG10>" + charges.Charges[10].ToString("F2") + "</SCHG10>"
                + "<SCHG11>" + charges.Charges[11].ToString("F2") + "</SCHG11>"
                + "<SCHG12>" + charges.Charges[12].ToString("F2") + "</SCHG12>"
                + "<SCHG13>" + charges.Charges[13].ToString("F2") + "</SCHG13>"
                + "<SCHG14>" + charges.Charges[14].ToString("F2") + "</SCHG14>"
                + "<SCHG15>" + charges.Charges[15].ToString("F2") + "</SCHG15>"
                + "<SCHG16>" + charges.Charges[16].ToString("F2") + "</SCHG16>"
                + "<SCHG17>" + charges.Charges[17].ToString("F2") + "</SCHG17>"
                + "<SCHG18>" + charges.Charges[18].ToString("F2") + "</SCHG18>"
                + "<SCHG19>" + charges.Charges[19].ToString("F2") + "</SCHG19>"
                + "<SCHG20>" + charges.Charges[20].ToString("F2") + "</SCHG20>"
                + "<SCHG21>" + charges.Charges[21].ToString("F2") + "</SCHG21>"
                + "<SCHG22>" + charges.Charges[22].ToString("F2") + "</SCHG22>"
                + "<SCHG23>" + charges.Charges[23].ToString("F2") + "</SCHG23>"
                + "<UCHG01>" + charges.Charges[24].ToString("F2") + "</UCHG01>"
                + "<UCHG02>" + charges.Charges[25].ToString("F2") + "</UCHG02>"
                + "<UCHG03>" + charges.Charges[26].ToString("F2") + "</UCHG03>"
                + "<UCHG04>" + charges.Charges[27].ToString("F2") + "</UCHG04>"
                + "<UCHG05>" + charges.Charges[28].ToString("F2") + "</UCHG05>"
                + "<UCHG06>" + charges.Charges[29].ToString("F2") + "</UCHG06>"
                + "<UCHG07>" + charges.Charges[30].ToString("F2") + "</UCHG07>"
                + "<UCHG08>" + charges.Charges[31].ToString("F2") + "</UCHG08>"
                + "<UCHG09>" + charges.Charges[32].ToString("F2") + "</UCHG09>"
                + "<UCHG10>" + charges.Charges[33].ToString("F2") + "</UCHG10>"
                + "<SUBTOTAL>" + charges.SubTotal.ToString("F2") + "</SUBTOTAL>"
                + "<SVCTAX>" + charges.ServiceTax.ToString("F2") + "</SVCTAX>"
                + "<ServiceTaxRate>" + charges.ServiceTaxRate.ToString("F2") + "</ServiceTaxRate>"
                + "<CESS>" + charges.EduCess.ToString("F2") + "</CESS>"
                + "<HEDU_CESS>" + charges.HEduCess.ToString("F2") + "</HEDU_CESS>"
                + "<DKTTOT>" + charges.DocketTotal.ToString("F2") + "</DKTTOT>"
                + "<Discount>" + charges.Discount.ToString("F2") + "</Discount>"
                + "<DiscountType>" + charges.DiscountType + "</DiscountType>"
                + "<DiscountRate>" + charges.DiscountRate.ToString("F2") + "</DiscountRate>"
                + "<ServiceTaxRate>" + charges.ServiceTaxRate.ToString("F2") + "</ServiceTaxRate>"
                /* SB Cess */
                + "<SbcRate>" + charges.SbcRate.ToString("F2") + "</SbcRate>"
                + "<SBCess>" + charges.SBCess.ToString("F2") + "</SBCess>"
                /* SB Cess */
                /* KK Cess */
                + "<KKCessRate>" + charges.KKCessRate.ToString("F2") + "</KKCessRate>"
                + "<KKCess>" + charges.KKCess.ToString("F2") + "</KKCess>"
                /* KK Cess */
                /* Add GST wise Change */
                + "<GSTRate>" + charges.GSTRate.ToString("F2") + "</GSTRate>"
                + "<GSTAmount>" + charges.GSTAmount.ToString("F2") + "</GSTAmount>"
                + "<GSTCharged>" + charges.GSTCharged.ToString("F2") + "</GSTCharged>"
                /* Add GST wise Change */
                + "</master_charges_entry></root>";

                //, strXMLInvoiceEntry = "";
                strXMLDocumentEntry = "<root><master_document_entry>";
                for (int i = 0; i < dockdoc.Length; i++)
                {
                    strXMLDocumentEntry += "<document>"
                    + "<dockno>" + dockdoc[i].DockNo + "</dockno>"
                    + "<docksf>" + dockdoc[i].DockSF + "</docksf>"
                    + "<srno>1</srno>"
                    + "<documentno>" + dockdoc[i].DocumentNo + "</documentno></document>";
                }
                strXMLDocumentEntry += "</master_document_entry></root>";


                strXMLInvoiceEntry = "";
                strXMLInvoiceEntry = "<root><master_invoice_entry>";
                for (int i = 0; i < dockinv.Length; i++)
                {
                    strXMLInvoiceEntry += "<invoice>"
                    + "<dockno>" + dockinv[i].DockNo + "</dockno>"
                    + "<invno>" + dockinv[i].InvoiceNo + "</invno>";

                    if (dockinv[i].InvoiceDate <= DateTime.MinValue || dockinv[i].InvoiceDate >= DateTime.MaxValue)
                        dockinv[i].InvoiceDate = WebXConvert.ToDateTime("01/01/1990", "en-GB");

                    strXMLInvoiceEntry += "<invdt>" + dockinv[i].InvoiceDate.ToString("dd MMM yyyy") + "</invdt>"
                        + "<declval>" + dockinv[i].DeclaredValue.ToString("F0") + "</declval>"
                        + "<pkgsno>" + dockinv[i].NoOfPkgs.ToString("F0") + "</pkgsno>"
                        + "<actuwt>" + dockinv[i].ActualWeight.ToString("F0") + "</actuwt>"
                        + "<vol_l>" + dockinv[i].Vol_Length.ToString("F0") + "</vol_l>"
                        + "<vol_b>" + dockinv[i].Vol_Breadth.ToString("F0") + "</vol_b>"
                        + "<vol_h>" + dockinv[i].Vol_Height.ToString("F0") + "</vol_h>"
                        + "<tot_cft>" + dockinv[i].Vol_CFT.ToString("F0") + "</tot_cft></invoice>";
                }
                strXMLInvoiceEntry += "</master_invoice_entry></root>";

                strXMLMasterEntry = strXMLMasterEntry.Replace("&", "&amp;");
                strXMLChargesEntry = strXMLChargesEntry.Replace("&", "&amp;");
                strXMLDocumentEntry = strXMLDocumentEntry.Replace("&", "&amp;");
                strXMLInvoiceEntry = strXMLInvoiceEntry.Replace("&", "&amp;");

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLdocketMasterEntry", strXMLMasterEntry, SqlDbType.NVarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@strXMLdocketChargesEntry", strXMLChargesEntry, SqlDbType.NVarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@strXMLdocketDocumentEntry", strXMLDocumentEntry, SqlDbType.NVarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@strXMLdocketInvoiceEntry", strXMLInvoiceEntry, SqlDbType.NVarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@dockno", dkt.DockNo, SqlDbType.NVarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@finyear4d", finyear4d, SqlDbType.NVarChar);

                SqlConnection con;
                try
                {
                    con = new SqlConnection(SessionUtilities.ConnectionString);
                }
                catch (Exception ex)
                {
                    Exception excp = new Exception("Session Expired.");
                    throw excp;
                }

                con.Open();
                SqlTransaction trn = con.BeginTransaction();
                DataSet ds = new DataSet();
                try
                {
                    ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, "USP_DOCKET_ENTRY_GSTWise", paramsToStore);
                }
                catch (Exception excp)
                {
                    trn.Rollback();
                    con.Close();
                    con.Dispose();
                    throw excp;
                }

                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                }

                trn.Commit();
                con.Close();
                con.Dispose();
            }
            catch (Exception excp)
            {
                throw excp;
            }

            return dt;
        }


        public static bool DocketChargesEntry(DocketCharges docketcharges, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[42];

                paramsToStore[0] = new SqlParameter("@DOCKNO", SqlDbType.VarChar);
                paramsToStore[0].Value = docketcharges.DockNo;
                paramsToStore[0].Size = 50;
                paramsToStore[1] = new SqlParameter("@RATE_TYPE", SqlDbType.Char);
                paramsToStore[1].Value = docketcharges.RateType;
                paramsToStore[1].Size = 1;
                paramsToStore[2] = new SqlParameter("@FRT_RATE", SqlDbType.Decimal);
                paramsToStore[2].Value = docketcharges.FreightRate;
                paramsToStore[3] = new SqlParameter("@FREIGHT", SqlDbType.Decimal);
                paramsToStore[3].Value = docketcharges.Freight;
                paramsToStore[4] = new SqlParameter("@SCHG01", SqlDbType.Decimal);
                paramsToStore[4].Value = docketcharges.Charges[1];
                paramsToStore[5] = new SqlParameter("@SCHG02", SqlDbType.Decimal);
                paramsToStore[5].Value = docketcharges.Charges[2];
                paramsToStore[6] = new SqlParameter("@SCHG03", SqlDbType.Decimal);
                paramsToStore[6].Value = docketcharges.Charges[3];
                paramsToStore[7] = new SqlParameter("@SCHG04", SqlDbType.Decimal);
                paramsToStore[7].Value = docketcharges.Charges[4];
                paramsToStore[8] = new SqlParameter("@SCHG05", SqlDbType.Decimal);
                paramsToStore[8].Value = docketcharges.Charges[5];
                paramsToStore[9] = new SqlParameter("@SCHG06", SqlDbType.Decimal);
                paramsToStore[9].Value = docketcharges.Charges[6];
                paramsToStore[10] = new SqlParameter("@SCHG07", SqlDbType.Decimal);
                paramsToStore[10].Value = docketcharges.Charges[7];
                paramsToStore[11] = new SqlParameter("@SCHG08", SqlDbType.Decimal);
                paramsToStore[11].Value = docketcharges.Charges[8];
                paramsToStore[12] = new SqlParameter("@SCHG09", SqlDbType.Decimal);
                paramsToStore[12].Value = docketcharges.Charges[9];
                paramsToStore[13] = new SqlParameter("@SCHG10", SqlDbType.Decimal);
                paramsToStore[13].Value = docketcharges.Charges[10];
                paramsToStore[14] = new SqlParameter("@SCHG11", SqlDbType.Decimal);
                paramsToStore[14].Value = docketcharges.Charges[11];
                paramsToStore[15] = new SqlParameter("@SCHG12", SqlDbType.Decimal);
                paramsToStore[15].Value = docketcharges.Charges[12];
                paramsToStore[16] = new SqlParameter("@SCHG13", SqlDbType.Decimal);
                paramsToStore[16].Value = docketcharges.Charges[13];
                paramsToStore[17] = new SqlParameter("@SCHG14", SqlDbType.Decimal);
                paramsToStore[17].Value = docketcharges.Charges[14];
                paramsToStore[18] = new SqlParameter("@SCHG15", SqlDbType.Decimal);
                paramsToStore[18].Value = docketcharges.Charges[15];
                paramsToStore[19] = new SqlParameter("@SCHG16", SqlDbType.Decimal);
                paramsToStore[19].Value = docketcharges.Charges[16];
                paramsToStore[20] = new SqlParameter("@SCHG17", SqlDbType.Decimal);
                paramsToStore[20].Value = docketcharges.Charges[17];
                paramsToStore[21] = new SqlParameter("@SCHG18", SqlDbType.Decimal);
                paramsToStore[21].Value = docketcharges.Charges[18];
                paramsToStore[22] = new SqlParameter("@SCHG19", SqlDbType.Decimal);
                paramsToStore[22].Value = docketcharges.Charges[19];
                paramsToStore[23] = new SqlParameter("@SCHG20", SqlDbType.Decimal);
                paramsToStore[23].Value = docketcharges.Charges[20];
                paramsToStore[24] = new SqlParameter("@SCHG21", SqlDbType.Decimal);
                paramsToStore[24].Value = docketcharges.Charges[21];
                paramsToStore[25] = new SqlParameter("@SCHG22", SqlDbType.Decimal);
                paramsToStore[25].Value = docketcharges.Charges[22];
                paramsToStore[26] = new SqlParameter("@SCHG23", SqlDbType.Decimal);
                paramsToStore[26].Value = docketcharges.Charges[23];
                paramsToStore[27] = new SqlParameter("@UCHG01", SqlDbType.Decimal);
                paramsToStore[27].Value = docketcharges.Charges[24];
                paramsToStore[28] = new SqlParameter("@UCHG02", SqlDbType.Decimal);
                paramsToStore[28].Value = docketcharges.Charges[25];
                paramsToStore[29] = new SqlParameter("@UCHG03", SqlDbType.Decimal);
                paramsToStore[29].Value = docketcharges.Charges[26];
                paramsToStore[30] = new SqlParameter("@UCHG04", SqlDbType.Decimal);
                paramsToStore[30].Value = docketcharges.Charges[27];
                paramsToStore[31] = new SqlParameter("@UCHG05", SqlDbType.Decimal);
                paramsToStore[31].Value = docketcharges.Charges[28];
                paramsToStore[32] = new SqlParameter("@UCHG06", SqlDbType.Decimal);
                paramsToStore[32].Value = docketcharges.Charges[29];
                paramsToStore[33] = new SqlParameter("@UCHG07", SqlDbType.Decimal);
                paramsToStore[33].Value = docketcharges.Charges[30];
                paramsToStore[34] = new SqlParameter("@UCHG08", SqlDbType.Decimal);
                paramsToStore[34].Value = docketcharges.Charges[31];
                paramsToStore[35] = new SqlParameter("@UCHG09", SqlDbType.Decimal);
                paramsToStore[35].Value = docketcharges.Charges[32];
                paramsToStore[36] = new SqlParameter("@UCHG10", SqlDbType.Decimal);
                paramsToStore[36].Value = docketcharges.Charges[33];
                paramsToStore[37] = new SqlParameter("@SubTotal", SqlDbType.Decimal);
                paramsToStore[37].Value = docketcharges.SubTotal;
                paramsToStore[38] = new SqlParameter("@SVCTAX", SqlDbType.Decimal);
                paramsToStore[38].Value = docketcharges.ServiceTax;
                paramsToStore[39] = new SqlParameter("@CESS", SqlDbType.Decimal);
                paramsToStore[39].Value = docketcharges.EduCess;
                paramsToStore[40] = new SqlParameter("@H_CESS", SqlDbType.Decimal);
                paramsToStore[40].Value = docketcharges.HEduCess;
                paramsToStore[41] = new SqlParameter("@DKTTOT", SqlDbType.Decimal);
                paramsToStore[41].Value = docketcharges.DocketTotal;

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_docket_Charges_entry", paramsToStore);

            }
            catch (Exception excp)
            {
                throw excp;
                return false;
            }
            return true;
        }
        public static bool InvoiceEntry(DocketInvoice dockinv, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[10];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@DOCKNO", dockinv.DockNo, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@INVNO", dockinv.InvoiceNo, SqlDbType.VarChar);
                if (dockinv.InvoiceDate > DateTime.MinValue && dockinv.InvoiceDate < DateTime.MaxValue)
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@invdt", dockinv.InvoiceDate, SqlDbType.DateTime);
                else
                    paramsToStore[2] = ControllersHelper.GetSqlParameter("@invdt", DBNull.Value);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@DECLVAL", dockinv.DeclaredValue.ToString("00"));
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@PKGSNO", dockinv.NoOfPkgs, SqlDbType.Decimal);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@ACTUWT", dockinv.ActualWeight, SqlDbType.Decimal);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@VOL_L", dockinv.Vol_Length, SqlDbType.Decimal);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@VOL_B", dockinv.Vol_Breadth, SqlDbType.Decimal);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@VOL_H", dockinv.Vol_Height, SqlDbType.Decimal);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@TOT_CFT", dockinv.Vol_CFT, SqlDbType.Decimal);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_docket_Invoice_entry", paramsToStore);
            }
            catch (Exception excp)
            {
                throw excp;
                return false;
            }

            return true;
        }
        public static bool DocumentEntry(DocketDocument dockdoc, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[4];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@DOCKNO", dockdoc.DockNo, SqlDbType.VarChar);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@DOCKSF", dockdoc.DockSF, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@SRNO", dockdoc.SRNo, SqlDbType.Decimal);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@DOCUMENTNO", dockdoc.DocumentNo, SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_docket_state_document_entry", paramsToStore);
            }
            catch (Exception excp)
            {
                throw excp;
                return false;
            }
            return true;
        }
        public static bool BACalculationEntry(Docket docket, DocketCharges docketcharges, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[24];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@dockno", docket.DockNo, SqlDbType.VarChar);
                if (docket.DockDate > DateTime.MinValue && docket.DockDate < DateTime.MaxValue)
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@dockdate", docket.DockDate, SqlDbType.DateTime);
                else
                    paramsToStore[1] = ControllersHelper.GetSqlParameter("@dockdate", DBNull.Value);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@paybas", docket.PayBase, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@orgnloc", docket.OrgnLoc, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@delloc", docket.DelLoc, SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@transmode", docket.TransMode, SqlDbType.VarChar);
                paramsToStore[6] = ControllersHelper.GetSqlParameter("@csgncd", docket.ConsignorCode, SqlDbType.VarChar);
                paramsToStore[7] = ControllersHelper.GetSqlParameter("@csgnname", docket.ConsignorName, SqlDbType.VarChar);
                paramsToStore[8] = ControllersHelper.GetSqlParameter("@csgecd", docket.ConsigneeCode, SqlDbType.VarChar);
                paramsToStore[9] = ControllersHelper.GetSqlParameter("@csgename", docket.ConsigneeName, SqlDbType.VarChar);
                paramsToStore[10] = ControllersHelper.GetSqlParameter("@noofpkgs", docket.NoOfPkgs, SqlDbType.Decimal);
                paramsToStore[11] = ControllersHelper.GetSqlParameter("@actualweight", docket.ActualWeight, SqlDbType.Decimal);
                paramsToStore[12] = ControllersHelper.GetSqlParameter("@chargedweight", docket.ChargedWeight, SqlDbType.Decimal);
                paramsToStore[13] = ControllersHelper.GetSqlParameter("@servicetype", docket.ServiceType, SqlDbType.VarChar);
                paramsToStore[14] = ControllersHelper.GetSqlParameter("@bacode", docket.BACode, SqlDbType.VarChar);
                paramsToStore[15] = ControllersHelper.GetSqlParameter("@freight", docketcharges.Freight, SqlDbType.Decimal);
                paramsToStore[16] = ControllersHelper.GetSqlParameter("@subtotal", docketcharges.SubTotal, SqlDbType.Decimal);
                paramsToStore[17] = ControllersHelper.GetSqlParameter("@svctax", docketcharges.ServiceTax, SqlDbType.Decimal);
                paramsToStore[18] = ControllersHelper.GetSqlParameter("@educess", docketcharges.EduCess, SqlDbType.Decimal);
                paramsToStore[19] = ControllersHelper.GetSqlParameter("@heducess", docketcharges.HEduCess, SqlDbType.Decimal);
                paramsToStore[20] = ControllersHelper.GetSqlParameter("@dockettotal", docketcharges.DocketTotal, SqlDbType.Decimal);
                paramsToStore[21] = ControllersHelper.GetSqlParameter("@mrno", docket.MRNo, SqlDbType.VarChar);
                paramsToStore[22] = ControllersHelper.GetSqlParameter("@entryby", docket.EntryBy, SqlDbType.VarChar);
                if (docket.EntryDate > DateTime.MinValue && docket.EntryDate < DateTime.MaxValue)
                    paramsToStore[23] = ControllersHelper.GetSqlParameter("@entrydate", docket.EntryDate, SqlDbType.DateTime);
                else
                    paramsToStore[23] = ControllersHelper.GetSqlParameter("@entrydate", DBNull.Value);
                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_ba_calculation_entry", paramsToStore);

            }
            catch (Exception excp)
            {
                throw excp;
                return false;
            }
            return true;
        }

        public static bool DocketAccountEntry(string dockno, string finyear4d, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transno", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docno", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear4d, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Acc_Instance", "01", SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@Entry_Cancel", "E", SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_DOCKET_TRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return true;
        }

	public static bool DocketAccountEntryNew(string dockno, string finyear4d, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transno", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docno", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear4d, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Acc_Instance", "01", SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@Entry_Cancel", "E", SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "usp_Docket_Transaction_Adjustment", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return true;
        }

        public static bool PaidAccountEntry(string dockno, string finyear, string employee, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transno", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docno", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@entryby1", employee, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@nextvoucherno", "", SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_PAIDMRTRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return true;
        }

        public static bool TBBAccountEntry(string dockno, string finyear, string employee, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[5];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transno", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docno", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@entryby1", employee, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@nextvoucherno", "", SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_TBB_TRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return true;
        }

        public static bool ToPayAccountEntry(string dockno, string finyear, string employee, SqlTransaction trn)
        {
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[6];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transno", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docno", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@docsf", ".", SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[4] = ControllersHelper.GetSqlParameter("@entryby1", employee, SqlDbType.VarChar);
                paramsToStore[5] = ControllersHelper.GetSqlParameter("@nextvoucherno", "", SqlDbType.VarChar);

                SqlHelper.ExecuteNonQuery(trn, CommandType.StoredProcedure, "USP_TOPAYMRTRANSACTION", paramsToStore);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return true;
        }

        public static string DocketPaidToPayBill(string dockno, string finyear, SqlTransaction trn)
        {
            string billno = "";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[4];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transNo", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docNo", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Acc_Instance", "01", SqlDbType.VarChar);

                billno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_PAID_TOPAY_BILLGENERATION", paramsToStore));

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return billno;
        }
        public static string DocketPaidToPayBill(string dockno, string finyear, string accinstance, SqlTransaction trn)
        {
            string billno = "";
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[4];

                paramsToStore[0] = ControllersHelper.GetSqlParameter("@transNo", 1, SqlDbType.Int);
                paramsToStore[1] = ControllersHelper.GetSqlParameter("@docNo", dockno, SqlDbType.VarChar);
                paramsToStore[2] = ControllersHelper.GetSqlParameter("@finyear", finyear, SqlDbType.VarChar);
                paramsToStore[3] = ControllersHelper.GetSqlParameter("@Acc_Instance", accinstance, SqlDbType.VarChar);

                billno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.StoredProcedure, "USP_PAID_TOPAY_BILLGENERATION", paramsToStore));

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return billno;
        }

        /// <summary>
        /// Gets Docket Charges From DataBase
        /// </summary>
        /// <param name="dockno">Docket Number</param>
        /// <returns>Charges Object</returns>
        public static DocketCharges GetDocketCharges(string dockno)
        {
            DocketCharges chrg = new DocketCharges();
            string sqlstr = "SELECT * FROM webx_master_docket_charges WHERE dockno='" + dockno + "'";
            DataTable dt = new DataTable();
            try
            {
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            }
            catch (Exception ex) { }

            if (dt.Rows.Count > 0)
            {
                for (int i = 1; i < 24; i++)
                {
                    chrg.Charges[i] = DocketController.ToDouble(dt.Rows[0]["SCHG" + i.ToString().PadLeft(2, '0')]);
                }

                for (int i = 24; i < 34; i++)
                {
                    chrg.Charges[i] = DocketController.ToDouble(dt.Rows[0]["UCHG" + Convert.ToString((i - 23)).PadLeft(2, '0')]);
                }

                chrg.DocketTotal = DocketController.ToDouble(dt.Rows[0]["dkttot"].ToString());
                chrg.DockNo = dockno;
                chrg.EduCess = DocketController.ToDouble(dt.Rows[0]["cess"].ToString());
                chrg.Freight = DocketController.ToDouble(dt.Rows[0]["freight"].ToString());
                chrg.FreightRate = DocketController.ToDouble(dt.Rows[0]["frt_rate"]);
                chrg.HEduCess = DocketController.ToDouble(dt.Rows[0]["hedu_cess"]);
                chrg.RateType = Convert.ToString(dt.Rows[0]["rate_type"]);
                chrg.ServiceTax = DocketController.ToDouble(dt.Rows[0]["svc_tax"]);
                chrg.SubTotal = DocketController.ToDouble(dt.Rows[0]["suttotal"]);
            }
            return chrg;
        }

        public static bool UpdateDCRCount(string dockno, SqlTransaction trn)
        {
            try
            {
                string sqlstr = "UPDATE webx_dcr_header SET used=ISNULL(used,0)+1 ";
                sqlstr = sqlstr + " WHERE '" + dockno + "' BETWEEN doc_sr_from AND doc_sr_to ";
                sqlstr = sqlstr + " AND LEN('" + dockno + "')=LEN(doc_sr_from) ";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return true;
        }

        #endregion

        #region GST
        /* Add GST wise Change */
        public static DataSet GetGSTDetails(DocketGSTDetails dst)
        {
            using (var dbObject = new WebXHelper())
            {
                var dtGstData = dbObject.ExecuteDataSet(CommandType.StoredProcedure, "USP_GET_GSTDETAILSBYCUSTOMER_V2",
                   new[] {
                    new SqlParameter("@GSTPaymentPartyCode",dst.GSTPaymentPartyCode),
                    new SqlParameter("@GSTProduct",dst.GSTProductID),
                    new SqlParameter("@PayBase",dst.GSTPayBaseId),
                    new SqlParameter("@FromCityId",dst.FromCityId),
                    new SqlParameter("@DestinatonCity",dst.DestinatonCity),
                    new SqlParameter("@BookingBranch",dst.BookingBranch),
                    new SqlParameter("@DestinatonionBranch",dst.DestinatonionBranch),
                    new SqlParameter("@BilledAtBranch",dst.BilledAtBranch),
                    new SqlParameter("@PartyAs",dst.PartyAs),
                    new SqlParameter("@ChangedStateId",dst.ChangedStateId),
                    new SqlParameter("@Module",dst.Module),
                   });
                return dtGstData;
            }

        }

        public static DataSet GSTCustomerDetailsInsert(CustomerGSTDetail dst)
        {

            /*If customer not exists then create new one. */
            if (dst.CUSTCD == "")
            {
                CustomerMasterController objCustomerMaster = new CustomerMasterController();
                int intCustCode = 1;
                string strCustCode = string.Empty;
                intCustCode = objCustomerMaster.getNextSecondoryCustomerCode(dst.GRPCD);
                strCustCode = dst.GRPCD + intCustCode.ToString().PadLeft(4, '0');
                dst.CUSTCD = strCustCode;
            }


            using (var dbObject = new WebXHelper())
            {
                var dtGstData = dbObject.ExecuteDataSet(CommandType.StoredProcedure, "USP_GST_CUSTOMERANDGST_DETAIL_INSERT_V2",
                   new[] {
                        new SqlParameter("@CUSTCD",dst.CUSTCD),
                        new SqlParameter("@GRPCD",dst.GRPCD),
                        new SqlParameter("@CUSTNM",dst.CUSTNM),
                        new SqlParameter("@CUSTPASS",dst.CUSTPASS),
                        new SqlParameter("@CUSTCAT",dst.CUSTCAT),
                        new SqlParameter("@BookingBranch",dst.BookingBranch),

                        new SqlParameter("@ServiceOptFor",dst.ServiceOptFor),
                        new SqlParameter("@entryby",SessionUtilities.CurrentEmployeeID),
                        //new SqlParameter("@GSTBillingState",dst.GSTBillingState),
                        //new SqlParameter("@GSTBillingCity",dst.GSTBillingCity),
                        new SqlParameter("@CGSTnumber",dst.CGSTnumber),
                        new SqlParameter("@IGSTnumber",dst.IGSTnumber),

                        new SqlParameter("@GSTBillingAddress",dst.GSTBillingAddress),
                        new SqlParameter("@BillingStateCode",dst.BillingStateCode),
                        new SqlParameter("@BillingAddress",dst.BillingAddress),
                        new SqlParameter("@BillingCityCode",dst.BillingCityCode),
                        new SqlParameter("@ProvisionalNumber",dst.ProvisionalNumber),
                        new SqlParameter("@GSTINNumber",dst.GSTINNumber),
                        new SqlParameter("@DeclarationFile",dst.DeclarationFile),
                        new SqlParameter("@GSTPincode",dst.GstPincode),
                   });
                return dtGstData;
            }
        }
        #endregion
        /* Add GST wise Change */
		
		/*Min Max Docket Total Validation From Contract */
        public static DataTable GetMinMaxDocketTotalByContractId(string ContractID)
        {
            var dt = new DataTable();
            try
            {
                SqlParameter[] paramsToStore = new SqlParameter[1];
                paramsToStore[0] = ControllersHelper.GetSqlParameter("@ContractID", ContractID, SqlDbType.VarChar);
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "USE_CustomerContract_GetMinMaxDocketTotal", paramsToStore).Tables[0];
            }
            catch (Exception excp)
            {
                throw excp;
            }
            return dt;
        }
    }
} // END OF DOCKET CONTROLLER
