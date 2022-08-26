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
/// Summary description for General
/// </summary>
public class cls_DocumentEntry : DataAccessLayer
{
    private string _Connection_String;
    private string _VehNo;
    private string _VEH_INTERNAL_NO;
    private string _CURRENT_KM_READ;
    private string _VehType;
    private string _DOCU_ID;
    private string _EXPRITY_DT;
    private string _DOCU_NO;
    private string _DOCU_TYPE;
    private string _DOCU_DET_ID;
    protected bool _IsRecordFound;

    public bool IsRecordFound { get { return _IsRecordFound; } set { _IsRecordFound = value; } }

    public string VehNo { get { return _VehNo; } set { _VehNo = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string CURRENT_KM_READ { get { return _CURRENT_KM_READ; } set { _CURRENT_KM_READ = value; } }
    public string VehType { get { return _VehType; } set { _VehType = value; } }
    public string DOCU_ID { get { return _DOCU_ID; } set { _DOCU_ID = value; } }
    public string EXPRITY_DT { get { return _EXPRITY_DT; } set { _EXPRITY_DT = value; } }
    public string DOCU_NO { get { return _DOCU_NO; } set { _DOCU_NO = value; } }
    public string DOCU_TYPE { get { return _DOCU_TYPE; } set { _DOCU_TYPE = value; } }
    public string DOCU_DET_ID { get { return _DOCU_DET_ID; } set { _DOCU_DET_ID = value; } }
    public cls_DocumentEntry(string Connection_String)
        : base(Connection_String)
	{
		//
		// TODO: Add constructor logic here 
		//
        _Connection_String = Connection_String; 
	}
  
    public void CheckValidVehNoRotate(string strVehNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Veh_No_DocEntnry", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            CURRENT_KM_READ = dt.Rows[0]["Current_KM_Read"].ToString();
            VehType = dt.Rows[0]["Type_Name"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckStartDate()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];
        prm[0] = new SqlParameter("@DOCU_ID", DOCU_ID);
        prm[1] = new SqlParameter("@DOCU_DET_ID", DOCU_DET_ID);
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_StartDt", prm);
        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            EXPRITY_DT = dt.Rows[0]["EXPRITY_DT"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void CheckDocNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[5];
        prm[0] = new SqlParameter("@DOCU_NO", DOCU_NO);
        prm[1] = new SqlParameter("@VEH_NO", VEH_INTERNAL_NO);
        prm[2] = new SqlParameter("@DOCU_ID", DOCU_ID);
        prm[3] = new SqlParameter("@DOCU_TYPE", DOCU_TYPE);
        prm[4] = new SqlParameter("@DOCU_DET_ID", DOCU_DET_ID);
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_DocNo", prm);
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
