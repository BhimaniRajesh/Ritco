using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Data.SqlClient;
using System.IO;

public partial class GUI_UNI_MIS_Account_Reports_Trail_bal_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string RO, LO, custcd, empcd, ACC_cd,Cumulative, vendcd, TYP_CD, RO_TO, LO_TO, Rtyp, View_Sales, DateType, st_paybasis, st_status, st_custcd, st_type, st_trnmod, fromdt, todt, st_Docnolist, select_list, select_Text, st_doctyp;
    public static string lv, RPT_flag,DWN_XLS, YearString, yearSuffix, finyearstart, strFinalQS = "", mHeadOfficeCode;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            
           

            DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            if (DWN_XLS == "Y")
            {
               // Response.ContentType = "application/vnd.ms-excel";
               // Response.AddHeader("content-disposition", "attachment; filename=Trail_balance.xls");

                XLS_DWN();
            }
            else
            {
                BindGrid();
            }
        }
    }
    public void XLS_DWN()
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;

            TBL_TB.BorderStyle =  BorderStyle.Double;
            TBL_TB.BorderWidth = 1;
            

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Trail_balance.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            //DipsplayReport();
            BindGrid();
            //GV_Booking.RenderControl(hw);
            TBL_TB.RenderControl(hw);
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

    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        DateType = Request.QueryString["report_mode"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        Rtyp = Request.QueryString["Rtyp"].ToString();
        TYP_CD = Request.QueryString["TYP_CD"].ToString();
        ACC_cd = Request.QueryString["ACC_cd"].ToString();
        Cumulative = Request.QueryString["Cumulative"].ToString();
        RO = Request.QueryString["RO"].ToString();
       
        LBLDATE.Text = fromdt + " - " + todt;
        if (Cumulative == "Y")
        {
            LBLRPT.Text = "Cumulative (Including All Branches)";
        }
        else
        {
            LBLRPT.Text = "Individual";
        }
        LBLBRANCH.Text = RO;

        if (Rtyp == "1")
        {
            LBLSUBRPT.Text = "Ledger Wise ";

        }
        else if (Rtyp == "2")
        {
            LBLSUBRPT.Text = "Customer Wise - " + TYP_CD;
        }
        else if (Rtyp == "3")
        {
            LBLSUBRPT.Text = "Vendor Wise - " + TYP_CD;
        }
        else if (Rtyp == "4")
        {
            LBLSUBRPT.Text = "Employee Wise - " + TYP_CD;
        }



        YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
        finyearstart = "01 APR " + YearString;
        yrstartdt = Convert.ToDateTime(finyearstart);
        mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
         SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        try
        {
            // string SQL_TB = "exec Webx_Trail_Balance_ver1 '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','','" + RO + "','" + Rtyp + "','%" + ACC_cd + "%','%" + TYP_CD + "%'";
            string SQL_TB = "exec Webx_Trail_Balance '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','','" + RO + "','1','" + ACC_cd + "','" + TYP_CD + "'";
           // Response.Write("<BR> SQL_TB : " + SQL_TB);
            Rtyp = "1";
            SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
            sqlcmd12.Transaction = trans;
            SqlDataReader dr;
            dr = sqlcmd12.ExecuteReader();
            //SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            //DataSet ds = new DataSet();
            //da.Fill(ds);
            //dgDocket.DataSource = ds;
            //dgDocket.DataBind();
            //dgDocket.Visible = true;

            TableRow tr = new TableRow();

            TableCell tc2 = new TableCell();
            TableCell tc1 = new TableCell();
            TableCell tc2a = new TableCell();
            TableCell tc3 = new TableCell();

            TableCell tc4 = new TableCell();
            TableCell tc5 = new TableCell();
            TableCell tc6 = new TableCell();

            TableCell tc7 = new TableCell();
            TableCell tc8 = new TableCell();
            TableCell tc9 = new TableCell();

            if (Rtyp == "1")
            {
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

                tc2a.Text = "Sub Group 1";
                tc2a.CssClass = "blackfnt";
                tc2a.Wrap = false;
                tr.CssClass = "bgbluegrey";
                tr.Cells.Add(tc2a);

                tc3.Text = "Account Name";
                tc3.CssClass = "blackfnt";
                tc3.Wrap = false;
                tr.CssClass = "bgbluegrey";
                tr.Cells.Add(tc3);
            }
            else if (Rtyp == "2" || Rtyp == "3" || Rtyp == "4")
            {
                if (Rtyp == "2")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.CssClass = "bgbluegrey";
                    tr.Cells.Add(tc1);

                    tc2.Text = "Customer";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.CssClass = "bgbluegrey";
                    tr.Cells.Add(tc2);
                }
                else if (Rtyp == "3")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.CssClass = "bgbluegrey";
                    tr.Cells.Add(tc1);

                    tc2.Text = "Vendor";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.CssClass = "bgbluegrey";
                    tr.Cells.Add(tc2);
                }
                else if (Rtyp == "4")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.CssClass = "bgbluegrey";
                    tr.Cells.Add(tc1);

                    tc2.Text = "Employee";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.CssClass = "bgbluegrey";
                    tr.Cells.Add(tc2);
                }
            }
            else if (Rtyp == "5")
            {
                tc1.Text = "Location";
                tc1.CssClass = "blackfnt";
                tc1.Wrap = false;
                tr.CssClass = "bgbluegrey";
                tr.Cells.Add(tc1);

                tc2.Text = "Account";
                tc2.CssClass = "blackfnt";
                tc2.Wrap = false;
                tr.CssClass = "bgbluegrey";
                tr.Cells.Add(tc2);
            }

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

            TBL_TB.Rows.Add(tr);
            string FL_OPN = "N", FL_CURR = "N", FL_CLOSE = "N";
            string mGroupDesc = "", PremGroupDesc = "", mMainGroup = "";
            string mSubGroupDesc = "", PremSubGroupDesc = "";
            double OPN_Dr = 0, OPN_Cr = 0, CURR_Dr = 0, CURR_Cr = 0, CLOSE_Dr = 0, CLOSE_Cr = 0;
            double DIFF_OPN_Dr = 0, DIFF_OPN_Cr = 0, DIFF_CURR_Dr = 0, DIFF_CURR_Cr = 0, DIFF_CLOSE_Dr = 0, DIFF_CLOSE_Cr = 0;
            double TOT_OPN_Dr = 0, TOT_OPN_Cr = 0, TOT_CURR_Dr = 0, TOT_CURR_Cr = 0, TOT_CLOSE_Dr = 0, TOT_CLOSE_Cr = 0;
            double RO_TOT_OPN_Dr = 0, RO_TOT_OPN_Cr = 0, RO_TOT_CURR_Dr = 0, RO_TOT_CURR_Cr = 0, RO_TOT_CLOSE_Dr = 0, RO_TOT_CLOSE_Cr = 0;
            int i = 1;
            while (dr.Read())
            {
                FL_OPN = "N";
                FL_CURR = "N";
                FL_CLOSE = "N";



                OPN_Dr = Convert.ToDouble(dr["opn_DR"].ToString());
                OPN_Cr = Convert.ToDouble(dr["opn_CR"].ToString());
                CURR_Dr = Convert.ToDouble(dr["TR_TRANS_DR"].ToString());
                CURR_Cr = Convert.ToDouble(dr["TR_TRANS_CR"].ToString());
                CLOSE_Dr = Convert.ToDouble(dr["opn_DR"].ToString()) + Convert.ToDouble(dr["TR_TRANS_DR"].ToString());
                CLOSE_Cr = Convert.ToDouble(dr["opn_CR"].ToString()) + Convert.ToDouble(dr["TR_TRANS_CR"].ToString());
                if (OPN_Dr > OPN_Cr)
                {
                    OPN_Dr = OPN_Dr - OPN_Cr;
                    OPN_Cr = 0;
                }
                else
                {
                    OPN_Cr = OPN_Cr - OPN_Dr;
                    OPN_Dr = 0;
                }

                if (OPN_Cr > 0 || OPN_Dr > 0)
                {
                    FL_OPN = "Y";
                }

                if (CURR_Dr > 0 || CURR_Cr > 0)
                {
                    FL_CURR = "Y";
                }
                if (CLOSE_Dr > CLOSE_Cr)
                {
                    CLOSE_Dr = CLOSE_Dr - CLOSE_Cr;
                    CLOSE_Cr = 0;
                }
                else
                {
                    CLOSE_Cr = CLOSE_Cr - CLOSE_Dr;
                    CLOSE_Dr = 0;
                }

                if (CLOSE_Cr > 0 || CLOSE_Dr > 0)
                {
                    FL_CLOSE = "Y";
                }




                if (FL_CLOSE == "Y" || FL_CURR == "Y" || FL_OPN == "Y")
                 {



                    if (Rtyp == "1")
                    {
                        mGroupDesc = dr["CAT"].ToString();
                        mSubGroupDesc = dr["groupdesc_m"].ToString();


                        if (mSubGroupDesc != PremSubGroupDesc && PremSubGroupDesc != "")
                        {

                            TableRow tr1a = new TableRow();

                            TableCell tr1atc1 = new TableCell();
                            TableCell tr1atc2 = new TableCell();
                            TableCell tr1atc2a = new TableCell();
                            TableCell tr1atc3 = new TableCell();

                            TableCell tr1atc4 = new TableCell();
                            TableCell tr1atc5 = new TableCell();
                            TableCell tr1atc6 = new TableCell();

                            TableCell tr1atc7 = new TableCell();
                            TableCell tr1atc8 = new TableCell();
                            TableCell tr1atc9 = new TableCell();


                            tr1atc1.Text = "";
                            tr1atc1.CssClass = "blackfnt";
                            tr1atc1.Wrap = false;

                            tr1a.Cells.Add(tr1atc1);
                            tr1atc2.Text = "Total " + PremSubGroupDesc;
                            tr1atc2.CssClass = "blackfnt";
                            tr1atc2.Font.Bold = true;
                            tr1atc2.ColumnSpan = 2;
                            tr1atc2.Wrap = false;

                            tr1a.Cells.Add(tr1atc2);



                            tr1atc3.Text = "";
                            tr1atc3.Wrap = false;
                            tr1atc3.CssClass = "blackfnt";
                            tr1atc3.Font.Bold = true;
                            tr1a.Cells.Add(tr1atc3);

                            tr1atc4.Text = RO_TOT_OPN_Dr.ToString("F2");
                            tr1atc4.HorizontalAlign = HorizontalAlign.Right;
                            tr1atc4.CssClass = "blackfnt";
                            tr1atc4.Wrap = false;
                            tr1atc4.Font.Bold = true;
                            tr1a.Cells.Add(tr1atc4);

                            tr1atc5.Text = RO_TOT_OPN_Cr.ToString("F2");
                            tr1atc5.HorizontalAlign = HorizontalAlign.Right;
                            tr1atc5.CssClass = "blackfnt";
                            tr1atc5.Wrap = false;
                            tr1atc5.Font.Bold = true;
                            tr1a.Cells.Add(tr1atc5);

                            tr1atc6.Text = RO_TOT_CURR_Dr.ToString("F2");
                            tr1atc6.HorizontalAlign = HorizontalAlign.Right;
                            tr1atc6.Font.Bold = true;
                            tr1atc6.Wrap = false;
                            tr1atc6.CssClass = "blackfnt";
                            tr1a.Cells.Add(tr1atc6);

                            tr1atc7.Text = RO_TOT_CURR_Cr.ToString("F2");
                            tr1atc7.HorizontalAlign = HorizontalAlign.Right;
                            tr1atc7.CssClass = "blackfnt";
                            tr1atc7.Wrap = false;
                            tr1atc7.Font.Bold = true;
                            tr1a.Cells.Add(tr1atc7);

                            tr1atc8.Text = RO_TOT_CLOSE_Dr.ToString("F2");
                            tr1atc8.HorizontalAlign = HorizontalAlign.Right;
                            tr1atc8.CssClass = "blackfnt";
                            tr1atc8.Wrap = false;
                            tr1atc8.Font.Bold = true;
                            tr1a.Cells.Add(tr1atc8);

                            tr1atc9.Text = RO_TOT_CLOSE_Cr.ToString("F2");
                            tr1atc9.HorizontalAlign = HorizontalAlign.Right;
                            tr1atc9.CssClass = "blackfnt";
                            tr1atc9.Wrap = false;
                            tr1atc9.Font.Bold = true;
                            tr1a.CssClass = "bgbluegrey";
                            tr1a.Cells.Add(tr1atc9);
                            tr1a.Font.Bold = true;
                            //tr1a.BackColor = System.Drawing.Color.White;
                            TBL_TB.Rows.Add(tr1a);

                            RO_TOT_OPN_Dr = 0;
                            RO_TOT_OPN_Cr = 0;
                            RO_TOT_CURR_Dr = 0;
                            RO_TOT_CURR_Cr = 0;
                            RO_TOT_CLOSE_Dr = 0;
                            RO_TOT_CLOSE_Cr = 0;
                        }

                    }




                    TableRow tr1 = new TableRow();

                    TableCell Tr1tc1 = new TableCell();
                    TableCell Tr1tc2 = new TableCell();
                    TableCell Tr1tc2a = new TableCell();
                    TableCell Tr1tc3 = new TableCell();

                    TableCell Tr1tc4 = new TableCell();
                    TableCell Tr1tc5 = new TableCell();
                    TableCell Tr1tc6 = new TableCell();

                    TableCell Tr1tc7 = new TableCell();
                    TableCell Tr1tc8 = new TableCell();
                    TableCell Tr1tc9 = new TableCell();

                    if (Rtyp == "1")
                    {
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
                            else if (mGroupDesc == "BAN")
                            {
                                mMainGroup = "BANK";
                            }
                            else if (mGroupDesc == "CAS")
                            {
                                mMainGroup = "CASH";
                            }
                            Tr1tc1.Text = mMainGroup;
                            Tr1tc1.Font.Bold = true;
                        }
                        else
                        {
                            Tr1tc1.Text = "";
                        }
                        Tr1tc1.CssClass = "blackfnt";
                        Tr1tc1.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc1);



                        if (mSubGroupDesc != PremSubGroupDesc)
                        {

                            Tr1tc2.Text = dr["groupdesc_m"].ToString();
                        }
                        else
                        {
                            Tr1tc2.Text = "";
                        }
                        Tr1tc2.CssClass = "blackfnt";
                        Tr1tc2.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc2);

                        if (mSubGroupDesc != dr["groupdesc"].ToString())
                        {
                            Tr1tc2a.Text = dr["groupdesc"].ToString();
                        }
                        else
                        {
                            Tr1tc2a.Text = "";
                        }
                        Tr1tc2a.CssClass = "blackfnt";
                        Tr1tc2a.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc2a);
                        string ST_ACCCD = dr["acccode"].ToString();
                        string ST_DWN_XLS = "N";
                        string dirlldown = "branch=" + RO + "&ACCODE=" + ST_ACCCD + "&Rtyp=" + Rtyp + "&dateFrom=" + fromdt + "&dateTo=" + todt + "&Cumlative=" + Cumulative + "&TYP_CD=" + TYP_CD + "&DWN_XLS=" + ST_DWN_XLS;

                        Tr1tc3.Text = "<a href='Result_GL.aspx?" + dirlldown + "'><u>" + dr["acccdesc"].ToString() + "</u></a>";
                        Tr1tc3.CssClass = "blackfnt";
                        Tr1tc3.Wrap = false;
                        // tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc3);
                    }
                    else if (Rtyp == "5")
                    {
                        Tr1tc1.Text = dr["brcd"].ToString();
                        Tr1tc1.CssClass = "blackfnt";
                        Tr1tc1.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc1);

                        Tr1tc2.Text = dr["RP_CD"].ToString() + " : " + dr["RP_NM"].ToString();
                        Tr1tc2.CssClass = "blackfnt";
                        Tr1tc2.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc2);

                    }
                    else if (Rtyp == "2" || Rtyp == "3" || Rtyp == "4")
                    {
                        Tr1tc1.Text = i.ToString();
                        Tr1tc1.CssClass = "blackfnt";
                        Tr1tc1.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc1);


                        Tr1tc2.Text = dr["RP_CD"].ToString() + " : " + dr["RP_NM"].ToString();
                        Tr1tc2.CssClass = "blackfnt";
                        Tr1tc2.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc2);

                    }


                    Tr1tc4.Text = OPN_Dr.ToString("F2");
                    Tr1tc4.CssClass = "blackfnt";
                    Tr1tc4.HorizontalAlign = HorizontalAlign.Right;
                    Tr1tc4.Wrap = false;
                    // tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(Tr1tc4);

                    Tr1tc5.Text = OPN_Cr.ToString("F2");
                    Tr1tc5.CssClass = "blackfnt";
                    Tr1tc5.Wrap = false;
                    Tr1tc5.HorizontalAlign = HorizontalAlign.Right;
                    //tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(Tr1tc5);

                    Tr1tc6.Text = CURR_Dr.ToString("F2");
                    Tr1tc6.CssClass = "blackfnt";
                    Tr1tc6.Wrap = false;
                    Tr1tc6.HorizontalAlign = HorizontalAlign.Right;
                    tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(Tr1tc6);


                    Tr1tc7.Text = CURR_Cr.ToString("F2");
                    Tr1tc7.CssClass = "blackfnt";
                    Tr1tc7.Wrap = false;
                    Tr1tc7.HorizontalAlign = HorizontalAlign.Right;
                    // tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(Tr1tc7);

                    Tr1tc8.Text = CLOSE_Dr.ToString("F2");
                    Tr1tc8.CssClass = "blackfnt";
                    Tr1tc8.Wrap = false;
                    Tr1tc8.HorizontalAlign = HorizontalAlign.Right;
                    //tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(Tr1tc8);

                    Tr1tc9.Text = CLOSE_Cr.ToString("F2");
                    Tr1tc9.CssClass = "blackfnt";
                    Tr1tc9.Wrap = false;
                    Tr1tc9.HorizontalAlign = HorizontalAlign.Right;
                    //tr1.CssClass = "bgbluegrey";
                    tr1.Cells.Add(Tr1tc9);

                    tr1.BackColor = System.Drawing.Color.White;
                    TBL_TB.Rows.Add(tr1);

                    if (Rtyp == "1")
                    {
                        PremGroupDesc = dr["CAT"].ToString();
                        PremSubGroupDesc = dr["groupdesc_m"].ToString();
                    }

                    TOT_OPN_Dr += OPN_Dr;
                    TOT_OPN_Cr += OPN_Cr;
                    TOT_CURR_Dr += CURR_Dr;
                    TOT_CURR_Cr += CURR_Cr;
                    TOT_CLOSE_Dr += CLOSE_Dr;
                    TOT_CLOSE_Cr += CLOSE_Cr;

                    RO_TOT_OPN_Dr += OPN_Dr;
                    RO_TOT_OPN_Cr += OPN_Cr;
                    RO_TOT_CURR_Dr += CURR_Dr;
                    RO_TOT_CURR_Cr += CURR_Cr;
                    RO_TOT_CLOSE_Dr += CLOSE_Dr;
                    RO_TOT_CLOSE_Cr += CLOSE_Cr;

                    i += 1;
                }

            }

            if (Rtyp == "1")
            {
                TableRow tr1b = new TableRow();

                TableCell tr1btc1 = new TableCell();
                TableCell tr1btc2 = new TableCell();
                TableCell tr1btc3 = new TableCell();

                TableCell tr1btc4 = new TableCell();
                TableCell tr1btc5 = new TableCell();
                TableCell tr1btc6 = new TableCell();

                TableCell tr1btc7 = new TableCell();
                TableCell tr1btc8 = new TableCell();
                TableCell tr1btc9 = new TableCell();


                tr1btc1.Text = "";
                tr1btc1.CssClass = "blackfnt";
                tr1btc1.Wrap = false;

                tr1b.Cells.Add(tr1btc1);
                tr1btc2.Text = "Total " + mSubGroupDesc;
                tr1btc2.CssClass = "blackfnt";
                tr1btc2.Font.Bold = true;
                tr1btc2.ColumnSpan = 2;
                tr1btc2.Wrap = false;

                tr1b.Cells.Add(tr1btc2);
                tr1btc3.Text = "";
                tr1btc3.Wrap = false;
                tr1btc3.CssClass = "blackfnt";
                tr1btc3.Font.Bold = true;
                tr1b.Cells.Add(tr1btc3);

                tr1btc4.Text = RO_TOT_OPN_Dr.ToString("F2");
                tr1btc4.HorizontalAlign = HorizontalAlign.Right;
                tr1btc4.CssClass = "blackfnt";
                tr1btc4.Wrap = false;
                tr1btc4.Font.Bold = true;
                tr1b.Cells.Add(tr1btc4);

                tr1btc5.Text = RO_TOT_OPN_Cr.ToString("F2");
                tr1btc5.HorizontalAlign = HorizontalAlign.Right;
                tr1btc5.CssClass = "blackfnt";
                tr1btc5.Wrap = false;
                tr1btc5.Font.Bold = true;
                tr1b.Cells.Add(tr1btc5);

                tr1btc6.Text = RO_TOT_CURR_Dr.ToString("F2");
                tr1btc6.HorizontalAlign = HorizontalAlign.Right;
                tr1btc6.Font.Bold = true;
                tr1btc6.Wrap = false;
                tr1btc6.CssClass = "blackfnt";
                tr1b.Cells.Add(tr1btc6);

                tr1btc7.Text = RO_TOT_CURR_Cr.ToString("F2");
                tr1btc7.HorizontalAlign = HorizontalAlign.Right;
                tr1btc7.CssClass = "blackfnt";
                tr1btc7.Wrap = false;
                tr1btc7.Font.Bold = true;
                tr1b.Cells.Add(tr1btc7);

                tr1btc8.Text = RO_TOT_CLOSE_Dr.ToString("F2");
                tr1btc8.HorizontalAlign = HorizontalAlign.Right;
                tr1btc8.CssClass = "blackfnt";
                tr1btc8.Wrap = false;
                tr1btc8.Font.Bold = true;
                tr1b.Cells.Add(tr1btc8);

                tr1btc9.Text = RO_TOT_CLOSE_Cr.ToString("F2");
                tr1btc9.HorizontalAlign = HorizontalAlign.Right;
                tr1btc9.CssClass = "blackfnt";
                tr1btc9.Wrap = false;
                tr1btc9.Font.Bold = true;
                tr1b.CssClass = "bgbluegrey";
                tr1b.Cells.Add(tr1btc9);
                tr1b.Font.Bold = true;
                //tr1b.BackColor = System.Drawing.Color.White;
                TBL_TB.Rows.Add(tr1b);
            }


            TableRow tr1c = new TableRow();

            TableCell tr1ctc1 = new TableCell();
            TableCell tr1ctc2 = new TableCell();
            TableCell tr1ctc3 = new TableCell();

            TableCell tr1ctc4 = new TableCell();
            TableCell tr1ctc5 = new TableCell();
            TableCell tr1ctc6 = new TableCell();

            TableCell tr1ctc7 = new TableCell();
            TableCell tr1ctc8 = new TableCell();
            TableCell tr1ctc9 = new TableCell();

            if (Rtyp == "1")
            {
                tr1ctc1.Text = "";
                tr1ctc1.CssClass = "blackfnt";
                tr1ctc1.Wrap = false;

                tr1c.Cells.Add(tr1ctc1);
                tr1ctc2.Text = "";
                tr1ctc2.CssClass = "blackfnt";
                tr1ctc2.ColumnSpan = 2;
                tr1ctc2.Font.Bold = true;
                tr1ctc2.Wrap = false;

                tr1c.Cells.Add(tr1ctc2);
                tr1ctc3.Text = "Diff in Balances";
                tr1ctc3.Wrap = false;
                tr1ctc3.CssClass = "blackfnt";
                tr1ctc3.Font.Bold = true;
                tr1c.Cells.Add(tr1ctc3);
            }
            else if (Rtyp == "2" || Rtyp == "3" || Rtyp == "4")
            {
                tr1ctc2.Text = "Total ";
                tr1ctc2.CssClass = "blackfnt";
                tr1ctc2.Font.Bold = true;
                tr1ctc2.Wrap = false;
                tr1ctc2.ColumnSpan = 2;
                tr1c.Cells.Add(tr1ctc2);
            }
            else if (Rtyp == "5")
            {


                tr1ctc2.Text = "Total ";
                tr1ctc2.CssClass = "blackfnt";
                tr1ctc2.Font.Bold = true;
                tr1ctc2.Wrap = false;
                tr1ctc2.ColumnSpan = 2;
                tr1c.Cells.Add(tr1ctc2);
            }

            if (TOT_OPN_Dr > TOT_OPN_Cr)
            {
                DIFF_OPN_Dr = TOT_OPN_Dr - TOT_OPN_Cr;
                DIFF_OPN_Cr = 0;
            }
            else if (TOT_OPN_Cr > TOT_OPN_Dr)
            {
                DIFF_OPN_Dr = 0;
                DIFF_OPN_Cr = TOT_OPN_Cr - TOT_OPN_Dr;
            }
            else
            {
                DIFF_OPN_Dr = 0;
                DIFF_OPN_Cr = 0;
            }


            tr1ctc4.Text = DIFF_OPN_Cr.ToString("F2");
            tr1ctc4.HorizontalAlign = HorizontalAlign.Right;
            tr1ctc4.CssClass = "blackfnt";
            tr1ctc4.Wrap = false;
            tr1ctc4.Font.Bold = true;
            tr1c.Cells.Add(tr1ctc4);

            tr1ctc5.Text = DIFF_OPN_Dr.ToString("F2");
            tr1ctc5.HorizontalAlign = HorizontalAlign.Right;
            tr1ctc5.CssClass = "blackfnt";
            tr1ctc5.Wrap = false;
            tr1ctc5.Font.Bold = true;
            tr1c.Cells.Add(tr1ctc5);

            if (TOT_CURR_Dr > TOT_CURR_Cr)
            {
                DIFF_CURR_Dr = TOT_CURR_Dr - TOT_CURR_Cr;
                DIFF_CURR_Cr = 0;
            }
            else if (TOT_CURR_Cr > TOT_CURR_Dr)
            {
                DIFF_CURR_Dr = 0;
                DIFF_CURR_Cr = TOT_CURR_Cr - TOT_CURR_Dr;
            }
            else
            {
                DIFF_CURR_Dr = 0;
                DIFF_CURR_Cr = 0;
            }


            tr1ctc6.Text = DIFF_CURR_Cr.ToString("F2");
            tr1ctc6.HorizontalAlign = HorizontalAlign.Right;
            tr1ctc6.Font.Bold = true;
            tr1ctc6.Wrap = false;
            tr1ctc6.CssClass = "blackfnt";
            tr1c.Cells.Add(tr1ctc6);

            tr1ctc7.Text = DIFF_CURR_Dr.ToString("F2");
            tr1ctc7.HorizontalAlign = HorizontalAlign.Right;
            tr1ctc7.CssClass = "blackfnt";
            tr1ctc7.Wrap = false;
            tr1ctc7.Font.Bold = true;
            tr1c.Cells.Add(tr1ctc7);

            if (TOT_CLOSE_Dr > TOT_CLOSE_Cr)
            {
                DIFF_CLOSE_Dr = TOT_CLOSE_Dr - TOT_CLOSE_Cr;
                DIFF_CLOSE_Cr = 0;
            }
            else if (TOT_CURR_Cr > TOT_CLOSE_Dr)
            {
                DIFF_CLOSE_Dr = 0;
                DIFF_CLOSE_Cr = TOT_CLOSE_Cr - TOT_CLOSE_Dr;
            }
            else
            {
                DIFF_CLOSE_Dr = 0;
                DIFF_CLOSE_Cr = 0;
            }

            tr1ctc8.Text = DIFF_CLOSE_Cr.ToString("F2");
            tr1ctc8.HorizontalAlign = HorizontalAlign.Right;
            tr1ctc8.CssClass = "blackfnt";
            tr1ctc8.Wrap = false;
            tr1ctc8.Font.Bold = true;
            tr1c.Cells.Add(tr1ctc8);

            tr1ctc9.Text = DIFF_CLOSE_Dr.ToString("F2");
            tr1ctc9.HorizontalAlign = HorizontalAlign.Right;
            tr1ctc9.CssClass = "blackfnt";
            tr1ctc9.Wrap = false;
            tr1ctc9.Font.Bold = true;
            tr1c.CssClass = "bgbluegrey";
            tr1c.Cells.Add(tr1ctc9);
            tr1c.Font.Bold = true;
            //tr1c.BackColor = System.Drawing.Color.White;
            TBL_TB.Rows.Add(tr1c);

            TableRow tr1d = new TableRow();

            TableCell tr1dtc1 = new TableCell();
            TableCell tr1dtc2 = new TableCell();
            TableCell tr1dtc3 = new TableCell();

            TableCell tr1dtc4 = new TableCell();
            TableCell tr1dtc5 = new TableCell();
            TableCell tr1dtc6 = new TableCell();

            TableCell tr1dtc7 = new TableCell();
            TableCell tr1dtc8 = new TableCell();
            TableCell tr1dtc9 = new TableCell();

            if (Rtyp == "1")
            {
                tr1dtc1.Text = "";
                tr1dtc1.CssClass = "blackfnt";
                tr1dtc1.Wrap = false;

                tr1d.Cells.Add(tr1dtc1);
                tr1dtc2.Text = "";
                tr1dtc2.CssClass = "blackfnt";
                tr1dtc2.ColumnSpan = 2;
                tr1dtc2.Font.Bold = true;
                tr1dtc2.Wrap = false;

                tr1d.Cells.Add(tr1dtc2);
                tr1dtc3.Text = "Total";
                tr1dtc3.Wrap = false;
                tr1dtc3.CssClass = "blackfnt";
                tr1dtc3.Font.Bold = true;
                tr1d.Cells.Add(tr1dtc3);
            }
            else if (Rtyp == "2" || Rtyp == "3" || Rtyp == "4")
            {
                tr1dtc2.Text = "Total ";
                tr1dtc2.CssClass = "blackfnt";
                tr1dtc2.Font.Bold = true;
                tr1dtc2.Wrap = false;
                tr1dtc2.ColumnSpan = 2;
                tr1d.Cells.Add(tr1dtc2);
            }
            else if (Rtyp == "5")
            {


                tr1dtc2.Text = "Total ";
                tr1dtc2.CssClass = "blackfnt";
                tr1dtc2.Font.Bold = true;
                tr1dtc2.Wrap = false;
                tr1dtc2.ColumnSpan = 2;
                tr1d.Cells.Add(tr1dtc2);
            }


            tr1dtc4.Text = TOT_OPN_Dr.ToString("F2");
            tr1dtc4.HorizontalAlign = HorizontalAlign.Right;
            tr1dtc4.CssClass = "blackfnt";
            tr1dtc4.Wrap = false;
            tr1dtc4.Font.Bold = true;
            tr1d.Cells.Add(tr1dtc4);

            tr1dtc5.Text = TOT_OPN_Cr.ToString("F2");
            tr1dtc5.HorizontalAlign = HorizontalAlign.Right;
            tr1dtc5.CssClass = "blackfnt";
            tr1dtc5.Wrap = false;
            tr1dtc5.Font.Bold = true;
            tr1d.Cells.Add(tr1dtc5);

            tr1dtc6.Text = TOT_CURR_Dr.ToString("F2");
            tr1dtc6.HorizontalAlign = HorizontalAlign.Right;
            tr1dtc6.Font.Bold = true;
            tr1dtc6.Wrap = false;
            tr1dtc6.CssClass = "blackfnt";
            tr1d.Cells.Add(tr1dtc6);

            tr1dtc7.Text = TOT_CURR_Cr.ToString("F2");
            tr1dtc7.HorizontalAlign = HorizontalAlign.Right;
            tr1dtc7.CssClass = "blackfnt";
            tr1dtc7.Wrap = false;
            tr1dtc7.Font.Bold = true;
            tr1d.Cells.Add(tr1dtc7);

            tr1dtc8.Text = TOT_CLOSE_Dr.ToString("F2");
            tr1dtc8.HorizontalAlign = HorizontalAlign.Right;
            tr1dtc8.CssClass = "blackfnt";
            tr1dtc8.Wrap = false;
            tr1dtc8.Font.Bold = true;
            tr1d.Cells.Add(tr1dtc8);

            tr1dtc9.Text = TOT_CLOSE_Cr.ToString("F2");
            tr1dtc9.HorizontalAlign = HorizontalAlign.Right;
            tr1dtc9.CssClass = "blackfnt";
            tr1dtc9.Wrap = false;
            tr1dtc9.Font.Bold = true;
            tr1d.CssClass = "bgbluegrey";
            tr1d.Cells.Add(tr1dtc9);
            tr1d.Font.Bold = true;
            //tr1d.BackColor = System.Drawing.Color.White;
            TBL_TB.Rows.Add(tr1d);
            dr.Close();
            trans.Commit();

           // Conn.Close();

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                // abc = "Insert Susccessfully !!!!!!!";
            }

            trans.Rollback();
           // Conn.Close();
            Response.End();
        }
        finally
        {
            Conn.Close();
        }
    }

    //protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    //{


    //}
}
