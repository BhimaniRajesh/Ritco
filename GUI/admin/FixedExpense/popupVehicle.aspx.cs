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

public partial class GUI_admin_FixedExpense_popupVehicle : System.Web.UI.Page
{
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            hdnstrQSParam.Value = HttpUtility.UrlDecode(Request.QueryString.ToString());
            SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string sql = "SELECT VehNo FROM dbo.webx_VEHICLE_HDR WHERE ACTIVEFLAG='Y'";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            GridVehicle.DataSource = dt;
            GridVehicle.DataBind();
        }
    }
}