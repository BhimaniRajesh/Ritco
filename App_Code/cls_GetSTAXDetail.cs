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
/// Summary description for cls_GetSTAXDetail
/// </summary>
public class cls_GetSTAXDetail : DataAccessLayer
{
    private string _Connection_String;
    private string _TransDt;

    private string _STax;
    private string _EduCess;
    private string _HEduCess;
    private string _SBCess;//added BY Anupam
    private string _KKCess;//added BY Anupam

    protected bool _Is_Record_Found;
    public string TransDt { get { return _TransDt; } set { _TransDt = value; } }

    public string STax { get { return _STax; } set { _STax = value; } }
    public string EduCess { get { return _EduCess; } set { _EduCess = value; } }
    public string HEduCess { get { return _HEduCess; } set { _HEduCess = value; } }
    public string SBCess { get { return _SBCess; } set { _SBCess = value; } }//added BY Anupam
    public string KKCess { get { return _KKCess; } set { _KKCess = value; } }//added BY Anupam
    public bool Is_Record_Found { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    public cls_GetSTAXDetail(string Connection_String): base(Connection_String)
    {
        //
        // TODO: Add constructor logic here
        //
        _Connection_String = Connection_String;
    }

    public void GetSTAXDetail()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@TransDt", TransDt);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Get_STAX_Details", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            STax = dt.Rows[0]["svctax_rate"].ToString();
            EduCess = dt.Rows[0]["EDU_CESS_RATE"].ToString();
            HEduCess = dt.Rows[0]["hedu_cess_rate"].ToString();
            SBCess = dt.Rows[0]["SbcRate"].ToString();//added BY Anupam
            KKCess = dt.Rows[0]["KKCessRate"].ToString();//added BY Anupam
        }
        else
        {
            Is_Record_Found = false;
        }
    }
}
