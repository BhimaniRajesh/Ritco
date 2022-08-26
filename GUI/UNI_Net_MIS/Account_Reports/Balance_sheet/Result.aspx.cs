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

public partial class GUI_UNI_Net_MIS_Account_Reports_Balance_sheet_Result : System.Web.UI.Page
{
    string DWN_XLS = "";
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DWN_XLS = Request.QueryString["DWN_XLS"].ToString();
            if (DWN_XLS == "Y")
            {
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

            

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Trail_balance.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            //DipsplayReport();
            BindGrid();
            //GV_Booking.RenderControl(hw);
            TBL_BS.RenderControl(hw);
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

        string DateType = Request.QueryString["report_mode"].ToString();
        string fromdt = Request.QueryString["fromdt"].ToString();
        string todt = Request.QueryString["todt"].ToString();
        string Rtyp = Request.QueryString["Rtyp"].ToString();
        string TYP_CD = Request.QueryString["TYP_CD"].ToString();
        string ACC_cd = Request.QueryString["ACC_cd"].ToString();
        string  Cumulative = Request.QueryString["Cumulative"].ToString();
        string  RO = Request.QueryString["RO"].ToString();
        string GRP = Request.QueryString["GRP"].ToString();

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

        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
        string finyearstart = "01 APR " + YearString;
        yrstartdt = Convert.ToDateTime(finyearstart);
        string mHeadOfficeCode = Session["HeadOfficeCode"].ToString();
         SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        try
        {
            string SQL_BS = "exec Webx_BalanceSheet '" + fromdt + "','" + todt + "','" + Cumulative + "','" + yearSuffix + "','" + RO + "','1','" + TYP_CD + "'";
           // Response.Write("<BR> SQL_BS : " + SQL_BS);
            SqlCommand sqlcmd12 = new SqlCommand(SQL_BS, Conn);
            sqlcmd12.Transaction = trans;
            sqlcmd12.ExecuteNonQuery();


            SQL_BS = "select M_CAT,M_CAT_no,debit=sum(isnull(debit,0)),credit=sum(isnull(credit,0)) ,BS_AMt=(case when sum(isnull(debit,0))>sum(isnull(credit,0)) then sum(isnull(debit,0))-sum(isnull(credit,0)) else sum(isnull(credit,0))-sum(isnull(debit,0)) end)	from Webx_BlanaceSheet_RPT  group by M_CAT,M_CAT_no order by  M_CAT_no	";
            SQL_BS = "select M_CAT_S=M_CAT,M_CAT=(case when M_CAT='SF' then 'Source Of Funds' when M_CAT='CL' then 'Less : Current Liabilities & Provisions'  when M_CAT='AF' then 'Application Of Funds' when M_CAT='CA' then 'Current Assets, Loans & Advances' end),M_CAT_no,M_GCD,debit=sum(isnull(debit,0)),credit=sum(isnull(credit,0)),	BS_AMt=sum(isnull(debit,0))-sum(isnull(credit,0))	 from Webx_BlanaceSheet_RPT group by M_CAT,M_CAT_no,M_GCD,M_ACD order by  M_CAT_no ";
           
            sqlcmd12 = new SqlCommand(SQL_BS, Conn);
            sqlcmd12.Transaction = trans;
            SqlDataReader dr = sqlcmd12.ExecuteReader();
            
            
            TBL_BS.Visible = true;

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
            double TOT_SF = 0, TOT_AF = 0, TOT_CA = 0, TOT_CL = 0;
           
            while (dr.Read())
            {
                if (dr["M_CAT_S"].ToString() == "SF")
                {
                    TOT_SF += Convert.ToDouble(dr["BS_AMt"].ToString());
                }
                else if (dr["M_CAT_S"].ToString() == "AF")
                    TOT_AF += Convert.ToDouble(dr["BS_AMt"].ToString());
                else if (dr["M_CAT_S"].ToString() == "CL")
                    TOT_CL += Convert.ToDouble(dr["BS_AMt"].ToString());
                else if (dr["M_CAT_S"].ToString() == "CA")
                    TOT_CA += Convert.ToDouble(dr["BS_AMt"].ToString());
            }
            double TOTAF_DA = TOT_AF + TOT_CA - TOT_CL;
            dr.Close();

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
            TOT_DIFF_BS=TOT_SF - TOTAF_DA;
            

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
                tr9tc1.Text ="("+ TOT_DIFF_BS.ToString("F2")+")";
            }
            tr9.Cells.Add(tr9tc1);



            tr9.BorderWidth = 1;
            tr9.BorderColor = System.Drawing.Color.Gray;
            tr9.BackColor = System.Drawing.Color.White;
            TBL_BS.Rows.Add(tr9);



            SQL_BS = "select M_CAT_S=M_CAT,M_CAT=(case when M_CAT='SF' then 'Source Of Funds' when M_CAT='CL' then 'Less : Current Liabilities & Provisions'  when M_CAT='AF' then 'Application Of Funds' when M_CAT='CA' then 'Current Assets, Loans & Advances' end),M_CAT_no,M_GCD,M_ACD,debit=sum(isnull(debit,0)),credit=sum(isnull(credit,0)),	BS_AMt= sum(isnull(debit,0))-sum(isnull(credit,0)) 	 from Webx_BlanaceSheet_RPT group by M_CAT,M_CAT_no,M_GCD,M_ACD order by  M_CAT_no ";
            SQL_BS = "select M_CAT_S,M_CAT,M_CAT_no,GCD,grouplevel,groupdesc_m,M_GCD,M_ACD,debit,credit,BS_AMt,Parentcode  from  VwNet_BlanaceSheet_RPT order by  M_CAT_no";
            sqlcmd12 = new SqlCommand(SQL_BS, Conn);
            sqlcmd12.Transaction = trans;
            dr = sqlcmd12.ExecuteReader();

            TableRow TRB = new TableRow();
            TableCell TRBTC = new TableCell();

            TRBTC.Text = "";
            TRBTC.CssClass = "bluefnt";
            TRBTC.Font.Bold = true;
            TRBTC.HorizontalAlign = HorizontalAlign.Center;
            TRB.Cells.Add(TRBTC);

            TRBTC = new TableCell();
            TRBTC.Text = "Particular";
            //TRBTC.ColumnSpan = 2;
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
            //TRB.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB);

            string BSCATTYP = "", BSCATTYP_PR="";
            string GRP_str = "", GRP_str_PR = "";
            string BSCATTYP_str = "", BSCATTYP_str_PR = "";
            string GRPNM = "", GRPNM_PR = "";
            double TOT_SF_1 = 0, TOT_AF_1 = 0, TOT_CA_1 = 0, TOT_CL_1 = 0, totBSAMT = 0, totGRBSAMT=0; 

            double TOT_ACCBSAMT=0;
            int grpint = 0;

            int i = 0;
            while (dr.Read())
            {
                if (Convert.ToDouble(dr["BS_AMt"].ToString()) != 0)
                {
                    GRPNM = dr["M_GCD"].ToString();

                    BSCATTYP = dr["M_CAT_no"].ToString();
                    BSCATTYP_str = dr["M_CAT"].ToString();
                    GRP_str = dr["groupdesc_m"].ToString();
                    
                    ///////////////// FOr BS Category 

                    if (BSCATTYP != BSCATTYP_PR)
                    {
                        if (BSCATTYP_PR == "")
                        {
                            TableRow TRB2a1 = new TableRow();
                            TableCell TRB2a1TC = new TableCell();

                            TRB2a1TC.Text = BSCATTYP;
                            TRB2a1TC.CssClass = "bluefnt";
                            if (GRP == "1")
                            {
                                TRB2a1TC.ForeColor = System.Drawing.Color.MidnightBlue;
                                TRB2a1TC.Font.Size = 9;
                            }
                            TRB2a1TC.Font.Bold = true;
                            
                            TRB2a1TC.HorizontalAlign = HorizontalAlign.Center;
                            TRB2a1.Cells.Add(TRB2a1TC);

                            TRB2a1TC = new TableCell();
                            TRB2a1TC.Text = "";
                            TRB2a1TC.CssClass = "bluefnt";
                            if (GRP == "1")
                            {
                                TRB2a1TC.ForeColor = System.Drawing.Color.MidnightBlue;
                                TRB2a1TC.Font.Size = 9;
                            }
                            TRB2a1TC.Font.Bold = true;                            
                            TRB2a1TC.ColumnSpan = 2;
                            TRB2a1TC.HorizontalAlign = HorizontalAlign.Left;
                            TRB2a1.Cells.Add(TRB2a1TC);

                            TRB2a1TC.Text = dr["M_CAT"].ToString();

                            TRB2a1.BorderWidth = 1;
                            TRB2a1.BorderColor = System.Drawing.Color.Gray;
                            //TRB2a1.HorizontalAlign = HorizontalAlign.Center;
                            TRB2a1.BackColor = System.Drawing.Color.White;
                            TBL_BS_Det.Rows.Add(TRB2a1);
                        }
                    }

                    if (GRP_str != GRP_str_PR)
                    {

                        if (GRP_str_PR != "")
                        {
                            TableRow TRB2_GT = new TableRow();
                            TableCell TRB2_GTTC = new TableCell();

                            TRB2_GTTC.Text = "";
                            TRB2_GTTC.CssClass = "bluefnt";
                            TRB2_GTTC.Font.Bold = true;
                            TRB2_GTTC.HorizontalAlign = HorizontalAlign.Right;
                            TRB2_GT.Cells.Add(TRB2_GTTC);

                            TRB2_GTTC = new TableCell();
                            TRB2_GTTC.Text = "";
                            TRB2_GTTC.CssClass = "bluefnt";
                            // TRB2_GTTC.ForeColor = System.Drawing.Color.MidnightBlue;
                           
                            //TRB2_GTTC.Font.Size = 10;
                            if (GRP == "1")
                            {
                                TRB2_GTTC.Text = "Total Of " + GRP_str_PR + " : - ";
                                TRB2_GTTC.HorizontalAlign = HorizontalAlign.Right;
                                TRB2_GTTC.Font.Bold = true;
                            }
                            else
                            {
                                TRB2_GTTC.Text ="&nbsp;&nbsp;&nbsp;&nbsp;"+ GRP_str_PR ;
                                TRB2_GTTC.HorizontalAlign = HorizontalAlign.Left;
                                TRB2_GTTC.CssClass = "blackfnt";
                            }
                            
                            TRB2_GT.Cells.Add(TRB2_GTTC);

                            TRB2_GTTC = new TableCell();

                            if (totGRBSAMT < 0)
                                TRB2_GTTC.Text = "(" + totGRBSAMT.ToString("F2").Replace("-", "") + ")";
                            else
                                TRB2_GTTC.Text = totGRBSAMT.ToString("F2");


                            TRB2_GTTC.CssClass = "bluefnt";
                           
                            if (GRP == "1")
                            {
                                TRB2_GTTC.CssClass = "blackfnt";
                                TRB2_GTTC.Font.Bold = false;
                            }

                            TRB2_GTTC.HorizontalAlign = HorizontalAlign.Right;
                            TRB2_GT.Cells.Add(TRB2_GTTC);




                            TRB2_GT.BorderWidth = 1;
                            TRB2_GT.BorderColor = System.Drawing.Color.Gray;
                            //TRB2_GT.HorizontalAlign = HorizontalAlign.Center;
                            TRB2_GT.BackColor = System.Drawing.Color.White;
                            TBL_BS_Det.Rows.Add(TRB2_GT);

                            totGRBSAMT = 0;

                        }

                        if (GRP == "1")
                        {
                            if (grpint == 0)
                            {
                                TableRow TRB2ic = new TableRow();
                                TableCell TRB2icTC = new TableCell();

                                TRB2icTC.Text = "";
                                TRB2icTC.CssClass = "bluefnt";
                                TRB2icTC.Font.Bold = true;
                                TRB2icTC.HorizontalAlign = HorizontalAlign.Center;
                                TRB2ic.Cells.Add(TRB2icTC);

                                TRB2icTC = new TableCell();
                                TRB2icTC.CssClass = "bluefnt";
                                TRB2icTC.Font.Bold = true;
                                TRB2icTC.ColumnSpan = 2;
                                TRB2icTC.HorizontalAlign = HorizontalAlign.Left;
                                TRB2ic.Cells.Add(TRB2icTC);
                                TRB2icTC.Text = dr["groupdesc_m"].ToString();


                                TRB2ic.BorderWidth = 1;
                                TRB2ic.BorderColor = System.Drawing.Color.Gray;
                                //TRB2ic.HorizontalAlign = HorizontalAlign.Center;
                                TRB2ic.BackColor = System.Drawing.Color.White;
                                TBL_BS_Det.Rows.Add(TRB2ic);

                                grpint = 0;
                            }
                        }

                    }

                    if (BSCATTYP != BSCATTYP_PR)
                    {
                        if (BSCATTYP_PR != "")
                        {
                            TableRow TRB2 = new TableRow();
                            TableCell TRB2TC = new TableCell();

                            TRB2TC.Text = "";
                            TRB2TC.CssClass = "bluefnt";
                            TRB2TC.Font.Bold = true;
                            TRB2TC.HorizontalAlign = HorizontalAlign.Right;
                            TRB2.Cells.Add(TRB2TC);

                            TRB2TC = new TableCell();
                            TRB2TC.Text = "";
                            TRB2TC.CssClass = "bluefnt";
                            if (GRP == "1")
                            {
                                TRB2TC.ForeColor = System.Drawing.Color.MidnightBlue;
                                TRB2TC.Font.Size = 9;
                            }
                            TRB2TC.Font.Bold = true;
                            
                            TRB2TC.Text = "Total Of " + BSCATTYP_str_PR + " : - ";
                            TRB2TC.HorizontalAlign = HorizontalAlign.Right;
                            TRB2.Cells.Add(TRB2TC);

                            TRB2TC = new TableCell();

                            if (totBSAMT < 0)
                                TRB2TC.Text = "(" + totBSAMT.ToString("F2").Replace("-", "") + ")";
                            else
                                TRB2TC.Text = totBSAMT.ToString("F2");


                            TRB2TC.CssClass = "bluefnt";
                            TRB2TC.Font.Bold = true;
                            TRB2TC.HorizontalAlign = HorizontalAlign.Right;
                            TRB2.Cells.Add(TRB2TC);

                            if (BSCATTYP_PR == "A")
                                TOT_SF_1 = totBSAMT;
                            else if (BSCATTYP_PR == "B")
                                TOT_AF_1 = totBSAMT;
                            else if (BSCATTYP_PR == "D")
                                TOT_CL_1 = totBSAMT;
                            else if (BSCATTYP_PR == "C")
                                TOT_CA_1 = totBSAMT;


                            TRB2.BorderWidth = 1;
                            TRB2.BorderColor = System.Drawing.Color.Gray;
                            //TRB2.HorizontalAlign = HorizontalAlign.Center;
                            TRB2.BackColor = System.Drawing.Color.White;
                            TBL_BS_Det.Rows.Add(TRB2);

                            totBSAMT = 0;
                            TableRow TRB2a = new TableRow();
                            TableCell TRB2aTC = new TableCell();

                            TRB2aTC.Text = BSCATTYP;
                            TRB2aTC.CssClass = "bluefnt";
                            if (GRP == "1")
                            {
                                TRB2aTC.ForeColor = System.Drawing.Color.MidnightBlue;
                            }
                            TRB2aTC.Font.Bold = true;
                            TRB2aTC.Font.Size = 9;
                            TRB2aTC.HorizontalAlign = HorizontalAlign.Center;
                            TRB2a.Cells.Add(TRB2aTC);

                            TRB2aTC = new TableCell();
                            TRB2aTC.Text = "";
                            TRB2aTC.CssClass = "bluefnt";
                            if (GRP == "1")
                            {
                                TRB2aTC.ForeColor = System.Drawing.Color.MidnightBlue;
                                TRB2aTC.Font.Size = 9;
                            }
                            TRB2aTC.Font.Bold = true;
                            
                            TRB2aTC.ColumnSpan = 2;
                            TRB2aTC.HorizontalAlign = HorizontalAlign.Left;
                            TRB2a.Cells.Add(TRB2aTC);

                            TRB2aTC.Text = dr["M_CAT"].ToString();

                            TRB2a.BorderWidth = 1;
                            TRB2a.BorderColor = System.Drawing.Color.Gray;
                            //TRB2a.HorizontalAlign = HorizontalAlign.Center;
                            TRB2a.BackColor = System.Drawing.Color.White;
                            TBL_BS_Det.Rows.Add(TRB2a);
                        }
                    }

                    if (GRP == "1")
                    {
                        if (GRP_str != GRP_str_PR)
                        {
                            if (grpint != 0)
                            {
                                TableRow TRB2ic = new TableRow();
                                TableCell TRB2icTC = new TableCell();

                                TRB2icTC.Text = "";
                                TRB2icTC.CssClass = "bluefnt";
                                TRB2icTC.Font.Bold = true;
                                TRB2icTC.HorizontalAlign = HorizontalAlign.Center;
                                TRB2ic.Cells.Add(TRB2icTC);

                                TRB2icTC = new TableCell();
                                TRB2icTC.CssClass = "bluefnt";
                                TRB2icTC.Font.Bold = true;
                                TRB2icTC.ColumnSpan = 2;
                                TRB2icTC.HorizontalAlign = HorizontalAlign.Left;
                                TRB2ic.Cells.Add(TRB2icTC);
                                TRB2icTC.Text = dr["groupdesc_m"].ToString();


                                TRB2ic.BorderWidth = 1;
                                TRB2ic.BorderColor = System.Drawing.Color.Gray;
                                //TRB2ic.HorizontalAlign = HorizontalAlign.Center;
                                TRB2ic.BackColor = System.Drawing.Color.White;
                                TBL_BS_Det.Rows.Add(TRB2ic);

                                grpint = 0;
                            }

                        }

                    }

                    ///////////////// FOr BS Groups  
                    //if (GRP == "1")
                    //{
                    grpint += 1;
                    if (GRP == "1")
                    { 
                        if (GRPNM != GRPNM_PR)
                        {
                            if (GRPNM != GRP_str)
                            {
                                TableRow TRB2c = new TableRow();
                                TableCell TRB2cTC = new TableCell();

                                TRB2cTC.Text = "";
                                TRB2cTC.CssClass = "bluefnt";
                                TRB2cTC.Font.Bold = true;
                                TRB2cTC.HorizontalAlign = HorizontalAlign.Center;
                                TRB2c.Cells.Add(TRB2cTC);

                                TRB2cTC = new TableCell();
                                TRB2cTC.CssClass = "bluefnt";
                                TRB2cTC.ColumnSpan = 2;
                                TRB2cTC.HorizontalAlign = HorizontalAlign.Left;
                                TRB2c.Cells.Add(TRB2cTC);

                                TRB2cTC.Text = "&nbsp;&nbsp;-- " + GRPNM;

                                TRB2c.BorderWidth = 1;
                                TRB2c.BorderColor = System.Drawing.Color.Gray;
                                //TRB2c.HorizontalAlign = HorizontalAlign.Center;
                                TRB2c.BackColor = System.Drawing.Color.White;
                                TBL_BS_Det.Rows.Add(TRB2c);
                            }
                        }

                        

                            TableRow TRB1 = new TableRow();
                            TableCell TRB1TC = new TableCell();
                            TRB1TC.Text = "";
                            TRB1TC.CssClass = "bluefnt";
                            TRB1TC.Font.Bold = true;
                            TRB1TC.Width = 50;
                            TRB1TC.HorizontalAlign = HorizontalAlign.Center;
                            TRB1.Cells.Add(TRB1TC);

                            TRB1TC = new TableCell();
                            TRB1TC.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dr["M_ACD"].ToString();
                            TRB1TC.HorizontalAlign = HorizontalAlign.Left;
                            TRB1TC.CssClass = "blackfnt";
                            // TRB1TC.Wrap = false;
                            TRB1.Cells.Add(TRB1TC);


                            TRB1TC = new TableCell();

                            if (Convert.ToDouble(dr["BS_AMt"].ToString()) < 0)
                                TRB1TC.Text = "(" + dr["BS_AMt"].ToString().Replace("-", "") + ")";
                            else
                                TRB1TC.Text = dr["BS_AMt"].ToString();
                            TRB1TC.CssClass = "blackfnt";
                            TRB1TC.HorizontalAlign = HorizontalAlign.Right;
                            TRB1.Cells.Add(TRB1TC);



                            TRB1.BorderWidth = 1;
                            TRB1.BorderColor = System.Drawing.Color.Gray;
                            //TRB1.HorizontalAlign = HorizontalAlign.Center;
                            TRB1.BackColor = System.Drawing.Color.White;
                            TBL_BS_Det.Rows.Add(TRB1);
                        }
                  //  }
                    //else if (GRP == "2")
                    //{
                    //    //if (GRP_str != GRPNM)
                    //    //{
                    //        if (GRP_str != GRP_str_PR)
                    //        {
                    //            if (GRP_str_PR != "")
                    //            {
                    //                TableRow TRB2ic = new TableRow();
                    //                TableCell TRB2icTC = new TableCell();

                    //                TRB2icTC.Text = "";
                    //                TRB2icTC.CssClass = "bluefnt";
                    //                TRB2icTC.Font.Bold = true;
                    //                TRB2icTC.HorizontalAlign = HorizontalAlign.Center;
                    //                TRB2ic.Cells.Add(TRB2icTC);

                    //                TRB2icTC = new TableCell();
                    //                TRB2icTC.CssClass = "bluefnt";
                    //                TRB2icTC.Font.Bold = true;
                    //                TRB2icTC.ColumnSpan = 2;
                    //                TRB2icTC.HorizontalAlign = HorizontalAlign.Left;
                    //                TRB2ic.Cells.Add(TRB2icTC);
                    //                TRB2icTC.Text = "&nbsp;&nbsp;&nbsp;" + dr["groupdesc_m"].ToString();


                    //                TRB2ic.BorderWidth = 1;
                    //                TRB2ic.BorderColor = System.Drawing.Color.Gray;
                    //                //TRB2ic.HorizontalAlign = HorizontalAlign.Center;
                    //                TRB2ic.BackColor = System.Drawing.Color.White;
                    //                TBL_BS_Det.Rows.Add(TRB2ic);
                    //            }
                    //        }
                    //    //}

                    //    if (GRPNM != GRPNM_PR)
                    //    {
                    //        if (GRPNM_PR != "")
                    //        {
                    //            TableRow TRB2c = new TableRow();
                    //            TableCell TRB2cTC = new TableCell();

                    //            TRB2cTC.Text = "";
                    //            TRB2cTC.CssClass = "bluefnt";
                    //            TRB2cTC.Font.Bold = true;
                    //            TRB2cTC.HorizontalAlign = HorizontalAlign.Center;
                    //            TRB2c.Cells.Add(TRB2cTC);

                    //            TRB2cTC = new TableCell();
                                
                    //            TRB2cTC.CssClass = "blackfnt";
                    //            TRB2cTC.Font.Bold = false;
                    //            if (GRP_str == GRPNM)
                    //            {
                    //                TRB2cTC.CssClass = "bluefnt";
                    //                TRB2cTC.Font.Bold = true;
                    //            }
                    //            TRB2cTC.HorizontalAlign = HorizontalAlign.Left;
                    //            TRB2c.Cells.Add(TRB2cTC);
                    //            // TRB2cTC.Font.Bold = true;
                    //            TRB2cTC.Text = "&nbsp;&nbsp;&nbsp;"+  GRPNM_PR;
                    //           // TRB2cTC.ForeColor = System.Drawing.Color.Green;

                    //            TRB2cTC = new TableCell();
                    //            TRB2cTC.Text = totGRBSAMT.ToString("F2");
                    //            if (totGRBSAMT < 0)
                    //                TRB2cTC.Text = "(" + totGRBSAMT.ToString("F2").Replace("-", "") + ")";
                    //            else
                    //                TRB2cTC.Text = totGRBSAMT.ToString("F2");
                    //            TRB2cTC.CssClass = "blackfnt";
                    //           // TRB2cTC.Font.Bold = true;
                    //            TRB2cTC.HorizontalAlign = HorizontalAlign.Right;
                    //            TRB2c.Cells.Add(TRB2cTC);

                    //            TRB2c.BorderWidth = 1;
                    //            TRB2c.BorderColor = System.Drawing.Color.Gray;
                    //            //TRB2c.HorizontalAlign = HorizontalAlign.Center;
                    //            TRB2c.BackColor = System.Drawing.Color.White;
                    //            TBL_BS_Det.Rows.Add(TRB2c);
                    //            totGRBSAMT = 0;
                    //        }
                    //    }

                    //}


                    BSCATTYP_PR = dr["M_CAT_no"].ToString();
                    BSCATTYP_str_PR = dr["M_CAT"].ToString();
                    GRPNM_PR = dr["M_GCD"].ToString();
                    GRP_str_PR = dr["groupdesc_m"].ToString();
                    i += 1;

                    totBSAMT += Convert.ToDouble(dr["BS_AMt"].ToString());
                    totGRBSAMT += Convert.ToDouble(dr["BS_AMt"].ToString());
                }
            }
            dr.Close();

            TableRow TRB2_GT1 = new TableRow();
            TableCell TRB2_GT1TC = new TableCell();

            TRB2_GT1TC.Text = "";
            TRB2_GT1TC.CssClass = "bluefnt";
            TRB2_GT1TC.Font.Bold = true;
            TRB2_GT1TC.HorizontalAlign = HorizontalAlign.Right;
            TRB2_GT1.Cells.Add(TRB2_GT1TC);

            TRB2_GT1TC = new TableCell();
            TRB2_GT1TC.Text = "";
            
            // TRB2_GT1TC.ForeColor = System.Drawing.Color.MidnightBlue;
            
            //TRB2_GT1TC.Font.Size = 10;
            if (GRP == "1")
            {
                TRB2_GT1TC.Text = "Total Of " + GRP_str_PR + " : - ";
                TRB2_GT1TC.HorizontalAlign = HorizontalAlign.Right;
                TRB2_GT1TC.CssClass = "bluefnt";
                TRB2_GT1TC.Font.Bold = true;
            }
            else
            {
                TRB2_GT1TC.Text = "&nbsp;&nbsp;&nbsp;&nbsp;" + GRP_str_PR;
                TRB2_GT1TC.CssClass = "blackfnt";
                TRB2_GT1TC.HorizontalAlign = HorizontalAlign.Left;
                TRB2_GT1TC.Font.Bold = false;
            }
            
            TRB2_GT1.Cells.Add(TRB2_GT1TC);

            TRB2_GT1TC = new TableCell();

            if (totGRBSAMT < 0)
                TRB2_GT1TC.Text = "(" + totGRBSAMT.ToString("F2").Replace("-", "") + ")";
            else
                TRB2_GT1TC.Text = totGRBSAMT.ToString("F2");


            TRB2_GT1TC.CssClass = "bluefnt";
            TRB2_GT1TC.Font.Bold = true;
            TRB2_GT1TC.HorizontalAlign = HorizontalAlign.Right;
            TRB2_GT1.Cells.Add(TRB2_GT1TC);




            TRB2_GT1.BorderWidth = 1;
            TRB2_GT1.BorderColor = System.Drawing.Color.Gray;
            //TRB2_GT1.HorizontalAlign = HorizontalAlign.Center;
            TRB2_GT1.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB2_GT1);


