using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for jsonUtility
/// </summary>
public static class jsonUtility
{
    public static string DataTableToJSON(DataTable table)
    {
        var list = new List<Dictionary<string, object>>();
        foreach (DataRow row in table.Rows)
        {
            var dict = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {
                dict[col.ColumnName] = row[col];
            }
            list.Add(dict);
        }
        var serializer = new JavaScriptSerializer();
        return serializer.Serialize(list);
    }

    public static string DataSetToJson(DataSet ds)
    {
        var dict = ds.Tables.Cast<DataTable>().ToDictionary<DataTable, string, object>(dt => dt.TableName, DataTableToJSON);

        var json = new JavaScriptSerializer();
        return json.Serialize(dict);
    }
}
