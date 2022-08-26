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
public class TripExpense : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String,_ID,_Trip_Exp_Header,_Polarity,_Active_Flag;
    protected bool _Is_Record_Found;
    private string _AvgDieRate, _Entry_By, _AccCode;
    
    #endregion

    #region Properties

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    public string ID { get { return _ID; } set { _ID = value; } }
    public string Trip_Exp_Header { get { return _Trip_Exp_Header; } set { _Trip_Exp_Header = value; } }
    public string Polarity { get { return _Polarity; } set { _Polarity = value; } }
    public string Active_Flag { get { return _Active_Flag; } set { _Active_Flag = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string AccCode { get { return _AccCode; } set { _AccCode = value; } }

    #endregion

    public TripExpense(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void BindGridTripExpense(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@ID", (ID == null) ? "": ID);

        dcm.DataBind(gv, CommandType.StoredProcedure, "Usp_Webx_Trip_Expense_Master", prm);
    }
    public void InsertTripExpense()
    {
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@Trip_Exp_Header", Trip_Exp_Header);
        prm[2] = new SqlParameter("@Polarity", Polarity);
        prm[3] = new SqlParameter("@Active_Flag", Active_Flag);
        prm[4] = new SqlParameter("@Enter_By", Entry_By);
        prm[5] = new SqlParameter("@AccCode", AccCode);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Trip_Expense_Master", prm);
    }
    public void UpdateTripExpense()
    {
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@ID", ID);
        prm[1] = new SqlParameter("@Trip_Exp_Header", Trip_Exp_Header);
        prm[2] = new SqlParameter("@Polarity", Polarity);
        prm[3] = new SqlParameter("@Active_Flag", Active_Flag );
        prm[4] = new SqlParameter("@Enter_By", Entry_By);
        prm[5] = new SqlParameter("@AccCode", AccCode);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Trip_Expense_Master", prm);
    }
    public DataTable GetTripExpenseDet()
    {
        DataTable dt = new DataTable();
        return dt = ExecuteDataTable(CommandType.Text, "SELECT * FROM [Webx_Trip_Expense_Master] WHERE ID='" + ID + "'");
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
    public void BindGridTripFinance(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.Text, "Select (Select AccCode + ':' + AccDesc From webx_acctinfo WITH(NOLOCK) WHERE ActiveFlag='Y' And AccCode=Webx_Fleet_Trip_Expense_Master.AccCode) as AccDesc, * From Webx_Fleet_Trip_Expense_Master");
    }
    public void CheckValidAccCode(string strAccCode)
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select distinct Acccode,Accdesc from webx_acctinfo WITH(NOLOCK) WHERE ActiveFlag='Y' and Acccode='" + strAccCode.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            AccCode = dt.Rows[0]["Acccode"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
