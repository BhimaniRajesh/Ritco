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
            //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }

    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "";
        string custcode = txtCustCode.Text;
        string custname = txtCustName.Text;
        string HO = Session["HeadOfficeCode"].ToString().Trim();
        string brcd = Session["brcd"].ToString().Trim();
        //if (HO == brcd)
        //{
            sql = "select LocCode, LocName from webx_location where ActiveFlag='Y' and LocCode like'%" + custcode + "%' and LocName Like '%" + custname + "%'order by Locname";
        //}
        //else
        //{
        //    sql = "select LocCode, LocName from webx_location where ActiveFlag='Y' and LocCode like'%" + custcode + "%' and LocName Like '%" + custname + "%' and LocCode = '" + brcd + "'order by Locname";
        //}
        //conn.Open();
        //SqlCommand cmd =new SqlCommand(sql,conn);
        //dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        dtr = Daccess.getreader(sql);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        //conn.Close();
    }
}
