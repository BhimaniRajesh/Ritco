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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
public partial class GUI_UNI_MIS_Monthly_Sales_Result : System.Web.UI.Page
{
    public static string RO, LO, month1, strCan = "N", Rmode, Subtyp, Rtyp, PaybasList, Trnlist, ColumnList, Ryear;
    public static string FirstColumnTitle = "", dkt_call = "", callas = "", callas1 = "", callas2 = "";
    public static string FlagAll = "", TYP_YEAR="", Aresize = "", FlagP01 = "", FlagP02 = "", FlagP03 = "", FlagP04 = "", FlagP06 = "", FlagP07 = "", FlagP08 = "", FlagP09 = "", FlagT1 = "", FlagT2 = "", FlagT3 = "", FlagT4 = "";
    int a = 0;
    double totdkts = 0, totamt = 0, totwt = 0, totyield = 0, div = 0;
    double totdkts_p01 = 0, totamt_p01 = 0, totwt_p01 = 0, totyield_p01 = 0;
    double totdkts_p02 = 0, totamt_p02 = 0, totwt_p02 = 0, totyield_p02 = 0;
    double totdkts_p03 = 0, totamt_p03 = 0, totwt_p03 = 0, totyield_p03 = 0;
    double totdkts_p04 = 0, totamt_p04 = 0, totwt_p04 = 0, totyield_p04 = 0;
    double totdkts_p06 = 0, totamt_p06 = 0, totwt_p06 = 0, totyield_p06 = 0;
    double totdkts_p07 = 0, totamt_p07 = 0, totwt_p07 = 0, totyield_p07 = 0;
    double totdkts_p08 = 0, totamt_p08 = 0, totwt_p08 = 0, totyield_p08 = 0;
    double totdkts_p09 = 0, totamt_p09 = 0, totwt_p09 = 0, totyield_p09 = 0;
    double totdkts_CAN = 0, totamt_CAN = 0, totwt_CAN = 0, totyield_CAN = 0;

    double RO_totdkts = 0, RO_totamt = 0, RO_totwt = 0, RO_totyield = 0;
    double RO_totdkts_p01 = 0, RO_totamt_p01 = 0, RO_totwt_p01 = 0, RO_totyield_p01 = 0;
    double RO_totdkts_p02 = 0, RO_totamt_p02 = 0, RO_totwt_p02 = 0, RO_totyield_p02 = 0;
    double RO_totdkts_p03 = 0, RO_totamt_p03 = 0, RO_totwt_p03 = 0, RO_totyield_p03 = 0;
    double RO_totdkts_p04 = 0, RO_totamt_p04 = 0, RO_totwt_p04 = 0, RO_totyield_p04 = 0;
    double RO_totdkts_p06 = 0, RO_totamt_p06 = 0, RO_totwt_p06 = 0, RO_totyield_p06 = 0;
    double RO_totdkts_p07 = 0, RO_totamt_p07 = 0, RO_totwt_p07 = 0, RO_totyield_p07 = 0;
    double RO_totdkts_p08 = 0, RO_totamt_p08 = 0, RO_totwt_p08 = 0, RO_totyield_p08 = 0;
    double RO_totdkts_p09 = 0, RO_totamt_p09 = 0, RO_totwt_p09 = 0, RO_totyield_p09 = 0;
    double RO_totdkts_CAN = 0, RO_totamt_CAN = 0, RO_totwt_CAN = 0, RO_totyield_CAN = 0;


    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    public void BindGrid()
    {
        string BUSTYP = Request.QueryString["BUSTYP"].ToString();
        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        TYP_YEAR = Request.QueryString["TYP_YEAR"].ToString();
        Rmode = Request.QueryString["Rmode"].ToString();
        Subtyp = Request.QueryString["Subtyp"].ToString();
        Rtyp = Request.QueryString["Rtyp"].ToString();
        PaybasList = Request.QueryString["PaybasList"].ToString();
        string DateType = Request.QueryString.Get("report_type_st");
        string cust8888 = Request.QueryString.Get("cust8888");
        // string strQSMRDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        string strrightnow = "", strrightnow1 = "", dtFrom = "", dtTo = "";
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (Rmode == "10")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (Rmode == "9")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (Rmode == "8")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (Rmode == "8" || Rmode == "9" || Rmode == "10")
        {
            string[] strArrDtFrom = strrightnow.Split('/');
            string[] strArrDtTo = strrightnow1.Split('/');
            dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("ddMMM yy");
            dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        }


        if(Rmode=="1")
        {
            LBLDATE.Text = "Current Month";
        }
        else if (Rmode == "2")
        {
            LBLDATE.Text = "Previous  Month";
        }
        else if (Rmode == "3")
        {
            LBLDATE.Text = "First Quarter - (Jan - Mar)";
        }
        else if (Rmode == "4")
        {
            LBLDATE.Text = "Sencond Quarter - (Apr - Jun)";
        }
        else if (Rmode == "5")
        {
            LBLDATE.Text = "Third Quarter - (Jul - Sep)";
        }
        else if (Rmode == "6")
        {
            LBLDATE.Text = "Fourth Quarter - (Oct - Dec)";
        }
        else if (Rmode == "7")
        {
            LBLDATE.Text = "Year ";
        }
        else if (Rmode == "8")
        {
            LBLDATE.Text = "Today";
        }
        else if (Rmode == "9")
        {
            LBLDATE.Text = "Last Week (including today)";
        }
        else if (Rmode == "12")
        {
            LBLDATE.Text = "Month Wise (Horizontal)";
        }
        else if (Rmode == "11")
        {
            LBLDATE.Text = "Month Wise (Vertical)";
        }
        else if (Rmode == "10")
        {
            LBLDATE.Text = dtFrom+" - "+dtTo;
        }


        if (Subtyp == "1")
        {
            lblSubtyp.Text = "Paybas Wise";
        }
        else if (Subtyp == "2")
        {
            lblSubtyp.Text = "Mode Wise";
        }


        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;

        lblTYpe.Text = "";
        if (Rtyp == "1")
        {
            lblTYpe.Text = "Location Wise";
        }
        else if (Rtyp == "2")
        {
            lblTYpe.Text = "Customer  Wise";
        }
        else if (Rtyp == "3")
        {
            lblTYpe.Text = "Customer Group Wise";
        }
        else if (Rtyp == "4")
        {
            lblTYpe.Text = "Entry Person Wise";
        }
        else if (Rtyp == "5")
        {
            lblTYpe.Text = "Lost Customer Wise";
        }
        else if (Rtyp == "6")
        {
            lblTYpe.Text = "Top 20 Customer ";
        }
        else if (Rtyp == "7")
        {
            lblTYpe.Text = "Employee/BA Wise";
        }
        else if (Rtyp == "8")
        {
            lblTYpe.Text = "Location/Customer Wise";
        }


        Trnlist = Request.QueryString["Trnlist"].ToString();
        ColumnList = Request.QueryString["ColumnList"].ToString();
        Ryear = Request.QueryString["Ryear"].ToString();
        dkt_call = Session["DocketCalledAs"].ToString();

        if (Rtyp == "1" )
        {
            FirstColumnTitle = "Location";
        }
        else if (Rtyp == "2" || Rtyp == "5" || Rtyp == "6")
        {
            FirstColumnTitle = "Customer";
        }
        else if (Rtyp == "3")
        {
            FirstColumnTitle = "Customer Group";
        }
        else if (Rtyp == "4" || Rtyp == "7")
        {
            FirstColumnTitle = "Employee";
        }


        if (PaybasList.IndexOf("All") != -1 || Trnlist.IndexOf("All") != -1)
            FlagAll = "Y";
        else
            FlagAll = "N";


        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        //dgDocket.Visible = true;
        string[] PaybasListArr = PaybasList.Split(',');
        string[] TrnlistArr = Trnlist.Split(',');

        int SencodrowL = 0;

        if (Subtyp == "1")
        {
            SencodrowL = PaybasListArr.Length;
            callas = "Pay";
            callas1 = "P";
        }
        else if (Subtyp == "2")
        {
            SencodrowL = TrnlistArr.Length;
            callas = "TRN";
            callas1 = "TRN_";
        }
       

        int monthid = 0;
        if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
        {
            callas2 = "M";
            monthid = 1;
        }
        else
        {
            callas2 = "";
        }

        if (Rmode == "11")
        {
            callas = "M";
            callas2 = "";
            callas1 = "";
            monthid = 1;
            SencodrowL = 2;
        }

        //string sql_grid = "exec webx_Monthly_sales_ver3 '" + Rmode + "','" + RO + "','" + LO + "','" + PaybasList + "','" + Trnlist + "','" + ColumnList + "','" + Subtyp + "','" + Rtyp + "','" + Ryear + "','" + dtFrom + "','" + dtTo + "','" + cust8888 + "'";
        string sql_grid = "exec webx_Monthly_sales_ver4 '" + Rmode + "','" + RO + "','" + LO + "','" + PaybasList + "','" + Trnlist + "','" + ColumnList + "','" + Subtyp + "','" + Rtyp + "','" + Ryear + "','" + dtFrom + "','" + dtTo + "','" + cust8888 + "','" + BUSTYP + "','" + TYP_YEAR + "'";
         //Response.Write("abcd : " + sql_grid);
        SqlCommand cmd = new SqlCommand(sql_grid, Conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        int Nrows = ds.Tables[0].Rows.Count;
        SqlDataReader dr = cmd.ExecuteReader();


        ///totdkts_CAN_M[0 ----means first cancel
        ///totdkts_CAN[0,0,0 --- Total no of dockets
        ///totdkts_CAN[0,0,1 --- Total no of Amt
        ///totdkts_CAN[0,0,2 --- Total no of Wt
        ///totdkts_CAN[0,0,3 --- Total no of Yield



        string typ_name = "";

        int loopint = 0, rptcol = 0;

        if (Rmode == "1" || Rmode == "2" || Rmode == "7" || Rmode == "8" || Rmode == "9" || Rmode == "10" || Rmode == "12")
        {
            loopint = 1;
            rptcol = SencodrowL;
        }
        else if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6" )
        {
            loopint = 3;
            rptcol = ((SencodrowL - 1) * loopint) + 1;
        }
        else if ( Rmode == "11")
        {
            loopint = 12;
            rptcol = 13;
        }


        double[, ,] totdkts_CAN_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P01_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P02_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P03_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P04_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P09_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P06_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P07_M = new double[loopint, Nrows, 4];
        double[, ,] totdkts_P08_M = new double[loopint, Nrows, 4];
        string ftqt = "04/04/" + Ryear;
        //if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
        //{
        int stmonth = 0;
        TableRow tr1a = new TableRow();
        TableCell tr1atc1 = new TableCell();
        TableCell tr1atc2 = new TableCell();
        TableCell tr1atc4 = new TableCell();


        tr1atc1.Text = "Sr No.";
        tr1atc1.CssClass = "blackboldfnt";
        tr1atc1.Wrap = false;


        tr1atc1.RowSpan = 3;

        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc1);

        tr1atc2.Text = FirstColumnTitle;
        tr1atc2.CssClass = "blackboldfnt";
        tr1atc2.Wrap = false;


        tr1atc2.RowSpan = 3;

        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc2);

