using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
public partial class Docket_Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string dockno = Request.QueryString.Get("strDckNo");
        Response.Write("<br> dockno 2: " + dockno);


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string sql = "USP_QTRACK";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@FromDt", SqlDbType.DateTime).Value = dockno;

        DataSet ds = new DataSet();
        da.Fill(ds);



        dgSales.DataSource = ds;
        dgSales.DataBind();
        conn.Close();
    }
}
