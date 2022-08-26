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

public partial class GUI_finance_voucher_CreditVoucher : System.Web.UI.Page
{
    public DataSet_Templates _dataSet = new DataSet_Templates();
    DateFunction DFun = new DateFunction();
    string connStr;
    int _lastEditedPage;
    MyFunctions myFunc;
    SqlDataReader dtr;
    AccountTrans AcctTrans = new AccountTrans();
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        connStr = Session["SqlProvider"].ToString().Trim();
        string strEmpid = "";
        //AccountTrans trans = new AccountTrans();
        //string vchrno = trans.genVoucherNo("HQTR");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        UserControls_ReceiptControl paymen = (UserControls_ReceiptControl)UCReceipt;
        DropDownList dlsttranstype = (DropDownList)paymen.FindControl("dlstTransType");
        TextBox txtChqNo = (TextBox)paymen.FindControl("txtChqNo");
        TextBox txtChqDate = (TextBox)paymen.FindControl("txtChqDate");
        TextBox txtAmount = (TextBox)paymen.FindControl("txtAmount");
        string aa = "javascript:return valid(this," + txtAmount.ClientID + "," + dlsttranstype.ClientID + "," + txtChqNo.ClientID + "," + txtChqDate.ClientID + ")";
        cmdSubmit.Attributes.Add("onClick", aa);

        
        txtAmount.Attributes.Add("onFocus", "javascript:return changeFocus(this)");

