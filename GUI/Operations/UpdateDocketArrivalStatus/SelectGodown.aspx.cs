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

public partial class GUI_Operations_UpdateDocketArrivalStatus_SelectGodown : System.Web.UI.Page
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
            string strSQL = "Select godown_srno,godown_name from webx_GODOWNMST where SPDBRCD='" + Session["brcd"].ToString() + "' order by godown_name";
            
            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);

            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet ds = new DataSet();

            sqlDA.Fill(ds);

            DataTable dt = new DataTable();

            dt.Columns.Add("Godown_ID", typeof(string));
            dt.Columns.Add("Godown_NAME", typeof(string));
            dt.Columns.Add("Godown_ID_Name", typeof(string));

            DataRow dr;

            intTotalRecords = ds.Tables[0].Rows.Count;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["Godown_ID"] = drRows["godown_srno"].ToString();
                dr["Godown_NAME"] = drRows["godown_name"].ToString();
                dr["Godown_ID_Name"] = drRows["godown_srno"].ToString() + " : " + drRows["godown_name"].ToString();

                dt.Rows.Add(dr);
            }

            rptGodown.DataSource = dt;
            rptGodown.DataBind();
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
