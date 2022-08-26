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
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }

    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string custcode = txtCustCode.Text;
        string custname = txtCustName.Text;
        string sql = "SELECT  distinct CUSTCD,CUSTNM  FROM webx_CUSTHDR  where CUSTCD is not null and custcd like '" + custcode.Trim() +"%' and custnm like '" + custname.Trim() +"%' order by CUSTNM";
        conn.Open();
        SqlCommand cmd =new SqlCommand(sql,conn);
        dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();
    }
}
