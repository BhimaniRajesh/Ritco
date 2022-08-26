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

public partial class GUI_UNI_MIS_Account_Reports_Trail_balance_Result_Trail_balance : System.Web.UI.Page
{
    SqlConnection conn, conn1;
    public static string strDateRange, mGroupTable,mindividual , mToDt,mClosedt,Reporttype,Str_Reporttype, rpt_typ,ACCOunts, finyearstart, strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    public static string Str_opnAcccode = "", Str_mTransCredit = "", Str_mTransDebit = "", str_acctcode = "";
    public static string Str_opnAcccode_TR = "", Str_mTransCredit_TR = "", Str_mTransDebit_TR = "", str_acctcode_TR = "";
   
    protected void Page_Load(object sender, EventArgs e)
    {

        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition", "attachment; filename=Profit_loss.xls");
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
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
            mAcctTransTable = "webx_acctopening_" + yearSuffix;
            AcctOpenTable = "webx_acctrans_" + yearSuffix;
            AcctTable = "webx_acctinfo";
            mGroupTable = "webx_groups";
            strDateRange = Request.QueryString["DOCDate"].ToString();
            string[] strDateRange_Arr = strDateRange.Split('-');

            lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
            //strro = "HQTR";
            mClosedt = strDateRange_Arr[1].ToString().Trim();
            lblro.Text = strro;

            // finyearstart = Session["FinYearStart"].ToString();
            mToDt = strDateRange_Arr[0].ToString().Trim();
            rpt_typ = Request.QueryString["Flowtype"].ToString();
            ACCOunts = Request.QueryString["ACCOunts"].ToString();
            //Reporttype= Request.QueryString["Reporttype"].ToString();



            //if (Reporttype == "0")
            //{
            //    Str_Reporttype="opening";

            //    lblrpt.Text = "Opening Balances Only";
            //}
            //else if (Reporttype == "1")
            //{
            //    Str_Reporttype="closing";
            //    lblrpt.Text = "Closing Balances Only";
            //}
            //else if (Reporttype == "2")
            //{
            //    Str_Reporttype="all";

            //    lblrpt.Text = "All Balances";

            //}



            if (rpt_typ == "0")
            {
                strindividual = "Y";
                mindividual = "Y";

            }
            else
            {
                strindividual = "N";

                mindividual = "HO";

            }

            //cmd.ExecuteNonQuery();
        }
        String Arr_openBal = "", Arr_OpenBal_Open = "", Arr_TransBal = "";



        //conn1.Open();

        //Arr_OpenBal_Open = " exec WEBX_ACCT_TRIAL_OPENBAL_OPENING_Net '" + AcctOpenTable + "','" + AcctTable + "','" + strro + "','" + mToDt + "','" + strindividual + "',''";
        //SqlCommand cmd1 = new SqlCommand(Arr_OpenBal_Open, conn);
        //SqlDataReader dr1;
        //dr1 = cmd1.ExecuteReader();

        //while (dr1.Read())
        //{
        //    if (Str_opnAcccode == "")
        //        Str_opnAcccode = Convert.ToString(dr1["acccode"]);
        //    else
        //        Str_opnAcccode = Str_opnAcccode + "^" + Convert.ToString(dr1["acccode"]);

        //    if (Str_mTransCredit == "")
        //        Str_mTransCredit = Convert.ToString(dr1["credit"]);
        //    else
        //        Str_mTransCredit = Str_mTransCredit + "^" + Convert.ToString(dr1["credit"]);

        //    if (Str_mTransDebit == "")
        //        Str_mTransDebit = Convert.ToString(dr1["debit"]);
        //    else
        //        Str_mTransDebit = Str_mTransDebit + "^" + Convert.ToString(dr1["debit"]);

        //    //mTransCredit = Convert.ToDouble(dr1["credit"]);
        //    //mTransDebit = Convert.ToDouble(dr1["debit"]);
        //}
        //dr1.Close();

