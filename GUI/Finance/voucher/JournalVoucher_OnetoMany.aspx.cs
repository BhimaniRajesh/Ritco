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

public partial class GUI_finance_voucher_JournalVoucher_OnetoMany : System.Web.UI.Page
{
    public DataSet_Templates _dataSet = new DataSet_Templates();
    string connStr;
    int _lastEditedPage;
    MyFunctions myFunc;
    SqlDataReader dtr;
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

        //LinkButton1.Attributes.Add("onClick", "javascript:window.open('../../../GUI/Admin/commonPopUp.aspx?ctrCodeName=" + txtManualNo.ClientID + "&ctrDescName=" + txtManualNo.ClientID + "',null,'height=250, width=250,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");
        string aa = "javascript:return valid()";
        cmdSubmit.Attributes.Add("onClick", aa);

        if (!IsPostBack)
        {
            ///////////////////////////////Need To Change Start//////////////////////////////////////////////////////
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
            cmdctrpopup.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=3&ctrCodeName=" + txtCustCode.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");
            cmdctrpopup1.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=2&ctrCodeName=" + txtVendCode.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");
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


            // txtPrepareFor.Attributes.Add("onblur","javascript:if("+strEmpid+".indexOf(document.getElementById('txtPrepareFor').value)==-1) { alert('Please enter proper employee code!!!);document.getElementById('txtPrepareFor').focus();");
            //string maxValue, minValue;
            //maxValue = DateTime.Now.ToString("dd MMM yyyy");
            //if (Convert.ToDateTime(Session["FinYearEnd"].ToString()) <= Convert.ToDateTime(maxValue))
            //{
            //    maxValue = Session["FinYearEnd"].ToString();
            //    minValue = Session["FinYearStart"].ToString();
            //}
            //else
            //{
            //    maxValue = DateTime.Now.ToString("dd MMM yyyy");
            //    minValue = Session["FinYearStart"].ToString();
            //}
            //RangeVoucherDate.MinimumValue = minValue;
            //RangeVoucherDate.MaximumValue = maxValue;

        }
    }
    private void Initialised()
    {
        _dataSet.Journal.AddJournalRow("", "", "0", "0", "");
        _dataSet.Journal.AddJournalRow("", "", "0", "0", "");
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
    private void ReverseBind()
    {
        DataSet_Templates.JournalRow _datarow;
        string mAcccode, mAccdesc;

        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            _datarow = _dataSet.Journal[gridrow.DataItemIndex];
            UserControls_WebUserControl UCAccount = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode"));

            mAcccode = UCAccount.AccCode;
            if (mAcccode == null)
                mAcccode = "";
            mAccdesc = UCAccount.AccDesc;
            if (mAccdesc == null)
                mAccdesc = "";

            // mAccdesc = UCAccount.AccDesc;
            _datarow.Acccode = mAcccode;//'UCAccount.AccCode;
            _datarow.Accdesc = mAccdesc;// UCAccount.AccDesc;
            _datarow.Debit = ((TextBox)gridrow.FindControl("txtDebit")).Text;
            _datarow.Credit = ((TextBox)gridrow.FindControl("txtCredit")).Text;
            _datarow.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text;
            _dataSet.Journal[gridrow.DataItemIndex].ItemArray = _datarow.ItemArray;
        }
        //BindGrid();
    }
    private void BindGrid()
    {
        dgGeneral.DataSource = _dataSet.Journal;
        dgGeneral.DataBind();
    }

    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //BindGrid();
    }

    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtDebit = (TextBox)e.Row.FindControl("txtDebit");
            TextBox txtCredit = (TextBox)e.Row.FindControl("txtCredit");
            txtCredit.Attributes.Add("onblur", "javascript:if((parseInt(document.getElementById('" + txtDebit.ClientID + "').value)>0)&&(parseInt(document.getElementById('" + txtCredit.ClientID + "').value)>0)) { alert('Either Debit or Credit  should be greater than zero!!!') ;document.getElementById('" + txtCredit.ClientID + "').focus();return;}");
        }
       
    }

    protected void AddNewRow(object sender, EventArgs e)
    {
        string rowno;
        rowno = txtNoOfRows.Text;
        int i;

        for (i = 0; i < Int16.Parse(txtNoOfRows.Text); i++)
        {
            _dataSet.Journal.AddJournalRow("", "", "0", "0", "");
        }
        BindGrid();
    }
    public void dg_totalCredit(object sender, EventArgs e)
    {
        double totalCredit = 0, credit = 0;
        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            if (gridrow.RowType == DataControlRowType.DataRow)
            {
                credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                totalCredit = totalCredit + credit;
            }
        }
        TextBox t1 = ((TextBox)dgGeneral.FooterRow.FindControl("txtTotalCredit"));
        t1.Text = Convert.ToString(totalCredit);
    }
    public void dg_totalDebit(object sender, EventArgs e)
    {
        double totalDebit = 0, debit = 0;
        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            if (gridrow.RowType == DataControlRowType.DataRow)
            {
                debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                totalDebit = totalDebit + debit;
            }
        }
        TextBox t1 = ((TextBox)dgGeneral.FooterRow.FindControl("txtTotalDebit"));
        t1.Text = Convert.ToString(totalDebit);
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
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
                string yearSuffix = Session["FinYear"].ToString() + "_" + CloseYear;
                AcctTrans.DocNo = txtRefNo.Text.ToString();
                AcctTrans.Autoentry = "N";
                AcctTrans.Billdt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billduedt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billno = "";
                AcctTrans.Brcd = Session["brcd"].ToString();
                AcctTrans.Chqno = "";
                AcctTrans.Chqdate = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Dockno = "";
                AcctTrans.Docksf = "";
                AcctTrans.DocNo = "";
                AcctTrans.Docsf = "";
                AcctTrans.Entryby = Session["empcd"].ToString();
                AcctTrans.Finyear = Finyear;
                AcctTrans.Opertitle = "Manual Voucher";
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
                AcctTrans.Transdate = Convert.ToDateTime(myFunc.Mydate1(txtVoucherDate.Text));
                AcctTrans.TransNo = 0;
                AcctTrans.Transtype = "Journal";
                AcctTrans.UpdateBy = Session["empcd"].ToString();
                AcctTrans.Voucher_Cancel = "N";
                AcctTrans.Voucher_status = "Submitted";
                AcctTrans.Voucherno = AcctTrans.genVoucherNo(Session["brcd"].ToString());
                docNo = AcctTrans.Voucherno;
                AcctTrans.Bookcode = "";
                AcctTrans.YearSuffix = yearSuffix;
                AcctTrans.Entryfor = txtPrepareFor.Text.ToString();
                AcctTrans.PrepareByLoc = Session["brcd"].ToString();


                AcctTrans.Oppacccode = "";
                AcctTrans.Oppaccount = "";
                int i = 0;
                string mainAcccode = "",mainAccdesc = "";
                foreach (GridViewRow gridrow in dgGeneral.Rows)
                {
                    if (i == 0)
                    {
                        AcctTrans.Acccode = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccCode().ToString();
                        mainAcccode = AcctTrans.Acccode;
                        mainAccdesc = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccDesc().ToString();

                        AcctTrans.Credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                        AcctTrans.Debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                        AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                       
                    }
                    else
                    {
                        if (i == 1)
                        {
                            AcctTrans.Oppacccode = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccCode().ToString();
                            AcctTrans.Oppaccount = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccDesc().ToString();
                            AcctTrans.InsertData();
                            AcctTrans.Acccode = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccCode().ToString();

                            AcctTrans.Oppacccode = mainAcccode;
                            AcctTrans.Oppaccount = mainAccdesc;

                            AcctTrans.Credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                            AcctTrans.Debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                            AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                            AcctTrans.InsertData();
                        }
                        else
                        {
                            AcctTrans.Acccode = ((UserControls_WebUserControl)gridrow.FindControl("txtAcccode")).getAccCode().ToString();
                            
                            AcctTrans.Oppacccode = mainAcccode;
                            AcctTrans.Oppaccount = mainAccdesc;

                            AcctTrans.Credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                            AcctTrans.Debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                            AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                            AcctTrans.InsertData();
                        }
                    }
                    i += 1;

                }
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
                Response.Redirect("./voucher_Done.aspx?VoucherType=Journal(O)&VoucherNo=" + docNo, true);
        }
    }
}
