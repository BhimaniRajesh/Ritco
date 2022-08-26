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



public partial class GUI_Fleet_Operations_Issue_popupcustcode : System.Web.UI.Page
{
    public static string strQSParam;

    protected void Page_Load(object sender, EventArgs e)
    {
        strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        // SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
        //SqlConnection cn = new SqlConnection(comon.common.cnstr);

        //ServiceOptFor:02 means FLEET CUSTOMER
        string sql = "Select custcd,custnm from webx_CUSTHDR where CUST_ACTIVE='Y' and ServiceOptFor like'%02%'  order by custcd";
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
