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
using System.IO;

public partial class GUI_UNI_MIS_accounts_mis_ledger_result : System.Web.UI.Page
{
    string sqlDet, sql;
    public double total_Debit = 0;
    public double total_Crebit = 0;
    public string DebitBal, CreditBal, DRCR;
    DataAccess DA = new DataAccess();
    public DataSet1 _dataSet = new DataSet1();
    SqlDataReader dtr;
    double acctTotalDr, acctTotalCr;
    DateFunction DFun = new DateFunction();
    DataAccess DAccess = new DataAccess();
    AccountTrans tran = new AccountTrans();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string Year = Session["FinYear"].ToString();

        string styear = Year.Substring(2, 2);
        //Response.Write("<br>Year " + Year);
        //Response.Write("<br>Year " + abc);
        // Response.End();
        string CloseYear = Convert.ToString((Convert.ToInt16(styear) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        string YearString = Convert.ToString(styear) + "_" + Convert.ToString(CloseYear);
        Session["YearVal"] = YearString;


        string branText = Request.QueryString["branText"];
        string branch = Request.QueryString["branch"];
        string mindividual = Request.QueryString["strdlstTranType"].ToString();
        string mTodt = Request.QueryString["dateFrom"];
        string mClosedt = Request.QueryString["dateTo"];
        string acccode = Request.QueryString["strdlstSalesAmount"];
        string mAcctTransTable = "webx_acctrans_" + Session["YearVal"].ToString();
        string mAcctTable="webx_acctinfo";
        string mGroupTable="webx_groups";

        string mAcctOpenTable = "webx_acctopening_" + Session["YearVal"].ToString();
        //Response.Write("<BR> mAcctOpenTable : " + mAcctOpenTable);
        string mdateDetCls = " and convert(varchar,t.transdate,106) between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + mClosedt + "',106)";
        string sssql = "select acccode,accdesc from webx_acctinfo where acccode='" + acccode + "'";
        
        string straccdesc = "";
        dtr = DAccess.getreader(sssql);
        while (dtr.Read())
        {
            straccdesc = dtr["accdesc"].ToString();
        }
        dtr.Close();
        
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
        lblBran.Text = branText + " " + tranType;
        lblDate_Range.Text = mTodt + " " + "-" + " " + mClosedt;
        lblAccount.Text = strSalesAccountText;
        if (!IsPostBack)
        {
            if (mindividual == "N")
            {
                sqlDet = "SELECT year(transdate) as year1 ,month(transdate) as month1 , t.transdate,STUFF(convert(varchar,t.transdate,106),7,3,' ') as transdate1, t.acccode, case when t.transtype='Journal' then 'JV :' + ' ' +  t.voucherno when t.transtype='CASH RECIEPT' then 'CSH - R :' + ' ' +  t.voucherno when t.transtype='Cash Payment' then 'CSH - P :' + ' ' +  t.voucherno when t.transtype='Bank Payment' then 'BK - P :' + ' ' +  t.voucherno when t.transtype='Bank Receipt' then 'BK - R :' + ' ' +  t.voucherno when t.transtype='Credit Note' then 'CN :' + ' ' +  t.voucherno when t.transtype='Debit note' then 'DN :' + ' ' +  t.voucherno when t.transtype='Contra' then 'CON :' + ' ' +  t.voucherno when t.transtype='Income' then 'INC :' + ' ' +  t.voucherno when t.transtype='Expenses' then 'EXP :' + ' ' +  t.voucherno when t.transtype='Sale' then 'SA :' + ' ' +  t.voucherno when t.transtype='Purchase' then 'PUR :' + ' ' +  t.voucherno End as voucherno, t.voucherno, t.narration,t.payto,convert(varchar,(convert(money,isNull(t.debit,'0'),2))) as debit,convert(varchar,(convert(money,isNull(t.credit,'0'),2))) as credit, srno,t.oppaccount,isNull(t.PBOV_CODE + ':' + t.PBOV_Name,'') as PROV from " + mAcctTransTable + " t  where  t.voucher_cancel='N'" + mdateDetCls + " and t.acccode='" + acccode + "'  order by transdate";
            }
            else
            {
                string branchcls = " and t.brcd='" + branch + "'";
                sqlDet = "SELECT year(transdate) as year1 ,month(transdate) as month1 , t.transdate,STUFF(convert(varchar,t.transdate,106),7,3,' ') as transdate1, t.acccode, case when t.transtype='Journal' then 'JV :' + ' ' +  t.voucherno when t.transtype='CASH RECIEPT' then 'CSH - R :' + ' ' +  t.voucherno when t.transtype='Cash Payment' then 'CSH - P :' + ' ' +  t.voucherno when t.transtype='Bank Payment' then 'BK - P :' + ' ' +  t.voucherno when t.transtype='Bank Receipt' then 'BK - R :' + ' ' +  t.voucherno when t.transtype='Credit Note' then 'CN :' + ' ' +  t.voucherno when t.transtype='Debit note' then 'DN :' + ' ' +  t.voucherno when t.transtype='Contra' then 'CON :' + ' ' +  t.voucherno when t.transtype='Income' then 'INC :' + ' ' +  t.voucherno when t.transtype='Expenses' then 'EXP :' + ' ' +  t.voucherno when t.transtype='Sale' then 'SA :' + ' ' +  t.voucherno when t.transtype='Purchase' then 'PUR :' + ' ' +  t.voucherno End as voucherno, t.voucherno, t.narration,t.payto,convert(varchar,(convert(money,isNull(t.debit,'0'),2))) as debit,convert(varchar,(convert(money,isNull(t.credit,'0'),2))) as credit, srno,t.oppaccount,isNull(t.PBOV_CODE + ':' + t.PBOV_Name,'') as PROV from " + mAcctTransTable + " t  where  t.voucher_cancel='N'" + branchcls + mdateDetCls + " and t.acccode='" + acccode + "' order by transdate ";
            }
            DateTime righnow = DateTime.Now;
            righnow = righnow.AddDays(-7);
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            string selectedDate = DFun.returnmmddyyyy_format(mTodt);


            DateTime pri = DateTime.Parse(selectedDate);
            pri = pri.AddDays(-1);
            string strpri = pri.ToString("dd/MM/yyyy");
            string strPriviousDate = DFun.return_date(strpri);
            string mdatefrom1 = "01 Jan 2000";
            string macctcls = "";
            string loccode = branch;
            
            SqlCommand cmd = new SqlCommand(sqlDet, conn);
            SqlDataAdapter da = new SqlDataAdapter(sqlDet, conn);
            da.Fill(_dataSet, "tran");

            RepeaterTran.DataSource = _dataSet.tran;
            RepeaterTran.DataBind();

            string monthName, yearName, monthNamec;
            string strtottaldebit, strtotalcredit;
            double tottaldebit=0;
            double totalcredit=0;
            
            dtr = DAccess.getreader(sqlDet);
            monthName="";
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
            

            double bal = (tottaldebit - totalcredit);
            monthNamec = DFun.monthName(monthName);
            
            lblTotalDebit.Text = string.Format("{0:0.00}", tottaldebit).ToString();
            lbltotalCredit.Text = string.Format("{0:0.00}", totalcredit).ToString();
            double ActualEnd = 0.00;
            if (tottaldebit > totalcredit)
            {
                lblTotalCridetAC.Text = "0.00";
                lblTotalDebitAC.Text = string.Format("{0:0.00}", (tottaldebit - totalcredit)).ToString();//Convert.ToString(tottaldebit - totalcredit);
            }
            else if (tottaldebit < totalcredit)
            {
                lblTotalCridetAC.Text = string.Format("{0:0.00}", (totalcredit - tottaldebit)).ToString(); ;
                lblTotalDebitAC.Text = "0.00";
            }
            if (mindividual == "N")
            {
                //sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
                sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd IN (Select LocCode From WebX_Location where Report_Loc='" + loccode + "')' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
            }
            else
            {
                sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,case when(isNull(o.opendebit_i,'0.00')='.00') then '0.00' End as opendebit ,case when(isNull(o.opencredit_i,'0.00')='.00') then '0.00' End as opencredit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
            }

            
            string branText1 = "";
            string info1 = branText;
            string[] arInfo1 = new string[1];
            char[] splitter1 = { ':' };
            arInfo1 = info1.Split(splitter1);
            for (int x1 = 0; x1 < arInfo1.Length; x1++)
            {
                branText1 = arInfo1[0];
            }
            lblbrantext.Text = branText1;
            string fromdate = Request.QueryString["dateFrom"].ToString();
            string toDate = Request.QueryString["dateTo"];
            DateTime dt = Convert.ToDateTime(DFun.returnmmddyyyy_format(fromdate));
            dt = dt.AddDays(-1);
            string new_Date_temp = dt.ToString("dd/MM/yyyy");
            string new_Date = DFun.return_date(new_Date_temp);

            string openTable = "webx_acctopening_" + Session["YearVal"].ToString(); 
            string transTable = "webx_acctrans_" + Session["YearVal"].ToString(); 
            string indiual = Request.QueryString["strdlstTranType"].ToString();

            string opening = "";
            string tranjaction = "";
            string all_tranDr = "", all_tranCr = "";
            string all_openDr = "", all_openCr = "";
            double transactionDr = 0;
            double transactionCr = 0;
            double openDr = 0, openCr = 0;
            double total_Debit = 0;
            double total_Crebit = 0;
            if (indiual == "N")
            {
                tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + " where Acccode= '" + acccode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) < convert(datetime, '" + fromdate + "' ,106) and Brcd IN (Select LocCode From WebX_Location where Report_Loc='" + loccode +"')";
                opening = "select isNull(sum(opendebit),0.00) as opendebit,isNull(sum(opencredit),0.00) as opencredit from " + openTable + " where Brcd IN (Select LocCode From WebX_Location where Report_Loc='" + loccode + "') and acccode= '" + acccode + "' ";

                dtr = DAccess.getreader(tranjaction);
                while (dtr.Read())
                {
                    all_tranDr = dtr["Debit"].ToString();
                    all_tranCr = dtr["Credit"].ToString();
                }
                dtr.Close();
                if (Convert.ToDouble(all_tranDr) < Convert.ToDouble(all_tranCr))
                {
                    transactionCr = Convert.ToDouble(all_tranCr) - Convert.ToDouble(all_tranDr);
                }
                else if (Convert.ToDouble(all_tranDr) > Convert.ToDouble(all_tranCr))
                {
                    transactionDr = Convert.ToDouble(all_tranDr) - Convert.ToDouble(all_tranCr);
                }

                dtr = DAccess.getreader(opening);
                while (dtr.Read())
                {
                    all_openDr = dtr["opendebit"].ToString();
                    all_openCr = dtr["opencredit"].ToString();
                }
                dtr.Close();
                if (Convert.ToDouble(all_openDr) < Convert.ToDouble(all_openCr))
                {
                    openCr = Convert.ToDouble(all_openCr) - Convert.ToDouble(all_openDr);
                }
                else if (Convert.ToDouble(all_openDr) > Convert.ToDouble(all_openCr))
                {
                    openDr = Convert.ToDouble(all_openDr) - Convert.ToDouble(all_openCr);
                }
                total_Debit = transactionDr + openDr;
                total_Crebit = transactionCr + openCr;
            }
            else
            {
                tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + " where brcd= '" + loccode + " ' and  Acccode= '" + acccode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) < convert(datetime, '" + fromdate + "' ,106) ";
                opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + " where brcd= '" + loccode + " ' and acccode= '" + acccode + "'";
                dtr = DAccess.getreader(tranjaction);
                while (dtr.Read())
                {
                    all_tranDr = dtr["Debit"].ToString();
                    all_tranCr = dtr["Credit"].ToString();
                }
                dtr.Close();
                if (Convert.ToDouble(all_tranDr) < Convert.ToDouble(all_tranCr))
                {
                    transactionCr = Convert.ToDouble(all_tranCr) - Convert.ToDouble(all_tranDr);
                }
                else if (Convert.ToDouble(all_tranDr) > Convert.ToDouble(all_tranCr))
                {
                    transactionDr = Convert.ToDouble(all_tranDr) - Convert.ToDouble(all_tranCr);
                }
                dtr = DAccess.getreader(opening);
                while (dtr.Read())
                {
                    all_openDr = dtr["opendebit_i"].ToString();
                    all_openCr = dtr["opencredit_i"].ToString();
                }
                dtr.Close();
                if (Convert.ToDouble(all_openDr) < Convert.ToDouble(all_openCr))
                {
                    openCr = Convert.ToDouble(all_openCr) - Convert.ToDouble(all_openDr);
                }
                else if (Convert.ToDouble(all_openDr) > Convert.ToDouble(all_openCr))
                {
                    openDr = Convert.ToDouble(all_openDr) - Convert.ToDouble(all_openCr);
                }
                total_Debit = transactionDr + openDr;
                total_Crebit = transactionCr + openCr;
            }
                                             
            
            DRCR = tran.getOpeningBalance_DRCR(acccode, fromdate, new_Date, loccode, openTable, transTable, indiual);
            if (DRCR == "Dr")
            {

                //double totalDr = Convert.ToDouble(bal);
                DebitBal = string.Format("{0:0.00}", total_Debit).ToString();
                CreditBal = string.Format("{0:0.00}", total_Crebit).ToString();
            }
            if (DRCR == "Cr")
            {
                DebitBal = string.Format("{0:0.00}", total_Debit).ToString();
                CreditBal = string.Format("{0:0.00}", total_Crebit).ToString();
                //double totalCR = Convert.ToDouble(bal);
                //string bal3 = string.Format("{0:.00}", totalCR).ToString();
            }
            
            double total_Dr = total_Debit + Convert.ToDouble(lblTotalDebitAC.Text);
            double total_Cr = total_Crebit + Convert.ToDouble(lblTotalCridetAC.Text); 
            if (total_Dr > total_Cr)
            {
                double temp = (total_Dr - total_Cr);
                lblCloD.Text = string.Format("{0:0.00}", temp).ToString();
                lblCloC.Text = "0.00";//string.Format("{0:0.00}", total_Dr).ToString();
            }
            else if (total_Dr < total_Cr)
            {
                double temp = (total_Cr - total_Dr);
                lblCloC.Text = string.Format("{0:0.00}", temp).ToString();
                lblCloD.Text = "0.00";//string.Format("{0:0.00}", total_Dr).ToString();
            }
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void BtnDownload_clicked(object sender, EventArgs e)
    {


        //table1.BorderWidth = 1;
        //table1.CssClass = "blackfnt";
        //table1.Font.Size = 10;
        table1.BgColor = "white";
        //table1.Border = 1;
        table1.Align = "center";
        table1.Width = "100%";
        table1.Height = "100%";
        table1.Style["class"] = "blackfnt";
        //tab2.BgColor = "white";
        table2.Border = 1;
        table2.Align = "center";
        //table3.Border = 1;
        //table3.Align = "center";
        //BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Voucher_Dtl.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(table1);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();


        //Response.Redirect("result_xls.aspx?branch=" + branch + "&strdlstTranType=" + mindividual + "&dateFrom=" + mTodt + "&dateTo=" + mClosedt + "&strdlstSalesAmount=" + acccode + "&branText=" + branText + "&strSalesAccountText=" + salestext, true);



    }
}
