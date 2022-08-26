using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for cls_VehicleLogEntry
/// </summary>
public class cls_VehicleLogEntry : DataAccessLayer
{
    public static string strTRIPSHEETNO = "", strCUSTOMER = "", strVEHNO="", strCATEGORY = "", strPRODUCT = "", strStartDt_From = "", strEndDt_To = "",strCompany="";

    #region Private Declaration
    private string _Connection_String;
    protected bool _Is_Record_Found;
    private string _VEHNO;
    private string _TYPE_NAME;
    private string _CAPACITY;
    private string _Driver_Name;
    private string _Driver_id;
    private string _CUSTNM;
    private string _CUSTCD;
    private string _LocName;
    private string _LocCode;
    private string _StartDateTime, _EndDateTime, _Hours, _Minute;

    #endregion

    #region Properties
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string TYPE_NAME { get { return _TYPE_NAME; } set { _TYPE_NAME = value; } }
    public string CAPACITY { get { return _CAPACITY; } set { _CAPACITY = value; } }
    public string Driver_Name { get { return _Driver_Name; } set { _Driver_Name = value; } }
    public string Driver_id { get { return _Driver_id; } set { _Driver_id = value; } }
    public string CUSTNM { get { return _CUSTNM; } set { _CUSTNM = value; } }
    public string CUSTCD { get { return _CUSTCD; } set { _CUSTCD = value; } }
    public string LocName { get { return _LocName; } set { _LocName = value; } }
    public string LocCode { get { return _LocCode; } set { _LocCode = value; } }

    public string StartDateTime { get { return _StartDateTime; } set { _StartDateTime = value; } }
    public string EndDateTime { get { return _EndDateTime; } set { _EndDateTime = value; } }
    public string Hours { get { return _Hours; } set { _Hours = value; } }
    public string Minute { get { return _Minute; } set { _Minute = value; } }

    #endregion

    public cls_VehicleLogEntry(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}


    public void CheckVehNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VEHNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_VehicleLogEntry", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            TYPE_NAME = dt.Rows[0]["TYPE_NAME"].ToString();
            CAPACITY = dt.Rows[0]["CAPACITY"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckDriverName()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Driver_Name", Driver_Name);
        //prm[2] = new SqlParameter("@Driver_id", Driver_Name);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_CheckDriver_VehicleLogEntry", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Driver_Name = dt.Rows[0]["Driver_Name"].ToString();
            Driver_id = dt.Rows[0]["Driver_id"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void CheckTransitTime()
    {
        DataTable dt = new DataTable();

        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@StartDateTime", StartDateTime);
        prm[1] = new SqlParameter("@EndDateTime", EndDateTime);


        dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_Fleet_CheckTransitTime", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            Hours = dt.Rows[0]["Hours"].ToString();
            Minute = dt.Rows[0]["Minute"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckIdleTime()
    {
        DataTable dt = new DataTable();

        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@StartDateTime", StartDateTime);
        prm[1] = new SqlParameter("@EndDateTime", EndDateTime);


        dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_Fleet_CheckIdleTime", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            Hours = dt.Rows[0]["Hours"].ToString();
            Minute = dt.Rows[0]["Minute"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void CheckLocationName()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@LocName", LocName);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_CheckLocName_VehicleLogEntry", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            LocName = dt.Rows[0]["LocName"].ToString();
            LocCode = dt.Rows[0]["LocCode"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }
   

    public void CheckValidCustomer()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@CUSTNM", CUSTNM);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_CheckCustNm_VehicleLogEntry", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            CUSTNM = dt.Rows[0]["CUSTNM"].ToString();
            CUSTCD = dt.Rows[0]["CUSTCD"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckValidVehNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VEHNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_CheckVehNo_VehicleLogEntry", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            //VEHNO = dt.Rows[0]["VEHNO"].ToString();
          
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void BindDropDown(DropDownList ddl, string strSQL)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, strSQL);
    }
    
}