            //if (GRP == "2")
            //{

            //    TableRow TRB2ci = new TableRow();
            //    TableCell TRB2ciTC = new TableCell();

            //    TRB2ciTC.Text = "";
            //    TRB2ciTC.CssClass = "bluefnt";
            //    TRB2ciTC.Font.Bold = true;
            //    TRB2ciTC.HorizontalAlign = HorizontalAlign.Center;
            //    TRB2ci.Cells.Add(TRB2ciTC);

            //    TRB2ciTC = new TableCell();
            //    TRB2ciTC.CssClass = "blackfnt";
            //    TRB2ciTC.HorizontalAlign = HorizontalAlign.Left;
            //    TRB2ci.Cells.Add(TRB2ciTC);
            //    // TRB2ciTC.Font.Bold = true;
            //    TRB2ciTC.Text = "&nbsp;&nbsp;&nbsp;" + GRPNM_PR;
            //    // TRB2ciTC.ForeColor = System.Drawing.Color.Green;

            //    TRB2ciTC = new TableCell();
            //    TRB2ciTC.Text = totGRBSAMT.ToString("F2");
            //    if (totGRBSAMT < 0)
            //        TRB2ciTC.Text = "(" + totGRBSAMT.ToString("F2").Replace("-", "") + ")";
            //    else
            //        TRB2ciTC.Text = totGRBSAMT.ToString("F2");
            //    TRB2ciTC.CssClass = "blackfnt";
            //    // TRB2ciTC.Font.Bold = true;
            //    TRB2ciTC.HorizontalAlign = HorizontalAlign.Right;
            //    TRB2ci.Cells.Add(TRB2ciTC);

