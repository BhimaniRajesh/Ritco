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
/// Summary description for cls_TyrePosition
/// </summary>
public class cls_VehicllTracking : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String;
    private string _VehNo;
    private string _VEH_INTERNAL_NO;
    private string _CURRENT_KM_READ;
    private string _VSLIPNO;
    private string _Locaiton;
    private string _Tracking_Date;
    private string _Tracking_Time;
    private string _Entry_By, _Remarks;
    protected bool _Is_Record_Found;

    #endregion

    #region Properties


    public string VehNo { get { return _VehNo; } set { _VehNo = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string VSLIPNO { get { return _VSLIPNO; } set { _VSLIPNO = value; } }
    public string CURRENT_KM_READ { get { return _CURRENT_KM_READ; } set { _CURRENT_KM_READ = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string Locaiton { get { return _Locaiton; } set { _Locaiton = value; } }
    public string Tracking_Date { get { return _Tracking_Date; } set { _Tracking_Date = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string Remarks { get { return _Remarks; } set { _Remarks = value; } }
    public string Tracking_Time { get { return _Tracking_Time; } set { _Tracking_Time = value; } }
    
    #endregion

    public cls_VehicllTracking(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void CheckValidVehNo(string strVehNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Veh_No_VehicleTracking", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            CURRENT_KM_READ = dt.Rows[0]["Current_KM_Read"].ToString();
            VSLIPNO = dt.Rows[0]["VSLIPNO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void checkLocation(string strLocation)
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT LOCNAME FROM WEBX_LOCATION WHERE LOCNAME='" + strLocation + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void checkTSNumber(string strVehno,string strTSNo)
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT *FROM WEBX_FLEET_VEHICLE_ISSUE WHERE VEHICLENO='" + strVehno + "' AND VSLIPNO='"+ strTSNo +"'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void Insert_Webx_Fleet_Vehicle_Tracking()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@Vehicle_No", VehNo);
        prm[1] = new SqlParameter("@Tripsheet_No", VSLIPNO);
        prm[2] = new SqlParameter("@Locaiton", Locaiton);
        prm[3] = new SqlParameter("@Tracking_Date", Tracking_Date);
        prm[4] = new SqlParameter("@Entry_By", Entry_By);
        prm[5] = new SqlParameter("@Remarks", Remarks);
        prm[6] = new SqlParameter("@Tracking_Time", Tracking_Time);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_Vehicle_Tracking", prm);
    }
    public void BindGrid(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VehNo", (VehNo == null) ? "" : VehNo);

        dcm.DataBind(gv, CommandType.StoredProcedure, "usp_Search_Webx_Fleet_Vehicle_Tracking", prm);
    }
}
