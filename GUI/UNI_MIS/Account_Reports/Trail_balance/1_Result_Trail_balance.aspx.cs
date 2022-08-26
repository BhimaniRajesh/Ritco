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
    SqlConnection conn;//, conn1;
    public static string strDateRange, mGroupTable, mToDt, mClosedt, Reporttype, Str_Reporttype, rpt_typ, ACCOunts, finyearstart, strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        ///conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            String Year = Session["FinYear"].ToString();
            string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"]) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            YearString = Convert.ToString(Year) + "_" + Convert.ToString(CloseYear);
            yearSuffix = YearString;
            finyearstart = "01 APR " + Year;
            mAcctTransTable = "webx_acctopening_" + yearSuffix;
            AcctOpenTable = "webx_acctrans_" + yearSuffix;
            AcctTable = "webx_acctinfo";
            mGroupTable = "webx_groups";
            strDateRange = Request.QueryString["DOCDate"].ToString();
            string[] strDateRange_Arr = strDateRange.Split('-');

            //lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
            mClosedt = strDateRange_Arr[1].ToString().Trim();
            // lblro.Text = strro;

            // finyearstart = Session["FinYearStart"].ToString();
            mToDt = strDateRange_Arr[0].ToString().Trim();
            rpt_typ = Request.QueryString["Flowtype"].ToString();
            Reporttype = Request.QueryString["Reporttype"].ToString();



            if (Reporttype == "0")
            {
                Str_Reporttype = "opening";
            }
            else if (Reporttype == "1")
            {
                Str_Reporttype = "closing";
            }
            else if (Reporttype == "2")
            {
                Str_Reporttype = "all";
            }



            if (rpt_typ == "0")
            {
                strindividual = "Y";

            }
            else
            {
                strindividual = "N";

            }

            //cmd.ExecuteNonQuery();
        }
        String Arr_openBal = "", Arr_OpenBal_Open = "", Arr_TransBal = "";

        Arr_openBal = "exec webx_ACCT_TRIAL_YEAROPEN  '" + mAcctTransTable + "','" + mGroupTable + "','" + AcctTable + "','" + strro + "'";

        SqlCommand cmd = new SqlCommand(Arr_openBal, conn);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        String mGroupDesc = "", mGropuCodeDesc = "", mGropuCode = "", PremGroupDesc = "", mMainGroup = "", PrevmGropuCodeDesc = "";


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

        if (Str_Reporttype == "opening")
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
        else if (Str_Reporttype == "closing")
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

        String macccode = "", maccdesc = "", mTotalFlag = "";
        int i = 0, j = 0;
        String StrmGroupDesc = "", StrmGroupDesc1 = "";
        String Strmacccode = "", Strmacccode1 = "";
        String Strmaccdesc = "", Strmaccdesc1 = "";
        String StrmGropuCodeDesc = "", StrmGropuCodeDesc1 = "";
        String StrmGropuCode = "", StrmGropuCode1 = "";
        String Str_mopenDebit = "", Str_mopenCredit = "";

        double ma=0,mb=0,mc=0,md=0;

        while (dr.Read())
        {


            //mGroupDesc = Convert.ToString(dr["Mgroupdesc"]);
            //macccode = Convert.ToString(dr["acccode"]);
            //maccdesc = Convert.ToString(dr["accdesc"]);
            //mGropuCodeDesc = Convert.ToString(dr["groupDesc"]);
            //// String PrevmGropuCodeDesc1 = "";
            //mGropuCode = Convert.ToString(dr["groupCode"]);

            if (StrmGroupDesc == "")
                StrmGroupDesc = Convert.ToString(dr["Mgroupdesc"]);
            else
                StrmGroupDesc = StrmGroupDesc + "^" + Convert.ToString(dr["Mgroupdesc"]);

            if (Strmacccode == "")
                Strmacccode = Convert.ToString(dr["acccode"]);
            else
                Strmacccode = Strmacccode + "^" + Convert.ToString(dr["acccode"]);

            if (Strmaccdesc == "")
                Strmaccdesc = Convert.ToString(dr["accdesc"]);
            else
                Strmaccdesc = Strmaccdesc + "^" + Convert.ToString(dr["accdesc"]);

            if (StrmGropuCodeDesc == "")
                StrmGropuCodeDesc = Convert.ToString(dr["groupDesc"]);
            else
                StrmGropuCodeDesc = StrmGropuCodeDesc + "^" + Convert.ToString(dr["groupDesc"]);

            if (StrmGropuCode == "")
                StrmGropuCode = Convert.ToString(dr["groupCode"]);
            else
                StrmGropuCode = StrmGropuCode + "^" + Convert.ToString(dr["groupCode"]);

            if (finyearstart == mToDt)
            {

                if (rpt_typ == "0")
                {
                    
                    ma=Convert.ToDouble(dr["opendebit"]);
                    mb = Convert.ToDouble(dr["opencredit"]);
                   
                }
                else
                {
                   // Str_mopenDebit = Convert.ToDouble(dr["opendebit_i"]);

                    ma=Convert.ToDouble(dr["opendebit_i"]);
                    mb=Convert.ToDouble(dr["opencredit_i"]);

                    
                }
            }
             else
                {
                    ma = 0;
                    mb = 0;
                }


            if(Str_mopenDebit=="")
                Str_mopenDebit = ma.ToString();
                    else
                         Str_mopenDebit = Str_mopenDebit + "^" +  ma.ToString();

                    if( Str_mopenCredit=="")
                        Str_mopenCredit = mb.ToString();
                    else
                        Str_mopenCredit = Str_mopenCredit + "^" + mb.ToString();  

        }
        dr.Close();

        string[] StrmGroupDesc_arr = StrmGroupDesc.Split('^');
        string[] Strmacccode_arr = Strmacccode.Split('^');
        string[] Strmaccdesc_arr = Strmaccdesc.Split('^');
        string[] StrmGropuCodeDesc_arr = StrmGropuCodeDesc.Split('^');
        string[] StrmGropuCode_arr = StrmGropuCode.Split('^');

        string[] Str_mopenDebit_arr = Str_mopenDebit.Split('^');
        string[] Str_mopenCredit_arr = Str_mopenCredit.Split('^');

        Response.Write("<br> StrmGropuCode : " + StrmGropuCode);

        for(int ik=0;ik<Strmacccode_arr.Length;ik++)
        {
            String mopenFlag = "False", mAllFlag = "False", mCloseFlag = "False";

            mGroupDesc = StrmGroupDesc_arr[ik].ToString();
            macccode = Strmacccode_arr[ik].ToString();
            maccdesc = Strmaccdesc_arr[ik].ToString();
            mGropuCodeDesc = StrmGropuCodeDesc_arr[ik].ToString();
            // String PrevmGropuCodeDesc1 = "";
            mGropuCode = StrmGropuCode_arr[ik].ToString();

            mopenDebit=Convert.ToDouble(Str_mopenDebit_arr[ik]);
            mopenCredit=Convert.ToDouble(Str_mopenCredit_arr[ik]);

                    Arr_OpenBal_Open=" exec WEBX_ACCT_TRIAL_OPENBAL_OPENING_Net '"+AcctOpenTable+"','"+AcctTable+"','"+strro+"','"+mToDt+"','"+strindividual+"','"+macccode+"'";
                SqlCommand cmd1 = new SqlCommand(Arr_OpenBal_Open, conn);
                SqlDataReader dr1;
                dr1= cmd1.ExecuteReader();

                while(dr1.Read())
                {
                    mTransCredit=Convert.ToDouble(dr1["credit"]);
                    mTransDebit=Convert.ToDouble(dr1["debit"]);
                }
                dr1.Close();


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

                     Arr_TransBal = "exec webx_ACCT_TRIAL_OPENBAL_Trans_net '" + AcctOpenTable + "','" + AcctTable + "','" + strro + "','" + mToDt + "','" + mClosedt + "','" + rpt_typ + "','" + macccode + "' ";
                     SqlCommand cmd2 = new SqlCommand(Arr_TransBal, conn); 
                   SqlDataReader dr2;
                    dr2= cmd2.ExecuteReader();

                    while(dr2.Read())
                    {
                        mTransCredit=Convert.ToDouble(dr2["credit"]);
                        mTransDebit=Convert.ToDouble(dr2["debit"]);
                    }
                    dr2.Close();


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

              // conn1.Close();

               if (mCloseCredit > 0 || mCloseDebit > 0 || mopenCredit > 0 || mopenDebit > 0 || mTransCredit > 0 || mTransDebit > 0) 
                {
                    mAllFlag="True";
                }



                if(mopenFlag =="True" || mCloseFlag =="True" || mAllFlag =="True")
                {




                    if (mGropuCodeDesc != PrevmGropuCodeDesc && PrevmGropuCodeDesc!="")
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
                        tr2c1.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c1);

                        tr2c2.Text = "Total" + ' ' + PrevmGropuCodeDesc;
                        tr2c2.CssClass = "blackboldfnt";
                        tr2c2.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c2);

                        tr2c3.Text = "";
                        tr2c3.CssClass = "blackfnt";
                        tr2c3.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2.Cells.Add(tr2c3);

                        if (Str_Reporttype == "opening")
                        {
                            tr2c4.Text = SubtotmopenDebit.ToString("F2");
                            tr2c4.CssClass = "blackboldfnt";
                            tr2c4.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c4);

                            tr2c5.Text = SubtotmopenCredit.ToString("F2");
                            tr2c5.CssClass = "blackboldfnt";
                            tr2c5.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c5);
                        }
                        else if (Str_Reporttype == "closing")
                        {
                            tr2c8.Text = SubtotmCloseDebit.ToString("F2");
                            tr2c8.CssClass = "blackboldfnt";
                            tr2c8.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c8);

                            tr2c9.Text = SubtotmCloseCredit.ToString("F2");
                            tr2c9.CssClass = "blackboldfnt";
                            tr2c9.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c9);

                        }
                        else if (Str_Reporttype == "all")
                        {

                            tr2c4.Text = SubtotmopenDebit.ToString("F2");
                            tr2c4.CssClass = "blackboldfnt";
                            tr2c4.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c4);

                            tr2c5.Text = SubtotmopenCredit.ToString("F2");
                            tr2c5.CssClass = "blackboldfnt";
                            tr2c5.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c5);

                            tr2c6.Text = SubtotmTransDebit.ToString("F2");
                            tr2c6.CssClass = "blackboldfnt";
                            tr2c6.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c6);

                            tr2c7.Text = SubtotmTransCredit.ToString("F2");
                            tr2c7.CssClass = "blackboldfnt";
                            tr2c7.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c7);

                            tr2c8.Text = SubtotmCloseDebit.ToString("F2");
                            tr2c8.CssClass = "blackboldfnt";
                            tr2c8.Wrap = false;
                            tr2.CssClass = "bgbluegrey";
                            tr2.Cells.Add(tr2c8);

                            tr2c9.Text = SubtotmCloseCredit.ToString("F2");
                            tr2c9.CssClass = "blackboldfnt";
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
                    trc1.Wrap = false;
                    // tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(trc1);

                    trc2.Text = "";
                    if (mGropuCodeDesc != PrevmGropuCodeDesc)
                    {
                        i = 0;
                        j = 0;
                        trc2.Text = mGropuCodeDesc;
                        i = i + 1;
                    }
                    else
                    {
                        j = j + 1;

                    }


                  //  Response.Write("<br> j : " + maccdesc+ " : " + j);


                    trc2.CssClass ="blackfnt";
                    trc2.Wrap = false;
                    // tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(trc2);

                    trc3.Text = maccdesc;
                    trc3.CssClass = "blackfnt";
                    trc3.Wrap = false;
                    //tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(trc3);
                    if (Str_Reporttype == "opening")
                    {

                        trc4.Text = mopenDebit.ToString("F2");
                        trc4.CssClass = "blackfnt";
                        trc4.Wrap = false;
                        tr1.Cells.Add(trc4);

                        trc5.Text = mopenCredit.ToString("F2");
                        trc5.CssClass = "blackfnt";
                        trc5.Wrap = false;
                        tr1.Cells.Add(trc5);
                    }
                    else if (Str_Reporttype == "closing")
                    {
                        trc8.Text = mCloseDebit.ToString("F2");
                        trc8.CssClass = "blackfnt";
                        trc8.Wrap = false;
                        tr1.Cells.Add(trc8);

                        trc9.Text = mCloseCredit.ToString("F2");
                        trc9.CssClass = "blackfnt";
                        trc9.Wrap = false;
                        tr1.Cells.Add(trc9);


                    }
                    else if (Str_Reporttype == "all")
                    {

                        trc4.Text = mopenDebit.ToString("F2");
                        trc4.CssClass = "blackfnt";
                        trc4.Wrap = false;
                        tr1.Cells.Add(trc4);

                        trc5.Text = mopenCredit.ToString("F2");
                        trc5.CssClass = "blackfnt";
                        trc5.Wrap = false;
                        tr1.Cells.Add(trc5);

                        trc6.Text = mTransDebit.ToString("F2");
                        trc6.CssClass = "blackfnt";
                        trc6.Wrap = false;
                        tr1.Cells.Add(trc6);


                        trc7.Text = mTransCredit.ToString("F2");
                        trc7.CssClass = "blackfnt";
                        trc7.Wrap = false;
                        tr1.Cells.Add(trc7);

                        trc8.Text = mCloseDebit.ToString("F2");
                        trc8.CssClass = "blackfnt";
                        trc8.Wrap = false;
                        tr1.Cells.Add(trc8);

                        trc9.Text = mCloseCredit.ToString("F2");
                        trc9.CssClass = "blackfnt";
                        trc9.Wrap = false;
                        tr1.Cells.Add(trc9);
                    }

                    tr1.BackColor = System.Drawing.Color.White;
                    tblheadache.Rows.Add(tr1);



                    PrevmGropuCodeDesc = mGropuCodeDesc;

                    PremGroupDesc = mGroupDesc;

                    
                }





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
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c4);

                tr3c5.Text = SubtotmopenCredit.ToString("F2");
                tr3c5.CssClass = "blackboldfnt";
                tr3c5.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c5);
            }
            else if (Str_Reporttype == "closing")
            {
                tr3c8.Text = SubtotmCloseDebit.ToString("F2");
                tr3c8.CssClass = "blackboldfnt";
                tr3c8.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c8);

                tr3c9.Text = SubtotmCloseCredit.ToString("F2");
                tr3c9.CssClass = "blackboldfnt";
                tr3c9.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c9);

            }
            else if (Str_Reporttype == "all")
            {
                tr3c6.Text = SubtotmTransDebit.ToString("F2");
                tr3c6.CssClass = "blackboldfnt";
                tr3c6.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c6);

                tr3c7.Text = SubtotmTransCredit.ToString("F2");
                tr3c7.CssClass = "blackboldfnt";
                tr3c7.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c7);

                tr3c8.Text = SubtotmCloseDebit.ToString("F2");
                tr3c8.CssClass = "blackboldfnt";
                tr3c8.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c8);

                tr3c9.Text = SubtotmCloseCredit.ToString("F2");
                tr3c9.CssClass = "blackboldfnt";
                tr3c9.Wrap = false;
                tr3.CssClass = "bgbluegrey";
                tr3.Cells.Add(tr3c9);
            }

            tblheadache.Rows.Add(tr3);

        }
}



  

        






        //    double diffopenbald = 0, diffopenbalc = 0;
        //    double diffcurrbald = 0, diffcurrbalc = 0;
        //    double diffclosebald = 0, diffclosebalc = 0;

        //    if (TotalmopenDebit >= TotalmopenCredit)
        //    {
        //        diffopenbald = TotalmopenDebit - TotalmopenCredit;
        //        diffopenbalc = 0;
        //    }
        //    else
        //    {
        //        diffopenbald = 0;
        //        diffopenbalc = TotalmopenCredit - TotalmopenDebit;
        //    }

        //    if (TotalmTransDebit >= TotalmTransCredit)
        //    {
        //        diffcurrbald = TotalmTransDebit - TotalmTransCredit;
        //         diffcurrbalc = 0;
        //    }
        //    else
        //    {
        //        diffcurrbald = 0;
        //        diffcurrbalc = TotalmTransCredit - TotalmTransDebit;
        //    }

        //    if (TotalmCloseDebit >= TotalmCloseCredit)
        //    {
        //        diffclosebald = TotalmCloseDebit - TotalmCloseCredit;
        //        diffclosebalc = 0;
        //    }
        //    else
        //    {
        //        diffclosebald = 0;
        //        diffclosebalc = TotalmCloseCredit - TotalmCloseDebit;
        //    }

        //    TableRow tr4 = new TableRow();

        //    TableCell tr4c1 = new TableCell();
        //    TableCell tr4c2 = new TableCell();
        //    TableCell tr4c3 = new TableCell();

        //    TableCell tr4c4 = new TableCell();
        //    TableCell tr4c5 = new TableCell();
        //    TableCell tr4c6 = new TableCell();

        //    TableCell tr4c7 = new TableCell();
        //    TableCell tr4c8 = new TableCell();
        //    TableCell tr4c9 = new TableCell();


        //    tr4c1.Text = " ";
        //    tr4c1.CssClass = "blackboldfnt";
        //    tr4c1.Wrap = false;
        //    tr4.CssClass = "bgbluegrey";
        //    tr4.Cells.Add(tr4c1);

        //    tr4c2.Text = "";
        //    tr4c2.CssClass = "blackboldfnt";
        //    tr4c2.Wrap = false;
        //    tr4.CssClass = "bgbluegrey";
        //    tr4.Cells.Add(tr4c2);

        //    tr4c3.Text = "Diff in Balances";
        //    tr4c3.CssClass = "blackboldfnt";
        //    tr4c3.Wrap = false;
        //    tr4.CssClass = "bgbluegrey";
        //    tr4.Cells.Add(tr4c3);
        //    if (Str_Reporttype == "opening")
        //    {
        //        tr4c4.Text = diffopenbalc.ToString("F2");
        //        tr4c4.CssClass = "blackboldfnt";
        //        tr4c4.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c4);

        //        tr4c5.Text = diffopenbald.ToString("F2");
        //        tr4c5.CssClass = "blackboldfnt";
        //        tr4c5.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c5);
        //    }
        //    else if (Str_Reporttype == "closing")
        //    {
        //        tr4c8.Text = diffclosebalc.ToString("F2");
        //        tr4c8.CssClass = "blackboldfnt";
        //        tr4c8.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c8);

        //        tr4c9.Text = diffclosebald.ToString("F2");
        //        tr4c9.CssClass = "blackboldfnt";
        //        tr4c9.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c9);

        //    }
        //    else if (Str_Reporttype == "all")
        //    {

        //        tr4c6.Text = diffcurrbalc.ToString("F2");
        //        tr4c6.CssClass = "blackboldfnt";
        //        tr4c6.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c6);

        //        tr4c7.Text = diffcurrbald.ToString("F2");
        //        tr4c7.CssClass = "blackboldfnt";
        //        tr4c7.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c7);

        //        tr4c8.Text = diffclosebalc.ToString("F2");
        //        tr4c8.CssClass = "blackboldfnt";
        //        tr4c8.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c8);

        //        tr4c9.Text = diffclosebald.ToString("F2");
        //        tr4c9.CssClass = "blackboldfnt";
        //        tr4c9.Wrap = false;
        //        tr4.CssClass = "bgbluegrey";
        //        tr4.Cells.Add(tr4c9);
        //    }
        //    tblheadache.Rows.Add(tr4);


        //    TotalmopenDebit += diffopenbalc;
        //    TotalmopenCredit += diffopenbald;
        //    TotalmTransDebit += diffcurrbalc;
        //    TotalmTransCredit += diffcurrbald;
        //    TotalmCloseDebit += diffclosebalc;
        //    TotalmCloseCredit += diffclosebald;



        //    TableRow tr5 = new TableRow();

        //    TableCell tr5c1 = new TableCell();
        //    TableCell tr5c2 = new TableCell();
        //    TableCell tr5c3 = new TableCell();

        //    TableCell tr5c4 = new TableCell();
        //    TableCell tr5c5 = new TableCell();
        //    TableCell tr5c6 = new TableCell();

        //    TableCell tr5c7 = new TableCell();
        //    TableCell tr5c8 = new TableCell();
        //    TableCell tr5c9 = new TableCell();


        //    tr5c1.Text = " ";
        //    tr5c1.CssClass = "blackboldfnt";
        //    tr5c1.Wrap = false;
        //    tr5.CssClass = "bgbluegrey";
        //    tr5.Cells.Add(tr5c1);

        //    tr5c2.Text = "";
        //    tr5c2.CssClass = "blackboldfnt";
        //    tr5c2.Wrap = false;
        //    tr5.CssClass = "bgbluegrey";
        //    tr5.Cells.Add(tr5c2);

        //    tr5c3.Text = "Total";
        //    tr5c3.CssClass = "blackboldfnt";
        //    tr5c3.Wrap = false;
        //    tr5.CssClass = "bgbluegrey";
        //    tr5.Cells.Add(tr5c3);

        //    if (Str_Reporttype == "opening")
        //    {
        //        tr5c4.Text = TotalmopenDebit.ToString("F2");
        //        tr5c4.CssClass = "blackboldfnt";
        //        tr5c4.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c4);

        //        tr5c5.Text = TotalmopenCredit.ToString("F2");
        //        tr5c5.CssClass = "blackboldfnt";
        //        tr5c5.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c5);
        //    }
        //    else if (Str_Reporttype == "closing")
        //    {
        //        tr5c8.Text = TotalmCloseDebit.ToString("F2");
        //        tr5c8.CssClass = "blackboldfnt";
        //        tr5c8.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c8);

        //        tr5c9.Text = TotalmCloseCredit.ToString("F2");
        //        tr5c9.CssClass = "blackboldfnt";
        //        tr5c9.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c9);
        //    }
        //    else if (Str_Reporttype == "all")
        //    {
        //        tr5c6.Text = TotalmTransDebit.ToString("F2");
        //        tr5c6.CssClass = "blackboldfnt";
        //        tr5c6.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c6);

        //        tr5c7.Text = TotalmTransCredit.ToString("F2");
        //        tr5c7.CssClass = "blackboldfnt";
        //        tr5c7.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c7);

        //        tr5c8.Text = TotalmCloseDebit.ToString("F2");
        //        tr5c8.CssClass = "blackboldfnt";
        //        tr5c8.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c8);

        //        tr5c9.Text = TotalmCloseCredit.ToString("F2");
        //        tr5c9.CssClass = "blackboldfnt";
        //        tr5c9.Wrap = false;
        //        tr5.CssClass = "bgbluegrey";
        //        tr5.Cells.Add(tr5c9);
        //    }
        //    tblheadache.Rows.Add(tr5);
        //}
    

