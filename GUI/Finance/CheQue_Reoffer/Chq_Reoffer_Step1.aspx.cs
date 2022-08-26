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
    public static string Financial_Year = "", fin_year = "", opertitle = "MANUAL DEBIT VOUCHER", Defaultdate="";
    public string cnt = "0";
    public static int Total_Count = 0;
    string Chqdate = "", Chqno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
     //   SHR();
        con.Close();

        Button1.Attributes.Add("onclick", "javascript:return Chq_Submit()");

        TxtChqNo.Attributes.Add("onblur", "javascript:Chq_valid_YN()");
        TxtChqdt.Attributes.Add("onblur", "javascript:Chq_valid_YN()");
        //btnSubmit.Attributes.Add("onclick", "javascript:return Chq_Bounce_Validate()");

        TxtReofferDate.CssClass = "blackfnt";
        TxtChqNo.CssClass = "blackfnt";
        TxtChqdt.CssClass = "blackfnt";
        

    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
         string  Financial_Year = "", fin_year = "",TableName="";
         Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
         fin_year = Session["FinYear"].ToString();
         double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
         fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
         TableName = "Webx_acctrans_" + fin_year;
         SqlTransaction trans;
         trans = con.BeginTransaction();
         string Sql_insert = "";
         string Reofferdate = fn.Mydate1(System.DateTime.Now.ToString("dd/MM/yyyy"));
         Chqdate = fn.Mydate1(TxtChqdt.Text.ToString());
         Chqno = TxtChqNo.Text.ToString();
         try
         {

             Sql_insert = "Exec USP_Chq_Reoffer_Updation 1,'" + Chqno + "','" + Chqdate + "','" + Reofferdate + "','" + Session["empcd"].ToString() + "','" + Session["finyear"].ToString() + "'";
             SqlCommand cmd = new SqlCommand(Sql_insert, con, trans);
             cmd.ExecuteNonQuery();

            trans.Commit();
            con.Close();
            Response.Redirect("./Reoffer_Done.aspx?Chqno=" + Chqno + "&ChqDate=" + Chqdate, false);

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

    }
}
