using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using ApplicationManager;
using System.Data.SqlClient;



/// <summary>
/// Summary description for cls_AutoMail
/// </summary>
public class cls_AutoMail : DataAccessLayer   
{

    #region Private Declaration

    private string _Connection_String;
    private string _Report_Name;
    private string _Client_Name;
    private string _TetLive;

    #endregion

    #region Properties

    public string Report_Name { get { return _Report_Name; } set { _Report_Name = value; } }
    public string Client_Name { get { return _Client_Name; } set { _Client_Name = value; } }
    public string TetLive { get { return _TetLive; } set { _TetLive = value; } }

    #endregion

    public cls_AutoMail(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }

    public DataSet GetReportParameters()
    {
        DataSet ds = new DataSet();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@sRepoName", Report_Name);
        prm[1] = new SqlParameter("@sClient", Client_Name);
        prm[2] = new SqlParameter("@sLiveTest", TetLive);

        ds = ExecuteDataSet(CommandType.StoredProcedure, "USP_GetReportParameter", prm);
        return ds;
    }
}