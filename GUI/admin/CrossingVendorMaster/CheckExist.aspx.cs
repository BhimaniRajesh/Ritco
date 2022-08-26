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

public partial class GUI_admin_CrossingVendorMaster_CheckExist : System.Web.UI.Page
{
    public string origin, destination, ratetype, VendorCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        origin = Request.QueryString["origin"].ToString();
        destination = Request.QueryString["destination"].ToString();
        ratetype = Request.QueryString["ratetype"].ToString();
        VendorCode = Request.QueryString["VendorCode"].ToString();
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "select VendorCode,Origin,DestCity,ratetype from webx_vendor_Crossing_Contract_Det where VendorCode='" + VendorCode + "' and Origin='" + origin + "' and DestCity='" + destination + "' and ratetype='" + ratetype + "'";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            //date = Convert.ToString(dr["Origin"]);
            //from = Convert.ToString(dr["DestCity"]);
            //to = Convert.ToString(dr["ratetype"]);
            i = 1;
            break;
        }
        dr.Close();

        Response.Clear();
        if (i == 0)
            Response.Write("true|");
        else if (i == 1)
            Response.Write("false|");
        con.Close();
    }
}

