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

public partial class GUI_Finance_re_assign_vendor_code_VendorCode : System.Web.UI.Page
{
    public static string cd, nm;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            cd = Request.QueryString["cd"].ToString();
            hdnCD.Value = cd;
            SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            string sql = "select VendorCode,VendorName from webx_VENDOR_HDR where active is NULL or active='Y'";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
    }
}
