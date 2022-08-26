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
public partial class GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance12 : System.Web.UI.Page
{

  
        SqlConnection conn,conn1;
    double st_totinc = 0, st_totexp = 0, st_profit_loss = 0,tot_cashdebit = 0, tot_cashcredit = 0, cashclosedebit = 0, cashclosecredit = 0, tot_bankdebit = 0, tot_bankcredit = 0, bankClosecredit = 0, bankClosedebit=0;
    public static string strDateRange, String_loccode,chkstate, String_accode, rpt_typ, ACCOunts, a_todt, a_frmdt, finyearstart, strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    protected void Page_Load(object sender, EventArgs e)
    {  Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition","attachment; filename=Profit_loss.xls");

        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn1.Open();
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
            mAcctTransTable = "webx_acctrans_" + yearSuffix;
            AcctOpenTable = "webx_acctopening_" + yearSuffix;
            AcctTable = "webx_acctinfo";
            //Session["HeadOfficeCode1"] = "HQTR";
            strDateRange = Request.QueryString["DOCDate"].ToString();
            string[] strDateRange_arr = strDateRange.Split('-');
            a_todt = strDateRange_arr[1].ToString().Trim();
            a_frmdt = strDateRange_arr[0].ToString().Trim();
            lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
            chkstate = Request.QueryString["chkstate"].ToString();
            //strro = "HQTR";
            lblro.Text = strro;
            rpt_typ = Request.QueryString["Flowtype"].ToString();

            String SQL_Closing = "";
            if (rpt_typ == "0")
            {
                rpt_typ = "Y";
                SQL_Closing = "exec Webx_profitloss_closingbalance_Net '" + mAcctTransTable + "','" + AcctTable + "','" + strro + "','" + a_todt + "','Y','" + a_frmdt + "'";
            }
            else
            {
                rpt_typ = "N";
                SQL_Closing = "exec Webx_profitloss_closingbalance_Net '" + mAcctTransTable + "','" + AcctTable + "','','" + a_todt + "','N','" + a_frmdt + "'";
            }
            //lblro.Text = strro;
            //ACCOunts = Request.QueryString["ACCOunts"].ToString();

            // String SQL_Closing = "exec Webx_profitloss_closingbalance_Net '" + mAcctTransTable + "','" + AcctTable + "','" + strro + "','" + a_todt + "','" + rpt_typ + "','" + finyearstart + "'";
            SqlCommand cmd3Closing = new SqlCommand(SQL_Closing, conn);
            cmd3Closing.ExecuteNonQuery();

        }

        //BindGrid();
        //BankList();


        //////////////////////////////////NIMESH CODING


        string[] String_accode = new string[2000];
        string[] String_accdesc = new string[2000];
        string stracccode = "", straccdesc = "", SubGrp_Str = "", st_y_n = "N";

        String SQL_ACC_ABCD = "select a.acccode,accdesc,acccategory,bkloccode from webx_acctinfo a where upper(acccategory) in ('BANK','CASH') order by acccategory desc";


        SqlCommand cmd3123 = new SqlCommand(SQL_ACC_ABCD, conn);
        SqlDataReader dr123 = cmd3123.ExecuteReader();
        int c = 0;
        while (dr123.Read())
        {

            if (stracccode.CompareTo("") == 0)
                stracccode = Convert.ToString(dr123["acccode"]);
            else
                stracccode = stracccode + "," + Convert.ToString(dr123["acccode"]);


            String_accdesc[c++] = Convert.ToString(dr123["accdesc"]);
        }

        dr123.Close();




        //// agra row
        String SQL_top = "";//select BANK_OPNDEBIT=sum(case when acccategory='BANK' then debit else 0 end),BANK_OPNCredit=sum(case when acccategory='BANK' then credit else 0 end),CASH_OPNDEBIT=sum(case when acccategory='CASH' then debit else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then credit else 0 end)  from " + AcctOpenTable + " M," + AcctTable + " D where m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106)  ";

        if (strro == "")
        {
            SQL_top = "select  loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and (loc_level='2' or loc_level='1') order by locName";
        }
        else if (strro == Session["HeadOfficeCode"].ToString() && rpt_typ == "N")
        {

            SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and (loc_level='2' or loc_level='1') order by locName";
        }
        else
        {
            if (rpt_typ == "Y")
            {
                SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and loccode='" + strro + "' order by locName";
            }
            else
            {
                SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and loccode='" + strro + "' order by locName";
            }

        }
        //else 
        //{
        //    SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and report_loc='" + strro + "' order by locName";
        //}


        cmd3123 = new SqlCommand(SQL_top, conn);

