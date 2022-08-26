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
public class cls_TyreModel : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _TYRE_MODEL_ID;
    private string _MFG_ID;
    private string _MODEL_NO;
    private string _MODEL_DESC;
    private string _TREAD_DEPTH;
    private string _TYRE_PATTERNID;
    private string _TYRE_SIZEID;
    private string _ACTIVE_FLAG;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string TYRE_MODEL_ID { get { return _TYRE_MODEL_ID; } set { _TYRE_MODEL_ID = value; } }
    public string MFG_ID { get { return _MFG_ID; } set { _MFG_ID = value; } }
    public string MODEL_NO { get { return _MODEL_NO; } set { _MODEL_NO = value; } }
    public string MODEL_DESC { get { return _MODEL_DESC; } set { _MODEL_DESC = value; } }
    public string TREAD_DEPTH { get { return _TREAD_DEPTH; } set { _TREAD_DEPTH = value; } }
    public string TYRE_PATTERNID { get { return _TYRE_PATTERNID; } set { _TYRE_PATTERNID = value; } }
    public string TYRE_SIZEID { get { return _TYRE_SIZEID; } set { _TYRE_SIZEID = value; } }
    public string ACTIVE_FLAG { get { return _ACTIVE_FLAG; } set { _ACTIVE_FLAG = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_TyreModel(string ConnectionString) : base(ConnectionString)
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
    public void InsertTyreModel()
    {
        SqlParameter[] prm = new SqlParameter[8];
        prm[0] = new SqlParameter("@TYRE_MODEL_ID", TYRE_MODEL_ID);
        prm[1] = new SqlParameter("@MFG_ID", MFG_ID);
        prm[2] = new SqlParameter("@MODEL_NO", MODEL_NO);
        prm[3] = new SqlParameter("@MODEL_DESC", MODEL_DESC);
        prm[4] = new SqlParameter("@TREAD_DEPTH", TREAD_DEPTH);
        prm[5] = new SqlParameter("@TYRE_PATTERNID", TYRE_PATTERNID);
        prm[6] = new SqlParameter("@TYRE_SIZEID", TYRE_SIZEID);
        prm[7] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_INSERT_TYREMODEL", prm);
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
    public void CheckValidTyreModelNo(string strTyreModId)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];
        prm[0] = new SqlParameter("@MODEL_NO", MODEL_NO);
        prm[1] = new SqlParameter("@MODEL_ID", strTyreModId);
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Tyremodel_no", prm);
        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            MODEL_NO = dt.Rows[0]["MODEL_NO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

}
