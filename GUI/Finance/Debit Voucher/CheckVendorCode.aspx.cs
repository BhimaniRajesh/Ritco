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

public partial class GUI_Finance_Accounts_Debit_Voucher_CheckVendorCode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "";
        if (mode.CompareTo("Paid") == 0)
            qry = "select vendorCode as code , vendorname as name from webx_VENDOR_HDR WITH(NOLOCK) where Active='Y' union select custcd as code,custnm as name from webx_custhdr WITH(NOLOCK)";
        
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            if (dr[0].ToString().CompareTo(code) == 0)
            {
                i = 1;
                break;
            }

        }
        dr.Close();

        if (i == 0)
            Response.Write("false|");
        else if (i == 1)
        //Response.Write("true|");
        {
            string strSql = "select vendorname as docname from webx_VENDOR_HDR where Active='Y' and vendorCode = '" + code + "' union select custnm as docname from webx_custhdr where  custcd = '" + code + "'";
            SqlCommand cmd1 = new SqlCommand(strSql, con);
            string res =Convert.ToString(cmd1.ExecuteScalar());
            Response.Write(res+"|");
        }

        con.Close();
    }
}