        string strloc = "", strloccode = "";
        c = 0;
        dr123 = cmd3123.ExecuteReader();
        while (dr123.Read())
        {
            if (strloc == "")
                strloc = dr123["locname"].ToString();
            else
                strloc = strloc + "," + dr123["locname"].ToString();


            if (strloccode == "")
                strloccode = dr123["loccode"].ToString();
            else
                strloccode = strloccode + "," + dr123["loccode"].ToString();


        }
        dr123.Close();

        string[] String_loc = strloc.Split(',');
        string[] String_loccode = strloccode.Split(',');


        ////////////////////////////////////////////////////// DEBIT ARRY

        string[] stracccode_arr = stracccode.Split(',');
        int opn = stracccode_arr.Length;








        TableRow tr = new TableRow();
        TableRow tr1 = new TableRow();
        TableRow tr2 = new TableRow();

        TableCell tc1 = new TableCell();
        TableCell tc2 = new TableCell();
        TableCell tc3 = new TableCell();

        tc1.CssClass = "blackfnt";
        tc1.Text = "PROFIT AND LOSS ACCOUNT";
        tc1.Wrap = false;
        //tc2.Text = "Particulars";
        tr.CssClass = "bgbluegrey";
        //tc2.CssClass = "blackfnt";
        tr.Cells.Add(tc1);

        tc2.CssClass = "blackfnt";
        tc2.Text = "<-----PARTICULARS----->";
        //tc2.Text = "Particulars";
        tr1.CssClass = "bgbluegrey";
        //tc2.CssClass = "blackfnt";
        tr1.Cells.Add(tc2);

        tr2.CssClass = "bgbluegrey";
        tc3.CssClass = "blackfnt";
        tc3.Text = "Locations";
        tr2.Cells.Add(tc3);
        // tr.Cells.Add(tc2);
        int abc_colun = 0;
        String Str_all_lococde = "";
        String Str_all_lococde_All = "";
        String SQL_RO_LO = "";
        for (int i = 0; i < String_loccode.Length; i++)
        {

            TableCell tc = new TableCell();
            tc.Text = String_loc[i];

            tr.Cells.Add(tc);
            tc.CssClass = "blackfnt";
            tc.RowSpan = 2;

            SQL_RO_LO = "select loccode,locname=(loccode+' : '+locname)  from webx_location where activeFlag='Y' and report_loc='" + String_loccode[i].ToString() + "' or loccode='" + String_loccode[i].ToString() + "'";
            if (rpt_typ == "Y")
            {
                SQL_RO_LO = "select loccode,locname=(loccode+' : '+locname)  from webx_location where activeFlag='Y' and loccode='" + String_loccode[i].ToString() + "'";
            }

            SqlCommand cmd3123_ro = new SqlCommand(SQL_RO_LO, conn);

            string strloc_ro = "", strloccode_ro = "";

            SqlDataReader dr123_ro = cmd3123_ro.ExecuteReader();
            while (dr123_ro.Read())
            {
                if (strloc_ro == "")
                    strloc_ro = dr123_ro["locname"].ToString();
                else
                    strloc_ro = strloc_ro + "," + dr123_ro["locname"].ToString();


                if (strloccode_ro == "")
                    strloccode_ro = dr123_ro["loccode"].ToString();
                else
                    strloccode_ro = strloccode_ro + "," + dr123_ro["loccode"].ToString();




            }
            dr123_ro.Close();



            if (strloccode_ro != "")
            {
                if (Str_all_lococde == "")
                    Str_all_lococde = strloccode_ro;
                else
                    Str_all_lococde = Str_all_lococde + "," + strloccode_ro;

            }


            string[] String_loc_ro = strloc_ro.Split(',');
            string[] String_loccode_ro = strloccode_ro.Split(',');

            for (int ro_i = 0; ro_i < String_loccode_ro.Length; ro_i++)
            {

                TableCell tc21 = new TableCell();
                tc21.Text = String_loc_ro[ro_i];

                tr2.Cells.Add(tc21);
                tc21.CssClass = "blackfnt";

                abc_colun = abc_colun + 2;
            }

            tc.ColumnSpan = String_loccode_ro.Length;



        }
        if (rpt_typ == "N")
        {
            TableCell tc22 = new TableCell();
            tc22.Text = " Total";
            if (rpt_typ == "N")
            {
                tc22.Text = " Total Of " + Session["HeadOfficeCode"].ToString();
            }
            tc22.CssClass = "blackfnt";
            tc22.RowSpan = 3;
            tr.Cells.Add(tc22);
        }



        tblheadache.Rows.Add(tr);

        tblheadache.Rows.Add(tr1);
        tblheadache.Rows.Add(tr2);

        String SQL_ACCT_INC = " select Groupcode,groupdesc=(Company_Groupcode+' : '+ groupdesc) from webx_groups  where  Groupcode like 'INC%'  order by groupdesc ";
        SqlCommand cmd3123_ACC_INC = new SqlCommand(SQL_ACCT_INC, conn);

