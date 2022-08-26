using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class Finance_Billing_Billcollection_dyn_combo : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string chqno = Request.QueryString.Get("chqno");
        string chqdate = fn.Mydate1(Request.QueryString.Get("chqdate"));
        string chqdt = Request.QueryString.Get("chqdate");
        string Party = Request.QueryString.Get("Party");
        
        //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader drchq;

        string sql = "select chqno,chqdt,chqamt,adjustamt,banknm,bankbrn,CHQ_B_R,OwnCust,ptmsptcd,depoflag=isnull(depoflag,'N'),acccode from webx_chq_det  where   chqno='" + chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdate + "',106)   ";
        SqlCommand cmd = new SqlCommand(sql, conn);
        drchq = cmd.ExecuteReader();

        string chqamt="";
        string adjustamt = "";
        string banknm = "", CHQ_B_R = "", OwnCust = "", ptmsptcd = "", depoflag = "N", Depoaccount = "";
        string bankbrn = "", flag = "";
        double pendamt=0; 
        while (drchq.Read())
        {
           //OwnCust='C' 
           chqamt = drchq.GetValue(2).ToString();
           adjustamt = drchq.GetValue(3).ToString();
           banknm = drchq.GetValue(4).ToString();
           bankbrn = drchq.GetValue(5).ToString();
           pendamt = Convert.ToDouble(chqamt) - Convert.ToDouble(adjustamt);
           CHQ_B_R = drchq.GetValue(6).ToString();
           OwnCust = drchq.GetValue(7).ToString();
           ptmsptcd = drchq.GetValue(8).ToString().ToUpper().Trim();
           depoflag = drchq.GetValue(9).ToString();
           Depoaccount = drchq.GetValue(10).ToString();
           flag = "Y";
        }
        drchq.Close();
        if (CHQ_B_R == "B")
        {
            flag = "N";
        }
        //if (OwnCust != "C")
       // {
       //     flag = "N";
       // }
        Response.Write(chqno + "~" + chqdt + "~" + chqamt + "~" + pendamt + "~" + banknm + "~" + bankbrn + "~" + flag + "~" + CHQ_B_R + "~" + OwnCust + "~" + ptmsptcd + "~" + depoflag + "~" + Depoaccount + "~");
        
    }
}
