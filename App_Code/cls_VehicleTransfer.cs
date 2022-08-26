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
/// Summary description for cls_VehicleTransfer
/// </summary>
public class cls_VehicleTransfer : DataAccessLayer
{
    #region Private Declaration
    private string _Connection_String;
    private string _VEHNO;
    private string _VEH_INTERNAL_NO;
    private string _CURLOC;
    private string _Current_KM_Read;
    private string _LocCode;
    private string _VEHREGNO;
    protected bool _Is_Record_Found;
    private string _New_VehicleNo, _New_Control_Loc, _Veh_Transfer_Date;
    private string _EntryBy, _UpdatedBy;
    private DateTime _EntryDt, _UpdatedDt;
    private string _Conrtl_branch;
    private string _Vehicle_Status, _JS_Maintainance_Status;
    #endregion

    #region Properties
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string CURLOC { get { return _CURLOC; } set { _CURLOC = value; } }
    public string Current_KM_Read { get { return _Current_KM_Read; } set { _Current_KM_Read = value; } }

    public string New_VehicleNo { get { return _New_VehicleNo; } set { _New_VehicleNo = value; } }
    public string New_Control_Loc { get { return _New_Control_Loc; } set { _New_Control_Loc = value; } }
    public string Veh_Transfer_Date { get { return _Veh_Transfer_Date; } set { _Veh_Transfer_Date = value; } }

    public string LocCode { get { return _LocCode; } set { _LocCode = value; } }
    public string VEHREGNO { get { return _VEHREGNO; } set { _VEHREGNO = value; } }

    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public DateTime EntryDt { get { return _EntryDt; } set { _EntryDt = value; } }
    public string UpdatedBy { get { return _UpdatedBy; } set { _UpdatedBy = value; } }
    public DateTime UpdatedDt { get { return _UpdatedDt; } set { _UpdatedDt = value; } }
    public string Conrtl_branch { get { return _Conrtl_branch; } set { _Conrtl_branch = value; } }

    public string Vehicle_Status { get { return _Vehicle_Status; } set { _Vehicle_Status = value; } }
    public string JS_Maintainance_Status { get { return _JS_Maintainance_Status; } set { _JS_Maintainance_Status = value; } }



    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_VehicleTransfer(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }

    public void GetVehicleNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VEHNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_VehicleNo", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            Conrtl_branch = dt.Rows[0]["Conrtl_branch"].ToString();
            Current_KM_Read = dt.Rows[0]["Current_KM_Read"].ToString();
            Vehicle_Status = dt.Rows[0]["Vehicle_Status"].ToString();
            JS_Maintainance_Status = dt.Rows[0]["JS_Maintainance_Status"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }


    public void GetNewVehicleNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VEHNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_New_VehicleNo", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VEHNO = dt.Rows[0]["VEHNO"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetNewControllingBranch()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@LocCode", LocCode);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_New_Controlling_Branch", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            LocCode = dt.Rows[0]["LocCode"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetTransferDate()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@VEHNO", VEHNO);
        prm[1] = new SqlParameter("@Transfer_dt", VEHREGNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_TRANSFER_DATE", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            VEHREGNO = dt.Rows[0]["VEHREGNO"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void InsertVehicleTransfer()
    {
        SqlParameter[] prm = new SqlParameter[8];

        prm[0] = new SqlParameter("@VehicleNo", VEHNO);
        prm[1] = new SqlParameter("@Vehicle_Internal_No", VEH_INTERNAL_NO);
        prm[2] = new SqlParameter("@Old_Control_Loc", CURLOC);
        prm[3] = new SqlParameter("@Vehicle_KM_Reading", Current_KM_Read);
        prm[4] = new SqlParameter("@New_VehicleNo", New_VehicleNo);
        prm[5] = new SqlParameter("@New_Control_Loc", New_Control_Loc);
        prm[6] = new SqlParameter("@Veh_Transfer_Date", Veh_Transfer_Date);
        prm[7] = new SqlParameter("@EntryBy", EntryBy);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Fleet_Vehicle_transfer", prm);
    }
}
