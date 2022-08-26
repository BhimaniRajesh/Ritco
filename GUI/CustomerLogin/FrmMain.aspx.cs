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
public partial class GUI_CustomerLogin_FrmMain : System.Web.UI.Page
{
    SqlConnection cn;
    public string Client;
    protected void Page_Load(object sender, EventArgs e)
    {
        string logo = Session["logofile"].ToString();
        imgLogo.ImageUrl = "~/GUI/images/" + logo;

        if (Session["Client"] == "ASL")
        {
            Client = "ASL";
            lblWelcome.Text = "Welcome To ASL Customer Module";
        }
        else
        {
            lblWelcome.Text = "Welcome To RITCO Customer Module";
        }
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        lblccode.Text = Convert.ToString(Session["custcd"]);
        SqlCommand cmd = new SqlCommand("Select CUSTNM from webx_CUSTHDR where CUSTCD='" + lblccode.Text + "'",cn);
        lblcname.Text = Convert.ToString(cmd.ExecuteScalar());
        cn.Close();
    }
    protected void logout(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect(Convert.ToString(Session["RedirectURL"]));
    }
}
