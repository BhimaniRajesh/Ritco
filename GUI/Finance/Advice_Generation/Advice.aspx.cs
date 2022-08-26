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
using System.IO;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Text;

public partial class GUI_Finance_Advice_Generation_Advice : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    MyFunctions fn = new MyFunctions();
    Advice adv = new Advice();
    DateFunction DAccess = new DateFunction();
    string chque_entry, chque_yn_chk;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        if (Session["Client"].ToString().CompareTo("Ritco") == 0 || Session["Client"].ToString().CompareTo("RCPL") == 0)
        {
            if (Session["Client"].ToString().CompareTo("RCPL") == 0)
            {
                if (Session["empcd"].ToString().CompareTo("10001") != 0)
                {
                    txtAdviceDate.Enabled = false;
                }
            }
            else
            {
                //txtAdviceDate.Enabled = false;
            }
        }
        if (!IsPostBack)
        {
            txtAdviceDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }
        lblgeneratedby.Text = Session["empcd"].ToString() + ":" + fn.GetEmpName(Session["empcd"].ToString().ToUpper());
        lblraisedby.Text = Session["brcd"].ToString() + ":" + fn.GetLocation(Session["brcd"].ToString());
        btnRaisedLoc.Attributes.Add("onclick", "popuplist('LocCode','" + txtRaisedOn.ClientID.ToString() + "','none')");
        txtRaisedOn.Attributes.Add("onblur", "LocBlur('" + txtRaisedOn.ClientID.ToString() + "')");
        txtChqDate.Attributes.Add("onblur", "ChequeBlur('" + txtChqDate.ClientID.ToString() + "')");
        txtAdviceDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'09','../../images/Date_Control_Rule_Check.aspx')");
    }
    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPayMode.SelectedItem.Text == "Cash")
        {
              txtCashAmt.Text = txtPaymentAmt.Text;
              txtCashAmt.Enabled = false;
              ddrCashcode.Enabled = true;
              txtPaymentAmt.Enabled = true;

              txtChqAmt.Enabled = false;
              txtChqNo.Enabled = false;
              txtChqAmt.Text = "0.00";
              txtChqNo.Text = "";
              
              txtChqAmt.Text = "";
              txtChqNo.Text = "";

              ddrBankaccode.SelectedValue = "";
              ddrBankaccode.Enabled = false;
              txtChqDate.Text = "";
              txtChqDate.Enabled = false;

              ddrCashcode.Items.Clear();
              string strSql = " select top 1 '' as asscodeval,'--Select--' as accdesc Union  select acccode  as asscodeval,accdesc from webx_acctinfo where  acccategory='CASH'";
              cmd = new SqlCommand(strSql, con);

              dr = cmd.ExecuteReader();
              while (dr.Read())
              {
                  ddrCashcode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
              }
              dr.Close();
              ddrCashcode.CssClass = "blackfnt";
          }
          else if (ddlPayMode.SelectedItem.Text == "Bank")
          {
              txtCashAmt.Enabled = false;
              txtCashAmt.Text = "0.00";
              ddrCashcode.SelectedValue = "";
              ddrCashcode.Enabled = false;
              txtPaymentAmt.Enabled = true;

              txtChqAmt.Enabled = false;
              txtChqNo.Enabled = true;
              txtChqAmt.Text = txtPaymentAmt.Text;

              txtCashAmt.Text = "";

              ddrBankaccode.Enabled = true;
              txtChqDate.Enabled = true;

              ddrBankaccode.Items.Clear();

              string strSql = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
              cmd = new SqlCommand(strSql, con);

              dr = cmd.ExecuteReader();
              while (dr.Read())
              {
                  ddrBankaccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
              }
              dr.Close();

              ddrBankaccode.CssClass = "blackfnt";
          }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {   
            string Financial_Year = Session["FinYear"].ToString();
            string AdviceNo = "";
            string[] AdvDate = txtAdviceDate.Text.Split('/');
            string AdviceDate = Convert.ToDateTime(AdvDate[1] + "/" + AdvDate[0] + "/" + AdvDate[2]).ToString("yyyy/MM/dd");
            string AdviceType = dlstAdviceType.SelectedValue.ToString();
            string RaisedBy = Session["brcd"].ToString();
            string RaisedOn = txtRaisedOn.Text;
            string GeneratedBy = Session["empcd"].ToString();
            string Reason = txtReason.Text;
            string enclosed = txtEnclosedDoc.Text;
            string Advicetype = dlstAdviceType.SelectedValue.ToString();
            string PaymentMode = ddlPayMode.SelectedValue.ToString();
            string advice_amount = "";
            string CashBankAccount = "";
            string chqno= "";
            string chqdate = "";
            Boolean success = false;

            if (PaymentMode.ToUpper() == "CASH" && Advicetype == "D")
            {
                SqlDataReader dtr;
                double intCASH_OPNDEBIT = 0;
                double intCASH_OPNCredit = 0;
                string str = "";
                string openBalance = "";
                string finyear = Session["FinYear"].ToString();
                string curr_year = DateTime.Now.ToString("yyyy");

                string Financial_Year_1 = Session["FinYear"].ToString().Substring(2, 2);
                double fin_year_next = Convert.ToDouble(Financial_Year_1) + 1;
                string fin_year = Financial_Year_1 + "_" + fin_year_next.ToString().PadLeft(2, '0');

                string finyearstar = "";
                if (finyear == curr_year)
                {
                    finyearstar = "01 Apr " + curr_year;
                }
                else
                {
                    finyearstar = "01 Apr " + finyear;
                }

                str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + fin_year + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + Session["brcd"].ToString() + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + finyearstar + "',106) and convert(datetime,'" + fn.Mydate1(txtAdviceDate.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + fin_year + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + Session["brcd"].ToString() + "' and ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
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

                double curr_val = Convert.ToDouble(txtPaymentAmt.Text);
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
            if(PaymentMode.ToUpper() == "CASH")
            {
                advice_amount =  txtCashAmt.Text;
                CashBankAccount = ddrCashcode.SelectedValue.ToString();
            }

            if (PaymentMode.ToUpper() == "BANK")
            {
                advice_amount =  txtChqAmt.Text;
                CashBankAccount = ddrBankaccode.SelectedValue.ToString();
                string[] ChDate = txtChqDate.Text.Split('/');
                chqdate = Convert.ToDateTime(ChDate[1] + "/" + ChDate[0] + "/" + ChDate[2]).ToString("yyyy/MM/dd");
                chqno = txtChqNo.Text;

                //string sql_chk = "select a.chqno,convert(varchar,a.chqdt,106) as chqdt from webx_billchqdetail a where (a.chqno='" + chqno + "' and a.chqdt='" + chqdate + "') or (a.chqno in(select b.chqno from webx_chq_det b where b.chqno='" + chqno + "' and b.chqdt='" + chqdate + "') and a.chqdt in(select b.chqdt from webx_chq_det b where b.chqno='" + chqno + "' and b.chqdt='" + chqdate + "'))";
                string sql_chk = "select chqno,convert(varchar,chqdt,106) chqdt,chqamt,depoflag from webx_chq_det where depoflag='N' and chqno='" + chqno + "' and chqdt='" + chqdate + "' and chqamt='" + advice_amount + "'";
                SqlCommand cmd_chk = new SqlCommand(sql_chk, con);
                SqlDataReader dr_chk = null;
                dr_chk = cmd_chk.ExecuteReader();

                chque_yn_chk = "N";
                chque_entry = "Y";

                if (dr_chk.Read())
                {
                    chque_yn_chk = "Y";
                    chque_entry = "N";
                }
                dr_chk.Close();

                if (chque_yn_chk == "N")
                {
                    sql_chk = "select chqno,convert(varchar,chqdt,106) chqdt,chqamt,depoflag from webx_chq_det where chqno='" + chqno + "' and chqdt='" + chqdate + "'";
                    cmd_chk = new SqlCommand(sql_chk, con);
                    dr_chk = cmd_chk.ExecuteReader();

                    while(dr_chk.Read())
                    {
                        chque_yn_chk = "Y";
                    }
                    dr_chk.Close();

                    if (chque_yn_chk == "Y")
                    {   
                        string ErrorMsg = "Transactions halted !!!,Duplicate Cheque Entered";
                        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                    }
                    else
                    {
                        chque_entry = "Y";
                    }
                }
            }

            SqlTransaction trans;
            trans = con.BeginTransaction();
            try
            {   
                    double adv_amt = Convert.ToDouble(advice_amount);
                    double payment_amt = Convert.ToDouble(txtPaymentAmt.Text);

                    if(adv_amt != payment_amt)
                        throw new Exception("Advice Payment Amount Shoud be Equal to Cash or Cheque Amount");
                    else if(adv_amt == 0)
                        throw new Exception("Advice Amount Can't Be Zero");

                    string strSql = "exec usp_Insert_webx_Advice_hdr_ChqDetail '" + AdviceDate + "','" + AdviceType + "','";
                    strSql += RaisedOn + "','" + RaisedBy + "'," + adv_amt + ",'" + Reason + "','" + PaymentMode.ToUpper() + "','";
                    strSql += enclosed + "','" + Financial_Year + "','" + GeneratedBy + "','" + CashBankAccount + "','";
                    strSql += chqno + "','" + chqdate + "','" + chque_entry + "','output'";
                    cmd = new SqlCommand(strSql, con, trans);
                    SqlDataReader dr = null;
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        AdviceNo = Convert.ToString(dr["GenAdviceNo"]);
                    }
                    dr.Close();
                     
                    //string strsql_proc = "exec usp_AdviceTransaction_ver1 1,'" + AdviceNo + "','" + Financial_Year.Substring(2, 2) + "','" + chqno + "','" + chqdate + "'";
                    //cmd = new SqlCommand(strsql_proc, con, trans);
                    //cmd.ExecuteNonQuery();

                    trans.Commit();
                    success = true;
            }
            catch (Exception e1)
            {
                Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
                string msg = e1.Message.ToString();
                msg = msg.Replace('\n', ' ');
                msg = msg.Replace('\r', ' ');
                trans.Rollback();
                //Response.Redirect("Message.aspx?" + msg);
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + msg);
            }
            if(success)
            {
                Response.Redirect("advice_Done.aspx?AdviceNo=" + AdviceNo + "&AdviceType=" + AdviceType);
            }
        }
    }
}
