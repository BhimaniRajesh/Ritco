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
public class cls_DocumentType : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _DOCU_TYPE_ID;
    private string _DOCU_TYPE;
    private string _DECS;
    private string _APPLICABLE_STATE;
    private string _RENEW_AUTH_ID;
    private string _COST_CAPTURED;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string DOCU_TYPE_ID { get { return _DOCU_TYPE_ID; } set { _DOCU_TYPE_ID = value; } }
    public string DOCU_TYPE { get { return _DOCU_TYPE; } set { _DOCU_TYPE = value; } }
    public string DECS { get { return _DECS; } set { _DECS = value; } }
    public string APPLICABLE_STATE { get { return _APPLICABLE_STATE; } set { _APPLICABLE_STATE = value; } }
    public string RENEW_AUTH_ID { get { return _RENEW_AUTH_ID; } set { _RENEW_AUTH_ID = value; } }
    public string COST_CAPTURED { get { return _COST_CAPTURED; } set { _COST_CAPTURED = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_DocumentType(string ConnectionString) : base(ConnectionString)
    { 
        _Connection_String = ConnectionString; 
    }
  
    public void BindGrid(DataGrid dg)
    {
        //DataControlManager dcm = new DataControlManager(_Connection_String);
        //SqlParameter[] prm = new SqlParameter[8];

        //prm[0] = new SqlParameter("@RemouldId", (RemouldId == null) ? "" : RemouldId);
        //prm[1] = new SqlParameter("@TyreId", TyreId);
        //prm[2] = new SqlParameter("@CaptureKM", (CaptureKM == null) ? "" : CaptureKM);
        //prm[3] = new SqlParameter("@Cost", (Cost == null) ? "" : Cost);
        //prm[4] = new SqlParameter("@TotalCost", (TotalCost == null) ? "" : TotalCost);
        //prm[5] = new SqlParameter("@RemouldTyreLife", (RemouldTyreLife == null) ? "" : RemouldTyreLife);
        //prm[6] = new SqlParameter("@RemouldVendor", (RemouldVendor == null) ? "" : RemouldVendor);
        //prm[7] = new SqlParameter("@RemouldDate", RemouldDate);
        
        //dcm.DataBind(dg, CommandType.StoredProcedure, "usp_Search_Tyre_Remould", prm);
    }
    public void InsertDocumentType()
    {
        SqlParameter[] prm = new SqlParameter[6];
        prm[0] = new SqlParameter("@DOCU_TYPE_ID", DOCU_TYPE_ID);
        prm[1] = new SqlParameter("@DOCU_TYPE",DOCU_TYPE);
        prm[2] = new SqlParameter("@DECS", DECS);
        prm[3] = new SqlParameter("@APPLICABLE_STATE", APPLICABLE_STATE);
        prm[4] = new SqlParameter("@RENEW_AUTH_ID", RENEW_AUTH_ID);
        prm[5] = new SqlParameter("@COST_CAPTURED", COST_CAPTURED);
        ExecuteNonQuery(CommandType.StoredProcedure, "usp_Insert_Docu_Type", prm);
    }
    //public void UpdateDocumentType()
    //{
    //    SqlParameter[] prm = new SqlParameter[6];
    //    prm[0] = new SqlParameter("@DOCU_TYPE_ID", DOCU_TYPE_ID);
    //    prm[1] = new SqlParameter("@DOCU_TYPE", DOCU_TYPE);
    //    prm[2] = new SqlParameter("@DECS", DECS);
    //    prm[3] = new SqlParameter("@APPLICABLE_STATE", APPLICABLE_STATE);
    //    prm[4] = new SqlParameter("@RENEW_AUTH_ID", RENEW_AUTH_ID);
    //    prm[5] = new SqlParameter("@COST_CAPTURED", COST_CAPTURED);
    //    ExecuteNonQuery(CommandType.StoredProcedure, "usp_Insert_Docu_Type", prm);
    //}
    public void CheckValidDocumentType()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];
        prm[0] = new SqlParameter("@DOCU_TYPE", DOCU_TYPE);
        prm[1] = new SqlParameter("@DOCU_TYPE_ID", DOCU_TYPE_ID); 
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Docu_Type", prm);
        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
