using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for FileUploadUtility
/// </summary>
public class FileUploadUtility
{
    public FileUploadUtility()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //below method will upload file to given default file folder used in THC Generation
    public static string UploadFile(FileUpload fileUpload, string defaultFileFolder, string yearMonthDirReq_YN, string strNewFileNm, string strPrefix, int MaxSizeAllowed, string[] AllowedExtensions)
    {
        double dblFileSize = 0;

        string newFName = "", YMDir = "", filePath = "";
        try
        {
            if (fileUpload.HasFile)
            {
                //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
                //dtfi.ShortDatePattern = "dd/MM/yyyy";
                //dtfi.DateSeparator = "/";
                //DateTime docDate = Convert.ToDateTime(System.DateTime.Now.ToString());
                //string docDateStr = docDate.ToString("dd MM yy hh mm ss sss");
                //filNm = docDateStr;
                //newFName = GetFileName(fileUpload.PostedFile.FileName, docDateStr, "");

                newFName = GetFileName(fileUpload.PostedFile.FileName, strNewFileNm, strPrefix);
                if (yearMonthDirReq_YN == "Y")
                {
                    YMDir = CreateYearMonthDir(defaultFileFolder);
                    filePath = defaultFileFolder + @"\" + YMDir + @"\" + newFName;
                }
                else
                    filePath = defaultFileFolder + @"\" + newFName;


                int extCnt = 0;
                string allowedFileExtList = "";
                string fileExtension = System.IO.Path.GetExtension(fileUpload.PostedFile.FileName).ToLower();

                for (int i = 0; i < AllowedExtensions.Length; i++)
                {
                    if (fileExtension.Trim() == AllowedExtensions[i].Trim())
                    {
                        extCnt++;
                    }
                    allowedFileExtList = allowedFileExtList + AllowedExtensions[i].ToString() + ", ";
                }
                allowedFileExtList = allowedFileExtList.Trim().TrimEnd(',');
                if (extCnt == 0)
                {
                    throw new Exception("File Cannot Be Uploaded!!! File Types Allowed: " + allowedFileExtList.ToString());
                }
                dblFileSize = Math.Ceiling(Convert.ToDouble(fileUpload.PostedFile.ContentLength) / 1024);
                //double MaxSize = 1024; //1MB

                if (dblFileSize > MaxSizeAllowed)
                {
                    throw new Exception("File size can not be more than " + MaxSizeAllowed.ToString("0") + " KB");
                }

                if (CheckDocumentExistance(filePath) == true)
                {
                    //throw new Exception("Please Upload File Again.");
                    File.Delete(filePath);
                }
                if (CheckDocumentsDirectory(defaultFileFolder) == false)
                {
                    //throw new Exception("Fail to create directory!! ");
                }
                else
                {
                    fileUpload.SaveAs(filePath);
                }
            }
        }
        catch (Exception exp)
        {
            throw exp;
        }
        return filePath;
    }

    public static bool CheckDocumentsDirectory(string defaultFileFolder)
    {
        try
        {
            string strDirectoryName = defaultFileFolder;
            if (Directory.Exists(strDirectoryName))
            {
                return true;
            }
            else
            {
                Directory.CreateDirectory(strDirectoryName);
                return true;
            }
        }
        catch (Exception Ex)
        {
            return false;
        }
    }

    public static bool CheckDocumentExistance(string FileName)
    {
        try
        {
            return File.Exists(FileName);
        }
        catch (Exception Ex)
        {
            return false;
        }
    }

    public static string GetFileName(string fileName, string docno, string pref)
    {
        string strRet = fileName;

        string pat = @"(?:.+)(.+)\.(.+)";
        Regex r = new Regex(pat);
        //run
        Match m = r.Match(fileName);
        string file_ext = m.Groups[2].Captures[0].ToString();
        string filename = m.Groups[1].Captures[0].ToString();
        
        docno = docno.Replace("/", "");
        docno = docno.Replace(" ", "");
        docno = docno.Replace(".", "");
        docno = docno.Replace("_", "");

        if (pref.Trim() == "")
            strRet = docno + "." + file_ext;
        else
            strRet = pref + "_" + docno + "." + file_ext;

        return strRet;
    }

    public static string CreateYearMonthDir(string defaultFileFolder)
    {

        string YearMonth;
        string thisDir;
        thisDir = defaultFileFolder;

        YearMonth = DateTime.Now.ToString("yyyy").Trim();
        thisDir = thisDir + "\\" + DateTime.Now.ToString("yyyy").Trim();

        if (!System.IO.Directory.Exists(thisDir))
        {
            System.IO.Directory.CreateDirectory(thisDir);
        }


        YearMonth = YearMonth + "\\" + DateTime.Now.ToString("MMM").Trim();
        thisDir = thisDir + "\\" + DateTime.Now.ToString("MMM").Trim();

        if (!System.IO.Directory.Exists(thisDir))
        {
            System.IO.Directory.CreateDirectory(thisDir);
        }
        return YearMonth;
    }
}