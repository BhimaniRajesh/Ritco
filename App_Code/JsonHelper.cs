using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;

/// <summary>
/// JSON Serialization and Deserialization Assistant Class
/// </summary>
public class JsonHelper
{
    /// <summary>
    /// JSON Serialization
    /// </summary>
    public static string JsonSerialize<T>(T t)
    {
        var ser = new DataContractJsonSerializer(typeof(T));
        using (var ms = new MemoryStream())
        {
            ser.WriteObject(ms, t);
            return Encoding.UTF8.GetString(ms.ToArray());
        }
    }
    /// <summary>
    /// JSON Deserialization
    /// </summary>
    public static T JsonDeserialize<T>(string jsonString)
    {
        var ser = new DataContractJsonSerializer(typeof(T));
        using (var ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString)))
        {
            return (T) ser.ReadObject(ms);
        }
    }

    public static string JavaScriptSerialize<T>(T t)
    {
        return (new JavaScriptSerializer()).Serialize(t);
    }
}