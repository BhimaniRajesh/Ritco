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
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        mode=Request.QueryString["mode"].ToString();
        code = Request.QueryString["code"].ToString();
        fn=new MyFunctions();

        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        if (mode.CompareTo("check") == 0)
        {
            if(code.CompareTo("destcode")==0)
            {
                string destcode = Request.QueryString["destcode"].ToString();
                string sql = "select loccode from webx_location where loccode='" + destcode + "'";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                
                while (dr.Read())
                {
                    i = 1;
                }
                dr.Close();

                if (i == 1)
                {
                    Response.Write("true|" +  "|");
                }
                else
                {
                    Response.Write("false|" + "|");
                }
            }
            else if (code.CompareTo("dest") == 0) // for destination city
            {
                string destcode = Request.QueryString["destcode"].ToString();
                string destloc = Request.QueryString["destloc"].ToString();
              
                string sql = "select location,oda_yn from webx_citymaster where location='" + destloc + "'";
                SqlCommand cmd = new SqlCommand(sql,con);
                SqlDataReader dr = cmd.ExecuteReader();
                int i = 0;
                string oda = "";
                while (dr.Read())
                {
                    i = 1;
                    oda = dr["oda_yn"].ToString();
                }
                dr.Close();

                if (i == 1)
                {
                    Response.Write("true|" + oda.ToUpper().Trim() + "|");
                }
                else
                {
                    Response.Write("false|" + oda.ToUpper().Trim() + "|");
                }

            }
            else if (code.CompareTo("origin") == 0)
            {
                string origincode = Request.QueryString["origincode"].ToString();
                string originloc = Request.QueryString["originloc"].ToString();
                string sql = "SELECT location FROM webx_citymaster WHERE location='" + originloc + "'";
                SqlCommand cmd = new SqlCommand(sql,con);
                if (cmd.ExecuteScalar()!=null)
                    Response.Write("true|");
                else
                    Response.Write("false|");
            }
            else if (code.CompareTo("partycode") == 0)
            {
                string partycode = Request.QueryString["partycode"].ToString();
                string sql = "SELECT  DISTINCT custcd,custnm FROM webx_CUSTHDR  where CUSTCD='" + partycode + "'";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr=cmd.ExecuteReader();
                if (dr.Read())
                {
                    Response.Write("true|" + dr["custnm"].ToString() + "|");
                }
                else
                {
                    Response.Write("false|This Party Code Doesn't Exists|");
                }
            }
            else if (code.CompareTo("dockno") == 0)
            {
                string dockno = Request.QueryString["dockno"].ToString();
                string sql = "usp_validate_docket_entry";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.CommandType = CommandType.StoredProcedure;
                DataSet ds = new DataSet();

                cmd.Parameters.Add("@DocketNo", SqlDbType.VarChar).Value = dockno;
                cmd.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
                string val = Convert.ToString(cmd.ExecuteScalar());

                if (val.CompareTo("0") != 0)
                {
                    if (Session["client"].ToString().CompareTo("RCPL") == 0)
                    {
                        sql = "sp_forced_serial";
                        cmd = new SqlCommand(sql, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno;
                        string flag = Convert.ToString(cmd.ExecuteScalar());
                        if (flag.CompareTo("Y") == 0)
                            Response.Write("true|");
                        else
                            Response.Write("false|");

                        return;
                    }
                }


                if (val.CompareTo("0") == 0)
                    Response.Write("false|");
                else
                    Response.Write("true|");   // this is valid docket number
               
                return;
            }
        }
    }

    // Inner Function convert string to double,(incase string is NULL or blank it handles) and  keep Code clear
    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0";
        }

        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception e)
        {
            return 0.00;
        }
    }


}
