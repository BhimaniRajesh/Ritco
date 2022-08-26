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
        string Chqno = Request.QueryString["Chqno"].ToString();
        string ChqDate = fn.Mydate1(Request.QueryString["ChqDate"].ToString());
        string desc = "";
        
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "select CHQ_B_R,chq_status,depoflag from webx_chq_det where chqno='" + Chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + ChqDate + "',106)";
         
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        string CHQ_B_R = "", chq_status = "", Status = "", Flag = "", Availabe_FOR_USE_YN = "U", depoflag="";
        int i = 0;
            if (dr.Read())
            {
                i = i + 1;
                CHQ_B_R = dr[0].ToString();
                chq_status = dr[1].ToString();
                depoflag = dr[2].ToString();
            }
            dr.Close();
            if (i == 1)
            {
                qry = "select Availabe_FOR_USE_YN from webx_Chq_Bounce_Reoffer_Details where chqno='" + Chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + ChqDate + "',106) and Availabe_FOR_USE_YN='U'";
                cmd = new SqlCommand(qry, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Availabe_FOR_USE_YN = dr[0].ToString();

                }
            }
            if (i == 0)
            {
                Status = "Cheque Is Not Present In System";
                Flag = "F";
            }
            else if (i == 1)
            {
                if (CHQ_B_R == "B")
                {
                    Status = "Cheque Is Already Bounced";
                    Flag = "F";
                }
                else if (depoflag == "N")
                {
                    Status = "Cheque Is Not Deposited";
                    Flag = "F";
                }
                else if (Availabe_FOR_USE_YN!="U")
                {
                    Status = "Cheque Is Reoffred But Not Used For Collection";
                    Flag = "F";
                }
                    
                else  
                {
                    Flag = "Y";
                }
            }
            Response.Write(Flag + "|" + Status);

       con.Close();
    }
 
}
