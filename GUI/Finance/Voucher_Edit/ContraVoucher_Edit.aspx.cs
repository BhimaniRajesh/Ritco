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

public partial class GUI_Finance_Voucher_Edit_ContraVoucher_Edit : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    string Financial_Year = "", fin_year = "", opertitle = "MANUAL CONTRA VOUCHER", Defaultdate = "", chque_entry = "", chque_yn_chk="";
    double fin_year_next = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        string table_name = "";
        
        if (!IsPostBack)
        {
            lblvoucherno.Text = Request.QueryString["voucherno"].ToString().Replace("'", "");
            table_name = "webx_acctrans_" + fin_year;

            dt = new DataTable("table1");
            dt.Columns.Add("Paymode");
            dt.Columns.Add("Acccode");
            dt.Columns.Add("Debit");
            dt.Columns.Add("Credit");
            dt.Columns.Add("Chqno");
            dt.Columns.Add("Chqdt");

            string sql = "select Paymode=(select acccategory from webx_acctinfo b where b.acccode=a.acccode),convert(varchar,a.transdate,103) transdate,";
            sql += "a.acccode,a.debit,a.credit,a.entryby,a.Narration,c.Manual_voucherno,c.refno,a.brcd,";
            sql += "chqueno=(case when a.acccode='CAS0002' then '' else case when (select acccategory from webx_acctinfo d where d.acccode=a.acccode)='BANK' and a.credit > 0 then a.chqno else '' end end),";
            sql += "chquedt=(case when a.acccode='CAS0002' then '' else case when (select acccategory from webx_acctinfo d where d.acccode=a.acccode)='BANK' and a.credit > 0 then convert(varchar,a.chqdate,103) else '' end end),";
            sql += "a.chqno,convert(varchar,a.chqdate,103) chqdate from " + table_name + " a left outer join webx_vouchertrans_arch c ";
            sql += "on a.voucherno=c.voucherno where a.voucherno='" + lblvoucherno.Text + "' and isnull(a.voucher_cancel,'N')='N'  order by a.srno";
            cmd = new SqlCommand(sql, con);
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txtManualNo.Text = dr["Manual_voucherno"].ToString();
                txtRefNo.Text = dr["refno"].ToString();
                lblpreparedby.Text = dr["entryby"].ToString() + " : " + fn.GetEmpName(dr["entryby"].ToString());
                lblpreparedloc.Text = dr["brcd"].ToString() + " : " + fn.GetLocation(dr["brcd"].ToString());
                txtVoucherDate.Text = dr["transdate"].ToString();
                txtNarration.Text = dr["narration"].ToString();
                HdnBrcd.Value = dr["brcd"].ToString();
                HdnEntryby.Value = dr["entryby"].ToString();

                if (dr["chqueno"].ToString().CompareTo("") != 0)
                {
                    HdnChqno.Value = dr["chqueno"].ToString();
                    HdnChqdt.Value = dr["chquedt"].ToString();
                    //HdnCashBankAmt.Value = dr["chquedt"].ToString();
                }
                
                /*if (Convert.ToDouble(dr["debit"].ToString()) > 0)
                    HdnCashBankAmt.Value = dr["debit"].ToString();
                else
                    HdnCashBankAmt.Value = dr["credit"].ToString();*/

                if (dr["Paymode"].ToString() == "CASH")
                { 
                    if (Convert.ToDouble(dr["debit"].ToString()) > 0)
                        HdnCashBankAmt.Value = "0";
                    else
                        HdnCashBankAmt.Value = dr["credit"].ToString();
                }

                dt.Rows.Add(dr["Paymode"].ToString(), dr["acccode"].ToString(), dr["debit"].ToString(), dr["credit"].ToString(), dr["chqueno"].ToString(), dr["chquedt"].ToString());
            }
            dr.Close();

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();

            sql = "select count(*) total from webx_chq_det where voucherno='" + lblvoucherno.Text + "' OR (chqno='" + HdnChqno.Value + "' and chqdt='" + fn.Mydate1(HdnChqdt.Value) + "')";
            cmd = new SqlCommand(sql, con);
            double total = Convert.ToDouble(cmd.ExecuteScalar());
            if (total == 0)
            {
                chkRefno.Checked = true;
            }
        }
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {   
            DropDownList ddlcashbank = (DropDownList)e.Row.FindControl("ddlcashbank");
            DropDownList ddlaccountlist = (DropDownList)e.Row.FindControl("ddlaccountlist");
            TextBox txtDebitAmt = (TextBox)e.Row.FindControl("txtDebitAmt");
            TextBox txtCreditAmt = (TextBox)e.Row.FindControl("txtCreditAmt");
            TextBox txtChqno = (TextBox)e.Row.FindControl("txtChqno");
            TextBox txtChqdate = (TextBox)e.Row.FindControl("txtChqdate");

            ddlcashbank.SelectedValue = DataBinder.Eval(e.Row.DataItem, "Paymode").ToString();

            if (ddlcashbank.SelectedValue == "CASH")
            {
                string sql_cash = "select '' as asscodeval,'--Select--' as accdesc Union  select acccode  as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
                cmd = new SqlCommand(sql_cash, con);
                ddlaccountlist.Items.Clear();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    ddlaccountlist.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
                }
                dr.Close();
                ddlaccountlist.CssClass = "blackfnt";
                ddlaccountlist.SelectedValue = DataBinder.Eval(e.Row.DataItem, "Acccode").ToString();
            }
            else if (ddlcashbank.SelectedValue == "BANK")
            {
                string sql_bank = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + HdnBrcd.Value + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
                cmd = new SqlCommand(sql_bank, con);
                ddlaccountlist.Items.Clear();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    ddlaccountlist.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
                }
                dr.Close();
                ddlaccountlist.CssClass = "blackfnt";
                ddlaccountlist.SelectedValue = DataBinder.Eval(e.Row.DataItem, "Acccode").ToString();
            }

            
            txtDebitAmt.Text = DataBinder.Eval(e.Row.DataItem, "Debit").ToString();
            txtCreditAmt.Text = DataBinder.Eval(e.Row.DataItem, "Credit").ToString();
            txtChqno.Text = DataBinder.Eval(e.Row.DataItem, "Chqno").ToString();
            txtChqdate.Text = DataBinder.Eval(e.Row.DataItem, "Chqdt").ToString();
        }
    }
    public void FillAcccode(string acccode)
    {
        
    }
    protected void fillcashbank(object sender, EventArgs e)
    {
        DropDownList ddlcashbank = (DropDownList)sender;
        DropDownList ddlaccountlist = (DropDownList)ddlcashbank.Parent.FindControl("ddlaccountlist");
        SqlCommand cmd;

        string cashbank = ddlcashbank.SelectedValue.ToString();
        if (cashbank == "CASH")
        {
            string sql_cash = "select '' as asscodeval,'--Select--' as accdesc Union  select acccode  as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
            cmd = new SqlCommand(sql_cash, con);
            ddlaccountlist.Items.Clear();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddlaccountlist.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddlaccountlist.CssClass = "blackfnt";
        }
        if (cashbank == "BANK")
        {
            string sql_bank = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + HdnBrcd.Value + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            cmd = new SqlCommand(sql_bank, con);
            ddlaccountlist.Items.Clear();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddlaccountlist.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            ddlaccountlist.CssClass = "blackfnt";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Year = Session["FinYear"].ToString();
        string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        string Voucherno = lblvoucherno.Text;
        string[] VDate = txtVoucherDate.Text.Split('/');
        string EntryBy = HdnEntryby.Value , Transtype = "Contra";
        string OppaccountDesc1 = "", OppaccountCode1 = "", OppaccountDesc_mode = "", OppaccountCode_mode = "";
        string OppaccountDesc2 = "", OppaccountCode2 = "", OppaccountDesc_mode1 = "", OppaccountCode_mode1 = "";
        string sql_Acccode = "", chqrefyn = "N";
        string VoucherDate = Convert.ToDateTime(VDate[1] + "/" + VDate[0] + "/" + VDate[2]).ToString("yyyy/MM/dd");
        string Narration = txtNarration.Text.ToString();

        if (chkRefno.Checked)
        {
            chqrefyn = "Y";
            chque_entry = "N";
        }
        else
        {
            chqrefyn = "N";
            chque_entry = "N";
        }

        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {
            string Account = ((DropDownList)gridrow.FindControl("ddlaccountlist")).SelectedValue.ToString();
            string paymode = ((DropDownList)gridrow.FindControl("ddlcashbank")).SelectedValue.ToString();
            string Credit = ((TextBox)gridrow.FindControl("txtCreditAmt")).Text.ToString();
            string chqno = ((TextBox)gridrow.FindControl("txtChqno")).Text.ToString();
            TextBox txtchqdt = ((TextBox)gridrow.FindControl("txtChqdate"));

            if (chkRefno.Checked != true)
            {
                if (Convert.ToDouble(Credit) > 0 && paymode.ToUpper() == "BANK")
                {
                    chque_yn_chk = "N";
                    chque_entry = "Y";
                    if (HdnChqno.Value != chqno && HdnChqdt.Value != txtchqdt.Text && HdnCashBankAmt.Value != Credit)
                    {
                        string sql_chk = "select chqamt,adjustamt,banknm from webx_chq_det where depoflag='N' and chqamt='" + Credit + "' and chqno='" + chqno + "' and chqdt='" + fn.Mydate1(txtchqdt.Text) + "'";
                        SqlCommand cmd_chk = new SqlCommand(sql_chk, con);
                        SqlDataReader dr_chk = null;

                        dr_chk = cmd_chk.ExecuteReader();

                        while (dr_chk.Read())
                        {
                            chque_yn_chk = "Y";
                            chque_entry = "N";
                        }
                        dr_chk.Close();

                        if (chque_yn_chk == "N")
                        {

                            sql_chk = "select chqamt,adjustamt,banknm from webx_chq_det where chqno='" + chqno + "' and chqdt='" + fn.Mydate1(txtchqdt.Text) + "'";
                            cmd_chk = new SqlCommand(sql_chk, con);
                            dr_chk = cmd_chk.ExecuteReader();

                            while (dr_chk.Read())
                            {
                                chque_yn_chk = "Y";
                            }
                            dr_chk.Close();

                            if (chque_yn_chk == "Y")
                            {
                                string ErrorMsg = "Transactions halted !!!,Duplicate Cheque Entered ";
                                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                            }
                            else
                            {
                                chque_entry = "Y";
                            }
                        }
                    }
                    if (HdnChqno.Value == chqno && HdnChqdt.Value == txtchqdt.Text && HdnCashBankAmt.Value == Credit)
                    {
                        chque_entry = "Y";
                    }
                }
            }
            if (Convert.ToDouble(Credit) > 0 && paymode.ToUpper() == "CASH")
            {
                double intCASH_OPNDEBIT = 0;
                double intCASH_OPNCredit = 0;
                string str = "";
                string openBalance = "";
                string finyear = Session["FinYear"].ToString();
                string curr_year = DateTime.Now.ToString("yyyy");

                string finyearstar = "";
                if (finyear == curr_year)
                {
                    finyearstar = "01 Apr " + curr_year;
                }
                else
                {
                    finyearstar = "01 Apr " + finyear;
                }

                str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + fin_year + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + HdnBrcd.Value + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + HdnBrcd.Value + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + finyearstar + "',106) and convert(datetime,'" + fn.Mydate1(txtVoucherDate.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + fin_year + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + HdnBrcd.Value + "' and ( acccategory='CASH' OR ((bkloccode like '%" + HdnBrcd.Value + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
                SqlDataReader dtr;
                dtr = DAccess.getreader(str);
                while (dtr.Read())
                {
                    string CASH_OPNDEBIT = dtr["CASH_OPNDEBIT"].ToString();
                    intCASH_OPNDEBIT = intCASH_OPNDEBIT + Convert.ToDouble(dtr["CASH_OPNDEBIT"]);
                    string CASH_OPNCredit = dtr["CASH_OPNCredit"].ToString();
                    intCASH_OPNCredit = intCASH_OPNCredit + Convert.ToDouble(dtr["CASH_OPNCredit"]);
                    if (intCASH_OPNDEBIT > intCASH_OPNCredit)
                    {
                        openBalance = Convert.ToString(intCASH_OPNDEBIT - intCASH_OPNCredit) + " " + "Dr";
                    }
                    else
                    {
                        openBalance = Convert.ToString(intCASH_OPNCredit - intCASH_OPNDEBIT) + " " + "Cr";
                    }
                }
                dtr.Close();

                double Old_AMT = 0, New_AMT = 0;
                Old_AMT = Convert.ToDouble(HdnCashBankAmt.Value.ToString());
                New_AMT = Convert.ToDouble(Credit);
                double curr_val = 0;
                if (New_AMT > Old_AMT)
                {
                    curr_val = New_AMT - Old_AMT;
                }

                double open_val = Convert.ToDouble(openBalance.Substring(0, openBalance.Length - 3));
                string open_val_str = (openBalance.Substring(openBalance.Length - 3, 3)).Trim();

                if (open_val >= curr_val && open_val_str == "Dr")
                { }
                else
                {
                    string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + HdnBrcd.Value;
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                }
            }
        }
        
        SqlTransaction trans;
        trans = con.BeginTransaction();
        try
        {
            string sql_Acctrans = "", Acccode = "", Debit = "", Credit = "", chqno = "";
            string ChqueNo = "", ChqueDate = "";
            string Xml_Acccode_Details = "<root>";

            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                Acccode = ((DropDownList)gridrow.FindControl("ddlaccountlist")).SelectedValue.ToString();
                Debit = ((TextBox)gridrow.FindControl("txtDebitAmt")).Text.ToString();
                Credit = ((TextBox)gridrow.FindControl("txtCreditAmt")).Text.ToString();
                chqno = ((TextBox)gridrow.FindControl("txtChqno")).Text.ToString();
                TextBox txtchqdt = ((TextBox)gridrow.FindControl("txtChqdate"));

                if (chqno != "" && txtchqdt.Text != "")
                {
                    ChqueNo = chqno;
                    ChqueDate = fn.Mydate1(txtchqdt.Text);
                }

                Xml_Acccode_Details = Xml_Acccode_Details + "<Acctdetails>";
                Xml_Acccode_Details = Xml_Acccode_Details + "<Acccode>" + Acccode.Trim() + "</Acccode>";
                Xml_Acccode_Details = Xml_Acccode_Details + "<Accdesc>" + fn.getAccountDesc("webx_acctinfo", Acccode).ToString().Trim() + "</Accdesc>";
                Xml_Acccode_Details = Xml_Acccode_Details + "<Debit>" + Debit.Trim() + "</Debit>";
                Xml_Acccode_Details = Xml_Acccode_Details + "<Credit>" + Credit.Trim() + "</Credit>";
                Xml_Acccode_Details = Xml_Acccode_Details + "</Acctdetails>";
            }
            Xml_Acccode_Details = Xml_Acccode_Details + "</root>";

            string Xml_Other_Details = "<root><Other>";
            Xml_Other_Details = Xml_Other_Details + "<Finyear>" + Session["FinYear"].ToString().Trim() + "</Finyear>";
            Xml_Other_Details = Xml_Other_Details + "<Transdate>" + VoucherDate.Trim() + "</Transdate>";
            Xml_Other_Details = Xml_Other_Details + "<Transtype>" + Transtype.Trim() + "</Transtype>";
            Xml_Other_Details = Xml_Other_Details + "<Voucherno>" + Voucherno.Trim() + "</Voucherno>";
            Xml_Other_Details = Xml_Other_Details + "<Brcd>" + HdnBrcd.Value.Trim() + "</Brcd>";
            Xml_Other_Details = Xml_Other_Details + "<Entryby>" + HdnEntryby.Value.Trim() + "</Entryby>";
            Xml_Other_Details = Xml_Other_Details + "<Opertitle>" + "MANUAL CONTRA VOUCHER" + "</Opertitle>";
            Xml_Other_Details = Xml_Other_Details + "<ManualNo>" + txtManualNo.Text.Trim() + "</ManualNo>";
            Xml_Other_Details = Xml_Other_Details + "<Refno>" + txtRefNo.Text.Trim() + "</Refno>";
            Xml_Other_Details = Xml_Other_Details + "<Narration>" + txtNarration.Text.Trim() + "</Narration>";
            Xml_Other_Details = Xml_Other_Details + "<chqno>" + ChqueNo.Trim() + "</chqno>";
            Xml_Other_Details = Xml_Other_Details + "<chqdt>" + ChqueDate.Trim() + "</chqdt>";
            Xml_Other_Details = Xml_Other_Details + "<ChqueEntryYN>" + chque_entry.Trim() + "</ChqueEntryYN>";
            Xml_Other_Details = Xml_Other_Details + "<ChqueRefYN>" + chqrefyn.Trim() + "</ChqueRefYN>";
            Xml_Other_Details = Xml_Other_Details + "<pbov_code></pbov_code>";
            Xml_Other_Details = Xml_Other_Details + "<pbov_name></pbov_name>";
            Xml_Other_Details = Xml_Other_Details + "<pbov_typ></pbov_typ>";
            Xml_Other_Details = Xml_Other_Details + "<EntryType>Update</EntryType>";
            Xml_Other_Details = Xml_Other_Details + "</Other></root>";

            //string sql = "usp_Generate_Ins_Up_ContraAccountDetails";
			string sql = "usp_Generate_Ins_Up_ContraAccountDetails_Ver2";
            cmd = new SqlCommand(sql, con, trans);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Xml_Acccode_Details", SqlDbType.Text).Value = Xml_Acccode_Details.Replace("&", "&amp;").Trim();
            cmd.Parameters.Add("@Xml_Other_Details", SqlDbType.Text).Value = Xml_Other_Details.Replace("&", "&amp;").Trim();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();

            double LedgerDiff = 0;
            sql_Acctrans = "select sum(debit) - sum(credit) as Differance from webx_acctrans_" + fin_year + " where voucher_cancel='N' and voucherno='" + Voucherno + "'";
            cmd = new SqlCommand(sql_Acctrans, con, trans);
            SqlDataReader dr_count = cmd.ExecuteReader();
            while (dr_count.Read())
            {
                LedgerDiff = Convert.ToDouble(dr_count["Differance"].ToString().Trim());
            }
            dr_count.Close();

            if (LedgerDiff != 0)
            {
                throw new Exception("Debit Amount Should Be Equal To Credit Amount");
            }
            else
            {
                trans.Commit();
            }
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            msg = msg.Replace('\r', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + msg);
            Response.End();
        }
        
        con.Close();
        Response.Redirect("voucher_Done.aspx?VoucherType=Contra&VoucherNo=" + Voucherno + "&Defaultdate=" + txtVoucherDate.Text, false);

    }
}
