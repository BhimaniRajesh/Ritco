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

public partial class GUI_Finance_Billing_BillEdit_BringBillDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string Mode = Request.QueryString["Mode"].ToString();
        string Code = Request.QueryString["Code"].ToString();
        string desc = "";

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";

        if (Mode == "Customer")
        {
            qry = "select custcd as Code , custnm as Name from webx_custHDR WITH(NOLOCK) where custcd ='" + Code + "' ";
        }
        else if (Mode == "Location")
        {
            qry = "select loccode as Code , locname as Name from webx_location WITH(NOLOCK) where loccode ='" + Code + "' ";
        }
        else if (Mode == "ManualMR")
        {
            qry = "select MANUAL_DOCNO as Code   from webx_location WITH(NOLOCK) where MANUAL_DOCNO ='" + Code + "' ";
        }
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;
            con.Open();
            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i = 1;
                break;
            }
            dr.Close();

            if (i == 0)
            {
                Response.Write("false|");
            }
            else if (i == 1)
            {
                Response.Write("true|");
            }
            con.Close();
        
    }
 
}
