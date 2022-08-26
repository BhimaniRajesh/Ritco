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
        string chqno = "";
        string chqdt = "";    
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["Code"].ToString();
        string desc = "";

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";

        if (mode.CompareTo("LocCode") == 0)
            qry = "SELECT loccode,locname FROM webx_location where ActiveFlag='Y' And loccode='" + code + "' ";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
            while (dr.Read())
            {
              if(dr[0].ToString().CompareTo(code)==0)
              {
                  if (mode.CompareTo("AccCode") == 0)
                  {
                      desc = dr[1].ToString();
                      i = 1;
                      break;
                  }
                  else
                  {
                      i = 1;
                      desc = dr[1].ToString();
                      break;
                  }
              }
            }
            dr.Close();

       if(i==0)
           Response.Write("false|");
       else if (i == 1)
           Response.Write("true|" + desc + "|");

        con.Close();
    }
 
}
