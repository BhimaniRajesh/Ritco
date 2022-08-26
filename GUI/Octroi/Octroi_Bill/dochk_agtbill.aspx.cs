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

public partial class GUI_admin_AirportMaster_dyn_combo : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string result = "";
        string dec = "";
        string octamt = "0";
        string rno = "";
        string rdt = "";

        
        string dno = Request.QueryString["dno"].ToString();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader dr;
        string sql = "select dockno from webx_trans_docket_status where octroi<>'y' and dockno='" + dno + "' ";
        SqlCommand cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        Int16 cnt = 0;
         
        string s = "";
       
        if (dr.HasRows == false)
        {
            result = "Invalid "+ Session["DocketCalledAs"].ToString() + " No.";
            s = "Invalid Docket No.";
            dr.Close();
        }
         
        else
        {
            dr.Close();
            result = "OK";
            string sql2 = "select (select sum(declval) from WebX_Master_Docket_Invoice where dockno='" + dno + "') as d,isnull(octamt,0) as octamt,isnull(recptno,'') as recptno,isnull(convert(varchar,recptdt,103),'') as recptdt  from webx_OCT_DET where dockno='" + dno + "'";
            SqlCommand cmd2 = new SqlCommand(sql2, conn);
            SqlDataReader dr2;
            dr2 = cmd2.ExecuteReader();
            dr2.Read();

            if (dr2.HasRows == false)
            {

                dec = "";
                octamt = "0";
                rno = ""; 
                rdt = "";
            }

            else
            {
                dec = dr2["d"].ToString();
 
                octamt = dr2["octamt"].ToString();

                rno = dr2["recptno"].ToString();

                rdt = dr2["recptdt"].ToString();
            }



        }
       


        Response.Write(result + "|" + dec + "|" + octamt + "|" + rno + "|" + rdt);
    }
}
