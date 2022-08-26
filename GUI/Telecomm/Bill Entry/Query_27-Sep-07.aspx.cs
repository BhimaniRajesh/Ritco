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

public partial class Bill_Entry_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!(IsPostBack))
        {
            Vendor();
            cboVendor.Focus();
        }
    }

    private void Vendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter("select vh.Vendor_Type,vh.VENDORNAME from webx_VENDOR_HDR vh,webx_Vendor_Type vt where vt.Type_Code=vh.Vendor_Type and vt.Type_Code=vh.vendcat and vt.Type_Name ='Service Provider-Communication'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cboVendor.DataSource = ds;
        cboVendor.DataTextField = "VENDORNAME";
        cboVendor.DataValueField = "VENDORNAME";
        cboVendor.DataBind();
        cboVendor.Items.Insert(0, "--Select--");
        conn.Close();
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string Vendor = cboVendor.SelectedItem.Text;
        Response.Redirect("~/GUI/Telecomm/Bill Entry/CommunicationExpenseBillEntry.aspx?Vendor=" + Vendor);
    }
}
