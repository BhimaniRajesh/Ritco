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

public partial class GUI_Finance_Vendor_BA_payment_PDC_FIN_Edit_PDC_FIN_Updates : System.Web.UI.Page
{
    public string billno_nos, Branch, documentprint, voucherNo;
    public string checkeddockno, fromdt, Todt, Vno;
    public int totdkt, srno;
    public int ContractAmt = 0;
    public double OtherAmt = 0.00, TDSDeduction = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    MyFunctions fn = new MyFunctions();
    DateTime Fromdate, Todate, PDCdate;

    string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year = "",PDcbr = "",BranchCode="";
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        checkeddockno = Request.QueryString.Get(0).ToString();

        if (!IsPostBack)
        {
            string sql = "select * from webx_pdchdr where pdcno='" + checkeddockno.ToString() + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            PDCno.Text = checkeddockno.ToString();
            string PDCDT = "", PDcno = "", tdsfor = "", vendorcode = "", vendorname = "", vehicleno = "", routecd = "", routenm = "";
            string Pcamt = "", Advpaidby = "", Advamt = "", ServiceTax = "", CessAmount = "", H_CessAmount = "", LoadOpertype = "", balamtbrcd = "", netbalamt = "", Pan_no = "", Svrc_rate = "", Tds_chrg = "", Tds_rate = "", TEL_CHRG = "", LOAD_CHRG = "", MAMUL_CHRG = "", CESSAMT = "";

            while (dr.Read())
            {
                PDCDT = dr["pdCDT"].ToString();


                PDcbr = dr["PDCbr"].ToString();
                vendorcode = dr["vendorcode"].ToString();
                vendorname = dr["vendorname"].ToString();
                vehicleno = dr["vehno"].ToString();
                tdsfor = dr["tdsfor"].ToString();
                Pcamt = dr["pdc_amt"].ToString();
                fincmplbr = dr["fincmplbr"].ToString();
                if (Pcamt is DBNull || Pcamt == "")
                {
                    Pcamt = "0.00";
                }

                Tds_rate = dr["tdsrate"].ToString();
                if (Tds_rate is DBNull || Tds_rate == "")
                {
                    Tds_rate = "0.00";
                }
                Tds_chrg = dr["tdsamt"].ToString();
                if (Tds_chrg is DBNull || Tds_chrg == "")
                {
                    Tds_chrg = "0.00";
                }

                Pan_no = dr["panno"].ToString();
                Advamt = dr["Advamt"].ToString();
                if (Advamt is DBNull || Advamt == "")
                {
                    Advamt = "0.00";
                }
                netbalamt = dr["balamt"].ToString();
                if (netbalamt is DBNull || netbalamt == "")
                {
                    netbalamt = "0.00";
                }
                balamtbrcd = dr["balamtbrcd"].ToString();
                Advpaidby = dr["advamt_paidby"].ToString();
            }
            dr.Close();
            cboTDSDeducted.SelectedValue = tdsfor;
            vehno.Text = vehicleno;
            PDCBr.Text = PDcbr + ":" + fn.GetLocation(PDcbr);
            PDCdate = Convert.ToDateTime(PDCDT);
            PDCdt.Text = PDCdate.ToString("dd/MM/yyyy");
            hdPdcdt.Value = PDCdate.ToString("dd/MM/yyyy");
            PDCdt.Text = fn.Mydate(PDCdt.Text);
            Venodrename.Text = vendorcode + ":" + vendorname;
            contractamt.Text = Pcamt.ToString();
            tds_rate.Text = Tds_rate.ToString();
            tds_chrg.Text = Tds_chrg.ToString();
            pan_no.Text = Pan_no.ToString();
            advanceamt.Text = Advamt.ToString();
            advpaidby.Text = Advpaidby.ToString();
            balamt.Text = netbalamt.ToString();
            balamtbr.Text = balamtbrcd.ToString();


            sql = "select acccode as codeval,Accdesc from webx_acctinfo where acccode ='CLA0015'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);

            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            da.Fill(ds, "tab1");

            tdsacccode.DataSource = ds;

            tdsacccode.DataTextField = "Accdesc";
            tdsacccode.DataValueField = "codeval";
            tdsacccode.DataBind();

            btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit()");
        }
    }
    public void BindGrid()
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "SELECT accdesc+':'+Company_acccode as dispval,accdesc,acccode FROM webx_acctinfo WHERE acccode='CLA0015'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        tdsacccode.Items.Clear();
        while (dr.Read())
        {
            tdsacccode.Items.Add(new ListItem(dr["dispval"].ToString(), dr["acccode"].ToString()));
            acccode = dr["acccode"].ToString();
            accdesc = dr["accdesc"].ToString();
        }

        dr.Close();

        sql = "select pdc_status as pdc_status,PDCBR from webx_PDChdr where pdcno='" + Request.QueryString.Get(0).ToString() + "'";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        string advvoucherno = "";
        while (dr.Read())
        {

            advvoucherno = dr["pdc_status"].ToString();
            BranchCode = dr["PDCBR"].ToString();
        }

        dr.Close();

        if (advanceamt.Text == "")
        {
            advanceamt.Text = "0.00";
        }

        string sql_arch = "UPDATE webx_pdchdr  set pdc_amt=" + contractamt.Text + ",tdsrate=" + tds_rate.Text + ",tdsamt=" + tds_chrg.Text + " ";
        sql_arch = sql_arch + " ,pdc_net=" + balamt.Text + ",balamt=" + balamt.Text + ",panno='" + pan_no.Text + "',tds_accdesc='" + tdsacccode.SelectedItem.Text + "',tds_acccode='" + tdsacccode.SelectedValue.ToString() + "',tdsfor='" + cboTDSDeducted.SelectedValue.ToString() + "',advamt_paidby='" + advpaidby.Text + "',balamtbrcd='" + balamtbr.Text + "'";


        if (Convert.ToDouble(advanceamt.Text) == 0)
        {
            sql_arch = sql_arch + " ,pdc_status='OC'";// WHERE thcno='" + strNewTHCNo + "'";
        }
        else
        {
                sql_arch = sql_arch;

        }

        SqlTransaction trn;
        trn = conn.BeginTransaction();


        try
        {
            sql_arch = sql_arch + " WHERE PDCno='" + Request.QueryString.Get(0).ToString() + "'";
            cmd = new SqlCommand(sql_arch, conn, trn);
            cmd.ExecuteNonQuery();


            string Vno = "";

            sql = "update webx_acctrans_" + fin_year + " set Voucher_Cancel='Y' WHERE docno='" + Request.QueryString.Get(0).ToString() + "' and Transtype not in ('Bank Payment','Cash Payment')";
            cmd = new SqlCommand(sql, conn, trn);
            cmd.ExecuteNonQuery();

            string Vbrcd = Session["brcd"].ToString(), Voucherno = fn.NextVoucherno(PDcbr, Financial_Year);
            Vno = fn.NextVoucherno(BranchCode, Financial_Year);

            string sql_bal_acct = "exec usp_PDCTransaction 1,'" + Request.QueryString.Get(0).ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
            cmd = new SqlCommand(sql_bal_acct, conn, trn);
            cmd.ExecuteNonQuery();

            sql_bal_acct = "exec usp_PDCTransaction 2,'" + Request.QueryString.Get(0).ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
            cmd = new SqlCommand(sql_bal_acct, conn, trn);
            cmd.ExecuteNonQuery();

            sql = "update webx_pdchdr set Adv_VoucherNo=NULL WHERE PDCno='" + Request.QueryString.Get(0).ToString() + "'";
            cmd = new SqlCommand(sql, conn, trn);
            cmd.ExecuteNonQuery();

            trn.Commit();
            conn.Close();
            string final = "?DocumentPrint=" + Request.QueryString.Get(0).ToString();
            final += "&voucherNo=" + Vno;
            Response.Redirect("PDC_fin_updates_done.aspx" + final);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            Response.End();

        }
    }

}
