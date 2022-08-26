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

/// <summary>
/// Summary description for FM_Utility
/// </summary>
public class FMUtility
{
    #region Constants

    public const string FMDocumentDirectory = @"FMDocuments";
    public const string POD = "1";
    public const string Bill = "2";
    public const string COD_DOD = "4";
    public const string Octroi = "3";

    #endregion

    #region Constructer
    public FMUtility()
	{
		//
		// TODO: Add constructor logic here
		//
    }
    #endregion    

    #region Public Methods

    public static void BindFMDocTypes(DropDownList ddl, string selectedValue)
    {
        string connStr = GetConnectionString();
        BindDropDown(ddl, GetDocTypes("CodeDesc"), "CodeDesc", "CodeId", "Select", "", 0, selectedValue);
    }

    public static void BindPayBas(DropDownList ddl, string selectedValue)
    {
        string connStr = GetConnectionString();
        string cmd = "select CodeId,CodeDesc from webx_master_general  where codetype='paytyp' and  statuscode='Y' Order By CodeDesc";
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
        BindDropDown(ddl, ds.Tables[0], "CodeDesc", "CodeId", "All", "All", 0, selectedValue);
    }
    public static void BindBillPayBas(DropDownList ddl, string selectedValue)
    {
        string connStr = GetConnectionString();
        string cmd = "select CodeId,CodeDesc from webx_master_general  where codetype='billtyp' and  statuscode='Y' Order By CodeDesc";
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
        BindDropDown(ddl, ds.Tables[0], "CodeDesc", "CodeId", "All", "All", 0, selectedValue);
    }

    public static void BindLocation(DropDownList ddl, string selectedValue)
    {
        BindLocation(ddl, selectedValue, "");
    }

    public static void BindLocation(DropDownList ddl, string selectedValue, string LocNotIN)
    { 
        string cmd = "SELECT LocCode, LocCode + ' : ' + LocName AS Location FROM webx_location WHERE ActiveFlag = 'Y' ORDER BY LocCode";
        if (LocNotIN != "")
        {
            if (!LocNotIN.Contains(","))
                LocNotIN += ",_";
            cmd = "SELECT LocCode, LocCode + ' : ' + LocName AS Location FROM webx_location WHERE ActiveFlag = 'Y' AND LocCode not in (select Items from dbo.Split('" + LocNotIN + "',',')) ORDER BY LocCode";           
        }
        string connStr = GetConnectionString();
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
        BindDropDown(ddl, ds.Tables[0], "Location", "LocCode", "Select", "", 0, selectedValue);
    }
    public static void BindSelectedLocation(DropDownList ddl, string selectedValue, string LocList)
    {
        string cmd = "SELECT LocCode, LocCode + ' : ' + LocName AS Location FROM webx_location WHERE ActiveFlag = 'Y' ORDER BY LocCode";
        if (LocList != "")
        {
            if (!LocList.Contains(","))
                LocList += ",_";
            cmd = "SELECT LocCode, LocCode + ' : ' + LocName AS Location FROM webx_location WHERE ActiveFlag = 'Y' AND LocCode in (select Items from dbo.Split('" + LocList + "',',')) ORDER BY LocCode";
        }
        string connStr = GetConnectionString();
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
        BindDropDown(ddl, ds.Tables[0], "Location", "LocCode", "Select", "", 0, selectedValue);
    }

    public static void BindCustomer(DropDownList ddl, string selectedValue)
    {
        string cmd = "select CUSTCD, CUSTCD + ' : ' + CUSTNM AS CustName FROM webx_custhdr WHERE CUST_ACTIVE = 'Y' ORDER BY CUSTCD";
        string connStr = GetConnectionString();
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
        BindDropDown(ddl, ds.Tables[0], "CustName", "CUSTCD", "Select", "", 0, selectedValue);
    }

    public static DataTable GetDocTypes(string orderBy)
    {
        return GetDocTypes(orderBy, "Y");
    }
    public static DataTable GetDocTypes(string orderBy, string status)
    {
        string connStr = GetConnectionString();
        string cmd = "Select CodeId,CodeDesc from webx_master_general where CodeType='FMDOC'";
        if (status.ToUpper() == "ALL" || status == "")
            cmd += " Order By " + orderBy;
        else
            cmd += "and StatusCode='" + status + "' Order By " + orderBy;
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, cmd);
        return ds.Tables[0];
    }
    public static string GetDocumentTypeDesc(string codeid)
    {
        string strRet = "";
        string cmd = string.Format("Select top 1 CodeDesc from webx_master_general where CodeType='FMDOC' and StatusCode='Y' And CodeId='{0}'", codeid);
        object obj = SqlHelper.ExecuteScalar(GetConnectionString(), CommandType.Text, cmd);
        if (obj != null)
            strRet = (string)obj;
        return strRet;
    }

    public static string GetFMDocketTypeSuffix(string DocTypeValue)
    {
        string strDocTypeSuffix = "";

        switch (DocTypeValue)
        {
            case "1":
                strDocTypeSuffix = "P";
                break;
            case "2":
                strDocTypeSuffix = "B";
                break;
            case "3":
                strDocTypeSuffix = "O";
                break;
            case "4":
                strDocTypeSuffix = "C";
                break;
        }

        return strDocTypeSuffix;
    }
    
    #endregion

    #region Private Methods
    private static string GetConnectionString()
    {
        return SessionUtilities.ConnectionString;
    }
    private static void BindDropDown(DropDownList ddl, DataTable dataSource, string textField, string valueField, string addText, string addValue, int addIndex, string selectedValue)
    {
        ddl.DataSource = dataSource;
        ddl.DataTextField = textField;
        ddl.DataValueField = valueField;
        ddl.DataBind();
        ddl.Items.Insert(addIndex, new ListItem(addText, addValue));
        ddl.SelectedValue = selectedValue;
    }   
    #endregion    
}
