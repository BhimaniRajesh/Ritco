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

public partial class GUI_Octroi_ViewnPrint_VendorPaymentVoucher_xls : System.Web.UI.Page
{
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    public string billno = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string voucherno = Request.QueryString["voucherno"].ToString();
        Ptrinyn = Request.QueryString["printyn"].ToString();

        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";

        if (Ptrinyn == "1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string sql = "SELECT convert(varchar,transdate,106) as transdate,convert(varchar,chqdate,106) as chqdate,* FROM webx_vouchertrans_arch WHERE voucherno='" + voucherno + "'";
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblvoucherno.Text = dr["voucherno"].ToString();
            lblvoucherdate.Text = dr["transdate"].ToString();
            lblvendor.Text = dr["pbov_code"].ToString() + " : " + dr["pbov_name"].ToString();
            lblvendorservtaxno.Text = dr["servicetaxno"].ToString();
            lblvendorpanno.Text = dr["panno"].ToString();
            lblnetpayable.Text = dr["netamt"].ToString();

            lbltransmode.Text = dr["transmode"].ToString();
            lblissuedfromacc.Text = dr["oppacccode"].ToString();
            lblchequeno.Text = dr["chqno"].ToString();
            lblchequedate.Text = dr["chqdate"].ToString();
            lblchequeamt.Text = dr["chqamt"].ToString();
            lblpayamt.Text = dr["netamt"].ToString();
            lbltotal.Text = dr["netamt"].ToString();
            lblnetpayable2.Text = dr["netamt"].ToString();
        }

        dr.Close();


        sql = "SELECT convert(varchar,vendorbilldt,106) as vendorbilldt,convert(varchar,duedt,106) as duedt,* FROM webx_vendorbill_hdr WHERE voucherno='" + voucherno + "'";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblbillno.Text = dr["billno"].ToString();
            billno = lblbillno.Text;
            lblvendorbillno.Text = dr["vendorbillno"].ToString();
            lblvendorbilldate.Text = dr["vendorbilldt"].ToString();
            lblduedate.Text = dr["duedt"].ToString();
            
        }


        con.Close();

    }
}
