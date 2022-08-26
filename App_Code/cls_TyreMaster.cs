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
public class cls_TyreMaster : DataAccessLayer 
{
    #region Private Declaration
    private string _Connection_String;
    private string _OPCODE;
    private string _TYRE_ID;
    private string _TYRE_OE;
    private string _TYRE_NO;
    private string _TYRE_CATEGORY;
    private string _TYRE_SIZEID;
    private string _MFG_ID;
    private string _TYRE_TYPEID;
    //private string _TYRE_WARRANTY_EXPDT;
    //private string _TYRE_WARRANTY_EXPKMS;
    private string _TYRE_TREAD_DEPTH_32NDS;
    private string _TYRE_PURDT;
    private string _TYRE_PUR_KMS;
    private string _TYRE_COST;
    private string _TYRE_VEHNO;
    private string _TYRE_LOCATION;
    private string _TYRE_VENDOR;
    private string _TYRE_ENTRYBY;
    //private string _TYRE_ENTRYDT;
    private string _VEH_INTERNAL_NO;
    private string _TYREPOS_ID;
    private string _TYRE_ACTIVEFLAG;
    private string _TYRE_STATUS;
    private string _TYRE_PATTERN_DESC;
    private string _TYRE_MODEL_ID;
    private string _POS_CATEGORY;
    private string _Tyre_Weight;
    private string _Outer_Dimension;
    private string _Company_Code;
    protected bool _Is_Record_Found;
    #endregion

    #region Properties

    public string OPCODE { get { return _OPCODE; } set { _OPCODE = value; } }
    public string TYRE_ID { get { return _TYRE_ID; } set { _TYRE_ID = value; } }
    public string TYRE_OE { get { return _TYRE_OE; } set { _TYRE_OE = value; } }
    public string TYRE_NO { get { return _TYRE_NO; } set { _TYRE_NO = value; } }
    public string TYRE_CATEGORY { get { return _TYRE_CATEGORY; } set { _TYRE_CATEGORY = value; } }
    public string TYRE_SIZEID { get { return _TYRE_SIZEID; } set { _TYRE_SIZEID = value; } }
    public string MFG_ID { get { return _MFG_ID; } set { _MFG_ID = value; } }
    public string TYRE_TYPEID { get { return _TYRE_TYPEID; } set { _TYRE_TYPEID = value; } }
    //public string TYRE_WARRANTY_EXPDT { get { return _TYRE_WARRANTY_EXPDT; } set { _TYRE_WARRANTY_EXPDT = value; } }
    //public string TYRE_WARRANTY_EXPKMS { get { return _TYRE_WARRANTY_EXPKMS; } set { _TYRE_WARRANTY_EXPKMS = value; } }
    public string TYRE_TREAD_DEPTH_32NDS { get { return _TYRE_TREAD_DEPTH_32NDS; } set { _TYRE_TREAD_DEPTH_32NDS = value; } }
    public string TYRE_PURDT { get { return _TYRE_PURDT; } set { _TYRE_PURDT = value; } }
    public string TYRE_PUR_KMS { get { return _TYRE_PUR_KMS; } set { _TYRE_PUR_KMS = value; } }
    public string TYRE_COST { get { return _TYRE_COST; } set { _TYRE_COST = value; } }
    public string TYRE_VEHNO { get { return _TYRE_VEHNO; } set { _TYRE_VEHNO = value; } }
    public string TYRE_LOCATION { get { return _TYRE_LOCATION; } set { _TYRE_LOCATION = value; } }
    public string TYRE_VENDOR { get { return _TYRE_VENDOR; } set { _TYRE_VENDOR = value; } }
    public string TYRE_ENTRYBY { get { return _TYRE_ENTRYBY; } set { _TYRE_ENTRYBY = value; } }
    //public string TYRE_ENTRYDT { get { return _TYRE_ENTRYDT; } set { _TYRE_ENTRYDT = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string TYREPOS_ID { get { return _TYREPOS_ID; } set { _TYREPOS_ID = value; } }
    public string TYRE_ACTIVEFLAG { get { return _TYRE_ACTIVEFLAG; } set { _TYRE_ACTIVEFLAG = value; } }
    public string TYRE_STATUS { get { return _TYRE_STATUS; } set { _TYRE_STATUS = value; } }
    public string TYRE_PATTERN_DESC { get { return _TYRE_PATTERN_DESC; } set { _TYRE_PATTERN_DESC = value; } }
    public string TYRE_MODEL_ID { get { return _TYRE_MODEL_ID; } set { _TYRE_MODEL_ID = value; } }
    public string POS_CATEGORY { get { return _POS_CATEGORY; } set { _POS_CATEGORY = value; } }
    public string Tyre_Weight { get { return _Tyre_Weight; } set { _Tyre_Weight = value; } }
    public string Outer_Dimension { get { return _Outer_Dimension; } set { _Outer_Dimension = value; } }
    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    #endregion

