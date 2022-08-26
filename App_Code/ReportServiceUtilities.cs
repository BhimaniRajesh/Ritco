using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System.Reflection;
using System.IO;

/// <summary>
/// Summary description for ReportServiceUtilities
/// </summary>
public class ReportServiceUtilities
{
    public static string ReportServer
    {
        get { return ConfigurationManager.AppSettings["ReportServer"]; }
    }
    public static Uri ReportServerURL
    {
        get { return new Uri(ConfigurationManager.AppSettings["ReportServerURL"]); }
    }
    public static string ReportServerUser
    {
        get { return ConfigurationManager.AppSettings["ReportServerUser"]; }
    }
    public static string ReportServerPass
    {
        get { return ConfigurationManager.AppSettings["ReportServerPass"]; }
    }
    public static string ReportPathPrefix
    {
        get { return ConfigurationManager.AppSettings["ReportPathPrefix"]; }
    }
    public static string ReportFleetPathPrefix
    {
        get { return ConfigurationManager.AppSettings["ReportFleetPathPrefix"]; }
    }

    public static string ReportPath
    {
        get { return ReportPathPrefix; }
    }

    private rs2005.ReportingService2005 rs;
    private rsExecService.ReportExecutionService rsExec;
    private rsExecService.ParameterValue[] _ReportParams;

    public rsExecService.ParameterValue[] ReportParams
    {
        get { return _ReportParams; }
        set { _ReportParams = value; }
    }

	public ReportServiceUtilities()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static ReportCredentials GetReportCredentials()
    {
        return new ReportCredentials(ReportServerUser, ReportServerPass, ReportServer);
    }

    public void Export(string reportName, string format, HttpResponse responce)
    {
        Export(reportName, format, responce, reportName + GetFileExtention(format));
    }