        //Arr_TransBal = "exec webx_ACCT_TRIAL_OPENBAL_Trans_net '" + AcctOpenTable + "','" + AcctTable + "','" + strro + "','" + mToDt + "','" + mClosedt + "','" + strindividual + "','' ";
        //SqlCommand cmd2 = new SqlCommand(Arr_TransBal, conn);
        //SqlDataReader dr2;
        //dr2 = cmd2.ExecuteReader();

        //while (dr2.Read())
        //{
        //    if (Str_opnAcccode_TR == "")
        //        Str_opnAcccode_TR = Convert.ToString(dr2["acccode"]);
        //    else
        //        Str_opnAcccode_TR = Str_opnAcccode_TR + "^" + Convert.ToString(dr2["acccode"]);

        //    if (Str_mTransCredit_TR == "")
        //        Str_mTransCredit_TR = Convert.ToString(dr2["credit"]);
        //    else
        //        Str_mTransCredit_TR = Str_mTransCredit_TR + "^" + Convert.ToString(dr2["credit"]);

        //    if (Str_mTransDebit_TR == "")
        //        Str_mTransDebit_TR = Convert.ToString(dr2["debit"]);
        //    else
        //        Str_mTransDebit_TR = Str_mTransDebit_TR + "^" + Convert.ToString(dr2["debit"]);


        //    //mTransCredit = Convert.ToDouble(dr2["credit"]);
        //    //mTransDebit = Convert.ToDouble(dr2["debit"]);
        //}
        //dr2.Close();

        Arr_openBal = "exec usp_branchacctwise_trialbalance  '" + strro + "', '" + finyearstart + "','" + mToDt + "','" + mClosedt + "','" + mindividual + "','" + ACCOunts + "','" + yearSuffix + "'";
       // Response.Write("<br>" + Arr_openBal);
        SqlCommand cmd = new SqlCommand(Arr_openBal, conn);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        String mGroupDesc = "", mGropuCodeDesc = "", mGropuCode = "", PremGroupDesc = "", mMainGroup = "", PrevmGropuCodeDesc = "";

        //string[] Str_opnAcccode_arr = Str_opnAcccode.Split('^');
        //string[] Str_mTransCredit_arr = Str_mTransCredit.Split('^');
        //string[] Str_mTransDebit_arr = Str_mTransDebit.Split('^');


        //string[] Str_opnAcccode_TR_arr = Str_opnAcccode_TR.Split('^');
        //string[] Str_mTransCredit_arr_TR = Str_mTransCredit_TR.Split('^');
        //string[] Str_mTransDebit_arr_TR = Str_mTransDebit_TR.Split('^');



        TableRow tr = new TableRow();

        TableCell tc1 = new TableCell();
        TableCell tc2 = new TableCell();
        TableCell tc3 = new TableCell();

        TableCell tc4 = new TableCell();
        TableCell tc5 = new TableCell();
        TableCell tc6 = new TableCell();

        TableCell tc7 = new TableCell();
        TableCell tc8 = new TableCell();
        TableCell tc9 = new TableCell();


