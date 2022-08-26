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

public partial class popupbranch : System.Web.UI.Page
{
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
            SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
            //SqlConnection cn = new SqlConnection(comon.common.cnstr);
            //string sql = "Select Location from webx_citymaster where location <>'' order by Location ";
            //string sql = "select DISTINCT LocCode,LocName as Location from webx_location  INNER JOIN webx_vehicle_hdr ON webx_location.LocCode=webx_vehicle_hdr.Conrtl_branch ORDER BY LocName";
            string sql = "select LocName,LocCode,LocCode + ' : ' +LocName as [Location] from webx_location ORDER BY LocName";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind(); 
  
        }

    }
}
