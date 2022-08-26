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

public partial class GUI_Operations_UpdateDocketArrivalStatus_SelectArrivalCondition : System.Web.UI.Page
{
    public int intTotalRecords = 0;

    public static string strQSParam;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strQSParam = HttpUtility.UrlDecode(Request.QueryString["ControlName"].ToString());
        }

        DisplayList();
    }

    private void DisplayList()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        try
        {
            //string strSQL = "Select UTY_ID,UTY_NAME From webx_UTYMAST Where UTY_ID like 'C%' Order By UTY_ID";
            string strSQL = "select CodeId, CodeId + ' : ' + CodeDesc AS Code from webx_master_general where codetype = 'RECV' and StatusCode = 'Y' ORDER BY CodeId";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet ds = new DataSet();

            sqlDA.Fill(ds);

            DataTable dt = new DataTable();

            dt.Columns.Add("CodeId", typeof(string));
            dt.Columns.Add("Code", typeof(string));
            dt.Columns.Add("CodeIDName", typeof(string));

            DataRow dr;

            intTotalRecords = ds.Tables[0].Rows.Count;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["CodeId"] = drRows["CodeId"].ToString();
                dr["Code"] = drRows["Code"].ToString();
                dr["CodeIDName"] = drRows["CodeId"].ToString() + " : " + drRows["Code"].ToString();

                dt.Rows.Add(dr);
            }

            rptCondition.DataSource = dt;
            rptCondition.DataBind();
        }
        catch (Exception Ex)
        {

        }
        finally
        {
            sqlConn.Close();
            sqlConn = null;
        }
    }
}
