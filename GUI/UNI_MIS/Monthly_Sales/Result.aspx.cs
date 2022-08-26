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
    public static string RO, LO, month1, Rmode, Subtyp, Rtyp, PaybasList, Trnlist, ColumnList, Ryear;
    public static string FirstColumnTitle = "", dkt_call = "", callas = "", callas1 = "", callas2 = "";
    public static string FlagAll = "", FlagP01 = "", FlagP02 = "", FlagP03 = "", FlagP04 = "", FlagP06 = "", FlagP07 = "", FlagP08 = "", FlagP09 = "", FlagT1 = "", FlagT2 = "", FlagT3 = "", FlagT4 = "";
    int a = 0;
    double totdkts = 0, totamt = 0, totwt = 0, totyield = 0,div=0;
    double totdkts_p01 = 0, totamt_p01 = 0, totwt_p01 = 0, totyield_p01 = 0;
    double totdkts_p02 = 0, totamt_p02 = 0, totwt_p02 = 0, totyield_p02 = 0;
    double totdkts_p03 = 0, totamt_p03 = 0, totwt_p03 = 0, totyield_p03 = 0;
    double totdkts_p04 = 0, totamt_p04 = 0, totwt_p04 = 0, totyield_p04 = 0;
    double totdkts_p06 = 0, totamt_p06 = 0, totwt_p06 = 0, totyield_p06 = 0;
   // double[] arrtotdkts_no = new double[9];
    double totdkts_p07 = 0, totamt_p07 = 0, totwt_p07 = 0, totyield_p07 = 0;
    double totdkts_p08 = 0, totamt_p08 = 0, totwt_p08 = 0, totyield_p08 = 0;
    double totdkts_p09 = 0, totamt_p09 = 0, totwt_p09 = 0, totyield_p09 = 0;

    double RO_totdkts = 0, RO_totamt = 0, RO_totwt = 0, RO_totyield = 0;
    double RO_totdkts_p01 = 0, RO_totamt_p01 = 0, RO_totwt_p01 = 0, RO_totyield_p01 = 0;
    double RO_totdkts_p02 = 0, RO_totamt_p02 = 0, RO_totwt_p02 = 0, RO_totyield_p02 = 0;
    double RO_totdkts_p03 = 0, RO_totamt_p03 = 0, RO_totwt_p03 = 0, RO_totyield_p03 = 0;
    double RO_totdkts_p04 = 0, RO_totamt_p04 = 0, RO_totwt_p04 = 0, RO_totyield_p04 = 0;
    double RO_totdkts_p06 = 0, RO_totamt_p06 = 0, RO_totwt_p06 = 0, RO_totyield_p06 = 0;
    // double[] arrtotdkts_no = new double[9];
    double RO_totdkts_p07 = 0, RO_totamt_p07 = 0, RO_totwt_p07 = 0, RO_totyield_p07 = 0;
    double RO_totdkts_p08 = 0, RO_totamt_p08 = 0, RO_totwt_p08 = 0, RO_totyield_p08 = 0;
    double RO_totdkts_p09 = 0, RO_totamt_p09 = 0, RO_totwt_p09 = 0, RO_totyield_p09 = 0;
   

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

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
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
        if (Rmode == "8" || Rmode == "9" || Rmode == "10" )
        {
            string[] strArrDtFrom = strrightnow.Split('/');
            string[] strArrDtTo = strrightnow1.Split('/');
            dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
            dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        }
        Trnlist = Request.QueryString["Trnlist"].ToString();
        ColumnList = Request.QueryString["ColumnList"].ToString();
        Ryear = Request.QueryString["Ryear"].ToString();
        dkt_call = Session["DocketCalledAs"].ToString();

        if (Rtyp == "1")
        {
            FirstColumnTitle = "Location";
        }
        else if (Rtyp == "2")
        {
            FirstColumnTitle = "Customer";
        }
        else if (Rtyp == "3")
        {
            FirstColumnTitle = "Customer Group";
        }
        else if (Rtyp == "4")
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

        string sql_grid = "exec webx_Monthly_sales_ver1 '" + Rmode + "','" + RO + "','" + LO + "','" + PaybasList + "','" + Trnlist + "','" + ColumnList + "','" + Subtyp + "','" + Rtyp + "','" + Ryear + "','" + dtFrom + "','" + dtTo + "','" + cust8888 + "'";
       // Response.Write("abcd : " + sql_grid);
        SqlCommand cmd = new SqlCommand(sql_grid,Conn);
        SqlDataReader dr = cmd.ExecuteReader();

        string typ_name = "";

        int loopint = 0,rptcol=0;

        if (Rmode == "1" || Rmode == "2" || Rmode == "7" || Rmode == "8" || Rmode == "9" || Rmode == "10")
        {
            loopint = 1;
            rptcol = SencodrowL;
        }
        else if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
        {
            loopint = 3;
            rptcol = ((SencodrowL-1) * loopint)+1 ;
        }

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


                for (int lp1 = 0; lp1 < loopint; lp1++)
                {
                    if (Rmode == "3")
                    {
                        stmonth = 1 + lp1;
                    }
                    else if (Rmode == "4")
                    {
                        stmonth = 4 + lp1;
                    }
                    else if (Rmode == "5")
                    {
                        stmonth = 7 + lp1;
                    }
                    else if (Rmode == "6")
                    {
                        stmonth = 10 + lp1;
                    }
                    else if (Rmode == "1")
                    {
                        stmonth = 10 + lp1;
                    }
                    else if (Rmode == "2")
                    {
                        stmonth = 10 + lp1;
                    }


                    if (Rmode == "6")
                    {
                        ftqt = stmonth.ToString() + "/" + stmonth.ToString() + "/" + Ryear;
                    }
                    else if(Rmode == "1")
                    {
                        ftqt = System.DateTime.Today.ToString("MMM yy");
                    }
                        else if(Rmode == "2")
                    {
                         ftqt =System.DateTime.Today.AddMonths(-1).ToString("MMM yy");
                    }
                        else
                    {
                        ftqt ="0"+ stmonth.ToString() + "/0" + stmonth.ToString() + "/" + Ryear;
                    }

                   
                    TableCell tr1atc3 = new TableCell();
                    //tr1atc3.Text = Convert.ToDateTime(ftqt).ToString("MMM yy");
                    if(Rmode == "1")
                    {
                        tr1atc3.Text ="["+ System.DateTime.Today.ToString("MMM yy")+"]";
                    }
                    else if (Rmode == "2")
                    {
                        tr1atc3.Text = "[" + System.DateTime.Today.AddMonths(-1).ToString("MMM yy") + "]";
                    }
                    else if (Rmode == "8" || Rmode == "9" || Rmode == "10")
                    {
                        tr1atc3.Text = "[" + dtFrom + "-" + dtTo + "]";
                    }
                    else if (Rmode == "7")
                    {
                        string dt1 = "01/01/" + Ryear;
                        string dt2 = "12/12/" + Ryear;
                        tr1atc3.Text = "[" + Convert.ToDateTime(dt1).ToString("MMM yy") + " - " + Convert.ToDateTime(dt2).ToString("MMM yy") + "]";
                    }
                    else
                    {
                        tr1atc3.Text = "[" + Convert.ToDateTime(ftqt).ToString("MMM yy") + "]";
                    }

                    tr1atc3.CssClass = "blackboldfnt";
                    tr1atc3.Wrap = false;
                    tr1atc3.ColumnSpan = (SencodrowL-1) * 4;
                    //if (Rmode == "1" || Rmode == "2")
                    //{
                    //    tr1atc3.ColumnSpan =  4;
                    //}
                    tr1a.CssClass = "bgbluegrey";
                    tr1a.Cells.Add(tr1atc3);


                }


            }
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
                if (Subtyp == "1")
                {
                    if (PaybasListArr[rl] == "All")
                    {
                        abch = "N";
                    }
                    else if (PaybasListArr[rl] == "P01")
                    {
                        typnoh = "1";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P02")
                    {
                        typnoh = "2";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P03")
                    {
                        typnoh = "3";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P04")
                    {
                        typnoh = "4";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P06")
                    {
                        typnoh = "6";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P07")
                    {
                        typnoh = "7";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P08")
                    {
                        typnoh = "8";
                        abch = "Y";
                    }
                    else if (PaybasListArr[rl] == "P09")
                    {
                        typnoh = "9";
                        abch = "Y";
                    }
                }
                else if (Subtyp == "2")
                {
                    if (TrnlistArr[rl] == "All")
                    {
                        abch = "N";
                    }
                    else if (TrnlistArr[rl] == "1")
                    {
                        typnoh = "1";
                        abch = "Y";
                    }
                    else if (TrnlistArr[rl] == "2")
                    {
                        typnoh = "2";
                        abch = "Y";
                    }
                    else if (TrnlistArr[rl] == "3")
                    {
                        typnoh = "3";
                        abch = "Y";
                    }
                    else if (TrnlistArr[rl] == "4")
                    {
                        typnoh = "4";
                        abch = "Y";
                    }
                }
                if (abch == "Y")
                {

                    TableCell tr1tc5 = new TableCell();
                    if (Subtyp == "1")
                    {

                        tr1tc5.Text = Getpaybas("p0" + typnoh + "");
                        tr1tc5.CssClass = "blackboldfnt";
                        tr1tc5.Wrap = false;
                        tr1.CssClass = "bgbluegrey";
                        tr1tc5.ColumnSpan = 4;
                        tr1.Cells.Add(tr1tc5);
                    }
                    else if (Subtyp == "2")
                    {

                        tr1tc5.Text = Gettrnmod("" + typnoh + "");
                        tr1tc5.CssClass = "blackboldfnt";
                        tr1tc5.Wrap = false;
                        tr1.CssClass = "bgbluegrey";
                        tr1tc5.ColumnSpan = 4;
                        tr1.Cells.Add(tr1tc5);
                    }
                }
            }
        }

      
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
        tr11.HorizontalAlign = HorizontalAlign.Center;
        TBL_MonthlySales.Rows.Add(tr11);
        int srno = 0;

        srno = 1;
        string CRo="", PrevRO="";
        while (dr.Read())
        {
            
            typ_name = dr["cd"].ToString() + " : " + dr["nm"].ToString();
            if (Rtyp == "1" || Rtyp == "7")
            {
                CRo = dr["ro"].ToString();
                if (CRo != PrevRO && PrevRO!="")
                {
                    TableRow tr2a = new TableRow();

                    TableCell tr2atc1 = new TableCell();
                    TableCell tr2atc3 = new TableCell();
                    TableCell tr2atc4 = new TableCell();
                    TableCell tr2atc5 = new TableCell();
                    TableCell tr2atc6 = new TableCell();

                    tr2atc1.Text = Getlocation("" + PrevRO + "");
                    if (Rtyp == "7")
                    {
                        tr2atc1.Text =  PrevRO ;
                    }

                    tr2atc1.Wrap = false;
                   
                    tr2atc1.ColumnSpan = 2;
                    tr2atc1.HorizontalAlign = HorizontalAlign.Center;
                    tr2a.Cells.Add(tr2atc1);

                    //tr2atc2.Text = "";
                    //tr2atc2.CssClass = "blackfnt";
                    //tr2atc2.Wrap = false;
                    //tr2atc2.ColumnSpan = ((SencodrowL - 1) * 4)+4;
                    ////tr2a.CssClass = "bgbluegrey";
                    //tr2atc2.BackColor = System.Drawing.Color.White;
                    //tr2atc2.HorizontalAlign = HorizontalAlign.Left;
                    //tr2a.Cells.Add(tr2atc2);
                    //tr2a.CssClass = "blackfnt";
                    //TBL_MonthlySales.Rows.Add(tr2a);






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
                            if (Subtyp == "1")
                            {
                                if (PaybasListArr[rl] == "All")
                                {

                                }
                                else if (PaybasListArr[rl] == "P01")
                                {
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
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P02")
                                {
                                    RO_paytotdkt = RO_totdkts_p02;
                                    RO_paytotAmt = RO_totamt_p02;
                                    RO_paytotWT = RO_totwt_p02;
                                    if (totwt_p02 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p02 / RO_totwt_p02;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P03")
                                {
                                    RO_paytotdkt = RO_totdkts_p03;
                                    RO_paytotAmt = RO_totamt_p03;
                                    RO_paytotWT = RO_totwt_p03;
                                    if (RO_totwt_p03 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p03 / RO_totwt_p03;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P04")
                                {
                                    RO_paytotdkt = RO_totdkts_p04;
                                    RO_paytotAmt = RO_totamt_p04;
                                    RO_paytotWT = RO_totwt_p04;
                                    if (totwt_p04 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p04 / RO_totwt_p04;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P06")
                                {
                                    RO_paytotdkt = RO_totdkts_p06;
                                    RO_paytotAmt = RO_totamt_p06;
                                    RO_paytotWT = RO_totwt_p06;
                                    if (totwt_p06 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p06 / RO_totwt_p06;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P07")
                                {
                                    RO_paytotdkt = RO_totdkts_p07;
                                    RO_paytotAmt = RO_totamt_p07;
                                    RO_paytotWT = RO_totwt_p07;
                                    if (totwt_p07 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p07 / RO_totwt_p07;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P08")
                                {
                                    RO_paytotdkt = RO_totdkts_p08;
                                    RO_paytotAmt = RO_totamt_p08;
                                    RO_paytotWT = RO_totwt_p08;
                                    if (totwt_p08 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p08 / RO_totwt_p08;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (PaybasListArr[rl] == "P09")
                                {
                                    RO_paytotdkt = RO_totdkts_p09;
                                    RO_paytotAmt = RO_totamt_p09;
                                    RO_paytotWT = RO_totwt_p09;
                                    if (totwt_p09 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p09 / RO_totwt_p09;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
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
                                    abc = "Y";
                                }
                                else if (TrnlistArr[rl] == "2")
                                {
                                    RO_paytotdkt = RO_totdkts_p02;
                                    RO_paytotAmt = RO_totamt_p02;
                                    RO_paytotWT = RO_totwt_p02;
                                    if (totwt_p02 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p02 / RO_totwt_p02;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                }
                                else if (TrnlistArr[rl] == "3")
                                {
                                    RO_paytotdkt = RO_totdkts_p03;
                                    RO_paytotAmt = RO_totamt_p03;
                                    RO_paytotWT = RO_totwt_p03;
                                    if (RO_totwt_p03 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p03 / RO_totwt_p03;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                    abc = "Y";
                                }
                                else if (TrnlistArr[rl] == "4")
                                {
                                    RO_paytotdkt = RO_totdkts_p04;
                                    RO_paytotAmt = RO_totamt_p04;
                                    RO_paytotWT = RO_totwt_p04;
                                    if (totwt_p04 > 0)
                                    {
                                        RO_paytotYld = RO_totyield_p04 / RO_totwt_p04;
                                    }
                                    else
                                    {
                                        RO_paytotYld = 0;
                                    }
                                    abc = "Y";
                                    abc = "Y";
                                }
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
                    tr2a.BackColor = System.Drawing.Color.White;
                    TBL_MonthlySales.Rows.Add(tr2a);

                    TableRow tr2d1 = new TableRow();

                    TableCell tr2d1tc2 = new TableCell();

                    tr2d1tc2.Text = "";
                    tr2d1tc2.CssClass = "blackfnt";
                    tr2d1tc2.Wrap = false;
                    tr2d1tc2.ColumnSpan = ((SencodrowL - 1) * loopint  * 4) + 4 + 2;

                    tr2d1tc2.BackColor = System.Drawing.Color.White;
                    tr2d1tc2.HorizontalAlign = HorizontalAlign.Left;
                    tr2d1.Cells.Add(tr2d1tc2);
                    tr2d1.BackColor = System.Drawing.Color.White;
                    tr2d1.Height = 20;
                    TBL_MonthlySales.Rows.Add(tr2d1);
                    srno = 1;

                   
                    RO_totamt = 0;
                    RO_totwt = 0;
                    RO_totyield = 0;
                    RO_totdkts = 0;
                    RO_totdkts_p01 = 0;
                    RO_totamt_p01 = 0;
                    RO_totwt_p01 = 0;
                    RO_totyield_p01 = 0;
                    RO_totdkts_p02 = 0;
                    RO_totamt_p02 = 0;
                    RO_totwt_p02 = 0;
                    RO_totyield_p02 = 0;
                    RO_totdkts_p03 = 0;
                    RO_totamt_p03 = 0;
                    RO_totwt_p03 = 0;
                    RO_totyield_p03 = 0;
                    RO_totdkts_p04 = 0;
                    RO_totamt_p04 = 0;
                    RO_totwt_p04 = 0;
                    RO_totyield_p04 = 0;
                    RO_totdkts_p06 = 0;
                    RO_totamt_p06 = 0;
                    RO_totwt_p06 = 0;
                    RO_totyield_p06 = 0;

                    RO_totdkts_p07 = 0;
                    RO_totamt_p07 = 0;
                    RO_totwt_p07 = 0;
                    RO_totyield_p07 = 0;
                    RO_totdkts_p08 = 0;
                    RO_totamt_p08 = 0;
                    RO_totwt_p08 = 0;
                    RO_totyield_p08 = 0;
                    RO_totdkts_p09 = 0;
                    RO_totamt_p09 = 0;
                    RO_totwt_p09 = 0;
                    RO_totyield_p09 = 0;
                }
              
                PrevRO = dr["ro"].ToString();
               
                 
            }

            TableRow tr2 = new TableRow();

            TableCell tr2tc1 = new TableCell();
            TableCell tr2tc2 = new TableCell();
            TableCell tr2tc3 = new TableCell();
            TableCell tr2tc4 = new TableCell();
            TableCell tr2tc5 = new TableCell();
            TableCell tr2tc6 = new TableCell();
            //TableCell tr2tc7 = new TableCell();
            //TableCell tr2tc8 = new TableCell();
            //TableCell tr2tc9 = new TableCell();
            //TableCell tr2tc10 = new TableCell();



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

                tr2tc3.Text = dr["" + callas + "_All_dkt"].ToString();
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

                totdkts =totdkts+Convert.ToDouble( dr["" + callas + "_All_dkt"].ToString());
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
                if (Rmode == "3" || Rmode == "4" || Rmode == "5" || Rmode == "6")
                {
                    month1 = a.ToString()+"_";
                }
                for (int rl = 0; rl < SencodrowL; rl++)
                {
                    //if (FlagP01 == "Y")
                    //{
                    string typno = "", abc = "N";
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

                        if (Subtyp == "1")
                        {
                            if (PaybasListArr[rl] == "P01")
                            {
                                totdkts_p01 = totdkts_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p01 = totwt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p01 = totamt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p01 = totyield_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p01 = RO_totdkts_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p01 = RO_totwt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p01 = RO_totamt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p01 = RO_totyield_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P02")
                            {
                                totdkts_p02 = totdkts_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p02 = totwt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p02 = totamt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p02 = totyield_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p02 = RO_totdkts_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p02 = RO_totwt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p02 = RO_totamt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p02 = RO_totyield_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P03")
                            {
                                totdkts_p03 = totdkts_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p03 = totwt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p03 = totamt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p03 = totyield_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p03 = RO_totdkts_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p03 = RO_totwt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p03 = RO_totamt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p03 = RO_totyield_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P04")
                            {
                                totdkts_p04 = totdkts_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p04 = totwt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p04 = totamt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p04 = totyield_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p04 = RO_totdkts_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p04 = RO_totwt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p04 = RO_totamt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p04 = RO_totyield_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P06")
                            {
                                totdkts_p06 = totdkts_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p06 = totwt_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p06 = totamt_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p06 = totyield_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p06 = RO_totdkts_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p06 = RO_totwt_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p06 = RO_totamt_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p06 = RO_totyield_p06 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P07")
                            {
                                totdkts_p07 = totdkts_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p07 = totwt_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p07 = totamt_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p07 = totyield_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p07 = RO_totdkts_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p07 = RO_totwt_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p07 = RO_totamt_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p07 = RO_totyield_p07 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P08")
                            {
                                totdkts_p08 = totdkts_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p08 = totwt_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p08 = totamt_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p08 = totyield_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p08 = RO_totdkts_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p08 = RO_totwt_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p08 = RO_totamt_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p08 = RO_totyield_p08 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (PaybasListArr[rl] == "P09")
                            {
                                totdkts_p09 = totdkts_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p09 = totwt_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p09 = totamt_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p09 = totyield_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p09 = RO_totdkts_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p09 = RO_totwt_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p09 = RO_totamt_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p09 = RO_totyield_p09 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                        }
                        else if(Subtyp=="2")
                        {
                            if (TrnlistArr[rl] == "1")
                            {
                                totdkts_p01 = totdkts_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p01 = totwt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p01 = totamt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p01 = totyield_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p01 = RO_totdkts_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p01 = RO_totwt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p01 = RO_totamt_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p01 = RO_totyield_p01 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (TrnlistArr[rl] == "2")
                            {
                                totdkts_p02 = totdkts_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p02 = totwt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p02 = totamt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p02 = totyield_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p02 = RO_totdkts_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p02 = RO_totwt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p02 = RO_totamt_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p02 = RO_totyield_p02 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (TrnlistArr[rl] == "3")
                            {
                                totdkts_p03 = totdkts_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p03 = totwt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p03 = totamt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p03 = totyield_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p03 = RO_totdkts_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p03 = RO_totwt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p03 = RO_totamt_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p03 = RO_totyield_p03 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                            else if (TrnlistArr[rl] == "4")
                            {
                                totdkts_p04 = totdkts_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                totwt_p04 = totwt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                totamt_p04 = totamt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                totyield_p04 = totyield_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                                RO_totdkts_p04 = RO_totdkts_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_dkt"]);
                                RO_totwt_p04 = RO_totwt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_wt"]);
                                RO_totamt_p04 = RO_totamt_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_Amt"]);
                                RO_totyield_p04 = RO_totyield_p04 + Convert.ToDouble(dr["" + callas2 + month1 + callas1 + typno + "_yld"]);

                            }
                        }

                //totdkts =totdkts+Convert.ToDouble( dr["" + callas + "_All_dkt"].ToString());
                //totwt = totwt + Convert.ToDouble(dr["" + callas + "_All_wt"]);
                //totamt = totwt + Convert.ToDouble(dr["" + callas + "_All_Amt"]);
                //totyield = totwt + Convert.ToDouble(dr["" + callas + "_All_yld"]);
                    }
                    //}
                }
            }
            srno = srno + 1;
            tr2.BackColor = System.Drawing.Color.White;
            TBL_MonthlySales.Rows.Add(tr2);

            
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


            tr2btc1.Text = Getlocation(""+PrevRO+"");
            if (Rtyp == "7")
            {
                tr2btc1.Text = PrevRO;
            }
            tr2btc1.Wrap = false;
            
            tr2btc1.ColumnSpan = 2;
            tr2btc1.HorizontalAlign = HorizontalAlign.Center;
            tr2b.Cells.Add(tr2btc1);

           // tr2btc2.Text = "";
           // tr2btc2.CssClass = "blackfnt";
           // tr2btc2.Wrap = false;
           // tr2btc2.ColumnSpan = ((SencodrowL - 1) * 4) + 4;
           //// tr2btc2.CssClass = "bgbluegrey";
           // tr2btc2.BackColor = System.Drawing.Color.White;
           // tr2btc2.HorizontalAlign = HorizontalAlign.Left;
           // tr2b.Cells.Add(tr2btc2);
           // tr2b.CssClass = "blackfnt";




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
                    tr2btc6.Text = (Convert.ToDouble(totyield) / Convert.ToDouble(totwt)).ToString("F2");
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
                    if (Subtyp == "1")
                    {
                        if (PaybasListArr[rl] == "All")
                        {

                        }
                        else if (PaybasListArr[rl] == "P01")
                        {
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
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P02")
                        {
                            RO_paytotdkt = RO_totdkts_p02;
                            RO_paytotAmt = RO_totamt_p02;
                            RO_paytotWT = RO_totwt_p02;
                            if (totwt_p02 > 0)
                            {
                                RO_paytotYld = RO_totyield_p02 / RO_totwt_p02;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P03")
                        {
                            RO_paytotdkt = RO_totdkts_p03;
                            RO_paytotAmt = RO_totamt_p03;
                            RO_paytotWT = RO_totwt_p03;
                            if (RO_totwt_p03 > 0)
                            {
                                RO_paytotYld = RO_totyield_p03 / RO_totwt_p03;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P04")
                        {
                            RO_paytotdkt = RO_totdkts_p04;
                            RO_paytotAmt = RO_totamt_p04;
                            RO_paytotWT = RO_totwt_p04;
                            if (totwt_p04 > 0)
                            {
                                RO_paytotYld = RO_totyield_p04 / RO_totwt_p04;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P06")
                        {
                            RO_paytotdkt = RO_totdkts_p06;
                            RO_paytotAmt = RO_totamt_p06;
                            RO_paytotWT = RO_totwt_p06;
                            if (totwt_p06 > 0)
                            {
                                RO_paytotYld = RO_totyield_p06 / RO_totwt_p06;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P07")
                        {
                            RO_paytotdkt = RO_totdkts_p07;
                            RO_paytotAmt = RO_totamt_p07;
                            RO_paytotWT = RO_totwt_p07;
                            if (totwt_p07 > 0)
                            {
                                RO_paytotYld = RO_totyield_p07 /RO_totwt_p07;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P08")
                        {
                            RO_paytotdkt = RO_totdkts_p08;
                            RO_paytotAmt = RO_totamt_p08;
                            RO_paytotWT = RO_totwt_p08;
                            if (totwt_p08 > 0)
                            {
                                RO_paytotYld = RO_totyield_p08 / RO_totwt_p08;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P09")
                        {
                            RO_paytotdkt = RO_totdkts_p09;
                            RO_paytotAmt = RO_totamt_p09;
                            RO_paytotWT = RO_totwt_p09;
                            if (totwt_p09 > 0)
                            {
                                RO_paytotYld = RO_totyield_p09 / RO_totwt_p09;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
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
                            abc = "Y";
                        }
                        else if (TrnlistArr[rl] == "2")
                        {
                            RO_paytotdkt = RO_totdkts_p02;
                            RO_paytotAmt = RO_totamt_p02;
                            RO_paytotWT = RO_totwt_p02;
                            if (totwt_p02 > 0)
                            {
                                RO_paytotYld = RO_totyield_p02 / RO_totwt_p02;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (TrnlistArr[rl] == "3")
                        {
                            RO_paytotdkt = RO_totdkts_p03;
                            RO_paytotAmt = RO_totamt_p03;
                            RO_paytotWT = RO_totwt_p03;
                            if (RO_totwt_p03 > 0)
                            {
                                RO_paytotYld = RO_totyield_p03 / RO_totwt_p03;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                            abc = "Y";
                        }
                        else if (TrnlistArr[rl] == "4")
                        {
                            RO_paytotdkt = RO_totdkts_p04;
                            RO_paytotAmt = RO_totamt_p04;
                            RO_paytotWT = RO_totwt_p04;
                            if (totwt_p04 > 0)
                            {
                                RO_paytotYld = RO_totyield_p04 / RO_totwt_p04;
                            }
                            else
                            {
                                RO_paytotYld = 0;
                            }
                            abc = "Y";
                            abc = "Y";
                        }
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
            tr2b.BackColor = System.Drawing.Color.White;
            TBL_MonthlySales.Rows.Add(tr2b);

            TableRow tr2d = new TableRow();

            TableCell tr2dtc2 = new TableCell();
           
            tr2dtc2.Text = "";
            tr2dtc2.CssClass = "blackfnt";
            tr2dtc2.Wrap = false;
            tr2dtc2.ColumnSpan = ((SencodrowL - 1) * loopint * 4) + 4 + 2;
           
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
                    if (Subtyp == "1")
                    {
                        if (PaybasListArr[rl] == "All")
                        {

                        }
                        else if (PaybasListArr[rl] == "P01")
                        {
                            paytotdkt = totdkts_p01;
                            paytotAmt = totamt_p01;
                            paytotWT = totwt_p01;
                            if (totwt_p01 > 0)
                            {
                                paytotYld = totyield_p01 / totwt_p01;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P02")
                        {
                            paytotdkt = totdkts_p02;
                            paytotAmt = totamt_p02;
                            paytotWT = totwt_p02;
                            if (totwt_p02 > 0)
                            {
                                paytotYld = totyield_p02 / totwt_p02;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P03")
                        {
                            paytotdkt = totdkts_p03;
                            paytotAmt = totamt_p03;
                            paytotWT = totwt_p03;
                            if (totwt_p03 > 0)
                            {
                                paytotYld = totyield_p03 / totwt_p03;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P04")
                        {
                            paytotdkt = totdkts_p04;
                            paytotAmt = totamt_p04;
                            paytotWT = totwt_p04;
                            if (totwt_p04 > 0)
                            {
                                paytotYld = totyield_p04 / totwt_p04;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P06")
                        {
                            paytotdkt = totdkts_p06;
                            paytotAmt = totamt_p06;
                            paytotWT = totwt_p06;
                            if (totwt_p06 > 0)
                            {
                                paytotYld = totyield_p06 / totwt_p06;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P07")
                        {
                            paytotdkt = totdkts_p07;
                            paytotAmt = totamt_p07;
                            paytotWT = totwt_p07;
                            if (totwt_p07 > 0)
                            {
                                paytotYld = totyield_p07 / totwt_p07;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P08")
                        {
                            paytotdkt = totdkts_p08;
                            paytotAmt = totamt_p08;
                            paytotWT = totwt_p08;
                            if (totwt_p08 > 0)
                            {
                                paytotYld = totyield_p08 / totwt_p08;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (PaybasListArr[rl] == "P09")
                        {
                            paytotdkt = totdkts_p09;
                            paytotAmt = totamt_p09;
                            paytotWT = totwt_p09;
                            if (totwt_p09 > 0)
                            {
                                paytotYld = totyield_p09 / totwt_p09;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
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
                            paytotdkt = totdkts_p01;
                            paytotAmt = totamt_p01;
                            paytotWT = totwt_p01;
                            if (totwt_p01 > 0)
                            {
                                paytotYld = totyield_p01 / totwt_p01;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (TrnlistArr[rl] == "2")
                        {
                            paytotdkt = totdkts_p02;
                            paytotAmt = totamt_p02;
                            paytotWT = totwt_p02;
                            if (totwt_p02 > 0)
                            {
                                paytotYld = totyield_p02 / totwt_p02;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (TrnlistArr[rl] == "3")
                        {
                            paytotdkt = totdkts_p03;
                            paytotAmt = totamt_p03;
                            paytotWT = totwt_p03;
                            if (totwt_p03 > 0)
                            {
                                paytotYld = totyield_p03 / totwt_p03;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
                        else if (TrnlistArr[rl] == "4")
                        {
                            paytotdkt = totdkts_p04;
                            paytotAmt = totamt_p04;
                            paytotWT = totwt_p04;
                            if (totwt_p04 > 0)
                            {
                                paytotYld = totyield_p04 / totwt_p04;
                            }
                            else
                            {
                                paytotYld = 0;
                            }
                            abc = "Y";
                        }
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
                    //}
                }
            }
            tr2c.CssClass = "bluefnt";
            tr2c.Font.Bold = true;
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
          
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Monthaly_Sales.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            //DipsplayReport();
            BindGrid();
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
