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
/// <summary>
/// Summary description for cls_AvgDieselRage
/// </summary>
public class AvgDieselRate : DataAccessLayer 
{
    #region Private Declaration

    private int _AvgDieselRateId;
    private string _Connection_String,_ROUTE_CODE;
    protected bool _Is_Record_Found;
    
    private string _AvgDieRate, _Entry_By;
    
    #endregion

    #region Properties

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public int AvgDieselRateId { get { return _AvgDieselRateId; } set { _AvgDieselRateId = value; } }
    public string AvgDieRate { get { return _AvgDieRate; } set { _AvgDieRate = value; } }
    public string ROUTE_CODE { get { return _ROUTE_CODE; } set { _ROUTE_CODE = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }

    #endregion

    public AvgDieselRate(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void BindGridAvgDieselRate(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@AvgDieselRateId", (AvgDieselRateId == null) ? 0 : AvgDieselRateId);

        dcm.DataBind(gv, CommandType.StoredProcedure, "Usp_Webx_Fleet_AvgDieselRate_Data", prm);
    }
    public void InsertAvgDieselRate()
    {
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@AvgDieselRate", AvgDieRate);
        prm[1] = new SqlParameter("@Entry_By", Entry_By);
        prm[2] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_AvgDieselRate", prm);
    }
    public void UpdateAvgDieselRate()
    {
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@AvgDieselRateId", AvgDieselRateId);
        prm[1] = new SqlParameter("@AvgDieselRate", AvgDieRate);
        prm[2] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_AvgDieselRate", prm);
    }
    public DataTable GetAvgDieselRate()
    {
        DataTable dt = new DataTable();
        return dt = ExecuteDataTable(CommandType.Text, "SELECT AvgDieselRateId,AvgDieselRate FROM [Webx_Fleet_AvgDieselRate] WHERE ROUTE_CODE='" + ROUTE_CODE + "'");
    }
    //public DataSet GetFuelExpDetails(string strID)
    //{
    //    SqlParameter[] prm = new SqlParameter[2];
    //    DataSet ds = new DataSet();

    //    prm[0] = new SqlParameter("@ID", strID);
    //    prm[1] = new SqlParameter("@route_code", ROUTE_CODE);

    //    ds = ExecuteDataSet(CommandType.StoredProcedure, "usp_TRIPROUTEFuelEXP_VIEW", prm);

    //    return ds;
    //}
}