        if (FlagAll == "Y")
        {
            tr1atc4.Text = "Total";
            tr1atc4.CssClass = "blackboldfnt";
            tr1atc4.Wrap = false;
            tr1a.CssClass = "bgbluegrey";
            tr1atc4.ColumnSpan = 4;
           
                tr1atc4.RowSpan = 2;
           
            tr1a.Cells.Add(tr1atc4);
        }

        if (SencodrowL > 1)
        {

           // SencodrowL = 1;
            for (int lp1 = 0; lp1 < loopint; lp1++)
            {
                if (Rmode == "3" || Rmode == "11")
                {
                    if (TYP_YEAR == "1")                    
                        stmonth = 1 + lp1;                   
                    else
                        stmonth = 4 + lp1;

                    if (Rmode == "11")
                    {
                        if(stmonth>12)
                        stmonth = stmonth -  12;
                    }
                }
                else if (Rmode == "4")
                {
                    stmonth = 4 + lp1;
                    if (TYP_YEAR == "1")
                        stmonth = 4 + lp1;
                    else
                        stmonth = 7 + lp1;
                }
                else if (Rmode == "5")
                {
                    stmonth = 7 + lp1;
                    if (TYP_YEAR == "1")
                        stmonth = 7 + lp1;
                    else
                        stmonth = 10 + lp1;
                }
                else if (Rmode == "6")
                {
                    stmonth = 10 + lp1;
                    if (TYP_YEAR == "1")
                        stmonth = 10 + lp1;
                    else
                        stmonth = 1 + lp1;
                }
                else if (Rmode == "1")
                {
                    stmonth = 10 + lp1;

                }
               

                if (Rmode == "6")
                {
                    ftqt = stmonth.ToString() + "/" + stmonth.ToString() + "/" + Ryear;
                }
                else if (Rmode == "1")
                {
                    ftqt = System.DateTime.Today.ToString("MMM yy");
                }
                else if (Rmode == "2")
                {
                    ftqt = System.DateTime.Today.AddMonths(-1).ToString("MMM yy");
                }
                else
                {
                    if (TYP_YEAR == "2")
                    {
                        if (Rmode == "3" || Rmode == "11")
                            Ryear = Ryear.ToString().Substring(0, 2);
                        
                    }
                    if (stmonth.ToString().Length == 1)
                    {
                        ftqt = "0" + stmonth.ToString() + "/0" + stmonth.ToString() + "/" + Ryear;
                    }
                    else
                    {
                        ftqt = stmonth.ToString() + "/" + stmonth.ToString() + "/" + Ryear;
                    }

                    if (Rmode == "11")
                    {
                        if (stmonth == 1 || stmonth == 2 || stmonth == 3)
                        {
                            string st_TYP_YEAR = "";
                            if (TYP_YEAR == "2")
                            {
                                st_TYP_YEAR = Convert.ToString(Convert.ToInt32(Ryear.ToString().Substring(0, 2)) + 1);
                                if (st_TYP_YEAR.Length == 1)
                                    st_TYP_YEAR = "0" + st_TYP_YEAR;
                            }
                            else
                            {
                                st_TYP_YEAR = Convert.ToString(Convert.ToInt32(Ryear.ToString().Substring(2, 2)) );
                                if (st_TYP_YEAR.Length == 1)
                                    st_TYP_YEAR = "0" + st_TYP_YEAR;
                            }

                            if (stmonth.ToString().Length == 1)
                            {
                                ftqt = "0" + stmonth.ToString() + "/0" + stmonth.ToString() + "/" + st_TYP_YEAR;
                            }
                            else
                            {
                                ftqt = stmonth.ToString() + "/" + stmonth.ToString() + "/" + st_TYP_YEAR;
                            }
                        }
                    }
                }


                TableCell tr1atc3 = new TableCell();
                //tr1atc3.Text = Convert.ToDateTime(ftqt).ToString("MMM yy");
                if (Rmode == "1")
                {
                    tr1atc3.Text = "[" + System.DateTime.Today.ToString("MMM yy") + "]";
                }
                else if (Rmode == "2")
                {
                    tr1atc3.Text = "[" + System.DateTime.Today.AddMonths(-1).ToString("MMM yy") + "]";
                }
                else if (Rmode == "8" || Rmode == "9" || Rmode == "10")
                {
                    tr1atc3.Text = "[" + dtFrom + "-" + dtTo + "]";
                }
                else if (Rmode == "7" || Rmode == "12")
                {
                    string dt1 = "01/01/" + Ryear;
                    string dt2 = "12/12/" + Ryear;

                    if (TYP_YEAR == "2")
                    {
                        string st_TYP_YEAR="";
                        st_TYP_YEAR = Convert.ToString(Convert.ToInt32(Ryear.ToString().Substring(0, 2))+ 1);
                        if (st_TYP_YEAR.Length == 1)
                            st_TYP_YEAR = "0" + st_TYP_YEAR;
                        dt1 = "04/04/" + Ryear.ToString().Substring(0, 2);
                        dt2 = "03/03/" + st_TYP_YEAR;
                    }

                    tr1atc3.Text = "[" + Convert.ToDateTime(dt1).ToString("MMM yy") + " - " + Convert.ToDateTime(dt2).ToString("MMM yy") + "]";
                }
                else
                {
                    tr1atc3.Text = "[" + Convert.ToDateTime(ftqt).ToString("MMM yy") + "]";
                }

                
                tr1atc3.CssClass = "blackboldfnt";
                tr1atc3.Wrap = false;
                tr1atc3.ColumnSpan = (SencodrowL - 1) * 4;
                if (Rmode == "11")
                {
                    tr1atc3.RowSpan = 2;
                    tr1atc3.ColumnSpan = 4;
                }
                //if (Rmode == "1" || Rmode == "2")
                //{
                //    tr1atc3.ColumnSpan =  4;
                //}
                tr1a.CssClass = "bgbluegrey";
                tr1a.Cells.Add(tr1atc3);


            }


        }
        tr1a.BorderWidth = 1;
        tr1a.BorderColor = System.Drawing.Color.Gray;
        tr1a.HorizontalAlign = HorizontalAlign.Center;
        TBL_MonthlySales.Rows.Add(tr1a);
        //}
        TableRow tr1 = new TableRow();
        TableCell tr1tc1 = new TableCell();
        TableCell tr1tc2 = new TableCell();
        TableCell tr1tc3 = new TableCell();
        TableCell tr1tc4 = new TableCell();


