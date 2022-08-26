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
            lbl_Like_Header_Text.Text = Request.QueryString["Header"].ToString() + " Like :";
            pnlLst.Width = Convert.ToInt32(Request.QueryString["width"].ToString()) - 25;
            //btnSubmit.Attributes.Add("OnClick", "javascript:selectItems();");
            BindData();
        }
    }
    public void BindData()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        SqlCommand cmd = new SqlCommand("USP_MULTISELCTION_POPUP", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@TABLE_NAME", SqlDbType.VarChar, 100).Value = Convert.ToString(Request.QueryString["TableName"]);
        cmd.Parameters.Add("@VALIE_FIELD", SqlDbType.VarChar, 100).Value = Convert.ToString(Request.QueryString["ValueField"]);
        cmd.Parameters.Add("@TEXT_FIELD", SqlDbType.VarChar, 100).Value = Convert.ToString(Request.QueryString["TextField"]);
        cmd.Parameters.Add("@ACTIVE_FLAG", SqlDbType.VarChar, 100).Value = Convert.ToString(Request.QueryString["ActiveFlagField"]);
        cmd.Parameters.Add("@LIKE_CHARACTER", SqlDbType.VarChar, 4000).Value = tb_TextBoxs.Text;
        cmd.Parameters.Add("@CodeType", SqlDbType.VarChar, 4000).Value = Convert.ToString(Request.QueryString["CodeType"]);

        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        chkLst.DataSource = ds;
        chkLst.DataValueField = Convert.ToString(Request.QueryString["ValueField"]);
        chkLst.DataTextField = Convert.ToString(Request.QueryString["TextField"]);
        chkLst.DataBind();
    }
    protected void textBox_TextChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
