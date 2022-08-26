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
using System.IO;

public partial class GUI_Operation_Singlescreen_docketentry_AjaxResponse : System.Web.UI.Page
{
    string mode = "", dkt_call = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        mode = Request.QueryString["mode"].ToString();
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            dkt_call = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Write("false|Session Expired. LogOn again....");
            return;
        }

        SqlCommand cmd;
        SqlDataReader dr;

        if (mode.CompareTo("check") == 0)
        {
            // CHECK MODE RETURNS true OR false USED ONLY TO CHECKING PURPOSE

            string code1 = Request.QueryString["code1"].ToString();
            if (code1.CompareTo("citytest") == 0)
            {
                string cityname = Request.QueryString["code2"].ToString();
                string sql = "";
                sql = "SELECT location FROM webx_citymaster WHERE location='" + cityname + "'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["location"].ToString().ToUpper().CompareTo(cityname.ToUpper()) == 0)
                    {
                        Response.Write("true|");
                        return;
                    }
                }
                dr.Close();
            }
            else if (code1.CompareTo("loctest") == 0)
            {
                string loccode = Request.QueryString["code2"].ToString();
                string sql = "SELECT loccode FROM webx_location WHERE activeflag='Y'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["loccode"].ToString().ToUpper().CompareTo(loccode.ToUpper()) == 0)
                    {
                        Response.Write("true|");
                        return;
                    }
                }
                dr.Close();
            } // LOCATION TEST ENDS HERE
            else if (code1.CompareTo("emptest") == 0)
            {
                string loccode = Request.QueryString["code2"].ToString();
                string sql = "SELECT useRid FROM webx_master_users WHERE status='100'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["useRid"].ToString().ToUpper().CompareTo(loccode.ToUpper()) == 0)
                    {
                        Response.Write("true|");
                        return;
                    }
                }
                dr.Close();
            } // EMP TEST ENDS HERE
            else if (code1.CompareTo("zonetest") == 0)
            {
                string loccode = Request.QueryString["code2"].ToString();
                string sql = "SELECT codeid FROM webx_master_general WHERE codedesc='" + loccode + "' AND codetype='ZONE' AND statuscode='Y'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["codeid"].ToString().ToUpper().CompareTo(loccode.ToUpper()) != 0)
                    {
                        Response.Write("true|");
                        return;
                    }
                }
                dr.Close();
            } // REGION/ZONE TEST ENDS HERE
            else if (code1.CompareTo("partytest") == 0)
            {
                string partycode = Request.QueryString["code2"].ToString();
                string type = Request.QueryString["code3"].ToString().ToUpper();
                string custloc = Request.QueryString["code4"].ToUpper();
                string sql = "";

                sql = "SELECT custcd,custnm FROM webx_custhdr WHERE cust_active='Y' AND PATINDEx ('%" + custloc + "%',custloc)>0";

                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["custcd"].ToString().ToUpper().CompareTo(partycode.ToUpper()) == 0)
                    {
                        Response.Write("true|" + dr["custnm"].ToString() + "|");
                        return;
                    }
                }
                dr.Close();
            }
           
            else if (code1.CompareTo("docknotest") == 0)
            {
                string dockno = Request.QueryString["code2"].ToString();
                if (dockno.CompareTo("") == 0)
                {
                    Response.Write("false|" + dkt_call + " Number Not Passed for varification...");
                    return;
                }
                string sql = "usp_validate_docket_entry";
                cmd = new SqlCommand(sql, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@docketno", SqlDbType.VarChar).Value = dockno;
                try
                {
                    cmd.Parameters.Add("@loccode", SqlDbType.VarChar).Value = Session["brcd"].ToString();
                }
                catch (Exception ex)
                {
                    Response.Write("false|Session Expired. LogOn again....");
                    return;
                }

                string flag = Convert.ToString(cmd.ExecuteScalar());

                if (flag.CompareTo("") == 0)
                {
                    Response.Write("false|UnDefined Error.....");
                    return;
                }


                // ONLY FOR RCPL
                if (flag.CompareTo("0") != 0)
                {
                    try
                    {
                        if (Session["client"].ToString().CompareTo("RCPL") == 0)
                        {
                            sql = "sp_forced_serial";
                            cmd = new SqlCommand(sql, con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno;
                            string forceflag = Convert.ToString(cmd.ExecuteScalar());

                            if (forceflag.ToUpper().CompareTo("Y") == 0)
                                Response.Write("true|");
                            else
                                Response.Write("false|" + dkt_call + " Number is not in Series or Not Serialwise or Duplicate Docket.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("false|DataBase InConsistant. LogOn again....");
                        return;
                    }
                }


                if (flag.CompareTo("0") == 0)
                {
                    Response.Write("false|" + dkt_call + " Number is not in Series or Duplicate Docket....");
                    return;
                }
                else
                {
                    Response.Write("true|" + dkt_call + " Number is not in Series or Duplicate Docket....");
                    return;
                }
            }
           

            Response.Write("false|");

        } // check ENDS HERE
        else if (mode.CompareTo("data") == 0)
        {
        }// data ENDS HERE

    }
}