        for (int lp2 = 0; lp2 < loopint; lp2++)
        {

            for (int rl = 0; rl < SencodrowL; rl++)
            {
                //if (FlagP01 == "Y")
                //{
                

                string typnoh = "", abch = "N";
                if (Rmode != "11")
                {
                    if (Subtyp == "1")
                    {
                        if (PaybasListArr[rl] == "All")
                        {
                            abch = "N";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P01")
                        {
                            typnoh = "1";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P02")
                        {
                            typnoh = "2";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P03")
                        {
                            typnoh = "3";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P04")
                        {
                            typnoh = "4";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P06")
                        {
                            typnoh = "6";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P07")
                        {
                            typnoh = "7";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P08")
                        {
                            typnoh = "8";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "P09")
                        {
                            typnoh = "9";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (PaybasListArr[rl] == "CAN")
                        {
                            typnoh = "C";
                            abch = "Y";
                            strCan = "Y";
                        }
                    }
                    else if (Subtyp == "2")
                    {
                        if (TrnlistArr[rl] == "All")
                        {
                            abch = "N";
                            strCan = "N";
                        }
                        else if (TrnlistArr[rl] == "1")
                        {
                            typnoh = "1";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (TrnlistArr[rl] == "2")
                        {
                            typnoh = "2";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (TrnlistArr[rl] == "3")
                        {
                            typnoh = "3";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (TrnlistArr[rl] == "4")
                        {
                            typnoh = "4";
                            abch = "Y";
                            strCan = "N";
                        }
                        else if (TrnlistArr[rl] == "CAN")
                        {
                            typnoh = "4";
                            abch = "Y";
                            strCan = "Y";
                        }
                    }
                }
                else
                {
                    typnoh = rl.ToString();
                    typnoh = Convert.ToString(Convert.ToInt32(typnoh) + 1);
                    //abch = "Y";
                    strCan = "N";
                }

                if (abch == "Y")
                {

                    TableCell tr1tc5 = new TableCell();
                    if (Subtyp == "1")
                    {

                        tr1tc5.Text = Getpaybas("p0" + typnoh + "");
                        if (strCan == "Y")
                        {
                            tr1tc5.Text = "Cancelled";
                        }
                        tr1tc5.CssClass = "blackboldfnt";
                        tr1tc5.Wrap = false;
                        tr1.CssClass = "bgbluegrey";
                        tr1tc5.ColumnSpan = 4;
                        tr1.Cells.Add(tr1tc5);
                    }
                    else if (Subtyp == "2")
                    {

                        tr1tc5.Text = Gettrnmod("" + typnoh + "");
                        if (strCan == "Y")
                        {
                            tr1tc5.Text = "Cancelled";
                        }
                        tr1tc5.CssClass = "blackboldfnt";
                        tr1tc5.Wrap = false;
                        tr1.CssClass = "bgbluegrey";
                        tr1tc5.ColumnSpan = 4;
                        tr1.Cells.Add(tr1tc5);
                    }
                }
            }
        }

        tr1.BorderWidth = 1;
        tr1.BorderColor = System.Drawing.Color.Gray;
            tr1.HorizontalAlign = HorizontalAlign.Center;
            TBL_MonthlySales.Rows.Add(tr1);
        



        TableRow tr11 = new TableRow();
        for (int rl = 0; rl < rptcol; rl++)
        {
            TableCell tr11tc1 = new TableCell();
            TableCell tr11tc2 = new TableCell();
            TableCell tr11tc3 = new TableCell();
            TableCell tr11tc4 = new TableCell();

            tr11tc1.Text = "No. Of " + dkt_call;
            tr11tc1.CssClass = "blackfnt";
            tr11tc1.Wrap = false;
            tr11.CssClass = "bgbluegrey";
            tr11.Cells.Add(tr11tc1);

            tr11tc2.Text = "Amount";
            tr11tc2.CssClass = "blackfnt";
            tr11tc2.Wrap = false;
            tr11.CssClass = "bgbluegrey";
            tr11.Cells.Add(tr11tc2);

            tr11tc3.Text = "Chrg Wt";
            tr11tc3.CssClass = "blackfnt";
            tr11tc3.Wrap = false;
            tr11.CssClass = "bgbluegrey";
            tr11.Cells.Add(tr11tc3);

            tr11tc4.Text = "Yield";
            tr11tc4.CssClass = "blackfnt";
            tr11tc4.Wrap = false;
            tr1.CssClass = "bgbluegrey";
            tr11.Cells.Add(tr11tc4);


        }
        tr11.BorderWidth = 1;
        tr11.BorderColor = System.Drawing.Color.Gray;
        tr11.HorizontalAlign = HorizontalAlign.Center;
        TBL_MonthlySales.Rows.Add(tr11);
        int srno = 0;
        string Currmonth = "", PrevMonth = "";
        srno = 1;
        string CRo = "", PrevRO = "";
        int RCnt = 1;
        int RCnti = 1;
        int RCntJ = 1;
        while (dr.Read())
        {

            
            

            typ_name = dr["cd"].ToString() + " : " + dr["nm"].ToString();

            if (Rtyp == "2")
            {
                typ_name = dr["cd"].ToString() + " : " + dr["nm"].ToString() + " - <font class=bluefnt>" + dr["custloc"].ToString() + "</font>";
            }


            if (Rtyp == "1" || Rtyp == "7" || Rtyp == "8")
            {
                CRo = dr["ro"].ToString();
                if (CRo != PrevRO && PrevRO != "")
                {

                    if (RCnti == 1)
                    {
                        RCntJ = 0;
                    }
                    else
                    {
                        RCntJ = RCnt - srno;
                    }
                    

                    TableRow tr2a = new TableRow();

                    TableCell tr2atc1 = new TableCell();
                    TableCell tr2atc3 = new TableCell();
                    TableCell tr2atc4 = new TableCell();
                    TableCell tr2atc5 = new TableCell();
                    TableCell tr2atc6 = new TableCell();

                    tr2atc1.Text = Getlocation("" + PrevRO + "");
                    if (Rtyp == "7")
                    {
                        tr2atc1.Text = PrevRO;
                    }

                    tr2atc1.Wrap = false;

                    tr2atc1.ColumnSpan = 2;
                    tr2atc1.HorizontalAlign = HorizontalAlign.Center;
                    tr2a.Cells.Add(tr2atc1);

                    if (FlagAll == "Y")
                    {

                        tr2atc3.Text = RO_totdkts.ToString();
                        tr2atc3.Wrap = false;
                        tr2atc3.HorizontalAlign = HorizontalAlign.Center;
                        tr2a.Cells.Add(tr2atc3);

                        tr2atc4.Text = RO_totamt.ToString("F2");                        
                        tr2atc4.Wrap = false;
                        tr2atc4.HorizontalAlign = HorizontalAlign.Right;
                        tr2a.Cells.Add(tr2atc4);

                        tr2atc5.Text = RO_totwt.ToString("F2");
                        tr2atc5.Wrap = false;
                        tr2atc5.HorizontalAlign = HorizontalAlign.Right;
                        tr2a.Cells.Add(tr2atc5);

                        if (Convert.ToDouble(RO_totwt) > 0)
                        {
                            tr2atc6.Text = (Convert.ToDouble(RO_totyield) / Convert.ToDouble(RO_totwt)).ToString("F2");
                        }
                        else
                        {
                            tr2atc6.Text = "0.0";
                        }

                        tr2atc6.Wrap = false;
                        tr2atc6.HorizontalAlign = HorizontalAlign.Right;

                        tr2a.Cells.Add(tr2atc6);

                        // totdkts =totdkts+Convert.ToInt16( dr["" + callas + "_All_dkt"].ToString());
                    }

                    month1 = "";
                    for (int lp3 = 0; lp3 < loopint; lp3++)
                    {
                        a = (monthid + lp3);
                        if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6" || Rmode == "11")
                        {
                            
                            month1 = a.ToString() + "_";
                            if (Rmode == "11")
                            {
                                month1 = "_";
                            }
                        }
                        Aresize = a.ToString() + "_";
                        for (int rl = 0; rl < SencodrowL; rl++)
                        {
                            //if (FlagP01 == "Y")
                            //{
                            double RO_paytotdkt = 0, RO_paytotAmt = 0, RO_paytotWT = 0, RO_paytotYld = 0;
                            string typno = "", abc = "N";
                            if (Rmode != "11")
                            {
                                if (Subtyp == "1")
                                {
                                    RO_paytotdkt = 0;
                                    RO_paytotAmt = 0;
                                    RO_paytotWT = 0;
                                    RO_totyield = 0;

                                    if (PaybasListArr[rl] == "All")
                                    {

                                    }
                                    else if (PaybasListArr[rl] == "P01")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P01_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P01_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P01_M[lp3, i, 2];
                                            RO_totyield += totdkts_P01_M[lp3, i, 3];
                                        }

                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P02")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P02_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P02_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P02_M[lp3, i, 2];
                                            RO_totyield += totdkts_P02_M[lp3, i, 3];
                                        }


                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P03")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P03_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P03_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P03_M[lp3, i, 2];
                                            RO_totyield += totdkts_P03_M[lp3, i, 3];
                                        }


                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P04")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P04_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P04_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P04_M[lp3, i, 2];
                                            RO_totyield += totdkts_P04_M[lp3, i, 3];
                                        }


                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P06")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P06_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P06_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P06_M[lp3, i, 2];
                                            RO_totyield += totdkts_P06_M[lp3, i, 3];
                                        }

                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P07")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P07_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P07_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P07_M[lp3, i, 2];
                                            RO_totyield += totdkts_P07_M[lp3, i, 3];
                                        }


                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P08")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P08_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P08_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P08_M[lp3, i, 2];
                                            RO_totyield += totdkts_P08_M[lp3, i, 3];
                                        }

                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "P09")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P09_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P09_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P09_M[lp3, i, 2];
                                            RO_totyield += totdkts_P09_M[lp3, i, 3];
                                        }

                                        abc = "Y";
                                    }
                                    else if (PaybasListArr[rl] == "CAN")
                                    {
                                        //RO_paytotdkt = RO_totdkts_CAN;
                                        //RO_paytotAmt = RO_totamt_CAN;
                                        //RO_paytotWT = RO_totwt_CAN;

                                        abc = "Y";

                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_CAN_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_CAN_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_CAN_M[lp3, i, 2];
                                            RO_totyield += totdkts_CAN_M[lp3, i, 3];
                                        }

                                    }
                                    if (RO_paytotWT > 0)
                                    {
                                        RO_paytotYld = RO_totyield / RO_paytotWT;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }


                                }
                                else if (Subtyp == "2")
                                {
                                    if (TrnlistArr[rl] == "All")
                                    {
                                        abc = "N";
                                        RO_paytotdkt = RO_totdkts_p01;
                                        RO_paytotAmt = RO_totamt_p01;
                                        RO_paytotWT = RO_totwt_p01;
                                        if (totwt_p01 > 0)
                                        {
                                            RO_paytotYld = RO_totyield_p01 / RO_totwt_p01;
                                        }
                                        else
                                        {
                                            RO_paytotYld = 0;
                                        }
                                    }
                                    else if (TrnlistArr[rl] == "1")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P01_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P01_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P01_M[lp3, i, 2];
                                            RO_totyield += totdkts_P01_M[lp3, i, 3];
                                        }
                                        abc = "Y";
                                        abc = "Y";
                                    }
                                    else if (TrnlistArr[rl] == "2")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P02_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P02_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P02_M[lp3, i, 2];
                                            RO_totyield += totdkts_P02_M[lp3, i, 3];
                                        }
                                        abc = "Y";
                                        abc = "Y";
                                    }
                                    else if (TrnlistArr[rl] == "3")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P03_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P03_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P03_M[lp3, i, 2];
                                            RO_totyield += totdkts_P03_M[lp3, i, 3];
                                        }
                                        abc = "Y";
                                        abc = "Y";
                                        abc = "Y";
                                    }
                                    else if (TrnlistArr[rl] == "4")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_P04_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_P04_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_P04_M[lp3, i, 2];
                                            RO_totyield += totdkts_P04_M[lp3, i, 3];
                                        }
                                        abc = "Y";

