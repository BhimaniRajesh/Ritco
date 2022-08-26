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

public partial class GUI_Operations_Crossing_RateCalculation : System.Web.UI.Page
{
    public string Origin, ToCity, RateBase, VendorRate, VendorCode, DDCharge;
    double Rate = 0.0, Weight = 0.0, DoorDeliveryCharge = 0.0, CrossingCharge = 0.0;
    double arrivedPkgs = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        VendorCode = Request.QueryString["Vendor"].ToString();
        Origin = Request.QueryString["Origin"].ToString();
        ToCity = Request.QueryString["ToCity"].ToString();
        RateBase = Request.QueryString["RateBase"].ToString();
        VendorRate = Request.QueryString["VendorRate"].ToString();
        DDCharge = Request.QueryString["DDCharge"].ToString();
        arrivedPkgs = Convert.ToDouble(Request.QueryString["arrivedPkgs"]);
        Weight = Convert.ToDouble(Request.QueryString["Weight"]);

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "select VendorCode,Origin,DestCity,ratetype,rate,doordeliveryCharge from webx_vendor_Crossing_Contract_Det where VendorCode='" + VendorCode + "' and Origin='" + Origin + "' and DestCity='" + ToCity + "' and ratetype='" + RateBase + "'";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            RateBase = Convert.ToString(dr["ratetype"]);
            Rate = Convert.ToDouble(dr["rate"]);
            DoorDeliveryCharge = Convert.ToDouble(dr["doordeliveryCharge"]);
            if (RateBase == "K")
            {
                CrossingCharge = (Weight * Rate);
            }
            else if (RateBase == "P")
            {
                CrossingCharge = (arrivedPkgs * Rate);
            }
            i = 1;
            break;
        }
        dr.Close();

        Response.Clear();
        if (i == 1)
            Response.Write("true|" + CrossingCharge + "|" + DoorDeliveryCharge + "|" + Rate + "|");
        else if (i == 0)
            Response.Write("false|");
        con.Close();
    }
}