    public cls_TyreMaster(string ConnectionString) : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}
    public void BindGridTyreMaster(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];
        prm[0] = new SqlParameter("@OPCODE", OPCODE);
        prm[1] = new SqlParameter("@TYRE_ID", TYRE_ID);

        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_TYREMST", prm);
    }
    public void InsertTyreMaster()
    {
        SqlParameter[] prm = new SqlParameter[26];
        prm[0] = new SqlParameter("@TYRE_ID", (TYRE_ID == null) ? "" : TYRE_ID);
        prm[1] = new SqlParameter("@TYRE_OE", TYRE_OE);
        prm[2] = new SqlParameter("@TYRE_NO", TYRE_NO);
        prm[3] = new SqlParameter("@TYRE_CATEGORY", TYRE_CATEGORY);
        prm[4] = new SqlParameter("@TYRE_SIZEID", TYRE_SIZEID);
        prm[5] = new SqlParameter("@MFG_ID", MFG_ID);
        prm[6] = new SqlParameter("@TYRE_TYPEID", TYRE_TYPEID);
        prm[7] = new SqlParameter("@TYRE_TREAD_DEPTH_32NDS",TYRE_TREAD_DEPTH_32NDS);
        prm[8] = new SqlParameter("@TYRE_PURDT", TYRE_PURDT);
        prm[9] = new SqlParameter("@TYRE_PUR_KMS", TYRE_PUR_KMS);
        prm[10] = new SqlParameter("@TYRE_COST", TYRE_COST);
        prm[11] = new SqlParameter("@TYRE_VEHNO", TYRE_VEHNO);
        prm[12] = new SqlParameter("@TYRE_LOCATION", TYRE_LOCATION); 
        prm[13] = new SqlParameter("@TYRE_VENDOR", TYRE_VENDOR);
        prm[14] = new SqlParameter("@TYRE_ENTRYBY", TYRE_ENTRYBY);
        prm[15] = new SqlParameter("@VEH_INTERNAL_NO",VEH_INTERNAL_NO);
        prm[16] = new SqlParameter("@TYREPOS_ID", TYREPOS_ID);
        prm[17] = new SqlParameter("@TYRE_ACTIVEFLAG", TYRE_ACTIVEFLAG);
        prm[18] = new SqlParameter("@TYRE_STATUS", TYRE_STATUS);
        prm[19] = new SqlParameter("@TYRE_PATTERN_DESC", TYRE_PATTERN_DESC);
        prm[20] = new SqlParameter("@OPCODE", OPCODE);
        prm[21] = new SqlParameter("@TYRE_MODEL_ID", TYRE_MODEL_ID);
        prm[22] = new SqlParameter("@POS_CATEGORY", POS_CATEGORY);
        prm[23] = new SqlParameter("@Tyre_Weight", Tyre_Weight == "" ? "0" : Tyre_Weight);
        prm[24] = new SqlParameter("@Outer_Dimension", Outer_Dimension == "" ? "0" : Outer_Dimension);
        prm[25] = new SqlParameter("@Company_Code", Company_Code);
        
        ExecuteNonQuery(CommandType.StoredProcedure, "USP_TYREMST", prm);
    }

    public void CheckValidTyreNo(string tyreid)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@TYRE_NO", TYRE_NO);
        prm[1] = new SqlParameter("@TYREID", tyreid);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_TyreMst_No", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            TYRE_NO = dt.Rows[0]["TYRE_NO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void FillTreadDepth(string modelid)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TYRE_MODEL_ID",modelid);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Fill_TreadDepth", prm);

        if (dt.Rows.Count > 0)
        {
            TYRE_TREAD_DEPTH_32NDS = dt.Rows[0]["TREAD_DEPTH"].ToString();
        }
        else
        {
            TYRE_TREAD_DEPTH_32NDS = "0";
        }
    }
    public void CheckValidSizeName(string sizename,string sizeid)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@TYRE_SIZENAME", sizename);
        prm[1] = new SqlParameter("@SIZEID", sizeid);
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_SizeName", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
