using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for cls_CheckList_Mst
/// </summary>
public class cls_CheckList_Mst : DataAccessLayer 
{
    private string _Connection_String;
    protected bool _Is_Record_Found;
    private string _Chk_ID, _Chk_Cat, _Chk_Desc, _Chk_Document_Shown, _ActiveFlag;
    private string _EntryBy, _Company_Code,_UpdatedBy;
    private DateTime _EntryDt,_UpdatedDt;

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string Chk_ID { get { return _Chk_ID; } set { _Chk_ID = value; } }
    public string Chk_Cat { get { return _Chk_Cat; } set { _Chk_Cat = value; } }
    public string Chk_Desc { get { return _Chk_Desc; } set { _Chk_Desc = value; } }
    public string Chk_Document_Shown { get { return _Chk_Document_Shown; } set { _Chk_Document_Shown = value; } }
    public string ActiveFlag { get { return _ActiveFlag; } set { _ActiveFlag = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
    public DateTime EntryDt { get { return _EntryDt; } set { _EntryDt = value; } }
    public string UpdatedBy { get { return _UpdatedBy; } set { _UpdatedBy = value; } }
    public DateTime UpdatedDt { get { return _UpdatedDt; } set { _UpdatedDt = value; } }
    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }

    public cls_CheckList_Mst(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}

    public void BindGridChecklist(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Chk_ID", (Chk_ID == null) ? "" : Chk_ID);

        dcm.DataBind(gv, CommandType.StoredProcedure, "Usp_Fleet_CheckList_Master", prm);
    }

    public void InsertCheckList()
    {
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@Chk_Cat", Chk_Cat);
        prm[1] = new SqlParameter("@Chk_Desc", Chk_Desc);
        prm[2] = new SqlParameter("@Chk_Document_Shown", Chk_Document_Shown);
        prm[3] = new SqlParameter("@ActiveFlag", ActiveFlag);
        prm[4] = new SqlParameter("@EntryBy", EntryBy);
        prm[5] = new SqlParameter("@Company_Code", Company_Code);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_FLEET_INSERT_CHECKLIST_MST", prm);
    }

    public void UpdateCheckList()
    {
        SqlParameter[] prm = new SqlParameter[8];

        prm[0] = new SqlParameter("@Chk_ID", Chk_ID);
        prm[1] = new SqlParameter("@Chk_Cat", Chk_Cat);
        prm[2] = new SqlParameter("@Chk_Desc", Chk_Desc);
        prm[3] = new SqlParameter("@Chk_Document_Shown", Chk_Document_Shown);
        prm[4] = new SqlParameter("@ActiveFlag", ActiveFlag);
        prm[5] = new SqlParameter("@UpdatedBy", UpdatedBy);
        prm[6] = new SqlParameter("@UpdatedDt", UpdatedDt);
        prm[7] = new SqlParameter("@Company_Code", Company_Code);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_FLEET_EDIT_CHECKLIST_MST", prm);
    }

    public void CheckValidCheckList()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@Chk_ID", Chk_ID);
        //prm[1] = new SqlParameter("@Chk_Cat", Chk_Cat);
        prm[1] = new SqlParameter("@Chk_Desc", Chk_Desc);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Check_Valid_CheckList", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Chk_ID = dt.Rows[0]["Chk_ID"].ToString();
            //Chk_Cat = dt.Rows[0]["Chk_Cat"].ToString();
            Chk_Desc = dt.Rows[0]["Chk_Desc"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
