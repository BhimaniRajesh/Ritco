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

public partial class GUI_Finance_Billing_BillEdit_BringDocDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (mode.CompareTo("doc") == 0)
        {
            string docno = Request.QueryString["docno"].ToString(); 
            string qry = "SELECT billed,party_code,fincmplbr,paybas,docket_mode FROM vw_docket_net WHERE dockno='" + docno + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;

            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i++;
                if (dr["paybas"].ToString().CompareTo("P02") == 0 || dr["paybas"].ToString().CompareTo("P08") == 0 || dr["paybas"].ToString().CompareTo("P09") == 0)
                {

                    if (dr["billed"].ToString().CompareTo("Y") == 0)
                    {
                        Response.Write("false|" + "AlReady Billed Docket....|");
                        return;
                    }
                    else
                    {
                        if (dr["docket_mode"].ToString().CompareTo("F") != 0)
                        {
                            Response.Write("false|" + "Please Enter Financially Complete Docket|");
                            return;
                        }
                        else
                        {
                            Response.Write("true|" + dr["party_code"].ToString() + "|" + dr["fincmplbr"].ToString() + "|");
                            return;
                        }
                    }
                }
                else
                {
                    Response.Write("false|Plz enter TBB/BOD/National Docket|");
                    return;
                }

            }

            if (i == 0)
                Response.Write("false|Invalid Docket|");
        }
        else if (mode.CompareTo("bill") == 0)
        {
            string billno=Request.QueryString["billno"].ToString();
            string qry = "SELECT billsubbrcd,billcolbrcd,billstatus,paybas,bcldt FROM webx_billmst WHERE Paybas in('1','2','3','6','7','11') and billno='" + billno + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr;

            dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                i++;
                /*if (dr["bcldt"].ToString().CompareTo("") != 0)
                {
                    Response.Write("false|Bill Already Collected" + "|");
                }*/
                if (dr["billstatus"].ToString().ToUpper().CompareTo("BILL GENERATED") == 0)
                {
                    Response.Write("true|" + dr["billsubbrcd"].ToString() + "|" + dr["billcolbrcd"].ToString() + "|Bill Generated|");
                }
                else if (dr["billstatus"].ToString().ToUpper().CompareTo("BILL SUBMITTED") == 0)
                {
                    Response.Write("true|" + dr["billsubbrcd"].ToString() + "|" + dr["billcolbrcd"].ToString() + "|Bill Submitted|");
                }
                else 
                {
                    Response.Write("false|Bill Status is not Valid" + "|");
                }
            }
            if (i == 0)
                Response.Write("false|Invalid Bill Number|");
        }
        else if (mode.CompareTo("paybasedocketno") == 0)
        {
            string dockno = Request.QueryString["dockno"].ToString();
            string qry = "SELECT billed FROM vw_docket_net WHERE dockno='" + dockno + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr = cmd.ExecuteReader();

            int i = 0;
            while (dr.Read())
            {
                i++;
                if (Convert.ToString(dr["billed"]).ToUpper().CompareTo("Y") == 0)
                { 
                
                }
             
            }
            if (i == 0)
                Response.Write("false|Invalid Docket Number|");
        }
        else if (mode.CompareTo("mrcolbranch") == 0)
        {
            string mrsno = Request.QueryString["mrsno"].ToString();
            string qry = "SELECT mrcollbrcd=ltrim(rtrim(mrcollbrcd)),mrs_closed=ltrim(rtrim(mrs_closed)),finclosedt FROM webx_mr_hdr WHERE mrsno='" + mrsno + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr = cmd.ExecuteReader();

            int i = 0;
            while (dr.Read())
            {
                i++;
                if (Convert.ToString(dr["mrs_closed"]).Trim().CompareTo("N") == 0 && dr["finclosedt"] is DBNull)
                {
                    Response.Write("true|" + Convert.ToString(dr["mrcollbrcd"]) + "|");
                    return;
                }
                else
                {
                    Response.Write("false|MR is Closed Can't Edit...|");
                    return;
                }

                

            }
            if (i == 0)
                Response.Write("false|Invalid MR Number|");
        }
        else if (mode.CompareTo("loccode") == 0)
        {
            string loccode = Request.QueryString["loccode"].ToString();
            string qry = "SELECT loccode FROM webx_location WHERE loccode='" + loccode + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr = cmd.ExecuteReader();

            int i = 0;
            while (dr.Read())
            {
                i++;

                
            }
            if (i == 0)
                Response.Write("false|Invalid Location Code...Please Enter Valid Location Code.|");
            else
                Response.Write("true|");
        }
        else if (mode.CompareTo("Misc_doc") == 0)
        {
            string docno = Request.QueryString["docno"].ToString();
            string qry = "SELECT * FROM vw_docket_net WHERE DOckno='" + docno + "'";
            SqlCommand cmd = new SqlCommand(qry, con);
            SqlDataReader dr = cmd.ExecuteReader();

            int i = 0;
            while (dr.Read())
            {
                i++;

            }
            if (i == 0)
                Response.Write("false|Invalid DOcket NUmber|");
            else
                Response.Write("true|");
        }

        con.Close();
    }
}
