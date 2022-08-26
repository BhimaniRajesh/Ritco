using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for cls_MVK_Upload
/// </summary>
public class cls_MVK_Upload : DataAccessLayer
{

    #region Private Declaration
    private string _VEHNO, _SQL_Data;
    private decimal _Odometer_reading;
    private string _Month;
    private decimal _Year;
    protected string _Connection_String;
    #endregion

    #region Properties
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public decimal Odometer_reading { get { return _Odometer_reading; } set { _Odometer_reading = value; } }
    public string Month { get { return _Month; } set { _Month = value; } }
    public decimal Year { get { return _Year; } set { _Year = value; } }
    public string SQL_Data { get { return _SQL_Data; } set { _SQL_Data = value; } }

    public string Connection_String { get { return _Connection_String; } set { _Connection_String = value; } }
    #endregion

    public cls_MVK_Upload(string AgilityERP_TestConnectionString)
        : base(AgilityERP_TestConnectionString)
	{
        _Connection_String = AgilityERP_TestConnectionString; 
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable MVK_XLS_Data(string strFileType, string strPath)
    {
        string OleDbConnStr = "";
        OleDbConnStr = ConfigurationManager.ConnectionStrings[strFileType].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT * FROM [Month_Vehicle_KM$] ORDER BY VEHNO", OleDbConnStr.Replace(strFileType, strPath));
        oleda.Fill(dt);
        return dt;
    }
    public DataTable MVK_Cols_N_Size()
    {
        DataTable dt = new DataTable();
        string strSQL = "SELECT COLUMN_NAME,DATA_TYPE,(CASE WHEN COLUMN_NAME + ' ' + DATA_TYPE + ' ' + [SIZE] IS NULL THEN COLUMN_NAME + ' ' + DATA_TYPE ELSE COLUMN_NAME + ' ' + DATA_TYPE + ' ' + [SIZE] END) + '''' + COLUMN_NAME + ''''  AS [COL_SIZE] FROM VW_MVK_Cols_N_Size ORDER BY COLUMN_NAME";
        dt = ExecuteDataTable(CommandType.Text, strSQL);
        return dt;
    }
    public DataTable XLS_Column_Counter(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT Top 1 * FROM [Month_Vehicle_KM$]", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_MVK_Header(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT DISTINCT VEHNO FROM [Month_Vehicle_KM$] WHERE VEHNO IS NOT NULL ORDER BY VEHNO", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_MVK_Details(string File_Type, string File_Path, string VEHNO)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter();

        if (cls_General.IsInt(VEHNO) || cls_General.IsDecimal(VEHNO) || cls_General.IsDouble(VEHNO))
            oleda = new OleDbDataAdapter("SELECT * FROM [Month_Vehicle_KM$] WHERE VEHNO = " + VEHNO.Trim() + " ORDER BY VEHNO", OleDbConnStr.Replace(File_Type, File_Path));
        else
            oleda = new OleDbDataAdapter("SELECT * FROM [Month_Vehicle_KM$] WHERE VEHNO = '" + VEHNO.Trim() + "' ORDER BY VEHNO", OleDbConnStr.Replace(File_Type, File_Path));

        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_MVK_Columns(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT Top 1 * FROM [Month_Vehicle_KM$]", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public bool CheckMVK()
    {
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VEHNO.Trim());

        if (HasRecord(CommandType.StoredProcedure, "usp_Check_MVK", prm))
            return true;
        else
            return false;

    }

    public void UpdateMVK()
    {
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@VEHNO", VEHNO);
        prm[1] = new SqlParameter("@Odometer_reading", Odometer_reading);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_MVK_Master", prm);
    }
    public void InsertXml()
    {
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@SQL_Data", SQL_Data);

        ExecuteNonQuery(CommandType.StoredProcedure, "usp_Insert_XML_Upload", prm);
    }
}
