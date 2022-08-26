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
/// Summary description for cls_Tyre_Upload
/// </summary>
public class cls_Tyre_Upload : DataAccessLayer
{   
    #region Private Declaration
    private string _Tyre_Id;
    private string _Tyre_No;
    private decimal _TYRE_OPKM_RUN;
    private string _TRUCK_TRAILER;
    private string _POS_ALLOWED;
    private string _TYREPOS_CODE;
    private string _TYREPOS_ID;
    private string _TYRE_VEHNO;       
    protected string _Connection_String;
    #endregion

    #region Properties
    public string Tyre_Id { get { return _Tyre_Id; } set { _Tyre_Id = value; } }
    public string Tyre_No { get { return _Tyre_No; } set { _Tyre_No = value; } }
    public decimal TYRE_OPKM_RUN { get { return _TYRE_OPKM_RUN; } set { _TYRE_OPKM_RUN = value; } }
    public string TRUCK_TRAILER { get { return _TRUCK_TRAILER; } set { _TRUCK_TRAILER = value; } }
    public string POS_ALLOWED { get { return _POS_ALLOWED; } set { _POS_ALLOWED = value; } }
    public string TYREPOS_ID { get { return _TYREPOS_ID; } set { _TYREPOS_ID = value; } }
    public string TYRE_VEHNO { get { return _TYRE_VEHNO; } set { _TYRE_VEHNO = value; } }
    public string TYREPOS_CODE { get { return _TYREPOS_CODE; } set { _TYREPOS_CODE = value; } }
    public string Connection_String { get { return _Connection_String; } set { _Connection_String = value; } }
    #endregion

    public cls_Tyre_Upload(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString; 
	}

    public DataTable Tyre_XLS_Data(string strFileType, string strPath)
    {
        string OleDbConnStr = "";
        OleDbConnStr = ConfigurationManager.ConnectionStrings[strFileType].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT * FROM [Tyre_Upload$] ORDER BY Tyre_No", OleDbConnStr.Replace(strFileType, strPath));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_Column_Counter(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT Top 1 * FROM [Tyre_Upload$]", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    //public DataTable Tyre_SQL_Cols()
    //{
    //    DataTable dt = new DataTable();
    //    string strSQL = "select Tyre_No,TYRE_OPKM_RUN,TYREPOS_ID,TYRE_VEHNO from WEBX_FLEET_TYREMST";
    //    dt = ExecuteDataTable(CommandType.Text, strSQL);
    //    return dt;
    //}

    public DataTable XLS_Tyre_Header(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT DISTINCT Tyre_No FROM [Tyre_Upload$] WHERE Tyre_No IS NOT NULL ORDER BY Tyre_No", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_Tyre_Details(string File_Type, string File_Path, string Tyre_No)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter();

        if (cls_General.IsInt(Tyre_No) || cls_General.IsDecimal(Tyre_No) || cls_General.IsDouble(Tyre_No))
            oleda = new OleDbDataAdapter("SELECT * FROM [Tyre_Upload$] WHERE Tyre_No = " + Tyre_No.Trim() + " ORDER BY Tyre_No", OleDbConnStr.Replace(File_Type, File_Path));
        else
            oleda = new OleDbDataAdapter("SELECT * FROM [Tyre_Upload$] WHERE Tyre_No = '" + Tyre_No.Trim() + "' ORDER BY Tyre_No", OleDbConnStr.Replace(File_Type, File_Path));

        oleda.Fill(dt);
        return dt;
    }

    public DataTable XLS_Tyre_Columns(string File_Type, string File_Path)
    {
        string OleDbConnStr = ConfigurationManager.ConnectionStrings[File_Type].ConnectionString;
        DataTable dt = new DataTable();
        OleDbDataAdapter oleda = new OleDbDataAdapter("SELECT Top 1 * FROM [Tyre_Upload$]", OleDbConnStr.Replace(File_Type, File_Path));
        oleda.Fill(dt);
        return dt;
    }

    public bool CheckTyre()
    {
        SqlParameter[] prm = new SqlParameter[1];
      
        prm[0] = new SqlParameter("@Tyre_No", Tyre_No.Trim());
       
        if (HasRecord(CommandType.StoredProcedure, "usp_Check_Tyre", prm))
            return true;
        else
            return false;

    }

    public bool CheckVehNo()
    {
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", TYRE_VEHNO.Trim());

        if (HasRecord(CommandType.StoredProcedure, "usp_Check_VehNo", prm))
            return true;
        else
            return false;

    }

    public bool CheckPosCategory()
    {
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@TYREPOS_CODE", TYREPOS_ID.Trim());
        prm[1] = new SqlParameter("@TRUCK_TRAILER", TRUCK_TRAILER.Trim());
        prm[2] = new SqlParameter("@POS_ALLOWED", POS_ALLOWED.Trim());

        if (HasRecord(CommandType.StoredProcedure, "usp_check_Category", prm))
            return true;
        else
            return false;

    }


    //public bool CheckTyrePos()
    //{
    //    SqlParameter[] prm = new SqlParameter[3];

    //    prm[0] = new SqlParameter("@TYREPOS_ID", TYREPOS_ID.Trim());
    //    prm[1] = new SqlParameter("@POS_ALLOWED", POS_ALLOWED.Trim());
    //    prm[2] = new SqlParameter("@TRUCK_TRAILER", TRUCK_TRAILER.Trim());

    //    if (HasRecord(CommandType.StoredProcedure, "usp_check_tyrepos", prm))
    //        return true;
    //    else
    //        return false;

    //}

    public void UpdateTyre()
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@Tyre_No", Tyre_No);
        prm[1] = new SqlParameter("@TYRE_OPKM_RUN", TYRE_OPKM_RUN);
        prm[2] = new SqlParameter("@TYREPOS_ID", TYREPOS_ID);
        prm[3] = new SqlParameter("@TYRE_VEHNO", TYRE_VEHNO);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_Tyre_Master", prm);
    }
  
}
