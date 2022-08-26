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
public class cls_Tyre_Remould : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _TyreId;
    private string _CaptureKM;
    private string _Cost;
    private string _TotalCost;
    private string _RemouldTyreLife;
    private string _RemouldVendor;
    private string _RemouldDate;
    private string _RemouldId, _Avg_TWI, _Remould_Cost, _EnterBy, _VendorCode, _TYRE_STATUS;

    private string _TYRE_TREAD_DEPTH_32NDS, _TYRE_VEHNO, _KM_Read, _TYRE_COST, _TYRE_NO, _tyre_pattern, _New_Tyre_Pattern;
    protected bool _Is_Record_Found;

    #endregion

    #region Properties

    public string TYRE_STATUS { get { return _TYRE_STATUS; } set { _TYRE_STATUS = value; } }

    public string TyreId { get { return _TyreId; } set { _TyreId = value; } }
    public string CaptureKM { get { return _CaptureKM; } set { _CaptureKM = value; } }
    public string Cost { get { return _Cost; } set { _Cost = value; } }
    public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
    public string TotalCost { get { return _TotalCost; } set { _TotalCost = value; } }
    public string RemouldTyreLife { get { return _RemouldTyreLife; } set { _RemouldTyreLife = value; } }
    public string RemouldVendor { get { return _RemouldVendor; } set { _RemouldVendor = value; } }
    public string RemouldDate { get { return _RemouldDate; } set { _RemouldDate = value; } }
    public string RemouldId { get { return _RemouldId; } set { _RemouldId = value; } }
    public string Remould_Cost { get { return _Remould_Cost; } set { _Remould_Cost = value; } }
    public string EnterBy { get { return _EnterBy; } set { _EnterBy = value; } }

    public string TYRE_TREAD_DEPTH_32NDS { get { return _TYRE_TREAD_DEPTH_32NDS; } set { _TYRE_TREAD_DEPTH_32NDS = value; } }
    public string TYRE_VEHNO { get { return _TYRE_VEHNO; } set { _TYRE_VEHNO = value; } }
    public string KM_Read { get { return _KM_Read; } set { _KM_Read = value; } }
    public string TYRE_COST { get { return _TYRE_COST; } set { _TYRE_COST = value; } }
    public string TYRE_NO { get { return _TYRE_NO; } set { _TYRE_NO = value; } }
    public string tyre_pattern { get { return _tyre_pattern; } set { _tyre_pattern = value; } }
    public string New_Tyre_Pattern { get { return _New_Tyre_Pattern; } set { _New_Tyre_Pattern = value; } }

    public string Avg_TWI { get { return _Avg_TWI; } set { _Avg_TWI = value; } }

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_Tyre_Remould(string ConnectionString) : base(ConnectionString)
    { 
        _Connection_String = ConnectionString; 
    }
  
    public void BindGridTyreRemould(DataGrid dg)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[8];

        prm[0] = new SqlParameter("@RemouldId", (RemouldId == null) ? "" : RemouldId);
        prm[1] = new SqlParameter("@TyreId", TyreId);
        prm[2] = new SqlParameter("@CaptureKM", (CaptureKM == null) ? "" : CaptureKM);
        prm[3] = new SqlParameter("@Cost", (Cost == null) ? "" : Cost);
        prm[4] = new SqlParameter("@TotalCost", (TotalCost == null) ? "" : TotalCost);
        prm[5] = new SqlParameter("@RemouldTyreLife", (RemouldTyreLife == null) ? "" : RemouldTyreLife);
        prm[6] = new SqlParameter("@RemouldVendor", (RemouldVendor == null) ? "" : RemouldVendor);
        prm[7] = new SqlParameter("@RemouldDate", RemouldDate);
        
        dcm.DataBind(dg, CommandType.StoredProcedure, "usp_Search_Tyre_Remould", prm);
    }
    public void InsertTyreRemould()
    {
        SqlParameter[] prm = new SqlParameter[12];

        prm[0] = new SqlParameter("@Remould_Id", (RemouldId == null) ? "" : RemouldId);
        prm[1] = new SqlParameter("@Tyre_Id", TyreId);
        prm[2] = new SqlParameter("@Capture_KM", CaptureKM);
        prm[3] = new SqlParameter("@Remould_Date", RemouldDate);
        prm[4] = new SqlParameter("@Tyre_Pattern", tyre_pattern);
        prm[5] = new SqlParameter("@Tyre_Pattern_New", New_Tyre_Pattern);
        prm[6] = new SqlParameter("@Tyre_Purchase_Cost", Cost);
        prm[7] = new SqlParameter("@Remould_Cost", Remould_Cost);
        prm[8] = new SqlParameter("@TYRE_TREAD_DEPTH_32NDS", TYRE_TREAD_DEPTH_32NDS);
        prm[9] = new SqlParameter("@Averate_TWI_Remould", Avg_TWI);
        prm[10] = new SqlParameter("@Entry_By",EnterBy.Trim());
        prm[11] = new SqlParameter("@VendorCode", VendorCode.Trim());

        ExecuteNonQuery(CommandType.StoredProcedure, "usp_Insert_Tyre_Remould", prm);
    }
    public void CheckValidTyreId()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Tyre_No", TyreId);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Tyre_No", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            TyreId = dt.Rows[0]["TYRE_ID"].ToString();
            TYRE_NO = dt.Rows[0]["TYRE_NO"].ToString();
            TYRE_TREAD_DEPTH_32NDS = dt.Rows[0]["TYRE_TREAD_DEPTH_32NDS"].ToString();
            TYRE_VEHNO = dt.Rows[0]["TYRE_VEHNO"].ToString();
            KM_Read = dt.Rows[0]["KM_Read"].ToString();
            TYRE_COST = dt.Rows[0]["TYRE_COST"].ToString();
            tyre_pattern = dt.Rows[0]["tyre_pattern"].ToString();
            TYRE_STATUS = dt.Rows[0]["TYRE_STATUS"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
