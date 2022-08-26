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

public partial class GUI_Operations_document_cancel_CheckExist : System.Web.UI.Page
{
    public string thc;
    public string date, from, to, manualno;
    protected void Page_Load(object sender, EventArgs e)
    {
        thc = Request.QueryString["thcno"].ToString();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //string qry = "select t.thcno,t.thcdt,sourcehb,t.tobh_code,t.ManualTHCNo,* from WebX_Trans_Docket_Status s , Webx_THC_Summary t where t.THCNo='" + thc.Trim() + "' and s.THC=t.thcno and s.MF is Not Null and t.VendorBillNo is NULL and t.VendorBENo is NULL and t.advvoucherno is NULL and t.balvoucherno is NULL and t.thcbr='" + Session["BRCD"].ToString() + "'";
        string qry = "EXEC IsValid_THC_For_Cancellation '" + thc + "','" + Session["BRCD"].ToString() + "'";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        while (dr.Read())
        {
            date = Convert.ToString(dr["thcdt"]);
            from = Convert.ToString(dr["sourcehb"]);
            to = Convert.ToString(dr["tobh_code"]);
            manualno = Convert.ToString(dr["ManualTHCNo"]);
            i = 1;
            break;
            
        }
        dr.Close();
        
        Response.Clear();
        if (i == 0)
            Response.Write("false|");
        else if (i == 1)
            Response.Write("true|" + date + "|" + from + "|" + to + "|" + manualno + "|");
        con.Close();
    }
}
