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
    public static string strDateRange, mGroupTable, mToDt,mClosedt,Reporttype,Str_Reporttype, rpt_typ,ACCOunts, finyearstart, strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    public static string Str_opnAcccode = "", Str_mTransCredit = "", Str_mTransDebit = "", str_acctcode = "";
    public static string Str_opnAcccode_TR = "", Str_mTransCredit_TR = "", Str_mTransDebit_TR = "", str_acctcode_TR = "";
   // public static string[] Str_opnAcccode_TR_arr ;
    protected void Page_Load(object sender, EventArgs e)
    {
        

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
            string[] strDateRange_Arr=strDateRange.Split('-');

          lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
            //strro = "HQTR";
            mClosedt=strDateRange_Arr[1].ToString().Trim();
           lblro.Text = strro;

           // finyearstart = Session["FinYearStart"].ToString();
            mToDt = strDateRange_Arr[0].ToString().Trim();
            rpt_typ = Request.QueryString["Flowtype"].ToString();
            Reporttype= Request.QueryString["Reporttype"].ToString();



            if (Reporttype == "0")
            {
                Str_Reporttype="opening";

                lblrpt.Text = "Opening Balances Only";
            }
            else if (Reporttype == "1")
            {
                Str_Reporttype="closing";
                lblrpt.Text = "Closing Balances Only";
            }
            else if (Reporttype == "2")
            {
                Str_Reporttype="all";

                lblrpt.Text = "All Balances";
                
            }
            


            if (rpt_typ == "0")
                {
                    strindividual="Y";
                   
                }
                else
                {
                    strindividual="N";
                   
                }
           
            //cmd.ExecuteNonQuery();
        }
        String Arr_openBal = "", Arr_OpenBal_Open = "", Arr_TransBal = "";

       

        //conn1.Open();

        Arr_OpenBal_Open = " exec WEBX_ACCT_TRIAL_OPENBAL_OPENING_Net '" + AcctOpenTable + "','" + AcctTable + "','" + mAcctTransTable + "','" + strro + "','" + mToDt + "','" + strindividual + "',''";
        SqlCommand cmd1 = new SqlCommand(Arr_OpenBal_Open, conn);
        SqlDataReader dr1;
        dr1 = cmd1.ExecuteReader();

        while (dr1.Read())
        {
            if (Str_opnAcccode == "")
                Str_opnAcccode = Convert.ToString(dr1["acccode"]);
            else
                Str_opnAcccode = Str_opnAcccode + "^" + Convert.ToString(dr1["acccode"]);

            if (Str_mTransCredit == "")
                Str_mTransCredit = Convert.ToString(dr1["credit"]);
            else
                Str_mTransCredit = Str_mTransCredit + "^" + Convert.ToString(dr1["credit"]);

            if (Str_mTransDebit == "")
                Str_mTransDebit = Convert.ToString(dr1["debit"]);
            else
                Str_mTransDebit = Str_mTransDebit + "^" + Convert.ToString(dr1["debit"]);
   
            //mTransCredit = Convert.ToDouble(dr1["credit"]);
            //mTransDebit = Convert.ToDouble(dr1["debit"]);
        }
        dr1.Close();

        Arr_TransBal = "exec webx_ACCT_TRIAL_OPENBAL_Trans_net '" + AcctOpenTable + "','" + AcctTable + "','" + strro + "','" + mToDt + "','" + mClosedt + "','" + strindividual + "','' ";
        SqlCommand cmd2 = new SqlCommand(Arr_TransBal, conn);
        SqlDataReader dr2;
        dr2 = cmd2.ExecuteReader();

        while (dr2.Read())
        {
            if (Str_opnAcccode_TR == "")
                Str_opnAcccode_TR = Convert.ToString(dr2["acccode"]);
            else
                Str_opnAcccode_TR = Str_opnAcccode_TR + "^" + Convert.ToString(dr2["acccode"]);

            if (Str_mTransCredit_TR == "")
                Str_mTransCredit_TR = Convert.ToString(dr2["credit"]);
            else
                Str_mTransCredit_TR = Str_mTransCredit_TR + "^" + Convert.ToString(dr2["credit"]);

            if (Str_mTransDebit_TR == "")
                Str_mTransDebit_TR = Convert.ToString(dr2["debit"]);
            else
                Str_mTransDebit_TR = Str_mTransDebit_TR + "^" + Convert.ToString(dr2["debit"]);


            //mTransCredit = Convert.ToDouble(dr2["credit"]);
            //mTransDebit = Convert.ToDouble(dr2["debit"]);
        }
        dr2.Close();

        Arr_openBal = "exec webx_ACCT_TRIAL_YEAROPEN  '" + mAcctTransTable + "','" + mGroupTable + "','" + AcctTable + "','" + strro + "'";

        SqlCommand cmd = new SqlCommand(Arr_openBal, conn);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        String mGroupDesc = "", mGropuCodeDesc = "", mGropuCode = "", PremGroupDesc = "", mMainGroup = "", PrevmGropuCodeDesc = "";

        string[] Str_opnAcccode_arr = Str_opnAcccode.Split('^');
        string[] Str_mTransCredit_arr = Str_mTransCredit.Split('^');
        string[] Str_mTransDebit_arr = Str_mTransDebit.Split('^');


        string[] Str_opnAcccode_TR_arr = Str_opnAcccode_TR.Split('^');
        string[] Str_mTransCredit_arr_TR = Str_mTransCredit_TR.Split('^');
        string[] Str_mTransDebit_arr_TR = Str_mTransDebit_TR.Split('^');

        

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
        

        tc1.Text = "Group";
        tc1.CssClass = "blackfnt";
        tc1.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc1);

        tc2.Text = "Sub Group";
        tc2.CssClass = "blackfnt";
        tc2.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc2);

        tc3.Text = "Account Name";
        tc3.CssClass = "blackfnt";
        tc3.Wrap = false;
        tr.CssClass = "bgbluegrey";
        tr.Cells.Add(tc3);
        
        if(Str_Reporttype=="opening")
        {
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
        }
        else if(Str_Reporttype=="closing")
        {

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

       
        }
        else if (Str_Reporttype == "all")
        {
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
        }
        tblheadache.Rows.Add(tr);

        double mopenDebit = 0, mopenCredit = 0, SubtotmopenDebit = 0, SubtotmopenCredit = 0, TotalmopenDebit = 0, TotalmopenCredit = 0;
        double mTransDebit = 0, mTransCredit = 0, SubtotmTransDebit = 0, SubtotmTransCredit = 0, TotalmTransDebit = 0, TotalmTransCredit = 0;
        double mCloseCredit = 0, mCloseDebit = 0, SubtotmCloseCredit = 0, SubtotmCloseDebit = 0, TotalmCloseCredit = 0, TotalmCloseDebit = 0;

        string macccode = "",st_prcd="", maccdesc = "", mTotalFlag="";
        int i = 0, j = 0;

        while (dr.Read())
        {
            String mopenFlag = "False", mAllFlag = "False", mCloseFlag = "False";
            
            mGroupDesc = Convert.ToString(dr["Mgroupdesc"]);
            st_prcd = Convert.ToString(dr["prcd"]);
//mTransDebit = 0;
//            mTransCredit = 0;
//            mCloseCredit = 0;
//            mCloseDebit = 0;
//            mopenDebit = 0;
//            mopenCredit = 0;

            SubtotmopenCredit += mopenCredit;
            SubtotmopenDebit += mopenDebit;
            SubtotmTransCredit += mTransCredit;
            SubtotmTransDebit += mTransDebit;
            SubtotmCloseCredit += mCloseCredit;
            SubtotmCloseDebit += mCloseDebit;


            mCloseCredit = 0;
            mCloseDebit = 0;
            mopenCredit = 0;
            mopenDebit = 0;
            mTransCredit = 0;
            mTransDebit = 0;



            macccode= Convert.ToString(dr["acccode"]);
            maccdesc= Convert.ToString(dr["accdesc"]);
            mGropuCodeDesc= Convert.ToString(dr["groupDesc"]);
          // String PrevmGropuCodeDesc1 = "";
            mGropuCode= Convert.ToString(dr["groupCode"]);

            if (finyearstart == mToDt)
            {
                


                if (rpt_typ == "0")
                {
                    strindividual="Y";
                    mopenDebit = Convert.ToDouble(dr["opendebit"]);
                    mopenCredit = Convert.ToDouble(dr["opencredit"]);
                }
                else
                {
                    strindividual="N";
                    mopenDebit = Convert.ToDouble(dr["opendebit_i"]);
                    mopenCredit = Convert.ToDouble(dr["opencredit_i"]);
                }
            }
            else
            {
                mopenDebit = 0;
                mopenCredit = 0;
            }

            if(mopenDebit > mopenCredit)
            {
                mopenDebit=mopenDebit-mopenCredit;
				mopenCredit=0;
            }
            else
            {
                mopenCredit=mopenCredit-mopenDebit;
			    mopenDebit=0;
            }


            for (int opn1 = 0; opn1 < Str_opnAcccode_arr.Length; opn1++)
            {
                str_acctcode = Str_opnAcccode_arr[opn1].ToString();

                //mTransCredit = 0;
                //mTransDebit = 0;
                
                
                if (macccode == str_acctcode)
                {

                    String MCR = Str_mTransCredit_arr[opn1].ToString();
                    String MdR = Str_mTransDebit_arr[opn1].ToString();
                    
                    mTransCredit = Convert.ToDouble(MCR);
                    mTransDebit = Convert.ToDouble(MdR);
                }

                //mTransCredit = Convert.ToDouble(dr1["credit"]);
                //mTransDebit = Convert.ToDouble(dr1["debit"]);
            }

           
           

            mopenDebit=mopenDebit + mTransDebit;
			mopenCredit=mopenCredit + mTransCredit;

            if(mopenDebit > mopenCredit)
            {
                mopenDebit=mopenDebit-mopenCredit;
				mopenCredit=0;
            }
            else
            {
                mopenCredit=mopenCredit-mopenDebit;
			    mopenDebit=0;
            }
           
                if( mopenCredit > 0 || mopenDebit > 0) 
                {
                    mopenFlag="True";
                }
					
			
	
           if( Str_Reporttype!="opening")
           {
                mTransCredit=0;
                mTransDebit=0;

                for (int opn1_TR = 0; opn1_TR < Str_opnAcccode_TR_arr.Length; opn1_TR++)
                {
                    str_acctcode_TR = Str_opnAcccode_TR_arr[opn1_TR].ToString();

                    //mTransCredit = 0;
                    //mTransDebit = 0;


                    if (macccode == str_acctcode_TR)
                    {

                        String MCR_TR = Str_mTransCredit_arr_TR[opn1_TR].ToString();
                        String MdR_TR = Str_mTransDebit_arr_TR[opn1_TR].ToString();

                        mTransCredit = Convert.ToDouble(MCR_TR);
                        mTransDebit = Convert.ToDouble(MdR_TR);
                    }

                    //mTransCredit = Convert.ToDouble(dr1["credit"]);
                    //mTransDebit = Convert.ToDouble(dr1["debit"]);
                }
                
                mCloseDebit = mopenDebit + mTransDebit;
                mCloseCredit = mopenCredit + mTransCredit;


               if(mCloseDebit > mCloseCredit)
               {
                   mCloseDebit=mCloseDebit-mCloseCredit;
					mCloseCredit=0;
               }
               else
               {
                   mCloseCredit=mCloseCredit-mCloseDebit;
					mCloseDebit=0;
               }

             if( mCloseCredit > 0 || mCloseDebit > 0) 
             {
					mCloseFlag="True";
             }
				

           }

          
           if (mCloseCredit > 0 || mCloseDebit > 0 || mopenCredit > 0 || mopenDebit > 0 || mTransCredit > 0 || mTransDebit > 0) 
            {
                mAllFlag="True";
            }

           
					
			if(mopenFlag =="True" || mCloseFlag =="True" || mAllFlag =="True")
            {

                //if (mGropuCodeDesc != PrevmGropuCodeDesc && PrevmGropuCodeDesc!="") if (mGroupDesc != PremGroupDesc && PremGroupDesc!="")

                //!= PremGroupDesc

                if (mGropuCodeDesc != PrevmGropuCodeDesc && PrevmGropuCodeDesc != "")
                {
                    mTotalFlag = "True";
                }

                if (mTotalFlag == "True" )
                {
                    TableRow tr2 = new TableRow();

                    TableCell tr2c1 = new TableCell();
                    TableCell tr2c2 = new TableCell();
                    TableCell tr2c3 = new TableCell();

                    TableCell tr2c4 = new TableCell();
                    TableCell tr2c5 = new TableCell();
                    TableCell tr2c6 = new TableCell();

                    TableCell tr2c7 = new TableCell();
                    TableCell tr2c8 = new TableCell();
                    TableCell tr2c9 = new TableCell();


                    tr2c1.Text = " ";
                    tr2c1.CssClass = "blackboldfnt";
                   // tr2c1.Wrap = false;
                    tr2.CssClass = "bgbluegrey";
                    tr2.Cells.Add(tr2c1);

                    tr2c2.Text = "Total" + ' ' + PrevmGropuCodeDesc;
                    tr2c2.CssClass = "blackboldfnt";
                   // tr2c2.Wrap = false;
                    tr2.CssClass = "bgbluegrey";
                    tr2.Cells.Add(tr2c2);

                    tr2c3.Text = "";
                    tr2c3.CssClass = "blackfnt";
                   // tr2c3.Wrap = false;
                    tr2.CssClass = "bgbluegrey";
                    tr2.Cells.Add(tr2c3);

                    if (Str_Reporttype == "opening")
                    {
                        tr2c4.Text = SubtotmopenDebit.ToString("F2");
                        tr2c4.CssClass = "blackboldfnt";
                        tr2c4.Wrap = false;
                        tr2c4.HorizontalAlign = HorizontalAlign.Right;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c4);

                        tr2c5.Text = SubtotmopenCredit.ToString("F2");
                        tr2c5.CssClass = "blackboldfnt";
                        tr2c5.HorizontalAlign = HorizontalAlign.Right;
                        tr2c5.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c5);
                    }
                    else if (Str_Reporttype == "closing")
                    {
                        tr2c8.Text = SubtotmCloseDebit.ToString("F2");
                        tr2c8.CssClass = "blackboldfnt";
                        tr2c8.HorizontalAlign = HorizontalAlign.Right;
                        tr2c8.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c8);

                        tr2c9.Text = SubtotmCloseCredit.ToString("F2");
                        tr2c9.CssClass = "blackboldfnt";
                        tr2c9.HorizontalAlign = HorizontalAlign.Right;
                        tr2c9.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c9);

                    }
                    else if (Str_Reporttype == "all")
                    {

                        tr2c4.Text = SubtotmopenDebit.ToString("F2");
                        tr2c4.CssClass = "blackboldfnt";
                        tr2c4.HorizontalAlign = HorizontalAlign.Right;
                        tr2c4.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c4);

                        tr2c5.Text = SubtotmopenCredit.ToString("F2");
                        tr2c5.CssClass = "blackboldfnt";
                        tr2c5.HorizontalAlign = HorizontalAlign.Right;
                        tr2c5.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c5);

                        tr2c6.Text = SubtotmTransDebit.ToString("F2");
                        tr2c6.CssClass = "blackboldfnt";
                        tr2c6.HorizontalAlign = HorizontalAlign.Right;
                        tr2c6.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c6);

                        tr2c7.Text = SubtotmTransCredit.ToString("F2");
                        tr2c7.CssClass = "blackboldfnt";
                        tr2c7.HorizontalAlign = HorizontalAlign.Right;
                        tr2c7.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c7);

                        tr2c8.Text = SubtotmCloseDebit.ToString("F2");
                        tr2c8.CssClass = "blackboldfnt";
                        tr2c8.HorizontalAlign = HorizontalAlign.Right;
                        tr2c8.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c8);

                        tr2c9.Text = SubtotmCloseCredit.ToString("F2");
                        tr2c9.CssClass = "blackboldfnt";
                        tr2c9.HorizontalAlign = HorizontalAlign.Right;
                        tr2c9.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c9);

                    }
                    tblheadache.Rows.Add(tr2);

                    SubtotmopenCredit = 0;
                    SubtotmopenDebit = 0;
                    SubtotmCloseCredit = 0;
                    SubtotmCloseDebit = 0;
                    SubtotmTransCredit = 0;
                    SubtotmTransDebit = 0;
                    mTotalFlag = "";
                }

                

                
            TableRow tr1 = new TableRow();
            TableCell trc1 = new TableCell();
            TableCell trc2 = new TableCell();
            TableCell trc3 = new TableCell();

            TableCell trc4 = new TableCell();
            TableCell trc5 = new TableCell();
            TableCell trc6= new TableCell();

            TableCell trc7 = new TableCell();
            TableCell trc8 = new TableCell();
            TableCell trc9 = new TableCell();

                if (mGroupDesc != PremGroupDesc)
                {
                    if (mGroupDesc == "INC")
                    {
                        mMainGroup = "INCOME";
                    }
                    else if (mGroupDesc == "LIA")
                    {
                        mMainGroup = "LIABILITIES";
                    }
                    else if (mGroupDesc == "EXP")
                    {
                        mMainGroup = "EXPENSES";
                    }
                    else if (mGroupDesc == "ASS")
                    {
                        mMainGroup = "ASSET";
                    }



                    trc1.Text = mMainGroup;

                }
                else
                {
                    trc1.Text = "";
                }
                trc1.CssClass = "blackboldfnt";
               // trc1.Wrap = false;
                // tr1.CssClass = "bgbluegrey";
                tr1.Cells.Add(trc1);
                
                trc2.Text = "";
                if (mGropuCodeDesc != PrevmGropuCodeDesc)
                {
                    i = 0;
                    j = 0;
                    if (st_prcd != "")
                    {
                        trc2.Text = mGropuCodeDesc + "<font class=bluefnt>"+" ---> " + st_prcd + "</font>";
                    }
                    else
                    {
                        trc2.Text = mGropuCodeDesc;
                    }
                    i = i + 1;
                }
                else
                {
                    if (st_prcd != "")
                    {
                        trc2.Text = "<font class=bluefnt>" + " ---> " + st_prcd + "</font>";
                    }
                    j = j + 1;

                }

                

              //  Response.Write("<br> j : " + maccdesc+ " : " + j);
               // String dirlldown = "branch=" + strro + "~" + macccode + "~" + maccdesc + "~" + mToDt + "~" + mClosedt + "strdlstTranType=" + strindividual;
                String dirlldown = "branText=" + strro + ":" + strro + "&branch=" + strro + "&strdlstSalesAmount=" + macccode + "&dateFrom=" + mToDt + "&dateTo=" + mClosedt + "&strdlstTranType=" + strindividual;

                trc2.CssClass ="blackfnt";
               // trc2.Wrap = false;
                // tr1.CssClass = "bgbluegrey";
                tr1.Cells.Add(trc2);
                //string strFinalQS;
                /////strFinalQS = "?dirlldown=" + dirlldown;
                //strFinalQS = "?strro=" + strro;
                //strFinalQS = strFinalQS + "&macccode=" + macccode;
                //strFinalQS = strFinalQS + "&maccdesc=" + maccdesc;
                //strFinalQS = strFinalQS + "&finyearstart=" + finyearstart;

                trc3.Text = "<a href='../../accounts_mis/ledger/result.aspx?" + dirlldown + "'><u>" + maccdesc + "</u></a>";
                trc3.CssClass = "blklnkund";
                //trc3.Wrap = false;
                //tr1.CssClass = "bgbluegrey";
                tr1.Cells.Add(trc3);
                if (Str_Reporttype == "opening")
                {

                    trc4.Text = mopenDebit.ToString("F2");
                    trc4.CssClass = "blackfnt";
                    trc4.Wrap = false;
                    trc4.HorizontalAlign = HorizontalAlign.Right;
                    tr1.Cells.Add(trc4);

                    trc5.Text = mopenCredit.ToString("F2");
                    trc5.CssClass = "blackfnt";
                    trc5.Wrap = false;
                    trc5.HorizontalAlign = HorizontalAlign.Right;
                    tr1.Cells.Add(trc5);
                }
                else if (Str_Reporttype == "closing")
                {
                    trc8.Text = mCloseDebit.ToString("F2");
                    trc8.CssClass = "blackfnt";
                    trc8.HorizontalAlign = HorizontalAlign.Right;
                    trc8.Wrap = false;
                    tr1.Cells.Add(trc8);

                    trc9.Text = mCloseCredit.ToString("F2");
                    trc9.CssClass = "blackfnt";
                    trc9.HorizontalAlign = HorizontalAlign.Right;
                    trc9.Wrap = false;
                    tr1.Cells.Add(trc9);


                }
                else if (Str_Reporttype == "all")
                {

                    trc4.Text = mopenDebit.ToString("F2");
                    trc4.CssClass = "blackfnt";
                    trc4.HorizontalAlign = HorizontalAlign.Right;
                    trc4.Wrap = false;
                    tr1.Cells.Add(trc4);

                    trc5.Text = mopenCredit.ToString("F2");
                    trc5.CssClass = "blackfnt";
                    trc5.HorizontalAlign = HorizontalAlign.Right;
                    trc5.Wrap = false;
                    tr1.Cells.Add(trc5);

                    trc6.Text = mTransDebit.ToString("F2");
                    trc6.CssClass = "blackfnt";
                    trc6.HorizontalAlign = HorizontalAlign.Right;
                    trc6.Wrap = false;
                    tr1.Cells.Add(trc6);


                    trc7.Text = mTransCredit.ToString("F2");
                    trc7.CssClass = "blackfnt";
                    trc7.HorizontalAlign = HorizontalAlign.Right;
                    trc7.Wrap = false;
                    tr1.Cells.Add(trc7);

                    trc8.Text = mCloseDebit.ToString("F2");
                    trc8.CssClass = "blackfnt";
                    trc8.HorizontalAlign = HorizontalAlign.Right;
                    trc8.Wrap = false;
                    tr1.Cells.Add(trc8);

                    trc9.Text = mCloseCredit.ToString("F2");
                    trc9.CssClass = "blackfnt";
                    trc9.HorizontalAlign = HorizontalAlign.Right;
                    trc9.Wrap = false;
                    tr1.Cells.Add(trc9);
                }

                tr1.BackColor = System.Drawing.Color.White;
                tblheadache.Rows.Add(tr1);



               

                PrevmGropuCodeDesc = Convert.ToString(dr["groupDesc"]);

                PremGroupDesc = Convert.ToString(dr["Mgroupdesc"]);
            }

           

            TotalmCloseCredit += mCloseCredit;
            TotalmCloseDebit += mCloseDebit;
            TotalmopenCredit += mopenCredit;
            TotalmopenDebit += mopenDebit;
            TotalmTransCredit += mTransCredit;
            TotalmTransDebit += mTransDebit; 

        }

        TableRow tr3 = new TableRow();

        TableCell tr3c1 = new TableCell();
        TableCell tr3c2 = new TableCell();
        TableCell tr3c3 = new TableCell();

        TableCell tr3c4 = new TableCell();
        TableCell tr3c5 = new TableCell();
        TableCell tr3c6 = new TableCell();

        TableCell tr3c7 = new TableCell();
        TableCell tr3c8 = new TableCell();
        TableCell tr3c9 = new TableCell();


        tr3c1.Text = " ";
        tr3c1.CssClass = "blackboldfnt";
        tr3c1.Wrap = false;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3c1);

        tr3c2.Text = "Total" + ' ' + PrevmGropuCodeDesc;
        tr3c2.CssClass = "blackboldfnt";
        tr3c2.Wrap = false;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3c2);

        tr3c3.Text = "";
        tr3c3.CssClass = "blackfnt";
        tr3c3.Wrap = false;
        tr3.CssClass = "bgbluegrey";
        tr3.Cells.Add(tr3c3);

        if (Str_Reporttype == "opening")
        {
            tr3c4.Text = SubtotmopenDebit.ToString("F2");
            tr3c4.CssClass = "blackboldfnt";
            tr3c4.Wrap = false;
            tr3c4.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c4);

            tr3c5.Text = SubtotmopenCredit.ToString("F2");
            tr3c5.CssClass = "blackboldfnt";
            tr3c5.HorizontalAlign = HorizontalAlign.Right;
            tr3c5.Wrap = false;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c5);
        }
        else if (Str_Reporttype == "closing")
        {
            

            tr3c8.Text = SubtotmCloseDebit.ToString("F2");
            tr3c8.CssClass = "blackboldfnt";
            tr3c8.Wrap = false;
            tr3c8.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c8);

            tr3c9.Text = SubtotmCloseCredit.ToString("F2");
            tr3c9.CssClass = "blackboldfnt";
            tr3c9.Wrap = false;
            tr3c9.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c9);

        }
        else if (Str_Reporttype == "all")
        {
            tr3c4.Text = SubtotmopenDebit.ToString("F2");
            tr3c4.CssClass = "blackboldfnt";
            tr3c4.Wrap = false;
            tr3c4.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c4);

            tr3c5.Text = SubtotmopenCredit.ToString("F2");
            tr3c5.CssClass = "blackboldfnt";
            tr3c5.Wrap = false;
            tr3c5.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c5);

            tr3c6.Text = SubtotmTransDebit.ToString("F2");
            tr3c6.CssClass = "blackboldfnt";
            tr3c6.Wrap = false;
            tr3c6.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c6);

            tr3c7.Text = SubtotmTransCredit.ToString("F2");
            tr3c7.CssClass = "blackboldfnt";
            tr3c7.Wrap = false;
            tr3c7.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c7);

            tr3c8.Text = SubtotmCloseDebit.ToString("F2");
            tr3c8.CssClass = "blackboldfnt";
            tr3c8.Wrap = false;
            tr3c8.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c8);

            tr3c9.Text = SubtotmCloseCredit.ToString("F2");
            tr3c9.CssClass = "blackboldfnt";
            tr3c9.Wrap = false;
            tr3c9.HorizontalAlign = HorizontalAlign.Right;
            tr3.CssClass = "bgbluegrey";
            tr3.Cells.Add(tr3c9);




        }

        tblheadache.Rows.Add(tr3);



       
        dr.Close();

        double diffopenbald = 0, diffopenbalc = 0;
        double diffcurrbald = 0, diffcurrbalc = 0;
        double diffclosebald = 0, diffclosebalc = 0;

        if (TotalmopenDebit >= TotalmopenCredit)
        {
            diffopenbald = TotalmopenDebit - TotalmopenCredit;
            diffopenbalc = 0;
        }
        else
        {
            diffopenbald = 0;
            diffopenbalc = TotalmopenCredit - TotalmopenDebit;
        }

        if (TotalmTransDebit >= TotalmTransCredit)
        {
            diffcurrbald = TotalmTransDebit - TotalmTransCredit;
             diffcurrbalc = 0;
        }
        else
        {
            diffcurrbald = 0;
            diffcurrbalc = TotalmTransCredit - TotalmTransDebit;
        }

        if (TotalmCloseDebit >= TotalmCloseCredit)
        {
            diffclosebald = TotalmCloseDebit - TotalmCloseCredit;
            diffclosebalc = 0;
        }
        else
        {
            diffclosebald = 0;
            diffclosebalc = TotalmCloseCredit - TotalmCloseDebit;
        }

        TableRow tr4 = new TableRow();

        TableCell tr4c1 = new TableCell();
        TableCell tr4c2 = new TableCell();
        TableCell tr4c3 = new TableCell();

        TableCell tr4c4 = new TableCell();
        TableCell tr4c5 = new TableCell();
        TableCell tr4c6 = new TableCell();

        TableCell tr4c7 = new TableCell();
        TableCell tr4c8 = new TableCell();
        TableCell tr4c9 = new TableCell();


        tr4c1.Text = " ";
        tr4c1.CssClass = "blackboldfnt";
        tr4c1.Wrap = false;
        tr4c1.HorizontalAlign = HorizontalAlign.Right;
        tr4.CssClass = "bgbluegrey";
        tr4.Cells.Add(tr4c1);

        tr4c2.Text = "";
        tr4c2.CssClass = "blackboldfnt";
        tr4c2.Wrap = false;
        tr4c2.HorizontalAlign = HorizontalAlign.Right;
        tr4.CssClass = "bgbluegrey";
        tr4.Cells.Add(tr4c2);

        tr4c3.Text = "Diff in Balances";
        tr4c3.CssClass = "blackboldfnt";
        tr4c3.Wrap = false;
        tr4c3.HorizontalAlign = HorizontalAlign.Right;
        tr4.CssClass = "bgbluegrey";
        tr4.Cells.Add(tr4c3);
        if (Str_Reporttype == "opening")
        {
            tr4c4.Text = diffopenbalc.ToString("F2");
            tr4c4.CssClass = "blackboldfnt";
            tr4c4.Wrap = false;
            tr4c4.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c4);

            tr4c5.Text = diffopenbald.ToString("F2");
            tr4c5.CssClass = "blackboldfnt";
            tr4c5.Wrap = false;
            tr4c5.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c5);
        }
        else if (Str_Reporttype == "closing")
        {
            tr4c8.Text = diffclosebalc.ToString("F2");
            tr4c8.CssClass = "blackboldfnt";
            tr4c8.Wrap = false;
            tr4c8.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c8);

            tr4c9.Text = diffclosebald.ToString("F2");
            tr4c9.CssClass = "blackboldfnt";
            tr4c9.Wrap = false;
            tr4c9.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c9);

        }
        else if (Str_Reporttype == "all")
        {
            tr4c4.Text = diffopenbalc.ToString("F2");
            tr4c4.CssClass = "blackboldfnt";
            tr4c4.Wrap = false;
            tr4c4.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c4);

            tr4c5.Text = diffopenbald.ToString("F2");
            tr4c5.CssClass = "blackboldfnt";
            tr4c5.Wrap = false;
            tr4c5.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c5);

            tr4c6.Text = diffcurrbalc.ToString("F2");
            tr4c6.CssClass = "blackboldfnt";
            tr4c6.Wrap = false;
            tr4c6.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c6);

            tr4c7.Text = diffcurrbald.ToString("F2");
            tr4c7.CssClass = "blackboldfnt";
            tr4c7.Wrap = false;
            tr4c7.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c7);

            tr4c8.Text = diffclosebalc.ToString("F2");
            tr4c8.CssClass = "blackboldfnt";
            tr4c8.Wrap = false;
            tr4c8.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c8);

            tr4c9.Text = diffclosebald.ToString("F2");
            tr4c9.CssClass = "blackboldfnt";
            tr4c9.Wrap = false;
            tr4c9.HorizontalAlign = HorizontalAlign.Right;
            tr4.CssClass = "bgbluegrey";
            tr4.Cells.Add(tr4c9);
        }
        tblheadache.Rows.Add(tr4);


        TotalmopenDebit += diffopenbalc;
        TotalmopenCredit += diffopenbald;
        TotalmTransDebit += diffcurrbalc;
        TotalmTransCredit += diffcurrbald;
        TotalmCloseDebit += diffclosebalc;
        TotalmCloseCredit += diffclosebald;



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


        tr5c1.Text = " ";
        tr5c1.CssClass = "blackboldfnt";
        tr5c1.Wrap = false;
        tr5c1.HorizontalAlign = HorizontalAlign.Right;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c1);

        tr5c2.Text = "";
        tr5c2.CssClass = "blackboldfnt";
        tr5c2.Wrap = false;
        tr5c2.HorizontalAlign = HorizontalAlign.Right;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c2);

        tr5c3.Text = "Total";
        tr5c3.CssClass = "blackboldfnt";
        tr5c3.Wrap = false;
        tr5c3.HorizontalAlign = HorizontalAlign.Right;
        tr5.CssClass = "bgbluegrey";
        tr5.Cells.Add(tr5c3);

        if (Str_Reporttype == "opening")
        {
            tr5c4.Text = TotalmopenDebit.ToString("F2");
            tr5c4.CssClass = "blackboldfnt";
            tr5c4.Wrap = false;
            tr5c4.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c4);

            tr5c5.Text = TotalmopenCredit.ToString("F2");
            tr5c5.CssClass = "blackboldfnt";
            tr5c5.Wrap = false;
            tr5c5.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c5);
        }
        else if (Str_Reporttype == "closing")
        {
            tr5c8.Text = TotalmCloseDebit.ToString("F2");
            tr5c8.CssClass = "blackboldfnt";
            tr5c8.Wrap = false;
            tr5c8.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c8);

            tr5c9.Text = TotalmCloseCredit.ToString("F2");
            tr5c9.CssClass = "blackboldfnt";
            tr5c9.Wrap = false;
            tr5c9.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c9);
        }
        else if (Str_Reporttype == "all")
        {
            tr5c4.Text = TotalmopenDebit.ToString("F2");
            tr5c4.CssClass = "blackboldfnt";
            tr5c4.Wrap = false;
            tr5c4.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c4);

            tr5c5.Text = TotalmopenCredit.ToString("F2");
            tr5c5.CssClass = "blackboldfnt";
            tr5c5.Wrap = false;
            tr5c5.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c5);

            tr5c6.Text = TotalmTransDebit.ToString("F2");
            tr5c6.CssClass = "blackboldfnt";
            tr5c6.Wrap = false;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c6);

            tr5c7.Text = TotalmTransCredit.ToString("F2");
            tr5c7.CssClass = "blackboldfnt";
            tr5c7.Wrap = false;
            tr5c7.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c7);

            tr5c8.Text = TotalmCloseDebit.ToString("F2");
            tr5c8.CssClass = "blackboldfnt";
            tr5c8.Wrap = false;
            tr5c8.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c8);

            tr5c9.Text = TotalmCloseCredit.ToString("F2");
            tr5c9.CssClass = "blackboldfnt";
            tr5c9.Wrap = false;
            tr5c9.HorizontalAlign = HorizontalAlign.Right;
            tr5.CssClass = "bgbluegrey";
            tr5.Cells.Add(tr5c9);
        }
        tblheadache.Rows.Add(tr5);
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("content-disposition", "attachment; filename=Location_Report.xls");
        //BindGrid();
        string strFinalQS;

        //string dtFrom, dtTo;
        //dtFrom = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
        // dtTo = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];


        //string ro = Request.QueryString.Get("ro");
        string Flowtype = Request.QueryString.Get("Flowtype");
        string RO = Request.QueryString.Get("RO");
        string DOCDate = Request.QueryString.Get("DOCDate");
        string Reporttype = Request.QueryString.Get("Reporttype");

        strFinalQS = "?DOCDate=" + DOCDate;
        strFinalQS = strFinalQS + "&RO=" + RO;
        strFinalQS = strFinalQS + "&Flowtype=" + Flowtype;
        strFinalQS = strFinalQS + "&Reporttype=" + Reporttype;
       

        Response.Redirect("Result_Trail_balance_xls.aspx" + strFinalQS);

    }
}
