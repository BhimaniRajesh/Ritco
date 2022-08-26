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

public partial class GUI_admin_VehicleMaster_popup_Vehicle : System.Web.UI.Page
{
    //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "Select vehno,vendorcode from webx_vehicle_hdr order by vehno,vendorcode";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        adp.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind(); 

    }
}
 
        


