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
/// Summary description for cls_Tyre_Tracking
/// </summary>
public class cls_Tyre_Tracking : DataAccessLayer 
{
    private string _Connection_String,_TYRE_NO, _TYRE_VEHNO;
    protected bool _Is_Record_Found;

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string TYRE_NO { get { return _TYRE_NO; } set { _TYRE_NO = value; } }
    public string TYRE_VEHNO { get { return _TYRE_VEHNO; } set { _TYRE_VEHNO = value; } }

    public cls_Tyre_Tracking(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString; 
	}

    public void CheckTyreNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TYRE_NO", TYRE_NO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Tyre_tracking", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void CheckVehNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TYRE_VEHNO", TYRE_VEHNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Tyre_VehNo_tracking", prm);

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
