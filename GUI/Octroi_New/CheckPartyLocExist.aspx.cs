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

public partial class GUI_Octroi_New_CheckPartyLocExist : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "";

        if (mode.CompareTo("Party") == 0)
            qry = "SELECT distinct custcd,custnm,CUSTADDRESS from webx_CUSTHDR where  custcd='" + code + "'"; //custloc = '" + Session["brcd"].ToString() + "' and
        else
            qry = "SELECT distinct loccode,locname from webx_location WHERE loccode like '" + code + "%'";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();

        string custnm = "", Sublocation = "", collLocation = "", Lbl_Credit_Limit = "", Lbl_Credit_days = "";
        string custadd = "-";
        string Outstanding_amt = "0.00";
        string locname = "", Flag = "false";
        int i = 0;

        while (dr.Read())
        {
            Flag = "true";
        }
        dr.Close();
            if (Flag == "true")
            {
                qry = "exec Usp_Cust_Billdetails  '" + code.ToString() + "'";
                cmd = new SqlCommand(qry, con);
                dr = cmd.ExecuteReader();
                //string Sublocation = "", collLocation = "";
                if (dr.Read())
                {
                    Sublocation = dr["billsub_loccode"].ToString();
                    collLocation = dr["billcol_loccode"].ToString();
                     Sublocation = fn.GetLocation(Sublocation) + '~' + Sublocation;
                     collLocation = fn.GetLocation(collLocation) + '~' + collLocation;
                     if (Sublocation == "")
                     {
                         Sublocation = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
                     }
                     if (collLocation == "")
                     {
                         collLocation = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
                     }

                    custadd = dr["custaddress"].ToString();
                    Lbl_Credit_Limit = dr["credit_limit"].ToString();
                    Lbl_Credit_days = dr["credit_day"].ToString();
                }
                dr.Close();

                qry = "exec WebxNet_OutStd_Cust_billLoc '" + Session["brcd"].ToString() + "', '" + code.ToString() + "'";
                cmd = new SqlCommand(qry, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Outstanding_amt = dr.GetValue(3).ToString();
                }
            }
        con.Close();
        Response.Write(Flag + "|" + custadd + "|" + Lbl_Credit_days + "|" + Lbl_Credit_Limit + "|" + Outstanding_amt + "|" + Sublocation + "|" + collLocation + "|");

        
    }
}
