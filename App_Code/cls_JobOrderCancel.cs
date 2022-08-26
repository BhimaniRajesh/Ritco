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
/// Summary description for cls_JobOrderCancel
/// </summary>
public class cls_JobOrderCancel : DataAccessLayer 
{
    public cls_JobOrderCancel(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString; 
	}

    #region Private Declaration
    private string _Connection_String;
    private string _Job_Order_No;
    private string _Job_Order_Dt;
    private string _VEHNO;
    private string _JS_BRCD;
    private string _ORDER_STATUS;
    //private string _VENDOR;
    private string _Cancel_Status;
    private string _Cancel_Dt;
    private string _Cancel_Actual_Dt;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties
    public string Job_Order_No { get { return _Job_Order_No; } set { _Job_Order_No = value; } }
    public string Job_Order_Dt { get { return _Job_Order_Dt; } set { _Job_Order_Dt = value; } }
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string JS_BRCD { get { return _JS_BRCD; } set { _JS_BRCD = value; } }
    public string ORDER_STATUS { get { return _ORDER_STATUS; } set { _ORDER_STATUS = value; } }
    //public string VENDOR { get { return _VENDOR; } set { _VENDOR = value; } }
    public string Cancel_Status { get { return _Cancel_Status; } set { _Cancel_Status = value; } }
    public string Cancel_Dt { get { return _Cancel_Dt; } set { _Cancel_Dt = value; } }
    public string Cancel_Actual_Dt { get { return _Cancel_Actual_Dt; } set { _Cancel_Actual_Dt = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public void GetJobOrderNo()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Job_Order_No", Job_Order_No);
        //prm[1] = new SqlParameter("@Company_Code", SessionUtilities.DefaultCompanyCode.ToUpper().Trim());

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_JOB_ORDER_NO", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            Job_Order_No = dt.Rows[0]["Job_Order_No"].ToString();
            Job_Order_Dt = dt.Rows[0]["Job_Order_Dt"].ToString();
            VEHNO = dt.Rows[0]["VEHNO"].ToString();
            JS_BRCD = dt.Rows[0]["JS_BRCD"].ToString();
            ORDER_STATUS = dt.Rows[0]["ORDER_STATUS"].ToString();
            //VENDOR = dt.Rows[0]["VENDOR"].ToString();
            Cancel_Status = dt.Rows[0]["Cancel_Status"].ToString();

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void GetCancel_Date()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@Job_Order_No", Job_Order_No);
        prm[1] = new SqlParameter("@Cancel_Dt", Cancel_Dt);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_GET_Cancel_Date", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            //Job_Order_No = dt.Rows[0]["Job_Order_No"].ToString();
            //Job_Order_Dt = dt.Rows[0]["Job_Order_Dt"].ToString();
            //Cancel_Dt = dt.Rows[0]["Cancel_Dt"].ToString();
            //Cancel_Actual_Dt = dt.Rows[0]["Cancel_Actual_Dt"].ToString();
            
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
