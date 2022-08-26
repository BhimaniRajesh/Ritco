using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;



public partial class GUI_Fleet_Operations_Issue_Popup_Vehicle : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string strQSParam;
    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn.Open();
        cmd = new SqlCommand("USP_VALID_VEHICLE", cn);
        cmd.CommandType = CommandType.StoredProcedure;   
        cmd.Parameters.Add("@VEHNO", SqlDbType.VarChar, 100).Value = txtVehNo.Text;
        cmd.Parameters.Add("@BRCD", SqlDbType.VarChar, 100).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();  
        cmd.Parameters.Add("@VENDORTYPE", SqlDbType.VarChar, 100).Value = "05";
		adp = new SqlDataAdapter(cmd);
        cn.Close();
        ds = new DataSet();
        adp.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
    }
}
