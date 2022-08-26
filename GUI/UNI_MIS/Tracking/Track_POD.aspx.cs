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


public partial class GUI_Tracking_Track_POD : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string strPFMNo = Request.QueryString.ToString();

        String SQL_grid = "select dockno,fm_no,fmdt,fromloc=(select loccode +':' + locname from webx_location where loccode=FM_crrloc),toLoc=loc_cust_code+ ' -('+doc_fwd_to+')',doc_status,doc_status from VW_FM_TRACK_Report where dockno='" + strPFMNo + "'";

        //Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        dgDocket.Visible = true;
        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Style["display"] = "block";
        conn.Close();
    }
}
