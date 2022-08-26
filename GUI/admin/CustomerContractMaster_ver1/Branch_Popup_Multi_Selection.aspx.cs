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

public partial class Branch_Popup_Multi_Selection : System.Web.UI.Page
{
    //static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");

    String strSP = "";

    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strCount = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());

            //if(strQSParam.Trim() != "")
            //{
            //    string[] strArrQS = strQSParam.Split(',');

            //    strMode = strArrQS[0];
            //    strCount = strArrQS[1];
            //}

            strMode = strQSParam;
        }

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSP = "Webx_SP_GetLocationDetails";

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = strSP;

        sqlCommand.Parameters.Add("@ActiveYN", "Y");

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
