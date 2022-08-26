using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance : System.Web.UI.Page
{

    SqlConnection conn;
    double tot_cashdebit = 0, tot_cashcredit = 0, cashclosedebit = 0, cashclosecredit = 0, tot_bankdebit = 0, tot_bankcredit = 0, bankClosecredit = 0, bankClosedebit=0;
    public static string strDateRange, ACCOunts,mAcctTransTable_open, finyearstart,strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    protected void Page_Load(object sender, EventArgs e)
    {

        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition", "attachment; filename=CBS.xls");
        if (!IsPostBack)
        {
            String Year = Session["FinYear"].ToString();

            string abc = Year.Substring(2, 2);
            //Response.Write("<br>Year " + Year);
            //Response.Write("<br>Year " + abc);
            // Response.End();
            string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
            yearSuffix = YearString;
            finyearstart = "01 APR " + abc;
            mAcctTransTable_open = "webx_acctopening_" + yearSuffix;
            mAcctTransTable = "webx_acctrans_" + yearSuffix;
            AcctOpenTable = "webx_acctrans_" + yearSuffix;
            AcctTable = "webx_acctinfo";

            strDateRange = Request.QueryString["DOCDate"].ToString();
            lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
           lblro.Text = strro;
            ACCOunts = Request.QueryString["ACCOunts"].ToString();
           
            
        }

        BindGrid();
       // DisplayDocFlow();
        
    }

    private void BindGrid()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // conn.Open();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //  Response.Write("<br> ff :" +Session["SqlProvider1"].ToString());
        conn.Open();
        string BankCashCls,BankCashCls1;



        if (ACCOunts == "0")
        {
            BankCashCls = "and ( acccategory='CASH' OR ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')) ";
			 BankCashCls1 = BankCashCls;
        }
        else if (ACCOunts == "1")
        {
            BankCashCls = " and ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')";
			 BankCashCls1 = BankCashCls;
        }
        else if (ACCOunts == "2")
        {
            BankCashCls = " and d.acccategory ='CASH'";
			 BankCashCls1 = BankCashCls;
        }
        else
        {
            BankCashCls = " and (d.acccode ='" + ACCOunts + "' or oppacccode ='" + ACCOunts + "')  and ( acccategory='CASH' OR ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')) ";
			 BankCashCls1 = " and (d.acccode ='" + ACCOunts + "' )  and ( acccategory='CASH' OR ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')) "; ;
        }

        //String	branchcls=" and m.brcd='" +  strro + "'";

        string[] strArrDtFromTo = strDateRange.Split('-');
        DateTime fromdt = Convert.ToDateTime(strArrDtFromTo[0]);
        DateTime fromdt1 = Convert.ToDateTime(finyearstart);
        //DateTime todt = Convert.ToDateTime(strArrDtFromTo[1]);
        if (fromdt1 > fromdt)
        {
            fromdt = fromdt1;
        }

        String fromdt_s = fromdt.ToShortDateString();
        // String todt_s = fromdt.ToShortDateString();
        string[] strArrDtFrom = fromdt_s.Split('/');


        TBL_CBS.Visible = true;

        TableRow tr1 = new TableRow();

        TableCell tr1tc1 = new TableCell();
        TableCell tr1tc2 = new TableCell();
        TableCell tr1tc3 = new TableCell();
        TableCell tr1tc4 = new TableCell();
        TableCell tr1tc5 = new TableCell();
        TableCell tr1tc6 = new TableCell();
        TableCell tr1tc7 = new TableCell();
        TableCell tr1tc8 = new TableCell();
        TableCell tr1tc9 = new TableCell();

        tr1tc1.Text = "Sr No.";
        tr1tc1.CssClass = "blackfnt";
        tr1tc1.Wrap = false;

        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc1);

        tr1tc2.Text = "Vaouche No.";
        tr1tc2.CssClass = "blackfnt";
        tr1tc2.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc2);

        tr1tc3.Text = " Date";
        tr1tc3.CssClass = "blackfnt";
        tr1tc3.Wrap = false;
        tr1.CssClass = "bgbluegrey";

        tr1.Cells.Add(tr1tc3);

        tr1tc4.Text = "Party";
        tr1tc4.CssClass = "blackfnt";
        tr1tc4.Wrap = false;
        tr1.CssClass = "bgbluegrey";

        tr1.Cells.Add(tr1tc4);

        tr1tc5.Text = "Particulars ";
        tr1tc5.CssClass = "blackfnt";
        tr1tc5.Wrap = false;
        tr1.CssClass = "bgbluegrey";

        tr1.Cells.Add(tr1tc5);

        tr1tc6.Text = "Cash/Bank Name";
        tr1tc6.CssClass = "blackfnt";
        tr1tc6.Wrap = false;
        tr1.CssClass = "bgbluegrey";

        tr1.Cells.Add(tr1tc6);

        tr1tc7.Text = "Cheque No ";
        tr1tc7.CssClass = "blackfnt";
        tr1tc7.Wrap = false;
        tr1.CssClass = "bgbluegrey";

        tr1.Cells.Add(tr1tc7);

        tr1tc8.Text = "Cash ";
        tr1tc8.CssClass = "blackfnt";
        tr1tc8.Wrap = false;
        tr1tc8.ColumnSpan = 2;
        tr1.CssClass = "bgbluegrey";

        tr1.Cells.Add(tr1tc8);

        tr1tc9.Text = "Bank ";
        tr1tc9.CssClass = "blackfnt";
        tr1tc9.Wrap = false;
        tr1tc9.ColumnSpan = 2;
        tr1.CssClass = "bgbluegrey";
        tr1.HorizontalAlign = HorizontalAlign.Center;

        tr1.Cells.Add(tr1tc9);


        TBL_CBS.Rows.Add(tr1);

        TableRow tr2 = new TableRow();

        TableCell tr2tc1 = new TableCell();
        TableCell tr2tc2 = new TableCell();
        TableCell tr2tc3 = new TableCell();
        TableCell tr2tc4 = new TableCell();
        TableCell tr2tc5 = new TableCell();
        TableCell tr2tc6 = new TableCell();
        TableCell tr2tc7 = new TableCell();
        TableCell tr2tc8 = new TableCell();
        TableCell tr2tc9 = new TableCell();
        TableCell tr2tc10 = new TableCell();
        TableCell tr2tc11 = new TableCell();
        tr2tc1.Text = "";
        tr2tc1.CssClass = "blackfnt";
        tr2tc1.Wrap = false;
        // tr2tc1.RowSpan = 2;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc1);

        tr2tc2.Text = "";
        tr2tc2.CssClass = "blackfnt";
        tr2tc2.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc2);

        tr2tc3.Text = " ";
        tr2tc3.CssClass = "blackfnt";
        tr2tc3.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc3);

        tr2tc4.Text = "";
        tr2tc4.CssClass = "blackfnt";
        tr2tc4.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc4);

        tr2tc5.Text = " ";
        tr2tc5.CssClass = "blackfnt";
        tr2tc5.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc5);

        tr2tc6.Text = "";
        tr2tc6.CssClass = "blackfnt";
        tr2tc6.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc6);

        tr2tc7.Text = " ";
        tr2tc7.CssClass = "blackfnt";
        tr2tc7.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc7);

        tr2tc8.Text = "Dr ";
        tr2tc8.CssClass = "blackfnt";
        tr2tc8.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc8);

        tr2tc9.Text = "Cr ";
        tr2tc9.CssClass = "blackfnt";
        tr2tc9.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc9);

        tr2tc10.Text = "Dr ";
        tr2tc10.CssClass = "blackfnt";
        tr2tc10.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc10);

        tr2tc11.Text = "Cr ";
        tr2tc11.CssClass = "blackfnt";
        tr2tc11.Wrap = false;
        tr2.CssClass = "bgbluegrey";

        tr2.Cells.Add(tr2tc11);

        tr2.HorizontalAlign = HorizontalAlign.Center;
        tr2.BackColor = System.Drawing.Color.White;
        TBL_CBS.Rows.Add(tr2);




        //String SQL_bottom = " select Name,locname=(select top 1 locname from webx_location where loccode='" + Session["brcd"] + "' ), DATE_TIME=(convert(varchar,getdate(),106) + ' ' + convert(varchar,getdate(),108))from WebX_Master_Users where UserID='" + Session["empcd"] + "'";
        String SQL_bottom = " select Name,locname=(select top 1 locname from webx_location where loccode='" + Session["brcd"] + "' ), DATE_TIME=(convert(varchar,getdate(),106) + ' ' + convert(varchar,getdate(),108))from WebX_Master_Users where UserID='" + Session["empcd"] + "'";
        //String SQL_top = "select BANK_OPNDEBIT=sum(case when acccategory='BANK' then debit else 0 end),BANK_OPNCredit=sum(case when acccategory='BANK' then credit else 0 end),CASH_OPNDEBIT=sum(case when acccategory='CASH' then debit else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then credit else 0 end)  from " + AcctOpenTable + " M," + AcctTable + " D where m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106)  ";

        SqlCommand sqlcmd2 = new SqlCommand(SQL_bottom, conn);
        SqlDataReader dr2;
        dr2 = sqlcmd2.ExecuteReader();
        dr2.Read();

        //lblPrepareBy.Text = Convert.ToString(dr2["Name"]);
        //lblAt.Text = Convert.ToString(dr2["locname"]);
        //lblDateTime.Text = Convert.ToString(dr2["DATE_TIME"]);

        dr2.Close();
        fromdt_s = Convert.ToDateTime(strArrDtFrom[0] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");

        string opntodt = "";

        //if ((strArrDtFrom[0].ToString() + "/" + strArrDtFrom[1].ToString()) == "01/04")
        //{
        //    opntodt = Convert.ToDateTime(strArrDtFrom[0] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        //}
        //else
        //{
            opntodt = Convert.ToDateTime(strArrDtFrom[0] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[2]).AddDays(-1).ToString("dd MMM yy");
        //}

        string SQL_top = "select BANK_OPNDEBIT=sum(case when acccategory='BANK' then debit else 0 end),BANK_OPNCredit=sum(case when acccategory='BANK' then credit else 0 end),CASH_OPNDEBIT=sum(case when acccategory='CASH' then debit else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then credit else 0 end)  from " + AcctOpenTable + " M," + AcctTable + " D where m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  and Voucher_cancel='N'  And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + opntodt + "',106)  ";
        // String SQL_top = "select BANK_OPNDEBIT=sum(case when acccategory='BANK' then (isnull(opendebit_i,0)) else 0 end),BANK_OPNCredit=sum(case when acccategory='BANK' then (isnull(opencredit_i,0)) else 0 end),CASH_OPNDEBIT=sum(case when acccategory='CASH' then (isnull(opendebit_i,0)) else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then (isnull(opencredit_i,0)) else 0 end)  from " + mAcctTransTable + " M," + AcctTable + " D where m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  ";//And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106)  ";
        /// string SQL_top = "select BANK_OPNDEBIT=sum(case when acccategory='BANK' then  isnull(debit,0) else 0 end) + (case when acccategory='BANK' then  isnull(o.opendebit_i,0) else 0 end) ,BANK_OPNCredit=sum(case when acccategory='BANK' then  isnull(credit,0) else 0 end)+ (case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end) ,CASH_OPNDEBIT=sum(case when acccategory='CASH' then isnull(debit,0) else 0 end) + (case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then isnull(credit,0) else 0 end) +(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from " + AcctTable + " D  with(NOLOCK) left outer join " + mAcctTransTable_open + " o  with(NOLOCK) on D.acccode=o.acccode  and o.brcd='" + strro + "' left outer join " + AcctOpenTable + " M with(NOLOCK) on D.acccode=M.acccode and  M.brcd='" + strro + "' where (   1=1 ) " + BankCashCls + " and Voucher_cancel='N'  And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + opntodt + "',106) group by acccategory,opencredit_i,opendebit_i";
        // Response.Write("<br> SQL_top : " +SQL_top);
        string SQL_TOP1 = "";

        //if (strindividual == "Y")
        //{
        SQL_TOP1 = "select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit_i,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit_i,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit_i,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit_i,0) else 0 end) from " + AcctTable + " D with(NOLOCK) left outer join " + mAcctTransTable_open + " o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + strro + "' " + BankCashCls1 + "";
        // }
        // else
        //{
        //    SQL_TOP1 = "select BANK_OPNDEBIT=(case when acccategory='BANK' then isnull(o.opendebit,0) else 0 end),BANK_OPNCredit=(case when acccategory='BANK' then isnull(o.opencredit,0) else 0 end),CASH_OPNDEBIT=(case when acccategory='CASH' then isnull(o.opendebit,0) else 0 end),CASH_OPNCredit=(case when acccategory='CASH' then isnull(o.opencredit,0) else 0 end) from " + AcctTable + " D with(NOLOCK) left outer join " + mAcctTransTable_open + " o with(NOLOCK) on D.acccode=o.acccode where o.brcd='" + strro + "' " + BankCashCls + "";
        // }
        string sql_opnbal = SQL_top + " Union " + SQL_TOP1;
        // Response.Write("<br> sql_opnbal : " + sql_opnbal);
        SqlCommand sqlcmd1 = new SqlCommand(sql_opnbal, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd1.ExecuteReader();

        double BANK_OPNCredit = 0, BANK_OPNDEBIT = 0, CASH_OPNCredit = 0, CASH_OPNDEBIT = 0;

        //  dr1.Read();
        while (dr1.Read())
        {

            if ((dr1["BANK_OPNCredit"]) is DBNull)
            {
                BANK_OPNCredit = 0;
            }
            else
            {
                BANK_OPNCredit += Convert.ToDouble(dr1["BANK_OPNCredit"]);
            }
            if ((dr1["BANK_OPNDEBIT"]) is DBNull)
            {
                BANK_OPNDEBIT = 0;
            }
            else
            {
                BANK_OPNDEBIT += Convert.ToDouble(dr1["BANK_OPNDEBIT"]);
            }
            if ((dr1["CASH_OPNCredit"]) is DBNull)
            {
                CASH_OPNCredit = 0;
            }
            else
            {
                CASH_OPNCredit += Convert.ToDouble(dr1["CASH_OPNCredit"]);
            }
            if ((dr1["CASH_OPNDEBIT"]) is DBNull)
            {
                CASH_OPNDEBIT = 0;
            }
            else
            {
                CASH_OPNDEBIT += Convert.ToDouble(dr1["CASH_OPNDEBIT"]);
            }

        }
        dr1.Close();

        if (CASH_OPNCredit >= CASH_OPNDEBIT)
        {
            CASH_OPNCredit = CASH_OPNCredit - CASH_OPNDEBIT;
            CASH_OPNDEBIT = 0;
        }
        else
        {
            CASH_OPNDEBIT = CASH_OPNDEBIT - CASH_OPNCredit;
            CASH_OPNCredit = 0;
        }

        if (BANK_OPNCredit >= BANK_OPNDEBIT)
        {
            BANK_OPNCredit = BANK_OPNCredit - BANK_OPNDEBIT;
            BANK_OPNDEBIT = 0;
        }
        else
        {
            BANK_OPNDEBIT = BANK_OPNDEBIT - BANK_OPNCredit;
            BANK_OPNCredit = 0;
        }



        TableRow tr3 = new TableRow();

        TableCell tr3tc1 = new TableCell();
        TableCell tr3tc2 = new TableCell();
        TableCell tr3tc3 = new TableCell();
        TableCell tr3tc4 = new TableCell();
        TableCell tr3tc5 = new TableCell();
        TableCell tr3tc6 = new TableCell();

        tr3tc1.Text = "";
        tr3tc1.CssClass = "blackfnt";
        tr3tc1.Wrap = false;
        // tr3tc1.RowSpan = 2;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3tc1);

        tr3tc2.Text = "Opening Balance B/F";
        tr3tc2.CssClass = "blackfnt";
        tr3tc2.Wrap = false;
        tr3tc2.ColumnSpan = 6;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3tc2);

        tr3tc3.Text = CASH_OPNDEBIT.ToString("F2");
        tr3tc3.CssClass = "blackfnt";
        tr3tc3.Wrap = false;
        tr3tc3.HorizontalAlign = HorizontalAlign.Right;
        tr3.CssClass = "bgbluegrey";

        tr3.Cells.Add(tr3tc3);

        tr3tc4.Text = CASH_OPNCredit.ToString("F2");
        tr3tc4.CssClass = "blackfnt";
        tr3tc4.Wrap = false;
        tr3tc4.HorizontalAlign = HorizontalAlign.Right;
        tr3.CssClass = "bgbluegrey";

        tr3.Cells.Add(tr3tc4);

        tr3tc5.Text = BANK_OPNDEBIT.ToString("F2");
        tr3tc5.CssClass = "blackfnt";
        tr3tc5.Wrap = false;
        tr3.CssClass = "bgbluegrey";
        tr3tc5.HorizontalAlign = HorizontalAlign.Right;
        tr3.Cells.Add(tr3tc5);

        tr3tc6.Text = BANK_OPNCredit.ToString("F2");
        tr3tc6.CssClass = "blackfnt";
        tr3tc6.Wrap = false;
        tr3.CssClass = "bgbluegrey";
        tr3tc6.HorizontalAlign = HorizontalAlign.Right;
        tr3.Cells.Add(tr3tc6);



        tr3.BackColor = System.Drawing.Color.White;
        TBL_CBS.Rows.Add(tr3);


        dr1.Close();

        String SQL_ACC = "select m.acccode,oppaccount,oppacccode,d.groupcode,debit ,credit,chqno,voucherNo,Narration ,Transdate,Convert(varchar,Transdate,106) as Voucher_date,acccategory,pbov_name,pbov_code,CASH_Debit=(case when acccategory='CASH' then  debit else 0 end) ,CASH_Credit=(case when acccategory='CASH' then  credit else 0 end) ,Bank_Debit=(case when acccategory='BANK' then  debit else 0 end) ,Bank_Credit=(case when acccategory='BANK' then  credit else 0 end),Bank_name=(select top 1  accdesc from webx_acctinfo where acccode=m.acccode)  from " + AcctOpenTable + " M," + AcctTable + " D where Voucher_cancel='N' and (M.debit<>m.credit) and m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between convert(datetime,'" + fromdt_s + "',106) and Convert(datetime,'" + strArrDtFromTo[1] + "',106) Order  by transdate,voucherno";

        SqlCommand cmd1 = new SqlCommand(SQL_ACC, conn);


        SqlDataReader drvlist = cmd1.ExecuteReader();
        int srno = 0;
        srno = 1;
        while (drvlist.Read())
        {
            TableRow tr4 = new TableRow();

            TableCell tr4tc1 = new TableCell();
            TableCell tr4tc2 = new TableCell();
            TableCell tr4tc3 = new TableCell();
            TableCell tr4tc4 = new TableCell();
            TableCell tr4tc5 = new TableCell();
            TableCell tr4tc6 = new TableCell();
            TableCell tr4tc7 = new TableCell();
            TableCell tr4tc8 = new TableCell();
            TableCell tr4tc9 = new TableCell();
            TableCell tr4tc10 = new TableCell();
            TableCell tr4tc11 = new TableCell();
            tr4tc1.Text = srno.ToString();
            tr4tc1.CssClass = "blackfnt";
            tr4tc1.Wrap = false;
            // tr4tc1.RowSpan = 2;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4tc1);

            tr4tc2.Text = drvlist["voucherNo"].ToString();
            tr4tc2.CssClass = "blackfnt";
            tr4tc2.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4tc2);

            tr4tc3.Text = drvlist["Voucher_date"].ToString();
            tr4tc3.CssClass = "blackfnt";
            tr4tc3.Wrap = false;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc3);

            tr4tc4.Text = drvlist["pbov_code"].ToString() + " : " + drvlist["pbov_name"].ToString();
            tr4tc4.CssClass = "blackfnt";
            // tr4tc4.Wrap = false;
            tr4.CssClass = "bgbluegrey";
            tr4tc4.HorizontalAlign = HorizontalAlign.Left;
            tr4.Cells.Add(tr4tc4);

            tr4tc5.Text = drvlist["oppaccount"].ToString();
            tr4tc5.CssClass = "blackfnt";
            //tr4tc5.Wrap = false;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc5);

            tr4tc6.Text = drvlist["Bank_name"].ToString();
            tr4tc6.CssClass = "blackfnt";
            //tr4tc6.Wrap = false;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc6);

            tr4tc7.Text = drvlist["chqno"].ToString();
            tr4tc7.CssClass = "blackfnt";
            tr4tc7.Wrap = false;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc7);

            tr4tc8.Text = drvlist["CASH_Debit"].ToString();
            tr4tc8.CssClass = "blackfnt";
            tr4tc8.Wrap = false;
            tr4tc8.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc8);

            tr4tc9.Text = drvlist["CASH_Credit"].ToString();
            tr4tc9.CssClass = "blackfnt";
            tr4tc9.Wrap = false;
            tr4tc9.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc9);

            tr4tc10.Text = drvlist["Bank_Debit"].ToString();
            tr4tc10.CssClass = "blackfnt";
            tr4tc10.Wrap = false;
            tr4tc10.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc10);

            tr4tc11.Text = drvlist["Bank_Credit"].ToString();
            tr4tc11.CssClass = "blackfnt";
            tr4tc11.Wrap = false;
            tr4tc11.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";

            tr4.Cells.Add(tr4tc11);

            tr4.HorizontalAlign = HorizontalAlign.Center;
            tr4.BackColor = System.Drawing.Color.White;
            TBL_CBS.Rows.Add(tr4);

            TableRow tr5 = new TableRow();

            TableCell tr5tc1 = new TableCell();
            TableCell tr5tc2 = new TableCell();
            TableCell tr5tc3 = new TableCell();
            TableCell tr5tc4 = new TableCell();
            TableCell tr5tc5 = new TableCell();
            TableCell tr5tc6 = new TableCell();

            tr5tc1.Text = "";
            tr5tc1.CssClass = "blackfnt";
            tr5tc1.Wrap = false;
            // tr5tc1.RowSpan = 2;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc1);

            tr5tc2.Text = drvlist["Narration"].ToString();
            tr5tc2.CssClass = "blackfnt";
            // tr5tc2.Wrap = false;
            tr5tc2.ColumnSpan = 6;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc2);

            tr5tc3.Text = "";
            tr5tc3.CssClass = "blackfnt";
            tr5tc3.Wrap = false;
            tr5tc3.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";

            tr5.Cells.Add(tr5tc3);

            tr5tc4.Text = "";
            tr5tc4.CssClass = "blackfnt";
            tr5tc4.Wrap = false;
            tr5tc4.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";

            tr5.Cells.Add(tr5tc4);

            tr5tc5.Text = "";
            tr5tc5.CssClass = "blackfnt";
            tr5tc5.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5tc5.HorizontalAlign = HorizontalAlign.Right;
            tr5.Cells.Add(tr5tc5);

            tr5tc6.Text = "";
            tr5tc6.CssClass = "blackfnt";
            tr5tc6.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5tc6.HorizontalAlign = HorizontalAlign.Right;
            tr5.Cells.Add(tr5tc6);


            tr5.Height = 30;
            tr5.BackColor = System.Drawing.Color.White;
            TBL_CBS.Rows.Add(tr5);

            tot_cashcredit += Convert.ToDouble(drvlist["CASH_Credit"].ToString()) + 0;
            tot_cashdebit += Convert.ToDouble(drvlist["CASH_Debit"].ToString()) + 0;
            tot_bankcredit += Convert.ToDouble(drvlist["Bank_Credit"].ToString()) + 0;
            tot_bankdebit += Convert.ToDouble(drvlist["Bank_Debit"].ToString()) + 0;


            srno = srno + 1;
        }

        cashclosedebit = tot_cashdebit + CASH_OPNDEBIT + 0;
        bankClosecredit = tot_bankcredit + BANK_OPNCredit;
        bankClosedebit = tot_bankdebit + BANK_OPNDEBIT;
        cashclosecredit = tot_cashcredit + CASH_OPNCredit;


        if (cashclosecredit > cashclosedebit)
        {
            cashclosecredit = cashclosecredit - cashclosedebit;
            cashclosedebit = 0;
        }
        else
        {
            cashclosedebit = cashclosedebit - cashclosecredit;
            cashclosecredit = 0;
        }

        if (bankClosecredit > bankClosedebit)
        {
            bankClosecredit = bankClosecredit - bankClosedebit;
            bankClosedebit = 0;
        }
        else
        {
            bankClosedebit = bankClosedebit - bankClosecredit;
            bankClosecredit = 0;
        }

        drvlist.Close();



        TableRow tr6 = new TableRow();

        TableCell tr6tc1 = new TableCell();
        TableCell tr6tc2 = new TableCell();
        TableCell tr6tc3 = new TableCell();
        TableCell tr6tc4 = new TableCell();
        TableCell tr6tc5 = new TableCell();
        TableCell tr6tc6 = new TableCell();

        tr6tc1.Text = "";
        tr6tc1.CssClass = "blackfnt";
        tr6tc1.Wrap = false;
        // tr6tc1.RowSpan = 2;
        tr6.CssClass = "bgbluegrey";
        tr6.Cells.Add(tr6tc1);

        tr6tc2.Text = "Closing Balance C/F";
        tr6tc2.CssClass = "blackfnt";
        tr6tc2.Wrap = false;
        tr6tc2.ColumnSpan = 6;
        tr6.CssClass = "bgbluegrey";
        tr6.Cells.Add(tr6tc2);

        tr6tc3.Text = cashclosedebit.ToString("F2");
        tr6tc3.CssClass = "blackfnt";
        tr6tc3.Wrap = false;
        tr6tc3.HorizontalAlign = HorizontalAlign.Right;
        tr6.CssClass = "bgbluegrey";

        tr6.Cells.Add(tr6tc3);

        tr6tc4.Text = cashclosecredit.ToString("F2");
        tr6tc4.CssClass = "blackfnt";
        tr6tc4.Wrap = false;
        tr6tc4.HorizontalAlign = HorizontalAlign.Right;
        tr6.CssClass = "bgbluegrey";

        tr6.Cells.Add(tr6tc4);

        tr6tc5.Text = bankClosedebit.ToString("F2");
        tr6tc5.CssClass = "blackfnt";
        tr6tc5.Wrap = false;
        tr6.CssClass = "bgbluegrey";
        tr6tc5.HorizontalAlign = HorizontalAlign.Right;
        tr6.Cells.Add(tr6tc5);

        tr6tc6.Text = bankClosecredit.ToString("F2");
        tr6tc6.CssClass = "blackfnt";
        tr6tc6.Wrap = false;
        tr6.CssClass = "bgbluegrey";
        tr6tc6.HorizontalAlign = HorizontalAlign.Right;
        tr6.Cells.Add(tr6tc6);



        tr6.BackColor = System.Drawing.Color.White;
        TBL_CBS.Rows.Add(tr6);


        TableRow tr7 = new TableRow();

        TableCell tr7tc1 = new TableCell();
        TableCell tr7tc2 = new TableCell();
        TableCell tr7tc3 = new TableCell();
        TableCell tr7tc4 = new TableCell();
        TableCell tr7tc5 = new TableCell();
        TableCell tr7tc6 = new TableCell();

        tr7tc1.Text = "";
        tr7tc1.CssClass = "blackfnt";
        tr7tc1.Wrap = false;
        // tr7tc1.RowSpan = 2;
        tr7.CssClass = "bgbluegrey";
        tr7.Cells.Add(tr7tc1);

        tr7tc2.Text = "Total";
        tr7tc2.CssClass = "blackboldfnt";
        tr7tc2.Wrap = false;
        tr7tc2.ColumnSpan = 6;
        tr7.CssClass = "bgbluegrey";
        tr7.Cells.Add(tr7tc2);

        tr7tc3.Text = tot_cashdebit.ToString("F2");
        tr7tc3.CssClass = "blackboldfnt";
        tr7tc3.Wrap = false;
        tr7tc3.HorizontalAlign = HorizontalAlign.Right;
        tr7.CssClass = "bgbluegrey";

        tr7.Cells.Add(tr7tc3);

        tr7tc4.Text = tot_cashcredit.ToString("F2");
        tr7tc4.CssClass = "blackboldfnt";
        tr7tc4.Wrap = false;
        tr7tc4.HorizontalAlign = HorizontalAlign.Right;
        tr7.CssClass = "bgbluegrey";

        tr7.Cells.Add(tr7tc4);

        tr7tc5.Text = tot_bankdebit.ToString("F2");
        tr7tc5.CssClass = "blackboldfnt";
        tr7tc5.Wrap = false;
        tr7.CssClass = "bgbluegrey";
        tr7tc5.HorizontalAlign = HorizontalAlign.Right;
        tr7.Cells.Add(tr7tc5);

        tr7tc6.Text = tot_bankcredit.ToString("F2");
        tr7tc6.CssClass = "blackboldfnt";
        tr7tc6.Wrap = false;
        tr7.CssClass = "bgbluegrey";
        tr7tc6.HorizontalAlign = HorizontalAlign.Right;
        tr7.Cells.Add(tr7tc6);



        tr7.BackColor = System.Drawing.Color.White;
        TBL_CBS.Rows.Add(tr7);
    }

    //protected void pgChange(object sender, GridViewPageEventArgs e)
    //{
        
    //            GridView1.PageIndex = e.NewPageIndex;
           
           

    //    DisplayDocFlow();


    //}

    //private void DisplayDocFlow()
    //{

    //    conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    String BankCashCls;

    //    if (ACCOunts == "0")
    //    {
    //        BankCashCls = "and ( acccategory='CASH' OR ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')) ";
    //    }
    //    else if (ACCOunts == "1")
    //    {
    //        BankCashCls =" and ((bkloccode like '%" +strro+ "%' or bkloccode='ALL' ) AND acccategory='BANK')";
    //    }
    //    else if (ACCOunts == "2")
    //    {
    //        BankCashCls =" and d.acccategory ='CASH'";
    //    }
    //    else
    //    {
    //        BankCashCls =" and d.acccode ='"+ACCOunts+"'";
    //    }

    //        //String	branchcls=" and m.brcd='" +  strro + "'";
        
    //    string[] strArrDtFromTo = strDateRange.Split('-');
    //    String SQL_ACC = "select m.acccode,oppaccount,oppacccode,d.groupcode,debit ,credit,chqno,voucherNo,Narration ,Transdate,Convert(varchar,Transdate,106) as Voucher_date,acccategory,CASH_Debit=(case when acccategory='CASH' then  debit else 0 end) ,CASH_Credit=(case when acccategory='CASH' then  credit else 0 end) ,Bank_Debit=(case when acccategory='BANK' then  debit else 0 end) ,Bank_Credit=(case when acccategory='BANK' then  credit else 0 end),Bank_name=(select top 1  accdesc from webx_acctinfo where acccode=m.acccode)  from " + AcctOpenTable + " M," + AcctTable + " D where Voucher_cancel='N' and (M.debit<>m.credit) and m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between Convert(datetime,'" + strArrDtFromTo[0] + "',106) and Convert(datetime,'" + strArrDtFromTo[1] + "',106) Order  by transdate,voucherno";

    //    SqlCommand cmd1 = new SqlCommand(SQL_ACC, conn);

    //    SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);

    //    DataSet ds = new DataSet();

    //    sqlDA.Fill(ds);

    //    GridView1.DataSource = ds;
    //    GridView1.DataBind();


    //    GridView1.Visible = true;

    //    conn.Close();

    //}

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("content-disposition", "attachment; filename=Location_Report.xls");
        //BindGrid();
        string strFinalQS;

        //string dtFrom, dtTo;
        //dtFrom = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        // dtTo = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];


        string ro = Request.QueryString.Get("ro");
        string Flowtype = Request.QueryString.Get("Flowtype");
        string RO = Request.QueryString.Get("RO");
        string DOCDate = Request.QueryString.Get("DOCDate");
        string ACCOunts = Request.QueryString.Get("ACCOunts");

        strFinalQS = "?DOCDate=" + DOCDate;
        strFinalQS = strFinalQS + "&RO=" + RO;
        //strFinalQS = strFinalQS + "&Location=" + strloc;
        strFinalQS = strFinalQS + "&Flowtype=" + Flowtype;
        strFinalQS = strFinalQS + "&ACCOunts=" + ACCOunts;

        Response.Redirect("Cumulative_Result_PL_xls.aspx" + strFinalQS);

    }
}