                                        abc = "Y";
                                    }
                                    else if (TrnlistArr[rl] == "CAN")
                                    {
                                        for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                        {
                                            RO_paytotdkt += totdkts_CAN_M[lp3, i, 0];
                                            RO_paytotWT += totdkts_CAN_M[lp3, i, 1];
                                            RO_paytotAmt += totdkts_CAN_M[lp3, i, 2];
                                            RO_totyield += totdkts_CAN_M[lp3, i, 3];
                                        }
                                        abc = "Y";
                                    }
                                    if (RO_totwt_p04 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p04 / RO_totwt_p04;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                }
                            }
                            else
                            {
                                for (int i = RCntJ; i < srno - 1 + RCntJ; i++)
                                {
                                    RO_paytotdkt += totdkts_P01_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P01_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P01_M[lp3, i, 2];
                                    RO_totyield += totdkts_P01_M[lp3, i, 3];
                                }

                                abc = "Y";
                            }

                            if (abc == "Y")
                            {
                                TableCell tr2atc7 = new TableCell();
                                TableCell tr2atc8 = new TableCell();
                                TableCell tr2atc9 = new TableCell();
                                TableCell tr2atc10 = new TableCell();

                                tr2atc7.Text = RO_paytotdkt.ToString();

                                tr2atc7.Wrap = false;

                                tr2atc7.HorizontalAlign = HorizontalAlign.Center;
                                tr2a.Cells.Add(tr2atc7);

                                tr2atc8.Text = RO_paytotAmt.ToString("F2");

                                tr2atc8.Wrap = false;

                                tr2atc8.HorizontalAlign = HorizontalAlign.Right;
                                tr2a.Cells.Add(tr2atc8);

                                tr2atc9.Text = RO_paytotWT.ToString("F2");

                                tr2atc9.Wrap = false;

                                tr2atc9.HorizontalAlign = HorizontalAlign.Right;
                                tr2a.Cells.Add(tr2atc9);

                                tr2atc10.Text = RO_paytotYld.ToString("F2");

                                tr2atc10.Wrap = false;

                                tr2atc10.HorizontalAlign = HorizontalAlign.Right;
                                tr2a.Cells.Add(tr2atc10);


                            }
                            //}
                        }
                    }
                    tr2a.CssClass = "bluefnt";
                    //tr2a.Font.Bold = true;
                    tr2a.BorderWidth = 1;
                    tr2a.BorderColor = System.Drawing.Color.Gray;
                    tr2a.BackColor = System.Drawing.Color.White;
                    TBL_MonthlySales.Rows.Add(tr2a);                 



                    TableRow tr2d1 = new TableRow();
                    TableCell tr2d1tc2 = new TableCell();

                    tr2d1tc2.Text = "";
                    tr2d1tc2.CssClass = "blackfnt";
                    tr2d1tc2.Wrap = false;
                    tr2d1tc2.ColumnSpan = ((SencodrowL - 1) * loopint * 4) + 4 + 2;
                    if (Rmode == "11")
                    {
                        tr2d1tc2.ColumnSpan = 54;
                    }

                    tr2d1tc2.BackColor = System.Drawing.Color.White;
                    tr2d1tc2.HorizontalAlign = HorizontalAlign.Left;
                    tr2d1.Cells.Add(tr2d1tc2);
                    tr2d1.BackColor = System.Drawing.Color.White;
                    tr2d1.Height = 20;
                    TBL_MonthlySales.Rows.Add(tr2d1);

                    srno = 1;
                    RCnti += 1;

                    RO_totdkts = 0;
                    RO_totyield = 0;
                    RO_totamt = 0;
                    RO_totwt = 0;
                    
                }

                PrevRO = dr["ro"].ToString();


            }
            if (Rmode == "12")
            {
                Currmonth = dr["m"].ToString();
                if (Currmonth != PrevMonth)
                {
                    string st_TYP_YEAR11 = "";
                    st_TYP_YEAR11 = dr["Y"].ToString();
                    //st_TYP_YEAR = Ryear.ToString().Substring(0, 2);
                    //if (Convert.ToInt32(Currmonth) > 12)
                    //{
                    //    st_TYP_YEAR = Convert.ToString(Convert.ToInt32(Ryear.ToString().Substring(0, 2)) + 1);
                    //}

                    //if (st_TYP_YEAR.Length == 1)
                    //    st_TYP_YEAR = "0" + st_TYP_YEAR;
                    string ftqt111 = "";

                    //if (TYP_YEAR == "2")
                    //{
                    //    if (Currmonth.ToString().Length == 1)
                    //    {
                    //        ftqt111 = "0" + Currmonth.ToString() + "/0" + Currmonth.ToString() + "/" + st_TYP_YEAR;
                    //    }
                    //    else
                    //    {
                    //        ftqt111 = Currmonth.ToString() + "/" + Currmonth.ToString() + "/" + st_TYP_YEAR;
                    //    }
                    //}
                    //else
                    //{
                        if (Currmonth.ToString().Length == 1)
                        {
                            ftqt111 = "0" + Currmonth.ToString() + "/0" + Currmonth.ToString() + "/" + st_TYP_YEAR11;
                        }
                        else
                        {
                            ftqt111 = Currmonth.ToString() + "/" + Currmonth.ToString() + "/" + st_TYP_YEAR11;
                        }
                    //}

                    TableRow tr11Ab = new TableRow();

                    TableCell tr11Abtc1 = new TableCell();
                    tr11Abtc1.Text = "[" + Convert.ToDateTime(ftqt111).ToString("MMM yy") + "]";
                    tr11Abtc1.CssClass = "blackboldfnt";
                    tr11Abtc1.Wrap = false;
                    tr11Ab.CssClass = "bgbluegrey";
                    tr11Abtc1.ColumnSpan = ((SencodrowL - 1) * loopint * 4) + 4 + 2;
                    tr11Ab.Cells.Add(tr11Abtc1);

                    tr11Ab.BorderWidth = 1;
                    tr11Ab.BorderColor = System.Drawing.Color.Gray;
                    tr11Ab.HorizontalAlign = HorizontalAlign.Center;
                    TBL_MonthlySales.Rows.Add(tr11Ab);
                }
                PrevMonth = dr["m"].ToString();
            }


            TableRow tr2 = new TableRow();

            TableCell tr2tc1 = new TableCell();
            TableCell tr2tc2 = new TableCell();
            TableCell tr2tc3 = new TableCell();
            TableCell tr2tc4 = new TableCell();
            TableCell tr2tc5 = new TableCell();
            TableCell tr2tc6 = new TableCell();
      
            tr2tc1.Text = srno.ToString();
            tr2tc1.CssClass = "blackfnt";
            tr2tc1.Wrap = false;
            tr2.CssClass = "bgbluegrey";
            tr2tc1.HorizontalAlign = HorizontalAlign.Center;
            tr2.Cells.Add(tr2tc1);

            tr2tc2.Text = typ_name;
            tr2tc2.CssClass = "blackfnt";
            tr2tc2.Wrap = false;
            tr2.CssClass = "bgbluegrey";
            tr2tc2.HorizontalAlign = HorizontalAlign.Left;
            tr2.Cells.Add(tr2tc2);

            if (FlagAll == "Y")
            {

                tr2tc3.Text =dr["" + callas + "_All_dkt"].ToString();
                tr2tc3.CssClass = "blackfnt";
                tr2tc3.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2tc3.HorizontalAlign = HorizontalAlign.Center;
                tr2.Cells.Add(tr2tc3);

                tr2tc4.Text = dr["" + callas + "_All_Amt"].ToString();
                tr2tc4.CssClass = "blackfnt";
                tr2tc4.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2tc4.HorizontalAlign = HorizontalAlign.Right;
                tr2.Cells.Add(tr2tc4);

                tr2tc5.Text = dr["" + callas + "_All_wt"].ToString();
                tr2tc5.CssClass = "blackfnt";
                tr2tc5.Wrap = false;
                tr2.CssClass = "bgbluegrey";
                tr2tc5.HorizontalAlign = HorizontalAlign.Right;
                tr2.Cells.Add(tr2tc5);

                if (Convert.ToDouble(dr["" + callas + "_All_wt"]) > 0)
                {
                    tr2tc6.Text = (Convert.ToDouble(dr["" + callas + "_All_yld"]) / Convert.ToDouble(dr["" + callas + "_All_wt"])).ToString("F2");
                }
                else
                {
                    tr2tc6.Text = "0.00";
                }
                tr2tc6.CssClass = "blackfnt";
                tr2tc6.Wrap = false;
                tr2tc6.HorizontalAlign = HorizontalAlign.Right;
                tr2.CssClass = "bgbluegrey";
                tr2.Cells.Add(tr2tc6);

                totdkts = totdkts + Convert.ToDouble(dr["" + callas + "_All_dkt"].ToString());
                totwt = totwt + Convert.ToDouble(dr["" + callas + "_All_wt"].ToString());
                totamt = totamt + Convert.ToDouble(dr["" + callas + "_All_Amt"].ToString());
                totyield = totyield + Convert.ToDouble(dr["" + callas + "_All_yld"].ToString());

                //Response.Write("<br> totwt : " + totwt);
                //Response.Write("<br> totyield : " + totyield);


                RO_totdkts = RO_totdkts + Convert.ToDouble(dr["" + callas + "_All_dkt"].ToString());
                RO_totwt = RO_totwt + Convert.ToDouble(dr["" + callas + "_All_wt"].ToString());
                RO_totamt = RO_totamt + Convert.ToDouble(dr["" + callas + "_All_Amt"].ToString());
                RO_totyield = RO_totyield + Convert.ToDouble(dr["" + callas + "_All_yld"].ToString());


                div = div + 1;
            }

            month1 = "";

            for (int lp3 = 0; lp3 < loopint; lp3++)
            {


                a = (monthid + lp3);
                Aresize = "1_";
               // month1 = a.ToString() + "_";
                if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
                {
                    month1 = a.ToString() + "_";
                    Aresize = a.ToString() + "_";
                }
                if (Rmode == "11")
                {
                    month1 = "";
                    SencodrowL = 1;
                    Aresize = "4_";
                }
                
                for (int rl = 0; rl < SencodrowL; rl++)
                {
                    //if (FlagP01 == "Y")
                    //{
                    string typno = "", abc = "N";
                    if (Rmode != "11")
                    {
                        
                        if (Subtyp == "1")
                        {
                            if (PaybasListArr[rl] == "All")
                            {
                                abc = "N";
                            }
                            else if (PaybasListArr[rl] == "P01")
                            {
                                typno = "1";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P02")
                            {
                                typno = "2";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P03")
                            {
                                typno = "3";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P04")
                            {
                                typno = "4";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P06")
                            {
                                typno = "6";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P07")
                            {
                                typno = "7";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P08")
                            {
                                typno = "8";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P09")
                            {
                                typno = "9";
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "CAN")
                            {
                                typno = "C";
                                abc = "Y";
                            }
                        }
                        else if (Subtyp == "2")
                        {
                            if (TrnlistArr[rl] == "All")
                            {
                                abc = "N";
                            }
                            else if (TrnlistArr[rl] == "1")
                            {
                                typno = "1";
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "2")
                            {
                                typno = "2";
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "3")
                            {
                                typno = "3";
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "4")
                            {
                                typno = "4";
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "CAN")
                            {
                                typno = "C";
                                abc = "Y";
                            }
                        }

                    }
                    else
                    {
                        typno = lp3.ToString();
                        typno = Convert.ToString(Convert.ToInt32(typno) + 1);
                        abc = "Y";
                        strCan = "N";
                        callas1 = "M";
                    }


                    if (abc == "Y")
                    {
                        TableCell tr2tc7 = new TableCell();
                        TableCell tr2tc8 = new TableCell();
                        TableCell tr2tc9 = new TableCell();
                        TableCell tr2tc10 = new TableCell();

                        tr2tc7.Text = dr["" + callas2 + month1 + callas1 + typno + "_dkt"].ToString();
                        tr2tc7.CssClass = "blackfnt";
                        tr2tc7.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2tc7.HorizontalAlign = HorizontalAlign.Center;
                        tr2.Cells.Add(tr2tc7);

                        tr2tc8.Text = dr["" + callas2 + month1 + callas1 + typno + "_Amt"].ToString();
                        tr2tc8.CssClass = "blackfnt";
                        tr2tc8.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2tc8.HorizontalAlign = HorizontalAlign.Right;
                        tr2.Cells.Add(tr2tc8);

                        tr2tc9.Text = dr["" + callas2 + month1 + callas1 + typno + "_wt"].ToString();
                        tr2tc9.CssClass = "blackfnt";
                        tr2tc9.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2tc9.HorizontalAlign = HorizontalAlign.Right;
                        tr2.Cells.Add(tr2tc9);
                        if (Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]) > 0)
                        {
                            tr2tc10.Text = (Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]) / Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"])).ToString("F2");
                        }
                        else
                        {
                            tr2tc10.Text = "0.00";
                        }
                        tr2tc10.CssClass = "blackfnt";
                        tr2tc10.Wrap = false;
                        tr2.CssClass = "bgbluegrey";
                        tr2tc10.HorizontalAlign = HorizontalAlign.Right;
                        tr2.Cells.Add(tr2tc10);
                        if (Rmode != "11")
                        {
                            if (Subtyp == "1")
                            {
                                if (PaybasListArr[rl] == "P01")
                                {
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "P02")
                                {
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "P03")
                                {
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "P04")
                                {
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                }
                                else if (PaybasListArr[rl] == "P06")
                                {
                                    totdkts_P06_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P06_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P06_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P06_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "P07")
                                {
                                    totdkts_P07_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P07_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P07_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P07_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "P08")
                                {
                                    totdkts_P08_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P08_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P08_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P08_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "P09")
                                {
                                    totdkts_P09_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P09_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P09_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P09_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (PaybasListArr[rl] == "CAN")
                                {

                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }

                            }
                            else if (Subtyp == "2")
                            {
                                if (TrnlistArr[rl] == "1")
                                {
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P01_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (TrnlistArr[rl] == "2")
                                {
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P02_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (TrnlistArr[rl] == "3")
                                {
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P03_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);


                                }
                                else if (TrnlistArr[rl] == "4")
                                {
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_P04_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                                }
                                else if (TrnlistArr[rl] == "CAN")
                                {
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                    totdkts_CAN_M[Convert.ToInt16(Aresize.Substring(0, 1)) - 1, RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                }
                            }
                        }
                        else
                        {

                            totdkts_P01_M[Convert.ToInt16(lp3), RCnt - 1, 0] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                            totdkts_P01_M[Convert.ToInt16(lp3) , RCnt - 1, 1] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                            totdkts_P01_M[Convert.ToInt16(lp3) , RCnt - 1, 2] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                            totdkts_P01_M[Convert.ToInt16(lp3) , RCnt - 1, 3] = Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);
                        }

                    }
                    //}
                }
            }
            srno = srno + 1;
            tr2.BorderWidth = 1;
            tr2.BorderColor = System.Drawing.Color.Gray;
            tr2.BackColor = System.Drawing.Color.White;
            TBL_MonthlySales.Rows.Add(tr2);

            RCnt += 1;
        }
        dr.Close();

        if (CRo != "")
        {
            TableRow tr2b = new TableRow();

            TableCell tr2btc1 = new TableCell();
            TableCell tr2btc3 = new TableCell();
            TableCell tr2btc4 = new TableCell();
            TableCell tr2btc5 = new TableCell();
            TableCell tr2btc6 = new TableCell();


            tr2btc1.Text = Getlocation("" + PrevRO + "");
            if (Rtyp == "7")
            {
                tr2btc1.Text = PrevRO;
            }
            tr2btc1.Wrap = false;

            tr2btc1.ColumnSpan = 2;
            tr2btc1.HorizontalAlign = HorizontalAlign.Center;
            tr2b.Cells.Add(tr2btc1);

            if (FlagAll == "Y")
            {

                tr2btc3.Text = RO_totdkts.ToString();

                tr2btc3.Wrap = false;

                tr2btc3.HorizontalAlign = HorizontalAlign.Center;
                tr2b.Cells.Add(tr2btc3);

                tr2btc4.Text = RO_totamt.ToString("F2");

                tr2btc4.Wrap = false;

                tr2btc4.HorizontalAlign = HorizontalAlign.Right;
                tr2b.Cells.Add(tr2btc4);

                tr2btc5.Text = RO_totwt.ToString("F2");

                tr2btc5.Wrap = false;

                tr2btc5.HorizontalAlign = HorizontalAlign.Right;
                tr2b.Cells.Add(tr2btc5);

                if (Convert.ToDouble(totwt) > 0)
                {
                    tr2btc6.Text = (Convert.ToDouble(RO_totyield) / Convert.ToDouble(RO_totwt)).ToString("F2");
                }
                else
                {
                    tr2btc6.Text = "0.0";
                }

                tr2btc6.Wrap = false;
                tr2btc6.HorizontalAlign = HorizontalAlign.Right;

                tr2b.Cells.Add(tr2btc6);

                // totdkts =totdkts+Convert.ToInt16( dr["" + callas + "_All_dkt"].ToString());
            }

            month1 = "";
            for (int lp3 = 0; lp3 < loopint; lp3++)
            {
                a = (monthid + lp3);
                if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
                {
                    month1 = a.ToString() + "_";
                }
                for (int rl = 0; rl < SencodrowL; rl++)
                {
                    //if (FlagP01 == "Y")
                    //{
                    double RO_paytotdkt = 0, RO_paytotAmt = 0, RO_paytotWT = 0, RO_paytotYld = 0;
                    string typno = "", abc = "N";
                    if (Rmode != "11")
                    {
                        if (Subtyp == "1")
                        {
                            RO_paytotdkt = 0;
                            RO_paytotAmt = 0;
                            RO_paytotWT = 0;
                            RO_totyield = 0;

                            if (PaybasListArr[rl] == "All")
                            {

                            }
                            else if (PaybasListArr[rl] == "P01")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P01_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P01_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P01_M[lp3, i, 2];
                                    RO_totyield += totdkts_P01_M[lp3, i, 3];
                                }

                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P02")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P02_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P02_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P02_M[lp3, i, 2];
                                    RO_totyield += totdkts_P02_M[lp3, i, 3];
                                }


                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P03")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P03_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P03_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P03_M[lp3, i, 2];
                                    RO_totyield += totdkts_P03_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P04")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P04_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P04_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P04_M[lp3, i, 2];
                                    RO_totyield += totdkts_P04_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P06")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P06_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P06_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P06_M[lp3, i, 2];
                                    RO_totyield += totdkts_P06_M[lp3, i, 3];
                                }

                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P07")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P07_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P07_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P07_M[lp3, i, 2];
                                    RO_totyield += totdkts_P07_M[lp3, i, 3];
                                }


                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P08")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P08_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P08_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P08_M[lp3, i, 2];
                                    RO_totyield += totdkts_P08_M[lp3, i, 3];
                                }

                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P09")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P09_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P09_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P09_M[lp3, i, 2];
                                    RO_totyield += totdkts_P09_M[lp3, i, 3];
                                }

                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "CAN")
                            {
                                //RO_paytotdkt = RO_totdkts_CAN;
                                //RO_paytotAmt = RO_totamt_CAN;
                                //RO_paytotWT = RO_totwt_CAN;

                                abc = "Y";
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_CAN_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_CAN_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_CAN_M[lp3, i, 2];
                                    RO_totyield += totdkts_CAN_M[lp3, i, 3];
                                }
                            }
                            if (RO_paytotWT > 0)
                            {
                                RO_paytotYld = RO_totyield / RO_paytotWT;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }

                        }
                        else if (Subtyp == "2")
                        {
                            if (TrnlistArr[rl] == "All")
                            {
                                abc = "N";
                                RO_paytotdkt = RO_totdkts_p01;
                                RO_paytotAmt = RO_totamt_p01;
                                RO_paytotWT = RO_totwt_p01;
                                if (totwt_p01 > 0)
                                {
                                    RO_paytotYld = RO_totyield_p01 / RO_totwt_p01;
                                }
                                else
                                {
                                    RO_paytotYld = 0;
                                }
                            }
                            else if (TrnlistArr[rl] == "1")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P01_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P01_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P01_M[lp3, i, 2];
                                    RO_totyield += totdkts_P01_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "2")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P02_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P02_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P02_M[lp3, i, 2];
                                    RO_totyield += totdkts_P02_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "3")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P03_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P03_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P03_M[lp3, i, 2];
                                    RO_totyield += totdkts_P03_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "4")
                            {
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_P04_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_P04_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_P04_M[lp3, i, 2];
                                    RO_totyield += totdkts_P04_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "4")
                            {
                                abc = "Y";
                                for (int i = RCnt - srno; i < RCnt - 1; i++)
                                {
                                    RO_paytotdkt += totdkts_CAN_M[lp3, i, 0];
                                    RO_paytotWT += totdkts_CAN_M[lp3, i, 1];
                                    RO_paytotAmt += totdkts_CAN_M[lp3, i, 2];
                                    RO_totyield += totdkts_CAN_M[lp3, i, 3];
                                }
                            }
                            if (RO_paytotWT > 0)
                            {
                                RO_paytotYld = RO_totyield / RO_paytotWT;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                        }

                    }
                    else
                    {
                        for (int i = RCnt - srno; i < RCnt - 1; i++)
                        {
                            RO_paytotdkt += totdkts_P01_M[lp3, i, 0];
                            RO_paytotWT += totdkts_P01_M[lp3, i, 1];
                            RO_paytotAmt += totdkts_P01_M[lp3, i, 2];
                            RO_totyield += totdkts_P01_M[lp3, i, 3];
                        }

                        abc = "Y";
                    }

                    if (abc == "Y")
                    {
                        TableCell tr2btc7 = new TableCell();
                        TableCell tr2btc8 = new TableCell();
                        TableCell tr2btc9 = new TableCell();
                        TableCell tr2btc10 = new TableCell();

                        tr2btc7.Text = RO_paytotdkt.ToString();

                        tr2btc7.Wrap = false;

                        tr2btc7.HorizontalAlign = HorizontalAlign.Center;
                        tr2b.Cells.Add(tr2btc7);

                        tr2btc8.Text = RO_paytotAmt.ToString("F2");

                        tr2btc8.Wrap = false;

                        tr2btc8.HorizontalAlign = HorizontalAlign.Right;
                        tr2b.Cells.Add(tr2btc8);

                        tr2btc9.Text = RO_paytotWT.ToString("F2");

                        tr2btc9.Wrap = false;

                        tr2btc9.HorizontalAlign = HorizontalAlign.Right;
                        tr2b.Cells.Add(tr2btc9);

                        tr2btc10.Text = RO_paytotYld.ToString("F2");

                        tr2btc10.Wrap = false;

                        tr2btc10.HorizontalAlign = HorizontalAlign.Right;
                        tr2b.Cells.Add(tr2btc10);


                    }
                    //}
                }
            }
            tr2b.CssClass = "bluefnt";
            // tr2b.Font.Bold = true;
            tr2b.BorderWidth = 1;
            tr2b.BorderColor = System.Drawing.Color.Gray;
            tr2b.BackColor = System.Drawing.Color.White;
            TBL_MonthlySales.Rows.Add(tr2b);

            TableRow tr2d = new TableRow();

            TableCell tr2dtc2 = new TableCell();

            tr2dtc2.Text = "";
            tr2dtc2.CssClass = "blackfnt";
            tr2dtc2.Wrap = false;
            tr2dtc2.ColumnSpan = ((SencodrowL - 1) * loopint * 4) + 4 + 2;
            if (Rmode == "11")
            {
                tr2dtc2.ColumnSpan = 54;
            }

            tr2d.BorderWidth = 1;
            tr2d.BorderColor = System.Drawing.Color.Gray;
            tr2dtc2.BackColor = System.Drawing.Color.White;
            tr2dtc2.HorizontalAlign = HorizontalAlign.Left;
            tr2d.Cells.Add(tr2dtc2);
            tr2d.BackColor = System.Drawing.Color.White;
            tr2d.Height = 20;
            TBL_MonthlySales.Rows.Add(tr2d);
        }


        if (srno > 1)
        {
            TableRow tr2c = new TableRow();

            TableCell tr2ctc1 = new TableCell();
            TableCell tr2ctc2 = new TableCell();
            TableCell tr2ctc3 = new TableCell();
            TableCell tr2ctc4 = new TableCell();
            TableCell tr2ctc5 = new TableCell();
            TableCell tr2ctc6 = new TableCell();



            tr2ctc1.Text = "Total";

            tr2ctc1.Wrap = false;

            tr2ctc1.ColumnSpan = 2;
            tr2ctc1.HorizontalAlign = HorizontalAlign.Center;
            tr2c.Cells.Add(tr2ctc1);

            if (FlagAll == "Y")
            {

                tr2ctc3.Text = totdkts.ToString();

                tr2ctc3.Wrap = false;

                tr2ctc3.HorizontalAlign = HorizontalAlign.Center;
                tr2c.Cells.Add(tr2ctc3);

                tr2ctc4.Text = totamt.ToString("F2");

                tr2ctc4.Wrap = false;

                tr2ctc4.HorizontalAlign = HorizontalAlign.Right;
                tr2c.Cells.Add(tr2ctc4);

                tr2ctc5.Text = totwt.ToString("F2");

                tr2ctc5.Wrap = false;

                tr2ctc5.HorizontalAlign = HorizontalAlign.Right;
                tr2c.Cells.Add(tr2ctc5);

                if (Convert.ToDouble(totwt) > 0)
                {
                    tr2ctc6.Text = (Convert.ToDouble(totyield) / Convert.ToDouble(totwt)).ToString("F2");
                }
                else
                {
                    tr2ctc6.Text = "0.0";
                }

                tr2ctc6.Wrap = false;
                tr2ctc6.HorizontalAlign = HorizontalAlign.Right;

                tr2c.Cells.Add(tr2ctc6);

                // totdkts =totdkts+Convert.ToInt16( dr["" + callas + "_All_dkt"].ToString());
            }

            month1 = "";
            for (int lp3 = 0; lp3 < loopint; lp3++)
            {
                a = (monthid + lp3);
                if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
                {
                    month1 = a.ToString() + "_";
                }
                for (int rl = 0; rl < SencodrowL; rl++)
                {
                    //if (FlagP01 == "Y")
                    //{
                    double paytotdkt = 0, paytotAmt = 0, paytotWT = 0, paytotYld = 0;
                    string typno = "", abc = "N";
                    if (Rmode != "11")
                    {
                        if (Subtyp == "1")
                        {
                            if (PaybasListArr[rl] == "All")
                            {

                            }
                            else if (PaybasListArr[rl] == "P01")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P01_M[lp3, i, 0];
                                    paytotWT += totdkts_P01_M[lp3, i, 1];
                                    paytotAmt += totdkts_P01_M[lp3, i, 2];
                                    totyield += totdkts_P01_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P02")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P02_M[lp3, i, 0];
                                    paytotWT += totdkts_P02_M[lp3, i, 1];
                                    paytotAmt += totdkts_P02_M[lp3, i, 2];
                                    totyield += totdkts_P02_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P03")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P03_M[lp3, i, 0];
                                    paytotWT += totdkts_P03_M[lp3, i, 1];
                                    paytotAmt += totdkts_P03_M[lp3, i, 2];
                                    totyield += totdkts_P03_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P04")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P04_M[lp3, i, 0];
                                    paytotWT += totdkts_P04_M[lp3, i, 1];
                                    paytotAmt += totdkts_P04_M[lp3, i, 2];
                                    totyield += totdkts_P04_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P06")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P06_M[lp3, i, 0];
                                    paytotWT += totdkts_P06_M[lp3, i, 1];
                                    paytotAmt += totdkts_P06_M[lp3, i, 2];
                                    totyield += totdkts_P06_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P07")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P07_M[lp3, i, 0];
                                    paytotWT += totdkts_P07_M[lp3, i, 1];
                                    paytotAmt += totdkts_P07_M[lp3, i, 2];
                                    totyield += totdkts_P07_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P08")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P08_M[lp3, i, 0];
                                    paytotWT += totdkts_P08_M[lp3, i, 1];
                                    paytotAmt += totdkts_P08_M[lp3, i, 2];
                                    totyield += totdkts_P08_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "P09")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P09_M[lp3, i, 0];
                                    paytotWT += totdkts_P09_M[lp3, i, 1];
                                    paytotAmt += totdkts_P09_M[lp3, i, 2];
                                    totyield += totdkts_P09_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (PaybasListArr[rl] == "CAN")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_CAN_M[lp3, i, 0];
                                    paytotWT += totdkts_CAN_M[lp3, i, 1];
                                    paytotAmt += totdkts_CAN_M[lp3, i, 2];
                                    totyield += totdkts_CAN_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }

                            if (paytotWT > 0)
                            {
                                paytotYld = paytotAmt / paytotWT;
                            }
                            else
                            {
                                paytotYld = 0;
                            }

                        }
                        else if (Subtyp == "2")
                        {
                            if (TrnlistArr[rl] == "All")
                            {
                                abc = "N";

                            }
                            else if (TrnlistArr[rl] == "1")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P01_M[lp3, i, 0];
                                    paytotWT += totdkts_P01_M[lp3, i, 1];
                                    paytotAmt += totdkts_P01_M[lp3, i, 2];
                                    totyield += totdkts_P01_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "2")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P02_M[lp3, i, 0];
                                    paytotWT += totdkts_P02_M[lp3, i, 1];
                                    paytotAmt += totdkts_P02_M[lp3, i, 2];
                                    totyield += totdkts_P02_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "3")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P03_M[lp3, i, 0];
                                    paytotWT += totdkts_P03_M[lp3, i, 1];
                                    paytotAmt += totdkts_P03_M[lp3, i, 2];
                                    totyield += totdkts_P03_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "4")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_P04_M[lp3, i, 0];
                                    paytotWT += totdkts_P04_M[lp3, i, 1];
                                    paytotAmt += totdkts_P04_M[lp3, i, 2];
                                    totyield += totdkts_P04_M[lp3, i, 3];
                                }
                                abc = "Y";
                            }
                            else if (TrnlistArr[rl] == "CAN")
                            {
                                for (int i = 0; i < RCnt - 1; i++)
                                {
                                    paytotdkt += totdkts_CAN_M[lp3, i, 0];
                                    paytotWT += totdkts_CAN_M[lp3, i, 1];
                                    paytotAmt += totdkts_CAN_M[lp3, i, 2];
                                    totyield += totdkts_CAN_M[lp3, i, 3];
                                }
                                abc = "Y";


                            }
                            if (paytotWT > 0)
                            {
                                paytotYld = paytotAmt / paytotWT;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                        }
                    }

                    else
                    {
                        for (int i = 0; i < RCnt - 1; i++)
                        {
                            paytotdkt += totdkts_P01_M[lp3, i, 0];
                            paytotWT += totdkts_P01_M[lp3, i, 1];
                            paytotAmt += totdkts_P01_M[lp3, i, 2];
                            totyield += totdkts_P01_M[lp3, i, 3];
                        }
                        abc = "Y";

                    }


                    if (abc == "Y")
                    {
                        TableCell tr2ctc7 = new TableCell();
                        TableCell tr2ctc8 = new TableCell();
                        TableCell tr2ctc9 = new TableCell();
                        TableCell tr2ctc10 = new TableCell();

                        tr2ctc7.Text = paytotdkt.ToString();

                        tr2ctc7.Wrap = false;

                        tr2ctc7.HorizontalAlign = HorizontalAlign.Center;
                        tr2c.Cells.Add(tr2ctc7);

                        tr2ctc8.Text = paytotAmt.ToString("F2");

                        tr2ctc8.Wrap = false;

                        tr2ctc8.HorizontalAlign = HorizontalAlign.Right;
                        tr2c.Cells.Add(tr2ctc8);

                        tr2ctc9.Text = paytotWT.ToString("F2");

                        tr2ctc9.Wrap = false;

                        tr2ctc9.HorizontalAlign = HorizontalAlign.Right;
                        tr2c.Cells.Add(tr2ctc9);

                        tr2ctc10.Text = paytotYld.ToString("F2");

                        tr2ctc10.Wrap = false;

                        tr2ctc10.HorizontalAlign = HorizontalAlign.Right;
                        tr2c.Cells.Add(tr2ctc10);


                    }
                }
                
            }
            tr2c.CssClass = "bluefnt";
            tr2c.Font.Bold = true;
            tr2c.BorderWidth = 1;
            tr2c.BorderColor = System.Drawing.Color.Gray;
            tr2c.BackColor = System.Drawing.Color.White;
            TBL_MonthlySales.Rows.Add(tr2c);
        }

        //SqlDataAdapter da = new SqlDataAdapter(cmd);

        //DataSet ds = new DataSet();

        //da.Fill(ds);
        //dgDocket.DataSource = ds;
        //dgDocket.DataBind();

        Conn.Close();
    }

    public string Getpaybas(string lococde)
    {


        string paybasdesc = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_paybas";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@paybas", SqlDbType.VarChar).Value = lococde.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            paybasdesc = Convert.ToString(dr["paybasdesc"]);
        }

        if (paybasdesc == null) paybasdesc = "";
        return paybasdesc;
    }

    public string Gettrnmod(string lococde)
    {


        string moddesc = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "sp_get_trnmod";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@trnmod", SqlDbType.VarChar).Value = lococde.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            moddesc = Convert.ToString(dr["moddesc"]);
        }

        if (moddesc == null) moddesc = "";
        return moddesc;
    }
    public string Getlocation(string lococde)
    {


        string moddesc = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select top 1  loccode+' : '+locname as locname from webx_location where loccode='" + lococde + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@trnmod", SqlDbType.VarChar).Value = lococde.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            moddesc = Convert.ToString(dr["locname"]);
        }

        if (moddesc == null) moddesc = "";
        return moddesc;
    }


    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;

            TBL_MonthlySales.BorderStyle = BorderStyle.Double;
            TBL_MonthlySales.BorderWidth = 1;
            TBL_MonthlySales.CellSpacing = 2;
            TBL_CRI.Border = 1;
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Monthaly_Sales.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            //DipsplayReport();
            BindGrid();
            TBL_CRI.RenderControl(hw);
            //GV_Booking.RenderControl(hw);
            TBL_MonthlySales.RenderControl(hw);
            //TBL_MonthlySales.BorderWidth = 1;
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            //throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }

    //protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    GridView oGridView = (GridView)sender;

    //    GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
    //    TableCell oTableCell = new TableCell();
    //    TableCell oTableCell1 = new TableCell();

    //    oTableCell = new TableCell();
    //    oTableCell.Text = " Srno";
    //    oTableCell.HorizontalAlign = HorizontalAlign.Center;
    //    oTableCell.CssClass = "blackfnt";
    //    oTableCell.RowSpan = 2;
    //    oGridViewRow.Cells.Add(oTableCell);


    //    oTableCell = new TableCell();
    //    oTableCell.Text = FirstColumnTitle;
    //    oTableCell.HorizontalAlign = HorizontalAlign.Center;
    //    oTableCell.CssClass = "blackfnt";
    //    oTableCell.RowSpan = 2;
    //    oGridViewRow.Cells.Add(oTableCell);


    //    oTableCell = new TableCell();
    //    oTableCell.Text = "Total";
    //    oTableCell.HorizontalAlign = HorizontalAlign.Center;
    //    oTableCell.CssClass = "blackfnt";

    //    oGridViewRow.Cells.Add(oTableCell);
    //    oTableCell.ColumnSpan = 4;
    //    oGridViewRow.Cells.Add(oTableCell);


    //    oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
    //    oGridView.Controls[0].Controls.RemoveAt(1);


    //    if (e.Row.RowType == DataControlRowType.Footer)
    //    {
    //        //Build custom header.


    //        //GridView oGridView = (GridView)sender;
    //        // Label billamt = (Label)oGridView.FindControl("billamt");

    //        GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

    //       // TableCell oTableCell1 = new TableCell();
    //        //***************************
    //        //*****for second row *************

    //        oTableCell1 = new TableCell();
    //        oTableCell1.Text = "No.of " + dkt_call;
    //        oTableCell1.CssClass = "blackfnt";
    //        oGridViewRow1.Cells.Add(oTableCell1);

    //        oTableCell1 = new TableCell();
    //        oTableCell1.Text = "Amout";
    //        oTableCell1.CssClass = "blackfnt";
    //        oGridViewRow1.Cells.Add(oTableCell1);


    //        oTableCell1 = new TableCell();
    //        oTableCell1.Text = "Charge Wt";
    //        oTableCell1.CssClass = "blackfnt";
    //        oGridViewRow1.Cells.Add(oTableCell1);

    //        oTableCell1 = new TableCell();
    //        oTableCell1.Text = "Yield";
    //        oTableCell1.CssClass = "blackfnt";
    //        oGridViewRow1.Cells.Add(oTableCell1);

    //        oGridViewRow1.HorizontalAlign = HorizontalAlign.Center;
    //        oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
    //        oGridViewRow1.CssClass = "bgbluegrey";
    //    }



    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        //e.Row.Cells[1].Text=
    //    }
    //}
    //protected void pgChange(object sender, GridViewPageEventArgs e)
    //{

    //    dgDocket.PageIndex = e.NewPageIndex;

    //    // BindGrid();

    //}

}
