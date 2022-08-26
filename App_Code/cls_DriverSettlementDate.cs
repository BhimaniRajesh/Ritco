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
public class cls_DriverSettlementDate : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String;
    protected bool _Is_Record_Found;
    private string _DriverSettlementDate, _EntryBy;
    
    #endregion

    #region Properties

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string DriverSettlementDate { get { return _DriverSettlementDate; } set { _DriverSettlementDate = value; } }
    public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }

    #endregion

    public cls_DriverSettlementDate(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void BindGridDriverSettlementDate(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.Text, "select Convert(Varchar,DriverSettlementDate,103) as DriverSettlementDate from Webx_Fleet_DriverSettlementDate");
    }
    public void InsertDriverSettlementDate()
    {
        ExecuteNonQuery(CommandType.Text, "INSERT INTO Webx_Fleet_DriverSettlementDate (DriverSettlementDate,EntryBy) VALUES ('" + DTM.ConvertToDate(DriverSettlementDate) + "','" + EntryBy + "')");
    }
    public void UpdateDriverSettlementDate()
    {
        ExecuteNonQuery(CommandType.Text, "UPDATE Webx_Fleet_DriverSettlementDate SET DriverSettlementDate='" + DTM.ConvertToDate(DriverSettlementDate) + "',EntryBy='" + EntryBy + "'");
    }
    public DataTable GetDriverSettlemnetDate()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select Convert(Varchar,DriverSettlementDate,106) as DriverSettlementDate from Webx_Fleet_DriverSettlementDate");
        return dt;
    }
}