        string strloc_ACC_INC = "", strloccode_ACC_INC = "";

        SqlDataReader dr123_ACC_INC = cmd3123_ACC_INC.ExecuteReader();
        while (dr123_ACC_INC.Read())
        {
            if (strloc_ACC_INC == "")
                strloc_ACC_INC = dr123_ACC_INC["groupdesc"].ToString();
            else
                strloc_ACC_INC = strloc_ACC_INC + "^" + dr123_ACC_INC["groupdesc"].ToString();


            if (strloccode_ACC_INC == "")
                strloccode_ACC_INC = dr123_ACC_INC["Groupcode"].ToString();
            else
                strloccode_ACC_INC = strloccode_ACC_INC + "^" + dr123_ACC_INC["Groupcode"].ToString();

            st_y_n = "N";
            if (SubGrp_Str.CompareTo("") == 0)
                SubGrp_Str = st_y_n;
            else
                SubGrp_Str = SubGrp_Str + "," + st_y_n;


            if (chkstate == "False")
            {
                st_y_n = "Y";

                String SQL_ACC_SubGroup = "select a.acccode,accdesc=(Company_Acccode+' : '+ accdesc) ,acccategory,bkloccode from webx_acctinfo a where  a.groupcode='" + dr123_ACC_INC["Groupcode"].ToString() + "'";
                SqlCommand cmd3Sub = new SqlCommand(SQL_ACC_SubGroup, conn1);
                SqlDataReader drSub = cmd3Sub.ExecuteReader();

                while (drSub.Read())
                {

                    if (strloccode_ACC_INC.CompareTo("") == 0)
                        strloccode_ACC_INC = Convert.ToString(drSub["acccode"]);
                    else
                        strloccode_ACC_INC = strloccode_ACC_INC + "^" + Convert.ToString(drSub["acccode"]);


                    if (strloc_ACC_INC == "")
                        strloc_ACC_INC = drSub["accdesc"].ToString();
                    else
                        strloc_ACC_INC = strloc_ACC_INC + "^" + drSub["accdesc"].ToString();

                    if (SubGrp_Str.CompareTo("") == 0)
                        SubGrp_Str = st_y_n;
                    else
                        SubGrp_Str = SubGrp_Str + "," + st_y_n;

                    // String_accdesc[c++] = Convert.ToString(dr123["accdesc"]);

                }

                drSub.Close();
            }

        }
        dr123_ACC_INC.Close();

        TableRow tr3Ei = new TableRow();
        TableCell tc4Ei = new TableCell();
        tr3Ei.BackColor = System.Drawing.Color.White;
        tc4Ei.Text = "INCOME";
        tc4Ei.CssClass = "blackboldfnt";
        tr3Ei.Cells.Add(tc4Ei);
        tc4Ei.ColumnSpan = abc_colun + 1;
        tblheadache.Rows.Add(tr3Ei);

        string strloc_ACC_INC_total = strloc_ACC_INC + "^" + "Total INCOME";
        string strloccode_ACC_INC_total = strloccode_ACC_INC + "^" + "totinc";
        string SubGrp_Str1 = SubGrp_Str + ",N";
        string[] SubGrp_StrArr = SubGrp_Str1.Split(',');

        string SubGrp = "";

        //if (rpt_typ == "N")
        //{
        //strloc_ACC_INC_total = strloc_ACC_INC;
        //strloccode_ACC_INC_total = strloccode_ACC_INC;
        //}

        string[] String_loc_ACC_INC = strloc_ACC_INC_total.Split('^');
        string[] String_loccode_ACC_INC = strloccode_ACC_INC_total.Split('^');

