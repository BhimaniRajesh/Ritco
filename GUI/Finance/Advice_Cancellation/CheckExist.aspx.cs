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
  
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
        if(mode.CompareTo("loc")==0)
            qry = "SELECT distinct loccode,locname from webx_location where loccode = '" + code + "'";
        
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
       

        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
            while (dr.Read())
            {
              
                  i = 1; break;
              
            }

       if(i==0)
           Response.Write("false|");
       else if(i==1)
           Response.Write("true|");

        con.Close();
    }
 
}
