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
    string mode = "", dkt_call = "", thc_call = "";
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        mode = Request.QueryString["mode"].ToString();
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            dkt_call = Session["DocketCalledAs"].ToString();
            thc_call = Session["THCcalledas"].ToString();
        }
        catch (Exception ex)
        {
            Response.Write("false|Session Expired. LogOn again....");
            return;
        }

        SqlCommand cmd;
        SqlDataReader dr;
        string dockno = "";
        if (mode.CompareTo("check") == 0)
        {
            // CHECK MODE RETURNS true OR false USED ONLY TO CHECKING PURPOSE

            string code1 = Request.QueryString["code1"].ToString();
            if (code1.CompareTo("freshdockno") == 0)
            {
                dockno = Request.QueryString["code2"].ToString();
                string sql = "SELECT ls,mf,thc,prs,drs FROM webx_trans_docket_status WHERE dockno='" + dockno + "'";
                cmd = new SqlCommand(sql, con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (Convert.ToString(dr["thc"]).CompareTo("") != 0)
                    {
                        Response.Write("false|Can't Cancell " + dkt_call + ". " + thc_call + " " + Convert.ToString(dr["thc"] + " is Generated for " + dockno) + "|" );
                        return;
                    }

                    if (Convert.ToString(dr["mf"]).CompareTo("") != 0)
                    {
                        Response.Write("false|Can't Cancell " + dkt_call + ". Manifest " + Convert.ToString(dr["mf"] + " is Generated for " + dockno)+ "|");
                        return;
                    }

                    if (Convert.ToString(dr["ls"]).CompareTo("") != 0)
                    {
                        Response.Write("false|Can't Cancell " + dkt_call + ". Loading Sheet " + Convert.ToString(dr["ls"] + " is Generated for " + dockno)+ "|");
                        return;
                    }

                    if (Convert.ToString(dr["mf"]).CompareTo("") != 0)
                    {
                        Response.Write("false|Can't Cancell " + dkt_call + ".PRS " + Convert.ToString(dr["prs"] + " is Generated for " + dockno)+ "|");
                        return;
                    }

                    if (Convert.ToString(dr["ls"]).CompareTo("") != 0)
                    {
                        Response.Write("false|Can't Cancell " + dkt_call + ". DRS" + Convert.ToString(dr["drs"] + " is Generated for " + dockno)+ "|");
                        return;
                    }

                    Response.Write("true|");
                }
                dr.Close();
            } // FRESH DOCKNO TEST ENDS HERE
            else if (code1.CompareTo("cancelleddockno") == 0)
            {
                dockno = Request.QueryString["code2"].ToString();
                string sql = "SELECT ISNULL(cancelled,'N') FROM webx_trans_docket_status WHERE dockno='" + dockno + "'";
                cmd = new SqlCommand(sql, con);
                string flag = Convert.ToString(cmd.ExecuteScalar());

                if (flag.CompareTo("Y") == 0)
                {
                    Response.Write("true|");
                    return;
                }
                else
                {
                    Response.Write("false|Docket doesn't Exists or Docket is not Cancelled");
                    return;
                }
            }

            Response.Write("false|" + Session["docketcalledas"].ToString() + " No " + dockno + " doesn't Exists");

        } // check ENDS HERE
        else if (mode.CompareTo("data") == 0)
        {
        }// data ENDS HERE

    }
}
