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

public partial class GUI_admin_CustomerMaster_popupLoc : System.Web.UI.Page
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
            //string sql = "select distinct A.LOCCD, B.LOCNAME from webx_CUSTDET A, webx_LOCATION B where A.LOCCD=B.LocCode and A.CUSTCD='" + Session["popCustCd"].ToString() + "' order by B.LOCNAME";
            string sql = "Select loccode,locname from webx_Location where activeflag='Y' order by locname";
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
}

