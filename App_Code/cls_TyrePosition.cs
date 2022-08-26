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
public class cls_TyrePosition : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _TYREPOS_ID;
    private string _TYREPOS_CODE;
    private string _TYREPOS_DESC;
    private string _ACTIVE_FLAG;
    private string _VEHICLE_TYPE;
    private string _POS_ALLOWED;
    private string _TRUCK_TRAILER;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string TYREPOS_ID { get { return _TYREPOS_ID; } set { _TYREPOS_ID = value; } }
    public string TYREPOS_CODE { get { return _TYREPOS_CODE; } set { _TYREPOS_CODE = value; } }
    public string TYREPOS_DESC { get { return _TYREPOS_DESC; } set { _TYREPOS_DESC = value; } }
    public string ACTIVE_FLAG { get { return _ACTIVE_FLAG; } set { _ACTIVE_FLAG = value; } }
    public string VEHICLE_TYPE { get { return _VEHICLE_TYPE; } set { _VEHICLE_TYPE = value; } }
    public string POS_ALLOWED { get { return _POS_ALLOWED; } set { _POS_ALLOWED = value; } }
    public string TRUCK_TRAILER { get { return _TRUCK_TRAILER; } set { _TRUCK_TRAILER = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_TyrePosition(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    //public void BindGridTyrePosition(DataGrid dg)
    //{
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    SqlParameter[] prm = new SqlParameter[5];

    //    prm[0] = new SqlParameter("@TYREPOS_ID", (RemouldId == null) ? "" : RemouldId);
    //    prm[1] = new SqlParameter("@TYREPOS_CODE", TyreId);
    //    prm[2] = new SqlParameter("@TYREPOS_DESC", (CaptureKM == null) ? "" : CaptureKM);
    //    prm[3] = new SqlParameter("@ACTIVE_FLAG", (Cost == null) ? "" : Cost);
    //    prm[4] = new SqlParameter("@VEHICLE_TYPE", (TotalCost == null) ? "" : TotalCost);

    //    dcm.DataBind(dg, CommandType.StoredProcedure, "usp_Search_Tyre_Remould", prm);
    //}
    public void InsertTyrePosition()
    {
        SqlParameter[] prm = new SqlParameter[7];
        prm[0] = new SqlParameter("@TYREPOS_CODE", (TYREPOS_CODE == null) ? "" : TYREPOS_CODE);
        prm[1] = new SqlParameter("@TYREPOS_DESC", TYREPOS_DESC);
        prm[2] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
        prm[3] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);
        prm[4] = new SqlParameter("@TYREPOS_ID", TYREPOS_ID);
        prm[5] = new SqlParameter("@POS_ALLOWED", POS_ALLOWED);
        prm[6] = new SqlParameter("@TRUCK_TRAILER", TRUCK_TRAILER);  
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_INSERT_TYREPOSITION", prm);
    }
    //public void UpdateTyrePosition()
    //{
    //    SqlParameter[] prm = new SqlParameter[4];
    //    prm[0] = new SqlParameter("@TYREPOS_CODE", (TYREPOS_CODE == null) ? "" : TYREPOS_CODE);
    //    prm[1] = new SqlParameter("@TYREPOS_DESC", TYREPOS_DESC);
    //    prm[2] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
    //    prm[3] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "USP_INSERT_TYREPOSITION", prm);
    //}
    public void CheckValidTyrePos(string strTyrePosId)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@TYREPOS_CODE", TYREPOS_CODE);
        prm[1] = new SqlParameter("@TYREPOS_ID", strTyrePosId);
        prm[2] = new SqlParameter("@VEH_CATE", TRUCK_TRAILER); 
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Tyrepos_code", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TYREPOS_CODE = dt.Rows[0]["TYREPOS_CODE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

}
