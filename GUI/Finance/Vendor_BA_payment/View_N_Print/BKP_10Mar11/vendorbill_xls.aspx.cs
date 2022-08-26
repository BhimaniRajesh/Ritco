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

public partial class GUI_Finance_Vendor_BA_payment_View_N_Print_vendorbill_xls : System.Web.UI.Page
{
    public static string str_GenerateBillNo,str_GenerateBillNo2,bill;
    public static string DOCNO,betype;
    public static int PCAMT, tot, totOTHAMT, totSVCTAX, totCESS, totADVPAID, totOTHDED, totSVCTAXDED, totnetpay, tottdsded, tottds_rate;
    public int totdisount;

    protected void Page_Load(object sender, EventArgs e)
    {
        string str_GenerateBillNo = Request.QueryString.Get("strGenerateBillNo");
        string[] Split = str_GenerateBillNo.Split(new Char[] { ',' });
        str_GenerateBillNo = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        betype = Convert.ToString(Split[2]);

        if (Session["Client"].ToString() == "PRRL")
        {
            imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
        }
        if (Session["Client"].ToString() == "TLL")
        {
            imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
        }
        else if (Session["Client"].ToString() == "EXL")
        {
            imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Varuna")
        {
            imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
        }
        else if (Session["Client"].ToString() == "RITCO")
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }
        else if (Session["Client"].ToString() == "RCPL")
        {
            imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Agility")
        {
            imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
        }
        else if (Session["Client"].ToString() == "ASL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
        }
        else if (Session["Client"].ToString() == "UFL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ufl_logo_NEW.gif";
        }
        else
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select BILLNO,VENDORCODE + ':' + VENDORNAME as VENDORNAME,convert(varchar,VENDORBILLDT,6) as VENDORBILLDT,PCAMT,OTHAMT,Round(SVCTAX,2) as SVCTAX,Round(CESSAMT,2) as CESSAMT,convert(varchar,BILLDT,6) as BILLDT,VENDORBILLNO,convert(varchar,DUEDT,6) as DUEDT,ADVAMT,OTHERDED,SVCTAXDED,TDS,Round(NETAMT,2) as NETAMT,discount,REMARK,Hedu_Cess,* from WEBX_VENDORBILL_HDR where BILLNO='" + str_GenerateBillNo + "' ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        SqlDataReader dr = null;
        dr = sqlcmd.ExecuteReader();

        if (dr.Read())
        {
            string BillNo = dr[0].ToString().Trim();
            string vandorname = dr[1].ToString().Trim();
            string vendorbilldate = dr[2].ToString().Trim();
            string contractamount = dr[3].ToString().Trim();
            string otheramount = dr[4].ToString().Trim();
            string servicetax = dr[5].ToString().Trim();
            string cess1 = dr[6].ToString().Trim();
            string bill_entrydate = dr[7].ToString().Trim();
            string vendorbillno = dr[8].ToString().Trim();
            string duedate = dr[9].ToString().Trim();
            string advancepaid = dr[10].ToString().Trim();
            string deduction = dr[11].ToString().Trim();
            string servicetaxdeduction = dr[12].ToString().Trim();
            string TDSdeduction = dr[13].ToString().Trim();
            string netpayable = dr[14].ToString().Trim();
            string tot_dis = dr["discount"].ToString().Trim();
            string HigherEduCess = dr["Hedu_Cess"].ToString().Trim();
            if (HigherEduCess == "")
            {
                HigherEduCess = "0";
            }
            string remark = dr["REMARK"].ToString().Trim();

            lblvendorname.Text = vandorname;
            lblvendorbilldt.Text = vendorbilldate;
            lblcontractamt.Text = contractamount;
            lblotheramount.Text = otheramount;
            lblservicetaxcharged.Text = servicetax;
            lblcess.Text = cess1;
            lblbillentrydt.Text = bill_entrydate;
            lblvendorbillnumber.Text = vendorbillno;
            lblduedt.Text = duedate;
            lbladvancepaid.Text = advancepaid;
            lbldeduction.Text = deduction;
            lblsvctaxdeduction.Text = servicetaxdeduction;
            lblTDSdeduction.Text = TDSdeduction;
            lblDiscount.Text = tot_dis;
            lblHduCess.Text = HigherEduCess;
            lblnetpayable.Text = netpayable;
            lblRemarks.Text = remark;


        }
        dr.Close();
        conn.Close();
        disp();
    }
    public void disp()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        str_GenerateBillNo2 = Request.QueryString.Get("strGenerateBillNo");


        string[] Split = str_GenerateBillNo2.Split(new Char[] { ',' });
        str_GenerateBillNo2 = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        betype = Convert.ToString(Split[2]);
        if (betype == "THC")
        {
            GridView1.Visible = true;
            GridView2.Visible = false;
            string sql2 = "select ld_actuwt,v.BILLNO, v.BILLSF, v.DOCNO, v.DOCSF, v.PCAMT, v.OTHAMT, Round(v.SVCTAX,2) as SVCTAX, Round(v.CESS,2) as CESS, v.ADVPAID,v.OTHDED, v.SVCTAXDED, v.voucherNo, v.paydt,Round(v.netpay,2) as netpay,v.tdsded,v.tds_rate,v.svctaxrate,v.discount,* from WEBX_VENDORBILL_DET v,webx_thc_summary t where BILLNO='" + str_GenerateBillNo2 + "' and v.docno=t.thcno ";
            SqlCommand sqlcmd2 = new SqlCommand(sql2, conn);

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd2);

            DataSet ds = new DataSet();
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();

        }
        else if (betype == "PDC")
        {
            GridView2.Visible = true;
            GridView1.Visible = false;
            string sql3 = "select docno,PCAMT,OTHAMT,discount,svctaxrate,svctax,cess,advpaid,othded,svctaxded,tds_rate,tdsded,netpay from WEBX_VENDORBILL_DET where billno='" + str_GenerateBillNo2 + "'";
            SqlCommand sqlcmd2 = new SqlCommand(sql3, conn);

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd2);

            DataSet ds = new DataSet();
            da.Fill(ds);

            GridView2.DataSource = ds;
            GridView2.DataBind();

        
        }


        conn.Close();

    }
    //public void pgChange(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;

    //    disp();


    //}
}
