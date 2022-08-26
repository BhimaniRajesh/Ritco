using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for SMvehiclewiseUpload
/// </summary>
public class cls_SMvehiclewiseUpload : DataAccessLayer
{
    #region Private Declaration
    private string _VEHNO;
    private string _SMTask_Id;
    private DateTime _LastSM_Dt;
    private decimal _LastSM_KM_Read;
    private string _SQL_Data;
    protected string _Connection_String;
    #endregion

    #region Properties
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string SMTask_Id { get { return _SMTask_Id; } set { _SMTask_Id = value; } }
    public DateTime LastSM_Dt { get { return _LastSM_Dt; } set { _LastSM_Dt = value; } }
    public decimal LastSM_KM_Read { get { return _LastSM_KM_Read; } set { _LastSM_KM_Read = value; } }
    public string SQL_Data { get { return _SQL_Data; } set { _SQL_Data = value; } }
    public string Connection_String { get { return _Connection_String; } set { _Connection_String = value; } }
    #endregion

    public cls_SMvehiclewiseUpload(string AgilityERP_TestConnectionString)
        : base(AgilityERP_TestConnectionString)
	{
        _Connection_String = AgilityERP_TestConnectionString; 
		//
		// TODO: Add constructor logic here
		//
	}

    public DataTable SM_XLS_Data(string strFileType, string strPath)
    {
        string OleDbConnStr = "";
        OleDbConnStr = ConfigurationManager.ConnectionStrings[strFileType].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT * FROM [SM_Upload$] ORDER BY SMTask_Id", OleDbConnStr.Replace(strFileType, strPath));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_Column_Counter(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT Top 1 * FROM [SM_Upload$]", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_SM_Header(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT DISTINCT SMTask_Id FROM [SM_Upload$] WHERE SMTask_Id IS NOT NULL ORDER BY SMTask_Id", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_SM_Details(string File_Type, string File_Path, string SMTask_Id)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter();

        if (cls_General.IsInt(SMTask_Id) || cls_General.IsDecimal(SMTask_Id) || cls_General.IsDouble(SMTask_Id))
            oleda = new OleDbDataAdapter("SELECT * FROM [SM_Upload$] WHERE SMTask_Id = " + SMTask_Id.Trim() + " ORDER BY SMTask_Id", OleDbConnStr.Replace(File_Type, File_Path));
        else
            oleda = new OleDbDataAdapter("SELECT * FROM [SM_Upload$] WHERE SMTask_Id = '" + SMTask_Id.Trim() + "' ORDER BY SMTask_Id", OleDbConnStr.Replace(File_Type, File_Path));

        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_SM_Columns(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT Top 1 * FROM [SM_Upload$]", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable SM_Cols_N_Size()
    {
        DataTable dt = new DataTable();
        string strSQL = "SELECT COLUMN_NAME,DATA_TYPE,(CASE WHEN COLUMN_NAME + ' ' + DATA_TYPE + ' ' + [SIZE] IS NULL THEN COLUMN_NAME + ' ' + DATA_TYPE ELSE COLUMN_NAME + ' ' + DATA_TYPE + ' ' + [SIZE] END) + '''' + COLUMN_NAME + ''''  AS [COL_SIZE] FROM VW_SM_Cols_N_Size ORDER BY COLUMN_NAME";
        dt = ExecuteDataTable(CommandType.Text, strSQL);
        return dt;
    }

    public bool CheckSM()
    {
        SqlParameter[] prm = new SqlParameter[1];
    
        prm[0] = new SqlParameter("@VEHNO", VEHNO.Trim());

        if (HasRecord(CommandType.StoredProcedure, "usp_Check_SM", prm))
            return true;
        else
            return false;

    }

    public bool CheckSMTask_id()
    {
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@SMTask_Id", SMTask_Id.Trim());
        prm[1] = new SqlParameter("@VEHNO", VEHNO.Trim());

        if (HasRecord(CommandType.StoredProcedure, "usp_Check_SMTask_Id", prm))
            return true;
        else
            return false;

    }

    public void InsertSMXml()
    {
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@SQL_Data", SQL_Data);

        ExecuteNonQuery(CommandType.StoredProcedure, "usp_Insert_XML_Upload", prm);
    }

}
