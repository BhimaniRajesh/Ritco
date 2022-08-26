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
                sql = "SELECT loccode FROM webx_location WHERE loc_level<>'1' AND loc_level<>'2' AND activeflag='Y'";
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
                string sql = "";
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
                    Response.Write("false|" + dkt_call + " Number Not Passed for varification...|");
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
                    Response.Write("false|Session Expired. LogOn again....|");
                    return;
                }

                string flag = Convert.ToString(cmd.ExecuteScalar());

                if (flag.CompareTo("") == 0)
                {
                    Response.Write("false|UnDefined Error.....|");
                    return;
                }

                if (flag.CompareTo("0") != 0)
                {
                    try
                    {
                        sql = "SELECT defaultvalue FROM webx_rules_docket WHERE code='DCR_SERIAL'";
                        cmd = new SqlCommand(sql, con);
                        string strserial = "N";
                        strserial = Convert.ToString(cmd.ExecuteScalar());

                        if (strserial.CompareTo("Y") == 0)
                        {
                            sql = "sp_forced_serial";
                            cmd = new SqlCommand(sql, con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno;
                            string forceflag = Convert.ToString(cmd.ExecuteScalar());

                            if (forceflag.ToUpper().CompareTo("Y") == 0)
                                Response.Write("true|");
                            else
                                Response.Write("false|" + dkt_call + " Number is not in Series or Not Serialwise or Duplicate " + dkt_call + ".|");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("false|DataBase InConsistant. LogOn again....|");
                        return;
                    }
                } // FORCED SERIAL END

                if (flag.CompareTo("0") != 0)
                {
                    sql = "SELECT defaultvalue=ISNULL(defaultvalue,'N') FROM webx_rules_docket WHERE code='FLAG_VOID'";
                    cmd = new SqlCommand(sql, con);
                    string strflagvoid = "N";
                    strflagvoid = Convert.ToString(cmd.ExecuteScalar());

                    if (strflagvoid.CompareTo("Y") == 0)
                    {
                        sql = "SELECT docno FROM webx_document_void WHERE doc_type='DKT' ";
                        sql = sql + "AND docno='" + dockno + "' AND activeflag='Y'";
                        cmd = new SqlCommand(sql, con);
                        string strvoiddockno = "";
                        strvoiddockno = Convert.ToString(cmd.ExecuteScalar());

                        if (strvoiddockno.CompareTo("") != 0)
                        {
                            Response.Write("false|" + dkt_call + " Number is in Void List. Can't Enter " + dkt_call + "....|");
                            return;
                        }
                    }
                } // VOID CHECK END


                if (flag.CompareTo("0") == 0)
                {
                    Response.Write("false|" + dkt_call + " Number is not in Series or Duplicate " + dkt_call + "....|");
                    return;
                }
                else
                {
                    Response.Write("true|" + dkt_call + " Number is not in Series or Duplicate " + dkt_call + "....|");
                    return;
                }
            }
            else if (code1.CompareTo("partybillloc") == 0)
            {
                string partycode = Request.QueryString["code2"].ToString();
                if (partycode.CompareTo("") == 0)
                {
                    Response.Write("false|Pary Not Found.....|");
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
                        dr.Close();
                        return;
                    }
                }
                dr.Close();
            }
            else if (code1.CompareTo("sourcedocknotest") == 0)
            {
                string sourcedockno = Request.QueryString["code2"].ToString();
                string dockdate = Request.QueryString["code3"].ToUpper();
                string sql = "";
                sql = "SELECT dockno FROM webx_master_docket WHERE CONVERT(VARCHAR,dockdt,103)='" + dockdate + "'";
                sql = sql + " AND service_class='2' AND paybas='P02' AND dockno='" + sourcedockno + "'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Response.Write("true|");
                    dr.Close();
                    return;
                }
                dr.Close();

                Response.Write("false|" + sourcedockno + " " + dkt_call + " is not Valid Source " + dkt_call  + "|");
                return;
            }
            Response.Write("false||");
        } // check ENDS HERE
        else if (mode.CompareTo("data") == 0)
        {
        }// data ENDS HERE

    }
}
