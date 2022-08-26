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

    SqlConnection conn;
    double tot_cashdebit = 0, tot_cashcredit = 0, cashclosedebit = 0, cashclosecredit = 0, tot_bankdebit = 0, tot_bankcredit = 0, bankClosecredit = 0, bankClosedebit=0;
    public static string strDateRange,String_loccode,String_accode, ACCOunts, finyearstart,strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
            mAcctTransTable = "webx_acctrans_" + yearSuffix;
            AcctOpenTable = "webx_acctopening_" + yearSuffix;
            AcctTable = "webx_acctinfo";

            strDateRange = Request.QueryString["DOCDate"].ToString();
            //lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
            //lblro.Text = strro;
            ACCOunts = Request.QueryString["ACCOunts"].ToString();
           
            
        }
        //BindGrid();
        //BankList();
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

        string opntodt = "";

        if ((strArrDtFrom[0].ToString() + "/" + strArrDtFrom[1].ToString()) == "01/04")
        {
            opntodt = Convert.ToDateTime(strArrDtFrom[0] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        }
        else
        {
            opntodt = Convert.ToDateTime(strArrDtFrom[0] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[2]).AddDays(-1).ToString("dd MMM yy");
        }

        //////////////////////////////////NIMESH CODING


        string[] String_accode = new string[2000];
        string[] String_accdesc = new string[2000];
        string stracccode = "", straccdesc = "";

        String SQL_ACC_ABCD = "select a.acccode,accdesc,acccategory,bkloccode from webx_acctinfo a where upper(acccategory) in ('BANK','CASH') order by acccategory desc";

        conn.Open();
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
            SQL_top = "select top 10 loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' order by locName";
        }
        else
        {
            SQL_top = "select loccode,locname=(loccode+' : '+locname) from webx_location where activeFlag='Y' and loccode='" + strro + "' order by locName";
        }

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


        //for (int j = 0; j < String_loccode.Length; j++)
        //{
        //loccd = String_loccode[j];

        //for (int i = 0; i < opn; i++)
        //{
        //   string SQL_OPN_close = "exec WEBX_ClosingBal '" + AcctOpenTable + "','" + mAcctTransTable + "','" + stracccode_arr[i] + "','31 Oct 07','" + String_loccode[j] + "'";
        //   // Response.Write("<br> SQL_OPN_close : " + SQL_OPN_close);




        //    SqlCommand cmd3122 = new SqlCommand(SQL_OPN_close, conn);
        //    SqlDataReader dr122 = cmd3122.ExecuteReader();
        //    while (dr122.Read())
        //    {
        //        if (loccd != loccd1)
        //        {
        //            if (DATA_OPNBAL == "")
        //            {
        //                DATA_OPNBAL = dr122["Debit"].ToString();
        //                DATA_CLBAL = dr122["Credit"].ToString();
        //            }
        //            else
        //            {
        //                DATA_OPNBAL = DATA_OPNBAL + '^' + dr122["Debit"].ToString();
        //                DATA_CLBAL = DATA_CLBAL + '^' + dr122["Credit"].ToString();
        //            }

        //        }


        //    }

        //    dr122.Close();


        //} /// I LOOP

        //loccd1 = String_loccode[j];
        //} // j LOOP
        ////////////////





        TableRow tr = new TableRow();
        TableCell tc1 = new TableCell();
        TableCell tc2 = new TableCell();
        tc1.CssClass = "blackfnt";
        tc1.Text = "Sr.No.";
        tc2.Text = "Particulars";
        tr.CssClass = "bgbluegrey";
        tc2.CssClass = "blackfnt";
        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        for (int i = 0; i < stracccode_arr.Length; i++)
        {
            TableCell tc = new TableCell();
            tc.Text = String_accdesc[i];

            tr.Cells.Add(tc);
            tc.CssClass = "blackfnt";
        }

        tblheadache.Rows.Add(tr);



        ///////////////////////MAIN FILLING FOR LOOOP

        for (int i = 0; i < String_loc.Length; i++)
        {

            string DATA_OPNBAL = "", DATA_CLBAL = "";
            string loccd = "", loccd1 = "";

            for (int k = 0; k < 2; k++)
            {
                loccd = String_loccode[i];

                for (int ik = 0; ik < opn; ik++)
                {
                    if (k == 0)
                    {

                        string SQL_OPN_close = "exec WEBX_ClosingBal '" + AcctOpenTable + "','" + mAcctTransTable + "','" + stracccode_arr[ik] + "','" + opntodt + "','" + loccd + "'";
                        // Response.Write("<br> SQL_OPN_close : " + SQL_OPN_close);
                        //

                        SqlCommand cmd3122 = new SqlCommand(SQL_OPN_close, conn);
                        SqlDataReader dr122 = cmd3122.ExecuteReader();
                        while (dr122.Read())
                        {


                            double opendebit = 0, opencredit = 0;
                            ReturnCloseBalBC = "";
                            opendebit = Convert.ToDouble(dr122["Debit"]);
                            opencredit = Convert.ToDouble(dr122["Credit"]);

                            if (opendebit >= opencredit)
                            {
                                opendebit = opendebit - opencredit;
                                opencredit = 0;
                                if (opendebit != 0)
                                {
                                    ReturnCloseBalBC = Convert.ToString(opendebit) + " DR";

                                }
                                else
                                {
                                    ReturnCloseBalBC = "0.00";
                                }

                            }
                            else
                            {
                                opencredit = opencredit - opendebit;
                                opendebit = 0;

                                if (opencredit != 0)
                                {
                                    ReturnCloseBalBC = Convert.ToString(opencredit) + " CR";
                                }
                                else
                                {
                                    ReturnCloseBalBC = "0.00";
                                }


                            }





                            //if (loccd != loccd1)
                            //{
                            //    if (DATA_OPNBAL == "")
                            //    {
                            //        DATA_OPNBAL = ReturnCloseBalBC;// dr122["Debit"].ToString();
                            //       // DATA_CLBAL = ReturnCloseBalBC;//dr122["Credit"].ToString();
                            //    }
                            //    else
                            //    {
                            //        DATA_OPNBAL = DATA_OPNBAL + '^' + ReturnCloseBalBC;/// dr122["Debit"].ToString();
                            //       // DATA_CLBAL = DATA_CLBAL + '^' + ReturnCloseBalBC;//dr122["Credit"].ToString();
                            //    }

                            //}


                        }

                        dr122.Close();
                    }
                    else
                    {
                        string SQL_OPN_close = "exec WEBX_ClosingBal '" + AcctOpenTable + "','" + mAcctTransTable + "','" + stracccode_arr[ik] + "','" + fromdt_s + "','" + loccd + "'";
                        //Response.Write("<br> SQL_OPN_close : " + SQL_OPN_close);

                        SqlCommand cmd3122 = new SqlCommand(SQL_OPN_close, conn);
                        SqlDataReader dr122 = cmd3122.ExecuteReader();
                        while (dr122.Read())
                        {


                            double opendebit = 0, opencredit = 0;
                            ReturnCloseBalBC = "";
                            opendebit = Convert.ToDouble(dr122["Debit"]);
                            opencredit = Convert.ToDouble(dr122["Credit"]);

                            if (opendebit >= opencredit)
                            {
                                opendebit = opendebit - opencredit;
                                opencredit = 0;
                                if (opendebit != 0)
                                {
                                    ReturnCloseBalBC = Convert.ToString(opendebit) + " DR";

                                }
                                else
                                {
                                    ReturnCloseBalBC = "0.00";
                                }

                            }
                            else
                            {
                                opencredit = opencredit - opendebit;
                                opendebit = 0;

                                if (opencredit != 0)
                                {
                                    ReturnCloseBalBC = Convert.ToString(opencredit) + " CR";
                                }
                                else
                                {
                                    ReturnCloseBalBC = "0.00";
                                }


                            }







                        }

                        dr122.Close();
                    }

                    if (loccd != loccd1)
                    {
                        if (DATA_OPNBAL == "")
                        {
                            if (k == 0)
                            {
                                DATA_OPNBAL = ReturnCloseBalBC;// dr122["Debit"].ToString();
                            }
                            else
                            {
                                DATA_CLBAL = ReturnCloseBalBC;//dr122["Credit"].ToString();
                            }
                        }
                        else
                        {
                            if (k == 0)
                            {
                                DATA_OPNBAL = DATA_OPNBAL + '^' + ReturnCloseBalBC;/// dr122["Debit"].ToString();
                            }
                            else
                            {///
                                DATA_CLBAL = DATA_CLBAL + '^' + ReturnCloseBalBC;//dr122["Credit"].ToString();
                            }
                        }

                    }



                } /// I LOOP
            }
            loccd1 = String_loccode[i];

            string[] debit_arr = DATA_OPNBAL.Split('^');
            string[] Credit_arr = DATA_CLBAL.Substring(1, (DATA_CLBAL.Length) - 1).Split('^');

            tr = new TableRow();

            tc1 = new TableCell();
            tc1.Text = Convert.ToString(i + 1);
            tc2 = new TableCell();
            tc2.Text = String_loc[i];
            tc2.ColumnSpan = stracccode_arr.Length + 1;
            tr.BackColor = System.Drawing.Color.White;
            tr.CssClass = "blackfnt";


            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);

            tblheadache.Rows.Add(tr);

            TableRow trdeb = new TableRow();
            tc2 = new TableCell();
            tc1 = new TableCell();
            tc1.Text = "";
            tc2.Text = "Opening Balance";
            trdeb.CssClass = "blackfnt";
            trdeb.Cells.Add(tc1);
            trdeb.Cells.Add(tc2);
            trdeb.BackColor = System.Drawing.Color.White;
            for (int k = 0; k < debit_arr.Length; k++)
            {
                TableCell tcdebit = new TableCell();

                tcdebit.Text = debit_arr[k].ToString();
                trdeb.Cells.Add(tcdebit);
            }
            tblheadache.Rows.Add(trdeb);


            TableRow trCr = new TableRow();
            tc2 = new TableCell();
            tc1 = new TableCell();
            tc1.Text = "";
            tc2.Text = "Closing  Balance";
            trCr.CssClass = "blackfnt";
            trCr.Cells.Add(tc1);
            trCr.Cells.Add(tc2);
            trCr.BackColor = System.Drawing.Color.White;
            for (int k = 0; k < Credit_arr.Length; k++)
            {
                TableCell tccredit = new TableCell();

                tccredit.Text = Credit_arr[k].ToString();
                trCr.Cells.Add(tccredit);
            }
            tblheadache.Rows.Add(trCr);


        }



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
            l1=(Label)e.Item.FindControl("lblOPNbal");
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
        DateTime fromdt =Convert.ToDateTime(strArrDtFromTo[0]);
        DateTime fromdt1 =Convert.ToDateTime(finyearstart);
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
        int loopCounter = 1, Cl = 0,clospn=0, i = 0;

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
            String loccd1="";

            String DATA_OPNBAL = "";
            String SQL_OPN_close="";
            if (i < Cl)
            {
                for ( i = 0; i < Cl; i++)
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
       
        

       
        
        
        conn.Close();
    }

}
