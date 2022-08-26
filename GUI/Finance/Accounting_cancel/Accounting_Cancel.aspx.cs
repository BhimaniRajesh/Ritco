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

public partial class GUI_Finance_Accounts_Debit_Voucher_DebitVoucher : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
     protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        
        if (!IsPostBack)
        {
             
        }
        

    }
 

   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
         
        SqlTransaction trans;
        trans = con.BeginTransaction();
        try
        {

            string sql = "Update webx_acctrans_08_09 set voucher_cancel='Y',Comment='Accounting Cancel From " + Session["brcd"].ToString() + " by   " + Session["empcd"].ToString() + " ',lasttransdate=getdate()  where Convert(varchar,transdate,106) < convert(datetime,'01 July 08',106) And voucher_cancel='N' ";
            SqlCommand cmd = new SqlCommand(sql, con, trans);
            cmd.ExecuteNonQuery();
            msgn.Text = "Cancelled Successfully";
            trans.Commit();  
            con.Close();
             
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }
       /// lblMsg.Text = "Update Successfully";
    }
}
