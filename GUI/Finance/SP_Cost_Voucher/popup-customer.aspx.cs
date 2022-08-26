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

public partial class GUI_Finance_Debit_Voucher_popup_customer : System.Web.UI.Page
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
        string custcode = txtCustCode.Text, custcode_cls = "";
        string custname = txtCustName.Text, custname_cls = "";
        
        if (custcode != "")
        {
            custcode_cls = " and custcd like'" + custcode + "%' ";
        }
        if (custname != "")
        {
            custname_cls = " and custnm Like '" + custname + "%' ";
        }
        string sql = "select custcd, custnm from webx_custhdr where 1=1 " + custcode_cls + custname_cls + "  order by custnm";
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();
    }

}
