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

public partial class GUI_UNI_MIS_Account_Reports_Trail_balance_Voucherlist_trailbalance : System.Web.UI.Page
{

    public static string loccode, acccode, accodesc, startdate, enddate, strindividual;
    public static string mAcctTransTable, AcctOpenTable, AcctTable, mGroupTable, YearString, yearSuffix, finyearstart;
    SqlConnection conn, conn1;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition", "attachment; filename=Trail_balance_VoucherList.xls");
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            String Query_str = Request.QueryString["Query_str"].ToString();
            // Response.Write("<br> RO ; " + RO + "<br>");
            Query_str = Query_str.Replace("%7e", "~");
            Query_str = Query_str.Replace("+", " ");
            //Response.Write("<br> RO ; " + Query_str);
            string[] Query_str_arr = Query_str.Split('~');



            loccode = Query_str_arr[0].ToString();
            acccode = Query_str_arr[1].ToString();
            accodesc = Query_str_arr[2].ToString();
            startdate = Query_str_arr[3].ToString();
            enddate = Query_str_arr[4].ToString();
            strindividual= Query_str_arr[5].ToString();

            lblro.Text = loccode;
            lblrpt.Text = accodesc + " ~ " + acccode;
            lblseldet.Text = startdate + " - " + enddate;

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


