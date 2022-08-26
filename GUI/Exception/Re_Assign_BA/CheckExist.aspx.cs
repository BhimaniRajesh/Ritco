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

public partial class GUI_Finance_Billing_BillEdit_BringBillDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
  
       
        string mode = Request.QueryString["mode"].ToString();

        string dockno = Request.QueryString["dockno"].ToString();
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "", msg = "", prs = "", drs = "", bacode = "", paybas="", trn_mod="", SubTotal="",resstr="";
        if (mode.CompareTo("docket") == 0)
            qry = "select isnull(prs,'N') as prs,isnull(drs,'N') as drs,bacode,paybas,trn_mod,SubTotal from vw_Docket_NET  where dockno='" + dockno + "'"; 
        
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        try
        {
            msg = "Invalid " + Session["DocketCalledAs"] + " NO.";
            con.Open();
            dr = cmd.ExecuteReader();

            int i = 0;
            while (dr.Read())
            {

                prs = dr["prs"].ToString();
                drs = dr["drs"].ToString();
                paybas = dr["paybas"].ToString();
                trn_mod = dr["trn_mod"].ToString();
                SubTotal = dr["SubTotal"].ToString();

                i = 1;
                bacode = dr["bacode"].ToString();
                resstr = paybas + "," + trn_mod + "," + SubTotal;

            }

            if (i == 0)
                Response.Write("false|" + msg);
            else if (i == 1)
                Response.Write("true|" + bacode + "|" + resstr);
        }
        catch (Exception ex)
        {
            Response.Write("false|" + ex.Message.Replace('\n', '_'));
        }
        con.Close();

    }
 
}
