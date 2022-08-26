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

public partial class GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    DataSet ds = new DataSet();
    public int i = 0;
    public string SQL_TB,FLG="N";
    string title="", title1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();          
           
        }
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
       
        string RO = "", LO = "", DateType = "", fromdt = "", todt = "", RPT = "", ST_CAT = "";
        string ST_ACC = "", ACC = "", st_cust_vend = "", st_cust_vend_name = "", rpt_SUB = "";

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT = Request.QueryString["RPT"].ToString();
        ST_CAT = Request.QueryString["ST_CAT"].ToString();
        ST_ACC = Request.QueryString["ST_ACC"].ToString();
        ACC = Request.QueryString["ACC"].ToString();
        st_cust_vend = Request.QueryString["st_cust_vend"].ToString();
        st_cust_vend_name = Request.QueryString["st_cust_vend_name"].ToString();
        rpt_SUB = Request.QueryString["rpt_SUB"].ToString();

        LBLDATE.Text = fromdt + " - " + todt;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        lblGrp.Text = ST_CAT;
        LBLSUBRPT.Text = ST_ACC;
        lblCust_vend.Text = st_cust_vend_name;

        if (RPT == "3")
        {
            lblCust_vend_typ.Text = "Customer";
        }
        else if (RPT == "4")
        {
            lblCust_vend_typ.Text = "Vendor";
        }
        else if (RPT == "5")
        {
            lblCust_vend_typ.Text = "Employee";
        } 
        else if (RPT == "6")
        {
            lblCust_vend_typ.Text = "Driver";
        }
        else 
        {
            lblCust_vend_typ.Text = "Customer/Vendor/Employee/Driver";
        }


        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
        SqlTransaction trans;
        trans = Conn.BeginTransaction();


        if (RO == LO)
            RO = "All";

        try
        {

            
             SQL_TB = "exec webxNet_TrailBalance '" + fromdt + "','" + todt + "','" + LO + "','" + RO + "','" + ST_CAT + "','" + ACC + "','" + st_cust_vend + "','" + RPT + "','" + rpt_SUB + "','" + yearSuffix + "'";
           // Response.Write("<BR> SQL_TB : " + SQL_TB);

            SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
	    sqlcmd12.CommandTimeout = 600;
            sqlcmd12.Transaction = trans;

            if (rpt_SUB != "3")
            {
                SqlDataReader dr = sqlcmd12.ExecuteReader();
                TBL_TB.Visible = true;
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

                if (RPT == "1")
                {
                    tc1.Text = "Group";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Sub Group";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                    tc2a.Text = "Sub Group 1";
                    tc2a.CssClass = "blackfnt";
                    tc2a.Wrap = false;
                    tr.Cells.Add(tc2a);

                    if (rpt_SUB == "1")
                    {
                        tc3.Text = "Account ";
                        tc3.CssClass = "blackfnt";
                        tc3.Wrap = false;
                        tr.Cells.Add(tc3);
                    }
                    if (rpt_SUB == "2")
                    {
                        tc3.Text = "Location";
                        tc3.CssClass = "blackfnt";
                        tc3.Wrap = false;
                        tr.Cells.Add(tc3);
                    }
                }
                else if (RPT == "2")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Location";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                }
                else if (RPT == "3")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Customer";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                }
                else if (RPT == "4")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Vendor";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                }
                else if (RPT == "5")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Employee";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                }
                else if (RPT == "7")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Driver";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                }
                else if (RPT == "6")
                {
                    tc1.Text = "SRNO";
                    tc1.CssClass = "blackfnt";
                    tc1.Wrap = false;
                    tr.Cells.Add(tc1);

                    tc2.Text = "Account";
                    tc2.CssClass = "blackfnt";
                    tc2.Wrap = false;
                    tr.Cells.Add(tc2);

                }

                if (RPT != "1")
                {
                    if (rpt_SUB == "1")
                    {
                        tc3.Text = "Account";
                        tc3.CssClass = "blackfnt";
                        tc3.Wrap = false;
                        tr.Cells.Add(tc3);

                    }
                    if (rpt_SUB == "2")
                    {
                        tc3.Text = "Location";
                        tc3.CssClass = "blackfnt";
                        tc3.Wrap = false;
                        tr.Cells.Add(tc3);
                    }

                }

                tc4.Text = "Opening Debit";
                tc4.CssClass = "blackfnt";
                tc4.Wrap = false;
                tr.Cells.Add(tc4);

                tc5.Text = "Opening Credit";
                tc5.CssClass = "blackfnt";
                tc5.Wrap = false;
                tr.Cells.Add(tc5);

                tc6.Text = "Current Debit";
                tc6.CssClass = "blackfnt";
                tc6.Wrap = false;
                tr.Cells.Add(tc6);

                tc7.Text = "Current Credit";
                tc7.CssClass = "blackfnt";
                tc7.Wrap = false;
                tr.Cells.Add(tc7);

                tc8.Text = "Closing Debit";
                tc8.CssClass = "blackfnt";
                tc8.Wrap = false;
                tr.Cells.Add(tc8);

                tc9.Text = "Closing Credit";
                tc9.CssClass = "blackfnt";
                tc9.Wrap = false;

                tr.Cells.Add(tc9);

                tr.BorderWidth = 1;
                tr.BorderColor = System.Drawing.Color.Gray;
                tr.CssClass = "bgbluegrey";
                TBL_TB.Rows.Add(tr);



                string mGroupDesc = "", PremGroupDesc = "", mMainGroup = "";
                string mSubGroupDesc = "", PremSubGroupDesc = "";
                double DIFF_OPN_Dr = 0, DIFF_OPN_Cr = 0, DIFF_CURR_Dr = 0, DIFF_CURR_Cr = 0, DIFF_CLOSE_Dr = 0, DIFF_CLOSE_Cr = 0;
                double TOT_OPN_Dr = 0, TOT_OPN_Cr = 0, TOT_CURR_Dr = 0, TOT_CURR_Cr = 0, TOT_CLOSE_Dr = 0, TOT_CLOSE_Cr = 0;
                double RO_TOT_OPN_Dr = 0, RO_TOT_OPN_Cr = 0, RO_TOT_CURR_Dr = 0, RO_TOT_CURR_Cr = 0, RO_TOT_CLOSE_Dr = 0, RO_TOT_CLOSE_Cr = 0;
                double OPN_Dr = 0, OPN_Cr = 0, CURR_Dr = 0, CURR_Cr = 0, CLOSE_Dr = 0, CLOSE_Cr = 0;

                int i = 1;
                while (dr.Read())
                {

                    OPN_Dr = Convert.ToDouble(dr["OPN_DEBIT"].ToString());
                    OPN_Cr = Convert.ToDouble(dr["OPN_Credit"].ToString());
                    CURR_Dr = Convert.ToDouble(dr["CURR_DEBIT"].ToString());
                    CURR_Cr = Convert.ToDouble(dr["CURR_Credit"].ToString());
                    CLOSE_Dr = Convert.ToDouble(dr["OPN_DEBIT"].ToString()) + Convert.ToDouble(dr["CURR_DEBIT"].ToString());
                    CLOSE_Cr = Convert.ToDouble(dr["OPN_Credit"].ToString()) + Convert.ToDouble(dr["CURR_Credit"].ToString());

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
                    if (RPT == "1")
                    {
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


                        
                    }
                    //if (RPT == "2" || RPT == "3" || RPT == "4" || RPT == "5" || RPT == "6" || RPT == "7")
                    //{
                    //}

                    if (RPT == "1")
                    {
                        mGroupDesc = dr["M_CAT"].ToString();
                        mSubGroupDesc = dr["groupdesc_m"].ToString();


                        if (mSubGroupDesc != PremSubGroupDesc && PremSubGroupDesc != "")
                        {



                            //RO_TOT_CLOSE_Dr = RO_TOT_OPN_Dr + RO_TOT_CURR_Dr;
                            //RO_TOT_CLOSE_Cr = RO_TOT_OPN_Cr + RO_TOT_CURR_Cr;


                            //if (RO_TOT_CLOSE_Dr > RO_TOT_CLOSE_Cr)
                            //{
                            //    RO_TOT_CLOSE_Dr = RO_TOT_CLOSE_Dr - RO_TOT_CLOSE_Cr;
                            //    RO_TOT_CLOSE_Cr = 0;
                            //}
                            //else
                            //{
                            //    RO_TOT_CLOSE_Cr = RO_TOT_CLOSE_Cr - RO_TOT_CLOSE_Dr;
                            //    RO_TOT_CLOSE_Dr = 0;
                            //}

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

                            if (rpt_SUB != "")
                            {
                                tr1atc3.Text = "";
                                tr1atc3.Wrap = false;
                                tr1atc3.CssClass = "blackfnt";
                                tr1atc3.Font.Bold = true;
                                tr1a.Cells.Add(tr1atc3);
                            }

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
                            tr1a.BorderWidth = 1;
                            tr1a.BorderColor = System.Drawing.Color.Gray;
                            TBL_TB.Rows.Add(tr1a);

                            RO_TOT_OPN_Dr = 0;
                            RO_TOT_OPN_Cr = 0;
                            RO_TOT_CURR_Dr = 0;
                            RO_TOT_CURR_Cr = 0;
                            RO_TOT_CLOSE_Dr = 0;
                            RO_TOT_CLOSE_Cr = 0;
                        }
                    }
                    else if (RPT == "2" || RPT == "3" || RPT == "4" || RPT == "5" || RPT == "6" || RPT == "7")
                    {

                        //mGroupDesc = dr["M_CAT"].ToString();
                        //mSubGroupDesc = dr["groupdesc_m"].ToString();

                        if (rpt_SUB != "")
                        {
                            //mGroupDesc = dr["M_CAT"].ToString();
                            mGroupDesc = dr["CD"].ToString() + " : " + dr["NM"].ToString();

                            if (mGroupDesc != PremGroupDesc && PremGroupDesc != "")
                            {

                                //RO_TOT_CLOSE_Dr = RO_TOT_OPN_Dr + RO_TOT_CURR_Dr;
                                //RO_TOT_CLOSE_Cr = RO_TOT_OPN_Cr + RO_TOT_CURR_Cr;


                                //if (RO_TOT_CLOSE_Dr > RO_TOT_CLOSE_Cr)
                                //{
                                //    RO_TOT_CLOSE_Dr = RO_TOT_CLOSE_Dr - RO_TOT_CLOSE_Cr;
                                //    RO_TOT_CLOSE_Cr = 0;
                                //}
                                //else
                                //{
                                //    RO_TOT_CLOSE_Cr = RO_TOT_CLOSE_Cr - RO_TOT_CLOSE_Dr;
                                //    RO_TOT_CLOSE_Dr = 0;
                                //}

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
                                tr1atc1.CssClass = "bluekfnt";
                                tr1atc1.Wrap = false;

                                tr1a.Cells.Add(tr1atc1);
                                tr1atc2.Text = "Total " + PremGroupDesc;
                                tr1atc2.CssClass = "bluekfnt";
                                tr1atc2.Font.Bold = true;
                                tr1atc2.ColumnSpan = 2;
                                tr1atc2.Wrap = false;

                                tr1a.Cells.Add(tr1atc2);


                                tr1atc4.Text = RO_TOT_OPN_Dr.ToString("F2");
                                tr1atc4.HorizontalAlign = HorizontalAlign.Right;
                                tr1atc4.CssClass = "bluekfnt";
                                tr1atc4.Wrap = false;
                                tr1atc4.Font.Bold = true;
                                tr1a.Cells.Add(tr1atc4);

                                tr1atc5.Text = RO_TOT_OPN_Cr.ToString("F2");
                                tr1atc5.HorizontalAlign = HorizontalAlign.Right;
                                tr1atc5.CssClass = "bluekfnt";
                                tr1atc5.Wrap = false;
                                tr1atc5.Font.Bold = true;
                                tr1a.Cells.Add(tr1atc5);

                                tr1atc6.Text = RO_TOT_CURR_Dr.ToString("F2");
                                tr1atc6.HorizontalAlign = HorizontalAlign.Right;
                                tr1atc6.Font.Bold = true;
                                tr1atc6.Wrap = false;
                                tr1atc6.CssClass = "bluekfnt";
                                tr1a.Cells.Add(tr1atc6);

                                tr1atc7.Text = RO_TOT_CURR_Cr.ToString("F2");
                                tr1atc7.HorizontalAlign = HorizontalAlign.Right;
                                tr1atc7.CssClass = "bluekfnt";
                                tr1atc7.Wrap = false;
                                tr1atc7.Font.Bold = true;
                                tr1a.Cells.Add(tr1atc7);

                                tr1atc8.Text = RO_TOT_CLOSE_Dr.ToString("F2");
                                tr1atc8.HorizontalAlign = HorizontalAlign.Right;
                                tr1atc8.CssClass = "bluekfnt";
                                tr1atc8.Wrap = false;
                                tr1atc8.Font.Bold = true;
                                tr1a.Cells.Add(tr1atc8);

                                tr1atc9.Text = RO_TOT_CLOSE_Cr.ToString("F2");
                                tr1atc9.HorizontalAlign = HorizontalAlign.Right;
                                tr1atc9.CssClass = "bluekfnt";
                                tr1atc9.Wrap = false;
                                tr1atc9.Font.Bold = true;
                                tr1a.CssClass = "bgbluegrey";
                                tr1a.Cells.Add(tr1atc9);
                                tr1a.Font.Bold = true;
                                //tr1a.BackColor = System.Drawing.Color.White;
                                tr1a.BorderWidth = 1;
                                tr1a.BorderColor = System.Drawing.Color.Gray;
                                TBL_TB.Rows.Add(tr1a);

                                RO_TOT_OPN_Dr = 0;
                                RO_TOT_OPN_Cr = 0;
                                RO_TOT_CURR_Dr = 0;
                                RO_TOT_CURR_Cr = 0;
                                RO_TOT_CLOSE_Dr = 0;
                                RO_TOT_CLOSE_Cr = 0;
                            }
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

                    if (RPT == "1")
                    {
                        if (mGroupDesc != PremGroupDesc)
                        {

                            Tr1tc1.Text = mGroupDesc;
                            // Tr1tc1.Font.Bold = true;
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

                        if (mSubGroupDesc != dr["NM"].ToString())
                        {
                            Tr1tc2a.Text = dr["NM"].ToString();
                        }
                        else
                        {
                            Tr1tc2a.Text = "";
                        }
                        Tr1tc2a.CssClass = "blackfnt";
                        Tr1tc2a.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc2a);
                        if (rpt_SUB != "")
                        {
                            string ST_ACCCD = dr["s_TYP"].ToString();
                            string ST_DWN_XLS = "N";
                            string dirlldown = "";// "branch=" + RO + "&ACCODE=" + ST_ACCCD + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo + "&Cumlative=" + Cumulative + "&TYP_CD=" + TYP_CD + "&DWN_XLS=" + ST_DWN_XLS;

                            Tr1tc3.Text = "<a href='Result_GL.aspx?" + dirlldown + "'><u>" + dr["M_ACD"].ToString() + "</u></a>";
                            Tr1tc3.Text = dr["M_ACD"].ToString();
                            Tr1tc3.CssClass = "blackfnt";
                            Tr1tc3.Wrap = false;
                            // tr1.CssClass = "bgbluegrey";
                            tr1.Cells.Add(Tr1tc3);
                        }
                    }


                    else if (RPT == "2" || RPT == "3" || RPT == "4" || RPT == "5" || RPT == "6" || RPT == "7")
                    {
                        Tr1tc1.Text = i.ToString();
                        Tr1tc1.CssClass = "blackfnt";
                        Tr1tc1.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc1);


                        Tr1tc2.Text = dr["CD"].ToString() + " : " + dr["NM"].ToString();
                        Tr1tc2.CssClass = "bluekfnt";
                        Tr1tc2.Wrap = false;
                        //tr1.CssClass = "bgbluegrey";
                        tr1.Cells.Add(Tr1tc2);
                        if (rpt_SUB != "")
                        {
                            if (mGroupDesc != PremGroupDesc)
                            {

                                Tr1tc2.Text = dr["CD"].ToString() + " : " + dr["NM"].ToString();
                                // Tr1tc2.Font.Bold = true;
                            }
                            else
                            {
                                Tr1tc2.Text = "";
                                //Tr1tc2.ColumnSpan = 2;
                            }
                        }
                        else
                        {
                            Tr1tc2.Text = dr["CD"].ToString() + " : " + dr["NM"].ToString();
                        }

                        if (rpt_SUB != "")
                        {
                            string ST_ACCCD = dr["s_TYP"].ToString();
                            string ST_DWN_XLS = "N";
                            string dirlldown = "";// "branch=" + RO + "&ACCODE=" + ST_ACCCD + "&dateFrom=" + dtFrom + "&dateTo=" + dtTo + "&Cumlative=" + Cumulative + "&TYP_CD=" + TYP_CD + "&DWN_XLS=" + ST_DWN_XLS;

                            Tr1tc3.Text = "<a href='Result_GL.aspx?" + dirlldown + "'><u>" + dr["M_ACD"].ToString() + "</u></a>";
                            Tr1tc3.Text = dr["M_ACD"].ToString();
                            Tr1tc3.CssClass = "blackfnt";
                            Tr1tc3.Wrap = false;
                            // tr1.CssClass = "bgbluegrey";
                            tr1.Cells.Add(Tr1tc3);
                        }

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
                    tr1.BorderWidth = 1;
                    tr1.BorderColor = System.Drawing.Color.Gray;
                    TBL_TB.Rows.Add(tr1);



                    if (RPT == "1")
                    {
                        PremGroupDesc = dr["M_CAT"].ToString();
                        PremSubGroupDesc = dr["groupdesc_m"].ToString();
                    }
                    else
                    {
                        PremGroupDesc = dr["CD"].ToString() + " : " + dr["NM"].ToString();
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

                //RO_TOT_CLOSE_Dr = RO_TOT_OPN_Dr + RO_TOT_CURR_Dr;
                //RO_TOT_CLOSE_Cr = RO_TOT_OPN_Cr + RO_TOT_CURR_Cr;


                //if (RO_TOT_CLOSE_Dr > RO_TOT_CLOSE_Cr)
                //{
                //    RO_TOT_CLOSE_Dr = RO_TOT_CLOSE_Dr - RO_TOT_CLOSE_Cr;
                //    RO_TOT_CLOSE_Cr = 0;
                //}
                //else
                //{
                //    RO_TOT_CLOSE_Cr = RO_TOT_CLOSE_Cr - RO_TOT_CLOSE_Dr;
                //    RO_TOT_CLOSE_Dr = 0;
                //}

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


                if (RPT == "1" || (rpt_SUB != "" && (RPT == "2" || RPT == "3" || RPT == "4" || RPT == "5" || RPT == "6" || RPT == "7")))
                {
                    tr1btc1.Text = "";
                    tr1btc1.CssClass = "blackfnt";
                    tr1btc1.Wrap = false;
                    if (RPT == "1")
                    {
                        tr1b.Cells.Add(tr1btc1);
                        tr1btc2.Text = "Total " + mSubGroupDesc;
                        tr1btc2.CssClass = "blackfnt";
                        tr1btc2.Font.Bold = true;
                        //tr1btc2.ColumnSpan = 2;
                        if (rpt_SUB != "")
                        {
                            tr1btc2.ColumnSpan = 2;
                        }
                        else
                        {
                            tr1btc2.Text = "";
                        }
                        tr1btc2.Wrap = false;
                    }
                    else
                    {
                        tr1b.Cells.Add(tr1btc1);
                        tr1btc2.Text = "Total " + mGroupDesc;
                        tr1btc2.CssClass = "blackfnt";
                        tr1btc2.Font.Bold = true;

                        tr1btc2.Wrap = false;
                    }

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
                    tr1b.BorderWidth = 1;
                    tr1b.BorderColor = System.Drawing.Color.Gray;
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

                if (RPT == "1")
                {
                    tr1ctc1.Text = "";
                    tr1ctc1.CssClass = "blackfnt";
                    tr1ctc1.Wrap = false;

                    tr1c.Cells.Add(tr1ctc1);
                    tr1ctc2.Text = "";
                    tr1ctc2.CssClass = "blackfnt";
                    if (rpt_SUB != "")
                    {
                        tr1ctc2.ColumnSpan = 2;
                    }
                    else
                    {
                        tr1ctc2.Text = "";
                    }
                    tr1ctc2.Font.Bold = true;
                    tr1ctc2.Wrap = false;

                    tr1c.Cells.Add(tr1ctc2);
                    tr1ctc3.Text = "Diff in Balances";
                    tr1ctc3.Wrap = false;
                    tr1ctc3.CssClass = "blackfnt";
                    tr1ctc3.Font.Bold = true;
                    tr1c.Cells.Add(tr1ctc3);
                }
                else if (RPT == "2" || RPT == "3" || RPT == "4" || RPT == "5" || RPT == "6" || RPT == "7")
                {
                    tr1ctc2.Text = "Diff in Balances ";
                    tr1ctc2.CssClass = "blackfnt";
                    tr1ctc2.Font.Bold = true;
                    tr1ctc2.Wrap = false;
                    if (rpt_SUB != "")
                    {
                        tr1ctc2.Font.Bold = true;
                        tr1ctc2.ColumnSpan = 3;
                    }
                    else
                    {
                        tr1ctc2.ColumnSpan = 2;
                    }
                    tr1c.Cells.Add(tr1ctc2);
                }
                //else if (RPT == "5")
                //{


                //    tr1ctc2.Text = "Total ";
                //    tr1ctc2.CssClass = "blackfnt";
                //    tr1ctc2.Font.Bold = true;
                //    tr1ctc2.Wrap = false;
                //    tr1ctc2.ColumnSpan = 2;
                //    tr1c.Cells.Add(tr1ctc2);
                //}

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
                tr1c.BorderWidth = 1;
                tr1c.BorderColor = System.Drawing.Color.Gray;
                tr1c.BorderWidth = 1;
                tr1c.BorderColor = System.Drawing.Color.Gray;
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

                if (RPT == "1")
                {
                    tr1dtc1.Text = "";
                    tr1dtc1.CssClass = "blackfnt";
                    tr1dtc1.Wrap = false;

                    tr1d.Cells.Add(tr1dtc1);
                    tr1dtc2.Text = "";
                    tr1dtc2.CssClass = "blackfnt";
                    //tr1dtc2.ColumnSpan = 2;
                    tr1dtc2.Font.Bold = true;
                    tr1dtc2.Wrap = false;
                    if (rpt_SUB != "")
                    {
                        tr1dtc2.ColumnSpan = 2;
                    }
                    else
                    {
                        tr1dtc2.Text = "";
                    }

                    tr1d.Cells.Add(tr1dtc2);
                    tr1dtc3.Text = "Total";
                    tr1dtc3.Wrap = false;
                    tr1dtc3.CssClass = "blackfnt";
                    tr1dtc3.Font.Bold = true;
                    tr1d.Cells.Add(tr1dtc3);
                }
                else if (RPT == "2" || RPT == "3" || RPT == "4" || RPT == "5" || RPT == "6" || RPT == "7")
                {
                    tr1dtc2.Text = "Total ";
                    tr1dtc2.CssClass = "blackfnt";
                    tr1dtc2.Font.Bold = true;

                    tr1dtc2.Wrap = false;
                    if (rpt_SUB != "")
                    {
                        tr1dtc2.Font.Bold = true;
                        tr1dtc2.ColumnSpan = 3;
                    }
                    else
                    {
                        tr1dtc2.ColumnSpan = 2;
                    }
                    tr1d.Cells.Add(tr1dtc2);
                }
                else if (RPT == "5")
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
                tr1d.BorderWidth = 1;
                tr1d.BorderColor = System.Drawing.Color.Gray;
                TBL_TB.Rows.Add(tr1d);
                dr.Close();

            }
            else
            {
                GRV_TB.Visible = true;
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
                
                da.Fill(ds);
                GRV_TB.DataSource = ds;
                GRV_TB.DataBind();
               
            }

                trans.Commit();
            
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                // abc = "Insert Susccessfully !!!!!!!";

            }
            Response.Write("<BR> SQL_TB : " + SQL_TB);
            trans.Rollback();
            Conn.Close();
            Response.End();
        }

        Conn.Close();

    }
    protected void GRV_TB_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       

        if (e.Row.RowType == DataControlRowType.Header)
        {
            string RPT = Request.QueryString["RPT"].ToString();

            if (RPT == "1")
            {
                e.Row.Cells[1].Text = "Groups";
            }
            else if (RPT == "2")
            {
                e.Row.Cells[1].Text = "Location ";
            }
            else if (RPT == "3")
            {
                e.Row.Cells[1].Text = "Customer ";
            }
            else if (RPT == "4")
            {
                e.Row.Cells[1].Text = "Vendor ";
            }
            else if (RPT == "5")
            {
                e.Row.Cells[1].Text = "Employee ";
            }
            else if (RPT == "6")
            {
                e.Row.Cells[1].Text = "Accounts ";
            }
            else if (RPT == "7")
            {
                e.Row.Cells[1].Text = "Driver ";
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label titleLabel = (Label)e.Row.FindControl("lblACC");
            string strval = ((Label)(titleLabel)).Text;
            title = (string)ViewState["lblACC"];
            if (title == strval && e.Row.RowIndex > 0)
            {
                titleLabel.Visible = false;
                titleLabel.Text = string.Empty;
            }
            else
            {
                title = strval;
                ViewState["lblACC"] = title;
                titleLabel.Visible = true;
                titleLabel.Text = "<b>" + title + "</b>";
            }

            Label lblcust_vend = (Label)e.Row.FindControl("lblCust");
            string strval1 = ((Label)(lblcust_vend)).Text;
            title1 = (string)ViewState["lblCust"];
            if (title1 == strval1 && e.Row.RowIndex > 0)
            {
                lblcust_vend.Visible = false;
                lblcust_vend.Text = string.Empty;
            }
            else
            {
                title1 = strval1;
                ViewState["lblCust"] = title1;
                lblcust_vend.Visible = true;
                lblcust_vend.Text = "<b>" + title1 + "</b>";
                i = 0;
            }

             if (e.Row.Cells[0].Text.ToString().Trim() == "Opening Balance :")
             {
                 e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                 e.Row.Cells[6].Font.Bold = true;
                 e.Row.Cells[7].Font.Bold = true;
             }
             else if (e.Row.Cells[0].Text.ToString().Trim() == "Total Transaction :")
             {
                 e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                 e.Row.Cells[4].Font.Bold = true;
                 e.Row.Cells[5].Font.Bold = true;
             }
             else if (e.Row.Cells[0].Text.ToString().Trim() == "Total for A/C (Dr./Cr.) :")
             {
                 e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                 e.Row.Cells[4].Font.Bold = true;
                 e.Row.Cells[5].Font.Bold = true;
             }
             else if (e.Row.Cells[0].Text.ToString().Trim() == "Closing Balance :")
             {
                 e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                 e.Row.Cells[4].Font.Bold = true;
                 e.Row.Cells[5].Font.Bold = true;
             }
             else
             {
                 i += 1;
                 e.Row.Cells[0].Text = i.ToString();
                 e.Row.Cells[0].Font.Bold = false;
             }
        }

    }

    //protected void dgDocket_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    //{
    //    Label titleLabel = (Label)e.Row.FindControl("lnk0");
    //       // Label titleLabel1 = (Label)e.Row.FindControl("lnk0");
    //        string strval = ((Label)(titleLabel)).Text;
    //        title = (string)ViewState["lnk0"];
    //        if (title == strval && e.Row.RowIndex > 0)
    //        {
    //            titleLabel.Visible = false;
    //            titleLabel.Text = string.Empty;
    //        }
    //        else
    //        {
    //            title = strval;
    //            ViewState["lnk0"] = title;
    //            titleLabel.Visible = true;
    //            titleLabel.Text = "<b>" + title + "</b>";
    //        }
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        if (e.Row.Cells[0].Text.ToString().Trim() == "Opening Balance :")
    //        {
    //            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
    //            e.Row.Cells[4].Font.Bold = true;
    //            e.Row.Cells[5].Font.Bold = true;
    //        }
    //        else if (e.Row.Cells[0].Text.ToString().Trim() == "Total Transaction :")
    //        {
    //            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
    //            e.Row.Cells[4].Font.Bold = true;
    //            e.Row.Cells[5].Font.Bold = true;
    //        }
    //        else if (e.Row.Cells[0].Text.ToString().Trim() == "Total for A/C (Dr./Cr.) :")
    //        {
    //            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
    //            e.Row.Cells[4].Font.Bold = true;
    //            e.Row.Cells[5].Font.Bold = true;
    //        }
    //        else if (e.Row.Cells[0].Text.ToString().Trim() == "Closing Balance :")
    //        {
    //            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
    //            e.Row.Cells[4].Font.Bold = true;
    //            e.Row.Cells[5].Font.Bold = true;
    //        }
    //        else
    //        {
    //            i += 1;
    //            e.Row.Cells[0].Text = i.ToString();
    //            e.Row.Cells[0].Font.Bold = false;
    //        }

           

    //    }

    //}

    public void DWN_XLS()
    {
        
        TBL_CRI.Border = 1;

        TBL_TB.BorderWidth = 1;
        TBL_TB.BorderColor = System.Drawing.Color.Gray;
        TBL_TB.Font.Name = "verdana";
        TBL_TB.Font.Size = 8;
        GRV_TB.AllowPaging = false;
        GRV_TB.BorderWidth = 1;
        GRV_TB.BorderColor = System.Drawing.Color.Gray;
        GRV_TB.Font.Name = "verdana";
        GRV_TB.Font.Size = 8;
               
            //BindGrid();
       
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TB.xls");
        Response.Charset = "";
       
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        
        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(TBL_TB);
        frm.Controls.Add(GRV_TB);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
}
