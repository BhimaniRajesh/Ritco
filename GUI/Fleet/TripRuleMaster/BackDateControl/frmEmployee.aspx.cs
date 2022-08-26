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

public partial class GUI_WebAdmin_popup_cust : System.Web.UI.Page
{
    DateFunction Daccess = new DateFunction();
    SqlDataReader dtr;
    public string location;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnid.Value = Request.QueryString["id"].ToString();
        if (!IsPostBack)
        {
            //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }

    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";
        string userid = txtEmpCode.Text;
        string username = txtEmpName.Text;
        sql = "select userid,name from webx_master_users where status=100 and userid like'" + userid + "%' and name Like '" + username + "%' order by name";
        dtr = Daccess.getreader(sql);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
    }
}