            //    TRB2ci.BorderWidth = 1;
            //    TRB2ci.BorderColor = System.Drawing.Color.Gray;
            //    //TRB2ci.HorizontalAlign = HorizontalAlign.Center;
            //    TRB2ci.BackColor = System.Drawing.Color.White;
            //    TBL_BS_Det.Rows.Add(TRB2ci);
            //    totGRBSAMT = 0;
            //}

            TableRow TRB2b = new TableRow();
            TableCell TRB2bTC = new TableCell();

            TRB2bTC.Text = "";
            TRB2bTC.CssClass = "bluefnt";
            TRB2bTC.Font.Bold = true;
            TRB2bTC.HorizontalAlign = HorizontalAlign.Left;
            TRB2b.Cells.Add(TRB2bTC);

            TRB2bTC = new TableCell();
            TRB2bTC.Text = "";
            TRB2bTC.CssClass = "bluefnt";
            if (GRP == "1")
            {
                TRB2bTC.ForeColor = System.Drawing.Color.MidnightBlue;
                TRB2bTC.Font.Size = 10;
            }
                        TRB2bTC.Text = "Total Of " + BSCATTYP_str_PR + " : - ";
            
            TRB2bTC.Font.Bold = true;
           // TRB2bTC.ColumnSpan = 2;
            TRB2bTC.HorizontalAlign = HorizontalAlign.Right;
            TRB2b.Cells.Add(TRB2bTC);