    public void Export(string reportName, string format, HttpResponse responce, string filename)
    {
        string strRed_Uri = "";
        if (strRed_Uri.EndsWith("/"))
        {
            if (ReportServiceUtilities.ReportPath.StartsWith("/"))
                strRed_Uri = strRed_Uri + ReportServiceUtilities.ReportPath.Substring(1);
            else
                strRed_Uri = strRed_Uri + ReportServiceUtilities.ReportPath;
        }
        else
        {
            if (ReportServiceUtilities.ReportPath.StartsWith("/"))
                strRed_Uri = strRed_Uri + ReportServiceUtilities.ReportPath;
            else
                strRed_Uri = strRed_Uri + "/" + ReportServiceUtilities.ReportPath;
        }
        if (reportName != "")
        {
            if (strRed_Uri.EndsWith("/"))
            {
                strRed_Uri = strRed_Uri + reportName;
            }
            else
            {
                strRed_Uri = strRed_Uri + "/" + reportName;
            }
        }

        rs = new rs2005.ReportingService2005();
        rsExec = new rsExecService.ReportExecutionService();

        // Authenticate to the Web service using Windows credentials
        rs.Credentials = new System.Net.NetworkCredential(ReportServiceUtilities.ReportServerUser, ReportServiceUtilities.ReportServerPass);
        rsExec.Credentials = new System.Net.NetworkCredential(ReportServiceUtilities.ReportServerUser, ReportServiceUtilities.ReportServerPass);

        // Assign the URL of the Web service
        rs.Url = ConfigurationManager.AppSettings["rs2005.ReportService2005"];
        rsExec.Url = ConfigurationManager.AppSettings["rsExecService.ReportExecution2005"];

        string historyID = null;
        string deviceInfo = null;
        Byte[] results;
        string encoding = String.Empty;
        string mimeType = String.Empty;
        string extension = String.Empty;
        rsExecService.Warning[] warnings = null;
        string[] streamIDs = null;

        // Define variables needed for GetParameters() method
        // Get the report name
        string _reportName = strRed_Uri;
        string _historyID = null;
        bool _forRendering = false;
        rs2005.ParameterValue[] _values = null;
        rs2005.DataSourceCredentials[] _credentials = null;
        rs2005.ReportParameter[] _parameters = null;

        try
        {
            // Get if any parameters needed.
            _parameters = rs.GetReportParameters(_reportName, _historyID,
                          _forRendering, _values, _credentials);

            // Load the selected report.
            rsExecService.ExecutionInfo ei =
                  rsExec.LoadReport(_reportName, historyID);

            rsExec.SetExecutionParameters(this.ReportParams, "en-us");
            results = rsExec.Render(format, deviceInfo,
                      out extension, out encoding,
                      out mimeType, out warnings, out streamIDs);

            responce.Clear();
            responce.Buffer = true;
            responce.ContentType = GetContentType(format);
            responce.AddHeader("content-disposition", String.Format("attachment;filename={0}", filename));
            responce.Charset = "";
            responce.BinaryWrite(results);
            responce.End();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public bool ExportToFile(string reportName, string format, string filename)
    {
        bool bChk = false;
        try
        {
            string strRed_Uri = "";
            if (strRed_Uri.EndsWith("/"))
            {
                if (ReportServiceUtilities.ReportPath.StartsWith("/"))
                    strRed_Uri = strRed_Uri + ReportServiceUtilities.ReportPath.Substring(1);
                else
                    strRed_Uri = strRed_Uri + ReportServiceUtilities.ReportPath;
            }
            else
            {
                if (ReportServiceUtilities.ReportPath.StartsWith("/"))
                    strRed_Uri = strRed_Uri + ReportServiceUtilities.ReportPath;
                else
                    strRed_Uri = strRed_Uri + "/" + ReportServiceUtilities.ReportPath;
            }
            if (reportName != "")
            {
                if (strRed_Uri.EndsWith("/"))
                {
                    strRed_Uri = strRed_Uri + reportName;
                }
                else
                {
                    strRed_Uri = strRed_Uri + "/" + reportName;
                }
            }

            rs = new rs2005.ReportingService2005();
            rsExec = new rsExecService.ReportExecutionService();

            // Authenticate to the Web service using Windows credentials
            rs.Credentials = new System.Net.NetworkCredential(ReportServiceUtilities.ReportServerUser, ReportServiceUtilities.ReportServerPass);
            rsExec.Credentials = new System.Net.NetworkCredential(ReportServiceUtilities.ReportServerUser, ReportServiceUtilities.ReportServerPass);

            // Assign the URL of the Web service
            rs.Url = ConfigurationManager.AppSettings["rs2005.ReportService2005"];
            rsExec.Url = ConfigurationManager.AppSettings["rsExecService.ReportExecution2005"];

            string historyID = null;
            string deviceInfo = null;
            Byte[] results;
            string encoding = String.Empty;
            string mimeType = String.Empty;
            string extension = String.Empty;
            rsExecService.Warning[] warnings = null;
            string[] streamIDs = null;

            // Define variables needed for GetParameters() method
            // Get the report name
            string _reportName = strRed_Uri;
            string _historyID = null;
            bool _forRendering = false;
            rs2005.ParameterValue[] _values = null;
            rs2005.DataSourceCredentials[] _credentials = null;
            rs2005.ReportParameter[] _parameters = null;

            try
            {
                // Get if any parameters needed.
                _parameters = rs.GetReportParameters(_reportName, _historyID,
                              _forRendering, _values, _credentials);

                // Load the selected report.
                rsExecService.ExecutionInfo ei =
                      rsExec.LoadReport(_reportName, historyID);

                rsExec.SetExecutionParameters(this.ReportParams, "en-us");
                results = rsExec.Render(format, deviceInfo,
                          out extension, out encoding,
                          out mimeType, out warnings, out streamIDs);
                FileStream fs = new FileStream(filename, FileMode.Create);
                fs.Write(results, 0, results.Length);
                fs.Flush();
                fs.Close();
                bChk = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        catch (Exception exc)
        {
            //throw exc;
            bChk = false;
        }
        return bChk;
    }

    public rsExecService.ParameterValue GetNewParam(string name, string value)
    {
        rsExecService.ParameterValue _p = new rsExecService.ParameterValue();
        _p.Name = name;
        _p.Value = value;
        return _p;
    }

    private string GetContentType(string format)
    {
        string type = "";
        if (format.ToUpper() == "EXCEL")
            type = "application/vnd.ms-excel";
        if (format.ToUpper() == "PDF")
            type = "application/octet-stream";
        //type = "application/pdf";
        if (format.ToUpper() == "CSV")
            type = "application/CSV";

        return type;
    }

    private string GetFileExtention(string format)
    {
        string type = "";
        if (format.ToUpper() == "EXCEL")
            type = ".xls";
        if (format.ToUpper() == "PDF")
            type = ".pdf";
        //type = "application/pdf";
        if (format.ToUpper() == "CSV")
            type = ".csv";

        return type;
    }
}

public class ReportCredentials : Microsoft.Reporting.WebForms.IReportServerCredentials
{
    string _userName, _password, _domain;

    public ReportCredentials(string userName, string password, string domain)
    {
        _userName = userName;
        _password = password;
        _domain = domain;
    }

    public System.Security.Principal.WindowsIdentity ImpersonationUser
    {
        get { return null; }
    }

    public System.Net.ICredentials NetworkCredentials
    {
        get
        {  return new System.Net.NetworkCredential(_userName, _password, _domain); }
    }

    public bool GetFormsCredentials(out System.Net.Cookie authCoki, out string userName, out string password, out string authority)
    {
        userName = _userName;
        password = _password;
        authority = _domain;

        authCoki = new System.Net.Cookie(".ASPXAUTH", ".ASPXAUTH", "/", "Domain");
        return true;
    }
}

public class ReportExportFormat
{
    public const string PDF = "PDF";
    public const string Excel = "Excel";
}

