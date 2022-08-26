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

public partial class GUI_admin_Extra_LocationTest : System.Web.UI.Page
{
    SqlConnection con;
    string mode = "", code = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        mode=Request.QueryString["mode"].ToString();
        code = Request.QueryString["code"].ToString();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        if (mode.CompareTo("check") == 0)
        {
            if (code.CompareTo("loccode") == 0)
            {
                string loccode = Request.QueryString["loccode"].ToString();

                loccode.ToUpper();
                string sql = "select LOCCODE from webx_location where loccode='" + loccode + "'";
                SqlCommand cmd = new SqlCommand(sql,con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                string oda = "";
                while (dr.Read())
                {
                    i = 1;
                }
                dr.Close();

                if (i == 1)
                    Response.Write("true|");
                else
                    Response.Write("false|");
               
            }
            else if (code.CompareTo("zonecode") == 0)
            {
                string zonecode = Request.QueryString["zonecode"].ToString();

                zonecode.ToUpper();
                string sql = "SELECT codedesc FROM webx_master_general WHERE UPPER(codetype)='ZONE' AND codedesc='" + zonecode + "'";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                string oda = "";
                while (dr.Read())
                {
                    i = 1;
                }
                dr.Close();

                if (i == 1)
                    Response.Write("true|");
                else
                    Response.Write("false|");

            }
            else if (code.CompareTo("citycode") == 0)
            {
                string citycode = Request.QueryString["citycode"].ToString();

                citycode.ToUpper();
                string sql = "SELECT location FROM webx_citymaster WHERE location='" + citycode + "'";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                string oda = "";
                while (dr.Read())
                {
                    i = 1;
                }
                dr.Close();

                if (i == 1)
                    Response.Write("true|");
                else
                    Response.Write("false|");

            }
            
        }
    }
}
