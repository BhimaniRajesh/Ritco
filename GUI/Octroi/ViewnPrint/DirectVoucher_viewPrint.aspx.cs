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

public partial class GUI_Octroi_Octroi_Bill_DirectPayVoucher_viewPrint : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public static double octtot;
    public static int rowcnt;
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {

        string voucherno=Request.QueryString["voucherno"].ToString();
        Ptrinyn = Request.QueryString["printyn"].ToString();
        lblvoucherno.Text = voucherno;
        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";
        
        if (Ptrinyn == "1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }
        gvdirectoct.CssClass = boxbg;
        gvdirectoct.HeaderStyle.CssClass = bluefnt;
        
        
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        string sqlqry = "SELECT convert(varchar,transdate,106) as transdate,* FROM webx_vouchertrans_arch WHERE voucherno='" + voucherno + "'";
        SqlCommand cmd = new SqlCommand(sqlqry);
        cmd.Connection = con;
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        
        while (dr.Read())
        {
            lblvoucherdate.Text= dr["transdate"].ToString();
            lbloctagent.Text=dr["pbov_code"].ToString() + " ~ " + dr["pbov_name"].ToString();
            lblpaidto.Text=dr["payto"].ToString();
            lbloctpaidrs.Text=dr["octpaid"].ToString();
            lblothchrg.Text=dr["othchrg"].ToString();
            lblpaidto.Text = dr["payto"].ToString();
            lblnetpay.Text=dr["netamt"].ToString();

            lbltransmode.Text = dr["transmode"].ToString();
            lblissuedacc.Text = dr["oppaccount"].ToString();
            lblchequeno.Text = dr["chqno"].ToString();
            lblchequedate.Text = dr["chqdate"].ToString();
            lblpaymentamt.Text = dr["netamt"].ToString();
        }

        dr.Close();
       string q2 = "select distinct convert(varchar,recptdt,106) as recptdt,* from webx_vouchertrans_arch a,webx_oct_det b where a.voucherno='" + voucherno + "' and b.voucherno='" + voucherno + "'";
        
        SqlCommand cmd1 = new SqlCommand(q2,con);
        SqlDataAdapter da = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        da.Fill(ds);
        gvdirectoct.DataSource = ds;
        gvdirectoct.DataBind();
        double octtot=0;
        int i = ds.Tables[0].Rows.Count;
        if (i>= 0)
        {
            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                octtot += Convert.ToDouble(drRows["octamt"]);
            }
 
                gvdirectoct.FooterRow.Cells[1].Text = "Total";
                gvdirectoct.FooterRow.Cells[4].Text = Convert.ToString(octtot);
                gvdirectoct.FooterRow.CssClass = bluefnt;
                gvdirectoct.FooterRow.BackColor = System.Drawing.Color.White;
                gvdirectoct.FooterRow.HorizontalAlign = HorizontalAlign.Right;
         }
        else
        {
            gvdirectoct.CssClass = "redfnt";
        }
         con.Close();

    }

  



    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvdirectoct_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
  
}
