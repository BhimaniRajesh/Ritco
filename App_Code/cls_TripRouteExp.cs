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
public class cls_TripRouteExp : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _ID;
    private string _ROUTE_EXP_CODE;
    private string _ROUTE_CODE;
    private string _ROUTE_SEGMENT;
    private string _VEHICLE_TYPE;
    private string _FULEXP_CODE;
    private string _STANDARD_RATE;
    private string _ENTER_BY;
    private string _UPDATE_DT;
    private string _ACTIVE_FLAG;
    private string _VEHNO;
    protected bool _Is_Record_Found;
    private string _EXP_RATE_CODE;
    private string _Polarity;
    #endregion

    #region Properties
    public string ID { get { return _ID; } set { _ID = value; } }
    public string ROUTE_EXP_CODE { get { return _ROUTE_EXP_CODE; } set { _ROUTE_EXP_CODE = value; } }
    public string ROUTE_CODE { get { return _ROUTE_CODE; } set { _ROUTE_CODE = value; } }
    public string ROUTE_SEGMENT { get { return _ROUTE_SEGMENT; } set { _ROUTE_SEGMENT = value; } }
    public string VEHICLE_TYPE { get { return _VEHICLE_TYPE; } set { _VEHICLE_TYPE = value; } }
    public string FULEXP_CODE { get { return _FULEXP_CODE; } set { _FULEXP_CODE = value; } }
    public string STANDARD_RATE { get { return _STANDARD_RATE; } set { _STANDARD_RATE = value; } }
    public string ENTER_BY { get { return _ENTER_BY; } set { _ENTER_BY = value; } }
    public string UPDATE_DT { get { return _UPDATE_DT; } set { _UPDATE_DT = value; } }
    public string EXP_RATE_CODE { get { return _EXP_RATE_CODE; } set { _EXP_RATE_CODE = value; } }
    public string ACTIVE_FLAG { get { return _ACTIVE_FLAG; } set { _ACTIVE_FLAG = value; } }
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string Polarity { get { return _Polarity; } set { _Polarity = value; } }
    #endregion

    public cls_TripRouteExp(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    //public void BindGridTyrePattern(DataGrid dg)
    //{
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    SqlParameter[] prm = new SqlParameter[5];

    //    prm[0] = new SqlParameter("@TYREPOS_ID", (RemouldId == null) ? "" : RemouldId);
    //    prm[1] = new SqlParameter("@TYREPOS_CODE", TyreId);
    //    prm[2] = new SqlParameter("@TYREPOS_DESC", (CaptureKM == null) ? "" : CaptureKM);
    //    prm[3] = new SqlParameter("@ACTIVE_FLAG", (Cost == null) ? "" : Cost);
    //    prm[4] = new SqlParameter("@VEHICLE_TYPE", (TotalCost == null) ? "" : TotalCost);

    //    dcm.DataBind(dg, CommandType.StoredProcedure, "usp_Search_Tyre_Remould", prm);
    //}
    public void InsertUpddateRouteExpMst()
    {
        SqlParameter[] prm = new SqlParameter[10];
        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@ROUTE_EXP_CODE", (ROUTE_EXP_CODE == null) ? "" : ROUTE_EXP_CODE);
        prm[2] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
        prm[3] = new SqlParameter("@ROUTE_SEGMENT", ROUTE_SEGMENT);
        prm[4] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);
        prm[5] = new SqlParameter("@FULEXP_CODE", FULEXP_CODE);
        prm[6] = new SqlParameter("@STANDARD_RATE", Convert.ToDouble(STANDARD_RATE.ToString()));
        prm[7] = new SqlParameter("@ACTIVE_FLAG", ACTIVE_FLAG);
        prm[8] = new SqlParameter("@ENTER_BY", ENTER_BY);
        prm[9] = new SqlParameter("@EXP_RATE_CODE", EXP_RATE_CODE);
        
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_TripRouteExp_InsUp", prm);
    }
    //public void CheckValidRateType()
    //{
    //    DataTable dt = new DataTable();
    //    SqlParameter[] prm = new SqlParameter[5];

    //    prm[0] = new SqlParameter("@ID", ID);
    //    prm[1] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
    //    prm[2] = new SqlParameter("@EXP_RATE_CODE", EXP_RATE_CODE);
    //    prm[3] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);
    //    prm[4] = new SqlParameter("@FULEXP_CODE", FULEXP_CODE);


    //    dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_ExpRateType_Code", prm);

    //    if (dt.Rows.Count > 0)
    //    {
    //        IsRecordFound = true;
    //        EXP_RATE_CODE = dt.Rows[0]["EXP_RATE_CODE"].ToString();
    //    }
    //    else
    //    {
    //        IsRecordFound = false;
    //    }
    //}
    public void FillStandardAmt()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
        prm[1] = new SqlParameter("@FULEXP_CODE", FULEXP_CODE);
        prm[2] = new SqlParameter("@VEHNO", VEHNO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_FILL_STANDARD_RARE", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            STANDARD_RATE = dt.Rows[0]["STANDARD_RATE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void FillPolarity()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "SELECT Polarity FROM Webx_Trip_Expense_Master where ID= '" + FULEXP_CODE + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Polarity = dt.Rows[0]["Polarity"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    
    public void CheckValidVehicleType()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
        //prm[2] = new SqlParameter("@EXP_RATE_CODE", EXP_RATE_CODE);
        prm[2] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);
        prm[3] = new SqlParameter("@FULEXP_CODE", FULEXP_CODE);


        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_FTLType_Code", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            VEHICLE_TYPE = dt.Rows[0]["VEHICLE_TYPE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckValidFuelType()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@ROUTE_CODE", ROUTE_CODE);
        //prm[2] = new SqlParameter("@EXP_RATE_CODE", EXP_RATE_CODE);
        prm[2] = new SqlParameter("@VEHICLE_TYPE", VEHICLE_TYPE);
        prm[3] = new SqlParameter("@FULEXP_CODE", FULEXP_CODE);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_FuelType_Code", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            FULEXP_CODE = dt.Rows[0]["FULEXP_CODE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
