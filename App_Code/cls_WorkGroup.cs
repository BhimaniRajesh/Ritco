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
public class cls_WorkGroup : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _WORK_GROUPCODE;
    private string _WORK_GROUPDESC;
    private string _ACTIVE_FLAG;
    private string _ENTRY_BY;
    protected bool _Is_Record_Found;
    private string _Account_Category;
    #endregion

    #region Properties
    public string WORK_GROUPCODE { get { return _WORK_GROUPCODE; } set { _WORK_GROUPCODE = value; } }
    public string WORK_GROUPDESC { get { return _WORK_GROUPDESC; } set { _WORK_GROUPDESC = value; } }
    public string ACTIVE_FLAG { get { return _ACTIVE_FLAG; } set { _ACTIVE_FLAG = value; } }
    public string ENTRY_BY { get { return _ENTRY_BY; } set { _ENTRY_BY = value; } }
    public string Account_Category { get { return _Account_Category; } set { _Account_Category = value; } }

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_WorkGroup(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}

    public void InsertWorkGroup()
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@WORK_GROUPCODE", WORK_GROUPCODE);
        prm[1] = new SqlParameter("@WORK_GROUPDESC", WORK_GROUPDESC);
        prm[2] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
        prm[3] = new SqlParameter("@ENTRY_BY", ENTRY_BY);
        //prm[4] = new SqlParameter("@Account_Category", Account_Category);
          
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_INSERT_WORKGROUP", prm);
    }

    
    public void CheckValidWorkGroup(string strWorkGroupCode)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@WORKGROUP_DESC", WORK_GROUPDESC);
        prm[1] = new SqlParameter("@WORKGROUP_CODE", strWorkGroupCode);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_WorkGroup_code", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            WORK_GROUPDESC = dt.Rows[0]["W_GRPDESC"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
