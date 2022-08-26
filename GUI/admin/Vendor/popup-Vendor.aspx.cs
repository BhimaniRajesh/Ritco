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

public partial class GUI_admin_Vendor_popup_Vendor : System.Web.UI.Page
{
    //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        hdnstrQSParam.Value = HttpUtility.UrlDecode(Request.QueryString.ToString());

        cn.Open();
        string sql = "select vendorcode,vendorname from webx_VENDOR_HDR order by vendorname";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        adp.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        cn.Close();

    }
}
 
        


