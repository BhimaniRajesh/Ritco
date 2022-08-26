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
public class cls_Tyre_Warranty : DataAccessLayer 
{
    #region Private Declaration
    
    private string _Connection_String;
    private string _TYRE_ID;
    private string _TYRE_NO;
    private string _VEH_INTERNAL_NO;
    private string _MFG;
    private string _TYRE_COST;
    private string _TYRE_TOTKM_RUN;
    private string _TOTAL_COST;
    private string _MODEL;
    private string _LAST_TERADDEPTH;
    
    protected bool _IsRecordFound;
    
    private string _W_ID;
    private string _USED_COST;
    private string _WARRANTY_DT;
    private string _WARRANTY_KM;
    private string _CLAIMING_DT;
    private string _REPLACE_TYRENO;

    #endregion

    #region Properties

    public string TYRE_ID { get { return _TYRE_ID; } set { _TYRE_ID = value; } }
    public string TYRE_NO { get { return _TYRE_NO; } set { _TYRE_NO = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string MFG { get { return _MFG; } set { _MFG = value; } }
    public string TYRE_COST { get { return _TYRE_COST; } set { _TYRE_COST = value; } }
    public string TYRE_TOTKM_RUN { get { return _TYRE_TOTKM_RUN; } set { _TYRE_TOTKM_RUN = value; } }
    public string TOTAL_COST { get { return _TOTAL_COST; } set { _TOTAL_COST = value; } }
    public string MODEL { get { return _MODEL; } set { _MODEL = value; } }
    public string LAST_TERADDEPTH { get { return _LAST_TERADDEPTH; } set { _LAST_TERADDEPTH = value; } }

    public string W_ID { get { return _W_ID; } set { _W_ID = value; } }
    public string USED_COST { get { return _USED_COST; } set { _USED_COST = value; } }
    public string WARRANTY_DT { get { return _WARRANTY_DT; } set { _WARRANTY_DT = value; } }
    public string WARRANTY_KM { get { return _WARRANTY_KM; } set { _WARRANTY_KM = value; } }
    public string CLAIMING_DT { get { return _CLAIMING_DT; } set { _CLAIMING_DT = value; } }
    public string REPLACE_TYRENO { get { return _REPLACE_TYRENO; } set { _REPLACE_TYRENO = value; } }

    public bool IsRecordFound { get { return _IsRecordFound; } set { _IsRecordFound = value; } }
    
    #endregion

    public cls_Tyre_Warranty(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
	
    public void BindGridTyreDetails(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_NO", "");
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_GET_DET_TYRE_WARRANTY", prm);  
    }
    public void FillTyreDetails(string strTyreNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_NO", strTyreNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_DET_TYRE_WARRANTY", prm);
        if (dt.Rows.Count > 0)
        {
            TYRE_ID = dt.Rows[0]["TYRE_ID"].ToString();
            TYRE_NO = dt.Rows[0]["TYRE_NO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            MFG = dt.Rows[0]["MFG"].ToString();
            TYRE_COST = dt.Rows[0]["TYRE_COST"].ToString();
            TYRE_TOTKM_RUN = dt.Rows[0]["TYRE_TOTKM_RUN"].ToString();
            TOTAL_COST = dt.Rows[0]["TOTAL_COST"].ToString();
            MODEL = dt.Rows[0]["MODEL"].ToString();
            LAST_TERADDEPTH = dt.Rows[0]["LAST_TERADDEPTH"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void InsertUpdateWarranty()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_Warranty_INSERTUPDATE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@W_ID", SqlDbType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.ToString();
        da.SelectCommand.Parameters.Add("@USED_COST", SqlDbType.VarChar).Value = USED_COST.ToString();
        da.SelectCommand.Parameters.Add("@WARRANTY_DT", SqlDbType.VarChar).Value = WARRANTY_DT.ToString();
        da.SelectCommand.Parameters.Add("@WARRANTY_KM", SqlDbType.VarChar).Value = WARRANTY_KM.ToString();
        da.SelectCommand.Parameters.Add("@CLAIMING_DT", SqlDbType.VarChar).Value = CLAIMING_DT.ToString();
        da.SelectCommand.Parameters.Add("@REPLACE_TYRENO", SqlDbType.VarChar).Value = REPLACE_TYRENO.ToString();
		da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToUpper().Trim();

        cmd.ExecuteNonQuery();
        conn.Close();
    }
    //public void checkTreadDepth()
    //{
    //    DataTable dt = new DataTable();
    //    SqlParameter[] prm = new SqlParameter[1];
    //    prm[0] = new SqlParameter("@TYRE_ID", TYRE_ID);
    //    dt = ExecuteDataTable(CommandType.StoredProcedure,"USP_CHECK_TREAD_DEPTH",prm);
    //    if (dt.Rows.Count > 0)
    //    {
    //        AVG_TWI = dt.Rows[0]["AVG_TWI"].ToString(); 
    //        IsRecordFound = true;
    //    }
    //    else
    //    {
    //        IsRecordFound = false;
    //    }
       
    //}
    //public void CheckTWI()
    //{
    //    DataTable dt = new DataTable();
    //    SqlParameter[] prm = new SqlParameter[1];
    //    prm[0] = new SqlParameter("@TYRE_ID", TYRE_ID);
    //    dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_CHECK_TREAD_DEPTH", prm);
    //    if (dt.Rows.Count > 0)
    //    {
    //        TWI1 = dt.Rows[0]["TWI1"].ToString();
    //        TWI2 = dt.Rows[0]["TWI2"].ToString();
    //        TWI3 = dt.Rows[0]["TWI3"].ToString();
    //        AVG_TWI = dt.Rows[0]["AVG_TWI"].ToString();
    //        IsRecordFound = true;
    //    }
    //    else
    //    {
    //        IsRecordFound = false;
    //    }
    //}
    
    //public void BindGridTyreDetails_TyreWise(GridView gv)
    //{
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    SqlParameter[] prm = new SqlParameter[1];
    //    prm[0] = new SqlParameter("@VEH_ID", VEH_NO.ToString());
    //    dcm.DataBind(gv, CommandType.StoredProcedure, "USP_GET_DET_TYRE_TREADDEPTH", prm);
    //}
  
    //public void FillTDM(string strTyreNo)
    //{
    //    DataTable dt = new DataTable();
    //    SqlParameter[] prm = new SqlParameter[1];
    //    prm[0] = new SqlParameter("@TYRE_ID", strTyreNo);
    //    dt = ExecuteDataTable(CommandType.StoredProcedure,"USP_CHECK_TREAD_DEPTH",prm);
    //    if (dt.Rows.Count > 0)
    //    {
    //        AVG_TWI = dt.Rows[0]["AVG_TWI"].ToString(); 
    //        IsRecordFound = true;
    //    }
    //    else
    //    {
    //        IsRecordFound = false;
    //    }
    //}
    
}
