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

public partial class GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THC_FIN_Updates : System.Web.UI.Page
{
    public string billno_nos, Branch, documentprint, voucherNo, AdvanceFlag;
    public static string checkeddockno, fromdt, Todt, Vno;
    public int totdkt, srno;
    public int ContractAmt = 0;
    public double OtherAmt = 0.00, TDSDeduction = 0.00,  AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    MyFunctions fn = new MyFunctions();
    DateTime Fromdate, Todate,Thcdate;
    public static string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year="";
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        checkeddockno = Request.QueryString.Get(0).ToString();
      //  BindGrid();
        if (!IsPostBack)
        {
            string sql = "select * from webx_thc_summary where thcno='" + checkeddockno.ToString() + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            //Response.Write("hi...." + Transdate);
            //Response.End();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            THCno.Text = checkeddockno.ToString();
            string thcdt = "", thcno = "", thcbr = "", vendorcode = "", vendorname = "", vehicleno = "", routecd = "", routenm = "";
            string Pcamt = "", Advpaidby = "", Advamt = "", ServiceTax = "", CessAmount = "", H_CessAmount = "", LoadOpertype = "", balamtbrcd = "", netbalamt = "", Pan_no = "", Svrc_rate = "", Tds_chrg = "", Tds_rate = "", TEL_CHRG = "", LOAD_CHRG = "", MAMUL_CHRG = "", CESSAMT = "";

            while (dr.Read())
            {
                thcdt = dr["THCDT"].ToString();// Convert.ToStringdr("THCDT");
                AdvanceFlag = dr["Advance_paid"].ToString();
                Advamt = dr["Advamt"].ToString();
                if (Advamt is DBNull || Advamt == "")
                {
                    Advamt = "0";
                }

                if (AdvanceFlag == "O" || AdvanceFlag == null || (AdvanceFlag == "F" && Advamt == "0"))
                {
                    advanceamt.Enabled = true;
                }
                else
                {
                    advanceamt.Enabled = false;
                }
                txtManualTHCNo.Text = dr["ManualTHCNO"].ToString();


                thcbr = dr["thcbr"].ToString();// Convert.ToString("thcbr");
                vendorcode = dr["vendor_code"].ToString();// Convert.ToString("vendor_code");
                vendorname = dr["vendor_name"].ToString(); //Convert.ToString("vendor_name");
                vehicleno = dr["vehno"].ToString(); //Convert.ToString("vehno");
                routecd = dr["routecd"].ToString(); //Convert.ToString("routecd");
                routenm = dr["routename"].ToString(); //Convert.ToString("routename");
                Pcamt = dr["Pcamt"].ToString();
                fincmplbr = dr["fincmplbr"].ToString();
                if (Pcamt is DBNull || Pcamt == "")
                {
                    Pcamt = "0.00";
                }
                TEL_CHRG = dr["TEL_CHRG"].ToString();
                if (TEL_CHRG is DBNull || TEL_CHRG == "")
                {
                    TEL_CHRG = "0.00";
                }
                LOAD_CHRG = dr["LOAD_CHRG"].ToString();
                if (LOAD_CHRG is DBNull || LOAD_CHRG == "")
                {
                    LOAD_CHRG = "0.00";
                }
                MAMUL_CHRG = dr["MAMUL_CHRG"].ToString();
                if (MAMUL_CHRG is DBNull || MAMUL_CHRG == "")
                {
                    MAMUL_CHRG = "0.00";
                }
                LoadOpertype = dr["LoadOpertype"].ToString();
                Tds_rate = dr["Tds_rate"].ToString();
                if (Tds_rate is DBNull || Tds_rate == "")
                {
                    Tds_rate = "0.00";
                }
                Tds_chrg = dr["Tds_chrg"].ToString();
                if (Tds_chrg is DBNull || Tds_chrg == "")
                {
                    Tds_chrg = "0.00";
                }
                Svrc_rate = dr["Svrc_rate"].ToString();
                if (Svrc_rate is DBNull || Svrc_rate == "")
                {
                    Svrc_rate = "0.00";
                }
                ServiceTax = dr["svrcamt"].ToString();
                if (ServiceTax is DBNull || ServiceTax == "")
                {
                    ServiceTax = "0.00";
                }
                CessAmount = dr["cessamt"].ToString();
                if (CessAmount is DBNull || CessAmount == "")
                {
                    CessAmount = "0.00";
                }
                H_CessAmount = dr["HEDU_CESS"].ToString();
                if (H_CessAmount is DBNull || H_CessAmount == "")
                {
                    H_CessAmount = "0.00";
                }
                Pan_no = dr["pan_no"].ToString();
                //Advamt = dr["Advamt"].ToString();
                //if (Advamt is DBNull || Advamt == "")
                //{
                //    Advamt = "0.00";
                //}
                netbalamt = dr["netbalamt"].ToString();
                if (netbalamt is DBNull || netbalamt == "")
                {
                    netbalamt = "0.00";
                }
                balamtbrcd = dr["balamtbrcd"].ToString();
                Advpaidby = dr["advpaidby"].ToString();
            }
            dr.Close();
            load_chrg.Text = LOAD_CHRG.ToString();
            THCBr.Text = thcbr + ":" + fn.GetLocation(thcbr);
            Thcdate = Convert.ToDateTime(thcdt);
            Thcdt.Text = Thcdate.ToString("dd/MM/yyyy");
            hdThcdt.Value = Thcdate.ToString("dd/MM/yyyy");
            Thcdt.Text = fn.Mydate(Thcdt.Text);
            routename.Text = routecd + ":" + routenm;
            Venodrename.Text = vendorcode + ":" + vendorname;
            contractamt.Text = Pcamt.ToString();
            tel_chrg.Text = TEL_CHRG.ToString();
            loadOpertype.SelectedValue = LoadOpertype.ToString();
            mamul_chrg.Text = MAMUL_CHRG.ToString();
            tds_rate.Text = Tds_rate.ToString();
            tds_chrg.Text = Tds_chrg.ToString();
            svtax_rate.Text = Svrc_rate.ToString();
            svrcamt.Text = ServiceTax.ToString();
            cessamt.Text = CessAmount.ToString();

            hcessamt.Text = H_CessAmount.ToString();
            pan_no.Text = Pan_no.ToString();
            advanceamt.Text = Advamt.ToString();
            advpaidby.Text = Advpaidby.ToString();
            balamt.Text = netbalamt.ToString();
            balamtbr.Text = balamtbrcd.ToString();


            sql = "select acccode+'~'+Accdesc as codeval,Accdesc from webx_acctinfo where acccode ='CLA0015'";
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

        sql = "select isnull(advvoucherno,'NA') as advvoucherno,fincmplbr from webx_thc_summary where thcno='" + Request.QueryString.Get(0).ToString() + "'";
        cmd = new SqlCommand(sql, conn);
        dr = cmd.ExecuteReader();
        string advvoucherno = "", fincmplbr_loc = "";
        while (dr.Read())
        {

            advvoucherno = dr["advvoucherno"].ToString();
            fincmplbr_loc = dr["fincmplbr"].ToString();
        }

        dr.Close();
        
        if (advanceamt.Text == "")
        {
            advanceamt.Text = "0.00";
        }

        sql = "UPDATE webx_thc_summary SET ManualTHCNO='" + txtManualTHCNo.Text + "',loadOperType='" + loadOpertype.Text + "',advamt=" + advanceamt.Text + ",advpaidby='" + advpaidby.Text + "',advpaiddt=GETDATE(),pcamt=";
        sql = sql + contractamt.Text + ",tel_chrg=" + tel_chrg.Text + ",mamul_chrg=" + mamul_chrg.Text + ",load_chrg=" + load_chrg.Text;
        sql = sql + ",balamtbrcd='" + balamtbr.Text + "',tds_rate=" + tds_rate.Text + ",tds_chrg=" + tds_chrg.Text + ",pan_no='" + pan_no.Text;
        sql = sql + "',tds_acccode='" + acccode + "',tds_accdesc='" + accdesc + "',tdsgrpcode='" + acccode + "',tdsgrpdesc='" + accdesc;
        //sql = sql + "',tdsfor='" + tdsfor.SelectedValue + "',svrcamt=" + svrcamt.Text + ",cessamt=" + cessamt.Text + ",netbalamt=" + balamt.Text + ",advance_paid='O',";
        sql = sql + "',tdsfor='-',svrcamt=" + svrcamt.Text + ",cessamt=" + cessamt.Text + ",netbalamt=" + balamt.Text + ","; //advance_paid='O',";
        sql = sql + "advamt_lastpaid=" + advanceamt.Text + ",svrc_rate='" + svtax_rate.Text + "',thcnew_mode='F',";

        //sql = sql + "cwt=" + txtcwt.Text + ",height=" + txtheight.Text + ",detention=" + txtdetentionchg.Text + ",";
        //sql=sql + "multi_point=" + txtmultipt.Text + ",";

        if (Convert.ToDouble(advanceamt.Text) == 0)
        {

            //sql = "update webx_thc_summary SET advance_paid='F' WHERE thcno='" + strNewTHCNo + "'";
            sql = sql + " advance_paid='F',";// WHERE thcno='" + strNewTHCNo + "'";
            //cmd = new SqlCommand(sql, con);
            //cmd.ExecuteNonQuery();
        }
        else
        {
            if (advvoucherno == "NA")
            {
                sql = sql + " advance_paid='O',";
            }
            else
            {
                sql = sql + " advance_paid='F',";
            }
        }

         SqlTransaction trn;
        trn = conn.BeginTransaction();


        try  //  try FOR ALL
        {
            sql = sql + "hedu_cess=" + hcessamt.Text + "  WHERE thcno='" + Request.QueryString.Get(0).ToString() + "'";
            cmd = new SqlCommand(sql, conn,trn);
            cmd.ExecuteNonQuery();
            string Vno = "";

            sql = "update webx_acctrans_" + fin_year + " set Voucher_Cancel='Y' WHERE docno='" + Request.QueryString.Get(0).ToString() + "' and Transtype not in ('Bank Payment','Cash Payment')";
            cmd = new SqlCommand(sql, conn, trn);
            cmd.ExecuteNonQuery();

            string Vbrcd = Session["brcd"].ToString();//, Voucherno = fn.NextVoucherno(fincmplbr_loc, Financial_Year);
            Vno = fn.NextVoucherno(fincmplbr_loc, Financial_Year);

            //string sql_Adv_acct = "exec usp_THCTransaction 1,'" + strNewTHCNo.ToString() + "','.','07','" + Session["empcd"].ToString() + "','" + Vno + "'";
            //cmd = new SqlCommand(sql_Adv_acct, con);
            //// Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
            //cmd.ExecuteNonQuery();

            string sql_bal_acct = "exec usp_THCTransaction 2,'" + Request.QueryString.Get(0).ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
            cmd = new SqlCommand(sql_bal_acct, conn, trn);
            // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
            cmd.ExecuteNonQuery();

            sql_bal_acct = "exec usp_THCTransaction 3,'" + Request.QueryString.Get(0).ToString() + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
            cmd = new SqlCommand(sql_bal_acct, conn, trn);
            // Response.Write("<br>" + Hidden_MRSNO.Value.ToString());
            cmd.ExecuteNonQuery();

            //************************************************************************************
            trn.Commit();

            conn.Close();
            string final = "?DocumentPrint=" + Request.QueryString.Get(0).ToString();
            final += "&voucherNo=" + Vno;
            Response.Redirect("THC_fin_updates_done.aspx" + final);

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();

        }
    }

}
