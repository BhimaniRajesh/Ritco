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
public class TripFinance : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String,_ID,_Trip_Exp_Header,_Polarity,_Active_Flag;
    protected bool _Is_Record_Found;
    private string _AvgDieRate, _Entry_By, _AccCode, _CodeType;
    
    #endregion

    #region Properties

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    public string ID { get { return _ID; } set { _ID = value; } }
    public string Trip_Exp_Header { get { return _Trip_Exp_Header; } set { _Trip_Exp_Header = value; } }
    public string Polarity { get { return _Polarity; } set { _Polarity = value; } }
    public string Active_Flag { get { return _Active_Flag; } set { _Active_Flag = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string AccCode { get { return _AccCode; } set { _AccCode = value; } }
    public string CodeType { get { return _CodeType; } set { _CodeType = value; } }

    #endregion

    public TripFinance(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void BindGridTripExpense(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@ID", (ID == null) ? "": ID);
        prm[1] = new SqlParameter("@CodeType", CodeType);

        dcm.DataBind(gv, CommandType.StoredProcedure, "Usp_Webx_Fleet_Trip_Expense_Master", prm);
    }
    //public void InsertTripExpense()
    //{
    //    SqlParameter[] prm = new SqlParameter[6];

    //    prm[0] = new SqlParameter("@ID", ID);
    //    prm[1] = new SqlParameter("@Trip_Exp_Header", Trip_Exp_Header);
    //    prm[2] = new SqlParameter("@Polarity", Polarity);
    //    prm[3] = new SqlParameter("@Active_Flag", Active_Flag);
    //    prm[4] = new SqlParameter("@Enter_By", Entry_By);
    //    prm[5] = new SqlParameter("@AccCode", AccCode);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Trip_Expense_Master", prm);
    //}
    public void UpdateTripExpense()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@CodeType", CodeType);
        prm[2] = new SqlParameter("@CodeDesc", Trip_Exp_Header);
        prm[3] = new SqlParameter("@Polarity", Polarity);
        prm[4] = new SqlParameter("@StatusCode", Active_Flag);
        prm[5] = new SqlParameter("@LastUpdatedBy", Entry_By);
        prm[6] = new SqlParameter("@AccCode", AccCode);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_Trip_Expense_Master", prm);
    }
    public DataTable GetTripExpenseDet()
    {
        DataTable dt = new DataTable();
        return dt = ExecuteDataTable(CommandType.Text, "Select (Select AccCode + ':' + AccDesc From webx_acctinfo  WITH(NOLOCK) WHERE ACCCATEGORY='EXPENSE' and ActiveFlag='Y' And AccCode=TEM.AccCode) as AccDesc,*From Webx_Master_General as GM Inner Join Webx_Fleet_Trip_Expense_Master As TEM  On GM.CodeId= TEM.Code_Id  And GM.CodeType= TEM.Code_Type Where GM.CodeType in ('FEXP','VEXP','OEXP') And GM.CodeId ='" + ID + "' And CodeType='" + CodeType + "'");
    }
    public void CheckValidExp()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@Trip_Exp_Header", Trip_Exp_Header);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Check_Valid_Expense", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Trip_Exp_Header = dt.Rows[0]["Trip_Exp_Header"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
   

    
}
