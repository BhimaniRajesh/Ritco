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

public partial class GUI_Octroi_ViewnPrint_THCBalanceVoucher : System.Web.UI.Page
{
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    protected void Page_Load(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();

        string thcno = Request.QueryString["voucherno"].ToString(), thcsf = ".";
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
        //string sql = "select convert(varchar,advvoucherdt,106) as advvoucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,* from webx_thc_summary T left outer join webx_acctrans_07_08 A  on  T.vendor_code=A.pbov_code where T.THCNO='" + thcno + "' and T.THCsf='" + thcsf + "' union select convert(varchar,advvoucherdt,106) as advvoucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,* from webx_thc_summary_arch T left outer join webx_acctrans_07_08 A  on T.vendor_code=A.pbov_code where T.THCNO='" + thcno + "' and T.THCsf='" + thcsf + "'";
        string sql = "select convert(varchar,advvoucherdt,106) as advvoucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,* from webx_thc_summary_arch  where THCNO='" + thcno + "' and thcsf='" + thcsf + "'";
       
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();


        while (dr.Read())
        {
            lblvoucherno.Text=dr["balvoucherno"].ToString();
            lblthcnumber.Text=dr["thcno"].ToString();
            lblvoucherdate.Text=dr["balvoucherdt"].ToString();
            lblroutename.Text=dr["routename"].ToString();
            lblmanfmno.Text=dr["manualfmno"].ToString();
            lblpaidat.Text=dr["balamtbrcd"].ToString();
            lblvendorname.Text = dr["vendor_code"].ToString() + dr["vendor_name"].ToString();
            lblvehicleno.Text=dr["vehno"].ToString();


            lblstdcontractamt.Text=dr["stdpcamt"].ToString();
            lbltdsrate.Text=dr["tds_rate"].ToString();
            lblcontractamt.Text=dr["pcamt"].ToString();
            lbltdsamt.Text=dr["tds_chrg"].ToString();
            lbltelchrg.Text=dr["tel_chrg"].ToString();
            lbltdstype.Text=dr["tdsgrpdesc"].ToString();
            lblhamali.Text=dr["load_chrg"].ToString();
            lblincentive.Text=dr["incentive"].ToString();
            lblmamul.Text=dr["mamul_chrg"].ToString();
            lblpenatalty.Text=dr["penalty"].ToString();
            lblservicetaxrate.Text=dr["svrc_rate"].ToString();
            lblclaim.Text=dr["claim_chrg"].ToString();
            lblservicetax.Text=dr["svrcamt"].ToString();
            lblhamali2.Text=dr["unload_chrg"].ToString();
            lblcess.Text=dr["cessamt"].ToString();
            lbldetentionchrg.Text=dr["deten_chrg"].ToString();
            lbladvancedamt.Text = Convert.ToString(Convert.ToDouble(dr["advamt"].ToString()) + Convert.ToDouble(dr["tds_chrg"].ToString()));
            lblothded.Text=dr["oth_ded"].ToString();
            lbladvancedpaidby.Text=dr["advpaidby"].ToString();
            lblnetamtpaidcol2.Text=dr["totalamtpaid"].ToString();
            lblnetamtpaidcol1.Text=dr["advamt"].ToString();
            lblbalamtpaidby.Text=dr["balpaidby"].ToString();

            if (dr["loadopertype"].ToString().CompareTo("+") == 0)
                lblbalamt.Text = Convert.ToString(Convert.ToDouble(dr["pcamt"].ToString()) + Convert.ToDouble(dr["tel_chrg"].ToString()) - Convert.ToDouble(dr["mamul_chrg"].ToString()) + Convert.ToDouble(dr["load_chrg"].ToString()) - Convert.ToDouble(dr["advamt"].ToString()) + Convert.ToDouble(dr["svrcamt"].ToString()) + Convert.ToDouble(dr["cessamt"].ToString()) - Convert.ToDouble(dr["tds_chrg"].ToString()));
            else
                lblbalamt.Text = Convert.ToString(Convert.ToDouble(dr["pcamt"].ToString()) + Convert.ToDouble(dr["tel_chrg"].ToString()) - Convert.ToDouble(dr["mamul_chrg"].ToString()) - Convert.ToDouble(dr["load_chrg"].ToString()) - Convert.ToDouble(dr["advamt"].ToString()) + Convert.ToDouble(dr["svrcamt"].ToString()) + Convert.ToDouble(dr["cessamt"].ToString()) - Convert.ToDouble(dr["tds_chrg"].ToString()));

            
            

            lblbalpayableat.Text=dr["balamtbrcd"].ToString();

            lbltransmode.Text=dr["bal_transtype"].ToString();
            lblpayacc.Text = dr["adv_acccode"].ToString();
            lblchequeno.Text=dr["adv_chqno"].ToString();
            lblchequedate.Text=dr["adv_chqdate"].ToString();
            lblpayamt.Text = dr["bal_colamt"].ToString();
        }

        con.Close();
    }

}
