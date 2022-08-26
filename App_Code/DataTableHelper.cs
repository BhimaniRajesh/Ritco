using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using ICSharpCode.SharpZipLib;
using ICSharpCode.SharpZipLib.Zip;

public class DataTableHelper
{
    ///
    /// Can stream DataTable to Browser, directly, you need to set
    ///
    /// Response.Clear();
    /// Response.Buffer= true;
    /// Response.ContentType = "application/vnd.ms-excel";
    /// Response.AddHeader("Content-Disposition", "inline;filename=Clientes.csv"); Response.Charset = "";
    /// this.EnableViewState = false
    /// // ACTUAL CODE
    /// ProduceCSV(dt, Response.Output, true);
    /// Responce.End();
    public static void ProduceCSV(DataTable dt, System.IO.TextWriter httpStream, bool WriteHeader)
    {
        if (WriteHeader)
        {
            string[] arr = new String[dt.Columns.Count];
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                arr[i] = dt.Columns[i].ColumnName;
                arr[i] = GetWriteableValue(arr[i]);
            }

            httpStream.WriteLine(string.Join(",", arr));
        }

        for (int j = 0; j < dt.Rows.Count; j++)
        {
            string[] dataArr = new String[dt.Columns.Count];
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                object o = dt.Rows[j][i];
                dataArr[i] = GetWriteableValue(o);
            }
            httpStream.WriteLine(string.Join(",", dataArr));
        }
    }

    public static string ProduceCSVString(DataTable dt, bool WriteHeader)
    {
        string strRet = "";
        if (WriteHeader)
        {
            string[] arr = new String[dt.Columns.Count];
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                arr[i] = dt.Columns[i].ColumnName;
                arr[i] = GetWriteableValue(arr[i]);
            }

            strRet += string.Join(",", arr) + Environment.NewLine;
        }

        for (int j = 0; j < dt.Rows.Count; j++)
        {
            string[] dataArr = new String[dt.Columns.Count];
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                object o = dt.Rows[j][i];
                dataArr[i] = GetWriteableValue(o);
            }
            strRet += string.Join(",", dataArr) + Environment.NewLine;
        }
        return strRet;
    }

    public static void ExportToCSV(DataTable dt, string fileName)
    {
        ExportToCSV(dt, fileName, true);
    }
    public static void ExportToCSV(DataTable dt, string fileName, string filter)
    {
        ExportToCSV(dt, fileName, filter, true);
    }
    public static void ExportToCSV(DataTable dt, string fileName, bool WriteHeader)
    {
        ExportToCSV(dt, fileName, "",WriteHeader);
    }
    public static void ExportToCSV(DataTable dt, string fileName, string filter, bool WriteHeader)
    {
        ExportToCSV(dt, HttpContext.Current.Response, fileName, filter, WriteHeader);
    }
    public static void ExportToCSV(string csvString, string fileName)
    {
        ExportToCSV(csvString, HttpContext.Current.Response, fileName);
    }

    public static void ExportToCSV(DataTable dt, HttpResponse Response, string fileName)
    {
        ExportToCSV(dt, Response, fileName, true);
    }
    public static void ExportToCSV(DataTable dt, HttpResponse Response, string fileName, string filter)
    {
        ExportToCSV(dt, Response, fileName, filter, true);
    }
    public static void ExportToCSV(DataTable dt, HttpResponse Response, string fileName,bool WriteHeader)
    {
        ExportToCSV(dt, Response, fileName, "", WriteHeader);
    }
    public static void ExportToCSV(DataTable dt, HttpResponse Response, string fileName, string filter, bool WriteHeader)
    {
        string CSVOutput = "";
        if (filter != "")
            CSVOutput += filter + Environment.NewLine;
        CSVOutput += ProduceCSVString(dt, WriteHeader);
        ExportToCSV(CSVOutput, Response, fileName);
    }
    public static void ExportToCSV(string csvString, HttpResponse Response, string fileName)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "inline;filename=" + fileName + ".csv");
        Response.Write(csvString);
        Response.End();
    }

    public static void ExportToZipCSV(DataTable dt, string fileName)
    {
        ExportToZipCSV(dt, fileName, "");
    }
    public static void ExportToZipCSV(DataTable dt, string fileName, string filter)
    {
        ExportToZipCSV(dt, fileName, filter, true);
    }
    public static void ExportToZipCSV(DataTable dt, string fileName, string filter, bool WriteHeader)
    {
        ExportToZipCSV(dt, HttpContext.Current.Response, fileName, filter, WriteHeader);        
    }
    public static void ExportToZipCSV(string csvString, string fileName)
    {
        ExportToZipCSV(csvString, HttpContext.Current.Response, fileName);
    }

    public static void ExportToZipCSV(DataTable dt, HttpResponse Response, string fileName)
    {
        ExportToZipCSV(dt, Response, fileName, "");
    }
    public static void ExportToZipCSV(DataTable dt, HttpResponse Response, string fileName, string filter)
    {
        ExportToZipCSV(dt, Response, fileName, filter, true);
    }
    public static void ExportToZipCSV(DataTable dt, HttpResponse Response, string fileName, string filter, bool WriteHeader)
    {
        string CSVOutput = "";
        if(filter != "")
            CSVOutput += filter + Environment.NewLine;
        CSVOutput += ProduceCSVString(dt, WriteHeader);
        ExportToZipCSV(CSVOutput, Response, fileName);
    }
    public static void ExportToZipCSV(string csvString, HttpResponse Response, string fileName)
    {
        StringBuilder str = new StringBuilder();

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".zip");
        Response.Charset = "";

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/x-zip-compressed";

        ZipOutputStream outputStream = new ZipOutputStream(Response.OutputStream);
        ZipEntry entry = new ZipEntry(fileName + ".csv"); entry.DateTime = DateTime.Now;

        outputStream.PutNextEntry(entry);
        using (StreamWriter sw = new StreamWriter(outputStream))
        {
            sw.Write(csvString);
        }

        // Close the zip file:
        outputStream.Finish();
        outputStream.Close();

        // Now end the response.
        Response.End();
    }

    public static void ExportToZipXLS(StringWriter stringWrite, string fileName)
    {
        ExportToZipXLS(stringWrite, HttpContext.Current.Response, fileName);
    }
    public static void ExportToZipXLS(StringWriter stringWrite, HttpResponse Response, string fileName)
    {
        StringBuilder str = new StringBuilder();

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".zip");
        Response.Charset = "";

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/x-zip-compressed";

        ZipOutputStream outputStream = new ZipOutputStream(Response.OutputStream);
        ZipEntry entry = new ZipEntry(fileName + ".xls"); entry.DateTime = DateTime.Now;

        outputStream.PutNextEntry(entry);
        using (StreamWriter sw = new StreamWriter(outputStream))
        {
            sw.Write(stringWrite.ToString());
        }

        // Close the zip file:
        outputStream.Finish();
        outputStream.Close();

        // Now end the response.
        Response.End();
    }

    public static void ExportToXLS(StringWriter stringWrite, string fileName)
    {
        ExportToXLS(stringWrite, HttpContext.Current.Response, fileName);
    }
    public static void ExportToXLS(StringWriter stringWrite, HttpResponse Response, string fileName)
    {
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    

    #region CSV Producer
    public static void ProduceCSV(DataTable dt, System.IO.StreamWriter file, bool WriteHeader)
    {
        if (WriteHeader)
        {
            string[] arr = new String[dt.Columns.Count];
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                arr[i] = dt.Columns[i].ColumnName;
                arr[i] = GetWriteableValue(arr[i]);
            }

            file.WriteLine(string.Join(",", arr));
        }

        for (int j = 0; j < dt.Rows.Count; j++)
        {
            string[] dataArr = new String[dt.Columns.Count];
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                object o = dt.Rows[j][i];
                dataArr[i] = GetWriteableValue(o);
            }
            file.WriteLine(string.Join(",", dataArr));
        }
    }

    public static string GetWriteableValue(object o)
    {
        string strRet = "";
        if (o == null || o == Convert.DBNull)
            strRet = "";
        else
        {
            strRet = o.ToString();
            strRet = strRet.Replace(",", " ");
            strRet = strRet.Replace("\r\n", " ");
            strRet = strRet.Replace("\t", " ");
        }

        return strRet;
    }
    #endregion
}