        for (int Acc_i = 0; Acc_i < String_loccode_ACC_INC.Length; Acc_i++)
        {
            TableRow tr3 = new TableRow();
            SubGrp = SubGrp_StrArr[Acc_i].ToString();
            TableCell tc5 = new TableCell();
            tc5.Text = String_loc_ACC_INC[Acc_i];
            tc5.CssClass = "blackfnt";
            tc5.BackColor = System.Drawing.Color.White;
            if (SubGrp == "Y")
            {
                //  tc5.BackColor = System.Drawing.Color.LightGray;
                tc5.Text = " ----   " + String_loc_ACC_INC[Acc_i];
                tc5.CssClass = "bluefnt";
            }
            if (String_loccode_ACC_INC[Acc_i] == "totinc")
            {
                tc5.CssClass = "blackboldfnt";
            }
            tc5.Wrap = false;


            tr3.Cells.Add(tc5);

            if (rpt_typ == "N")
            {
                Str_all_lococde_All = Str_all_lococde + "," + "All";
            }
            else
            {
                Str_all_lococde_All = Str_all_lococde;
            }

            string[] Str_all_lococde_arr = Str_all_lococde_All.Split(',');


            for (int Acc_l_i = 0; Acc_l_i < Str_all_lococde_arr.Length; Acc_l_i++)
            {

                

                TableCell tc4 = new TableCell();

                String SQL_PL = "exec Webx_profir_Loss_Net '" + finyearstart + "','" + a_todt + "','" + Str_all_lococde_arr[Acc_l_i] + "','" + String_loccode_ACC_INC[Acc_i] + "','" + SubGrp + "'";
                SqlCommand cmd3123_ACC_LOC = new SqlCommand(SQL_PL, conn);

                decimal Amt_Bal = 0, Amt_Bal_fin = 0;

                SqlDataReader dr123_ACC_LOC = cmd3123_ACC_LOC.ExecuteReader();
                while (dr123_ACC_LOC.Read())
                {


                    if (dr123_ACC_LOC["Acc_total_fin"] is DBNull)
                    {
                        Amt_Bal = 0;
                    }
                    else
                    {
                        Amt_Bal = Convert.ToDecimal(dr123_ACC_LOC["Acc_total_fin"]);
                    }


                }
                dr123_ACC_LOC.Close();

                //if (Amt_Bal != 0)
                //{


                string popstr1 = a_frmdt + "~" + a_todt + "~" + mAcctTransTable + "~" + Str_all_lococde_arr[Acc_l_i] + "~" + String_loccode_ACC_INC[Acc_i] + "~" + rpt_typ;

                tc4.Text = Convert.ToString(Amt_Bal);
                tc4.Text = "<a href=\"JavaScript:OpenPopupWindow1('" + popstr1 + "')\"><u>" + Convert.ToString(Amt_Bal) + " </u></a>";

                tc4.CssClass = "blackfnt";
                if (String_loccode_ACC_INC[Acc_i] == "totinc")
                {
                    st_totinc = Convert.ToDouble(Amt_Bal);
                }
                if (String_loccode_ACC_INC[Acc_i] == "totinc" || Str_all_lococde_arr[Acc_l_i] == "All" || Convert.ToString(Amt_Bal) == "0" || SubGrp == "Y")
                {
                    tc4.Text = Convert.ToString(Amt_Bal);
                    if (SubGrp == "Y")
                    {
                        popstr1 = "branch=" + Str_all_lococde_arr[Acc_l_i] + "&strdlstSalesAmount=" + String_loccode_ACC_INC[Acc_i] + "&dateFrom=" + a_frmdt + "&dateTo=" + a_todt + "&strdlstTranType=" + rpt_typ;
                        string popstr12 = Str_all_lococde_arr[Acc_l_i] + "~" + String_loccode_ACC_INC[Acc_i] + "~" + String_loc_ACC_INC[Acc_i] + "~" + a_frmdt + "~" + a_todt + "~" + rpt_typ;
                        tc4.Text = "<a href=\"JavaScript:OpenPopupWindow2('" + popstr1 + "')\"><u><font class='bluefnt'>" + Convert.ToString(Amt_Bal) + "</font> </u></a>";//<a href=\"JavaScript:OpenPopupWindow3('" + popstr12 + "')\"><u><font class='bluefnt'>" + Convert.ToString(Amt_Bal) + "</font> </u></a>";
                        // tc4.Text = "<a href='../../accounts_mis/ledger/result.aspx?" + popstr1 + "'><u><font class='bluefnt'>" + Convert.ToString(Amt_Bal) + " </font></u></a>";

                        //popstr1 = Str_all_lococde_arr[Acc_l_i] + "~" + String_loccode_ACC_INC[Acc_i] + "~" + String_loc_ACC_INC[Acc_i] + "~" + a_frmdt + "~" + a_todt + "~" + rpt_typ;
                        //tc4.Text = "<a href='../Trail_balance/Voucherlist_trailbalance.aspx?" + popstr1 + "'><u><font class='bluefnt'>" + Convert.ToString(Amt_Bal) + " </font></u></a>";

                        tc4.CssClass = "bluefnt";
                        // trc3.Text = "<a href='../../accounts_mis/ledger/result.aspx?" + dirlldown + "'><u>" + maccdesc + "</u></a>";
                    }
                }
                tc4.Text = Convert.ToString(Amt_Bal);
                tc4.HorizontalAlign = HorizontalAlign.Right;

                tr3.Cells.Add(tc4);
                tc4.BackColor = System.Drawing.Color.White;

                //}

            }

            tblheadache.Rows.Add(tr3);

            //tr3.BackColor = System.Drawing.Color.White;





        }


        TableRow tr3EH = new TableRow();
        TableCell tc4EH = new TableCell();
        tr3EH.BackColor = System.Drawing.Color.White;
        tc4EH.Text = "EXPENSE";
        tc4EH.CssClass = "blackboldfnt";
        tr3EH.Cells.Add(tc4EH);
        tc4EH.ColumnSpan = abc_colun + 1;
        tblheadache.Rows.Add(tr3EH);