             mAcctTransTable = "webx_acctopening_" + yearSuffix;
            AcctOpenTable = "webx_acctrans_" + yearSuffix;
            AcctTable = "webx_acctinfo";
            mGroupTable = "webx_groups";

        }
        String SQL_1 = "", SQL_OPNBAL="";


            if (strindividual == "N")
            {
                SQL_1 = "SELECT year(transdate) as year1 ,month(transdate) as month1 ,vaoucherdt=convert(varchar,transdate,106), t.transdate, t.acccode, t.transtype, t.voucherno, t.narration,t.payto, cast(t.debit as decimal(9,2)) as debit,cast(t.credit as decimal(9,2)) as credit, srno,t.oppaccount from " + AcctOpenTable + " t  with(NOLOCK) where  t.voucher_cancel='N'  and t.acccode='" + acccode + "' and  convert(varchar,t.transdate,106) between convert(datetime,'" + startdate + "',106) and convert(datetime,'" + enddate + "',106) order by transdate";
                SQL_OPNBAL = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,o.opendebit as opendebit ,o.opencredit as opendebit from " + mGroupTable + " g, " + AcctTable + " a," + mAcctTransTable + " o where a.acccode*=o.acccode and g.groupcode=a.groupcode and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
            }
            else
            {
                SQL_1 = "SELECT year(transdate) as year1 ,month(transdate) as month1 ,vaoucherdt=convert(varchar,transdate,106), t.transdate, t.acccode, t.transtype, t.voucherno, t.narration,t.payto, cast(t.debit as decimal(9,2)) as debit,cast(t.credit as decimal(9,2)) as credit, srno,t.oppaccount from " + AcctOpenTable + " t  with(NOLOCK) where  t.voucher_cancel='N'  and t.acccode='" + acccode + "' and t.brcd='" + loccode + "' and convert(varchar,t.transdate,106) between convert(datetime,'" + startdate + "',106) and convert(datetime,'" + enddate + "',106) order by transdate";
                SQL_OPNBAL = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,o.opendebit_i as opendebit ,o.opencredit_i as opendebit from " + mGroupTable + " g, " + AcctTable + " a," + mAcctTransTable + " o where a.acccode*=o.acccode and g.groupcode=a.groupcode and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
            }

           // Response.Write("<br> SQL_1 : " + SQL_1);
            SqlCommand cmd_opn = new SqlCommand(SQL_OPNBAL, conn);
            SqlDataReader dr_opn;
            dr_opn = cmd_opn.ExecuteReader();

            double opn_debit = 0, opn_credit = 0;
            while (dr_opn.Read())
            {
                opn_debit = Convert.ToDouble(dr_opn["opendebit"]);
                opn_credit = Convert.ToDouble(dr_opn["opendebit"]);
            }
            dr_opn.Close();

            SqlCommand cmd = new SqlCommand(SQL_1, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();

            TableRow tr = new TableRow();

            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc3 = new TableCell();

            TableCell tc4 = new TableCell();
            TableCell tc5 = new TableCell();
            TableCell tc6 = new TableCell();

            TableCell tc7 = new TableCell();
            //TableCell tc8 = new TableCell();
            //TableCell tc9 = new TableCell();


            tc1.Text = "S No";
            tc1.CssClass = "blackfnt";
            tc1.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc1);

            tc2.Text = "Voucher No.";
            tc2.CssClass = "blackfnt";
            tc2.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc2);

            tc3.Text = "Date";
            tc3.CssClass = "blackfnt";
            tc3.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc3);

            tc4.Text = "Particular";
            tc4.CssClass = "blackfnt";
            tc4.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc4);

            tc5.Text = "Debit";
            tc5.CssClass = "blackfnt";
            tc5.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc5);

            tc6.Text = "Credit";
            tc6.CssClass = "blackfnt";
            tc6.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc6);

            tc7.Text = "Narration";
            tc7.CssClass = "blackfnt";
            tc7.Wrap = false;
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc7);

            tblheadache.Rows.Add(tr);
            TableRow tr1 = new TableRow();

            TableCell tr1tc1 = new TableCell();
            tr1tc1.Text = acccode +" : "+ accodesc;
            tr1tc1.CssClass = "blackboldfnt";
            tr1tc1.Wrap = false;
            tr1tc1.ColumnSpan = 7;
            tr1.CssClass = "bgbluegrey";
            tr1.Cells.Add(tr1tc1);

            tblheadache.Rows.Add(tr1);


            TableRow tr1i = new TableRow();

            TableCell tr1itc1 = new TableCell();
            TableCell tr1itc2 = new TableCell();
            TableCell tr1itc3 = new TableCell();

            TableCell tr1itc4 = new TableCell();
            TableCell tr1itc5 = new TableCell();
            TableCell tr1itc6 = new TableCell();

            TableCell tr1itc7 = new TableCell();
            //TableCell tc8 = new TableCell();
            //TableCell tc9 = new TableCell();


            tr1itc1.Text = "";
            tr1itc1.CssClass = "blackfnt";
            tr1itc1.HorizontalAlign = HorizontalAlign.Center;
            tr1itc1.Wrap = false;
            tr1i.CssClass = "bgbluegrey";
            tr1i.Cells.Add(tr1itc1);


            tr1itc2.Text = "Opening Balance : ";
            tr1itc2.HorizontalAlign = HorizontalAlign.Center;
            tr1itc2.CssClass = "blackboldfnt";
            tr1itc2.ColumnSpan = 3;
            tr1itc2.Wrap = false;
            tr1i.CssClass = "bgbluegrey";
            tr1i.Cells.Add(tr1itc2);

            //tr1itc3.Text = dr["vaoucherdt"].ToString();
            //tr1itc3.HorizontalAlign = HorizontalAlign.Center;
            //tr1itc3.CssClass = "blackfnt";
            //tr1itc3.Wrap = false;
            //tr1i.CssClass = "bgbluegrey";
            //tr1i.Cells.Add(tr1itc3);

            //tr1itc4.Text = dr["oppaccount"].ToString();
            //tr1itc4.CssClass = "blackfnt";
            //tr1itc4.Wrap = false;
            //tr1i.CssClass = "bgbluegrey";
            //tr1i.Cells.Add(tr1itc4);




            tr1itc5.Text = opn_debit.ToString("F2");
            tr1itc5.HorizontalAlign = HorizontalAlign.Right;
            tr1itc5.CssClass = "blackboldfnt";
            tr1i.CssClass = "bgbluegrey";
            tr1i.Cells.Add(tr1itc5);

            tr1itc6.Text = opn_credit.ToString("F2");
            tr1itc6.HorizontalAlign = HorizontalAlign.Right;

            tr1itc6.CssClass = "blackboldfnt";
            tr1i.CssClass = "bgbluegrey";
            tr1i.Cells.Add(tr1itc6);

            tr1itc7.Text = "";
            tr1itc7.CssClass = "blackfnt";
            tr1i.CssClass = "bgbluegrey";
            tr1i.Cells.Add(tr1itc7);
            tr1i.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr1i);



            String str_year = "", prevstr_year = "", str_month = "", prestr_month = "";

            double mdebit = 0, mcredit = 0, sub_mdebit = 0, sub_mcredit = 0, total_mdebit = 0, total_mcredit = 0;

            int i = 1;
            while (dr.Read())
            {
                
                sub_mdebit += mdebit;
                sub_mcredit += mcredit;

                total_mdebit += mdebit;
                total_mcredit += mcredit;



                mdebit = 0;
                mcredit = 0;
                mdebit = Convert.ToDouble(dr["debit"]);
                mcredit = Convert.ToDouble(dr["credit"]);

                str_year = dr["year1"].ToString();
                str_month = dr["month1"].ToString();
                String Month_name = "";

                if (str_month != prestr_month && prestr_month != "")
                {
                    str_month = prestr_month;
                    if (str_month == "1")
                    {
                        Month_name = "January";
                    }
                    else if (str_month == "2")
                    {
                        Month_name = "February";
                    }
                    else if (str_month == "3")
                    {
                        Month_name = "March";
                    }
                    else if (str_month == "4")
                    {
                        Month_name = "April";
                    }
                    else if (str_month == "5")
                    {
                        Month_name = "May";
                    }
                    else if (str_month == "6")
                    {
                        Month_name = "June";
                    }
                    else if (str_month == "7")
                    {
                        Month_name = "July";
                    }
                    else if (str_month == "8")
                    {
                        Month_name = "August";
                    }
                    else if (str_month == "9")
                    {
                        Month_name = "September";
                    }
                    else if (str_month == "10")
                    {
                        Month_name = "October";
                    }
                    else if (str_month == "11")
                    {
                        Month_name = "November";
                    }
                    else if (str_month == "12")
                    {
                        Month_name = "December";
                    }

                    TableRow tr3 = new TableRow();

                    TableCell tr3tc1 = new TableCell();
                    TableCell tr3tc2 = new TableCell();
                    TableCell tr3tc3 = new TableCell();

                    TableCell tr3tc4 = new TableCell();
                    TableCell tr3tc5 = new TableCell();
                    TableCell tr3tc6 = new TableCell();

                    TableCell tr3tc7 = new TableCell();
                    //TableCell tc8 = new TableCell();
                    //TableCell tc9 = new TableCell();


                    tr3tc1.Text = "";
                    tr3tc1.CssClass = "blackfnt";
                    tr3tc1.HorizontalAlign = HorizontalAlign.Center;
                    tr3tc1.Wrap = false;
                    tr3.CssClass = "bgbluegrey";
                    tr3.Cells.Add(tr3tc1);

                    tr3tc2.Text = "Total for the Month : " + Month_name + " - " + str_year;
                    tr3tc2.HorizontalAlign = HorizontalAlign.Center;
                    tr3tc2.CssClass = "blackboldfnt";
                    tr3tc2.ColumnSpan = 3;
                    tr3tc2.Wrap = false;
                    tr3.CssClass = "bgbluegrey";
                    tr3.Cells.Add(tr3tc2);

                    //tr3tc3.Text = dr["vaoucherdt"].ToString();
                    //tr3tc3.HorizontalAlign = HorizontalAlign.Center;
                    //tr3tc3.CssClass = "blackfnt";
                    //tr3tc3.Wrap = false;
                    //tr3.CssClass = "bgbluegrey";
                    //tr3.Cells.Add(tr3tc3);

                    //tr3tc4.Text = dr["oppaccount"].ToString();
                    //tr3tc4.CssClass = "blackfnt";
                    //tr3tc4.Wrap = false;
                    //tr3.CssClass = "bgbluegrey";
                    //tr3.Cells.Add(tr3tc4);

                    tr3tc5.Text = sub_mdebit.ToString("F2");
                    tr3tc5.HorizontalAlign = HorizontalAlign.Right;
                    tr3tc5.CssClass = "blackboldfnt";
                    tr3.CssClass = "bgbluegrey";
                    tr3.Cells.Add(tr3tc5);

                    tr3tc6.Text = sub_mcredit.ToString("F2");
                    tr3tc6.HorizontalAlign = HorizontalAlign.Right;

                    tr3tc6.CssClass = "blackboldfnt";
                    tr3.CssClass = "bgbluegrey";
                    tr3.Cells.Add(tr3tc6);

                    tr3tc7.Text = "";
                    tr3tc7.CssClass = "blackfnt";
                    tr3.CssClass = "bgbluegrey";
                    tr3.Cells.Add(tr3tc7);
                    tr3.BackColor = System.Drawing.Color.White;
                    tblheadache.Rows.Add(tr3);


                    TableRow tr4 = new TableRow();

                    TableCell tr4tc1 = new TableCell();
                    TableCell tr4tc2 = new TableCell();
                    TableCell tr4tc3 = new TableCell();

                    TableCell tr4tc4 = new TableCell();
                    TableCell tr4tc5 = new TableCell();
                    TableCell tr4tc6 = new TableCell();

                    TableCell tr4tc7 = new TableCell();
                    //TableCell tc8 = new TableCell();
                    //TableCell tc9 = new TableCell();

                    double totalcoseDebit1 = 0, totalcoseCredit1 = 0;

                    if (total_mcredit > total_mdebit)
                    {
                        totalcoseCredit1 = total_mcredit - total_mdebit;
                        totalcoseDebit1 = 0;
                    }
                    else
                    {
                        totalcoseCredit1 = 0;
                        totalcoseDebit1 = total_mdebit - total_mcredit;
                    }


                    tr4tc1.Text = "";
                    tr4tc1.CssClass = "blackfnt";
                    tr4tc1.HorizontalAlign = HorizontalAlign.Center;
                    tr4tc1.Wrap = false;
                    tr4.CssClass = "bgbluegrey";
                    tr4.Cells.Add(tr4tc1);

                    tr4tc2.Text = "Closing balance for the Month : ";
                    tr4tc2.HorizontalAlign = HorizontalAlign.Center;
                    tr4tc2.CssClass = "blackboldfnt";
                    tr4tc2.ColumnSpan = 3;
                    tr4tc2.Wrap = false;
                    tr4.CssClass = "bgbluegrey";
                    tr4.Cells.Add(tr4tc2);

                    //tr4tc3.Text = dr["vaoucherdt"].ToString();
                    //tr4tc3.HorizontalAlign = HorizontalAlign.Center;
                    //tr4tc3.CssClass = "blackfnt";
                    //tr4tc3.Wrap = false;
                    //tr4.CssClass = "bgbluegrey";
                    //tr4.Cells.Add(tr4tc3);

                    //tr4tc4.Text = dr["oppaccount"].ToString();
                    //tr4tc4.CssClass = "blackfnt";
                    //tr4tc4.Wrap = false;
                    //tr4.CssClass = "bgbluegrey";
                    //tr4.Cells.Add(tr4tc4);

                    tr4tc5.Text = totalcoseDebit1.ToString("F2");
                    tr4tc5.HorizontalAlign = HorizontalAlign.Right;
                    tr4tc5.CssClass = "blackboldfnt";
                    tr4.CssClass = "bgbluegrey";
                    tr4.Cells.Add(tr4tc5);

                    tr4tc6.Text = totalcoseCredit1.ToString("F2");
                    tr4tc6.HorizontalAlign = HorizontalAlign.Right;

                    tr4tc6.CssClass = "blackboldfnt";
                    tr4.CssClass = "bgbluegrey";
                    tr4.Cells.Add(tr4tc6);

                    tr4tc7.Text = "";
                    tr4tc7.CssClass = "blackfnt";
                    tr4.CssClass = "bgbluegrey";
                    tr4.Cells.Add(tr4tc7);
                    tr4.BackColor = System.Drawing.Color.White;
                    tblheadache.Rows.Add(tr4);


                    sub_mcredit = 0;
                    sub_mdebit = 0;

                }


                TableRow tr2 = new TableRow();

                TableCell tr2tc1 = new TableCell();
                TableCell tr2tc2 = new TableCell();
                TableCell tr2tc3 = new TableCell();

                TableCell tr2tc4 = new TableCell();
                TableCell tr2tc5 = new TableCell();
                TableCell tr2tc6 = new TableCell();

                TableCell tr2tc7 = new TableCell();
                //TableCell tc8 = new TableCell();
                //TableCell tc9 = new TableCell();


                tr2tc1.Text =Convert.ToString(i);
                tr2tc1.CssClass = "blackfnt";
                tr2tc1.HorizontalAlign = HorizontalAlign.Center;
                tr2tc1.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc1);

                tr2tc2.Text = dr["voucherno"].ToString();
                tr2tc2.HorizontalAlign = HorizontalAlign.Center;
               tr2tc2.CssClass = "blackfnt";
               tr2tc2.Wrap = false;
               tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc2);

                tr2tc3.Text = dr["vaoucherdt"].ToString();
                tr2tc3.HorizontalAlign = HorizontalAlign.Center;
                tr2tc3.CssClass = "blackfnt";
                tr2tc3.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc3);

                tr2tc4.Text = dr["oppaccount"].ToString();
                tr2tc4.CssClass = "blackfnt";
                tr2tc4.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc4);

                tr2tc5.Text = dr["debit"].ToString();
                tr2tc5.HorizontalAlign = HorizontalAlign.Right;
                tr2tc5.CssClass = "blackfnt";               
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc5);

                tr2tc6.Text = dr["credit"].ToString();
                tr2tc6.HorizontalAlign = HorizontalAlign.Right;
                
                tr2tc6.CssClass = "blackfnt";                
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc6);

                tr2tc7.Text = dr["narration"].ToString();
                tr2tc7.CssClass = "blackfnt";
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc7);
                tr2.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr2);

                i = i + 1;


              


                prevstr_year = dr["year1"].ToString();
                prestr_month = dr["month1"].ToString();

            }
        dr.Close();

            String Month_name1 = "";

            str_month = prestr_month;
            if (str_month == "1")
            {
                Month_name1 = "January";
            }
            else if (str_month == "2")
            {
                Month_name1 = "February";
            }
            else if (str_month == "3")
            {
                Month_name1 = "March";
            }
            else if (str_month == "4")
            {
                Month_name1 = "April";
            }
            else if (str_month == "5")
            {
                Month_name1 = "May";
            }
            else if (str_month == "6")
            {
                Month_name1 = "June";
            }
            else if (str_month == "7")
            {
                Month_name1 = "July";
            }
            else if (str_month == "8")
            {
                Month_name1 = "August";
            }
            else if (str_month == "9")
            {
                Month_name1 = "September";
            }
            else if (str_month == "10")
            {
                Month_name1 = "October";
            }
            else if (str_month == "11")
            {
                Month_name1 = "November";
            }
            else if (str_month == "12")
            {
                Month_name1 = "December";
            }

            TableRow tr5 = new TableRow();

            TableCell tr5tc1 = new TableCell();
            TableCell tr5tc2 = new TableCell();
            TableCell tr5tc3 = new TableCell();

            TableCell tr5tc4 = new TableCell();
            TableCell tr5tc5 = new TableCell();
            TableCell tr5tc6 = new TableCell();

            TableCell tr5tc7 = new TableCell();
            //TableCell tc8 = new TableCell();
            //TableCell tc9 = new TableCell();


            tr5tc1.Text = "";
            tr5tc1.CssClass = "blackfnt";
            tr5tc1.HorizontalAlign = HorizontalAlign.Center;
            tr5tc1.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc1);
            String SQL_lastmonth="";
            if (strindividual == "N")
            {
                SQL_lastmonth = "SELECT  sum(isnull(t.debit,0)) as debit ,sum(isnull(t.credit,0)) as credit,tot=sum(case when  isnull(t.debit,0)>isnull(t.credit,0) then isnull(t.debit,0)-isnull(t.credit,0) else isnull(t.credit,0)-isnull(t.debit,0) end) from " + AcctOpenTable + " t  with(NOLOCK) where  t.voucher_cancel='N'  and t.acccode='" + acccode + "' and  year(transdate)='" + str_year + "' and month(transdate) = '" + str_month + "'";
            }
            else
            {
                SQL_lastmonth = "SELECT  sum(isnull(t.debit,0)) as debit ,sum(isnull(t.credit,0)) as credit,tot=sum(case when  isnull(t.debit,0)>isnull(t.credit,0) then isnull(t.debit,0)-isnull(t.credit,0) else isnull(t.credit,0)-isnull(t.debit,0) end) from " + AcctOpenTable + " t  with(NOLOCK) where  t.voucher_cancel='N'  and t.acccode='" + acccode + "' and   t.brcd='" + loccode + "' and year(transdate)='" + str_year + "' and month(transdate) = '" + str_month + "'";
            }
            //Response.Write("<br> SQL_lastmonth : " + SQL_lastmonth);
            SqlCommand cmd1 = new SqlCommand(SQL_lastmonth, conn);
            SqlDataReader dr12;
            dr12 = cmd1.ExecuteReader();

            double subcredit = 0, subdebit = 0;
            while (dr12.Read())
            {
                if (dr12["credit"] != null)
                {
                    subcredit = Convert.ToDouble(dr12["credit"]);
                }
                if (dr12["debit"] != null)
                {
                    subdebit = Convert.ToDouble(dr12["debit"]);
                }
            }
            dr12.Close();

            tr5tc2.Text = "Total for the Month : " + Month_name1 + " - " + str_year;
            tr5tc2.HorizontalAlign = HorizontalAlign.Center;
            tr5tc2.CssClass = "blackboldfnt";
            tr5tc2.ColumnSpan = 3;
            tr5tc2.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc2);

            //tr5tc3.Text = dr["vaoucherdt"].ToString();
            //tr5tc3.HorizontalAlign = HorizontalAlign.Center;
            //tr5tc3.CssClass = "blackfnt";
            //tr5tc3.Wrap = false;
            //tr5.CssClass = "bgbluegrey";
            //tr5.Cells.Add(tr5tc3);

            //tr5tc4.Text = dr["oppaccount"].ToString();
            //tr5tc4.CssClass = "blackfnt";
            //tr5tc4.Wrap = false;
            //tr5.CssClass = "bgbluegrey";
            //tr5.Cells.Add(tr5tc4);

            tr5tc5.Text = subdebit.ToString("F2");
            tr5tc5.HorizontalAlign = HorizontalAlign.Right;
            tr5tc5.CssClass = "blackboldfnt";
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc5);

            tr5tc6.Text = subcredit.ToString("F2");
            tr5tc6.HorizontalAlign = HorizontalAlign.Right;

            tr5tc6.CssClass = "blackboldfnt";
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc6);

            tr5tc7.Text = "";
            tr5tc7.CssClass = "blackfnt";
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5tc7);
            tr5.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr5);



            double totalcoseDebit = 0, totalcoseCredit = 0;

            if (total_mcredit > total_mdebit)
            {
                totalcoseCredit = total_mcredit - total_mdebit;
                totalcoseDebit = 0;
            }
            else
            {
                totalcoseCredit = 0;
                totalcoseDebit = total_mdebit - total_mcredit;
            }

            TableRow tr6 = new TableRow();

            TableCell tr6tc1 = new TableCell();
            TableCell tr6tc2 = new TableCell();
            TableCell tr6tc3 = new TableCell();

            TableCell tr6tc4 = new TableCell();
            TableCell tr6tc5 = new TableCell();
            TableCell tr6tc6 = new TableCell();

            TableCell tr6tc7 = new TableCell();
            //TableCell tc8 = new TableCell();
            //TableCell tc9 = new TableCell();




            tr6tc1.Text = "";
            tr6tc1.CssClass = "blackfnt";
            tr6tc1.HorizontalAlign = HorizontalAlign.Center;
            tr6tc1.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc1);

            tr6tc2.Text = "Closing balance for the Month : ";
            tr6tc2.HorizontalAlign = HorizontalAlign.Center;
            tr6tc2.CssClass = "blackboldfnt";
            tr6tc2.ColumnSpan = 3;
            tr6tc2.Wrap = false;
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc2);

            //tr6tc3.Text = dr["vaoucherdt"].ToString();
            //tr6tc3.HorizontalAlign = HorizontalAlign.Center;
            //tr6tc3.CssClass = "blackfnt";
            //tr6tc3.Wrap = false;
            //tr6.CssClass = "bgbluegrey";
            //tr6.Cells.Add(tr6tc3);

            //tr6tc4.Text = dr["oppaccount"].ToString();
            //tr6tc4.CssClass = "blackfnt";
            //tr6tc4.Wrap = false;
            //tr6.CssClass = "bgbluegrey";
            //tr6.Cells.Add(tr6tc4);

            tr6tc5.Text = totalcoseDebit.ToString("F2");
            tr6tc5.HorizontalAlign = HorizontalAlign.Right;
            tr6tc5.CssClass = "blackboldfnt";
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc5);

            tr6tc6.Text = totalcoseCredit.ToString("F2");
            tr6tc6.HorizontalAlign = HorizontalAlign.Right;

            tr6tc6.CssClass = "blackboldfnt";
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc6);

            tr6tc7.Text = "";
            tr6tc7.CssClass = "blackfnt";
            tr6.CssClass = "bgbluegrey";
            tr6.Cells.Add(tr6tc7);
            tr6.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr6);

            TableRow tr7 = new TableRow();

            TableCell tr7tc1 = new TableCell();
            TableCell tr7tc2 = new TableCell();
            TableCell tr7tc3 = new TableCell();

            TableCell tr7tc4 = new TableCell();
            TableCell tr7tc5 = new TableCell();
            TableCell tr7tc6 = new TableCell();

            TableCell tr7tc7 = new TableCell();
            //TableCell tc8 = new TableCell();
            //TableCell tc9 = new TableCell();


            tr7tc1.Text = "";
            tr7tc1.CssClass = "blackfnt";
            tr7tc1.HorizontalAlign = HorizontalAlign.Center;
            tr7tc1.Wrap = false;
            tr7.CssClass = "bgbluegrey";
            tr7.Cells.Add(tr7tc1);
            

            tr7tc2.Text = "Total for A/C : ";
            tr7tc2.HorizontalAlign = HorizontalAlign.Center;
            tr7tc2.CssClass = "blackboldfnt";
            tr7tc2.ColumnSpan = 3;
            tr7tc2.Wrap = false;
            tr7.CssClass = "bgbluegrey";
            tr7.Cells.Add(tr7tc2);

            //tr7tc3.Text = dr["vaoucherdt"].ToString();
            //tr7tc3.HorizontalAlign = HorizontalAlign.Center;
            //tr7tc3.CssClass = "blackfnt";
            //tr7tc3.Wrap = false;
            //tr7.CssClass = "bgbluegrey";
            //tr7.Cells.Add(tr7tc3);

            //tr7tc4.Text = dr["oppaccount"].ToString();
            //tr7tc4.CssClass = "blackfnt";
            //tr7tc4.Wrap = false;
            //tr7.CssClass = "bgbluegrey";
            //tr7.Cells.Add(tr7tc4);

           


            tr7tc5.Text = total_mcredit.ToString("F2");
            tr7tc5.HorizontalAlign = HorizontalAlign.Right;
            tr7tc5.CssClass = "blackboldfnt";
            tr7.CssClass = "bgbluegrey";
            tr7.Cells.Add(tr7tc5);

            tr7tc6.Text = total_mcredit.ToString("F2");
            tr7tc6.HorizontalAlign = HorizontalAlign.Right;

            tr7tc6.CssClass = "blackboldfnt";
            tr7.CssClass = "bgbluegrey";
            tr7.Cells.Add(tr7tc6);

            tr7tc7.Text = "";
            tr7tc7.CssClass = "blackfnt";
            tr7.CssClass = "bgbluegrey";
            tr7.Cells.Add(tr7tc7);
            tr7.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr7);


            TableRow tr8 = new TableRow();

            TableCell tr8tc1 = new TableCell();
            TableCell tr8tc2 = new TableCell();
            TableCell tr8tc3 = new TableCell();

            TableCell tr8tc4 = new TableCell();
            TableCell tr8tc5 = new TableCell();
            TableCell tr8tc6 = new TableCell();

            TableCell tr8tc7 = new TableCell();
            //TableCell tc8 = new TableCell();
            //TableCell tc9 = new TableCell();




            tr8tc1.Text = "";
            tr8tc1.CssClass = "blackfnt";
            tr8tc1.HorizontalAlign = HorizontalAlign.Center;
            tr8tc1.Wrap = false;
            tr8.CssClass = "bgbluegrey";
            tr8.Cells.Add(tr8tc1);

            tr8tc2.Text = "Closing Balance :  ";
            tr8tc2.HorizontalAlign = HorizontalAlign.Center;
            tr8tc2.CssClass = "blackboldfnt";
            tr8tc2.ColumnSpan = 3;
            tr8tc2.Wrap = false;
            tr8.CssClass = "bgbluegrey";
            tr8.Cells.Add(tr8tc2);

            //tr8tc3.Text = dr["vaoucherdt"].ToString();
            //tr8tc3.HorizontalAlign = HorizontalAlign.Center;
            //tr8tc3.CssClass = "blackfnt";
            //tr8tc3.Wrap = false;
            //tr8.CssClass = "bgbluegrey";
            //tr8.Cells.Add(tr8tc3);

            //tr8tc4.Text = dr["oppaccount"].ToString();
            //tr8tc4.CssClass = "blackfnt";
            //tr8tc4.Wrap = false;
            //tr8.CssClass = "bgbluegrey";
            //tr8.Cells.Add(tr8tc4);

            tr8tc5.Text = totalcoseDebit.ToString("F2");
            tr8tc5.HorizontalAlign = HorizontalAlign.Right;
            tr8tc5.CssClass = "blackboldfnt";
            tr8.CssClass = "bgbluegrey";
            tr8.Cells.Add(tr8tc5);

            tr8tc6.Text = totalcoseCredit.ToString("F2");
            tr8tc6.HorizontalAlign = HorizontalAlign.Right;

            tr8tc6.CssClass = "blackboldfnt";
            tr8.CssClass = "bgbluegrey";
            tr8.Cells.Add(tr8tc6);

            tr8tc7.Text = "";
            tr8tc7.CssClass = "blackfnt";
            tr8.CssClass = "bgbluegrey";
            tr8.Cells.Add(tr8tc7);
            tr8.BackColor = System.Drawing.Color.White;
            tblheadache.Rows.Add(tr8);

    }
}
