using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_finance_voucher_DebitVoucher : System.Web.UI.Page
{
    public DataSet_Templates _dataSet = new DataSet_Templates();
    string connStr;
    int _lastEditedPage;
    MyFunctions myFunc;
    DateFunction DAccess = new DateFunction();
    SqlDataReader dtr;
    SqlConnection conn;
    public static string Financial_Year = "", fin_year="";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        connStr = Session["SqlProvider"].ToString().Trim();
        string strEmpid = "";
        //AccountTrans trans = new AccountTrans();
        //string vchrno = trans.genVoucherNo("HQTR");

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        UserControls_PaymentControl paymen = (UserControls_PaymentControl)UCPayment;
        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this)");
        

        string aa = "javascript:return valid(this," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + "," + txtAmount.ClientID + ")";
        cmdSubmit.Attributes.Add("onClick", aa);


        

        if (!IsPostBack)
        {
            DateFunction DAccess = new DateFunction();
            string FieldCode, FieldName, FieldLengthMin, FieldLengthMax, PrefixAlphaChars, IsPrefixConstant, PrefixConstant;
            FieldCode = "";
            FieldName = "";
            FieldLengthMin = "";
            FieldLengthMax = "";
            PrefixAlphaChars = "";
            IsPrefixConstant = "";
            PrefixConstant = "";
            string str = "select * from WebX_Setup_Fields";
            dtr = DAccess.getreader(str);
            while (dtr.Read())
            {
                FieldCode = dtr["FieldCode"].ToString().Trim();
                FieldName = dtr["FieldName"].ToString().Trim();
                FieldLengthMin = dtr["FieldLengthMin"].ToString().Trim();
                FieldLengthMax = dtr["FieldLengthMax"].ToString().Trim();
                PrefixAlphaChars = dtr["PrefixAlphaChars"].ToString().Trim();
                IsPrefixConstant = dtr["IsPrefixConstant"].ToString().Trim();
                PrefixConstant = dtr["PrefixConstant"].ToString().Trim();
            }
            dtr.Close();
            txtPrepareFor.MaxLength = Convert.ToInt16(FieldLengthMax);
            string codename="";
            //(pbov_code + ':' + pbov_name) as pbov_name
            string str_empname = "select (EmpId + ':' + Name) as Name from webx_master_users with (NOLOCK) where UserId='" + Session["empcd"].ToString() + "' and Status='100'";
            dtr = DAccess.getreader(str_empname);
            while (dtr.Read())
            {
                codename = dtr["name"].ToString().Trim();
            }
            dtr.Close();

            Initialised();
            BindGrid();
            lblPrepareAt.Text = Session["brcd"].ToString();
            lblPrepareBy.Text = codename;

            txtVoucherDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

            string sql = "select EmpId,Name from webx_master_users with (NOLOCK) where Status='100'";
            SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            while (rdr.Read())
            {
                if (strEmpid == "")
                    strEmpid = rdr["EmpId"].ToString();
                else
                    strEmpid = strEmpid + "," + rdr["EmpId"].ToString();
                    
            }
            rdr.Close();


            myFunc = new MyFunctions();
            string maxValue, minValue;
            maxValue = DateTime.Now.ToString("dd MMM yyyy");
            if (Convert.ToDateTime(Session["FinYearEnd"].ToString()) <= Convert.ToDateTime(maxValue))
            {
                maxValue = myFunc.DatadateDDMMYYYY(Session["FinYearEnd"].ToString());
                minValue = myFunc.DatadateDDMMYYYY(Session["FinYearStart"].ToString());
            }
            else
            {
                maxValue = DateTime.Now.ToString("dd/MM/yyyy");
                minValue = myFunc.DatadateDDMMYYYY(Session["FinYearStart"].ToString());
            }
            //txtVoucherDate.Attributes.Add("onblur", "javascript:" + myFunc.getDateValidateString(txtVoucherDate, minValue, maxValue));


            AccountTrans Acctrans = new AccountTrans();
            string validemps = Acctrans.getValidEmployee();

            string strjs = " javascript : var raisedon=document.getElementById('" + txtPrepareFor.ClientID + "');" +
                           " var valuetoCompare = '" + validemps + "';" +
                           " raisedon.value = raisedon.value.toUpperCase();" +
                           " if((valuetoCompare.indexOf(raisedon.value)<=0)&&(raisedon.value!=''))  {" +
                           " alert('Invalid Employee !!!'); " +
                           " raisedon.focus();" +
                           " return; }";
            Acctrans = null;
            txtPrepareFor.Attributes.Add("OnBlur", strjs);

           
        }
    }
    public void emp_check(object sender, EventArgs e)
    {
        AccountTrans Acctrans = new AccountTrans();
        string validemps = Acctrans.getValidEmployee();
        if (validemps != "")
        {
            string flag = "N";
            string loc = validemps;
            string[] arLocation = new string[0];
            char[] split_arLocation = { ',' };
            arLocation = loc.Split(split_arLocation);
            for (int x = 0; x < arLocation.Length; x++)
            {
                string tempLoc = arLocation[x];
                if (tempLoc == txtPrepareFor.Text)
                {
                    error.Visible = false;
                    flag = "N";
                    break;
                }
                else
                {
                    flag = "Y";
                }
            }
            if (flag == "Y")
            {
                error.Visible = true;
                error.Text = "'Invalid Employee !!!'";
            }
            else
            {
                error.Visible = false;
            }
        }
    }
            
    private void Initialised()
    {
        _dataSet.DebitVoucher.AddDebitVoucherRow("", "", "0", "");
        _dataSet.DebitVoucher.AddDebitVoucherRow("", "", "0", "");
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet_Templates)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    private void BindGrid()
    {
        dgGeneral.DataSource = _dataSet.DebitVoucher;
        dgGeneral.DataBind();
    }

    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //BindGrid();
    }

    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //txtDebit
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                TextBox txt1 = ((TextBox)e.Row.FindControl("txtTotalDebit"));
                
                UserControls_TDSPayment tds1 = (UserControls_TDSPayment)UCTDSPayment;
                UserControls_PaymentControl payment1 = (UserControls_PaymentControl)UCPayment;
                TextBox txt2 = (TextBox)tds1.FindControl("txtTdsRate");
                TextBox txt3 = (TextBox)tds1.FindControl("txtTdsAmt");
                DropDownList dlstTdsAcccode = (DropDownList)tds1.FindControl("dlstTdsAcccode");
                TextBox payamt = (TextBox)payment1.FindControl("txtAmount");
                string myScript = "JavaScript: calcu(this," + dlstTdsAcccode.ClientID + "," + txt3.ClientID + "," + txt1.ClientID + "," + txt2.ClientID + "," + payamt.ClientID + ")";
                txt2.Attributes.Add("onblur", myScript);


            }
    }

    protected void AddNewRow(object sender, EventArgs e)
    {
        string rowno;
        rowno = txtNoOfRows.Text;
        int i;

        for (i = 0; i < Int16.Parse(txtNoOfRows.Text); i++)
        {
            _dataSet.DebitVoucher.AddDebitVoucherRow("", "", "0", "");
        }
        BindGrid();
    }

    public void dg_totalDebit(object sender, EventArgs e)
    {
        UserControls_PaymentControl payment1 = (UserControls_PaymentControl)UCPayment;
        TextBox txtAmount = (TextBox)payment1.FindControl("txtAmount");

        double totalDebit = 0, debit = 0;
        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            if (gridrow.RowType == DataControlRowType.DataRow)
            {
                debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                totalDebit = totalDebit + debit;
                TextBox txtDebit = (TextBox)gridrow.FindControl("txtDebit");
            }
        }
        TextBox t1 = ((TextBox)dgGeneral.FooterRow.FindControl("txtTotalDebit"));
        t1.Text = Convert.ToString(totalDebit);


        t1.Attributes.Add("onchange", "javascript:return changePayment(this)");
        //txtAmount.Text = Convert.ToString(totalDebit);
    }

    public void cmdSubmit_Click(object sender, EventArgs e)
    {
            cmdSubmit.Enabled = false;
        
            bool success = false;
            string docNo = "";
            try
            {
                myFunc = new MyFunctions();
                AccountTrans AcctTrans = new AccountTrans();
                string Finyear = Session["FinYear"].ToString();
                string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
                if (CloseYear.Length == 1)
                    CloseYear = "0" + CloseYear;
                string yearSuffix = Session["YearVal"].ToString(); 

                UserControls_PaymentControl payment1 = (UserControls_PaymentControl)UCPayment;
                DropDownList dlsttranstype=(DropDownList)payment1.FindControl("dlstTransType");
                DropDownList dlstAcccode=(DropDownList)payment1.FindControl("dlstAcccode");
                TextBox  txtChqNo=(TextBox)payment1.FindControl("txtChqNo");
                TextBox  txtChqDate=(TextBox)payment1.FindControl("txtChqDate");
                TextBox txtAmount = (TextBox)payment1.FindControl("txtAmount");

                string loccode = Session["brcd"].ToString();

                
                if (dlsttranstype.Text == "CASH")
                {
                    SqlDataReader dtr;
                    Int32 intCASH_OPNDEBIT = 0;
                    Int32 intCASH_OPNCredit = 0;
                    string str="";
			        string openBalance="";
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



                    str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + fin_year + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + loccode + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + loccode + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + finyearstar + "',106) and convert(datetime,'" + myFunc.Mydate1(txtVoucherDate.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + fin_year + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + loccode + "' and ( acccategory='CASH' OR ((bkloccode like '%" + loccode + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
                    dtr = DAccess.getreader(str);
                    while (dtr.Read())
                    {
                        string CASH_OPNDEBIT = dtr["CASH_OPNDEBIT"].ToString();
                        intCASH_OPNDEBIT = intCASH_OPNDEBIT + Convert.ToInt32(dtr["CASH_OPNDEBIT"]);
                        string CASH_OPNCredit = dtr["CASH_OPNCredit"].ToString();
                        intCASH_OPNCredit = intCASH_OPNCredit + Convert.ToInt32(dtr["CASH_OPNCredit"]);
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
                   
                    double curr_val = Convert.ToDouble(txtAmount.Text);
                    double open_val = Convert.ToDouble(openBalance.Substring(0, openBalance.Length - 3));
                    string open_val_str = (openBalance.Substring(openBalance.Length - 3, 3)).Trim();
                    
                    if (open_val >= curr_val && open_val_str == "Dr")
                    {
                        //Hashtable myHT = new Hashtable();
                        //myHT.Add("", "");
                    }
                    else
                    {
                        string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                        Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                    }
                }

                //Response.End();
                AcctTrans.Voucherno = AcctTrans.genVoucherNo(Session["brcd"].ToString());
                int cnt_narration = 0;
                
                if (dlsttranstype.Text == "CASH")
                {
                    AcctTrans.Transtype = "CASH PAYMENT";
                    AcctTrans.Chqno = "";
                    AcctTrans.Chqdate = Convert.ToDateTime("01 Jan 1900");
                }
                else
                {
                    AcctTrans.Transtype = "BANK PAYMENT";
                    AcctTrans.Chqno = txtChqNo.Text;
                    AcctTrans.Chqdate = Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text));

                    ChequeDet chqTrans = new ChequeDet();

                    chqTrans.Chqno = txtChqNo.Text;
                    chqTrans.Acccode = dlstAcccode.SelectedValue;
                    chqTrans.Adjustamt = (float)Convert.ToDouble(txtAmount.Text.ToString()); 

                    chqTrans.Bankbrn = "";
                    chqTrans.Banknm = "";
                    chqTrans.Brcd = Session["brcd"].ToString();
                    chqTrans.Chq_bounce_dt = Convert.ToDateTime("01 Jan 1900");
                    chqTrans.Chq_bounceamt = 0;
                    chqTrans.Chq_clear = "N";
                    chqTrans.Chq_depattempt = 0;
                    chqTrans.Chq_flag = "";
                    chqTrans.Chq_reoffer_dt = Convert.ToDateTime("01 Jan 1900");
                    chqTrans.Chq_status = "SUBMITTED";
                    chqTrans.Chq_trf = "N";
                    chqTrans.Chqamt = (float)Convert.ToDouble(txtAmount.Text.ToString());
                    chqTrans.Chqdt = Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text)); ;
                    chqTrans.Comments = "";
                    chqTrans.Depoflag = "Y";
                    chqTrans.Empcd = Session["empcd"].ToString();
                    chqTrans.OwnCust = "O";
                    if ((txtCustCode.Text.ToString()).TrimEnd() != "")
                    {
                        chqTrans.Ptmsptcd = txtCustCode.Text.ToString();
                        chqTrans.Ptmsptnm = "";
                    }
                    else
                    {
                        chqTrans.Ptmsptcd = "";
                        chqTrans.Ptmsptnm = txtCustName.Text.ToString();
                    }
                    chqTrans.Recdbrcd = "";
                    chqTrans.Transdate = Convert.ToDateTime(myFunc.Mydate1(txtVoucherDate.Text));
                    chqTrans.Voucherno = AcctTrans.Voucherno;
                    chqTrans.Depoloccode = Session["brcd"].ToString();
                    chqTrans.InsertData();
                    chqTrans = null;
                }

                AcctTrans.Oppacccode = dlstAcccode.SelectedValue.Substring(0,7).ToString();
                AcctTrans.Oppaccount = AcctTrans.getAccountDesc(AcctTrans.Oppacccode);

                AcctTrans.DocNo = txtRefNo.Text.ToString();
                AcctTrans.Autoentry = "N";
                AcctTrans.Billdt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billduedt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billno = "";
                AcctTrans.Brcd = Session["brcd"].ToString();
                
                AcctTrans.Dockno = "";
                AcctTrans.Docksf = "";
                AcctTrans.DocNo = "";
                AcctTrans.Docsf = "";
                AcctTrans.Entryby = Session["empcd"].ToString();
                AcctTrans.Finyear = Finyear;
                AcctTrans.Opertitle = "Manual Debit Voucher";
               
                AcctTrans.Panno = "";
                AcctTrans.Payto = txtNarration.Text;
                AcctTrans.PBOV_TYP = "";
                AcctTrans.PBOV_CODE = "";
                AcctTrans.PBOV_NAME = "";

                if ((txtVendCode.Text.ToString()).TrimEnd() != "")
                {
                    AcctTrans.PBOV_TYP = "V";
                    AcctTrans.PBOV_CODE = txtVendCode.Text.ToString();
                    AcctTrans.PBOV_NAME = AcctTrans.getVendorDesc(txtVendCode.Text.ToString());
                }
                else if ((txtVendName.Text.ToString()).TrimEnd() != "")
                {
                    AcctTrans.PBOV_TYP = "V";
                    AcctTrans.PBOV_CODE = "8888";
                    AcctTrans.PBOV_NAME = txtVendName.Text.ToString();
                }
                else if ((txtCustCode.Text.ToString()).TrimEnd() != "")
                {
                    AcctTrans.PBOV_TYP = "C";
                    AcctTrans.PBOV_CODE = txtCustCode.Text.ToString();
                    AcctTrans.PBOV_NAME = AcctTrans.getCustomerDesc(txtCustCode.Text.ToString());
                }
                else if ((txtCustName.Text.ToString()).TrimEnd() != "")
                {
                    AcctTrans.PBOV_TYP = "C";
                    AcctTrans.PBOV_CODE = "8888";
                    AcctTrans.PBOV_NAME = txtCustName.Text.ToString();
                }


                AcctTrans.ServicetaxNo = "";
                AcctTrans.Transdate = Convert.ToDateTime(myFunc.Mydate1(txtVoucherDate.Text));
                AcctTrans.TransNo = 0;
                
                AcctTrans.UpdateBy = Session["empcd"].ToString();
                AcctTrans.Voucher_Cancel = "N";
                AcctTrans.Voucher_status = "Submitted";
                
                docNo = AcctTrans.Voucherno;
                AcctTrans.Bookcode = "";
                AcctTrans.YearSuffix = yearSuffix;
                AcctTrans.Entryfor = txtPrepareFor.Text.ToString();
                AcctTrans.PrepareByLoc = Session["brcd"].ToString();

                string mainAcccode = "";
                string mainAccdesc = "";

                // Debit the selected account in Gridview
                foreach (GridViewRow gridrow in dgGeneral.Rows)
                {
                    string acc_code_ecfy = "";
                     string accc = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccCode().ToString();
                     string cod = "select Acccode from webx_acctinfo where Company_Acccode='" + accc + "'";
                     conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                     dtr = DAccess.getreader(cod);
                     while (dtr.Read())
                     {
                         acc_code_ecfy = dtr["Acccode"].ToString().Trim();
                     }
                     dtr.Close();
                     conn.Close();
                     AcctTrans.Acccode = acc_code_ecfy;
                    if (gridrow.RowIndex == 0)
                    {
                        mainAcccode = AcctTrans.Acccode;
                        mainAccdesc = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccDesc().ToString();
                    }
                    AcctTrans.Credit = 0;
                    AcctTrans.Debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                    AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                    if (AcctTrans.Acccode != "")
                    {
                        AcctTrans.InsertData();
                    }
                }
                UserControls_TDSPayment tds1 = (UserControls_TDSPayment)UCTDSPayment;

                DropDownList dlstTdsAcccode = (DropDownList)tds1.FindControl("dlstTdsAcccode");
                TextBox txtTdsRate = (TextBox)tds1.FindControl("txtTdsRate");
                TextBox txtTdsAmt = (TextBox)tds1.FindControl("txtTdsAmt");
                double tdsrate = Convert.ToDouble(txtTdsRate.Text);
                double tdsamt = Convert.ToDouble(txtTdsAmt.Text);
                AcctTrans.Acccode = dlstTdsAcccode.SelectedValue.ToString();
                AcctTrans.Credit = Convert.ToDouble(txtTdsAmt.Text.ToString());
                AcctTrans.Debit = 0;
                AcctTrans.Narration ="TDS Deducted For Debit Voucher";
                if (AcctTrans.Acccode != "")
                {
                    AcctTrans.InsertData();
                }
                foreach (GridViewRow gridrow in dgGeneral.Rows)
                {
                    cnt_narration = cnt_narration + 1;
                    if (cnt_narration == 1)
                    {
                        AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                    }
                }
                AcctTrans.Acccode = dlstAcccode.SelectedValue.ToString();
                AcctTrans.Credit = Convert.ToDouble(txtAmount.Text.ToString());
                AcctTrans.Debit = 0;
                AcctTrans.Oppacccode = mainAcccode;
                AcctTrans.Oppaccount = mainAccdesc;
                //AcctTrans.Narration = "";
                if (AcctTrans.Acccode != "")
                {
                    AcctTrans.InsertData();
                }
                //end here        
               
                success = true;
                AcctTrans = null;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                Response.End();
            }
            finally
            {

            }
            if (success)
                cmdSubmit.Enabled = true;
                Response.Redirect("./voucher_Done.aspx?VoucherType=Debit&VoucherNo=" + docNo, false);
        }
    }


