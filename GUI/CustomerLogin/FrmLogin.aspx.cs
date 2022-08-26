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
using System.Data.SqlClient;
public partial class _Default : System.Web.UI.Page
{
    //string mydbcon = System.Configuration.ConfigurationManager.AppSettings["dbConnection"];
    SqlConnection cn = new SqlConnection();
    Int32 a;
    public string Client;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;

        string logo = Session["logofile"].ToString();
        imgLogo.ImageUrl = "~/GUI/images/" + logo;

        if (Session["Client"] == "AGL")
        {
            Client = "AGL";
            lblWelcome.Text = "Welcome To ASL Customer Module";
        }
        else
        {
            lblWelcome.Text = "Welcome To RITCO Customer Login";
        }
        
        lblcusterror.Visible = false;
        //lblgrperror.Visible = false;
        a = 0;
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        //string str = Request.Path;
        ////Response.Write(str);
        ////Response.End();
        //if (str == "/webx/GUI/CustomerLogin/FrmLogin.aspx")
        //{
        //    string logo = "ASL_logo.GIF";
        //    imgLogo.ImageUrl = "~/GUI/images/" + logo;
        //}
        //else
        //{
        //    string logo = "";
        //    imgLogo.ImageUrl = "~/GUI/images/" + logo;

        //}

    }
    protected void cmdcstsubmit_Click(object sender, EventArgs e)
    {
        lblcusterror.Visible = false;
        SqlCommand cmd = new SqlCommand("Select count(CUSTCD) as custcd from webx_CUSTHDR where CUSTCD='" + txtcstuname.Text + "' and CUSTPASS='" + txtcstpwd.Text + "'", cn);
        a = Convert.ToInt32(cmd.ExecuteScalar());
        if (a > 0)
        {
            Session["custcd"] = txtcstuname.Text;
            nextpage();
        }
        else
        {
            lblcusterror.Visible = true;
        }
    }
    protected void cmdgrpsubmit_Click(object sender, EventArgs e)
    {
        //lblgrperror.Visible = false;
        //SqlCommand cmd = new SqlCommand("Select count(grpcd) as grpcd from webx_GRPMST where GRPCD='" + txtgrpuname.Text + "' and GRP_Pwd='" + txtgrppwd.Text + "' and ActiveFlag='Y'", cn);
        //a = Convert.ToInt32(cmd.ExecuteScalar());
        //if (a > 0)
        //{
        //    nextpage();
        //}
        //else
        //{
        //    lblgrperror.Visible = true;
        //}
    }
    protected void nextpage()
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("function NoConfirm()");
        sb.Append("{");
        sb.Append("win = top;");
        sb.Append("win.opener = top;");
        if (Request.QueryString["win"] == null)
        {
            sb.Append("win.close ();");
        }
        sb.Append("}");
        sb.Append("window.open('FrmMain.aspx','CustomPopUp',");
        sb.Append("'top=0, left=0,  width=700, height=700 ,scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("NoConfirm();");
        sb.Append("<");
        sb.Append("/script>");
        this.RegisterStartupScript("PopupWindow", sb.ToString());
    }
}