        tc1.Text = "Location";
        tc1.CssClass = "blackfnt";
        tc1.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc1);

        //tc2.Text = "Sub Group";
        //tc2.CssClass = "blackfnt";
        //tc2.Wrap = false;
        //tr.CssClass = "bgbluegrey";
        //tr.Cells.Add(tc2);

        //tc3.Text = "Account Name";
        //tc3.CssClass = "blackfnt";
        //tc3.Wrap = false;
        //tr.CssClass = "bgbluegrey";
        //tr.Cells.Add(tc3);






        tc4.Text = "Opening Debit";
        tc4.CssClass = "blackfnt";
        tc4.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc4);

        tc5.Text = "Opening Credit";
        tc5.CssClass = "blackfnt";
        tc5.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc5);

        tc6.Text = "Current Debit";
        tc6.CssClass = "blackfnt";
        tc6.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc6);

        tc7.Text = "Current Credit";
        tc7.CssClass = "blackfnt";
        tc7.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc7);

        tc8.Text = "Closing Debit";
        tc8.CssClass = "blackfnt";
        tc8.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc8);

        tc9.Text = "Closing Credit";
        tc9.CssClass = "blackfnt";
        tc9.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc9);

        tblheadache.Rows.Add(tr);

        double mopenDebit = 0, mopenCredit = 0, SubtotmopenDebit = 0, SubtotmopenCredit = 0, TotalmopenDebit = 0, TotalmopenCredit = 0;
        double mTransDebit = 0, mTransCredit = 0, SubtotmTransDebit = 0, SubtotmTransCredit = 0, TotalmTransDebit = 0, TotalmTransCredit = 0;
        double mCloseCredit = 0, mCloseDebit = 0, SubtotmCloseCredit = 0, SubtotmCloseDebit = 0, TotalmCloseCredit = 0, TotalmCloseDebit = 0;

        String macccode = "", maccdesc = "", mTotalFlag = "";
        int i = 0, j = 0;

        while (dr.Read())
        {
            String mopenFlag = "False", mAllFlag = "False", mCloseFlag = "False";


            //mTransDebit = 0;
            //            mTransCredit = 0;
            //            mCloseCredit = 0;
            //            mCloseDebit = 0;
            //            mopenDebit = 0;
            //            mopenCredit = 0;

            //SubtotmopenCredit += mopenCredit;
            //SubtotmopenDebit += mopenDebit;
            //SubtotmTransCredit += mTransCredit;
            //SubtotmTransDebit += mTransDebit;
            //SubtotmCloseCredit += mCloseCredit;
            //SubtotmCloseDebit += mCloseDebit;


            //mCloseCredit = 0;
            //mCloseDebit = 0;
            //mopenCredit = 0;
            //mopenDebit = 0;
            //mTransCredit = 0;
            //mTransDebit = 0;



            macccode = ""; //Convert.ToString(dr["acccode"]);
            maccdesc = "";// Convert.ToString(dr["accdesc"]);
            mGropuCodeDesc = "";//Convert.ToString(dr["groupDesc"]);
            // String PrevmGropuCodeDesc1 = "";
            mGropuCode = "";//Convert.ToString(dr["groupCode"]);

            mGroupDesc = Convert.ToString(dr["brcd"]) + " : " + Convert.ToString(dr["locname"]);
            strindividual = "Y";
            mopenDebit = Convert.ToDouble(dr["opendebit"]);
            mopenCredit = Convert.ToDouble(dr["opencredit"]);



            if (mopenDebit > mopenCredit)
            {
                mopenDebit = mopenDebit - mopenCredit;
                mopenCredit = 0;
            }
            else
            {
                mopenCredit = mopenCredit - mopenDebit;
                mopenDebit = 0;
            }



            mTransCredit = Convert.ToDouble(dr["transcredit"]);
            mTransDebit = Convert.ToDouble(dr["transdebit"]);





            //mopenDebit=mopenDebit + mTransDebit;
            //mopenCredit=mopenCredit + mTransCredit;

            if (mopenDebit > mopenCredit)
            {
                mopenDebit = mopenDebit - mopenCredit;
                mopenCredit = 0;
            }
            else
            {
                mopenCredit = mopenCredit - mopenDebit;
                mopenDebit = 0;
            }

            if (mopenCredit > 0 || mopenDebit > 0)
            {
                mopenFlag = "True";
            }



            //if( Str_Reporttype!="opening")
            //{
            //mTransCredit=0;
            //mTransDebit=0;

            //for (int opn1_TR = 0; opn1_TR < Str_opnAcccode_TR_arr.Length; opn1_TR++)
            //{
            //    str_acctcode_TR = Str_opnAcccode_TR_arr[opn1_TR].ToString();

            //    //mTransCredit = 0;
            //    //mTransDebit = 0;


            //    if (macccode == str_acctcode_TR)
            //    {

            //        String MCR_TR = Str_mTransCredit_arr_TR[opn1_TR].ToString();
            //        String MdR_TR = Str_mTransDebit_arr_TR[opn1_TR].ToString();

            //mTransCredit = Convert.ToDouble(MCR_TR);
            //mTransDebit = Convert.ToDouble(MdR_TR);
            //    }

            //mTransCredit = Convert.ToDouble(dr1["credit"]);
            //mTransDebit = Convert.ToDouble(dr1["debit"]);
            //}

            mCloseDebit = mopenDebit + mTransDebit;
            mCloseCredit = mopenCredit + mTransCredit;


            if (mCloseDebit > mCloseCredit)
            {
                mCloseDebit = mCloseDebit - mCloseCredit;
                mCloseCredit = 0;
            }
            else
            {
                mCloseCredit = mCloseCredit - mCloseDebit;
                mCloseDebit = 0;
            }

            if (mCloseCredit > 0 || mCloseDebit > 0)
            {
                mCloseFlag = "True";
            }


            //}


            if (mCloseCredit > 0 || mCloseDebit > 0 || mopenCredit > 0 || mopenDebit > 0 || mTransCredit > 0 || mTransDebit > 0)
            {
                mAllFlag = "True";
            }



            if (mopenFlag == "True" || mCloseFlag == "True" || mAllFlag == "True")
            {




                //if (mGropuCodeDesc != PrevmGropuCodeDesc && PrevmGropuCodeDesc!="")
                //{
                //    mTotalFlag = "True";
                //}  

                //if (mTotalFlag == "True" )
                //{
                //    TableRow tr2 = new TableRow();

                //    TableCell tr2c1 = new TableCell();
                //    TableCell tr2c2 = new TableCell();
                //    TableCell tr2c3 = new TableCell();

                //    TableCell tr2c4 = new TableCell();
                //    TableCell tr2c5 = new TableCell();
                //    TableCell tr2c6 = new TableCell();

                //    TableCell tr2c7 = new TableCell();
                //    TableCell tr2c8 = new TableCell();
                //    TableCell tr2c9 = new TableCell();


                //    tr2c1.Text = " ";
                //    tr2c1.CssClass = "blackboldfnt";
                //   // tr2c1.Wrap = false;
                //    tr2.CssClass = "bgbluegrey";
                //    tr2.Cells.Add(tr2c1);

                //    tr2c2.Text = "Total" + ' ' + PrevmGropuCodeDesc;
                //    tr2c2.CssClass = "blackboldfnt";
                //   // tr2c2.Wrap = false;
                //    tr2.CssClass = "bgbluegrey";
                //    tr2.Cells.Add(tr2c2);

                //    tr2c3.Text = "";
                //    tr2c3.CssClass = "blackfnt";
                //   // tr2c3.Wrap = false;
                //    tr2.CssClass = "bgbluegrey";
                //    tr2.Cells.Add(tr2c3);



                //        tr2c4.Text = SubtotmopenDebit.ToString("F2");
                //        tr2c4.CssClass = "blackboldfnt";
                //        tr2c4.Wrap = false;
                //        tr2.CssClass = "bgbluegrey";
                //        tr2.Cells.Add(tr2c4);

                //        tr2c5.Text = SubtotmopenCredit.ToString("F2");
                //        tr2c5.CssClass = "blackboldfnt";
                //        tr2c5.Wrap = false;
                //        tr2.CssClass = "bgbluegrey";
                //        tr2.Cells.Add(tr2c5);

                //        tr2c6.Text = SubtotmTransDebit.ToString("F2");
                //        tr2c6.CssClass = "blackboldfnt";
                //        tr2c6.Wrap = false;
                //        tr2.CssClass = "bgbluegrey";
                //        tr2.Cells.Add(tr2c6);

                //        tr2c7.Text = SubtotmTransCredit.ToString("F2");
                //        tr2c7.CssClass = "blackboldfnt";
                //        tr2c7.Wrap = false;
                //        tr2.CssClass = "bgbluegrey";
                //        tr2.Cells.Add(tr2c7);

                //        tr2c8.Text = SubtotmCloseDebit.ToString("F2");
                //        tr2c8.CssClass = "blackboldfnt";
                //        tr2c8.Wrap = false;
                //        tr2.CssClass = "bgbluegrey";
                //        tr2.Cells.Add(tr2c8);

                //        tr2c9.Text = SubtotmCloseCredit.ToString("F2");
                //        tr2c9.CssClass = "blackboldfnt";
                //        tr2c9.Wrap = false;
                //        tr2.CssClass = "bgbluegrey";
                //        tr2.Cells.Add(tr2c9);


                //    tblheadache.Rows.Add(tr2);

                //    SubtotmopenCredit = 0;
                //    SubtotmopenDebit = 0;
                //    SubtotmCloseCredit = 0;
                //    SubtotmCloseDebit = 0;
                //    SubtotmTransCredit = 0;
                //    SubtotmTransDebit = 0;
                //    mTotalFlag = "";
                //}




                TableRow tr1 = new TableRow();
                TableCell trc1 = new TableCell();
                TableCell trc2 = new TableCell();
                TableCell trc3 = new TableCell();

                TableCell trc4 = new TableCell();
                TableCell trc5 = new TableCell();
                TableCell trc6 = new TableCell();

                TableCell trc7 = new TableCell();
                TableCell trc8 = new TableCell();
                TableCell trc9 = new TableCell();

                //if (mGroupDesc != PremGroupDesc)
                //{
                //    if (mGroupDesc == "INC")
                //    {
                //        mMainGroup = "INCOME";
                //    }
                //    else if (mGroupDesc == "LIA")
                //    {
                //        mMainGroup = "LIABILITIES";
                //    }
                //    else if (mGroupDesc == "EXP")
                //    {
                //        mMainGroup = "EXPENSES";
                //    }
                //    else if (mGroupDesc == "ASS")
                //    {
                //        mMainGroup = "ASSET";
                //    }



                //    trc1.Text = mMainGroup;

                //}
                //else
                //{
                trc1.Text = mGroupDesc;
                //}
                trc1.CssClass = "blackboldfnt";
                // trc1.Wrap = false;
                // tr1.CssClass = "bgbluegrey";
                tr1.Cells.Add(trc1);

                //  trc2.Text = "";
                //  //if (mGropuCodeDesc != PrevmGropuCodeDesc)
                //  //{
                //  //    i = 0;
                //  //    j = 0;
                //  //    trc2.Text = mGropuCodeDesc;
                //  //    i = i + 1;
                //  //}
                //  //else
                //  //{
                //  //    j = j + 1;

                //  //}



                ////  Response.Write("<br> j : " + maccdesc+ " : " + j);
                //  String dirlldown = strro + "~" + macccode + "~" + maccdesc + "~" + finyearstart + "~" + mClosedt + "~" + strindividual;

                //  trc2.CssClass ="blackfnt";
                // // trc2.Wrap = false;
                //  // tr1.CssClass = "bgbluegrey";
                //  tr1.Cells.Add(trc2);
                //  //string strFinalQS;
                //  /////strFinalQS = "?dirlldown=" + dirlldown;
                //  //strFinalQS = "?strro=" + strro;
                //  //strFinalQS = strFinalQS + "&macccode=" + macccode;
                //  //strFinalQS = strFinalQS + "&maccdesc=" + maccdesc;
                //  //strFinalQS = strFinalQS + "&finyearstart=" + finyearstart;

                //  trc3.Text = "<a href='Voucherlist_trailbalance.aspx?" + dirlldown + "'>" + maccdesc + "</a>";
                //  trc3.CssClass = "blklnkund";
                //  //trc3.Wrap = false;
                //  //tr1.CssClass = "bgbluegrey";
                //  tr1.Cells.Add(trc3);

                trc4.Text = mopenDebit.ToString("F2");
                trc4.CssClass = "blackfnt";
                trc4.HorizontalAlign = HorizontalAlign.Right;
                trc4.Wrap = false;
                tr1.Cells.Add(trc4);

                trc5.Text = mopenCredit.ToString("F2");
                trc5.HorizontalAlign = HorizontalAlign.Right;
                trc5.CssClass = "blackfnt";
                trc5.Wrap = false;
                tr1.Cells.Add(trc5);

                trc6.Text = mTransDebit.ToString("F2");
                trc6.HorizontalAlign = HorizontalAlign.Right;
                trc6.CssClass = "blackfnt";
                trc6.Wrap = false;
                tr1.Cells.Add(trc6);


                trc7.Text = mTransCredit.ToString("F2");
                trc7.HorizontalAlign = HorizontalAlign.Right;
                trc7.CssClass = "blackfnt";
                trc7.Wrap = false;
                tr1.Cells.Add(trc7);

                trc8.Text = mCloseDebit.ToString("F2");
                trc8.HorizontalAlign = HorizontalAlign.Right;
                trc8.CssClass = "blackfnt";
                trc8.Wrap = false;
                tr1.Cells.Add(trc8);

                trc9.Text = mCloseCredit.ToString("F2");
                trc9.HorizontalAlign = HorizontalAlign.Right;
                trc9.CssClass = "blackfnt";
                trc9.Wrap = false;
                tr1.Cells.Add(trc9);


                tr1.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr1);





            }



            TotalmCloseCredit += mCloseCredit;
            TotalmCloseDebit += mCloseDebit;
            TotalmopenCredit += mopenCredit;
            TotalmopenDebit += mopenDebit;
            TotalmTransCredit += mTransCredit;
            TotalmTransDebit += mTransDebit;

        }





        dr.Close();





        TableRow tr5 = new TableRow();

        TableCell tr5c1 = new TableCell();
        TableCell tr5c2 = new TableCell();
        TableCell tr5c3 = new TableCell();

        TableCell tr5c4 = new TableCell();
        TableCell tr5c5 = new TableCell();
        TableCell tr5c6 = new TableCell();

        TableCell tr5c7 = new TableCell();
        TableCell tr5c8 = new TableCell();
        TableCell tr5c9 = new TableCell();


        //tr5c1.Text = " ";
        //tr5c1.CssClass = "blackboldfnt";
        //tr5c1.Wrap = false;
        //tr5.CssClass = "bgbluegrey";
        //tr5.Cells.Add(tr5c1);

        //tr5c2.Text = "";
        //tr5c2.CssClass = "blackboldfnt";
        //tr5c2.Wrap = false;
        //tr5.CssClass = "bgbluegrey";
        //tr5.Cells.Add(tr5c2);

        tr5c3.Text = "Total";
        tr5c3.CssClass = "blackboldfnt";
        tr5c3.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c3);


        tr5c4.Text = TotalmopenDebit.ToString("F2");
        tr5c4.HorizontalAlign = HorizontalAlign.Right;
        tr5c4.CssClass = "blackboldfnt";
        tr5c4.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c4);

        tr5c5.Text = TotalmopenCredit.ToString("F2");
        tr5c5.HorizontalAlign = HorizontalAlign.Right;
        tr5c5.CssClass = "blackboldfnt";
        tr5c5.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c5);

        tr5c6.Text = TotalmTransDebit.ToString("F2");
        tr5c6.HorizontalAlign = HorizontalAlign.Right;
        tr5c6.CssClass = "blackboldfnt";
        tr5c6.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c6);

        tr5c7.Text = TotalmTransCredit.ToString("F2");
        tr5c7.HorizontalAlign = HorizontalAlign.Right;
        tr5c7.CssClass = "blackboldfnt";
        tr5c7.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c7);

        tr5c8.Text = TotalmCloseDebit.ToString("F2");
        tr5c8.CssClass = "blackboldfnt";
        tr5c8.HorizontalAlign = HorizontalAlign.Right;
        tr5c8.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c8);

        tr5c9.Text = TotalmCloseCredit.ToString("F2");
        tr5c9.HorizontalAlign = HorizontalAlign.Right;
        tr5c9.CssClass = "blackboldfnt";
        tr5c9.Wrap = false;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c9);

        tblheadache.Rows.Add(tr5);
    }
}
