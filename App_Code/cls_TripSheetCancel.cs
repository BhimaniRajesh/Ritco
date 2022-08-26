using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using ApplicationManager;
using System.Data.SqlClient;

/// <summary>
/// Summary description for cls_TripSheetCancel
/// </summary>
public class cls_TripSheetCancel : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _VSlipNo;
    private string _Manual_TripSheetNo;
    private string _VSlipDt;
    private string _VEHNO;
    private string _Category;
    private string _THC_Attached_YN;
    private string _Status;

    private string _Cancel_Dt;
    private string _Cancel_Status;
    private string _Cancel_Entry_dt;
    private string _Cancel_Remarks;
    private string _TripSheet_Cancel;
    private string _TripsheetNo;
    private string _YearVal;
    private string _TripSheet_Row;
    private string _Driver1;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string VSlipNo { get { return _VSlipNo; } set { _VSlipNo = value; } }
    public string Manual_TripSheetNo { get { return _Manual_TripSheetNo; } set { _Manual_TripSheetNo = value; } }
    public string VSlipDt { get { return _VSlipDt; } set { _VSlipDt = value; } }
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string Category { get { return _Category; } set { _Category = value; } }
    public string THC_Attached_YN { get { return _THC_Attached_YN; } set { _THC_Attached_YN = value; } }
    public string Status { get { return _Status; } set { _Status = value; } }
    
    public string Cancel_Dt { get { return _Cancel_Dt; } set { _Cancel_Dt = value; } }
    public string Cancel_Status { get { return _Cancel_Status; } set { _Cancel_Status = value; } }
    public string Cancel_Entry_dt { get { return _Cancel_Entry_dt; } set { _Cancel_Entry_dt = value; } }
    public string Cancel_Remarks { get { return _Cancel_Remarks; } set { _Cancel_Remarks = value; } }
    public string TripSheet_Cancel { get { return _TripSheet_Cancel; } set { _TripSheet_Cancel = value; } }
    public string TripsheetNo { get { return _TripsheetNo; } set { _TripsheetNo = value; } }
    public string YearVal { get { return _YearVal; } set { _YearVal = value; } }
    public string TripSheet_Row { get { return _TripSheet_Row; } set { _TripSheet_Row = value; } }
    public string Driver1 { get { return _Driver1; } set { _Driver1 = value; } }
    
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_TripSheetCancel(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }

    public void GetTripSheetNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@TRIPSHEETNO", VSlipNo);
        prm[1] = new SqlParameter("@Manual_TRIPSHEETNO", Manual_TripSheetNo);
        prm[2] = new SqlParameter("@Flag", TripSheet_Row);
        prm[3] = new SqlParameter("@Company_Code", SessionUtilities.DefaultCompanyCode.ToUpper().Trim());

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_TRIP_SHEET_NO", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VSlipNo = dt.Rows[0]["VSlipNo"].ToString();
            TripsheetNo = dt.Rows[0]["TripsheetNo"].ToString();
            Manual_TripSheetNo = dt.Rows[0]["Manual_TripSheetNo"].ToString();
            VSlipDt = dt.Rows[0]["VSlipDt"].ToString();
            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            Category = dt.Rows[0]["Category"].ToString();
            THC_Attached_YN = dt.Rows[0]["THC_Attached_YN"].ToString();
            Status = dt.Rows[0]["Status"].ToString();
            Cancel_Dt = dt.Rows[0]["Cancel_Dt"].ToString();
            Cancel_Status = dt.Rows[0]["Cancel_Status"].ToString();
            Cancel_Entry_dt = dt.Rows[0]["Cancel_Entry_dt"].ToString();
            Driver1 = dt.Rows[0]["Driver1"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

     public void GetTripCancelDate()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@TRIPSHEETNO", VSlipNo);
        prm[1] = new SqlParameter("@Manual_TRIPSHEETNO", Manual_TripSheetNo);
        prm[2] = new SqlParameter("@Flag", TripSheet_Row);
        prm[3] = new SqlParameter("@Cancel_Dt", Cancel_Dt);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_TripSheet_Cancel_Date", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }

     public void UpdateTripSheetNo()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@TRIPSHEETNO", VSlipNo);
        prm[1] = new SqlParameter("@Cancel_Dt", Cancel_Dt);
        prm[2] = new SqlParameter("@Cancel_Remarks", Cancel_Remarks);
        prm[3] = new SqlParameter("@Fin_Year", YearVal);
        prm[4] = new SqlParameter("@TripSheet_Cancel_Rule", TripSheet_Cancel);
        prm[5] = new SqlParameter("@Driver1", Driver1);
        prm[6] = new SqlParameter("@Vehno", VEHNO);

        ExecuteNonQuery(CommandType.StoredProcedure, "Update_Manual_TripSheet_Cancel", prm);
    }


     public void CheckTripRule()
     {
         DataTable dt = new DataTable();
         dt = ExecuteDataTable(CommandType.Text, "Select TripSheet_Cancel,TripSheet_Row  From Webx_Fleet_Triprule");

         if (dt.Rows.Count > 0)
         {
             TripSheet_Cancel = dt.Rows[0]["TripSheet_Cancel"].ToString().Trim();
             TripSheet_Row = dt.Rows[0]["TripSheet_Row"].ToString().Trim();

             IsRecordFound = true;
         }
         else
         {
             IsRecordFound = false;
         }
     }
}

