using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;

public static class ExtensionUtility
{
    /*Converts List To DataTable*/
    public static DataTable ToDataTable<TSource>(this IList<TSource> data)
    {
        var dataTable = new DataTable(typeof(TSource).Name);
        var props = typeof(TSource).GetProperties(BindingFlags.Public | BindingFlags.Instance);
        foreach (PropertyInfo prop in props)
        {
            dataTable.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        }

        foreach (TSource item in data)
        {
            var values = new object[props.Length];
            for (int i = 0; i < props.Length; i++)
            {
                values[i] = props[i].GetValue(item, null);
            }
            dataTable.Rows.Add(values);
        }
        return dataTable;
    }

    /*Converts DataTable To List*/
    public static List<TSource> ToList<TSource>(this DataTable dataTable) where TSource : new()
    {
        var dataList = new List<TSource>();

        const BindingFlags flags = BindingFlags.Public | BindingFlags.Instance | BindingFlags.NonPublic;
        var objFieldNames = (from PropertyInfo aProp in typeof(TSource).GetProperties(flags)
                             select new { Name = aProp.Name, Type = Nullable.GetUnderlyingType(aProp.PropertyType) ?? aProp.PropertyType }).ToList();

        for (int i = 0; i < objFieldNames.Count; i++)
        {
            var oField = objFieldNames[i];
            for (int j = 0; j < dataTable.Columns.Count; j++)
            {
                if (oField.Name.ToUpper() == dataTable.Columns[j].ColumnName.ToUpper())
                {
                    dataTable.Columns[j].ColumnName = oField.Name;
                }
            }
        }

        var dataTblFieldNames = (from DataColumn aHeader in dataTable.Columns
                                 select new { Name = aHeader.ColumnName, Type = aHeader.DataType }).ToList();
        var commonFields = objFieldNames.Intersect(dataTblFieldNames).ToList();

        foreach (DataRow dataRow in dataTable.AsEnumerable().ToList())
        {
            var aTSource = new TSource();
            foreach (var aField in commonFields)
            {
                PropertyInfo propertyInfos = aTSource.GetType().GetProperty(aField.Name);

                if (dataRow[aField.Name] == DBNull.Value)
                {
                    switch (aField.Type.FullName)
                    {
                        case "System.DateTime":
                            propertyInfos.SetValue(aTSource, DateTime.MinValue, null); break;
                        case "System.String":
                            propertyInfos.SetValue(aTSource, "", null); break;
                        case "System.Decimal":
                        case "System.Double":
                        case "System.Int16":
                        case "System.Int32":
                        case "System.Int64":
                            propertyInfos.SetValue(aTSource, 0, null); break;
                        case "System.Boolean":
                            propertyInfos.SetValue(aTSource, false, null); break;
                        default: break;
                    }
                }
                else
                    propertyInfos.SetValue(aTSource, dataRow[aField.Name], null);
            }
            dataList.Add(aTSource);
        }
        return dataList;
    }
}