        if (!IsPostBack)
        {
            ///////////////////////////////Need To Change Start//////////////////////////////////////////////////////\
            
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
            string codename = "";
            //(pbov_code + ':' + pbov_name) as pbov_name
            string str_empname = "select (EmpId + ':' + Name) as Name from webx_master_users with (NOLOCK) where UserId='" + Session["empcd"].ToString() + "' and Status='100'";
            dtr = DAccess.getreader(str_empname);
            while (dtr.Read())
            {
                codename = dtr["name"].ToString().Trim();
            }
            dtr.Close();
            lblPrepareBy.Text = codename;
            ///////////////////////////////Need To Change End//////////////////////////////////////////////////////

            Initialised();
            BindGrid();
            lblPrepareAt.Text = Session["brcd"].ToString();
            //lblPrepareBy.Text = Session["empcd"].ToString();
            txtVoucherDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

            cmdctrpopup.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=3&ctrCodeName=" + txtCustCode.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=yes, toolbar=no,location=no,menubar=no ');");
            cmdctrpopup1.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=2&ctrCodeName=" + txtVendCode.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=yes, toolbar=no,location=no,menubar=no ');");

            string sql = "select EmpId from webx_master_users with (NOLOCK) where Status='100'";
            SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            while (rdr.Read())
            {
                if (strEmpid == "")
                    strEmpid = rdr["EmpId"].ToString();
                else
                    strEmpid = strEmpid + "," + rdr["EmpId"].ToString();
            }
            rdr.Close();

            string myScript = " javascript : var strempcd='" + strEmpid + "'; if ( strempcd.indexOf(document.getElementById('" + txtPrepareFor.ClientID + "').value)==-1)" +
                     "   { " +
                     " alert('The Employee does not belong to this location, please check !!!');document.getElementById('" + txtPrepareFor.ClientID + "').focus();return;}";

            txtPrepareFor.Attributes.Add("onBlur", myScript);

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
           // txtVoucherDate.Attributes.Add("onblur", "javascript:" + myFunc.getDateValidateString(txtVoucherDate, minValue, maxValue));


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
            //txtPrepareFor.Attributes.Add("OnBlur", strjs);
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
                    //error.Visible = false;
                    break;
                }
                else
                {
                    flag = "Y";
                }
            }
            if (flag == "Y")
            {
                //error.Visible = true;
                //error.Text = "'Invalid Location !!!'";
            }
            else
            {
                //error.Visible = false;
            }
        }
    }
    private void Initialised()
    {
        _dataSet.CreditVoucher.AddCreditVoucherRow("", "", "0", "");
        _dataSet.CreditVoucher.AddCreditVoucherRow("", "", "0", "");
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
        dgGeneral.DataSource = _dataSet.CreditVoucher;
        dgGeneral.DataBind();
    }

    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //BindGrid();
    }

    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txt1 = ((TextBox)e.Row.FindControl("txtTotalCredit"));

            UserControls_TDSPayment tds1 = (UserControls_TDSPayment)UCTDSPayment;
            UserControls_ReceiptControl payment1 = (UserControls_ReceiptControl)UCReceipt;
            TextBox txt2 = (TextBox)tds1.FindControl("txtTdsRate");
            TextBox txt3 = (TextBox)tds1.FindControl("txtTdsAmt");
            DropDownList dlstTdsAcccode = (DropDownList)tds1.FindControl("dlstTdsAcccode");
            TextBox payamt = (TextBox)payment1.FindControl("txtAmount");
            //string myScript = "javascript:document.getElementById('" + txt3.ClientID + "').value=parseFloat(document.getElementById('" + txt1.ClientID + "').value)*(parseFloat(document.getElementById('" + txt2.ClientID + "').value)/100);" +
            //                  " document.getElementById('" + payamt.ClientID + "').value=parseFloat(document.getElementById('" + txt1.ClientID + "').value)-parseFloat(document.getElementById('" + txt3.ClientID + "').value)";
            //txt2.Attributes.Add("onblur", myScript);
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
            _dataSet.CreditVoucher.AddCreditVoucherRow("", "", "0", "");
        }
        BindGrid();
    }

    public void dg_totalCredit(object sender, EventArgs e)
    {
        double totalCredit = 0, Credit = 0;
        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            if (gridrow.RowType == DataControlRowType.DataRow)
            {
                Credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                totalCredit = totalCredit + Credit;
            }
        }
        TextBox t1 = ((TextBox)dgGeneral.FooterRow.FindControl("txtTotalCredit"));
        t1.Text = Convert.ToString(totalCredit);
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        UserControls_ReceiptControl payment1 = (UserControls_ReceiptControl)UCReceipt;
        DropDownList dlsttranstype = (DropDownList)payment1.FindControl("dlstTransType");
        DataAccess DAccess = new DataAccess();
        myFunc = new MyFunctions();
        string Accdesc = "";
        string yearval = "";
        string Finyear = "";
        string strStartVal = "", strEndVal = "";
        DropDownList dlFinYear = (DropDownList)Master.FindControl("dlstFinYear");
        if (dlFinYear != null)
        {
            yearval = dlFinYear.SelectedItem.Text;
        }
        string info1 = yearval;
        string[] arInfo1 = new string[1];
        char[] splitter1 = { '-' };
        arInfo1 = info1.Split(splitter1);
        for (int x1 = 0; x1 < arInfo1.Length; x1++)
        {
            strStartVal = arInfo1[0];
            strEndVal = arInfo1[1];
        }
        Finyear = strStartVal;
        //string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
        //if (CloseYear.Length == 1)
        //    CloseYear = "0" + CloseYear;
        string yearSuffix = strEndVal; //Session["FinYear"].ToString() + "_" + CloseYear;
        if (Page.IsValid)
        {
            string Acccode = "";
            //string Accdesc = "";
            string mainAcccode = "";
            string mainAccdesc = "";
            bool success = false;
            string docNo = "";
            try
            {
                string voucher_no = AcctTrans.genVoucherNo(Session["brcd"].ToString());
                string cashAcccode = AcctTrans.getControlAcccode(dlsttranstype.SelectedItem.Text);
                //string chequeAcccode = "";
                TextBox txtChqNo = (TextBox)payment1.FindControl("txtChqNo");
                TextBox txtChqDate = (TextBox)payment1.FindControl("txtChqDate");
                TextBox txtAmount = (TextBox)payment1.FindControl("txtAmount");
                TextBox txtBanknm = (TextBox)payment1.FindControl("txtBanknm");
                TextBox txtBranchnm = (TextBox)payment1.FindControl("txtBranchnm");
                string chequeAcccode = "ACA0002";
                string chequeAccdesc = "";
                string str1 = "select Acccode,Accdesc from WebX_acctinfo where accdesc='CHEQUES IN HAND'";
                dtr = DAccess.getreader(str1);
                while (dtr.Read())
                {
                    Acccode = dtr["Acccode"].ToString();
                }
                dtr.Close();
                //Hardcode Cheque Account code. this process is wrong;
                string str2 = "select Accdesc from WebX_acctinfo where Acccode='" + chequeAcccode + "'";
                dtr = DAccess.getreader(str1);
                while (dtr.Read())
                {
                    chequeAccdesc = dtr["Accdesc"].ToString();
                }
                dtr.Close();
                if (dlsttranstype.Text == "CASH")
                {
                    AcctTrans.Transtype = "CASH RECIEPT";
                    AcctTrans.Chqno = "";
                    AcctTrans.Chqdate = Convert.ToDateTime("01 Jan 1900");
                    AcctTrans.Oppacccode = cashAcccode;
                }
                else
                {
                    AcctTrans.Transtype = "BANK RECIEPT";
                    AcctTrans.Chqno = txtChqNo.Text;
                    DateTime dt =  Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text));
                    AcctTrans.Chqdate = dt;
                    AcctTrans.Oppacccode = chequeAcccode;// dlstAcccode.SelectedValue.Substring(0, 7).ToString();
                    ChequeDet chqTrans = new ChequeDet();

                    chqTrans.Chqno = txtChqNo.Text;
                    chqTrans.Acccode = "";
                    chqTrans.Adjustamt = (float)Convert.ToDouble(txtAmount.Text.ToString());

                    chqTrans.Bankbrn = txtBranchnm.Text;
                    chqTrans.Banknm = txtBanknm.Text;
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
                    DateTime dt1 = Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text));
                    chqTrans.Chqdt = dt1;// Convert.ToDateTime(txtChqDate.Text);
                    chqTrans.Comments = "";
                    chqTrans.Depoflag = "N";
                    chqTrans.Empcd = Session["empcd"].ToString();
                    chqTrans.OwnCust = "C";
                    ///////////////////////////////////////////////////////////////////////////////////
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
                    ///////////////////////////////////////////////////////////////////////////////////
                    //chqTrans.Ptmsptcd = txtCustCode.Text;
                    //chqTrans.Ptmsptnm = "";
                    chqTrans.Recdbrcd = "";
                    chqTrans.Transdate = Convert.ToDateTime("01 Jan 1900");
                    chqTrans.Voucherno = voucher_no; 
                    chqTrans.Depoloccode = "";
                    
                    chqTrans.InsertData();
                    chqTrans = null;

                }
                AcctTrans.Oppaccount = AcctTrans.getAccountDesc(AcctTrans.Oppacccode);

                AcctTrans.DocNo = txtRefNo.Text.ToString();
                AcctTrans.Autoentry = "N";
                AcctTrans.Billdt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billduedt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billno = "";
                AcctTrans.Brcd = Session["brcd"].ToString();
                //AcctTrans.ReceivedFrom =;
                AcctTrans.Dockno = "";
                AcctTrans.Docksf = "";
                AcctTrans.DocNo = "";
                AcctTrans.Docsf = "";
                AcctTrans.Entryby = Session["empcd"].ToString();
                AcctTrans.Finyear = Finyear;
                AcctTrans.Opertitle = "Manual Credit Voucher";

                AcctTrans.Panno = "";
                AcctTrans.Payto = "";
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
                AcctTrans.Transdate = Convert.ToDateTime(DFun.return_date(txtVoucherDate.Text));
                AcctTrans.TransNo = 0;

                AcctTrans.UpdateBy = Session["empcd"].ToString();
                AcctTrans.Voucher_Cancel = "N";
                AcctTrans.Voucher_status = "Submitted";
                AcctTrans.Voucherno = voucher_no;//AcctTrans.genVoucherNo(Session["brcd"].ToString());
                docNo = AcctTrans.Voucherno;
                AcctTrans.Bookcode = "";
                AcctTrans.YearSuffix = yearSuffix;
                AcctTrans.Entryfor = txtPrepareFor.Text.ToString();
                AcctTrans.PrepareByLoc = Session["brcd"].ToString();
                
                foreach (GridViewRow gridrow in dgGeneral.Rows)
                {

                    Acccode = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccCode().ToString();
                    string str = "select Accdesc from webx_acctinfo where Acccode='" + Acccode  + "'";
                    dtr = DAccess.getreader(str);
                    while (dtr.Read())
                    {
                        Accdesc = dtr["Accdesc"].ToString();
                    }
                    dtr.Close();
                   
                    if (gridrow.RowIndex == 0)
                    {
                        mainAcccode =Acccode;
                        mainAccdesc = Accdesc;
                        AcctTrans.Acccode = Acccode;
                    }
                   
                    AcctTrans.Debit = 0;
                    AcctTrans.Credit =Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                    string Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                    if (Narration != null)
                    {
                        AcctTrans.Narration = Narration;
                    }
                    else
                    {
                        AcctTrans.Narration = "";
                    }
                    if (Acccode != "")
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
                AcctTrans.Debit = Convert.ToDouble(txtTdsAmt.Text.ToString());
                AcctTrans.Credit = 0;
                AcctTrans.Narration = "TDS Deducted For Credit Voucher";
                if (AcctTrans.Acccode != "")
                {
                    AcctTrans.InsertData();
                }
                //end here    
                //bank and cash account Debit start here 
                int cnt_narration=0;
                foreach (GridViewRow gridrow in dgGeneral.Rows)
                {
                    cnt_narration = cnt_narration + 1;
                    if (cnt_narration == 1)
                    {
                        AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                    }
                }
                AcctTrans.Acccode = AcctTrans.Oppacccode;// "";//dlstAcccode.SelectedValue.ToString();
                AcctTrans.Debit = Convert.ToDouble(txtAmount.Text.ToString());
                AcctTrans.Credit = 0;
                //AcctTrans.Narration = txtNarration.Text;
                AcctTrans.Oppacccode = mainAcccode;
                AcctTrans.Oppaccount = mainAccdesc;
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
                Response.Redirect("./voucher_Done.aspx?VoucherType=Credit&VoucherNo=" + docNo, false);
        }
    }
}
