using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Microsoft.ApplicationBlocks.Data;
//using dataservices;

/// <summary>
/// Docket Entry Rules 
/// </summary>
[Serializable]
public class DocketRules
{
    private string _code = "";
    private string _description = "";
    private string _defaultvalue = "";
    private int _minvalue = 0;
    private int _maxvalue = 0;
    private string _paybas = "";
    private string _activeflag = "";
    private string _enabled = "";

    public string code { get { return _code; } set { _code = value; } }
    public string description { get { return _description; } set { _description = value; } }
    public string defaultvalue { get { return _defaultvalue; } set { _defaultvalue = value; } }
    public int minvalue { get { return _minvalue; } set { _minvalue = value; } }
    public int maxvalue { get { return _maxvalue; } set { _maxvalue = value; } }
    public string paybas { get { return _paybas; } set { _paybas = value; } }
    public string activeflag { get { return _activeflag; } set { _activeflag = value; } }
    public string enabled { get { return _enabled; } set { _enabled = value; } }

    public DocketRules()
    {
        //
        // TODO: Add constructor logic here
        //        
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="dr"></param>
    /// <returns></returns>
    public static DocketRules FillObject(DataRow dr)
    {
        DocketRules objRD = new DocketRules();

        if (dr[(int)DocketRules_Columns.code] != DBNull.Value)
            objRD.code = dr[(int)DocketRules_Columns.code].ToString();
        if (dr[(int)DocketRules_Columns.description] != DBNull.Value)
            objRD.description = dr[(int)DocketRules_Columns.description].ToString();
        if (dr[(int)DocketRules_Columns.defaultvalue] != DBNull.Value)
            objRD.defaultvalue = dr[(int)DocketRules_Columns.defaultvalue].ToString();
        if (dr[(int)DocketRules_Columns.activeflag] != DBNull.Value)
            objRD.activeflag = dr[(int)DocketRules_Columns.activeflag].ToString();
        if (dr[(int)DocketRules_Columns.enabled] != DBNull.Value)
            objRD.enabled = dr[(int)DocketRules_Columns.enabled].ToString();
        if (dr[(int)DocketRules_Columns.minvalue] != DBNull.Value)
            objRD.minvalue = Convert.ToInt32(dr[(int)DocketRules_Columns.minvalue]);
        if (dr[(int)DocketRules_Columns.maxvalue] != DBNull.Value)
            objRD.maxvalue = Convert.ToInt32(dr[(int)DocketRules_Columns.maxvalue]);

        return objRD;
    }

    public static DocketRules GetByCode(string code)
    {
        DocketRules objDR = new DocketRules();

        try
        {
            string cmd = string.Format("SELECT * FROM webx_rules_docket where code='{0}'", code);

            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                objDR = FillObject(dt.Rows[0]);
            }
        }
        catch (Exception ex)
        {

        }
        return objDR;
    }
    /// <summary>
    /// Get default value of Rule, Payment Basis Wise
    /// </summary>
    /// <param name="code">Rule Code</param>
    /// <param name="paybas">Payment Basis</param>
    /// <returns>string : Default value of Rule</returns>
    public static string GetDefaultValue(string code, string paybas)
    {
        string defaultvalue = "";
        try
        {
            string strsql = "SELECT ISNULL(defaultvalue,'Y') FROM webx_rules_docket WHERE code='" + code + "' AND paybas='" + paybas + "'";
            defaultvalue = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        }
        catch (Exception ex)
        {

        }
        return defaultvalue;
    }

    /// <summary>
    /// Get default value of Rule, without Payment Basis
    /// </summary>
    /// <param name="code">Rule Code</param>
    /// <returns>string : Default value of Rule</returns>
    public static string GetDefaultValue(string code)
    {
        string defaultvalue = "";
        try
        {
            string strsql = "SELECT ISNULL(defaultvalue,'Y') FROM webx_rules_docket WHERE code='" + code + "'";
            defaultvalue = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        }
        catch (Exception ex)
        {

        }
        return defaultvalue;
    }

    /// <summary>
    /// Get Enable value of Rule,Payment Basis Wise
    /// </summary>
    /// <param name="code">Rule Code</param>
    /// <param name="paybas">Payment Basis</param>
    /// <returns>string : Default value of Rule</returns>
    public static string GetEnableValue(string code)
    {
        string enabled = "N";
        string strsql = "SELECT ISNULL(enabled,'E') FROM webx_rules_docket WHERE code='" + code + "'";
        enabled = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql));
        return enabled;
    }

    
    /// <summary>
    /// Get Enable value of Rule,without Payment Basis
    /// </summary>
    /// <param name="code">Rule Code</param>
    /// <returns>string : Default value of Rule</returns>
    public static string GetEnableValue(string code, string paybas)
    {
        string enabled = "N";
        string strsql = "SELECT ISNULL(enabled,'E') FROM webx_rules_docket WHERE code='" + code + "' AND paybas='" + paybas + "'";
        enabled = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString,CommandType.Text,strsql));
        return enabled;
    }

    public static List<DocketRules> GetAll()
    {
        List<DocketRules> ListDR = new List<DocketRules>();
        try
        {
            DocketRules objDR = new DocketRules();
            string cmd = "SELECT * FROM webx_rules_docket";

            DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, cmd).Tables[0];

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    objDR = FillObject(dr);
                    if (objDR.code != "")
                    { ListDR.Add(objDR); }
                }
            }
        }
        catch (Exception ex)
        {
        }
        return ListDR;
    }

 
}
public enum DocketRules_Columns
{
    code = 0,
    description,
    defaultvalue,
    minvalue,
    maxvalue,
    paybas,
    activeflag,
    enabled
}
