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
public partial class GUI_CustomerLogin_FrmLogin : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection();
    Int32 a;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblcusterror.Visible = false;
        //lblgrperror.Visible = false;
        a = 0;
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

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
        sb.Append("'top=0, left=0, fullscreen=yes, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("NoConfirm();");
        sb.Append("<");
        sb.Append("/script>");
        this.RegisterStartupScript("PopupWindow", sb.ToString());
    }
}
