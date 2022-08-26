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

public partial class GUI_UNI_MIS_accounts_mis_subsidiary_ledger_Result : System.Web.UI.Page
{
    string sqlDet, sql;
    DateFunction DAccess = new DateFunction();
    public DataSet1 _dataSet = new DataSet1();
    SqlDataReader dtr;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string branchText = Request.QueryString["branchText"];
        string branch = Request.QueryString["branch"];
        string mindividual = Request.QueryString["strdlstTranType"].ToString();
        string mTodt = Request.QueryString["dateFrom"];
        string mClosedt = Request.QueryString["dateTo"];
        // Request.QueryString["strdlstSalesAmount"];
        string mAcctTransTable = "webx_acctrans_" + Session["YearVal"].ToString();
        string mAcctTable = "webx_acctinfo";
        string mGroupTable = "webx_groups";
        string mAcctOpenTable = "webx_acctopening_" + Session["YearVal"].ToString();
        string ledgerof = Request.QueryString["ledgerof"].ToString();
        if (ledgerof == "C")
        {
            Label4.Text = "Customer";
            string acccode = "CDA0001";
            string mdateDetCls = " and convert(varchar,t.transdate,106) between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + mClosedt + "',106)";
            string sssql = "select acccode,accdesc from webx_acctinfo where acccode='" + acccode + "'";
            string cust_code = Request.QueryString["cust_code"].ToString();
            conn.Open();
            string straccdesc = "";
            dtr = DAccess.getreader(sssql);
            while (dtr.Read())
            {
                straccdesc = dtr["accdesc"].ToString();
            }
            dtr.Close();
            conn.Close();
            string custName = "";
            string custo = "SELECT  distinct CUSTCD,CUSTNM  FROM webx_CUSTHDR  where CUSTCD='" + cust_code + "'";
            conn.Open();
            dtr = DAccess.getreader(custo);
            while (dtr.Read())
            {
                custName = dtr["CUSTNM"].ToString();
            }
            dtr.Close();
            conn.Close();

            string strSalesAccountText = straccdesc;
            string tranType;

            if (mindividual == "Y")
            {
                tranType = "(Individual)";
            }
            else
            {
                tranType = "(Cumulative)";
            }
            lblBran.Text = branchText + " " + tranType;
            lblDate_Range.Text = mTodt + " " + "-" + " " + mClosedt;
            lblAccount.Text = strSalesAccountText;
            lblCustomer.Text = custName + " " + ":" + " " + cust_code;
            if (!IsPostBack)
            {
                if (mindividual == "N")
                {
                    sqlDet = "SELECT year(transdate) as year1 ,month(transdate) as month1 , t.transdate,STUFF(convert(varchar,t.transdate,106),7,3,' ') as transdate1, t.acccode, case when t.transtype='Journal' then 'JV :' + ' ' +  t.voucherno when t.transtype='Cash Receipt' then 'CSH - R :' + ' ' +  t.voucherno when t.transtype='Cash Payment' then 'CSH - P :' + ' ' +  t.voucherno when t.transtype='Bank Payment' then 'BK - P :' + ' ' +  t.voucherno when t.transtype='Bank Receipt' then 'BK - R :' + ' ' +  t.voucherno when t.transtype='Credit Note' then 'CN :' + ' ' +  t.voucherno when t.transtype='Debit note' then 'DN :' + ' ' +  t.voucherno when t.transtype='Contra' then 'CON :' + ' ' +  t.voucherno when t.transtype='Income' then 'INC :' + ' ' +  t.voucherno when t.transtype='Expenses' then 'EXP :' + ' ' +  t.voucherno when t.transtype='Sale' then 'SA :' + ' ' +  t.voucherno when t.transtype='Purchase' then 'PUR :' + ' ' +  t.voucherno End as voucherno, t.voucherno, t.narration,t.payto,convert(varchar,t.debit) as debit,convert(varchar,t.credit) as credit, srno,t.oppaccount,isNull(t.PBOV_CODE + ':' + t.PBOV_Name,'') as PROV from " + mAcctTransTable + " t  where  t.voucher_cancel='N'" + mdateDetCls + " and t.acccode='" + acccode + "' and t.pbov_code='" + cust_code + "' order by transdate";
                }
                else
                {
                    string branchcls = " and t.brcd='" + branch + "'";
                    sqlDet = "SELECT year(transdate) as year1 ,month(transdate) as month1 , t.transdate,STUFF(convert(varchar,t.transdate,106),7,3,' ') as transdate1, t.acccode, case when t.transtype='Journal' then 'JV :' + ' ' +  t.voucherno when t.transtype='Cash Receipt' then 'CSH - R :' + ' ' +  t.voucherno when t.transtype='Cash Payment' then 'CSH - P :' + ' ' +  t.voucherno when t.transtype='Bank Payment' then 'BK - P :' + ' ' +  t.voucherno when t.transtype='Bank Receipt' then 'BK - R :' + ' ' +  t.voucherno when t.transtype='Credit Note' then 'CN :' + ' ' +  t.voucherno when t.transtype='Debit note' then 'DN :' + ' ' +  t.voucherno when t.transtype='Contra' then 'CON :' + ' ' +  t.voucherno when t.transtype='Income' then 'INC :' + ' ' +  t.voucherno when t.transtype='Expenses' then 'EXP :' + ' ' +  t.voucherno when t.transtype='Sale' then 'SA :' + ' ' +  t.voucherno when t.transtype='Purchase' then 'PUR :' + ' ' +  t.voucherno End as voucherno, t.voucherno, t.narration,t.payto, convert(varchar,t.debit) as debit,convert(varchar,t.credit) as credit, srno,t.oppaccount,isNull(t.PBOV_CODE + ':' + t.PBOV_Name,'') as PROV from " + mAcctTransTable + " t  where  t.voucher_cancel='N'" + branchcls + mdateDetCls + " and t.acccode='" + acccode + "' and t.pbov_code='" + cust_code + "' order by transdate ";
                }
                DateTime righnow = DateTime.Now;
                righnow = righnow.AddDays(-7);
                string strrightnow = righnow.ToString("dd/MM/yyyy");
                string selectedDate = DAccess.returnmmddyyyy_format(mTodt);


                DateTime pri = DateTime.Parse(selectedDate);
                pri = pri.AddDays(-1);
                string strpri = pri.ToString("dd/MM/yyyy");
                string strPriviousDate = DAccess.return_date(strpri);
                string mdatefrom1 = "01 Jan 2000";
                string macctcls = "";
                string loccode = branch;



                conn.Open();
                SqlCommand cmd = new SqlCommand(sqlDet, conn);
                SqlDataAdapter da = new SqlDataAdapter(sqlDet, conn);
                da.Fill(_dataSet, "tran");
                RepeaterTran.DataSource = _dataSet.tran;
                RepeaterTran.DataBind();

                string monthName, yearName, monthNamec;
                string strtottaldebit, strtotalcredit;
                double tottaldebit = 0;
                double totalcredit = 0;
                //SqlCommand cmdRead = new SqlCommand(sqlDet, conn);
                dtr = DAccess.getreader(sqlDet);
                monthName = "";
                yearName = "";
                strtottaldebit = "";
                strtotalcredit = "";
                while (dtr.Read())
                {
                    monthName = dtr["month1"].ToString();
                    yearName = dtr["year1"].ToString();
                    strtottaldebit = dtr["debit"].ToString();
                    strtotalcredit = dtr["credit"].ToString();
                    tottaldebit = tottaldebit + Convert.ToDouble(strtottaldebit);
                    totalcredit = totalcredit + Convert.ToDouble(strtotalcredit);
                }

                dtr.Close();
                conn.Close();

                double bal = (tottaldebit - totalcredit);
                monthNamec = DAccess.monthName(monthName);

                lblMonth.Text = monthNamec + " " + "-" + " " + yearName;
                lblTotalDebit.Text = string.Format("{0:.00}", tottaldebit).ToString();
                lbltotalCredit.Text = string.Format("{0:.00}", totalcredit).ToString();
                if (totalcredit < tottaldebit)
                {
                    lblCDebit.Text = string.Format("{0:.00}", bal).ToString();
                }
                else if (tottaldebit < totalcredit)
                {
                    bal = (totalcredit - tottaldebit);
                    lblCCredit.Text = string.Format("{0:.00}", bal).ToString();
                }
                if (mindividual == "N")
                {
                    sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
                }
                else
                {
                    sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit_i,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit_i,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
                }

                SqlDataAdapter daSQL = new SqlDataAdapter(sql, conn);
                daSQL.Fill(_dataSet.Group);
                rpt.DataSource = _dataSet.Group;
                rpt.DataBind();

                //////////////////////////////////////////////////////
                //string openBalDebit, openBalCridet;
                string strOpnDebit, strOpnCridet;
                double tottaldebitAC = 0;
                double totalcreditAC = 0;

                dtr = DAccess.getreader(sql);
                strOpnDebit = "";
                strOpnCridet = "";

                while (dtr.Read())
                {
                    strOpnDebit = dtr["opendebit"].ToString();
                    strOpnCridet = dtr["opencredit"].ToString();
                    tottaldebitAC = Convert.ToDouble(strOpnDebit);
                    totalcreditAC = Convert.ToDouble(strOpnCridet);
                }
                dtr.Close();
                conn.Close();
                double totalACD = (tottaldebitAC + tottaldebit);
                double totalACC = (totalcreditAC + totalcredit);
                lblTotalDebitAC.Text = string.Format("{0:.00}", totalACD).ToString();
                lblTotalCridetAC.Text = string.Format("{0:.00}", totalACC).ToString();
                if (totalcredit < tottaldebit)
                {
                    lblCloD.Text = string.Format("{0:.00}", bal).ToString();
                }
                else if (tottaldebit < totalcredit)
                {
                    bal = (totalcredit - tottaldebit);
                    lblCloC.Text = string.Format("{0:.00}", bal).ToString();
                }
            }
        
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        if (ledgerof == "V")
        {
            string vend_code= Request.QueryString["vend_code"].ToString();
            {
                Label4.Text = "Vendor";
                string v_name, v_code;
                string strv = "select VENDORCODE,VENDORNAME from webx_VENDOR_HDR where VENDORCODE='" + vend_code + "'";
                dtr = DAccess.getreader(strv);
                conn.Open();
                while (dtr.Read())
                {
                    v_name = dtr["VENDORNAME"].ToString().Trim();
                    v_code = dtr["VENDORCODE"].ToString().Trim();
                }
                dtr.Close();
                conn.Close();
                string Vendor_Type = "";
                string str = "select Vendor_Type from webx_VENDOR_HDR where VENDORCODE='" + vend_code + "'";
                conn.Open();
                dtr = DAccess.getreader(str);
                while (dtr.Read())
                {
                    Vendor_Type = dtr["Vendor_Type"].ToString();
                }
                dtr.Close();
                conn.Close();
                string accthead = "";
                string straccthead = "select * from webx_AcctHead where CodeId='" + Vendor_Type + "'";
                conn.Open();
                dtr = DAccess.getreader(straccthead);
                while (dtr.Read())
                {
                    accthead = dtr["accthead"].ToString();
                }
                dtr.Close();
                conn.Close();

                string mdateDetCls = " and convert(varchar,t.transdate,106) between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + mClosedt + "',106)";
                string acccode = accthead;
                string sssql = "select acccode,accdesc from webx_acctinfo where acccode='" + acccode.Trim() + "'";
                string cust_code = Request.QueryString["vend_code"].ToString();
                conn.Open();
                string straccdesc = "";
                dtr = DAccess.getreader(sssql);
                while (dtr.Read())
                {
                    straccdesc = dtr["accdesc"].ToString();
                }
                dtr.Close();
                conn.Close();
                
                string strSalesAccountText = straccdesc;
                string tranType;

                if (mindividual == "Y")
                {
                    tranType = "(Individual)";
                }
                else
                {
                    tranType = "(Cumulative)";
                }
                lblBran.Text = branchText + " " + tranType;
                lblDate_Range.Text = mTodt + " " + "-" + " " + mClosedt;
                lblAccount.Text = strSalesAccountText;
                lblCustomer.Text = v_name + " " + ":" + " " + v_code;
                if (!IsPostBack)
                {
                    if (mindividual == "N")
                    {
                        sqlDet = "SELECT year(transdate) as year1 ,month(transdate) as month1 , t.transdate,STUFF(convert(varchar,t.transdate,106),7,3,' ') as transdate1, t.acccode, case when t.transtype='Journal' then 'JV :' + ' ' +  t.voucherno when t.transtype='Cash Receipt' then 'CSH - R :' + ' ' +  t.voucherno when t.transtype='Cash Payment' then 'CSH - P :' + ' ' +  t.voucherno when t.transtype='Bank Payment' then 'BK - P :' + ' ' +  t.voucherno when t.transtype='Bank Receipt' then 'BK - R :' + ' ' +  t.voucherno when t.transtype='Credit Note' then 'CN :' + ' ' +  t.voucherno when t.transtype='Debit note' then 'DN :' + ' ' +  t.voucherno when t.transtype='Contra' then 'CON :' + ' ' +  t.voucherno when t.transtype='Income' then 'INC :' + ' ' +  t.voucherno when t.transtype='Expenses' then 'EXP :' + ' ' +  t.voucherno when t.transtype='Sale' then 'SA :' + ' ' +  t.voucherno when t.transtype='Purchase' then 'PUR :' + ' ' +  t.voucherno End as voucherno, t.voucherno, t.narration,t.payto,convert(varchar,t.debit) as debit,convert(varchar,t.credit) as credit, srno,t.oppaccount,isNull(t.PBOV_CODE + ':' + t.PBOV_Name,'') as PROV from " + mAcctTransTable + " t  where  t.voucher_cancel='N'" + mdateDetCls + " and t.acccode='" + acccode + "' and t.pbov_code='" + vend_code + "' order by transdate";
                    }
                    else
                    {
                        string branchcls = " and t.brcd='" + branch + "'";
                        sqlDet = "SELECT year(transdate) as year1 ,month(transdate) as month1 , t.transdate,STUFF(convert(varchar,t.transdate,106),7,3,' ') as transdate1, t.acccode, case when t.transtype='Journal' then 'JV :' + ' ' +  t.voucherno when t.transtype='Cash Receipt' then 'CSH - R :' + ' ' +  t.voucherno when t.transtype='Cash Payment' then 'CSH - P :' + ' ' +  t.voucherno when t.transtype='Bank Payment' then 'BK - P :' + ' ' +  t.voucherno when t.transtype='Bank Receipt' then 'BK - R :' + ' ' +  t.voucherno when t.transtype='Credit Note' then 'CN :' + ' ' +  t.voucherno when t.transtype='Debit note' then 'DN :' + ' ' +  t.voucherno when t.transtype='Contra' then 'CON :' + ' ' +  t.voucherno when t.transtype='Income' then 'INC :' + ' ' +  t.voucherno when t.transtype='Expenses' then 'EXP :' + ' ' +  t.voucherno when t.transtype='Sale' then 'SA :' + ' ' +  t.voucherno when t.transtype='Purchase' then 'PUR :' + ' ' +  t.voucherno End as voucherno, t.voucherno, t.narration,t.payto, convert(varchar,t.debit) as debit,convert(varchar,t.credit) as credit, srno,t.oppaccount,isNull(t.PBOV_CODE + ':' + t.PBOV_Name,'') as PROV from " + mAcctTransTable + " t  where  t.voucher_cancel='N'" + branchcls + mdateDetCls + " and t.acccode='" + acccode + "' and t.pbov_code='" + vend_code + "' order by transdate ";
                    }
                    DateTime righnow = DateTime.Now;
                    righnow = righnow.AddDays(-7);
                    string strrightnow = righnow.ToString("dd/MM/yyyy");
                    string selectedDate = DAccess.returnmmddyyyy_format(mTodt);

                    DateTime pri = DateTime.Parse(selectedDate);
                    pri = pri.AddDays(-1);
                    string strpri = pri.ToString("dd/MM/yyyy");
                    string strPriviousDate = DAccess.return_date(strpri);
                    string mdatefrom1 = "01 Jan 2000";
                    string macctcls = "";
                    string loccode = branch;



                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sqlDet, conn);
                    SqlDataAdapter da = new SqlDataAdapter(sqlDet, conn);
                    da.Fill(_dataSet, "tran");
                    RepeaterTran.DataSource = _dataSet.tran;
                    RepeaterTran.DataBind();

                    string monthName, yearName, monthNamec;
                    string strtottaldebit, strtotalcredit;
                    double tottaldebit = 0;
                    double totalcredit = 0;
                    //SqlCommand cmdRead = new SqlCommand(sqlDet, conn);
                    dtr = DAccess.getreader(sqlDet);
                    monthName = "";
                    yearName = "";
                    strtottaldebit = "";
                    strtotalcredit = "";
                    while (dtr.Read())
                    {
                        monthName = dtr["month1"].ToString();
                        yearName = dtr["year1"].ToString();
                        strtottaldebit = dtr["debit"].ToString();
                        strtotalcredit = dtr["credit"].ToString();
                        tottaldebit = tottaldebit + Convert.ToDouble(strtottaldebit);
                        totalcredit = totalcredit + Convert.ToDouble(strtotalcredit);
                    }

                    dtr.Close();
                    conn.Close();

                    double bal = (tottaldebit - totalcredit);
                    monthNamec = DAccess.monthName(monthName);

                    lblMonth.Text = monthNamec + " " + "-" + " " + yearName;
                    lblTotalDebit.Text = string.Format("{0:.00}", tottaldebit).ToString();
                    lbltotalCredit.Text = string.Format("{0:.00}", totalcredit).ToString();
                    if (totalcredit < tottaldebit)
                    {
                        lblCDebit.Text = string.Format("{0:.00}", bal).ToString();
                    }
                    else if (tottaldebit < totalcredit)
                    {
                        bal = (totalcredit - tottaldebit);
                        lblCCredit.Text = string.Format("{0:.00}", bal).ToString();
                    }
                    if (mindividual == "N")
                    {
                        sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
                    }
                    else
                    {
                        sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit_i,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit_i,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
                    }

                    SqlDataAdapter daSQL = new SqlDataAdapter(sql, conn);
                    daSQL.Fill(_dataSet.Group);
                    rpt.DataSource = _dataSet.Group;
                    rpt.DataBind();

                    //////////////////////////////////////////////////////
                    //string openBalDebit, openBalCridet;
                    string strOpnDebit, strOpnCridet;
                    double tottaldebitAC = 0;
                    double totalcreditAC = 0;

                    dtr = DAccess.getreader(sql);
                    strOpnDebit = "";
                    strOpnCridet = "";

                    while (dtr.Read())
                    {
                        strOpnDebit = dtr["opendebit"].ToString();
                        strOpnCridet = dtr["opencredit"].ToString();
                        tottaldebitAC = Convert.ToDouble(strOpnDebit);
                        totalcreditAC = Convert.ToDouble(strOpnCridet);
                    }
                    dtr.Close();
                    conn.Close();
                    double totalACD = (tottaldebitAC + tottaldebit);
                    double totalACC = (totalcreditAC + totalcredit);
                    lblTotalDebitAC.Text = string.Format("{0:.00}", totalACD).ToString();
                    lblTotalCridetAC.Text = string.Format("{0:.00}", totalACC).ToString();
                    if (totalcredit < tottaldebit)
                    {
                        lblCloD.Text = string.Format("{0:.00}", bal).ToString();
                    }
                    else if (tottaldebit < totalcredit)
                    {
                        bal = (totalcredit - tottaldebit);
                        lblCloC.Text = string.Format("{0:.00}", bal).ToString();
                    }
                }

            }
        }
    }
}
