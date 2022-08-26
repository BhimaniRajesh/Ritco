using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Web.UI;

/// <summary>
/// Summary description for WebxUtils
/// </summary>
public class WebxUtils
{
    public WebxUtils()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// This Function will Check the Datatable if its Null Or Empty
    /// Kumar Lachhani
    /// </summary>
    /// <param name="dt">DataTable object to check</param>
    /// <returns></returns>
    public static bool IsDataTableNullOrEmpty(DataTable dt)
    {
        try
        {
            if ((dt != null) && (dt.Rows.Count > 0))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            return true;
        }
    }

    /// <summary>
    /// This Function will Check the Dataset if its Null Or Empty
    /// Kumar Lachhani
    /// </summary>
    /// <param name="ds">Dataset object to check</param>
    /// <returns></returns>
    public static bool IsDataSetNullOrEmpty(DataSet ds)
    {
        try
        {
            if ((ds != null) && (ds.Tables != null) && (ds.Tables.Count > 0) && (ds.Tables[0] != null) && (ds.Tables[0].Rows.Count > 0))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            return true;
        }
    }

    /// <summary>
    /// The Function will Check the object for Null Or Empty
    /// - Kumar Lachhani
    /// </summary>
    /// <param name="o">Object : The object to be checked</param>
    /// <returns></returns>
    public static bool IsObjectNullOrEmpty(Object o)
    {
        try
        {
            if ((o != null) && (o != ""))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            return true;
        }
    }

    /// <summary>
    /// The Function will Check the String for Null Or Empty
    /// Kumar Lachhani
    /// </summary>
    /// <param name="s">The string to be passed</param>
    /// <param name="valueifNull">value to be used when given string is null</param>
    /// <returns></returns>
    public static bool IsStringNullOrEmpty(string s)
    {
        try
        {
            // string s = WebXConvert.objectToString(o, string.Empty);
            if (string.IsNullOrEmpty(s.Trim()))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            return true;
        }
    }

