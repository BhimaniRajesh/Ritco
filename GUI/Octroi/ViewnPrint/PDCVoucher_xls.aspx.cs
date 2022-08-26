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

public partial class GUI_Octroi_ViewnPrint_PDCVoucher_xls : System.Web.UI.Page
{
    public static string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";
    public string status = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();
        
        string thcno = Request.QueryString["voucherno"].ToString(), thcsf = ".";
        status=Request.QueryString["status"].ToString();
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

        string sql = "";
        if (status.CompareTo("1") == 0)
            sql = "select convert(varchar,adv_voucherdt,106) as adv_voucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,convert(varchar,pdcdt,106) as pdcdt,* from webx_pdchdr T where T.pdcno='" + thcno + "' union select convert(varchar,adv_voucherdt,106) as adv_voucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,convert(varchar,pdcdt,106) as pdcdt,* from webx_pdchdr_arch T where T.pdcno='" + thcno + "'";
        else if (status.CompareTo("2") == 0)
            sql = "select convert(varchar,adv_voucherdt,106) as adv_voucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,convert(varchar,pdcdt,106) as pdcdt,* from webx_pdchdr T where T.pdcno='" + thcno + "' union select convert(varchar,adv_voucherdt,106) as adv_voucherdt,convert(varchar,adv_chqdate,106) as adv_chqdate,convert(varchar,pdcdt,106) as pdcdt,* from webx_pdchdr_arch T where T.pdcno='" + thcno + "'";
          
      

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        //string sql = "SELECT * FROM webx_vouchertrans_arch a,webx_thc_summary_arch b WHERE a.voucherno='" + voucherno + "' and b.thcno=a.docno";
        
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();


        while (dr.Read())
        {
            //select * from webx_thc_summary,webx_vouchertrans_arch where webx_thc_summary.thcno=webx_vouchertrans_arch.docno

            
            
            lblrunsheet.Text = dr["pdcbr"].ToString() + ":" + fn.GetLocation(dr["pdcbr"].ToString());
            lblvoucherno.Text = dr["adv_voucherNo"].ToString();
            lblvoucherdate.Text = dr["adv_voucherdt"].ToString();
            lblrunsheetno.Text = dr["pdcno"].ToString();
            lblrunsheetdate.Text = dr["pdcdt"].ToString();
            lblvendorname.Text = dr["vendorcode"] + " : " + dr["vendorname"].ToString();
            lblvehicleno.Text = dr["vehno"].ToString();
            lblrefno.Text=dr["manualfmno"].ToString();
            if (dr["pdcty"].ToString().CompareTo("P") == 0)
                lblrunsheettype.Text = "Pick Up";
            else if (dr["pdcty"].ToString().CompareTo("D") == 0)
                lblrunsheettype.Text = "Delivery";

         
            lblcontractamt.Text = dr["pdc_amt"].ToString();
            lblothchrg.Text = dr["mis_chg"].ToString();
            lblpanno.Text = dr["panno"].ToString();
            lbltdsrate.Text = dr["tdsrate"].ToString();
            lbltdstype.Text = dr["tds_accdesc"].ToString();

            lbltdsamt.Text = dr["tdsamt"].ToString();
            if(dr["tdsfor"].ToString().CompareTo("C")==0)
            {
                lbltdsdeducted.Text = "Non Corporate";
            }
            else if(dr["tdsfor"].ToString().CompareTo("NC")==0)
            {
                lbltdsdeducted.Text = "Corporate"; 
            }
            
            lblnetpay.Text = dr["pdc_net"].ToString();
            lblpaidby.Text = dr["adv_paidby"].ToString();
            

            lbltransmode.Text = dr["adv_transtype"].ToString();
            if(status.CompareTo("1")==0)
                lblpayacc.Text = dr["adv_accdesc"].ToString();
            else if(status.CompareTo("1")==0)
                 lblpayacc.Text = dr["bal_accdesc"].ToString();

            lblchequeno.Text = dr["adv_chqno"].ToString();
            lblchequedate.Text = dr["adv_chqdate"].ToString();
            lblamt.Text = dr["tdsamt"].ToString();
            lblbalamt.Text = dr["balamt"].ToString();
            lblbalpaybleat.Text = dr["fincmplbr"].ToString() + ":" +fn.GetLocation(dr["fincmplbr"].ToString());

        }

        con.Close();
    }

}
