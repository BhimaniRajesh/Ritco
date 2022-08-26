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
public partial class GUI_Operations_StockUpdate_CheckDKT : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string DOCKET = Request.QueryString["DOCKET"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "";
        qry = "select reason=(case when THC_NEXT_LOC='" + Session["brcd"].ToString().Trim() + "' then 'This Docket Yet to Arrived At '+THC_NEXT_LOC else reason end),dockno,PKGS,wt  from VWNET_CHKDKT_VALID_MISROUTE WITH(NOLOCK) where DOCKNO = '" + DOCKET + "'";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        string Reason = "N",pkgsno="0",weight="0";
        while (dr.Read())
        {
            Reason = dr[0].ToString().Trim();
            pkgsno = dr[2].ToString().Trim();
            weight = dr[3].ToString().Trim();
                i = 1;
                break;
           
        }
        dr.Close();

        if (i == 0)
            Response.Write("false|" + Reason + "|" + pkgsno + "|" + weight + "|");
        else if (i == 1)
            Response.Write("true|" + Reason + "|" + pkgsno + "|" + weight + "|");

        con.Close();
    }
}
