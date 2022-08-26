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

      //  string sql = "select chqno,chqdt,chqamt,adjustamt,banknm,bankbrn  from webx_chq_det  where OwnCust='C' and chqno='" + chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdate + "',106)  ";
          string sql = "select chqno,chqdt,chqamt,adjustamt,banknm,bankbrn  from webx_chq_det  where OwnCust='C' and chqno='" + chqno + "' and convert(varchar,chqdt,106)=convert(datetime,'" + chqdate + "',106)  and ptmsptcd='" + Party + "'  ";
       
        SqlCommand cmd = new SqlCommand(sql, conn);
        drchq = cmd.ExecuteReader();

        string chqamt="";
        string adjustamt = "";
        string banknm = "";
        string bankbrn = "", flag = "N";
        double pendamt=0; 
        while (drchq.Read())
        {
           //chqno= drchq.GetValue(0).ToString();
           //chqdate = drchq.GetValue(1).ToString();
           chqamt = drchq.GetValue(2).ToString();
           adjustamt = drchq.GetValue(3).ToString();
           banknm = drchq.GetValue(4).ToString();
           bankbrn = drchq.GetValue(5).ToString();
           pendamt = Convert.ToDouble(chqamt) - Convert.ToDouble(adjustamt);
           flag = "Y";
        }

        drchq.Close();
        Response.Write(chqno + "~" + chqdt + "~" + chqamt + "~" + pendamt + "~" + banknm + "~" + bankbrn + "~" + flag);
        //Response.End();
    }
}
