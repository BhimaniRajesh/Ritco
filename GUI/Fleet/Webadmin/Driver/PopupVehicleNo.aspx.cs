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
public partial class GUI_Fleet_Webadmin_Driver_PopupVehicleNo : System.Web.UI.Page
{
    public static string strQSParam;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
        //SqlConnection cn = new SqlConnection(comon.common.cnstr);
        string sql = "Select VEHNO from webx_VEHICLE_HDR where ACTIVEFLAG='Y' order by VEHNO";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        adp.Fill(dt);
        //dt.Columns.Add("Select", typeof(RadioButton));
        //dt.Columns["Select"].AutoIncrement = true;
        GridView1.DataSource = dt;
        GridView1.DataBind(); 
    }
}