        String SQL_ACCT_EXP = " select Groupcode,groupdesc=(Company_Groupcode+' : '+ groupdesc) from webx_groups  where  parentcode like 'EXP%'  order by groupdesc desc";
        SqlCommand cmd3123_ACC_EXP = new SqlCommand(SQL_ACCT_EXP, conn);

        string strloc_ACC_EXP = "", strloccode_ACC_EXP = "", SubGrp_Str_EXP = "", st_y_n_EXP = "N";

        SqlDataReader dr123_ACC_EXP = cmd3123_ACC_EXP.ExecuteReader();
        while (dr123_ACC_EXP.Read())
        {
            if (strloc_ACC_EXP == "")
                strloc_ACC_EXP = dr123_ACC_EXP["groupdesc"].ToString();
            else
                strloc_ACC_EXP = strloc_ACC_EXP + "^" + dr123_ACC_EXP["groupdesc"].ToString();

            st_y_n_EXP = "N";
            if (strloccode_ACC_EXP == "")
                strloccode_ACC_EXP = dr123_ACC_EXP["Groupcode"].ToString();
            else
                strloccode_ACC_EXP = strloccode_ACC_EXP + "^" + dr123_ACC_EXP["Groupcode"].ToString();



            if (SubGrp_Str_EXP.CompareTo("") == 0)
                SubGrp_Str_EXP = st_y_n_EXP;
            else
                SubGrp_Str_EXP = SubGrp_Str_EXP + "," + st_y_n_EXP;


            if (chkstate == "False")
            {
                st_y_n_EXP = "Y";

                String SQL_ACC_SubGroupE = "select a.acccode,accdesc=(Company_Acccode+' : '+ accdesc) ,acccategory,bkloccode from webx_acctinfo a where  a.groupcode='" + dr123_ACC_EXP["Groupcode"].ToString() + "'";
                SqlCommand cmd3SubE = new SqlCommand(SQL_ACC_SubGroupE, conn1);
                SqlDataReader drSubE = cmd3SubE.ExecuteReader();

                while (drSubE.Read())
                {

                    if (strloccode_ACC_EXP.CompareTo("") == 0)
                        strloccode_ACC_EXP = Convert.ToString(drSubE["acccode"]);
                    else
                        strloccode_ACC_EXP = strloccode_ACC_EXP + "^" + Convert.ToString(drSubE["acccode"]);


                    if (strloc_ACC_EXP == "")
                        strloc_ACC_EXP = drSubE["accdesc"].ToString();
                    else
                        strloc_ACC_EXP = strloc_ACC_EXP + "^" + drSubE["accdesc"].ToString();

                    if (SubGrp_Str_EXP.CompareTo("") == 0)
                        SubGrp_Str_EXP = st_y_n_EXP;
                    else
                        SubGrp_Str_EXP = SubGrp_Str_EXP + "," + st_y_n_EXP;

                    // String_accdesc[c++] = Convert.ToString(dr123["accdesc"]);

                }

                drSubE.Close();
            }

        }
        dr123_ACC_EXP.Close();

        string SubGrp_Str_EXP1 = SubGrp_Str_EXP + ",N,N";
        string[] SubGrp_Str_EXPArr = SubGrp_Str_EXP1.Split(',');
        String strloc_ACC_EXP_total = strloc_ACC_EXP + "^" + "Total EXPENSE";
        String strloccode_ACC_EXP_total = strloccode_ACC_EXP + "^" + "totexp";
        string SubGrp_EXP = "";
        if (rpt_typ == "N")
        {
            strloc_ACC_EXP_total = strloc_ACC_EXP;
            strloccode_ACC_EXP_total = strloccode_ACC_EXP;
        }

        string[] String_loc_ACC_EXP = strloc_ACC_EXP_total.Split('^');
        string[] String_loccode_ACC_EXP = strloccode_ACC_EXP_total.Split('^');

