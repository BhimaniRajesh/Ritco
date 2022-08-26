using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_BA_Payment_BOOKINGRATE_CUSRSOR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       

    }
    protected void Submit_Click(object sender, EventArgs e)
    {
        SqlConnection conn;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "exec WebxNet_BARATE_BKG";
        SqlCommand cmd = new SqlCommand(str, conn);
        cmd.ExecuteNonQuery();

        str = "select count(*) from webx_BA_calculation with(NOLOCK) where  isnull(slabrate_BKG,0)=0 and  bacode in (select vendorcode from webx_vendor_hdr where vendor_type='8' or vendor_type='08' ) and month(dockdt) ='7' and lasteditdate is null	";
        cmd = new SqlCommand(str, conn);

        int i = Convert.ToInt32(cmd.ExecuteScalar());
        totcount.Text = i.ToString();

        conn.Close();
    }
}
