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

public partial class GUI_Finance_Vendor_BA_payment_THCAdvanceCancellation_CheckExist : System.Web.UI.Page
{
    public string advvoucherno, balvoucherno, VendorBEno, vendorbillno;
    public string date, from, to, manualno;
    int i = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        advvoucherno = Request.QueryString["voucherno"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "select balvoucherno,VendorBEno,vendorbillno from webx_thc_summary where advvoucherno='" + advvoucherno + "'";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            balvoucherno = Convert.ToString(dr["balvoucherno"]);
            VendorBEno = Convert.ToString(dr["VendorBEno"]);
            vendorbillno = Convert.ToString(dr["vendorbillno"]);
            if ((balvoucherno == null || balvoucherno == "") && (VendorBEno == null || VendorBEno == "") && (vendorbillno == null || vendorbillno == ""))
                //if ((balvoucherno == null) && (VendorBEno == null) && (vendorbillno == null))
                {
                    i = 1;
                    break;
                }

        }
        dr.Close();

        Response.Clear();
        if (i == 0)
            Response.Write("false");
        else if (i == 1)
            Response.Write("true");
        con.Close();
    }
}
