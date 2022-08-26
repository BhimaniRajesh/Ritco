using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.WebControls;
using WebX.Common;
using System.Collections.Generic;

public class FileUploadHelper
{
    public FileUploadHelper()
    {
        RequiredColumnMapping = false;
    }
    public DataTable dtResultSuccess { get; set; }
    public DataTable dtResultFail { get; set; }
    public string strResultMessage { get; set; }

    public bool RequiredColumnMapping { get; set; }
    public FileUpload fileUploadControl { get; set; }
    public string strFileNamePrefix { get; set; }
    public string strFilePath { get; set; }
    public DataTable dtFormat { get; set; }
    public string strModuleName { get; set; }
    public string strProcedureName { get; set; }

    /// <summary>
    /// Get Column List for XLS Upload
    /// </summary>
    /// <param name="strDocumentType">Document Type</param>
    /// <returns>Data Table having list of columns as a Data Row</returns>
    public DataTable GetColumnList(string strDocumentType)
    {
        var dtFormat = new DataTable();
        using (var oDal = new WebXHelper())
        {
            dtFormat = oDal.ExecuteDataTable("Usp_Get_Column_List_For_Xls_Upload", new SqlParameter[] { new SqlParameter("@Document", strDocumentType) });
        }
        return dtFormat;
    }

    /// <summary>
    /// Check Valid Column Name
    /// </summary>
    /// <param name="dt">DataTable extracted from XLS</param>
    /// <param name="strFieldName">Field Name</param>
    /// <param name="strFieldCaption">Field Caption</param>
    public void CheckValidColumnName(DataTable dt, string strFieldName, string strFieldCaption)
    {
        string strErrorMessage = " column is missing";

        if (!dt.Columns.Contains(strFieldCaption))
            throw new Exception(strFieldCaption + strErrorMessage);
        else
            dt.Columns[strFieldCaption].ColumnName = strFieldName;
    }

    /// <summary>
    /// Set Caption in Result XLS
    /// </summary>
    /// <param name="dtResult">DataTable of XLS Upload Result</param>
    /// <param name="strFieldName">Field Name</param>
    /// <param name="strFieldCaption">Field Caption</param>
    /// <returns></returns>
    public void SetCaption(DataTable dtResult, string strFieldName, string strFieldCaption)
    {
        if (dtResult.Columns.Contains(strFieldName))
            dtResult.Columns[strFieldName].ColumnName = strFieldCaption;
    }

