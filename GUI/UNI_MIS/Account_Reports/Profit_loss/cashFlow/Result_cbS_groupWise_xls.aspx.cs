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
    public static string strDateRange, strindividial, opendtrange,branchcls,FROMDT, rptfromdt,rpttodt,ACCOunts, finyearstart, strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition", "attachment; filename=CASH_BANK_FLOW_GROPwise.xls");

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
            mAcctTransTable = "webx_acctrans_" + yearSuffix;
            AcctOpenTable = "webx_acctrans_" + yearSuffix;
            AcctTable = "webx_acctinfo";
            strindividial = Request.QueryString["strindividial"].ToString();
            strDateRange = Request.QueryString["DOCDate"].ToString();
            String[] strDateRange_ARR = strDateRange.Split('-');
            lblseldet.Text = strDateRange;
            FROMDT = strDateRange_ARR[0].ToString().Trim();
            rptfromdt = strDateRange_ARR[0].ToString().Trim();
            rpttodt = strDateRange_ARR[1].ToString().Trim();
           
            
            DateTime frmdt = Convert.ToDateTime(FROMDT);
            
            //Response.Write("<br> frmdt : " + frmdt);
            frmdt = frmdt.AddDays(-1);
           // Response.Write("<br> frmdt : " + frmdt);
            string[] strArrDtFrom = frmdt.ToString("dd/MM/yyyy").Split('/');
           // DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            FROMDT = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            //Response.Write("<br> frmdt : " + FROMDT);
            if (finyearstart.ToUpper().CompareTo(strDateRange_ARR[0].ToUpper().ToString().Trim()) == 0)
            {
                FROMDT = finyearstart;
            }
            strro = Request.QueryString["RO"].ToString();
           lblro.Text = strro;
            ACCOunts = Request.QueryString["ACCOunts"].ToString();
           
            
        }

        BindGrid();
       // DisplayDocFlow();
        
    }

    private void BindGrid()
    {
        
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        String BankCashCls;
       

        if (ACCOunts == "0")
        {
            BankCashCls = "and ( acccategory='CASH' OR ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')) ";
        }
        else if (ACCOunts == "1")
        {
            BankCashCls = " and ((bkloccode like '%" + strro + "%' or bkloccode='ALL' ) AND acccategory='BANK')";
        }
        else if (ACCOunts == "2")
        {
            BankCashCls = " and d.acccategory ='CASH'";
        }
        else
        {
            BankCashCls = " and m.acccode ='" + ACCOunts + "'";
        }


        if (strindividial == "Y")
        {
            branchcls = " and m.brcd='" + strro + "'";
        }
        else
        {
            if (strro == Session["HeadOfficeCode"].ToString())
            {
                branchcls = "";
            }
            else
            {
                branchcls = " and m.brcd='" + strro + "'";
            }
        }



        ///opendtrange = "And (convert(varchar,transdate,106) between convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + FROMDT + "',106))";

        String SQL_opnBal = "exec WEBX_cbs_mis '" + mAcctTransTable + "','" + ACCOunts + "','" + finyearstart + "','" + FROMDT + "','" + strro + "','"+strindividial+"' ";
        //Response.Write("<br> SQL_opnBal : " + SQL_opnBal);
        SqlCommand sqlcmd1 = new SqlCommand(SQL_opnBal, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd1.ExecuteReader();
        dr1.Read();
        string OpenBalance, CloseBalance;
        double opencredit = 0, opendebit = 0, Closecredit = 0, Closedebit = 0;

        opencredit = Convert.ToDouble(dr1["cr"]);
        opendebit = Convert.ToDouble(dr1["dr"]);

        Closecredit=opencredit;
        Closedebit = opendebit;
        if (opendebit > opencredit)
        {
            opendebit=opendebit-opencredit;
			opencredit=0;
			OpenBalance =opendebit.ToString("F2") + " Dr";
        }
        else
        {
            opencredit=opencredit-opendebit;
			opendebit=0;
            OpenBalance = opencredit.ToString("F2") + " Cr";
        }

        dr1.Close();

        TableRow tr = new TableRow();

        TableCell tc1 = new TableCell();
        TableCell tc2 = new TableCell();

        tc1.Text = "Inflow ";
        tc1.CssClass = "blackboldfnt";
        tc1.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc1);

        tc2.Text = "Amount";
        tc2.HorizontalAlign = HorizontalAlign.Center;
        tc2.CssClass = "blackboldfnt";        
        tc2.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc2);
        tblheadache.Rows.Add(tr);


        TableRow tr1 = new TableRow();

        TableCell tr1tc1 = new TableCell();
        TableCell tr1tc2 = new TableCell();

        tr1tc1.Text = "Opening Balance ";
        tr1tc1.CssClass = "blackboldfnt";
        tr1tc1.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc1);

        tr1tc2.Text = OpenBalance;
        tr1tc2.CssClass = "blackboldfnt";
        tr1tc2.HorizontalAlign = HorizontalAlign.Right;
        tr1tc2.Wrap = false;
        tr1.CssClass = "bgbluegrey";
        tr1.Cells.Add(tr1tc2);
        tblheadache.Rows.Add(tr1);

        TableRow tr2 = new TableRow();

        TableCell tr2tc1 = new TableCell();
        TableCell tr2tc2 = new TableCell();

        tr2tc1.Text = "Receipts";
        tr2tc1.CssClass = "blackboldfnt";
        tr2tc1.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc1);

        tr2tc2.Text = "";
        tr2tc2.CssClass = "blackboldfnt";
        tr2tc2.HorizontalAlign = HorizontalAlign.Right;
        tr2tc2.Wrap = false;
        tr2.CssClass = "bgbluegrey";
        tr2.Cells.Add(tr2tc2);
        tblheadache.Rows.Add(tr2);

        String SQL_RECIPT = " select oppaccount,oppacccode,cast(isnull(sum(debit),0) as decimal(9,2)) AS DEBIT,groupdesc from " + mAcctTransTable + " M , vw_acctgroup  D with(NOLOCK)  where Voucher_cancel='N' and (M.debit > 0) and m.oppacccode=d.acccode  " + BankCashCls + branchcls + " AND (convert(varchar,transdate,106) between convert(datetime,'" + rptfromdt + "',106) and convert(datetime,'" + rpttodt + "',106)) group by groupdesc,oppaccount,oppacccode order by groupdesc,oppaccount,oppacccode";
        //Response.Write("<br> SQL_opnBal : " + SQL_RECIPT);
        SqlCommand sqlcmd21 = new SqlCommand(SQL_RECIPT, conn);
        SqlDataReader dr21;
        dr21 = sqlcmd21.ExecuteReader();

        string Str_groupdesc = "", PrevStr_groupdesc = "";

        double total_debit = 0, amt_debit = 0, grpamt_debit=0;
        while (dr21.Read())
        {
            TableRow tr3a = new TableRow();

            TableCell tr3atc1 = new TableCell();
            TableCell tr3atc2 = new TableCell();

            amt_debit = Convert.ToDouble(dr21["DEBIT"]);
            grpamt_debit += amt_debit;
            amt_debit = 0;

            Str_groupdesc = dr21["groupdesc"].ToString();

            if (Str_groupdesc != PrevStr_groupdesc || PrevStr_groupdesc == "")
            {
                tr3atc2.Text = dr21["groupdesc"].ToString();
                tr3atc2.CssClass = "blackboldfnt";
                tr3atc2.HorizontalAlign = HorizontalAlign.Left;
                tr3atc2.Wrap = false;
                tr3atc2.ColumnSpan = 2;
                tr3a.CssClass = "bgbluegrey";
                tr3a.Cells.Add(tr3atc2);
                tr3a.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr3a);
            }

            TableRow tr3 = new TableRow();

            TableCell tr3tc1 = new TableCell();
            TableCell tr3tc2 = new TableCell();

            tr3tc1.Text = dr21["oppacccode"].ToString() + ":" + dr21["oppaccount"].ToString();
            tr3tc1.CssClass = "blackfnt";
            tr3tc1.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc1);

            tr3tc2.Text = dr21["DEBIT"].ToString();
            tr3tc2.CssClass = "blackfnt";
            tr3tc2.HorizontalAlign = HorizontalAlign.Right;
            tr3tc2.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3tc2);
            tr3.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr3);

            if (Str_groupdesc != PrevStr_groupdesc )
            {
                TableRow tr3b = new TableRow();

                TableCell tr3btc1 = new TableCell();
                TableCell tr3btc2 = new TableCell();

                tr3btc2.Text = grpamt_debit.ToString("F2");
                tr3btc2.CssClass = "blackboldfnt";
                tr3btc2.HorizontalAlign = HorizontalAlign.Right;
                tr3btc2.Wrap = false;
                tr3btc2.ColumnSpan = 2;
                tr3b.CssClass = "bgbluegrey";
                tr3b.Cells.Add(tr3btc2);
                tr3b.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr3b);

                grpamt_debit = 0;
            }

            total_debit += Convert.ToDouble(dr21["DEBIT"]);
            Closedebit += Convert.ToDouble(dr21["DEBIT"]);
            PrevStr_groupdesc = dr21["groupdesc"].ToString();
        }
        dr21.Close();

        TableRow tr4 = new TableRow();

        TableCell tr4tc1 = new TableCell();
        TableCell tr4tc2 = new TableCell();

        tr4tc1.Text = "Total";
        tr4tc1.CssClass = "blackboldfnt";
        tr4tc1.Wrap = false;
        tr4.CssClass = "bgbluegrey";
        tr4.Cells.Add(tr4tc1);

        tr4tc2.Text = total_debit.ToString("F2");
        tr4tc2.CssClass = "blackboldfnt";
        tr4tc2.HorizontalAlign = HorizontalAlign.Right;
        tr4tc2.Wrap = false;
        tr4.CssClass = "bgbluegrey";
        tr4.Cells.Add(tr4tc2);
        tblheadache.Rows.Add(tr4);

        TableRow tr5 = new TableRow();

        TableCell tr5tc1 = new TableCell();
        TableCell tr5tc2 = new TableCell();

        tr5tc1.Text = "Outflow";
        tr5tc1.CssClass = "blackboldfnt";
        tr5tc1.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5tc1);

        tr5tc2.Text = "";
        tr5tc2.CssClass = "blackboldfnt";
        tr5tc2.HorizontalAlign = HorizontalAlign.Right;
        tr5tc2.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5tc2);
        tblheadache.Rows.Add(tr5);

        String SQL_OutFlow = "select oppaccount,oppacccode,groupdesc,cast(isnull(sum(credit),0) as decimal(9,2)) AS credit  from " + mAcctTransTable + " M with(NOLOCK)  ,vw_acctgroup D with(NOLOCK) where Voucher_cancel='N' and (M.credit > 0) and m.oppacccode=d.acccode  " + BankCashCls + branchcls + " AND (convert(varchar,transdate,106) between convert(datetime,'" + rptfromdt + "',106) and convert(datetime,'" + rpttodt + "',106)) group by groupdesc,oppaccount,oppacccode order by groupdesc,oppaccount,oppacccode";

        //Response.Write("<br> SQL_opnBal : " + SQL_OutFlow);
        SqlCommand sqlcmd22 = new SqlCommand(SQL_OutFlow, conn);
        SqlDataReader dr22;
        String Str_groupdesc1 = "", PrevStr_groupdesc1 = "";
        dr22 = sqlcmd22.ExecuteReader();

        double total_credit = 0, amt_credit = 0, grpamt_credit = 0;
        while (dr22.Read())
        {
            TableRow tr6 = new TableRow();

            TableCell tr6tc1 = new TableCell();
            TableCell tr6tc2 = new TableCell();

            amt_credit = Convert.ToDouble(dr22["credit"]);
            grpamt_credit += amt_credit;
            amt_credit = 0;

            Str_groupdesc1 = dr22["groupdesc"].ToString();

            if (Str_groupdesc1 != PrevStr_groupdesc1 || PrevStr_groupdesc1 == "")
            {
                TableRow tr6a = new TableRow();

                TableCell tr6atc1 = new TableCell();
                TableCell tr6atc2 = new TableCell();

                tr6atc2.Text = dr22["groupdesc"].ToString();
                tr6atc2.CssClass = "blackboldfnt";
                tr6atc2.HorizontalAlign = HorizontalAlign.Left;
                tr6atc2.Wrap = false;
                tr6atc2.ColumnSpan = 2;
                tr6a.CssClass = "bgbluegrey";
                tr6a.Cells.Add(tr6atc2);
                tr6a.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr6a);
            }


            tr6tc1.Text = dr22["oppacccode"].ToString() + ":" + dr22["oppaccount"].ToString();
            tr6tc1.CssClass = "blackfnt";
            tr6tc1.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc1);

            tr6tc2.Text = dr22["credit"].ToString();
            tr6tc2.CssClass = "blackfnt";
            tr6tc2.HorizontalAlign = HorizontalAlign.Right;
            tr6tc2.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc2);
            tr6.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr6);

            if (Str_groupdesc1 != PrevStr_groupdesc1)
            {
                TableRow tr3b = new TableRow();

                TableCell tr3btc1 = new TableCell();
                TableCell tr3btc2 = new TableCell();

                tr3btc2.Text = grpamt_credit.ToString("F2");
                tr3btc2.CssClass = "blackboldfnt";
                tr3btc2.HorizontalAlign = HorizontalAlign.Right;
                tr3btc2.Wrap = false;
                tr3btc2.ColumnSpan = 2;
                tr3b.CssClass = "bgbluegrey";
                tr3b.Cells.Add(tr3btc2);
                tr3b.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr3b);

                grpamt_credit = 0;
            }

            PrevStr_groupdesc1 = dr22["groupdesc"].ToString();

            total_credit += Convert.ToDouble(dr22["credit"]);
            Closecredit += Convert.ToDouble(dr22["credit"]);
        }
        dr22.Close();

        TableRow tr7 = new TableRow();

        TableCell tr7tc1 = new TableCell();
        TableCell tr7tc2 = new TableCell();

        tr7tc1.Text = "Total";
        tr7tc1.CssClass = "blackboldfnt";
        tr7tc1.Wrap = false;
        tr7.CssClass = "bgbluegrey";
        tr7.Cells.Add(tr7tc1);

        tr7tc2.Text = total_credit.ToString("F2");
        tr7tc2.CssClass = "blackboldfnt";
        tr7tc2.HorizontalAlign = HorizontalAlign.Right;
        tr7tc2.Wrap = false;
        tr7.CssClass = "bgbluegrey";
        tr7.Cells.Add(tr7tc2);
        tblheadache.Rows.Add(tr7);


        if (Closecredit > Closedebit)
        {
            Closecredit = Closecredit - Closedebit;
            Closedebit = 0;
            CloseBalance =Closecredit.ToString("F2")+ " Cr";
        }
        else
        {
            Closedebit = Closedebit - Closecredit;
            Closecredit = 0;
            CloseBalance = Closedebit.ToString("F2") + " Dr";
        }

        TableRow tr8 = new TableRow();

        TableCell tr8tc1 = new TableCell();
        TableCell tr8tc2 = new TableCell();

        tr8tc1.Text = "Closing Balance ";
        tr8tc1.CssClass = "blackboldfnt";
        tr8tc1.Wrap = false;
        tr8.CssClass = "bgbluegrey";
        tr8.Cells.Add(tr8tc1);

        tr8tc2.Text = CloseBalance;
        tr8tc2.CssClass = "blackboldfnt";
        tr8tc2.HorizontalAlign = HorizontalAlign.Right;
        tr8tc2.Wrap = false;
        tr8.CssClass = "bgbluegrey";
        tr8.Cells.Add(tr8tc2);
        tblheadache.Rows.Add(tr8);


        String SQL_bottom = " select Name,locname=(select top 1 locname from webx_location where loccode='" + Session["brcd"] + "' ), DATE_TIME=(convert(varchar,getdate(),106) + ' ' + convert(varchar,getdate(),108))from WebX_Master_Users where UserID='" + Session["empcd"] + "'";
       //String SQL_top = "select BANK_OPNDEBIT=sum(case when acccategory='BANK' then debit else 0 end),BANK_OPNCredit=sum(case when acccategory='BANK' then credit else 0 end),CASH_OPNDEBIT=sum(case when acccategory='CASH' then debit else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then credit else 0 end)  from " + AcctOpenTable + " M," + AcctTable + " D where m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106)  ";

       SqlCommand sqlcmd2 = new SqlCommand(SQL_bottom, conn);
       SqlDataReader dr2;
       dr2 = sqlcmd2.ExecuteReader();
       dr2.Read();

       lblPrepareBy.Text = Convert.ToString(dr2["Name"]);
       lblAt.Text = Convert.ToString(dr2["locname"]);
       lblDateTime.Text = Convert.ToString(dr2["DATE_TIME"]);

       dr2.Close();

       conn.Close();
    }

    

    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    //Response.ContentType = "application/vnd.ms-excel";
    //    //Response.AddHeader("content-disposition", "attachment; filename=Location_Report.xls");
    //    //BindGrid();
    //    string strFinalQS;

    //    //string dtFrom, dtTo;
    //    //dtFrom = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
    //    // dtTo = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];


    //    string ro = Request.QueryString.Get("ro");
    //    string Flowtype = Request.QueryString.Get("Flowtype");
    //    string RO = Request.QueryString.Get("RO");
    //    string DOCDate = Request.QueryString.Get("DOCDate");
    //    string ACCOunts = Request.QueryString.Get("ACCOunts");
        

    //    strFinalQS = "?DOCDate=" + DOCDate;
    //    strFinalQS = strFinalQS + "&RO=" + RO;
    //    //strFinalQS = strFinalQS + "&Location=" + strloc;
    //    strFinalQS = strFinalQS + "&Flowtype=" + Flowtype;
    //    strFinalQS = strFinalQS + "&ACCOunts=" + ACCOunts;

    //    Response.Redirect("Cumulative_Result_CBS_xls.aspx" + strFinalQS);

    //}
}
