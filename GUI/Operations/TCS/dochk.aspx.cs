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

public partial class GUI_Operations_TCS_dochk : System.Web.UI.Page
{
    public string sql, result = "", vehno, vendorCode;

    protected void Page_Load(object sender, EventArgs e)
    {
        string dockno = Request.QueryString["dockno"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        sql = "select * from WebX_Trans_Docket_Status where MF is NULL and THC is NULL and Delivered='N' and Cancelled='N' and LS='" + dockno + "'";
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr = cmd.ExecuteReader();
            Int16 cnt = 0;
            if(dr.Read())
            {
                result = "OK";
                dockno = dr["LS"].ToString();
            }
            
            else
            {
                result = "Invalid Loading Sheet No.";
            }
            dr.Close();
        
        Response.Write(result + "|" + dockno );
    }
    
}
