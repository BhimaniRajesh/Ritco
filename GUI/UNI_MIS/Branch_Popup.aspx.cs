using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Branch_Popup : System.Web.UI.Page
{
    //static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE;";
    //static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");

    String strSQL = "";
    
    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strReport_Branch = "";
    public static string strRegion = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());

            if(strQSParam.Trim() != "")
            {
                string[] strArrQS = strQSParam.Split(',');

                strMode = strArrQS[0];
                strReport_Branch = strArrQS[1];
                strRegion = strArrQS[2];
            }
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        if (strReport_Branch != "A" && strRegion != "A")
        {
            strSQL = "SELECT loccode, locname FROM webx_location WHERE report_level='3' AND report_loc='" + strReport_Branch + "' AND report_loc<>loccode AND activeflag='Y' ORDER BY locname";
        }
        else if (strReport_Branch == "A" && strRegion != "A")
        {
            strSQL = "SELECT loccode, locname FROM webx_location WHERE report_loc IN (SELECT loccode FROM webx_location WHERE report_loc='" + strRegion + "') AND report_loc<>loccode AND activeflag='Y' ORDER BY locname";
        }
        else
        {
            strSQL = "SELECT loccode, locname FROM webx_Location WHERE activeflag='Y' ORDER BY locname";
        }

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("BranchCode", typeof(string));
        dt.Columns.Add("BranchName", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["BranchCode"] = drRows["loccode"].ToString();
            dr["BranchName"] = drRows["locname"].ToString();

            dt.Rows.Add(dr);
        }

        rptBranch.DataSource = dt;
        rptBranch.DataBind();
    }
}
