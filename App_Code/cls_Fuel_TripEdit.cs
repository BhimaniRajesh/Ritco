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
/// Summary description for cls_Fuel_TripEdit
/// </summary>
public class cls_Fuel_TripEdit : DataAccessLayer
{
    private string _Connection_String;
    protected bool _Is_Record_Found;
    private string _TripsheetNo,_driversettledt;
    private string _Cancel_Status;

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string TripsheetNo { get { return _TripsheetNo; } set { _TripsheetNo = value; } }
    public string driversettledt { get { return _driversettledt; } set { _driversettledt = value; } }
    public string Cancel_Status { get { return _Cancel_Status; } set { _Cancel_Status = value; } }

    public cls_Fuel_TripEdit(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }

    public void GetTripsheetNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TripsheetNo", TripsheetNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Fuel_TripsheetEdit", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TripsheetNo = dt.Rows[0]["VSlipno"].ToString();
            driversettledt = dt.Rows[0]["driversettledt"].ToString();
            Cancel_Status = dt.Rows[0]["Cancel_Status"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetTrip()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TripsheetNo", TripsheetNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Fuel_Trip_Edit", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TripsheetNo = dt.Rows[0]["TripsheetNo"].ToString();
            driversettledt = dt.Rows[0]["driversettledt"].ToString();
            Cancel_Status = dt.Rows[0]["Cancel_Status"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
