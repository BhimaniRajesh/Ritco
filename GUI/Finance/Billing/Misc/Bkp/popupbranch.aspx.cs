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
            string sql = "SELECT DISTINCT CUSTCD, CUSTNM FROM webx_CUSTHDR WHERE CUSTCD IS NOT NULL";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            //dt.Columns.Add("Select", typeof(RadioButton));
            //dt.Columns["Select"].AutoIncrement = true;
            GridView1.DataSource = dt;
            GridView1.DataBind(); 
           // SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
            //SqlConnection cn = new SqlConnection(comon.common.cnstr);
           
            
        }
    }


    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        string sql = "SELECT DISTINCT CUSTCD, CUSTNM FROM webx_CUSTHDR WHERE CUSTCD IS NOT NULL";

            if (txtVendorCode.Value != "")
            {
                sql = sql + " AND CUSTCD LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
            }
            else if (txtVendorName.Value != "")
            {
                sql = sql + " AND CUSTNM LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
            }

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
