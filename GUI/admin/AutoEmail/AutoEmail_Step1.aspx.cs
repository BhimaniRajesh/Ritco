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

public partial class GUI_admin_AutoEmail_AutoEmail_Step1 : System.Web.UI.Page
{
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string SQLSTR = "exec webx_CreateMailProfile '" + txtemailid.Text.ToString() + "','" + txtName.Text.ToString() + "','" + txtUsername.Text.ToString() + "','" + txtPWD.Text.ToString() + "','" + txtServer.Text.ToString() + "'";
        SqlCommand cmd = new SqlCommand(SQLSTR, Conn);
        cmd.ExecuteNonQuery();

        Conn.Close();

        Response.Redirect("./ProfileListing.aspx");
    }
}
