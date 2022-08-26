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

public partial class logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection(mydbcon);
        conn.Open();
        if (Session["RedirectURL"] != null)
        {
            string str = Session["RedirectURL"].ToString().Trim();
            Session.Abandon();
            //FormsAuthentication.SignOut();
            //Response.Write("<script type='text/javascript'>popup=window.open('./default.aspx');window.close();</script>");
            /*
            Response.Redirect(str, true);
             */

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


            //sb.Append("window.open('" + str + "', 'LoginWin',");
            //sb.Append("'top=0, left=0, width=500, height=500, menubar=no,toolbar=no,status=1,resizable=yes');");
            sb.Append("NoConfirm();");
            sb.Append("<");
            sb.Append("/script>");

            //Part 2 Registering The ClientScriptBlock
            //Type t = this.GetType();

            //if (!ClientScript.IsClientScriptBlockRegistered("PopupScript"))
            //    ClientScript.RegisterClientScriptBlock("PopupScript", sb.ToString());

            //Check whether they are already registered
            if (!this.IsStartupScriptRegistered("LoginWindow"))
            {
                //Register the script
                this.RegisterStartupScript("LoginWindow", sb.ToString());
            }

            string sql1 = "Update  webx_Login  set LOGOUTDT=getdate() where sessionID='" + Session.SessionID + "'";
            SqlCommand sqlcmd = new SqlCommand(sql1, conn);
            // sqlcmd.Transaction = trans;
            sqlcmd.ExecuteNonQuery();

            string sql2 = "select datediff(n,LASTLOGINDT,LOGOUTDT) as diff from webx_Login where sessionID='" + Session.SessionID + "'";
            SqlCommand sqlcmd1 = new SqlCommand(sql2, conn);
            SqlDataReader dr1 = sqlcmd1.ExecuteReader();
            string diff = "";
            while (dr1.Read())
            {
                 diff = dr1["diff"].ToString();
            }
            dr1.Close();

            string sql3 = "Update  webx_Login  set  Duration='" + diff + "' where sessionID='" + Session.SessionID + "'";
            SqlCommand sqlcmd2 = new SqlCommand(sql3, conn);
            // sqlcmd.Transaction = trans;
            sqlcmd2.ExecuteNonQuery();
        }
        else
        {
            Response.Redirect("~/GUI/TimeOut.aspx", true);     
        }

        conn.Close();
    }
}
