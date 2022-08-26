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

public partial class GUI_Octroi_ViewnPrint_VendorVoucher_viewPrint : System.Web.UI.Page
{
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();
        
        string thcno = Request.QueryString["voucherno"].ToString(),thcsf=".";
        Ptrinyn = Request.QueryString["printyn"].ToString();
        
        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";

        if (Ptrinyn == "1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        //string sql = "SELECT * FROM webx_vouchertrans_arch a,webx_thc_summary_arch b WHERE a.voucherno='" + voucherno + "' and b.thcno=a.docno";
        string sql = "select convert(varchar,advvoucherdt,106) as advvoucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,* from webx_thc_summary T left outer join webx_acctrans_07_08 A  on  T.vendor_code=A.pbov_code where T.THCNO='" + thcno + "' and T.THCsf='" + thcsf + "' union select convert(varchar,advvoucherdt,106) as advvoucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,* from webx_thc_summary_arch T left outer join webx_acctrans_07_08 A  on T.vendor_code=A.pbov_code where T.THCNO='" + thcno + "' and T.THCsf='" + thcsf + "'";
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
      

        while (dr.Read())
        { 
//select * from webx_thc_summary,webx_vouchertrans_arch where webx_thc_summary.thcno=webx_vouchertrans_arch.docno

            lblvoucherno.Text = dr["advvoucherNo"].ToString();
            lblvendorname.Text= dr["vendor_code"] + " : " +  dr["vendor_name"].ToString();
            lblthcnumber.Text = dr["thcno"].ToString();
            lblroutename.Text = dr["routename"].ToString();
            lblmanfmno.Text = dr["manualfmno"].ToString();
            lblpaidat.Text = dr["advpaidat"].ToString() + " : " + fn.GetLocation(dr["advpaidat"].ToString());
            lblvoucherdate.Text = dr["advvoucherdt"].ToString();
            
            lblvehicleno.Text = dr["vehno"].ToString();
            lblstdcontamt.Text = dr["stdpcamt"].ToString();
            lbltdstype.Text = dr["tdsgrpdesc"].ToString();
            lblcontractamt.Text = dr["pcamt"].ToString();
            
            lbltdsdeducted.Text = dr["tdsfor"].ToString(); // not founded
            
            lbltelchrg.Text = dr["tel_chrg"].ToString();
            lblpanno.Text = dr["pan_no"].ToString();
            lblhamali.Text = dr["load_chrg"].ToString();
            lbladpaid.Text = Convert.ToString(Convert.ToDouble(dr["advamt"].ToString()) - Convert.ToDouble(dr["advamt_lastpaid"].ToString()));
            lblmamul.Text = dr["mamul_chrg"].ToString();
            lbladamount.Text = dr["advamt_lastpaid"].ToString();
            lbltdsrate.Text = dr["tds_rate"].ToString();
            lbladamtpaidby.Text = dr["advpaidby"].ToString();
            lbltdsamt.Text = dr["tds_chrg"].ToString();
            lblnetamtpaid.Text = dr["advamt"].ToString();   
            lblsertaxreate.Text = dr["svrc_rate"].ToString();

            if(dr["loadopertype"].ToString().CompareTo("+")==0)
                lblbalamt.Text = Convert.ToString(Convert.ToDouble(dr["pcamt"].ToString()) + Convert.ToDouble(dr["tel_chrg"].ToString()) - Convert.ToDouble(dr["mamul_chrg"].ToString()) + Convert.ToDouble(dr["load_chrg"].ToString()) - Convert.ToDouble(dr["advamt"].ToString()) + Convert.ToDouble(dr["svrcamt"].ToString()) + Convert.ToDouble(dr["cessamt"].ToString()) - Convert.ToDouble(dr["tds_chrg"].ToString()));
            else
                lblbalamt.Text = Convert.ToString(Convert.ToDouble(dr["pcamt"].ToString()) + Convert.ToDouble(dr["tel_chrg"].ToString()) - Convert.ToDouble(dr["mamul_chrg"].ToString()) - Convert.ToDouble(dr["load_chrg"].ToString()) - Convert.ToDouble(dr["advamt"].ToString()) + Convert.ToDouble(dr["svrcamt"].ToString()) + Convert.ToDouble(dr["cessamt"].ToString()) - Convert.ToDouble(dr["tds_chrg"].ToString()));

            lblsertax.Text = dr["svrcamt"].ToString();
            lblbalpaybleat.Text = dr["balamtbrcd"].ToString() + " : " + fn.GetLocation(dr["balamtbrcd"].ToString());
            lblcess.Text = dr["cessamt"].ToString();
            lbltransmode.Text = dr["adv_transtype"].ToString();

            lblpayacc.Text = dr["adv_acccode"].ToString();
            lblchequeno.Text = dr["chqno"].ToString();
            lblchequedate.Text = dr["adv_chqdate"].ToString();
            lblpayamt.Text = dr["adv_colamt"].ToString();
           // lblrswordonly.Text = dr["payamt"].ToString();

            
        }

        con.Close();
    }

}