        for (int AccE_i = 0; AccE_i < String_loccode_ACC_EXP.Length; AccE_i++)
        {

            SubGrp_EXP = SubGrp_Str_EXPArr[AccE_i].ToString();
            TableRow tr3E = new TableRow();
            TableCell tc4E = new TableCell();
            TableCell tc5E = new TableCell();

            tc5E.BackColor = System.Drawing.Color.White;
            tc5E.CssClass = "blackfnt";
            tc5E.Text = String_loc_ACC_EXP[AccE_i];
            if (SubGrp_EXP == "Y")
            {
                //  tc5.BackColor = System.Drawing.Color.LightGray;
                tc5E.Text = " ----   " + String_loc_ACC_EXP[AccE_i];
                tc5E.CssClass = "bluefnt";
            }
            tc5E.Wrap = false;

            if (String_loc_ACC_EXP[AccE_i] == "Total EXPENSE")
            {
                tc5E.CssClass = "blackboldfnt";
            }
            tr3E.Cells.Add(tc5E);



            string[] Str_all_lococde_arrE = Str_all_lococde_All.Split(',');

            for (int Acc_l_iE = 0; Acc_l_iE < Str_all_lococde_arrE.Length; Acc_l_iE++)
            {




                String SQL_PLE = "exec Webx_profir_Loss_Net '" + finyearstart + "','" + a_todt + "','" + Str_all_lococde_arrE[Acc_l_iE] + "','" + String_loccode_ACC_EXP[AccE_i] + "','" + SubGrp_EXP + "'";
                SqlCommand cmd3123_ACC_LOCE = new SqlCommand(SQL_PLE, conn);

                decimal Amt_BalE = 0, Amt_Bal_finE = 0;

                SqlDataReader dr123_ACC_LOCE = cmd3123_ACC_LOCE.ExecuteReader();
                while (dr123_ACC_LOCE.Read())
                {


                    if (dr123_ACC_LOCE["Acc_total_fin"] is DBNull)
                    {
                        Amt_BalE = 0;
                    }
                    else
                    {
                        Amt_BalE = Convert.ToDecimal(dr123_ACC_LOCE["Acc_total_fin"]);
                    }



                }
                dr123_ACC_LOCE.Close();

                //if (Amt_BalE != 0)
                //{


                TableCell tc41E = new TableCell();
                // string popstr = a_frmdt + "~" + a_todt;
                string popstr = a_frmdt + "~" + a_todt + "~" + mAcctTransTable + "~" + Str_all_lococde_arrE[Acc_l_iE] + "~" + String_loccode_ACC_EXP[AccE_i];
                tc41E.Text = "<a href=\"JavaScript:OpenPopupWindow1('" + popstr + "')\"><u>" + Convert.ToString(Amt_BalE) + " </u></a>";

                if (String_loccode_ACC_EXP[AccE_i] == "totexp")
                {
                    st_totexp = Convert.ToDouble(Amt_BalE);
                }
                if (String_loccode_ACC_EXP[AccE_i] == "totexp" || Str_all_lococde_arrE[Acc_l_iE] == "All" || Convert.ToString(Amt_BalE) == "0" || SubGrp_EXP == "Y")
                {
                    tc41E.Text = Convert.ToString(Amt_BalE);
                    if (SubGrp_EXP == "Y")
                    {
                        tc41E.CssClass = "bluefnt";
                        popstr = "branch=" + Str_all_lococde_arrE[Acc_l_iE] + "&strdlstSalesAmount=" + String_loccode_ACC_EXP[AccE_i] + "&dateFrom=" + a_frmdt + "&dateTo=" + a_todt + "&strdlstTranType=" + rpt_typ;
                        tc41E.Text = "<a href='../../accounts_mis/ledger/result.aspx?" + popstr + "'><u><font class='bluefnt'>" + Convert.ToString(Amt_BalE) + " </font></u></a>";

                        //popstr = Str_all_lococde_arrE[Acc_l_iE] + "~" + String_loccode_ACC_EXP[AccE_i] + "~" + String_loc_ACC_EXP[AccE_i] + "~" + a_frmdt + "~" + a_todt + "~" + rpt_typ;
                        //tc41E.Text = "<a href='./Voucherlist_trailbalance.aspx?" + popstr + "'><u><font class='bluefnt'>" + Convert.ToString(Amt_BalE) + " </font></u></a>";
                        tc41E.CssClass = "bluefnt";
                    }
                }
                tc41E.Text = Convert.ToString(Amt_BalE);
                tc41E.CssClass = "blackfnt";
                tc41E.HorizontalAlign = HorizontalAlign.Right;
                tr3E.Cells.Add(tc41E);
                tc41E.BackColor = System.Drawing.Color.White;
                tr3E.BackColor = System.Drawing.Color.White;


                //}
            }


            tblheadache.Rows.Add(tr3E);











        }



        TableRow tr3TB = new TableRow();
        TableCell tc4b = new TableCell();
        tr3TB.BackColor = System.Drawing.Color.White;

        tc4b.Text = "";
        tc4b.ColumnSpan = abc_colun + 1;
        tr3TB.Cells.Add(tc4b);
        tblheadache.Rows.Add(tr3TB);


        TableRow tr3T = new TableRow();
        TableCell tc4T = new TableCell();
        TableCell tc5T = new TableCell();
        tc5T.Text = "PROFIT/(LOSS) BEFORE TAXATION ";
        tc5T.Wrap = false;
        // tc4EH.CssClass = "blackboldfnt";
        // tr3EH.Cells.Add(tc4EH);
        // tc4EH.ColumnSpan = abc_colun + 1;
        tc5T.CssClass = "blackboldfnt";
        tr3T.Cells.Add(tc5T);

