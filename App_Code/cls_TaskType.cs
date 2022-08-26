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
/// Summary description for cls_WorkGroup
/// </summary>
public class cls_TaskType : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String;
    private string _TaskTypeID;
    private string _TaskType;
    private string _AccCode;
    private string _ActiveFlag, _EntryBy;
    protected bool _Is_Record_Found;

    #endregion

    #region Properties

    public string TaskTypeID { get { return _TaskTypeID; } set { _TaskTypeID = value; } }
    public string TaskType { get { return _TaskType; } set { _TaskType = value; } }
    public string AccCode { get { return _AccCode; } set { _AccCode = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public string ActiveFlag { get { return _ActiveFlag; } set { _ActiveFlag = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    
    #endregion

    public cls_TaskType(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}

    public void InsertTaskType()
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@TaskType", TaskType);
        prm[1] = new SqlParameter("@AccCode", AccCode);
        prm[2] = new SqlParameter("@ActiveFlag", ActiveFlag);
        prm[3] = new SqlParameter("@EntryBy", EntryBy);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_INS_WEBX_FLEET_TASKTYPEMST", prm);
    }
    public void UpdateTaskType()
    {
        SqlParameter[] prm = new SqlParameter[5];

        prm[0] = new SqlParameter("@TaskTypeId", TaskTypeID);
        prm[1] = new SqlParameter("@TaskType", TaskType);
        prm[2] = new SqlParameter("@AccCode", AccCode);
        prm[3] = new SqlParameter("@ActiveFlag", ActiveFlag);
        prm[4] = new SqlParameter("@EntryBy", EntryBy);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_UPDATE_WEBX_FLEET_TASKTYPEMST", prm);
    }
    public void BindGridTaskType(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TaskType", (TaskType == null) ? "" : TaskType);

        dcm.DataBind(gv, CommandType.StoredProcedure, "usp_TaskTypeList", prm);
    }
    public DataTable GetData()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);

        dt = ExecuteDataTable(CommandType.Text, "exec [usp_GetSingletonValue] '" + TaskTypeID + "'");

        return dt;
    }
    public void CheckValidAccCode(string strAccCode)
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select distinct Acccode,Accdesc from webx_acctinfo WITH(NOLOCK) WHERE ACCCATEGORY='EXPENSE' and ActiveFlag='Y' and Acccode='" + strAccCode.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            AccCode = dt.Rows[0]["Accdesc"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }


    public void CheckValidTaskType(string strTaskTypeId)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@TaskType", TaskType);
        prm[1] = new SqlParameter("@TaskTypeID", strTaskTypeId);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_CheckValidTaskType", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TaskType = dt.Rows[0]["TaskType"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    
}
