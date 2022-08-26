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
/// Summary description for cls_Tyre_Remould
/// </summary>
public class cls_TyreOdometer : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private int _Tran_No;
    private DateTime _Tran_Dt;
    private string _VehicleNo;
    private double _Last_Km_Reading;
    private double _Odometer_Reading;
    private DateTime _Odometer_Reading_Dt;
    private string _VEH_INTERNAL_NO;
    private string _CURRENT_KM_READ;
    private string _Odometer_Reason;
    private string _TripSheetNo;
    private string _VehicleStatus;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public int Tran_No { get { return _Tran_No; } set { _Tran_No = value; } }
    public DateTime Tran_Dt { get { return _Tran_Dt; } set { _Tran_Dt = value; } }
    public string VehicleNo { get { return _VehicleNo; } set { _VehicleNo = value; } }
    public string TripSheetNo { get { return _TripSheetNo; } set { _TripSheetNo = value; } }
    public string VehicleStatus { get { return _VehicleStatus; } set { _VehicleStatus = value; } }
    public double Last_Km_Reading { get { return _Last_Km_Reading; } set { _Last_Km_Reading = value; } }
    public double Odometer_Reading { get { return _Odometer_Reading; } set { _Odometer_Reading = value; } }
    public DateTime Odometer_Reading_Dt { get { return _Odometer_Reading_Dt; } set { _Odometer_Reading_Dt = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string CURRENT_KM_READ { get { return _CURRENT_KM_READ; } set { _CURRENT_KM_READ = value; } }
    public string Odometer_Reason { get { return _Odometer_Reason; } set { _Odometer_Reason = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_TyreOdometer(string ConnectionString) : base(ConnectionString)
    { 
        _Connection_String = ConnectionString; 
    }
  
    //public void BindGridTyreRemould(DataGrid dg)
    //{
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    SqlParameter[] prm = new SqlParameter[8];

    //    prm[0] = new SqlParameter("@RemouldId", (RemouldId == null) ? "" : RemouldId);
    //    prm[1] = new SqlParameter("@TyreId", TyreId);
    //    prm[2] = new SqlParameter("@CaptureKM", (CaptureKM == null) ? "" : CaptureKM);
    //    prm[3] = new SqlParameter("@Cost", (Cost == null) ? "" : Cost);
    //    prm[4] = new SqlParameter("@TotalCost", (TotalCost == null) ? "" : TotalCost);
    //    prm[5] = new SqlParameter("@RemouldTyreLife", (RemouldTyreLife == null) ? "" : RemouldTyreLife);
    //    prm[6] = new SqlParameter("@RemouldVendor", (RemouldVendor == null) ? "" : RemouldVendor);
    //    prm[7] = new SqlParameter("@RemouldDate", RemouldDate);
        
    //    dcm.DataBind(dg, CommandType.StoredProcedure, "usp_Search_Tyre_Remould", prm);
    //}
    public void InsertTyreRemould()
    {
        SqlParameter[] prm = new SqlParameter[6];
        prm[0] = new SqlParameter("@Tran_No", (Tran_No == null) ? 0 : Tran_No);
        prm[1] = new SqlParameter("@VehicleNo", VehicleNo);
        prm[2] = new SqlParameter("@Last_Km_Reading", Last_Km_Reading);
        prm[3] = new SqlParameter("@Odometer_Reading", Odometer_Reading);
        prm[4] = new SqlParameter("@Odometer_Reading_Dt", Odometer_Reading_Dt);
        prm[5] = new SqlParameter("@Odometer_Reason", Odometer_Reason);
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_INS_UP_TYREODOMETER", prm);
    }
    public void GetVehIDKM()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VehicleNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Get_Veh_ID_KM", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VehicleNo = dt.Rows[0]["VEHNO"].ToString();
            CURRENT_KM_READ = dt.Rows[0]["CURRENT_KM_READ"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            TripSheetNo = dt.Rows[0]["VSLIPNO"].ToString();
            VehicleStatus = dt.Rows[0]["Vehicle_Status"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
