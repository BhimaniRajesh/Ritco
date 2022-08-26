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
public class TripRouteFuelExp : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _Id;
    private string _Route_Fuel_Exp_Code;
    private string _ROUTE_CODE;
    private string _Vehicle_Type_Code;
    private string _KMPL;
    private string _Active_Flag;
    private string _Entry_By;
    private string _Entry_Date;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string Id { get { return _Id; } set { _Id = value; } }
    public string Route_Fuel_Exp_Code { get { return _Route_Fuel_Exp_Code; } set { _Route_Fuel_Exp_Code = value; } }
    public string ROUTE_CODE { get { return _ROUTE_CODE; } set { _ROUTE_CODE = value; } }
    public string Vehicle_Type_Code { get { return _Vehicle_Type_Code; } set { _Vehicle_Type_Code = value; } }
    public string KMPL { get { return _KMPL; } set { _KMPL = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string Entry_Date { get { return _Entry_Date; } set { _Entry_Date = value; } }
    public string Active_Flag { get { return _Active_Flag; } set { _Active_Flag = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public TripRouteFuelExp(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void BindGridFuelExp(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@ID", (Id == null) ? "0" : Id);
        prm[1] = new SqlParameter("@route_code", ROUTE_CODE);

        dcm.DataBind(gv, CommandType.StoredProcedure, "usp_TRIPROUTEFuelEXP_VIEW", prm);
    }
    public void InsertUpddateRouteExpMst()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@Id", Id);
        prm[1] = new SqlParameter("@Route_Fuel_Exp_Code", Route_Fuel_Exp_Code);
        prm[2] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
        prm[3] = new SqlParameter("@Vehicle_Type_Code", Vehicle_Type_Code);
        prm[4] = new SqlParameter("@KMPL", KMPL);
        prm[5] = new SqlParameter("@Active_Flag", Active_Flag);
        prm[6] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_TripRouteFuelExp_InsUp", prm);
    }
    
    public DataSet GetFuelExpDetails(string strID)
    {
        SqlParameter[] prm = new SqlParameter[2];
        DataSet ds = new DataSet();

        prm[0] = new SqlParameter("@ID", strID);
        prm[1] = new SqlParameter("@route_code", ROUTE_CODE);

        ds = ExecuteDataSet(CommandType.StoredProcedure, "usp_TRIPROUTEFuelEXP_VIEW", prm);

        return ds;
    }

    public void CheckValidVehType()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@ID", Id);
        prm[1] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
        prm[2] = new SqlParameter("@Vehicle_Type_Code", Vehicle_Type_Code);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_VehicleType_Code_Fuel_Exp", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Vehicle_Type_Code = dt.Rows[0]["Vehicle_Type_Code"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
