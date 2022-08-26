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

           // SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
            //SqlConnection cn = new SqlConnection(comon.common.cnstr);



           string strSQL = "SELECT DISTINCT CUSTCD, CUSTNM FROM webx_CUSTHDR WHERE CUSTCD IS NOT NULL ";

            //if (txtCustCode.Value != "")
            //{
            //    strSQL = strSQL + " AND CUSTCD LIKE '" + txtCustCode.Value.Replace("'", "''") + "%'";
            //}
            //else if (txtCustName.Value != "")
            //{
            //    strSQL = strSQL + " AND CUSTNM LIKE '" + txtCustName.Value.Replace("'", "''") + "%'";
            //}

            strSQL = strSQL + " ORDER BY CUSTNM";

            SqlCommand cmd = new SqlCommand(strSQL, cn);
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
