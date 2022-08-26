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
        string dec = "0", octamt = "0", recptno = "", recptdt = "";
        string dno = Request.QueryString["dno"].ToString();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader dr;
        string sql = " select top 10  isnull(octroibill,'N') as octroibill,isnull(octroimr,'N') as octroimr ,paybas,docket_mode,* from vw_docket_net where dockno='" + dno + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        Int16 cnt = 0;

        /*
         
         if docket_mode <>'F' ---- Entered docket not fincialy completed
if paybas <>'p02,p08,p09' -----plz enter TBB/nationa/BOD dockets
if octroibill=='Y' -----Octroi bill already generated 
if octroimr='Y'-----Octroi MR already generated 
         */

        string docket_mode = "";
        string paybas = "";
        string octroibill = "";
        string octroimr = "";

        while (dr.Read())
        {
            docket_mode = dr["docket_mode"].ToString();
            paybas = dr["paybas"].ToString();
            octroibill = dr["octroibill"].ToString();
            octroimr = dr["octroimr"].ToString();
        }


        string s = "";

        if (dr.HasRows == false)
        {
            s = "123";
        }
        dr.Close();

        if (s == "123")
        {
            result = "Invalid Docket";
        }



        else if (docket_mode == "" || docket_mode != "F")
        {
            result = "Entered docket not fincialy completed !!";
        }
        else if (octroibill == "Y")
        {
            result = "Octroi bill already generated ";
        }
        else if (octroimr == "Y")
        {
            result = "Octroi MR already generated ";
        }
        //else if (paybas != "P02" && paybas != "P08")
        //{
        //    if (paybas != "P09")

        //        result = "plz enter TBB/nationa/BOD dockets";
        //}
        else
        {
            result = "OK";
            string sql2 = "select sum(declval) as d from WebX_Master_Docket_Invoice where dockno='" + dno + "'";
            SqlCommand cmd2 = new SqlCommand(sql2, conn);
            SqlDataReader dr2;
            dr2 = cmd2.ExecuteReader();
             dr2.Read();
             dec = dr2["d"].ToString();
             dr2.Close();

             sql2 = "select isnull(octamt,0) as octamt,recptno,convert(varchar,recptdt,103)  as recptdt from WebX_oct_det where dockno='" + dno + "'";
             cmd2 = new SqlCommand(sql2, conn);
             dr2 = cmd2.ExecuteReader();
             if (dr2.Read())
             {
                 octamt = dr2["octamt"].ToString();
                 recptno = dr2["recptno"].ToString();
                 recptdt = dr2["recptdt"].ToString();
             }
        }

        if (result == "OK")
        {
            Response.Write(result + "|" + dec + "|" + octamt + "|" + recptno + "|" + recptdt);
        }
        else
        {
            Response.Write(result);
        }
    }
}
