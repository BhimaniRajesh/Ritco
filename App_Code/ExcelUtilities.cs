using System;
using System.Collections.Generic;
using System.Web;
using System.Reflection;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using Excel;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;

/// <summary>
/// Summary description for ExcelUtilities
/// </summary>
public class ExcelUtilities
{
    private string _Error_Message = "";
    public string Error_Message { get { return _Error_Message; } set { _Error_Message = value; } }

	public ExcelUtilities()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
    public DataSet GetExcelData(string fileName)
    {
        DataSet ds = new DataSet();
        try
        {
            Regex r = new Regex(@"(?:.+)(.+)\.(.+)");
            //run
            Match m = r.Match(fileName);
            string file_ext = m.Groups[2].Captures[0].ToString();

            if (file_ext.ToLower() != "xls" && file_ext.ToLower() != "xlsx")
                throw new Exception("Invalied File");

            FileStream stream = File.Open(fileName, FileMode.Open, FileAccess.Read);
            try
            {
                if (file_ext.ToLower() == "xls")
                {
                    IExcelDataReader excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
                    excelReader.IsFirstRowAsColumnNames = true;
                    ds = excelReader.AsDataSet();
                }
                if (file_ext.ToLower() == "xlsx")
                {
                    IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                    excelReader.IsFirstRowAsColumnNames = true;
                    ds = excelReader.AsDataSet();
                }
            }
            catch (Exception exc)
            {
                throw exc;
            }
            finally
            {
                stream.Close();
                stream.Dispose();
            }
        }
        catch (Exception ex)
        {
            Error_Message = ex.Message;
            ds = null;
        }
        finally
        {
            //dispose objects
        }
        return ds;
    }

    public static DataSet ReadExcelData(string fileName)
    {
        DataSet ds = new DataSet();
        try
        {
            Regex r = new Regex(@"(?:.+)(.+)\.(.+)");
            //run
            Match m = r.Match(fileName);
            string file_ext = m.Groups[2].Captures[0].ToString();

            if (file_ext.ToLower() != "xls" && file_ext.ToLower() != "xlsx")
                throw new Exception("Invalied File");

            FileStream stream = File.Open(fileName, FileMode.Open, FileAccess.Read);
            try
            {
                if (file_ext.ToLower() == "xls")
                {
                    IExcelDataReader excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
                    excelReader.IsFirstRowAsColumnNames = true;
                    ds = excelReader.AsDataSet();
                }
                if (file_ext.ToLower() == "xlsx")
                {
                    IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
                    excelReader.IsFirstRowAsColumnNames = true;
                    ds = excelReader.AsDataSet();
                }
            }
            catch (Exception exc)
            {
                throw exc;
            }
            finally
            {
                stream.Close();
                stream.Dispose();
            }
        }
        catch (Exception ex)
        {
            ds = null;
            throw ex;
        }
        finally
        {
            //dispose objects
        }
        return ds;
    }

    public void ExportExcel_XLSX(DataSet ds, string filename)
    {
        using (ExcelPackage pck = new ExcelPackage())
        {
            foreach (DataTable dt in ds.Tables)
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add(dt.TableName);
                int col = 1;
                foreach (DataColumn c in dt.Columns)
                {
                    int row = 1;
                    ws.Cells[row, col].Value = c.ColumnName;                    
                    ws.Cells[row, col].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    ws.Cells[row, col].Style.Fill.BackgroundColor.SetColor(Color.LightSlateGray);
                    ws.Cells[row, col].Style.Font.Color.SetColor(Color.White);
                    ws.Cells[row, col].Style.Font.Bold = true;
                    ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                    row = 2;
                    foreach (DataRow dr in dt.Rows)
                    {   
                        ws.Cells[row, col].Value = dr[c.ColumnName].ToString(); 
                        ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        row++;
                    }
                    col++;
                }
            }
            //Write it back to the client
            //HttpContext.Current.Response.ContentType = "Application/x-msexcel";
            HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + filename);
            HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
        }
    }

    public void ExportExcel(DataSet ds, string fileName)
    {
        //create new xls file
        string filePath = HttpContext.Current.Server.MapPath("./" + fileName);
        if (File.Exists(filePath))
            File.Delete(filePath);
       
        using (ExcelPackage pck = new ExcelPackage())
        {   
            foreach (DataTable dt in ds.Tables)
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add(dt.TableName);
                int col = 1;
                foreach (DataColumn c in dt.Columns)
                {
                    int row = 1;
                    ws.Cells[row, col].Value = c.ColumnName;
                    ws.Cells[row, col].Style.Fill.PatternType = ExcelFillStyle.Solid;
                    ws.Cells[row, col].Style.Fill.BackgroundColor.SetColor(Color.LightSlateGray);                   
                    ws.Cells[row, col].Style.Font.Color.SetColor(Color.White);
                    ws.Cells[row, col].Style.Font.Bold = true;
                    ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                    row = 2;
                    foreach (DataRow dr in dt.Rows)
                    {
                        ws.Cells[row, col].Value = dr[c.ColumnName].ToString();
                        ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        row++;
                    }
                    col++;
                }
            }
            pck.SaveAs(new FileInfo(filePath));
        }

        HttpContext.Current.Response.Redirect("./" + fileName,false);
    }
}
