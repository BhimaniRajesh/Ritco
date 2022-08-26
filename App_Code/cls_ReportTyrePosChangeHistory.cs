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
/// Summary description for General
/// </summary>
public class cls_ReportTyrePosChangeHistory : DataAccessLayer
{
    private string _Connection_String;
    private string _TyreNo;
    private string _Manufacturer;
    private string _TyreModel;
    private string _TyreSize;
    private string _TyrePattern;
    private string _TyreType;
    private string _TyreId;
    protected bool _Is_Record_Found;


    public string TyreNo { get { return _TyreNo; } set { _TyreNo = value; } }
    public string Manufacturer { get { return _Manufacturer; } set { _Manufacturer = value; } }
    public string TyreModel { get { return _TyreModel; } set { _TyreModel = value; } }
    public string TyreSize { get { return _TyreSize; } set { _TyreSize = value; } }
    public string TyrePattern { get { return _TyrePattern; } set { _TyrePattern = value; } }
    public string TyreType { get { return _TyreType; } set { _TyreType = value; } }
    public string TyreId { get { return _TyreId; } set { _TyreId = value; } }
    public bool Is_Record_Found { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    public cls_ReportTyrePosChangeHistory(string Connection_String): base(Connection_String)
	{
		//
		// TODO: Add constructor logic here 
		//
        _Connection_String = Connection_String; 
	}
   
  
    public void GetTyreDetails()
    { 
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Tyre_No", TyreNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Get_Tyre_Det_Repo_Tyre_PosChange_History", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;
            TyreNo = dt.Rows[0]["TYRE_NO"].ToString();
            Manufacturer = dt.Rows[0]["MFG"].ToString();
            TyreModel = dt.Rows[0]["MODEL"].ToString();
            TyreSize = dt.Rows[0]["TYRESIZE"].ToString();
            TyrePattern = dt.Rows[0]["PATTERN"].ToString();
            TyreType = dt.Rows[0]["TYRETYPE"].ToString(); 
            TyreId = dt.Rows[0]["TYRE_ID"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }
}