        string[] Str_all_lococde_arrT = Str_all_lococde_All.Split(',');

        for (int Acc_l_iT = 0; Acc_l_iT < Str_all_lococde_arrT.Length; Acc_l_iT++)
        {

            st_profit_loss = st_totinc - st_totexp;

            TableCell tc41T = new TableCell();

            String SQL_PLT = "exec Webx_profir_Loss_Net '" + finyearstart + "','" + a_todt + "','" + Str_all_lococde_arrT[Acc_l_iT] + "','totexpinc','N'";
            SqlCommand cmd3123_ACC_LOCT = new SqlCommand(SQL_PLT, conn);

            decimal Amt_BalT = 0, Amt_Bal_finT = 0, Amt_Bal_debt = 0, Amt_Bal_crt = 0;

            SqlDataReader dr123_ACC_LOCT = cmd3123_ACC_LOCT.ExecuteReader();
            while (dr123_ACC_LOCT.Read())
            {


                if (dr123_ACC_LOCT["Acc_total_fin"] is DBNull)
                {
                    Amt_BalT = 0;
                }
                else
                {
                    Amt_BalT = Convert.ToDecimal(dr123_ACC_LOCT["Acc_total_fin"]);
                }

                if (dr123_ACC_LOCT["Acc_total"] is DBNull)
                {
                    Amt_Bal_debt = 0;
                }
                else
                {
                    Amt_Bal_debt = Convert.ToDecimal(dr123_ACC_LOCT["Acc_total"]);
                }






            }
            dr123_ACC_LOCT.Close();
            if (st_profit_loss > 0)
            {
                tc41T.Text = Amt_BalT.ToString("F2");
            }
            else
            {
                tc41T.Text = "(" + Amt_BalT.ToString("F2") + ")";
            }
            tc41T.CssClass = "blackboldfnt";
            tr3T.Cells.Add(tc41T);
            tc41T.BackColor = System.Drawing.Color.White;
            tc41T.HorizontalAlign = HorizontalAlign.Right;
        }
       

        tr3T.BackColor = System.Drawing.Color.White;

        tblheadache.Rows.Add(tr3T);


        ///////////////////////MAIN FILLING FOR LOOOP




        /////////////////////////////
        //////////////////////////////////////////END IMESH CODING