            if (BSCATTYP_PR == "A")
                TOT_SF_1 = totBSAMT;
            else if (BSCATTYP_PR == "B")
                TOT_AF_1 = totBSAMT;
            else if (BSCATTYP_PR == "D")
                TOT_CL_1 = totBSAMT;
            else if (BSCATTYP_PR == "C")
                TOT_CA_1 = totBSAMT;

            TRB2bTC = new TableCell();
            if (totBSAMT < 0)
                TRB2bTC.Text = "(" + totBSAMT.ToString("F2").Replace("-", "") + ")";
            else
                TRB2bTC.Text = totBSAMT.ToString("F2");

            TRB2bTC.CssClass = "bluefnt";
            TRB2bTC.Font.Bold = true;
            TRB2bTC.HorizontalAlign = HorizontalAlign.Right;
            TRB2b.Cells.Add(TRB2bTC);

            TRB2b.BorderWidth = 1;
            TRB2b.BorderColor = System.Drawing.Color.Gray;
            //TRB2b.HorizontalAlign = HorizontalAlign.Center;
            TRB2b.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB2b);


            for (i = 0; i < 2; i++)
            {
                TableRow TRB7 = new TableRow();
                TableCell TRB7TC = new TableCell();

                TRB7TC.Text = "";
                TRB7TC.CssClass = "bluefnt";
                TRB7TC.Font.Bold = true;
                TRB7TC.ColumnSpan = 3;
                TRB7TC.HorizontalAlign = HorizontalAlign.Left;
                TRB7.Cells.Add(TRB7TC);
                TRB7.Height = 10;

                TRB7.BorderWidth = 1;
                TRB7.BorderColor = System.Drawing.Color.Gray;
                //TRB7.HorizontalAlign = HorizontalAlign.Center;
                TRB7.BackColor = System.Drawing.Color.White;
                TBL_BS_Det.Rows.Add(TRB7);
            }

            TableRow TRB8 = new TableRow();
            TableCell TRB8TC = new TableCell();


            TRB8TC.Text = "Net Current Assets :";
            TRB8TC.CssClass = "blackboldfnt";
            TRB8TC.Font.Bold = true;
            
            TRB8TC.HorizontalAlign = HorizontalAlign.Right;
            TRB8.Cells.Add(TRB8TC);
            TRB8TC.ColumnSpan = 2;
            double TOTNETCA = 0;
            TOTNETCA = TOT_CA_1 - TOT_CL_1;

            TRB8TC = new TableCell();

            if (TOTNETCA < 0)
                TRB8TC.Text = "(" + TOTNETCA.ToString("F2").Replace("-", "") + ")";
            else
                TRB8TC.Text = TOTNETCA.ToString("F2");
            TRB8TC.CssClass = "blackboldfnt";
            TRB8TC.Font.Bold = true;
            
            TRB8TC.HorizontalAlign = HorizontalAlign.Right;
            TRB8.Cells.Add(TRB8TC);

            TRB8.BorderWidth = 1;
            TRB8.BorderColor = System.Drawing.Color.Gray;
            //TRB8.HorizontalAlign = HorizontalAlign.Center;
            TRB8.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB8);


            for (i = 0; i < 2; i++)
            {
                TableRow TRB9 = new TableRow();
                TableCell TRB9TC = new TableCell();

                TRB9TC.Text = "";
                TRB9TC.CssClass = "bluefnt";
                TRB9TC.Font.Bold = true;
                TRB9TC.ColumnSpan = 3;               
                TRB9.Cells.Add(TRB9TC);

                if (i == 1)
                {
                    TRB9TC.Text = "Incremental Deduction Recoverable";
                    TRB9.HorizontalAlign = HorizontalAlign.Center;
                }
                else
                {
                    TRB9.Height = 10;
                }

                TRB9.BorderWidth = 1;
                TRB9.BorderColor = System.Drawing.Color.Gray;
                //TRB9.HorizontalAlign = HorizontalAlign.Center;
                TRB9.BackColor = System.Drawing.Color.White;
                TBL_BS_Det.Rows.Add(TRB9);
            }


            //TableRow TRB8a = new TableRow();
            //TableCell TRB8aTC = new TableCell();


            //TRB8aTC.Text = "A : - &nbsp;&nbsp;&nbsp;";
            //TRB8aTC.CssClass = "bluefnt";
            //TRB8aTC.Font.Bold = true;

            //TRB8aTC.HorizontalAlign = HorizontalAlign.Right;
            //TRB8a.Cells.Add(TRB8aTC);
            //TRB8aTC.ColumnSpan = 2;
           
            //TRB8aTC = new TableCell();

            //if (TOT_SF_1 < 0)
            //    TRB8aTC.Text = "(" + TOT_SF_1.ToString("F2").Replace("-", "") + ")";
            //else
            //    TRB8aTC.Text = TOT_SF_1.ToString("F2");
            //TRB8aTC.CssClass = "blackboldfnt";
            //TRB8aTC.Font.Bold = true;

            //TRB8aTC.HorizontalAlign = HorizontalAlign.Right;
            //TRB8a.Cells.Add(TRB8aTC);

            //TRB8a.BorderWidth = 1;
            //TRB8a.BorderColor = System.Drawing.Color.Gray;
            ////TRB8a.HorizontalAlign = HorizontalAlign.Center;
            //TRB8a.BackColor = System.Drawing.Color.White;
            //TBL_BS_Det.Rows.Add(TRB8a);

            //TableRow TRB8b = new TableRow();
            //TableCell TRB8bTC = new TableCell();


            //TRB8bTC.Text = "D : - &nbsp;&nbsp;&nbsp;";
            //TRB8bTC.CssClass = "bluefnt";
            //TRB8bTC.Font.Bold = true;

            //TRB8bTC.HorizontalAlign = HorizontalAlign.Right;
            //TRB8b.Cells.Add(TRB8bTC);
            //TRB8bTC.ColumnSpan = 2;

            //TRB8bTC = new TableCell();

            //if (TOT_CL_1 < 0)
            //    TRB8bTC.Text = "(" + TOT_CL_1.ToString("F2").Replace("-", "") + ")";
            //else
            //    TRB8bTC.Text = TOT_CL_1.ToString("F2");
            //TRB8bTC.CssClass = "blackboldfnt";
            //TRB8bTC.Font.Bold = true;

            //TRB8bTC.HorizontalAlign = HorizontalAlign.Right;
            //TRB8b.Cells.Add(TRB8bTC);

            //TRB8b.BorderWidth = 1;
            //TRB8b.BorderColor = System.Drawing.Color.Gray;
            ////TRB8b.HorizontalAlign = HorizontalAlign.Center;
            //TRB8b.BackColor = System.Drawing.Color.White;
            //TBL_BS_Det.Rows.Add(TRB8b);


            TableRow TRB8bi = new TableRow();
            TableCell TRB8biTC = new TableCell();

            double TOTAD = 0;
            TOTAD = TOT_CL_1 + TOT_SF_1;

            TRB8biTC.Text = "A + D : - &nbsp;&nbsp;&nbsp;";
            TRB8biTC.CssClass = "bluefnt";
            TRB8biTC.Font.Bold = true;

            TRB8biTC.HorizontalAlign = HorizontalAlign.Right;
            TRB8bi.Cells.Add(TRB8biTC);
            TRB8biTC.ColumnSpan = 2;

            TRB8biTC = new TableCell();

            if (TOTAD < 0)
                TRB8biTC.Text = "(" + TOTAD.ToString("F2").Replace("-", "") + ")";
            else
                TRB8biTC.Text = TOTAD.ToString("F2");
            TRB8biTC.CssClass = "blackboldfnt";
            TRB8biTC.Font.Bold = true;

            TRB8biTC.HorizontalAlign = HorizontalAlign.Right;
            TRB8bi.Cells.Add(TRB8biTC);

            TRB8bi.BorderWidth = 1;
            TRB8bi.BorderColor = System.Drawing.Color.Gray;
            //TRB8bi.HorizontalAlign = HorizontalAlign.Center;
            TRB8bi.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB8bi);

            TableRow TRB8bj = new TableRow();
            TableCell TRB8bjTC = new TableCell();

            double TOTLia = 0;
            TOTLia = TOT_CA_1 + TOT_AF_1;

            TRB8bjTC.Text = "B + C : - &nbsp;&nbsp;&nbsp;";
            TRB8bjTC.CssClass = "bluefnt";
            TRB8bjTC.Font.Bold = true;

            TRB8bjTC.HorizontalAlign = HorizontalAlign.Right;
            TRB8bj.Cells.Add(TRB8bjTC);
            TRB8bjTC.ColumnSpan = 2;

            TRB8bjTC = new TableCell();

            if (TOTLia < 0)
                TRB8bjTC.Text = "(" + TOTLia.ToString("F2").Replace("-", "") + ")";
            else
                TRB8bjTC.Text = TOTLia.ToString("F2");
            TRB8bjTC.CssClass = "blackboldfnt";
            TRB8bjTC.Font.Bold = true;

            TRB8bjTC.HorizontalAlign = HorizontalAlign.Right;
            TRB8bj.Cells.Add(TRB8bjTC);

            TRB8bj.BorderWidth = 1;
            TRB8bj.BorderColor = System.Drawing.Color.Gray;
            //TRB8bj.HorizontalAlign = HorizontalAlign.Center;
            TRB8bj.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB8bj);


            TableRow TRB9a = new TableRow();
            TableCell TRB9aTC = new TableCell();

            double TOTDiffBS = 0;
            TOTDiffBS = TOTAD - TOTLia;

            TRB9aTC.Text = "(B + C) - (A + D) : - &nbsp;&nbsp;&nbsp;";
            TRB9aTC.CssClass = "bluefnt";
            TRB9aTC.Font.Bold = true;

            TRB9aTC.HorizontalAlign = HorizontalAlign.Right;
            TRB9a.Cells.Add(TRB9aTC);
            TRB9aTC.ColumnSpan = 2;

            TRB9aTC = new TableCell();

            if (TOTDiffBS < 0)
            {
                TRB9aTC.Text = "(" + TOTDiffBS.ToString("F2").Replace("-", "") + ")";
                TRB9aTC.CssClass = "redfnt";
            }
            else
            {
                TRB9aTC.Text = TOTDiffBS.ToString("F2");
                TRB9aTC.CssClass = "bluefnt";
            }
            
            TRB9aTC.Font.Bold = true;

            TRB9aTC.HorizontalAlign = HorizontalAlign.Right;
            TRB9a.Cells.Add(TRB9aTC);

            TRB9a.BorderWidth = 1;
            TRB9a.BorderColor = System.Drawing.Color.Gray;
            //TRB9a.HorizontalAlign = HorizontalAlign.Center;
            TRB9a.BackColor = System.Drawing.Color.White;
            TBL_BS_Det.Rows.Add(TRB9a);
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
}
