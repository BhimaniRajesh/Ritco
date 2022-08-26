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
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
  
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();
        string desc = "";

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry="";
        if (mode.CompareTo("ManualMR") == 0)
            qry = "select Count(*) from webx_MR_HDR WITH(NOLOCK) where MANUAL_DOCNO='" + code + "' and MANUAL_DOCNO<>'NA' and MANUAL_DOCNO is not  null  ";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int Counter=0;
        int i = 0;
            if(dr.Read())
            {
                Counter = Convert.ToInt16(dr[0].ToString());
            }
            dr.Close();
            con.Close();
            if (Counter > 0)
            {
                Response.Write("True");
            }
            else if (Counter == 0)
            {
                Response.Write("False");
            }

        
    }
 
}