        // DisplayDocFlow();

    }

    private void BankList()
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        String SQL_ACC_LIST = "select a.acccode,accdesc,acccategory,bkloccode from webx_acctinfo a where upper(acccategory) in ('BANK','CASH') order by acccategory desc";

        SqlCommand cmd12 = new SqlCommand(SQL_ACC_LIST, conn);

        SqlDataAdapter sqlDA12 = new SqlDataAdapter(cmd12);

        DataSet ds12 = new DataSet();

        sqlDA12.Fill(ds12);

        DataTable dt12 = new DataTable();


        dt12.Columns.Add("acccode", typeof(string));
        dt12.Columns.Add("accdesc", typeof(string));


        DataRow dr12;
        TimeSpan ts;
        String_accode = "";


        foreach (DataRow drRows in ds12.Tables[0].Rows)
        {



            dr12 = dt12.NewRow();
            dr12["acccode"] = drRows["acccode"].ToString();
            dr12["accdesc"] = drRows["accdesc"].ToString();

            //if (String_accode == "")
            //{
            //    String_accode = drRows["acccode"].ToString();
            //}
            //else
            //{
            //    String_accode = String_accode + '~'+drRows["acccode"].ToString();
            //}

            dt12.Rows.Add(dr12);

            //Repeater_BankName.DataSource = dt12;
            //Repeater_BankName.DataBind();



        }

        conn.Close();
    }


    protected void abcd(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label l1;
            l1 = (Label)e.Item.FindControl("lblOPNbal");
        }

    }

    private void BindGrid()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // conn.Open();
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
            BankCashCls = " and d.acccode ='" + ACCOunts + "'";
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
        string[] strArrDtFrom = fromdt_s.Split('/');


        fromdt_s = Convert.ToDateTime(strArrDtFrom[0] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");


        String SQL_top = "";//select BANK_OPNDEBIT=sum(case when acccategory='BANK' then debit else 0 end),BANK_OPNCredit=sum(case when acccategory='BANK' then credit else 0 end),CASH_OPNDEBIT=sum(case when acccategory='CASH' then debit else 0 end),CASH_OPNCredit=sum(case when acccategory='CASH' then credit else 0 end)  from " + AcctOpenTable + " M," + AcctTable + " D where m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between Convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strArrDtFromTo[1] + "',106)  ";

        if (strro == "")
        {
            SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' order by locName";
        }
        else
        {
            SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and loccode='" + strro + "' order by locName";
        }


        //dr1.Close();

        String SQL_ACC = "select m.acccode,oppaccount,oppacccode,d.groupcode,debit ,credit,chqno,voucherNo,Narration ,Transdate,Convert(varchar,Transdate,106) as Voucher_date,acccategory,CASH_Debit=(case when acccategory='CASH' then  debit else 0 end) ,CASH_Credit=(case when acccategory='CASH' then  credit else 0 end) ,Bank_Debit=(case when acccategory='BANK' then  debit else 0 end) ,Bank_Credit=(case when acccategory='BANK' then  credit else 0 end),Bank_name=(select top 1  accdesc from webx_acctinfo where acccode=m.acccode)  from " + AcctOpenTable + " M," + AcctTable + " D where Voucher_cancel='N' and (M.debit<>m.credit) and m.acccode=d.acccode " + BankCashCls + " and m.brcd='" + strro + "'  And convert(varchar,transdate,106)  between convert(datetime,'" + fromdt_s + "',106) and Convert(datetime,'" + strArrDtFromTo[1] + "',106) Order  by transdate,voucherno";
        SQL_ACC = SQL_top;
        SqlCommand cmd1 = new SqlCommand(SQL_ACC, conn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        String_accode = "";
        String SQL_ACC_ABCD = "select a.acccode,accdesc,acccategory,bkloccode from webx_acctinfo a where upper(acccategory) in ('BANK','CASH') order by acccategory desc";
        SqlCommand cmd3123 = new SqlCommand(SQL_ACC_ABCD, conn);
        SqlDataReader dr123 = cmd3123.ExecuteReader();
        while (dr123.Read())
        {


            if (String_accode == "")
            {

                String_accode = Convert.ToString(dr123["acccode"]);
            }
            else
            {

                String_accode = String_accode + "~" + Convert.ToString(dr123["acccode"]);
            }
        }

        dr123.Close();
        int loopCounter = 1, Cl = 0, clospn = 0, i = 0;

        string[] Accoce_data_arr = String_accode.Split('~');
        Cl = Accoce_data_arr.Length;

        clospn = Cl + 1;
        dt.Columns.Add("RowCounter", typeof(string));
        dt.Columns.Add("locname", typeof(string));
        dt.Columns.Add("clospn", typeof(string));

        dt.Columns.Add("OPNBalnce", typeof(string));




        DataRow dr;

        TimeSpan ts;



        foreach (DataRow drRows in ds.Tables[0].Rows)
        {



            dr = dt.NewRow();
            dr["RowCounter"] = loopCounter++;
            dr["locname"] = drRows["locname"].ToString();
            dr["clospn"] = Convert.ToString(clospn);


            String loccd = drRows["loccode"].ToString();
            String loccd1 = "";

            String DATA_OPNBAL = "";
            String SQL_OPN_close = "";
            if (i < Cl)
            {
                for (i = 0; i < Cl; i++)
                {
                    SQL_OPN_close = "exec WEBX_ClosingBal '" + AcctOpenTable + "','" + mAcctTransTable + "','" + Accoce_data_arr[i] + "','31 Oct 07','" + loccd + "'";
                    Response.Write("<br> SQL_OPN_close : " + SQL_OPN_close);



                    SqlCommand cmd3122 = new SqlCommand(SQL_OPN_close, conn);
                    SqlDataReader dr122 = cmd3122.ExecuteReader();
                    while (dr122.Read())
                    {
                        if (loccd != loccd1)
                        {
                            if (DATA_OPNBAL == "")
                            {
                                DATA_OPNBAL = dr122["Debit"].ToString();
                            }
                            else
                            {
                                DATA_OPNBAL = DATA_OPNBAL + '^' + dr122["Debit"].ToString();
                            }

                        }


                    }
                    dr122.Close();


                }



            }
            string[] DATA_OPNBAL_ARR = DATA_OPNBAL.Split('^');

            int OPBal = DATA_OPNBAL_ARR.Length;

            DataTable OPNdt = new DataTable();
            DataRow OPNDR;

            OPNdt.Columns.Add("OPNBALance", typeof(string));

            for (int opn = 0; opn < OPBal; opn++)
            {
                OPNDR = OPNdt.NewRow();
                OPNDR["OPNBALance"] = DATA_OPNBAL_ARR[opn];


                OPNdt.Rows.Add(OPNDR);

                //rptOPNBAL.DataSource = OPNdt;
                //rptOPNBAL.DataBind();
            }




            loccd1 = drRows["loccode"].ToString();

            dr["OPNBalnce"] = DATA_OPNBAL;// Convert.ToString(clospn);


            i = 0;


            dt.Rows.Add(dr);
            //rptBillDetails.DataSource = dt;
            //rptBillDetails.DataBind();
        }





        conn1.Close();
        conn.Close();
    }
}
