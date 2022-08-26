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

public partial class GUI_Finance_Journal_Voucher_JournalVoucher : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    string Financial_Year = "", fin_year = "", opertitle = "MANUAL CONTRA VOUCHER", Defaultdate = "";
    string chque_yn_chk, chque_entry ,chqrefyn;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        lblpreparedby.Text = Session["empcd"].ToString() + " : " + fn.GetEmpName(Session["empcd"].ToString());
        lblpreparedloc.Text = Session["brcd"].ToString() + " : " + fn.GetLocation(Session["brcd"].ToString());
        
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        Defaultdate = Request.QueryString["Defaultdate"];
        if (Defaultdate == "")
        {
            Defaultdate = "today";
        }
        if (!IsPostBack)
        {   

            for (int i = 0; i < 2; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();

            if (Defaultdate != "today")
            {
                txtVoucherDate.Text = Defaultdate;
            }
            else
            {
                txtVoucherDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                TextBox txtChqno = ((TextBox)gridrow.FindControl("txtChqno"));
                if (chkRefno.Checked)
                {
                    txtChqno.Attributes.Add("onkeypress", "");
                    txtChqno.MaxLength = 50;
                }
                else
                {
                    txtChqno.Attributes.Add("onkeypress", "validInt(event)");
                    txtChqno.MaxLength = 6;
                }
            }
        }
        txtVoucherDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'12','../../images/Date_Control_Rule_Check.aspx')");
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {   
        }
    }
    protected void CheckChqnofield(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {
            TextBox txtChqno = ((TextBox)gridrow.FindControl("txtChqno"));
            txtChqno.Text = "";
            if (chkRefno.Checked)
            {
                txtChqno.Attributes.Add("onkeypress", "");
                txtChqno.MaxLength = 50;
            }
            else
            {
                txtChqno.Attributes.Add("onkeypress", "validInt(event)");
                txtChqno.MaxLength = 50;
            }
        }
    }
    protected void fillcashbank(object sender, EventArgs e)
    {
        DropDownList ddlcashbank = (DropDownList)sender;
        DropDownList ddlaccountlist = (DropDownList)ddlcashbank.Parent.FindControl("ddlaccountlist");

        SqlCommand cmd;
        string cashbank = ddlcashbank.SelectedValue.ToString();
        if (cashbank == "Cash")
        {
            string sql_cash = "select '' as asscodeval,'--Select--' as accdesc Union  select acccode  as asscodeval,Company_acccode + ' : ' + accdesc as accdesc from webx_acctinfo where  acccategory='CASH'";
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
        if (cashbank == "Bank")
        {
            //string sql_bank = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,Company_acccode + ':' + accdesc as accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
			string sql_bank = "select '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,Company_acccode + ':' + accdesc as accdesc from webx_acctinfo where ((bkloccode like 'All' or '" + Session["brcd"].ToString() + "' in( select items from dbo.Split(bkloccode,','))) AND acccategory='BANK' ) order by accdesc asc";
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
        string Voucherno = "";
        string[] VDate = txtVoucherDate.Text.Split('/');
        string EntryBy = Session["empcd"].ToString(), Transtype = "Contra";
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

                    string sql_chk = "select chqamt,adjustamt,banknm from webx_chq_det where isnull(depoflag,'N')='N' and chqamt='" + Credit + "' and chqno='" + chqno + "' and chqdt='" + fn.Mydate1(txtchqdt.Text) + "'";
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

                str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + fin_year + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + Session["brcd"].ToString() + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + finyearstar + "',106) and convert(datetime,'" + fn.Mydate1(txtVoucherDate.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + fin_year + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + Session["brcd"].ToString() + "' and ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
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

                double curr_val = Convert.ToDouble(Credit);
                double open_val = Convert.ToDouble(openBalance.Substring(0, openBalance.Length - 3));
                string open_val_str = (openBalance.Substring(openBalance.Length - 3, 3)).Trim();

                if (open_val >= curr_val && open_val_str == "Dr")
                { }
                else
                {
                    string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                }
            }
        }

        SqlTransaction trans;
        trans = con.BeginTransaction();

        try
        {
            Voucherno = fn.NextVoucherno(Session["brcd"].ToString(), Financial_Year);

            string sql_Acctrans = "",Acccode = "", Debit = "", Credit = "", chqno = "";
            string ChqueNo = "",ChqueDate = "";
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
            Xml_Other_Details = Xml_Other_Details + "<Brcd>" + Session["brcd"].ToString().Trim() + "</Brcd>";
            Xml_Other_Details = Xml_Other_Details + "<Entryby>" + Session["empcd"].ToString().Trim() + "</Entryby>";
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
            Xml_Other_Details = Xml_Other_Details + "<EntryType>Insert</EntryType>";
            Xml_Other_Details = Xml_Other_Details + "</Other></root>";

            //string sql = "usp_Generate_ContraAccountDetails";
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
