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

public partial class GUI_WebAdmin_popup_radvendor : System.Web.UI.Page
{
    DateFunction Daccess = new DateFunction();
    SqlDataReader dtr;
    string sql, mHeadOfficeCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string loccode = Session["brcd"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string custcode = txtCustCode.Text;
        string custname = txtCustName.Text;
        if (loccode == Session["HeadOfficeCode"].ToString())
        {
            sql = "select VENDORCODE,VENDORNAME + ' : ' + VENDORCODE as VENDORNAME from webx_VENDOR_HDR where Active='Y' and VENDORCODE Like '" + txtCustCode.Text + "%' and VENDORNAME Like '" + txtCustName.Text + "%'";
        }
	    else
        {
            sql = "select a.VENDORCODE,a.VENDORNAME + ' : ' + a.VENDORCODE as VENDORNAME from webx_VENDOR_HDR a,webx_VENDOR_DET b where a.Active='Y' and a.VENDORCODE=b.VENDORCODE and b.VENDORBRCD='" + loccode + "' and a.VENDORCODE Like '" + txtCustCode.Text + "%' and a.VENDORNAME Like '" + txtCustName.Text + "%'";
        }

        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();
    }
}
