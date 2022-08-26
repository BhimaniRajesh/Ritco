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


public partial class GUI_UNI_Net_MIS_Account_Reports_GL_TB_Result_BS : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string RO, LO, custcd, empcd, ACC_cd, Cumulative, vendcd, TYP_CD, RO_TO, LO_TO, Rtyp, View_Sales, DateType, st_paybasis, st_status, st_custcd, st_type, st_trnmod, fromdt, todt, st_Docnolist, select_list, select_Text, st_doctyp;
    public static string lv, RPT_flag, DWN_XLS, YearString, yearSuffix, finyearstart, strFinalQS = "", mHeadOfficeCode;
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
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        XLS_DWN();
    }
    public void XLS_DWN()
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;

            TBL_BS_Det.BorderStyle = BorderStyle.Double;
            TBL_BS_Det.BorderWidth = 1;


            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=BalanceSheet.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            //DipsplayReport();
            BindGrid();
            //GV_Booking.RenderControl(hw);
            TBL_BS_Det.RenderControl(hw);
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
        string STRchar = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
        string[] Str_CHAR = STRchar.Split(',');

       // DateType = Request.QueryString["report_mode"].ToString();
        fromdt = Request.QueryString["dateFrom"].ToString();
        todt = Request.QueryString["dateTo"].ToString();
        Rtyp = Request.QueryString["Rtyp"].ToString();
        TYP_CD = Request.QueryString["TYP_CD"].ToString();
        ACC_cd = Request.QueryString["ACCODE"].ToString();
        Cumulative = Request.QueryString["Cumlative"].ToString();
        RO = Request.QueryString["branch"].ToString();

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

        //if (ACC_cd != "All" || ACC_cd != "")
        //{
        //    string SELACC = "exec WebxNet_Get_DocName '" + ACC_cd + "','A' ";
        //    SqlCommand cmd = new SqlCommand(SELACC, Conn);
        //    SqlDataReader dr = cmd.ExecuteReader();
        //    string STR_ACCD = "";
        //    while (dr.Read())
        //    {
        //        if (STR_ACCD == "")
        //            STR_ACCD = dr[0].ToString();
        //        else
        //            STR_ACCD = STR_ACCD + "," + dr[0].ToString();

        //    }
        //    dr.Close();

        //    //lblLdger.Text = STR_ACCD;

        //}
        if (Rtyp != "1")
        {
            string SELACC1 = "exec WebxNet_Get_DocName '" + ACC_cd + "','A' ";
            if (Rtyp == "2")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','C' ";
            if (Rtyp == "3")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','V' ";
            if (Rtyp == "4")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','E' ";
            if (Rtyp == "5")
                SELACC1 = "exec WebxNet_Get_DocName '" + TYP_CD + "','D' ";
            SqlCommand cmd1 = new SqlCommand(SELACC1, Conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            string STR_ACCD1 = "";
            while (dr1.Read())
            {
                if (STR_ACCD1 == "")
                    STR_ACCD1 = dr1[0].ToString();
                else
                    STR_ACCD1 = STR_ACCD1 + "," + dr1[0].ToString();

            }
            dr1.Close();

            LBLSUBRPT.Text = STR_ACCD1;
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
        //SqlTransaction trans;
        string transtyp1 = "";
        string RPTSUB = Request.QueryString["RPTSUB"].ToString();

        //trans = Conn.BeginTransaction();
        try
        {
            // string SQL_TB = "exec Webx_Trail_Balance_ver1 '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','','" + RO + "','" + Rtyp + "','%" + ACC_cd + "%','%" + TYP_CD + "%'";

            string SQL_PNL = "exec WEbxNet_ProfitLoss '" + RO + "','" + Cumulative + "','" + fromdt + "','" + todt + "','','Category','PNL','" + yearSuffix + "'  ";
            //Response.Write("<BR> SQL_PNL : " + SQL_PNL);
            SqlCommand sqlcmd12_PNL = new SqlCommand(SQL_PNL, Conn);
            //sqlcmd12.Transaction = trans;
            SqlDataReader dr_PNL;
            dr_PNL = sqlcmd12_PNL.ExecuteReader();
            double TOTINC=0,TOTEXP=0,PNLAMT=0;
            while (dr_PNL.Read())
            {
                if(dr_PNL["Category"].ToString().ToUpper().Trim()=="INCOME")
                    TOTINC=Convert.ToDouble(dr_PNL["TOTAL"].ToString());
                if (dr_PNL["Category"].ToString().ToUpper().Trim() == "EXPENSE")
                    TOTEXP = Convert.ToDouble(dr_PNL["TOTAL"].ToString());
            }

            PNLAMT = TOTINC - TOTEXP;

            dr_PNL.Close();

            string SQL_TB = "exec WebxNet_BalanceSheet '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','" + TYP_CD + "','" + RO + "','1','" + RPTSUB + "'";
          //Response.Write("<BR> SQL_TB : " + SQL_TB);
            Rtyp = "1";
            SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
            //sqlcmd12.Transaction = trans;
            SqlDataReader dr;
            dr = sqlcmd12.ExecuteReader();

            TableRow TRB = new TableRow();
            TableCell TRBTC = new TableCell();

            TRBTC.Text = "";
            TRBTC.CssClass = "bluefnt";
            TRBTC.Font.Bold = true;
            TRBTC.HorizontalAlign = HorizontalAlign.Center;
            TRB.Cells.Add(TRBTC);

            TRBTC = new TableCell();
            TRBTC.Text = "";
            TRBTC.CssClass = "blackboldfnt";
            TRB.Cells.Add(TRBTC);

            TRBTC = new TableCell();
            TRBTC.Text = "Particular";
            TRBTC.CssClass = "blackboldfnt";
            TRB.Cells.Add(TRBTC);

           

            TRBTC = new TableCell();
            TRBTC.Text = "20" + yearSuffix.Substring(0, 2).ToString() + " - 20" + yearSuffix.Substring(3, 2).ToString();
            TRBTC.CssClass = "blackboldfnt";
            TRB.Cells.Add(TRBTC);

            TRB.BorderWidth = 1;
            TRB.BorderColor = System.Drawing.Color.Gray;
            TRB.CssClass = "bgbluegrey";
            TRB.HorizontalAlign = HorizontalAlign.Center;
            TBL_BS_Det.Rows.Add(TRB);

            string BSCATTYP = "", BSCATTYP_PR="";
            string GRPP = "", GRPP_PR = "";
            string GRP_str = "", GRP_str_PR = "";
            string BSCATTYP_str = "", BSCATTYP_str_PR = "";
            string GRPNM = "", GRPNM_PR = "";
            double TOT_SF_1 = 0, TOT_AF_1 = 0, TOT_CA_1 = 0, TOT_CL_1 = 0, totBSAMT = 0, totGRBSAMT=0; 

            double TOT_ACCBSAMT=0;
            int grpint = 0;

            int i = 0,j=0;
            double TOT_SF = 0, TOT_AF = 0, TOT_CA = 0, TOT_CL = 0,NETCA=0,NETTOT_AF=0,TOTBSAMT=0;
            string CAP_CA = "", CAP_CL = "";
            //RPTSUB
            while (dr.Read())
            {

                if (dr["CATNO"].ToString() != "")
                    BSCATTYP = dr["CATNO"].ToString();

                GRPP = dr["groupdesc_m"].ToString();
                
               
                if (BSCATTYP != BSCATTYP_PR)
                {
                    TableRow TRB1 = new TableRow();
                    TableCell TRBTC1 = new TableCell();

                    j = 0;

                    TRBTC1.Text = dr["CATNO"].ToString();
                    TRBTC1.CssClass = "bluefnt";
                    TRBTC1.Font.Bold = true;
                    TRBTC1.HorizontalAlign = HorizontalAlign.Center;
                    TRB1.Cells.Add(TRBTC1);

                    TRBTC1 = new TableCell();
                    TRBTC1.Text = dr["CAT"].ToString();
                    TRBTC1.CssClass = "bluefnt";
                    TRBTC1.Font.Bold = true;
                    TRBTC1.ColumnSpan = 3;
                    TRBTC1.HorizontalAlign = HorizontalAlign.Left;
                    TRB1.Cells.Add(TRBTC1);

                    TRB1.BorderWidth = 1;
                    TRB1.BorderColor = System.Drawing.Color.Gray;
                    TRB1.BackColor = System.Drawing.Color.White;
                    TRB1.HorizontalAlign = HorizontalAlign.Center;
                    TBL_BS_Det.Rows.Add(TRB1);
                }

                 if (dr["ASCTYP"].ToString() == "" && dr["CATNO"].ToString() != "")
                {
                    TableRow TRB3 = new TableRow();
                    TableCell TRBTC3 = new TableCell();

                    TRBTC3.Text = "";
                    TRBTC3.CssClass = "blackfnt";
                    TRBTC3.Font.Bold = true;
                    TRBTC3.ColumnSpan = 4;
                    TRBTC3.HorizontalAlign = HorizontalAlign.Center;
                    TRB3.Cells.Add(TRBTC3);


                    TRB3.BorderWidth = 1;
                    TRB3.Height = 10;
                    TRB3.BorderColor = System.Drawing.Color.Gray;
                    TRB3.BackColor = System.Drawing.Color.White;
                    TRB3.HorizontalAlign = HorizontalAlign.Center;
                    TBL_BS_Det.Rows.Add(TRB3);
                }


                


              

                if (RPTSUB == "2")
                {
                    TableRow TRB2 = new TableRow();
                    TableCell TRBTC2 = new TableCell();
                    if (GRPP != GRPP_PR)
                    {
                        TRBTC2.Text = "";
                        TRBTC2.CssClass = "blackfnt";
                        TRBTC2.Font.Bold = true;
                        TRBTC2.HorizontalAlign = HorizontalAlign.Center;
                        TRB2.Cells.Add(TRBTC2);

                        TRBTC2 = new TableCell();
                        if (dr["CAT"].ToString() != "")
                        {
                            TRBTC2.Text = Str_CHAR[j].ToString();
                            if (dr["groupdesc_m"].ToString() == "Current Assets, Loans & Advances")
                                CAP_CA = Str_CHAR[j].ToString();
                            if (dr["groupdesc_m"].ToString() == "Less : Current Liabilities & Provisions")
                                CAP_CL = Str_CHAR[j].ToString();
                            j += 1;
                        }
                        else
                        {
                            TRBTC2.Text = dr["ASCTYP"].ToString();
                        }
                        TRBTC2.CssClass = "blackfnt";
                        TRBTC2.HorizontalAlign = HorizontalAlign.Center;
                        TRB2.Cells.Add(TRBTC2);

                        TRBTC2 = new TableCell();
                        TRBTC2.HorizontalAlign = HorizontalAlign.Left;
                        if (dr["ASCTYP"].ToString() == "" && dr["CATNO"].ToString() == "")
                        {
                            TRBTC2.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dr["groupdesc_m"].ToString();
                        }
                        else if (dr["ASCTYP"].ToString() == "" && dr["CATNO"].ToString() != "")
                        {
                            TRBTC2.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dr["groupdesc_m"].ToString() + " : -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                            TRBTC2.HorizontalAlign = HorizontalAlign.Right;

                        }
                        else
                            TRBTC2.Text = dr["groupdesc_m"].ToString();

                        if (dr["groupcode_m"].ToString() == "")
                        {
                            TRBTC2.CssClass = "bluefnt";
                            TRBTC2.Font.Bold = true;
                            //if (dr["groupdesc_m"].ToString() == "Current Assets, Loans & Advances")
                            //    CAP_CA = dr["ASCTYP"].ToString();
                            //if (dr["groupdesc_m"].ToString() == "Less : Current Liabilities & Provisions")
                            //    CAP_CL = dr["ASCTYP"].ToString();

                            if (dr["groupdesc_m"].ToString() == "NET CURRENT ASSETS ")
                            {
                                TRBTC2.Text = TRBTC2.Text.ToString() + "(" + CAP_CA + " - " + CAP_CL + ")";
                                TRBTC2.CssClass = "blackfnt";
                            }
                        }
                        else
                            TRBTC2.CssClass = "blackfnt";

                        TRB2.Cells.Add(TRBTC2);



                        TRBTC2 = new TableCell();
                        TRBTC2.CssClass = "bluefnt";
                        TRBTC2.Font.Bold = true;
                        if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AA")
                        {
                            TRBTC2.Text = TOT_SF.ToString();
                        }
                        else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AB")
                        {
                            TRBTC2.Text = TOT_CA.ToString();
                        }
                        else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AC")
                        {
                            TRBTC2.Text = TOT_CL.ToString();
                        }
                        else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AD")
                        {
                            TRBTC2.Text = NETCA.ToString();
                            TRBTC2.CssClass = "blackfnt";
                        }
                        else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "G")
                        {
                            TRBTC2.Text = NETTOT_AF.ToString();
                        }
                        else
                        {
                            TRBTC2.Text = "";
                            TRBTC2.CssClass = "blackfnt";
                            TRBTC2.Font.Bold = false;
                        }
                        TRBTC2.Wrap = false;
                        TRBTC2.HorizontalAlign = HorizontalAlign.Right;
                        TRB2.Cells.Add(TRBTC2);

                        TRB2.BorderWidth = 1;
                        TRB2.BorderColor = System.Drawing.Color.Gray;
                        TRB2.BackColor = System.Drawing.Color.White;
                        TRB2.HorizontalAlign = HorizontalAlign.Center;
                        TBL_BS_Det.Rows.Add(TRB2);
                    }

                    if (dr["accdesc"].ToString() != "")
                    {

                        TableRow TRB2a = new TableRow();
                        TableCell TRBTC2a = new TableCell();

                        TRBTC2a.Text = "";
                        TRBTC2a.CssClass = "blackfnt";
                        TRBTC2a.Font.Bold = true;
                        TRBTC2a.HorizontalAlign = HorizontalAlign.Center;
                        TRB2a.Cells.Add(TRBTC2a);

                        TRBTC2a = new TableCell();
                        TRBTC2a.Text = "";
                        TRBTC2a.CssClass = "blackfnt";
                        TRBTC2a.HorizontalAlign = HorizontalAlign.Center;
                        TRB2a.Cells.Add(TRBTC2a);

                        TRBTC2a = new TableCell();
                        TRBTC2a.Text = "&nbsp;&nbsp;"+ dr["acccode"].ToString()+" : " + dr["accdesc"].ToString();
                        TRBTC2a.CssClass = "bluefnt";
                        TRBTC2a.HorizontalAlign = HorizontalAlign.Left;
                        TRB2a.Cells.Add(TRBTC2a);


                        TRBTC2a = new TableCell();
                        TRBTC2a.Text = dr["BS_AMt"].ToString();
                       // string SQL_TB = "exec WebxNet_BalanceSheet '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','" + TYP_CD + "','" + RO + "','1','" + RPTSUB + "'";
                        string dirlldown1 = "branch=" + RO + "&ACCODE=" + dr["acccode"].ToString() + "&dateFrom=" + fromdt + "&dateTo=" + todt + "&Cumlative=" + Cumulative + "&TYP_CD=&PGNO=1&Psize=50&DWN_XLS=N&Rtyp=1";
                        TRBTC2a.Text = "<a href=\"JavaScript:OpenPopupWindow1('" + dirlldown1 + "')\"><font class=\"bluefnt\"><u>" + dr["BS_AMt"].ToString() + "</u></font></a>";
                        TRBTC2a.Wrap = false;
                        TRBTC2a.CssClass = "bluefnt";
                        TRBTC2a.HorizontalAlign = HorizontalAlign.Right;
                        TRB2a.Cells.Add(TRBTC2a);

                        TRB2a.BorderWidth = 1;
                        TRB2a.BorderColor = System.Drawing.Color.Gray;
                        TRB2a.BackColor = System.Drawing.Color.White;
                        TRB2a.HorizontalAlign = HorizontalAlign.Center;
                        TBL_BS_Det.Rows.Add(TRB2a);
                    }
                }
                else
                {
                    TableRow TRB2 = new TableRow();
                    TableCell TRBTC2 = new TableCell();

                    TRBTC2.Text = "";
                    TRBTC2.CssClass = "blackfnt";
                    TRBTC2.Font.Bold = true;
                    TRBTC2.HorizontalAlign = HorizontalAlign.Center;
                    TRB2.Cells.Add(TRBTC2);

                    TRBTC2 = new TableCell();
                    TRBTC2.Text = dr["ASCTYP"].ToString();
                    TRBTC2.CssClass = "blackfnt";
                    TRBTC2.HorizontalAlign = HorizontalAlign.Center;
                    TRB2.Cells.Add(TRBTC2);

                    TRBTC2 = new TableCell();
                    TRBTC2.HorizontalAlign = HorizontalAlign.Left;
                    if (dr["ASCTYP"].ToString() == "" && dr["CATNO"].ToString() == "")
                    {
                        TRBTC2.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dr["groupdesc_m"].ToString();
                    }
                    else if (dr["ASCTYP"].ToString() == "" && dr["CATNO"].ToString() != "")
                    {
                        TRBTC2.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dr["groupdesc_m"].ToString() + " : -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                        TRBTC2.HorizontalAlign = HorizontalAlign.Right;

                    }
                    else
                        TRBTC2.Text = dr["groupdesc_m"].ToString();

                    if (dr["groupcode_m"].ToString() == "")
                    {
                        TRBTC2.CssClass = "bluefnt";
                        TRBTC2.Font.Bold = true;
                        if (dr["groupdesc_m"].ToString() == "Current Assets, Loans & Advances")
                            CAP_CA = dr["ASCTYP"].ToString();
                        if (dr["groupdesc_m"].ToString() == "Less : Current Liabilities & Provisions")
                            CAP_CL = dr["ASCTYP"].ToString();

                        if (dr["groupdesc_m"].ToString() == "NET CURRENT ASSETS ")
                        {
                            TRBTC2.Text = TRBTC2.Text.ToString() + "(" + CAP_CA + " - " + CAP_CL + ")";
                            TRBTC2.CssClass = "blackfnt";
                        }
                    }
                    else
                        TRBTC2.CssClass = "blackfnt";

                    TRB2.Cells.Add(TRBTC2);



                    TRBTC2 = new TableCell();
                    TRBTC2.CssClass = "bluefnt";
                    TRBTC2.Font.Bold = true;
                    if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AA")
                    {
                        TRBTC2.Text = TOT_SF.ToString();
                    }
                    else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AB")
                    {
                        TRBTC2.Text = TOT_CA.ToString();
                    }
                    else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AC")
                    {
                        TRBTC2.Text = TOT_CL.ToString();
                    }
                    else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "AD")
                    {
                        TRBTC2.Text = NETCA.ToString();
                        TRBTC2.CssClass = "blackfnt";
                    }
                    else if (dr["ASCTYP"].ToString() == " " && dr["CATNO"].ToString() != "" && dr["bstype"].ToString() == "G")
                    {
                        TRBTC2.Text = NETTOT_AF.ToString();
                    }
                    else
                    {
                        TRBTC2.Text = dr["BS_AMt"].ToString();
                        if (dr["BS_AMt"].ToString() == "0.00")
                            TRBTC2.Text = "";
                        TRBTC2.CssClass = "blackfnt";
                        TRBTC2.Font.Bold = false;
                    }

                    TRBTC2.HorizontalAlign = HorizontalAlign.Right;
                    TRB2.Cells.Add(TRBTC2);

                    TRB2.BorderWidth = 1;
                    TRB2.BorderColor = System.Drawing.Color.Gray;
                    TRB2.BackColor = System.Drawing.Color.White;
                    TRB2.HorizontalAlign = HorizontalAlign.Center;
                    TBL_BS_Det.Rows.Add(TRB2);



                }

                if (dr["ASCTYP"].ToString() == "" && dr["CATNO"].ToString() != "")
                {
                    TableRow TRB4 = new TableRow();
                    TableCell TRBTC4 = new TableCell();

                    TRBTC4.Text = "";
                    TRBTC4.CssClass = "blackfnt";
                    TRBTC4.Font.Bold = true;
                    TRBTC4.ColumnSpan = 4;
                    TRBTC4.HorizontalAlign = HorizontalAlign.Center;
                    TRB4.Cells.Add(TRBTC4);

                    TRB4.BorderWidth = 1;
                    TRB4.Height = 10;
                    TRB4.BorderColor = System.Drawing.Color.Gray;
                    TRB4.BackColor = System.Drawing.Color.White;
                    TRB4.HorizontalAlign = HorizontalAlign.Center;
                    TBL_BS_Det.Rows.Add(TRB4);
                }

              

                if (dr["bstype"].ToString() == "SF")
                {
                    TOT_SF += Convert.ToDouble(dr["BS_AMt"].ToString());
                }
                else if (dr["bstype"].ToString() == "AF")
                    TOT_AF += Convert.ToDouble(dr["BS_AMt"].ToString());
                else if (dr["bstype"].ToString() == "CL")
                    TOT_CL += Convert.ToDouble(dr["BS_AMt"].ToString());
                else if (dr["bstype"].ToString() == "CA")
                    TOT_CA += Convert.ToDouble(dr["BS_AMt"].ToString());
                NETCA = TOT_CA - TOT_CL;

                NETTOT_AF = TOT_AF + NETCA;

                TOTBSAMT = TOT_SF - NETTOT_AF;
                if (dr["CATNO"].ToString() != "")
                    BSCATTYP_PR = dr["CATNO"].ToString();


                GRPP_PR = dr["groupdesc_m"].ToString();
            }
            TableRow TRB5 = new TableRow();
            TableCell TRBTC5 = new TableCell();

            TRBTC5.Text = "Difference in Balance Sheet (I - II):-";
            TRBTC5.CssClass = "bluefnt";
            TRBTC5.Font.Bold = true;
            TRBTC5.ColumnSpan = 3;
            TRBTC5.HorizontalAlign = HorizontalAlign.Right;
            TRB5.Cells.Add(TRBTC5);

            TRBTC5 = new TableCell();
            TRBTC5.Text = TOTBSAMT.ToString();
            TRBTC5.CssClass = "bluefnt";
            TRBTC5.Font.Bold = true;
            TRBTC5.HorizontalAlign = HorizontalAlign.Right;
            TRB5.Cells.Add(TRBTC5);

            TRB5.BorderWidth = 1;
            TRB5.Height = 10;
            TRB5.BorderColor = System.Drawing.Color.Gray;
            TRB5.BackColor = System.Drawing.Color.White;
            TRB5.HorizontalAlign = HorizontalAlign.Center;
            TBL_BS_Det.Rows.Add(TRB5);
            dr.Close();





            TableRow tr = new TableRow();
            TableCell trtc1 = new TableCell();

            trtc1.Text = "Formula Of Balance Sheet Getting Tallied";
            trtc1.ColumnSpan = 3;
            trtc1.CssClass = "blackboldfnt";
            tr.Cells.Add(trtc1);

            tr.BorderWidth = 1;
            tr.BorderColor = System.Drawing.Color.Gray;
            tr.HorizontalAlign = HorizontalAlign.Center;

            tr.CssClass = "bgbluegrey";
            TBL_BS.Rows.Add(tr);

            TableRow tr1 = new TableRow();
            TableCell tr1tc1 = new TableCell();
           
            double TOTAF_DA = TOT_AF + TOT_CA - TOT_CL;
            
            tr1tc1.Text = "1";
            tr1tc1.CssClass = "bluefnt";
            tr1tc1.Font.Bold = true;
            tr1tc1.HorizontalAlign = HorizontalAlign.Center;
            tr1.Cells.Add(tr1tc1);

            tr1tc1 = new TableCell();
            tr1tc1.Text = "Source Of Funds";
            tr1tc1.CssClass = "blackfnt";
            tr1tc1.HorizontalAlign = HorizontalAlign.Left;
            tr1.Cells.Add(tr1tc1);

            tr1tc1 = new TableCell();

            if (TOT_SF < 0)
            {
                tr1tc1.Text = "(" + TOT_SF.ToString("F2").Replace("-", "") + ")";
                tr1tc1.CssClass = "redfnt";
            }
            else
            {
                tr1tc1.Text = TOT_SF.ToString("F2");
                tr1tc1.CssClass = "blackfnt";
            }
            tr1tc1.HorizontalAlign = HorizontalAlign.Right;
            tr1.Cells.Add(tr1tc1);

            tr1.BorderWidth = 1;
            tr1.BorderColor = System.Drawing.Color.Gray;
            tr1.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr1);

            TableRow tr2 = new TableRow();
            TableCell tr2tc1 = new TableCell();

            tr2tc1.Text = "2";

            tr2tc1.CssClass = "bluefnt";
            tr2tc1.Font.Bold = true;
            tr2tc1.HorizontalAlign = HorizontalAlign.Center;
            tr2.Cells.Add(tr2tc1);

            tr2tc1 = new TableCell();
            tr2tc1.Text = "Application Of Fund - ( D + A )";
            tr2tc1.CssClass = "blackfnt";
            tr2tc1.HorizontalAlign = HorizontalAlign.Left;
            tr2.Cells.Add(tr2tc1);

            tr2tc1 = new TableCell();
            tr2tc1.Text = TOTAF_DA.ToString("F2");
            if (TOTAF_DA < 0)
            {
                tr2tc1.Text = "(" + TOTAF_DA.ToString("F2").Replace("-", "") + ")";
                tr2tc1.CssClass = "redfnt";
            }
            else
            {
                tr2tc1.Text = TOTAF_DA.ToString("F2");
                tr2tc1.CssClass = "blackfnt";
            }
            tr2tc1.HorizontalAlign = HorizontalAlign.Right;
            tr2.Cells.Add(tr2tc1);

            tr2.BorderWidth = 1;
            tr2.BorderColor = System.Drawing.Color.Gray;
            tr2.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr2);

            TableRow tr3 = new TableRow();
            TableCell tr3tc1 = new TableCell();

            tr3tc1.Text = "";
            tr3tc1.ColumnSpan = 3;
            tr3tc1.CssClass = "blackfnt";
            tr3.Cells.Add(tr3tc1);

            tr3.BorderWidth = 1;
            tr3.BorderColor = System.Drawing.Color.Gray;
            tr3.BackColor = System.Drawing.Color.White;
            tr3.Height = 10;
            TBL_BS.Rows.Add(tr3);

            TableRow tr4 = new TableRow();
            TableCell tr4tc1 = new TableCell();

            tr4tc1.Text = "";
            tr4tc1.CssClass = "blackfnt";
            tr4tc1.HorizontalAlign = HorizontalAlign.Center;
            tr4.Cells.Add(tr4tc1);

            tr4tc1 = new TableCell();
            tr4tc1.Text = "A) Fix Asset";
            tr4tc1.CssClass = "blackfnt";
            tr4tc1.HorizontalAlign = HorizontalAlign.Left;
            tr4.Cells.Add(tr4tc1);

            tr4tc1 = new TableCell();
            tr4tc1.Text = TOT_AF.ToString("F2");
            if (TOT_AF < 0)
            {
                tr4tc1.Text = "(" + TOT_AF.ToString("F2").Replace("-", "") + ")";
                tr4tc1.CssClass = "redfnt";
            }
            else
            {
                tr4tc1.Text = TOT_AF.ToString("F2");
                tr4tc1.CssClass = "blackfnt";
            }
            tr4tc1.HorizontalAlign = HorizontalAlign.Right;
            tr4.Cells.Add(tr4tc1);

            tr4.BorderWidth = 1;
            tr4.BorderColor = System.Drawing.Color.Gray;
            tr4.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr4);


            TableRow tr5 = new TableRow();
            TableCell tr5tc1 = new TableCell();

            tr5tc1.Text = "";
            tr5tc1.CssClass = "blackfnt";
            tr5tc1.HorizontalAlign = HorizontalAlign.Center;
            tr5.Cells.Add(tr5tc1);

            tr5tc1 = new TableCell();
            tr5tc1.Text = "B) Current Assets, Loans & Advances";
            tr5tc1.CssClass = "blackfnt";
            tr5tc1.HorizontalAlign = HorizontalAlign.Left;
            tr5.Cells.Add(tr5tc1);

            tr5tc1 = new TableCell();
            tr5tc1.Text = TOT_CA.ToString("F2");
            if (TOT_CA < 0)
            {
                tr5tc1.Text = "(" + TOT_CA.ToString("F2").Replace("-", "") + ")";
                tr5tc1.CssClass = "redfnt";
            }
            else
            {
                tr5tc1.Text = TOT_CA.ToString("F2");
                tr5tc1.CssClass = "blackfnt";
            }
            tr5tc1.HorizontalAlign = HorizontalAlign.Right;
            tr5.Cells.Add(tr5tc1);

            tr5.BorderWidth = 1;
            tr5.BorderColor = System.Drawing.Color.Gray;
            tr5.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr5);

            TableRow tr6 = new TableRow();
            TableCell tr6tc1 = new TableCell();

            tr6tc1.Text = "";
            tr6tc1.CssClass = "blackfnt";
            tr6tc1.HorizontalAlign = HorizontalAlign.Center;
            tr6.Cells.Add(tr6tc1);

            tr6tc1 = new TableCell();
            tr6tc1.Text = "C) Current Liabilities & Provisions";
            tr6tc1.CssClass = "blackfnt";
            tr6tc1.HorizontalAlign = HorizontalAlign.Left;
            tr6.Cells.Add(tr6tc1);

            tr6tc1 = new TableCell();
            tr6tc1.Text = TOT_CL.ToString("F2");
            if (TOT_CL < 0)
            {
                tr6tc1.Text = "(" + TOT_CL.ToString("F2").Replace("-", "") + ")";
                tr6tc1.CssClass = "redfnt";
            }
            else
            {
                tr6tc1.Text = TOT_CL.ToString("F2");
                tr6tc1.CssClass = "blackfnt";
            }
            tr6tc1.HorizontalAlign = HorizontalAlign.Right;
            tr6.Cells.Add(tr6tc1);

            tr6.BorderWidth = 1;
            tr6.BorderColor = System.Drawing.Color.Gray;
            tr6.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr6);

            TableRow tr7 = new TableRow();
            TableCell tr7tc1 = new TableCell();

            double TOT_NETCA = TOT_CA - TOT_CL;

            tr7tc1.Text = "";
            tr7tc1.CssClass = "blackfnt";
            tr7tc1.HorizontalAlign = HorizontalAlign.Center;
            tr7.Cells.Add(tr7tc1);

            tr7tc1 = new TableCell();
            tr7tc1.Text = "D) Net Current Asset  ( B - C )";
            tr7tc1.CssClass = "blackfnt";
            tr7tc1.HorizontalAlign = HorizontalAlign.Left;
            tr7.Cells.Add(tr7tc1);

            tr7tc1 = new TableCell();
            tr7tc1.Text = TOT_NETCA.ToString("F2");
            if (TOT_NETCA < 0)
            {
                tr7tc1.Text = "(" + TOT_NETCA.ToString("F2").Replace("-", "") + ")";
                tr7tc1.CssClass = "redfnt";
            }
            else
            {
                tr7tc1.Text = TOT_NETCA.ToString("F2");
                tr7tc1.CssClass = "blackfnt";
            }
            tr7tc1.HorizontalAlign = HorizontalAlign.Right;
            tr7.Cells.Add(tr7tc1);

            tr7.BorderWidth = 1;
            tr7.BorderColor = System.Drawing.Color.Gray;
            tr7.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr7);


            TableRow tr8 = new TableRow();
            TableCell tr8tc1 = new TableCell();

            tr8tc1.Text = "";
            tr8tc1.ColumnSpan = 3;
            tr8tc1.CssClass = "blackfnt";
            tr8.Cells.Add(tr8tc1);

            tr8.BorderWidth = 1;
            tr8.BorderColor = System.Drawing.Color.Gray;
            tr8.BackColor = System.Drawing.Color.White;
            tr8.Height = 10;
            TBL_BS.Rows.Add(tr8);

            TableRow tr9 = new TableRow();
            TableCell tr9tc1 = new TableCell();

            double TOT_DIFF_BS = 0;
            TOT_DIFF_BS = TOT_SF - TOTAF_DA;


            tr9tc1.Text = "";
            tr9tc1.CssClass = "blackfnt";
            tr9tc1.HorizontalAlign = HorizontalAlign.Center;
            tr9.Cells.Add(tr9tc1);

            tr9tc1 = new TableCell();
            tr9tc1.Text = "Diff In Balance Sheet ( 1 - 2 )";
            tr9tc1.CssClass = "bluefnt";
            tr9tc1.Font.Bold = true;
            tr9tc1.HorizontalAlign = HorizontalAlign.Left;
            tr9.Cells.Add(tr9tc1);

            tr9tc1 = new TableCell();
            tr9tc1.Text = TOT_DIFF_BS.ToString("F2");
            tr9tc1.HorizontalAlign = HorizontalAlign.Right;
            tr9tc1.CssClass = "bluefnt";
            tr9tc1.Font.Bold = true;
            if (TOT_DIFF_BS < 0)
            {
                TOT_DIFF_BS =TOTAF_DA- TOT_SF ;
                tr9tc1.CssClass = "redfnt";
                tr9tc1.Text = "(" + TOT_DIFF_BS.ToString("F2") + ")";
            }
            tr9.Cells.Add(tr9tc1);




            tr9.BorderWidth = 1;
            tr9.BorderColor = System.Drawing.Color.Gray;
            tr9.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr9);


            TableRow tr10= new TableRow();
            TableCell tr10tc1 = new TableCell();

            tr10tc1.Text = "";
            tr10tc1.ColumnSpan = 3;
            tr10tc1.CssClass = "blackfnt";
            tr10.Cells.Add(tr10tc1);

            tr10.BorderWidth = 1;
            tr10.BorderColor = System.Drawing.Color.Gray;
            tr10.BackColor = System.Drawing.Color.White;
            tr10.Height = 10;
            TBL_BS.Rows.Add(tr10);


            TableRow tr11 = new TableRow();
            TableCell tr11tc1 = new TableCell();

           // double TOTAF_DA = TOT_AF + TOT_CA - TOT_CL;

            tr11tc1.Text = "3";
            tr11tc1.CssClass = "bluefnt";
            tr11tc1.Font.Bold = true;
            tr11tc1.HorizontalAlign = HorizontalAlign.Center;
            tr11.Cells.Add(tr11tc1);

            tr11tc1 = new TableCell();
            tr11tc1.Text = "Total InCome";
            tr11tc1.CssClass = "blackfnt";
            tr11tc1.HorizontalAlign = HorizontalAlign.Left;
            tr11.Cells.Add(tr11tc1);

            tr11tc1 = new TableCell();

            if (TOTINC < 0)
            {
                tr11tc1.Text = "(" + TOTINC.ToString("F2").Replace("-", "") + ")";
                tr11tc1.CssClass = "redfnt";
            }
            else
            {
                tr11tc1.Text = TOTINC.ToString("F2");
                tr11tc1.CssClass = "blackfnt";
            }
            tr11tc1.HorizontalAlign = HorizontalAlign.Right;
            tr11.Cells.Add(tr11tc1);
            
            tr11.BorderWidth = 1;
            tr11.BorderColor = System.Drawing.Color.Gray;
            tr11.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr11);

            TableRow tr12 = new TableRow();
            TableCell tr12tc1 = new TableCell();

            tr12tc1.Text = "4";

            tr12tc1.CssClass = "bluefnt";
            tr12tc1.Font.Bold = true;
            tr12tc1.HorizontalAlign = HorizontalAlign.Center;
            tr12.Cells.Add(tr12tc1);

            tr12tc1 = new TableCell();
            tr12tc1.Text = "Total Expense";
            tr12tc1.CssClass = "blackfnt";
            tr12tc1.HorizontalAlign = HorizontalAlign.Left;
            tr12.Cells.Add(tr12tc1);

            tr12tc1 = new TableCell();
            tr12tc1.Text = TOTEXP.ToString("F2");
            if (TOTEXP < 0)
            {
                tr12tc1.Text = "(" + TOTEXP.ToString("F2").Replace("-", "") + ")";
                tr12tc1.CssClass = "redfnt";
            }
            else
            {
                tr12tc1.Text = TOTEXP.ToString("F2");
                tr12tc1.CssClass = "blackfnt";
            }
            tr12tc1.HorizontalAlign = HorizontalAlign.Right;
            tr12.Cells.Add(tr12tc1);

            tr12.BorderWidth = 1;
            tr12.BorderColor = System.Drawing.Color.Gray;
            tr12.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr12);


            TableRow tr13 = new TableRow();
            TableCell tr13tc1 = new TableCell();

            tr13tc1.Text = "";
            tr13tc1.ColumnSpan = 3;
            tr13tc1.CssClass = "blackfnt";
            tr13.Cells.Add(tr13tc1);

            tr13.BorderWidth = 1;
            tr13.BorderColor = System.Drawing.Color.Gray;
            tr13.BackColor = System.Drawing.Color.White;
            tr13.Height = 10;
            TBL_BS.Rows.Add(tr13);

            TableRow tr14 = new TableRow();
            TableCell tr14tc1 = new TableCell();

            tr14tc1.Text = "";
            tr14tc1.CssClass = "blackfnt";
            tr14tc1.HorizontalAlign = HorizontalAlign.Center;
            tr14.Cells.Add(tr14tc1);
             
            tr14tc1 = new TableCell();
            tr14tc1.Text = "Profit/(Loss) Amount ( 3 - 4 )";
            tr14tc1.CssClass = "bluefnt";
            tr14tc1.Font.Bold = true;
            tr14tc1.HorizontalAlign = HorizontalAlign.Left;
            tr14.Cells.Add(tr14tc1);

            tr14tc1 = new TableCell();
            tr14tc1.Text = PNLAMT.ToString("F2");
            tr14tc1.HorizontalAlign = HorizontalAlign.Right;
            tr14tc1.CssClass = "bluefnt";
            tr14tc1.Font.Bold = true;
            if (PNLAMT < 0)
            {
                //TOT_DIFF_BS = TOTAF_DA - TOT_SF;
                tr14tc1.CssClass = "redfnt";
                tr14tc1.Text = "(" + PNLAMT.ToString("F2") + ")";
            }
            tr14.Cells.Add(tr14tc1);

            tr14.BorderWidth = 1;
            tr14.BorderColor = System.Drawing.Color.Gray;
            tr14.BackColor = System.Drawing.Color.White;
            tr14.Height = 10;
            TBL_BS.Rows.Add(tr14);

        }
         
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                // abc = "Insert Susccessfully !!!!!!!";
            }

          
        }
        finally
        {
            Conn.Close();
        }
    }

}

