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

public partial class GUI_Finance_Billing_BillEdit_BringDocDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (mode.CompareTo("date") == 0)
        {
            string voucherno = Request.QueryString["code"].ToString();
            string yearsuffix = "";
            DateTime dt = new DateTime();
            dt = System.DateTime.Now;
            if (dt.Month < 4)
            {
                yearsuffix = Convert.ToString((dt.Year - 1)).Substring(2,2) + "_" + Convert.ToString((dt.Year)).Substring(2,2);
            }
            else 
            {
                yearsuffix = Convert.ToString((dt.Year)).Substring(2, 2) + "_" + Convert.ToString((dt.Year + 1)).Substring(2, 2);
            }

            string qry = "SELECT convert(varchar,transdate,103) as transdate FROM webx_acctrans_" + yearsuffix + " WHERE voucherno='" + voucherno + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr ;
            int i = 0;
            dr = cmd.ExecuteReader();
            while(dr.Read())
            {
                Response.Write("true|" + dr["transdate"].ToString() + "|");
                i++;
            }

            if (i == 0)
                Response.Write("false|");
        }
        else if (mode.CompareTo("bill") == 0)
        {
           
        }
        
        con.Close();
    }
}
