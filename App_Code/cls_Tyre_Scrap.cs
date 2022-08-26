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
/// Summary description for cls_Tyre_Remould
/// </summary>
public class cls_Tyre_Scrap : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String;

    private string _Tyre_No;
    private DateTime _Scrap_Date;
    private string _Scrap_Vendor;
    private double _Scrap_Value;
    private double _Estimated_Scrap_Value;
    private string _Remarks;
    private string _Entry_By;
    private string _VENDORNAME;
    private string _VENDORCODE;

    protected bool _Is_Record_Found;

    #endregion

    #region Properties

    public string Tyre_No { get { return _Tyre_No; } set { _Tyre_No = value; } }
    public DateTime Scrap_Date { get { return _Scrap_Date; } set { _Scrap_Date = value; } }
    public string Scrap_Vendor { get { return _Scrap_Vendor; } set { _Scrap_Vendor = value; } }
    public double Scrap_Value { get { return _Scrap_Value; } set { _Scrap_Value = value; } }
    public double Estimated_Scrap_Value { get { return _Estimated_Scrap_Value; } set { _Estimated_Scrap_Value = value; } }
    public string Remarks { get { return _Remarks; } set { _Remarks = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string VENDORNAME { get { return _VENDORNAME; } set { _VENDORNAME = value; } }
    public string VENDORCODE { get { return _VENDORCODE; } set { _VENDORCODE = value; } }


    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    #endregion

    public cls_Tyre_Scrap(string ConnectionString)
        : base(ConnectionString)
    { 
        _Connection_String = ConnectionString; 
    }

    public void InsertTyreScrap()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@Tyre_No", Tyre_No);
        prm[1] = new SqlParameter("@Scrap_Date", Scrap_Date);
        prm[2] = new SqlParameter("@Scrap_Vendor", VENDORCODE);
        prm[3] = new SqlParameter("@Scrap_Value", Scrap_Value);
        prm[4] = new SqlParameter("@Estimated_Scrap_Value", Estimated_Scrap_Value);
        prm[5] = new SqlParameter("@Remarks", Remarks);
        prm[6] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_Insert_Webx_Fleet_TyresSrap", prm);
    }

    //public void BindGridTyreRemould(DataGrid dg)
    //{
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    SqlParameter[] prm = new SqlParameter[8];

    //    prm[0] = new SqlParameter("@RemouldId", (RemouldId == null) ? "" : RemouldId);
    //    prm[1] = new SqlParameter("@TyreId", TyreId);
    //    prm[2] = new SqlParameter("@CaptureKM", (CaptureKM == null) ? "" : CaptureKM);
    //    prm[3] = new SqlParameter("@Cost", (Cost == null) ? "" : Cost);
    //    prm[4] = new SqlParameter("@TotalCost", (TotalCost == null) ? "" : TotalCost);
    //    prm[5] = new SqlParameter("@RemouldTyreLife", (RemouldTyreLife == null) ? "" : RemouldTyreLife);
    //    prm[6] = new SqlParameter("@RemouldVendor", (RemouldVendor == null) ? "" : RemouldVendor);
    //    prm[7] = new SqlParameter("@RemouldDate", RemouldDate);
        
    //    dcm.DataBind(dg, CommandType.StoredProcedure, "usp_Search_Tyre_Remould", prm);
    //}

    public void CheckVendorName()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VENDORNAME", VENDORNAME);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_FLEET_GET_VENDORNAME", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            VENDORNAME = dt.Rows[0]["VENDORNAME"].ToString();
            VENDORCODE = dt.Rows[0]["VENDORCODE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
   
}
