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

/// <summary>
/// Summary description for TaxRateController
/// </summary>
namespace WebX.Controllers
{
    public class TaxRateController
    {
        public TaxRateController()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static double GetServiceTaxRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(svctax_rate,0) AS servicetaxrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double servicetaxrate;
            try
            {
                servicetaxrate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return servicetaxrate;
        }

        public static double GetEduCessRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(edu_cess_rate,0) AS educessrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double educessrate;
            try
            {
                educessrate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return educessrate;
        }

        public static double GetHEduCessRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(hedu_cess_rate,0) AS heducessrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double heducessrate;
            try
            {
                heducessrate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return heducessrate;
        }
        public static double GetSwachhBharatCessRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(SbcRate,0) AS servicetaxrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double SbcRate;
            try
            {
                SbcRate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return SbcRate;
        }
        public static double GetKrushiKalyanCessRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(KKCessRate,0) AS servicetaxrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double KKCessRate;
            try
            {
                KKCessRate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return KKCessRate;
        }
        public static double GetAfterRebateRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(after_rebate_per,0) AS servicetaxrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double after_rebate_per;
            try
            {
                after_rebate_per = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return after_rebate_per;
        }
 public static double GetSBCessRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(SbcRate,0) AS sbcessrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double sbcessrate;
            try
            {
                sbcessrate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return sbcessrate;
        }
        public static double GetKKCessRate(DateTime date)
        {
            string sqlstr = "SELECT TOP 1 ISNULL(KKCessRate,0) AS kkcessrate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";

            double kkcessrate;
            try
            {
                kkcessrate = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return kkcessrate;
        }
        public static TaxRate GetTaxObject(TaxRate trate)
        {
            /* SB cess */
            string sqlstr = "SELECT TOP 1 ISNULL(svctax_rate,0) AS servicetaxrate,";
            sqlstr = sqlstr + " ISNULL(edu_cess_rate,0) AS educessrate,ISNULL(after_rebate_per,0) AS rebatedrate,";
            sqlstr = sqlstr + " ISNULL(hedu_cess_rate,0) AS heducessrate,SbcRate,KKCessRate FROM webx_chargemst ";
            sqlstr = sqlstr + " WHERE '" + trate.Date.ToString("dd MMM yyyy") + "' BETWEEN startdate AND enddate";
            /* SB cess */

            DataTable dt;
            try
            {
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }

            try
            {
                trate.ServiceTaxRate = Convert.ToDouble(dt.Rows[0]["servicetaxrate"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            try
            {
                trate.EduCessRate = Convert.ToDouble(dt.Rows[0]["educessrate"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            try
            {
                trate.HEduCessRate = Convert.ToDouble(dt.Rows[0]["heducessrate"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            try
            {
                trate.AfterRebatePer = Convert.ToDouble(dt.Rows[0]["rebatedrate"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            /* SB Cess */
            try
            {
                trate.SbcRate = Convert.ToDouble(dt.Rows[0]["SbcRate"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            /* SB Cess */
            /* KK Cess */
            try
            {
                trate.KKCessRate = Convert.ToDouble(dt.Rows[0]["KKCessRate"]);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            /* KK Cess */
            return trate;
        }
    }
}
