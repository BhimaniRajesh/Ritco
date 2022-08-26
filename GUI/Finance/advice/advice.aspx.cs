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

public partial class GUI_finance_advice_advice : System.Web.UI.Page
{
    MyFunctions myFunc;
    string connStr;
    Advice adv = new Advice();
    SqlDataReader dtr;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        connStr = Session["SqlProvider"].ToString().Trim();
        //AccountTrans trans = new AccountTrans();
        //string vchrno = trans.genVoucherNo("HQTR");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        cmdSubmit.Attributes.Add("onclick", "javascript:return check()");
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
            //Label1.Text = Session["brcd"].ToString().Trim();
            //txtPrepareFor.MaxLength = Convert.ToInt16(FieldLengthMax);
            string codename = "";

            string str_empname = "select (EmpId + ':' + Name) as Name from webx_master_users with (NOLOCK) where UserId='" + Session["empcd"].ToString() + "' and Status='100'";
            dtr = DAccess.getreader(str_empname);
            while (dtr.Read())
            {
                codename = dtr["name"].ToString().Trim();
            }
            dtr.Close();
            lblGenerateBy.Text = codename;
            ///////////////////////////////Need To Change End//////////////////////////////////////////////////////

            error.Visible = false;
            lblRaisedBy.Text = Session["brcd"].ToString();
            //lblGenerateBy.Text = Session["empcd"].ToString();

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
            txtAdviceDate.Text = maxValue.ToString();
            //txtAdviceDate.Attributes.Add("onblur", "javascript:" + myFunc.getDateValidateString(txtAdviceDate, minValue, maxValue));
            //cmdctrpopup.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=4&ctrCodeName=" + txtRaisedOn.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");
            
            //string validlocations = adv.getValidLocation();

