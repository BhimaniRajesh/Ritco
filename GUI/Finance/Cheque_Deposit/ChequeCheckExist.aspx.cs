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

        string chqno = Request.QueryString["chqno"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "SELECT top 1 DepoFlag,convert(varchar,chqdt,103) chqdt FROM WEBX_CHQ_DET WHERE DepoFlag='N' and CHQNO = '" + chqno + "' and brcd = '" + Session["brcd"].ToString() + "'";
        
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
       
        con.Open();
        dr = cmd.ExecuteReader();

        string DepoFlag = "Y",chqdt="",Resstr="";
        
        int i = 0;
        while (dr.Read())
        {  
           if (dr["DepoFlag"].ToString() == "N")
           {
               DepoFlag = dr["DepoFlag"].ToString();
               chqdt = dr["chqdt"].ToString();
               i = 1;
               break;
           }
           else
           {
               DepoFlag = "Y";
           }
        }
        con.Close();

        if(i==0)
            Resstr = DepoFlag + "," + chqdt;
        else if(i==1)
            Resstr = DepoFlag + "," + chqdt;

        Response.Write(Resstr);
    }
}
