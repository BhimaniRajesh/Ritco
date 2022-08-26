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

public partial class GUI_admin_CustomerMaster_popup_CUST : System.Web.UI.Page
{

    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string strQSParam;
    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {

        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //CREATE proc usp_Trip_Customer
        //(
        //@custcd varchar(20),
        //@custnm varchar(4000)
        //)
        //as

        //Select custcd,custnm from webx_CUSTHDR  
        //where CUST_ACTIVE='Y' 
        //and (custcd like @custcd + '%' or @custcd='')
        //and (custnm like @custnm + '%' or @custnm='')
        sql = "usp_Trip_Customer";
        cmd = new SqlCommand(sql, cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@custcd", SqlDbType.VarChar, 20).Value = txtCustCd.Text;
        cmd.Parameters.Add("@custnm", SqlDbType.VarChar, 4000).Value = txtCustNm.Text;
        adp = new SqlDataAdapter(cmd);
        ds = new DataSet();
        adp.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
    }
}

        
   

