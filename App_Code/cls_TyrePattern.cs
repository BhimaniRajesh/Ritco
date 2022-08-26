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
/// Summary description for cls_TyrePattern
/// </summary>
public class cls_TyrePattern : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _TYRE_PATTERNID;
    private string _TYREPAT_CODE;
    private string _TYRE_PATTERN_DESC;
    private string _POS_ALLOWED;
    private string _ACTIVE_FLAG;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string TYRE_PATTERNID { get { return _TYRE_PATTERNID; } set { _TYRE_PATTERNID = value; } }
    public string TYREPAT_CODE { get { return _TYREPAT_CODE; } set { _TYREPAT_CODE = value; } }
    public string TYRE_PATTERN_DESC { get { return _TYRE_PATTERN_DESC; } set { _TYRE_PATTERN_DESC = value; } }
    public string POS_ALLOWED { get { return _POS_ALLOWED; } set { _POS_ALLOWED = value; } }
    public string ACTIVE_FLAG { get { return _ACTIVE_FLAG; } set { _ACTIVE_FLAG = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_TyrePattern(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    //public void BindGridTyrePattern(DataGrid dg)
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
    public void InsertTyrePattern()
    {
        SqlParameter[] prm = new SqlParameter[5];
        prm[0] = new SqlParameter("@TYRE_PATTERNID", TYRE_PATTERNID);
        prm[1] = new SqlParameter("@TYREPAT_CODE", (TYREPAT_CODE == null) ? "" : TYREPAT_CODE);
        prm[2] = new SqlParameter("@TYRE_PATTERN_DESC", TYRE_PATTERN_DESC);
        prm[3] = new SqlParameter("@POS_ALLOWED", POS_ALLOWED);
        prm[4] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_INSERT_TYREPATTERN", prm);
    }
    //public void UpdateTyrePattern()
    //{
    //    SqlParameter[] prm = new SqlParameter[4];
    //    prm[0] = new SqlParameter("@TYREPOS_CODE", (TYREPOS_CODE == null) ? "" : TYREPOS_CODE);
    //    prm[1] = new SqlParameter("@TYREPOS_DESC", TYREPOS_DESC);
    //    prm[2] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
    //    prm[3] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "USP_INSERT_TYREPattern", prm);
    //}
    public void CheckValidTyrePat(string strTyrePatID)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@TYREPAT_CODE", TYREPAT_CODE);
        prm[1] = new SqlParameter("@TYREPAT_ID", strTyrePatID);
        
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Tyrepat_code", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TYREPAT_CODE = dt.Rows[0]["TYREPAT_CODE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

}
