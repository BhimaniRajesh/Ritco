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
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            string a = HttpUtility.UrlDecode(Request.QueryString.ToString());
            string[] a1 = a.Split('|'); 
            hdnstrQSParam.Value = Convert.ToString(a1[0]);//HttpUtility.UrlDecode(Request.QueryString.ToString());
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
            //SqlConnection cn = new SqlConnection(comon.common.cnstr);
            string sql="";
            if (Convert.ToString(a1[1]) == "" || Convert.ToString(a1[1]) == null || Convert.ToString(a1[1]) == "--Select--")
            {
                sql = "select location from webx_citymaster order by location";
            }
            else 
            {
                sql = "select location from webx_citymaster where state='" + Convert.ToString(a1[1]) + "' order by location";
            }
            
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet(); 
            adp.Fill(ds);
            //dt.Columns.Add("Select", typeof(RadioButton));
            //dt.Columns["Select"].AutoIncrement = true;
            GridView1.DataSource = ds;
            GridView1.DataBind(); 
  
        }

    }
}