            string strjs = "Javascript : myFunc (this)";
            txtRaisedOn.Attributes.Add("OnBlur", strjs);


        }
    }

    public void Valid_Location(object sender, EventArgs e)
    {
        string validlocations = adv.getValidLocation();

        if (validlocations != "")
        {
            string flag = "N";
            string loc = validlocations;
            string[] arLocation = new string[0];
            char[] split_arLocation = { ',' };
            arLocation = loc.Split(split_arLocation);

            for (int x = 0; x < arLocation.Length; x++)
            {
                string tempLoc = arLocation[x];
                if (tempLoc == txtRaisedOn.Text)
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
                error.Text = "'Invalid Location !!!'";
            }
            else
            {
                error.Visible = false;
            }
        }
    }
    
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bool success = false;
            string docNo = "";
            string docType = "";
            
            UserControls_PaymentControl_1 payment1 = (UserControls_PaymentControl_1)UCPayment;
            DropDownList dlsttranstype = (DropDownList)payment1.FindControl("dlstTransType");
            DropDownList dlstAcccode = (DropDownList)payment1.FindControl("dlstAcccode");
            TextBox txtChqNo = (TextBox)payment1.FindControl("txtChqNo");
            TextBox txtChqDate = (TextBox)payment1.FindControl("txtChqDate");
            TextBox txtAmount = (TextBox)payment1.FindControl("txtAmount");
            myFunc = new MyFunctions();

            AccountTrans acctrans = new AccountTrans();
            string cashAcccode = "";
            cashAcccode = acctrans.getControlAcccode(dlsttranstype.SelectedItem.Text);
            string IBTAcccode = "";
            IBTAcccode = acctrans.getIBTControlAcccode("IBT0002");
            
            if ((dlsttranstype.SelectedValue == "CASH") && (dlstAdviceType.SelectedValue == "D"))
            {
                string Finyear = Session["FinYear"].ToString();
                string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
                if (CloseYear.Length == 1)
                    CloseYear = "0" + CloseYear;
                string yearSuffix = Session["YearVal"].ToString();



                DataAccess DAccess = new DataAccess();
                SqlDataReader dtr;
                Int32 intCASH_OPNDEBIT = 0;
                Int32 intCASH_OPNCredit = 0;
                string str = "";
                string openBalance = "";
                string loccode = Session["brcd"].ToString();
                str = "select BANK_OPNDEBIT=isNull(sum(case when acccategory='BANK' then debit else 0 end),0.00),BANK_OPNCredit=isNull(sum(case when acccategory='BANK' then credit else 0 end),0.00),CASH_OPNDEBIT=isNull(sum(case when acccategory='CASH' then debit else 0 end),0.00),CASH_OPNCredit=isNull(sum(case when acccategory='CASH' then credit else 0 end),0.00) from webx_acctrans_" + yearSuffix + " M,webx_acctinfo D where m.acccode=d.acccode and ( acccategory='CASH' OR ((bkloccode like '%" + loccode + "%' or bkloccode='ALL' ) AND acccategory='BANK')) and m.brcd='" + loccode + "' and Voucher_cancel='N' And convert(varchar,transdate,106) between Convert(datetime,'" + Session["FinYearStart"].ToString() + "',106) and convert(datetime,'" + myFunc.Mydate1(txtAdviceDate.Text) + "',106) Union select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from webx_acctinfo D with(NOLOCK) left outer join webx_acctopening_" + yearSuffix + "  o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + loccode + "' and ( acccategory='CASH' OR ((bkloccode like '%" + loccode + "%' or bkloccode='ALL' ) AND acccategory='BANK'))";
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

                //string openBalance = acctrans.getOpeningBalance(cashAcccode, Session["FinYearStart"].ToString(), myFunc.Mydate1(txtAdviceDate.Text), Session["brcd"].ToString(), "webx_acctopening_" + yearSuffix, "webx_acctrans_" + yearSuffix, "Y");
                //string openBal = acctrans.getOpeningBalance_onlyValue(cashAcccode, Session["FinYearStart"].ToString(), myFunc.Mydate1(txtAdviceDate.Text), Session["brcd"].ToString(), "webx_acctopening_" + yearSuffix, "webx_acctrans_" + yearSuffix, "Y");
                //double intopenBalance = Convert.ToDouble(openBalance);
                double open_val = Convert.ToDouble(openBalance.Substring(0, openBalance.Length - 3));
                string open_val_str = (openBalance.Substring(openBalance.Length - 3, 3)).Trim();
                if (open_val_str == "Dr")  
                {
                }
                else
                {
                    //string ErrorMsg = "Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location " + Session["brcd"].ToString();
                   // Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Fund Transfer" + "&ErrorMsg=" + ErrorMsg);
                }
            }

            acctrans = null;
            try
            {
                Advice adv = new Advice();

                //  Modified by DP - 29/12/2007
                //string Finyear = "20" + Session["FinYear"].ToString();

                string Finyear = "";
                if ((DropDownList)Master.FindControl("dlstFinYear") != null)
                    Finyear = ((DropDownList)Master.FindControl("dlstFinYear")).SelectedItem.Text.Substring(0,4);

                //  Modified by DP - 29/12/2007
                //string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
                string CloseYear = Convert.ToString((Convert.ToInt16(Finyear) + 1));

                if (CloseYear.Length == 1) CloseYear = "0" + CloseYear;

                //  Modified by DP - 29/12/2007
                //string yearSuffix = Session["FinYear"].ToString() + "_" + CloseYear;
                string yearSuffix = Finyear + "_" + CloseYear;
                
                adv.AdviceNo = adv.genAdviceNo(Session["brcd"].ToString().ToUpper(), Finyear);
                adv.Credit_account = dlsttranstype.Text;
                adv.FromAcccode = dlstAcccode.SelectedValue.Substring(0, 7);
                adv.RaiseAcccode = IBTAcccode;
                adv.RaisedBy = lblRaisedBy.Text;
                adv.RaisedOn = txtRaisedOn.Text;
                adv.Reason = txtReason.Text.Replace("'","''");
                adv.RecvLocCd = "";
                adv.SendLocCd = lblRaisedBy.Text;
                adv.ToAcccode = "";
                adv.Finyear = Finyear;
                adv.Entryby = lblGenerateBy.Text;
                adv.Enclosed = txtEnclosedDoc.Text.Replace("'", "''");
                adv.Adjusted_amount = Convert.ToDouble(txtAmount.Text);
                adv.Advice_amount = Convert.ToDouble(txtAmount.Text);
                adv.AdvGenByCd = Session["empcd"].ToString();
                adv.Advice_Cancel="N";
                adv.AdviceDt = Convert.ToDateTime(myFunc.Mydate1(txtAdviceDate.Text));
                adv.AdviceStatus = "SUBMITTED";
                adv.AdviceType = dlstAdviceType.SelectedValue;
                adv.AgainstAdviceNo = "";
                adv.AdvApprBrCd = Session["brcd"].ToString();
                adv.AdvApprByCd = Session["empcd"].ToString();
                
                docNo=adv.AdviceNo;
                docType = dlstAdviceType.SelectedValue;

                adv.AdvApprDt = adv.AdviceDt;

                if (dlsttranstype.Text == "BANK")
                {
                    Billchqdetail chqdet = new Billchqdetail();

                    chqdet.Bankbrn = "";
                    chqdet.Bankcd = adv.FromAcccode;
                    chqdet.Banknm="";
                    chqdet.ChkAcct = "N";
                    chqdet.Chqamt = adv.Advice_amount;
                    chqdet.Clamt = adv.Advice_amount;
                    chqdet.DocNo = adv.AdviceNo;
                    chqdet.DocSf=".";
                    chqdet.DocType = dlstAdviceType.SelectedValue;
                    chqdet.Chqno = txtChqNo.Text; 
                    chqdet.Chqdt=Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text));
                    chqdet.Transfor = "Advice";
                    chqdet.InsertData();
                    chqdet = null;

                    ChequeDet chqTrans = new ChequeDet();

                    chqTrans.Chqno = txtChqNo.Text;
                    chqTrans.Acccode = adv.FromAcccode;
                    chqTrans.Adjustamt = (float)adv.Advice_amount;

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
                    chqTrans.Chqamt = (float)adv.Advice_amount;
                    chqTrans.Chqdt = Convert.ToDateTime(myFunc.Mydate1(txtChqDate.Text)); ;
                    chqTrans.Comments = "";
                    chqTrans.Depoflag = "Y";
                    chqTrans.Empcd = Session["empcd"].ToString();
                    chqTrans.OwnCust = "O";
                    chqTrans.Ptmsptcd = "";
                    chqTrans.Ptmsptnm = "";
                    chqTrans.Recdbrcd = "";
                    chqTrans.Transdate = Convert.ToDateTime(myFunc.Mydate1(txtAdviceDate.Text));
                    chqTrans.Voucherno = "";
                    chqTrans.Depoloccode = Session["brcd"].ToString();
                    chqTrans.InsertData();
                    chqTrans = null;
                }

                adv.InsertData();
                success = true;
            }
            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                Response.End();
            }
            finally
            {

            }
            
            
                Server.Transfer("./advice_Done.aspx?AdviceNo=" + docNo + "&AdviceType=" + docType, false);
        }
    }
}
