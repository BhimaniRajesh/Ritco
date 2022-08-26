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
/// Summary description for cls_TreadDepthMeasurement
/// </summary>
public class cls_TreadDepthMeasurement : DataAccessLayer 
{
    #region Private Declaration
    
    private string _Connection_String;
    private string _TyreId;
    private string _TD_ID;
    private string _VEH_NO;
    private string _TYRE_ID;
    private string _AVG_TWI;
    private string _TWI1;
    private string _TWI2;
    private string _TWI3;
    private string _TDM_DT, _TYRE_STATUS;
    private int _VehId;


    private string _KM_RUN;
    private string _POSITION;
    private string _TYRE_TREAD_DEPTH_32NDS;
    private string _MFG;
    private string _MODEL;
    private string _Company_Code;

    protected bool _IsRecordFound;
    
    #endregion

    #region Properties

    public string TYRE_STATUS { get { return _TYRE_STATUS; } set { _TYRE_STATUS = value; } }

    public string TyreId { get { return _TyreId; } set { _TyreId = value; } }
    public int VehId { get { return _VehId; } set { _VehId = value; } }
    public string TD_ID { get { return _TD_ID; } set { _TD_ID = value; } }
    public string VEH_NO { get { return _VEH_NO; } set { _VEH_NO = value; } }
    public string TYRE_ID { get { return _TYRE_ID; } set { _TYRE_ID = value; } }
    public string AVG_TWI { get { return _AVG_TWI; } set { _AVG_TWI = value; } }
    public string TWI1 { get { return _TWI1; } set { _TWI1 = value; } }
    public string TWI2 { get { return _TWI2; } set { _TWI2 = value; } }
    public string TWI3 { get { return _TWI3; } set { _TWI3 = value; } }
    public string TDM_DT { get { return _TDM_DT; } set { _TDM_DT = value; } }

    public string KM_RUN { get { return _KM_RUN; } set { _KM_RUN = value; } }
    public string POSITION { get { return _POSITION; } set { _POSITION = value; } }
    public string TYRE_TREAD_DEPTH_32NDS { get { return _TYRE_TREAD_DEPTH_32NDS; } set { _TYRE_TREAD_DEPTH_32NDS = value; } }
    public string MFG { get { return _MFG; } set { _MFG = value; } }
    public string MODEL { get { return _MODEL; } set { _MODEL = value; } }
    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }
    

    public bool IsRecordFound { get { return _IsRecordFound; } set { _IsRecordFound = value; } }
    
    #endregion

    public cls_TreadDepthMeasurement(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
	
    public void BindGridTyreDetails(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@VEH_ID", VehId.ToString());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_GET_DET_TYRE_TREADDEPTH", prm);  
    }
    public void checkTreadDepth()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_ID", TYRE_ID);
        dt = ExecuteDataTable(CommandType.StoredProcedure,"USP_CHECK_TREAD_DEPTH",prm);
        if (dt.Rows.Count > 0)
        {
            AVG_TWI = dt.Rows[0]["AVG_TWI"].ToString(); 
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
       
    }
    public void CheckTWI()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_ID", TYRE_ID);
        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_CHECK_TREAD_DEPTH", prm);
        if (dt.Rows.Count > 0)
        {
            TWI1 = dt.Rows[0]["TWI1"].ToString();
            TWI2 = dt.Rows[0]["TWI2"].ToString();
            TWI3 = dt.Rows[0]["TWI3"].ToString();
            AVG_TWI = dt.Rows[0]["AVG_TWI"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void InsertUpdateTDM()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_TreadDepthMeasurement_INSERTUPDATE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TD_ID", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@VEH_NO", SqlDbType.Int).Value = VehId.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.ToString();
        da.SelectCommand.Parameters.Add("@AVG_TWI", SqlDbType.Float).Value = AVG_TWI.ToString();
        da.SelectCommand.Parameters.Add("@TWI1", SqlDbType.Float).Value = TWI1.ToString();
        da.SelectCommand.Parameters.Add("@TWI2", SqlDbType.Float).Value = TWI2.ToString();
        da.SelectCommand.Parameters.Add("@TWI3", SqlDbType.Float).Value = TWI3.ToString();
        da.SelectCommand.Parameters.Add("@TDM_DT", SqlDbType.VarChar).Value = TDM_DT.ToString();
        da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = Company_Code.ToString();
        cmd.ExecuteNonQuery();
        conn.Close();
    }
    public void BindGridTyreDetails_TyreWise(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@VEH_ID", VEH_NO.ToString());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_GET_DET_TYRE_TREADDEPTH", prm);
    }
    public void FillTyreDetails_TyreWise(string strTyreNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_NO", strTyreNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_DET_TYRE_TREADDEPTH_TYREWISE", prm);
        if (dt.Rows.Count > 0)
        {
            TYRE_ID = dt.Rows[0]["TYRE_NO"].ToString();
            KM_RUN = dt.Rows[0]["KM_RUN"].ToString();
            VEH_NO  = dt.Rows[0]["VEHNO"].ToString();
            POSITION = dt.Rows[0]["POSITION"].ToString();
            TYRE_TREAD_DEPTH_32NDS = dt.Rows[0]["TYRE_TREAD_DEPTH_32NDS"].ToString();
            MFG = dt.Rows[0]["MFG"].ToString();
            MODEL = dt.Rows[0]["MODEL"].ToString();
            AVG_TWI  = dt.Rows[0]["AVG_TWI"].ToString();
            TyreId = dt.Rows[0]["TYRE_ID"].ToString();
            VehId = Convert.ToInt32(dt.Rows[0]["VEH_INTERNAL_NO"].ToString());
            TYRE_STATUS = dt.Rows[0]["TYRE_STATUS"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void FillTDM(string strTyreNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_ID", strTyreNo);
        dt = ExecuteDataTable(CommandType.StoredProcedure,"USP_CHECK_TREAD_DEPTH",prm);
        if (dt.Rows.Count > 0)
        {
            AVG_TWI = dt.Rows[0]["AVG_TWI"].ToString(); 
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
       
    }
    
}
