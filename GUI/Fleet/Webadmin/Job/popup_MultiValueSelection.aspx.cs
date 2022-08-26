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

public partial class popup_MultiValueSelection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        if(!IsPostBack)
        {
            chk_Select_All.Attributes.Add("OnClick", "javascript:SelectAll(" + chk_Select_All.ClientID.ToString() + "," + chkLst.ClientID.ToString() + ");");
            lbl_Like_Header_Text.Text = "Select Users Like :";
            //pnlLst.Width = Convert.ToInt32(Request.QueryString["width"].ToString()) - 25;
            //btnSubmit.Attributes.Add("OnClick", "javascript:selectItems();");
            BindData();
        }
    }
    public void BindData()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        SqlCommand cmd = new SqlCommand("select UserId from WebX_Master_Users where Status='100' order by UserId", con);
        cmd.CommandType = CommandType.Text;

        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        chkLst.DataSource = ds;
        chkLst.DataValueField = "UserId";
        chkLst.DataTextField = "UserId";
        chkLst.DataBind();
    }
    protected void textBox_TextChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
