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

public partial class GUI_Operations_THC_Reassign_Location_CheckExist : System.Web.UI.Page
{
    string LocCode="";
    protected void Page_Load(object sender, EventArgs e)
    {

        string mode = Request.QueryString["mode"].ToString();

        string dockno = Request.QueryString["dockno"].ToString();
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "", msg = "", prs = "", drs = "", bacode = "", paybas = "", trn_mod = "", SubTotal = "", resstr = "";
        qry = "select thcno,advance_paid,THCClose_Mode,thcbr,balamtbrcd,balvoucherno from webx_THC_Summary where thcno='" + dockno + "'";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        msg = "Invalid THC NO.";
        con.Open();
        dr = cmd.ExecuteReader();

        int i = 0;
        if (dr.Read())
        {
            
            if (dr["balvoucherno"] != DBNull.Value)
            {
                msg = "Balance Payment Done";
            }
            else
            {
                i = 1;
                LocCode = dr["balamtbrcd"].ToString();
            }

        }
        
        dr.Close();


        if (i == 0)
            Response.Write("false|" + msg);
        else if (i == 1)
            Response.Write("true|" + LocCode);

    }

}
