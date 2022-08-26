using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


public partial class GUI_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        lblWelcome.Text = System.Configuration.ConfigurationManager.AppSettings["WelcomeNote"];
        Login1.TitleText = "Customer Login ";
        Login1.UserNameLabelText = "Customer ID";
        if (Session["SqlProvider"] == null)
        {
            Server.Transfer("~/CustomerLogin/GUI/TimeOut.aspx");
        }
        else
        {
            if (Session["empcd"] != null)
            {
                Server.Transfer("~/CustomerLogin/GUI/welcome.aspx");
            }
        }
    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
	Session["SqlProvider"] = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //SqlCommand cmd = new SqlCommand("Select custcd,custnm From WebX_custhdr Where isnull(cust_active,'Y')='Y' and custcd='" + Login1.UserName.Trim() + "' and custpass='" + Login1.Password.Trim() + "'", conn);
        SqlCommand cmd = new SqlCommand("Select custcd,custnm From WebX_custhdr Where isnull(cust_active,'Y')='Y' and custcd=@USERID and custpass=@PWD", conn);
        cmd.Parameters.AddWithValue("@USERID", Login1.UserName.Trim());
        cmd.Parameters.AddWithValue("@PWD", Login1.Password.Trim());
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();
        try
        {
            if (dr.Read())
            {
                Session["empcd"] = dr[0].ToString().Trim();
                Session["empnm"] = dr[1].ToString().Trim();


                //Part 1 the same code as before
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<");
                sb.Append("script language='javascript'>");

                sb.Append("function NoConfirm()");
                sb.Append("{");
                sb.Append("win = top;");
                sb.Append("win.opener = top;");
                sb.Append("win.close ();");
                sb.Append("}");

                if (Session["empcd"].ToString().Trim() == "sa")
                {
                    sb.Append("window.open('./admin/sa.aspx', 'CustomPopUp',");
                }
                else
                {
                    sb.Append("window.open('welcome.aspx', 'CustomPopUp',");
                }
                sb.Append("'top=0, left=0, width=700, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
                sb.Append("NoConfirm();");
                sb.Append("<");
                sb.Append("/script>");

                //Part 2 Registering The ClientScriptBlock
                //Type t = this.GetType();

                //if (!ClientScript.IsClientScriptBlockRegistered("PopupScript"))
                //    ClientScript.RegisterClientScriptBlock("PopupScript", sb.ToString());

                //Check whether they are already registered
                if (!this.IsStartupScriptRegistered("PopupWindow"))
                {
                    //Register the script
                    this.RegisterStartupScript("PopupWindow", sb.ToString());
                }
                dr.Close();



                //Server.Transfer("welcome.aspx");
            }
            else
            {
                Login1.FailureText = "Authentification Failed....";
            }
        }
        finally
        {
            conn.Close();
        }
    }
}
