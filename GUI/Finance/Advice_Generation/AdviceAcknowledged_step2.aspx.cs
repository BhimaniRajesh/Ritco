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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Advice_Generation_AdviceAcknowledged_step2 : System.Web.UI.Page
{   
    SqlConnection connStr;
    SqlConnection conn;
    SqlCommand cmd;
    MyFunctions myFunc = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    string adviceNo = "", dateFrom = "", dateTo = "", option = "", Year, fin_year, table_name;
    double fin_year_next;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            option = Request.QueryString["option"];
            if (option == "1")
            {
                adviceNo = Request.QueryString["adviceno"];
            }
            else
            {
                myFunc = new MyFunctions();

                string strDateFrom = Request.QueryString["DateFrom"];
                string strDateTo = Request.QueryString["DateTo"];

                dateFrom = myFunc.Mydate1(strDateFrom);
                dateTo = myFunc.Mydate1(strDateTo);
            }
            
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            if (option == "1")
            {
                dateFrom = "";
                dateTo = "";
            }
            if (option == "2")
            {
                adviceNo = "";
            }

            Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year_next = Convert.ToDouble(Year) + 1;
            fin_year = Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
            table_name = "webx_acctrans_" + fin_year;
            
            //exec usp_Advice_Acknowledge '25 Jun 2008','02 Jul 2008','','AGR'
            string sql = "exec usp_Advice_Acknowledge '" + dateFrom + "','" + dateTo + "','" + adviceNo + "','" + Session["brcd"].ToString() + "','" + table_name + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandTimeout = 200;
            SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
            
            DataSet ds = new DataSet();
            myAdapter.Fill(ds);
            
            dgGeneral.DataSource = ds;
            dgGeneral.DataBind();

            if (ds.Tables[0].Rows.Count == 0)
                cmdbtnrow.Visible = false;
            else
                cmdbtnrow.Visible = true;
        }
    }
    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string sql = "";
            string transType = e.Row.Cells[3].Text;

            if(transType.ToUpper() == "CASH")
                sql = "select acccode,accdesc from webx_acctinfo where acccategory='CASH' order by accdesc asc";
            else
            {   
                if (Session["Client"].ToString() == "Ritco"){
                    //sql = "select acccode,accdesc from webx_acctinfo where acccategory='CASH' or ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND  acccategory='BANK') order by accdesc asc";
					sql = "select acccode,accdesc from webx_acctinfo where acccategory='CASH' or ((bkloccode like 'All' or '" + Session["brcd"].ToString() + "' in ( select items from dbo.Split(bkloccode,','))) AND acccategory='BANK' ) order by accdesc asc";
				}
                else
                    sql = "select acccode,accdesc from webx_acctinfo where ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND  acccategory='BANK') order by accdesc asc";
            }
            SqlCommand cmd_pbov = new SqlCommand(sql, conn);
            SqlDataReader dr_pbov;

            DropDownList dlstAcccode = (DropDownList)e.Row.FindControl("dlstAcccode");

            dr_pbov = cmd_pbov.ExecuteReader();
            dlstAcccode.Items.Clear();

            dlstAcccode.CssClass = "blackfnt";
            //dlstAcccode.Items.Add(new ListItem("Select", ""));
            while (dr_pbov.Read())
            {
                dlstAcccode.Items.Add(new ListItem(dr_pbov.GetValue(1).ToString(), dr_pbov.GetValue(0).ToString()));
            }
            dr_pbov.Close();
            dlstAcccode.Items.ToString().ToUpper();

            TextBox txtAccDate = ((TextBox)e.Row.FindControl("txtAccDate"));
            txtAccDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtAccDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'10','../../images/Date_Control_Rule_Check.aspx')");

            if (Session["Client"].ToString().CompareTo("Ritco") == 0 || Session["Client"].ToString().CompareTo("RCPL") == 0)
            {
                if (Session["Client"].ToString().CompareTo("RCPL") == 0)
                {
                    if (Session["empcd"].ToString().CompareTo("10001") != 0)
                    {
                        //txtAccDate.Enabled = false;
                    }
                }
                else
                {
                    //txtAccDate.Enabled = false;
                }
            }
        }
        
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string docNo = "", adv = "";
        bool success = false;
        if (Page.IsValid)
        {
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year_next = Convert.ToDouble(Year) + 1;
            fin_year = Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
            table_name = "webx_acctrans_" + fin_year;

            foreach (GridViewRow gr in dgGeneral.Rows)
            {
                DropDownList acccode1 = (DropDownList)gr.FindControl("dlstAcccode");
                TextBox accdate1 = (TextBox)gr.FindControl("txtAccDate");
                HtmlInputCheckBox chkAdvice = (HtmlInputCheckBox)gr.FindControl("chkAdvice");

                if (acccode1.SelectedValue.ToString() == "CAS0002" && gr.Cells[2].Text == "Credit" && chkAdvice.Checked)
                {
                    SqlDataReader dtr;
                    double intCASH_OPNDEBIT = 0;
                    double intCASH_OPNCredit = 0;
                    string str = "";
                    string openBalance = "";
                    string curr_year = DateTime.Now.ToString("yyyy");
                    string finyearstar = "";
                    if (Session["FinYear"].ToString() == curr_year)
                    {
                        finyearstar = "01 Apr " + curr_year;
                    }
                    else
                    {
                        finyearstar = "01 Apr " + Session["FinYear"].ToString();
                    }

                    str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + fin_year + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + Session["brcd"].ToString() + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + finyearstar + "',106) and convert(datetime,'" + myFunc.Mydate1(accdate1.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + fin_year + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + Session["brcd"].ToString() + "' and ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
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

                    double curr_val = Convert.ToDouble(gr.Cells[8].Text);
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
            trans = conn.BeginTransaction();
            try
            { 
                foreach (GridViewRow gr in dgGeneral.Rows)
                {   
                    DropDownList acccode1 = (DropDownList)gr.FindControl("dlstAcccode");
                    TextBox accdate1 = (TextBox)gr.FindControl("txtAccDate");

                    if (((HtmlInputCheckBox)gr.FindControl("chkAdvice")).Checked)
                    {
                        if (docNo == "")
                            docNo = gr.Cells[1].Text;
                        else
                            docNo = docNo + "," + gr.Cells[1].Text;
                        
                        string chequeadvice = "select advicestatus from webx_advice_hdr where adviceno='" + gr.Cells[1].Text + "'";
                        cmd = new SqlCommand(chequeadvice, conn, trans);
                        SqlDataReader dr_chqadv;
                        dr_chqadv = cmd.ExecuteReader();

                        string advicestatus = "";
                        while (dr_chqadv.Read())
                        {
                            advicestatus = dr_chqadv["advicestatus"].ToString();
                        }
                        dr_chqadv.Close();

                        advicestatus = advicestatus.ToUpper();

                        if (advicestatus == "SUBMITTED")
                        {
                            
                            string chqno="",chqdate="";
                            
                            if(gr.Cells[10].Text != "--")
                                chqno = gr.Cells[10].Text;
                            if(gr.Cells[11].Text != "--")
                                chqdate = gr.Cells[11].Text;
							

							string sql = "exec usp_Advice_updateData '" + gr.Cells[1].Text + "','" + Session["empcd"].ToString() + "','" + Convert.ToDateTime(myFunc.Mydate1(accdate1.Text)) + "','" + Session["brcd"].ToString() + "','" + Session["brcd"].ToString() + "','" + Session["empcd"].ToString() + "','" + acccode1.SelectedValue + "','" + Convert.ToDateTime(myFunc.Mydate1(accdate1.Text)) + "'";
                            cmd = new SqlCommand(sql, conn, trans);
                            cmd.ExecuteNonQuery();
							
							string strsql_procEntry = "exec usp_AdviceTransaction_ver1 1,'" + gr.Cells[1].Text + "','" + Year + "','" + chqno + "','" + chqdate + "'";
                            cmd = new SqlCommand(strsql_procEntry, conn, trans);
                            cmd.ExecuteNonQuery();

                            string strsql_proc = "exec usp_AdviceTransaction_ver1 2,'" + gr.Cells[1].Text + "','" + Year + "','" + chqno + "','" + chqdate + "'";
                            cmd = new SqlCommand(strsql_proc, conn, trans);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                trans.Commit();
                //trans.Rollback();

                adv = null;
                success = true;

            }
            catch (Exception e1)
            {   
                Response.Write("Error" + e1.Message);
                string msg = e1.Message.ToString();
                msg = msg.Replace('\n', ' ');
                msg = msg.Replace('\r', ' ');
                trans.Rollback();
                Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + msg);
                Response.End();
            }
            finally
            {

            }
            if (success)
                Response.Redirect("advRecv_Done.aspx?AdviceNo=" + docNo);

        }

    }
    
}