    /// <summary>
    /// The function will convert the JSON to DataTable
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="JSONString"></param>
    /// <returns></returns>
    public static DataTable JSONToDataTable(string JSONString)
    {
        try
        {
            DataTable dataTable = new DataTable();
            if (!(IsStringNullOrEmpty(JSONString)))
            {
                dataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<DataTable>(JSONString);
                return dataTable;
            }
            else
            {
                return null;
            }
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    /// <summary>
    ///  The function will convert the JSON to DataSet
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="JSONString"></param>
    /// <returns></returns>
    public static DataSet JSONToDataSet(string JSONString)
    {
        try
        {
            DataSet ds = new DataSet();
            if (!(IsStringNullOrEmpty(JSONString)))
            {
                ds = Newtonsoft.Json.JsonConvert.DeserializeObject<DataSet>(JSONString);
                return ds;
            }
            else
            {
                return null;
            }
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    /// <summary>
    /// The function will convert the DataTable to JSON string
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="dt"></param>
    /// <returns></returns>
    public static string DataTableToJSON(DataTable dt)
    {
        try
        {
            string jsonToReturn = string.Empty;
            if (!(IsDataTableNullOrEmpty(dt)))
            {
                jsonToReturn = Newtonsoft.Json.JsonConvert.SerializeObject(dt, Newtonsoft.Json.Formatting.Indented);
            }

            return jsonToReturn;

        }
        catch (Exception ex)
        {
            return string.Empty;
        }
    }

    /// <summary>
    /// The function will convert the DataSet to JSON string
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="ds"></param>
    /// <returns></returns>
    public static string DataSetToJSON(DataSet ds)
    {
        try
        {
            string jsonToReturn = string.Empty;
            if (!(IsDataSetNullOrEmpty(ds)))
            {
                jsonToReturn = Newtonsoft.Json.JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
            }

            return jsonToReturn;
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
    }

    /// <summary>
    /// The function will add the Column to the datatable
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="myDataTable">The DataTable objecto to add the column to</param>
    /// <param name="colName">string: Column Name to be added</param>
    /// <param name="colType">string: Column Type i.e. System.String, System.Double etc</param>
    public static void AddColumntoDatatable(DataTable myDataTable, string colName, string colType)
    {
        try
        {
            if (myDataTable != null)
            {
                DataColumn myDataColumn = new DataColumn();
                myDataColumn.DataType = Type.GetType(colType);
                myDataColumn.ColumnName = colName;
                myDataTable.Columns.Add(myDataColumn);
            }
        }
        catch
        {

        }
    }

    /// <summary>
    /// The function will add the datatable to the passed dataset
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="dtToCopy">DataTable: The DataTable object to copy</param>
    /// <param name="dsTarget">DataSet: Target Dataset in which datatable is to be added</param>
    /// <param name="TableName">TableName: The Name of the Table, if not passed then it will take default name</param>
    public static void addDataTableToDataSet(DataTable dtToCopy, DataSet dsTarget, string TableName)
    {
        DataTable dt = dtToCopy.Copy();

        if (IsStringNullOrEmpty(TableName))
            dt.TableName = "Table" + dsTarget.Tables.Count;
        else
            dt.TableName = TableName;

        dsTarget.Tables.Add(dt);
    }

    /// <summary>
    /// The function will add the datatable to the passed dataset
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="dt">DataTable: Source DataTable object</param>
    /// <param name="dtctobecomputed">DataColumn: DataColum object of which SUM has to be taken</param>
    /// <param name="TableName">TableName: The Name of the Table, if not passed then it will take default name</param>
    public static double SumofDataColumn(DataTable dt, DataColumn dtctobecomputed)
    {
        double totalofcolumn = 0;

        totalofcolumn = Convert.ToDouble(dt.Compute("Sum(" + dtctobecomputed + ")", ""));

        return totalofcolumn;
    }

    /// <summary>
    /// The function will apply Cache settings to the page
    /// - Kumar Lachhani
    /// </summary>
    public static void applyCacheSettings()
    {
        HttpContext c = HttpContext.Current;

        c.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        c.Response.Cache.SetNoStore();
        c.Response.Cache.SetExpires(DateTime.MinValue);
    }

    /// <summary>
    /// The function will Bind the Dropdown list with the passed params
    /// </summary>
    /// <param name="dl"></param>
    /// <param name="DataSource">object: DataTable/DataSet object containing data</param>
    /// <param name="TextField">string: Dropdown TextField</param>
    /// <param name="ValueField">string: Dropdown ValueField</param>
    /// <param name="selectedValue">string: selectedValue, value to select if any</param>
    /// /// <param name="addOptionSelect">bool: addOptionSelect, Select Option Add or Not</param>
    public static void BindDropDownList(DropDownList ddl, object DataSource, string TextField, string ValueField, string selectedValue, bool addOptionSelect)
    {
        if (ddl != null)
        {
            ddl.Items.Clear();

            if (DataSource.GetType().ToString() == "System.Data.DataSet")
            {
                DataSet ds = ((DataSet)DataSource).Copy();
                ddl.DataSource = ds;
            }
            else if (DataSource.GetType().ToString() == "System.Data.DataTable")
            {
                DataTable dt = ((DataTable)DataSource).Copy();
                ddl.DataSource = dt;
            }

            ddl.DataValueField = ValueField;
            ddl.DataTextField = TextField;
            ddl.DataBind();

            if (addOptionSelect)
            {
                ddl.Items.Insert(0, new ListItem("--Select--", ""));
                ddl.SelectedIndex = 0;
            }

            if (!WebxUtils.IsStringNullOrEmpty(selectedValue))
                ddl.SelectedValue = selectedValue;
        }
    }

    /// <summary>
    /// The function will Bind the ListBox with the passed params
    /// </summary>
    /// <param name="dl"></param>
    /// <param name="DataSource">object: DataTable/DataSet object containing data</param>
    /// <param name="TextField">string: ListBox TextField</param>
    /// <param name="ValueField">string: ListBox ValueField</param>
    /// <param name="selectedValue">string: selectedValue, value to select if any</param>
    /// <param name="addOptionSelect">bool: addOptionSelect, Select Option Add or Not</param>
    public static void BindListBox(ListBox lb, object DataSource, string TextField, string ValueField, string selectedValue, bool addOptionSelect)
    {
        if (lb != null)
        {
            lb.Items.Clear();

            if (DataSource.GetType().ToString() == "System.Data.DataSet")
            {
                DataSet ds = ((DataSet)DataSource).Copy();
                lb.DataSource = ds;
            }
            else if (DataSource.GetType().ToString() == "System.Data.DataTable")
            {
                DataTable dt = ((DataTable)DataSource).Copy();
                lb.DataSource = dt;
            }

            lb.DataValueField = ValueField;
            lb.DataTextField = TextField;
            lb.DataBind();

            if (addOptionSelect)
            {
                lb.Items.Insert(0, new ListItem("--Select--", ""));
                lb.SelectedIndex = 0;
            }

            if (!WebxUtils.IsStringNullOrEmpty(selectedValue))
                lb.SelectedValue = selectedValue;
        }
    }

    /// <summary>
    /// The function will Bind the RadioButtonList with the passed params
    /// </summary>
    /// <param name="rbl"></param>
    /// <param name="DataSource">object: DataTable/DataSet object containing data</param>
    /// <param name="TextField">string: ListBox TextField</param>
    /// <param name="ValueField">string: ListBox ValueField</param>
    /// <param name="selectedValue">string: selectedValue, value to select if any</param>
    /// <param name="addOptionAll">bool: addOptionAll, All Option Add or Not</param>
    public static void BindRadioButtonList(RadioButtonList rbl, object DataSource, string TextField, string ValueField, string selectedValue, bool addOptionAll)
    {
        if (rbl != null)
        {
            rbl.Items.Clear();

            if (DataSource.GetType().ToString() == "System.Data.DataSet")
            {
                DataSet ds = ((DataSet)DataSource).Copy();
                rbl.DataSource = ds;
            }
            else if (DataSource.GetType().ToString() == "System.Data.DataTable")
            {
                DataTable dt = ((DataTable)DataSource).Copy();
                rbl.DataSource = dt;
            }

            rbl.DataValueField = ValueField;
            rbl.DataTextField = TextField;
            rbl.DataBind();

            if (addOptionAll)
            {
                rbl.Items.Insert(0, new ListItem("All", "0"));
                rbl.SelectedIndex = 0;
            }

            if (!WebxUtils.IsStringNullOrEmpty(selectedValue))
                rbl.SelectedValue = selectedValue;
        }
    }


    /// <summary>
    /// The function will Generate the Stored Procedure Execution Script based on params passed
    /// </summary>
    /// <param name="cmdType">Command Type i.e. Stored Procedure OR Text</param>
    /// <param name="CommandText">Name of the Stored Procedure</param>
    /// <param name="param">SQLParameter Collection object containing Parameters</param>
    /// <returns></returns>
    public static string GenerateSPExecutionScript(CommandType cmdType, string CommandText, SqlParameter[] param)
    {
        StringBuilder b = new StringBuilder();

        if (cmdType == CommandType.StoredProcedure)
        {
            b.AppendLine("exec " + CommandText + " --Stored Procedure Name");
        }

        for (int i = 0; i < param.Length; i++)
        {
            try
            {
                if (param[i] != null)
                {
                    string paramname = WebXConvert.objectToString(param[i].ParameterName, string.Empty);
                    string paramvalue = WebXConvert.objectToString(param[i].Value, string.Empty);
                    if (param[i].SqlDbType.ToString().ToLower().Contains("varchar"))// DbType.String)
                    {
                        b.AppendLine("        " + paramname + " = '" + paramvalue + "',");
                    }
                    else if (param[i].SqlDbType.ToString().ToLower().Contains("xml"))
                    {
                        b.AppendLine("        " + paramname + " = N'" + paramvalue + "',");
                    }
                    else if (param[i].SqlDbType.ToString().ToLower().Contains("int"))
                    {
                        b.AppendLine("        " + paramname + " = " + paramvalue + ",");
                    }
                    else if (param[i].SqlDbType.ToString().ToLower().Contains("datetime"))
                    {
                        b.AppendLine("        " + paramname + " = '" + paramvalue + "',");
                    }
                    else
                    {
                        b.AppendLine("        " + paramname + " = " + paramvalue + ",");
                    }
                }
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }

        return b.ToString();
    }

    public static bool IsConnectionTimeout(Exception ex)
    {
        var sqlException = ex as SqlException;
        if (sqlException != null)
        {
            if (sqlException.Number == -2) { return true; }
        }
        return false;
    }

    /// <summary>
    /// The function will execute the Client script from server side code
    /// </summary>
    /// <param name="ClientScriptToExecute">string: The Client Script to Execute</param>
    public static void ExecuteClientScriptBlock(string ClientScriptToExecute)
    {
        try
        {
            Page p = HttpContext.Current.Handler as Page;
            if (IsObjectNullOrEmpty(System.Web.UI.ScriptManager.GetCurrent(p)))
            {
                p.ClientScript.RegisterClientScriptBlock(p.GetType(), WebXConvert.objectToString(Guid.NewGuid(), string.Empty), ClientScriptToExecute, true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(p, p.GetType(), WebXConvert.objectToString(Guid.NewGuid(), string.Empty), ClientScriptToExecute, true);
            }
        }
        catch (Exception x)
        {

        }
    }

    /// <summary>
    /// The function will show the alert and then redirect to another location as Response.Redirect skips the message
    /// </summary>
    /// <param name="Message"></param>
    /// <param name="RedirectURL"></param>
    public static void showMessageBoxWithRedirect(string Message, string RedirectURL)
    {
        try
        {
            if ((!(IsStringNullOrEmpty(Message))) && (!(IsStringNullOrEmpty(RedirectURL))))
            {
                string redirectScript = @"
                alert('" + Message + @"'); 
                window.location='" + RedirectURL + "';";

                ExecuteClientScriptBlock(redirectScript);
            }
        }
        catch (Exception ex)
        {

        }
    }

    /// <summary>
    /// The Function will return the Base URL of the Application
    /// </summary>
    /// <returns></returns>
    public static string GetBaseURL()
    {
        try
        {
            HttpContext context = HttpContext.Current;

            string baseUrl = context.Request.Url.Scheme + "://" + context.Request.Url.Authority + context.Request.ApplicationPath.TrimEnd('/') + '/';
            return baseUrl;
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
    }
}