    public void Upload()
    {

        if (fileUploadControl.HasFile)
        {
            string filepath = fileUploadControl.PostedFile.FileName;
            string pat = @"(?:.+)(.+)\.(.+)";

            Regex r = new Regex(pat);
            //run
            Match m = r.Match(filepath);
            string file_ext = m.Groups[2].Captures[0].ToString();
            string filename = strFileNamePrefix + "_" + DateTime.Now.ToString("ddMMyyyy") + "." + file_ext;


            if (file_ext.ToLower() != "xls" && file_ext.ToLower() != "xlsx" && file_ext.ToLower() != "csv")
                throw new Exception("Invalid File");

            string path = HttpContext.Current.Server.MapPath(strFilePath);

            if (Directory.Exists(path))
            {
                if (File.Exists(path + "\\" + filename))
                    File.Delete(path + "\\" + filename);
            }
            else
                Directory.CreateDirectory(path);

            fileUploadControl.SaveAs(path + "\\" + filename);
            ExcelUtilities exl = new ExcelUtilities();
            DataSet dsExcel = new DataSet();


            dsExcel = exl.GetExcelData(path + "\\" + filename);

            //dsExcel = ExcelUtils.GetExcelData(path + "\\" + filename);

            if (dsExcel == null)
            {
                throw new Exception("Invalid File. No Records Found");
            }
            DataTable dtExcel = dsExcel.Tables[0];


            if (dtExcel.Columns.Count != dtExcel.Columns.Count)
            {
                throw new Exception("Invalid no of columns.");
            }
            else if (dtExcel.Rows.Count < 1)
            {
                throw new Exception("Please input at-least one record.");
            }

            foreach (DataRow dr in dtFormat.Rows)
            {
                CheckValidColumnName(dtExcel, dr["FieldName"].ToString(), dr["FieldCaption"].ToString());
            }

                /*---------------------  Remove Blank Data Start ---------------------------*/
        GoTo:

            for (int i = 0; i < dtExcel.Rows.Count; i++)
            {
                if (dtExcel.Rows[i][0].ToString() == "")
                {
                    dtExcel.Rows.RemoveAt(i);
                    goto GoTo;
                }
            }

            /*----------------------  Remove Blank Data End ---------------------------*/
            if (dtExcel.Rows.Count < 1)
            {
                throw new Exception("Please input at-least one record.");
            }

            //dsExcel.DataSetName = "Document";
            //dsExcel.Tables[0].TableName = "Table1";
            dsExcel.DataSetName = strModuleName + "List";
            dsExcel.Tables[0].TableName = strModuleName;

            if (RequiredColumnMapping)
            {
                foreach (DataColumn dc in dsExcel.Tables[0].Columns)
                {
                    dc.ColumnMapping = MappingType.Attribute;
                }
            }


            if (File.Exists(path + "\\" + filename))
                File.Delete(path + "\\" + filename);

            string str_XML = dsExcel.GetXml();
            str_XML = dsExcel.GetXml().Replace("_x0020_", "_");
            var dsResult = new DataSet();

            using (var oDal = new WebXHelper())
            {
                oDal.BeginTransaction();
                try
                {
                    SqlParameter[] prm =
                    {
                        new SqlParameter("@XML", str_XML),
                        new SqlParameter("@Location", SessionUtilities.CurrentBranchCode),
                        new SqlParameter("@FinYear", SessionUtilities.FinYear),
                        new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID)
                    };
                    dsResult = oDal.ExecuteDataSet(CommandType.StoredProcedure, strProcedureName, prm);
                    oDal.CommitTransaction();
                }
                catch (Exception ex)
                {
                    oDal.RollBackTransaction();
                    ExceptionUtils.LogException(ex, strModuleName + "-Upload");
                    throw;
                }
            }

            if (dsResult != null && dsResult.Tables.Count > 0)
            {
                dtResultSuccess = dsResult.Tables[0];

                if (dtResultSuccess.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtFormat.Rows)
                    {
                        SetCaption(dtResultSuccess, dr["FieldName"].ToString(), dr["FieldCaption"].ToString());
                    }
                }
                if (dsResult.Tables.Count > 1)
                {
                    dtResultFail = dsResult.Tables[1];
                    if (dtResultFail.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dtFormat.Rows)
                        {
                            SetCaption(dtResultFail, dr["FieldName"].ToString(), dr["FieldCaption"].ToString());
                        }
                    }
                }
                int successCount = 0, failCount = 0;
                successCount = dtResultSuccess.Rows.Count;
                failCount = dtResultFail.Rows.Count;
                var msg = "";
                if (successCount > 0)
                    msg = successCount.ToString() + " record" + ((successCount == 1) ? "" : "s") + " succeeded";
                if (successCount == 0 && failCount > 0)
                    msg = failCount.ToString() + " record" + ((failCount == 1) ? "" : "s") + " failed";
                else if (successCount > 0 && failCount > 0)
                    msg = successCount.ToString() + " record" + ((successCount == 1) ? "" : "s") + " succeeded and " + failCount.ToString() + " record" + ((failCount == 1) ? "" : "s") + " failed";
                strResultMessage = msg + " out of " + (successCount + failCount).ToString() + " records";
            }
            else
                throw new Exception("No Data Uploaded");
        }
        else
        {
            throw new Exception("Please Select Excel File.");
        }
    }
	public void Upload(string EntryBy, SqlParameter[] additionalPerameters )
    {

        if (fileUploadControl.HasFile)
        {
            string filepath = fileUploadControl.PostedFile.FileName;
            string pat = @"(?:.+)(.+)\.(.+)";

            Regex r = new Regex(pat);
            //run
            Match m = r.Match(filepath);
            string file_ext = m.Groups[2].Captures[0].ToString();
            string filename = strFileNamePrefix + "_" + DateTime.Now.ToString("ddMMyyyy") + "." + file_ext;


            if (file_ext.ToLower() != "xls" && file_ext.ToLower() != "xlsx" && file_ext.ToLower() != "csv")
                throw new Exception("Invalid File");

            string path = HttpContext.Current.Server.MapPath(strFilePath);

            if (Directory.Exists(path))
            {
                if (File.Exists(path + "\\" + filename))
                    File.Delete(path + "\\" + filename);
            }
            else
                Directory.CreateDirectory(path);

            fileUploadControl.SaveAs(path + "\\" + filename);
            ExcelUtilities exl = new ExcelUtilities();
            DataSet dsExcel = new DataSet();
            dsExcel = exl.GetExcelData(path + "\\" + filename);

            //dsExcel = ExcelUtils.GetExcelData(path + "\\" + filename);

            if (dsExcel == null)
            {
                throw new Exception("Invalid File. No Records Found");
            }
            DataTable dtExcel = dsExcel.Tables[0];


            if (dtExcel.Columns.Count != dtExcel.Columns.Count)
            {
                throw new Exception("Invalid no of columns.");
            }
            else if (dtExcel.Rows.Count < 1)
            {
                throw new Exception("Please input at-least one record.");
            }

            foreach (DataRow dr in dtFormat.Rows)
            {
                CheckValidColumnName(dtExcel, dr["FieldName"].ToString(), dr["FieldCaption"].ToString());
            }

                /*---------------------  Remove Blank Data Start ---------------------------*/
        GoTo:

            for (int i = 0; i < dtExcel.Rows.Count; i++)
            {
                //Change By Chirag --
                if (dtExcel.Rows[i][0].ToString() == "")
                {
                    dtExcel.Rows.RemoveAt(i);
                    goto GoTo;
                }
            }

            /*----------------------  Remove Blank Data End ---------------------------*/
            if (dtExcel.Rows.Count < 1)
            {
                throw new Exception("Please input at-least one record.");
            }

            dsExcel.DataSetName = strModuleName + "List";
            dsExcel.Tables[0].TableName = strModuleName;

            if (RequiredColumnMapping)
            {
                foreach (DataColumn dc in dsExcel.Tables[0].Columns)
                {
                    dc.ColumnMapping = MappingType.Attribute;
                }
            }

            if (File.Exists(path + "\\" + filename))
                File.Delete(path + "\\" + filename);

            var dsResult = new DataSet();

            using (var oDal = new WebXHelper())
            {
                oDal.BeginTransaction();
                try
                {
                    if (EntryBy != null)
                    {
                        List<SqlParameter> aryPrm = new  List<SqlParameter>();
                        //SqlParameter[] prm = { new SqlParameter("@XML", dsExcel.GetXml()),
                        //                    new SqlParameter("@EntryBy", EntryBy)};
                        aryPrm.Add( new SqlParameter("@XML", dsExcel.GetXml()));
                        aryPrm.Add( new SqlParameter("@EntryBy", EntryBy));

                        if (additionalPerameters!=null)
                        {
                            aryPrm.AddRange(additionalPerameters);
                        }

                        dsResult = oDal.ExecuteDataSet(CommandType.StoredProcedure, strProcedureName, aryPrm.ToArray());
                    }
                    else
                    {
                        SqlParameter[] prm = { new SqlParameter("@XML", dsExcel.GetXml()) };

                        dsResult = oDal.ExecuteDataSet(CommandType.StoredProcedure, strProcedureName, prm);
                    }


                    oDal.CommitTransaction();
                }
                catch (Exception ex)
                {
                    oDal.RollBackTransaction();
                    ExceptionUtils.LogException(ex, strModuleName + "-Upload");
                    throw;
                }
            }

            if (dsResult != null && dsResult.Tables.Count > 0)
            {
                dtResultSuccess = dsResult.Tables[0];

                if (dtResultSuccess.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtFormat.Rows)
                    {
                        SetCaption(dtResultSuccess, dr["FieldName"].ToString(), dr["FieldCaption"].ToString());
                    }
                }
                if (dsResult.Tables.Count > 1)
                {
                    dtResultFail = dsResult.Tables[1];
                    if (dtResultFail.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dtFormat.Rows)
                        {
                            SetCaption(dtResultFail, dr["FieldName"].ToString(), dr["FieldCaption"].ToString());
                        }
                    }
                }
                int successCount = 0, failCount = 0;
                successCount = dtResultSuccess.Rows.Count;
                failCount = dtResultFail.Rows.Count;
                var msg = "";
                if (successCount > 0)
                    msg = successCount.ToString() + " record" + ((successCount == 1) ? "" : "s") + " succeeded";
                if (successCount == 0 && failCount > 0)
                    msg = failCount.ToString() + " record" + ((failCount == 1) ? "" : "s") + " failed";
                else if (successCount > 0 && failCount > 0)
                    msg = successCount.ToString() + " record" + ((successCount == 1) ? "" : "s") + " succeeded and " + failCount.ToString() + " record" + ((failCount == 1) ? "" : "s") + " failed";
                strResultMessage = msg + " out of " + (successCount + failCount).ToString() + " records";
            }
            else
                throw new Exception("No Data Uploaded");
        }
        else
        {
            throw new Exception("Please Select Excel File.");
        }
    }
}
