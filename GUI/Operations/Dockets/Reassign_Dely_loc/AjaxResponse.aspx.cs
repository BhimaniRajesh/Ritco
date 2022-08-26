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
            if (code1.CompareTo("loctest") == 0)
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
            else if (code1.CompareTo("delloc") == 0)
            {
                string loccode = Request.QueryString["code2"].ToString();
                string sql = "";
                if (Session["client"].ToString().CompareTo("RLL") == 0)
                    sql = "SELECT loccode FROM webx_location WHERE loc_level<>'1' AND loc_level<>'2' AND activeflag='Y'";
                else
                    sql = "SELECT loccode FROM webx_location WHERE activeflag='Y'";

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
            else if (code1.CompareTo("citytest") == 0)
            {
                string cityname = Request.QueryString["code2"].ToString();
                string type = Request.QueryString["code3"].ToUpper();
                string relatedloc = Request.QueryString["code4"].ToUpper();
                string sql ="";
                if (Session["client"].ToString().ToUpper().CompareTo("RLL") == 0 || Session["client"].ToString().ToUpper().CompareTo("ASL") == 0)
                {
                    if (type.ToUpper().CompareTo("FROM") == 0 || type.ToUpper().CompareTo("FROM") == 0)
                        sql = "SELECT location FROM webx_citymaster WHERE book_loc='" + relatedloc + "' AND location='" + cityname + "'";
                    else
                        sql = "SELECT location FROM webx_citymaster WHERE location='" + cityname + "'";
                }
                else
                {
                    sql = "SELECT location FROM webx_citymaster WHERE location='" + cityname + "'";
                }
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

                string flag = Convert.ToString( cmd.ExecuteScalar());

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
                            cmd = new SqlCommand(sql,con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno;
                            string forceflag = Convert.ToString(cmd.ExecuteScalar());

                            if (forceflag.ToUpper().CompareTo("Y") == 0)
                                Response.Write("true|");
                            else
                                Response.Write("false|" + dkt_call + " Number is not in Series or Not Serialwise or Duplicate Docket.|");
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
                    Response.Write("false|" + dkt_call + " Number is not in Series or Duplicate Docket....|");
                    return;
                }
                else
                {
                    Response.Write("true|" + dkt_call + " Number is not in Series or Duplicate Docket....|");
                    return;
                }
            }
            else if (code1.CompareTo("partybillloc") == 0)
            {
                string partycode = Request.QueryString["code2"].ToString();
                if (partycode.CompareTo("") == 0)
                {
                    Response.Write("false|Pary Not Found.....");
                    return;
                }

                string sqlstr = "SELECT billgenloc FROM webx_custcontract_charge WHERE custcode='" + partycode + "'";
                cmd = new SqlCommand(sqlstr, con);
                string billedat = Convert.ToString(cmd.ExecuteScalar());

                Response.Write("true|" + billedat);
                return;
            }
            else if (code1.CompareTo("partyedit") == 0)
            {
                string partycode = Request.QueryString["code2"].ToString();
                string custloc = Request.QueryString["code3"].ToUpper();
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

            Response.Write("false|");

        } // check ENDS HERE
        else if (mode.CompareTo("data") == 0)
        {
            string dockno = Request.QueryString["code2"].ToString();
            string code1 = Request.QueryString["code1"].ToString();
            if (code1.CompareTo("dockno") == 0)
            {
                if (dockno.CompareTo("") == 0)
                {
                    Response.Write("false|" + dkt_call + " Number Not Passed for varification...|");
                    return;
                }
                string sql = "SELECT d.reassign_destcd,s.nextloc FROM webx_master_docket d,webx_trans_docket_status s";
                sql = sql + " WHERE d.dockno=s.dockno AND d.dockno='" + dockno + "'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                string destcd = "", nextloc = "";
                int cnt = 0;
                while (dr.Read())
                {
                    destcd = Convert.ToString(dr["reassign_destcd"]);
                    nextloc = Convert.ToString(dr["nextloc"]);
                    cnt++;
                }
                dr.Close();



                if (cnt == 0)
                {
                    Response.Write("false|Docket Not Found....|");
                    return;
                }
                else
                {
                    Response.Write("true|" + destcd + "|" + nextloc + "|");
                }


                // ONLY FOR RCPL




            }
        }// data ENDS HERE

    }
}
