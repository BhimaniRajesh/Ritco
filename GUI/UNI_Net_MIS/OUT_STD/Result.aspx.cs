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

public partial class GUI_UNI_MIS_OUT_STD_Result : System.Web.UI.Page
{
    SqlConnection Conn;
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

        string RO = "", LO = "", RTP_DT_str = "", fromdt = "", todt = "", RPT = "", RTP_DT = "", BM_TYP;
        string frm_as_dt = "", to_as_dt = "", st_cust_vend = "",CustRPT="", st_cust_vend_name = "", rpt_SUB = "";

        double RO_GEN = 0, RO_SUB = 0, RO_COLL = 0;
        double TOT_GEN = 0, TOT_SUB = 0, TOT_COLL = 0;

        double RO_UNDUE = 0, RO_0_30 = 0, RO_31_60 = 0, RO_61_90 = 0, RO_91_180 = 0, RO_180 = 0, RO_365 = 0, RO_Total = 0;
        double TOT_UNDUE = 0, TOT_0_30 = 0, TOT_31_60 = 0, TOT_61_90 = 0, TOT_91_180 = 0, TOT_180 = 0, TOT_365 = 0, TOT_Total = 0;

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT = Request.QueryString["RPT"].ToString();
        st_cust_vend = Request.QueryString["st_cust_vend"].ToString();
        st_cust_vend_name = Request.QueryString["st_cust_vend_name"].ToString();
        rpt_SUB = Request.QueryString["rpt_SUB"].ToString();
        RTP_DT = Request.QueryString["RTP_DT"].ToString();
        RTP_DT_str = Request.QueryString["RTP_DT_str"].ToString();
        BM_TYP = Request.QueryString["BM_TYP"].ToString();
        frm_as_dt = Request.QueryString["frm_as_dt"].ToString();
        to_as_dt = Request.QueryString["to_as_dt"].ToString();
        CustRPT= Request.QueryString["CustRPT"].ToString();

        lbltypBill.Text = BM_TYP;
        LBLDATE.Text = fromdt + " - " + todt;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        lblGrp.Text = st_cust_vend_name;
        Label1.Text = RTP_DT_str;

        LBLSUBRPT.Text = frm_as_dt + " - " + to_as_dt;
        if (RPT != "4")
        {
            LBLSUBRPT.Text = frm_as_dt;
        }

        if (st_cust_vend == "All")
        {
            st_cust_vend = "";
        }

        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);
        if (RO == LO)
            RO = "All";
        string SQL_STR = "EXEC WebxNet_OutStd '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + st_cust_vend + "','" + frm_as_dt + "','" + to_as_dt + "','" + RTP_DT + "','" + RPT + "','" + rpt_SUB + "','" + yearSuffix + "','" + BM_TYP + "','" + CustRPT + "'";
       //Response.Write(" OUT STD Query : -" + SQL_STR);
       // Response.End();
        SqlCommand CMD = new SqlCommand(SQL_STR,Conn);
        SqlDataReader DR = CMD.ExecuteReader();
        TBL_TB.Visible = true;
        TableRow TR = new TableRow();
        TableCell TRTC1 = new TableCell();

        
            

        TRTC1.Text = "SRNO";
        TRTC1.CssClass = "blackboldfnt";
        TR.Cells.Add(TRTC1);

       
        TRTC1 = new TableCell();
        TRTC1.Text = "Location";
        if (RPT == "3" || RPT == "4")
        {
            TRTC1.Text = "Customer";
        }
        TRTC1.CssClass = "blackboldfnt";
        
        TR.Cells.Add(TRTC1);

        if (rpt_SUB != "")
        {
            TRTC1 = new TableCell();
            TRTC1.Text = "Location";
            if (rpt_SUB == "2")
            {
                TRTC1.Text = "Customer";
            }
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);
        }

        if (RPT == "1")
        {
            TRTC1 = new TableCell();
            TRTC1.Text = "Generated";            
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "To Be Submitted";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "To Be Collected";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);
        }
        if (RPT == "2" || RPT == "3")
        {
            if (RPT == "3")
            {
                TRTC1 = new TableCell();
                TRTC1.Text = "On Acc. Balance";
                TRTC1.CssClass = "blackboldfnt";
                TR.Cells.Add(TRTC1);

                TRTC1 = new TableCell();
                TRTC1.Text = "Ledger Balance";
                TRTC1.CssClass = "blackboldfnt";
                TR.Cells.Add(TRTC1);
            }
            TRTC1 = new TableCell();
            TRTC1.Text = "Undue";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "0-30";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "31-60";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "61-90";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "91-180";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "181-365";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = ">365";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "Total";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

        }
        if (RPT == "4")
        {
            
            TRTC1 = new TableCell();
            TRTC1.Text = "From As On <br><font class='bluefnt'><b>" + frm_as_dt + "</b></font>";
            TRTC1.Wrap = false;
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "Generated";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "Recived";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "To As On <br><font class='bluefnt'><b>" + to_as_dt + "</b></font>";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "On Acc. Balance";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

            TRTC1 = new TableCell();
            TRTC1.Text = "Ledger Balance";
            TRTC1.CssClass = "blackboldfnt";
            TR.Cells.Add(TRTC1);

           
        }


        TR.BorderWidth = 1;
        TR.HorizontalAlign = HorizontalAlign.Center;
        TR.BorderColor = System.Drawing.Color.Gray;
        TR.CssClass = "bgbluegrey";
        TBL_TB.Rows.Add(TR);

        string C_LOC = "", P_LOC = "", C_RO= "", P_RO = "";

        int i = 1;
        while (DR.Read())
        {

            if (RPT == "1" || RPT == "2")
            {
                C_RO = DR["report_loc_name"].ToString();

                if (C_RO != P_RO && P_RO != "")
                {
                    TableRow TR2 = new TableRow();
                    TableCell TR2TC1 = new TableCell();

                    TR2TC1.Text = P_RO.ToString();
                    TR2TC1.CssClass = "bluefnt";
                    TR2TC1.Font.Bold = true;
                    TR2TC1.ColumnSpan = 2;
                    if (rpt_SUB != "")
                    {
                        TR2TC1.ColumnSpan = 3;
                    }
                    TR2TC1.HorizontalAlign = HorizontalAlign.Center;
                    TR2.Cells.Add(TR2TC1);

                    if (RPT == "1")
                    {
                       
       

      // string dirlldown = "RO=" + RO + "&LO=" + LO + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=" + RPT + "&RPT=" + RPT + "&st_cust_vend=" + st_cust_vend + "&st_cust_vend_name=" + st_cust_vend_name + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&frm_as_dt=" + frm_as_dt + "&to_as_dt=" + to_as_dt + "&CustRPT=1&RMD=N";

                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_GEN.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);

                       // dirlldown = "RO=" + RO + "&LO=" + LO + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=" + RPT + "&RPT=" + RPT + "&st_cust_vend=" + st_cust_vend + "&st_cust_vend_name=" + st_cust_vend_name + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&frm_as_dt=" + frm_as_dt + "&to_as_dt=" + to_as_dt + "&CustRPT=2&RMD=N";

                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_SUB.ToString("F2");
                        //TR2TC1.Text = "<a href='Result.aspx?" + dirlldown + "'><u>" + RO_SUB.ToString("F2") + "</u></a>";
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2.Cells.Add(TR2TC1);

                    //    dirlldown = "RO=" + RO + "&LO=" + LO + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=" + RPT + "&RPT=" + RPT + "&st_cust_vend=" + st_cust_vend + "&st_cust_vend_name=" + st_cust_vend_name + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&frm_as_dt=" + frm_as_dt + "&to_as_dt=" + to_as_dt + "&CustRPT=2&RMD=N";

                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_COLL.ToString("F2");
                       // TR2TC1.Text = "<a href='Result.aspx?" + dirlldown + "'><u>" + RO_COLL.ToString("F2") + "</u></a>";
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);

                        RO_COLL = 0;
                        RO_GEN = 0;
                        RO_SUB = 0;
                    }
                    if (RPT == "2")
                    {
                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_UNDUE.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_0_30.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_31_60.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_COLL.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_61_90.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_91_180.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_180.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);

                        TR2TC1 = new TableCell();
                        TR2TC1.Text = RO_Total.ToString("F2");
                        TR2TC1.CssClass = "bluefnt";
                        TR2TC1.Font.Bold = true;
                        TR2TC1.HorizontalAlign = HorizontalAlign.Right;
                        TR2.Cells.Add(TR2TC1);


                        RO_UNDUE = 0;
                        RO_0_30 = 0;
                        RO_31_60 = 0;
                        RO_61_90 = 0;
                        RO_91_180 = 0;
                        RO_180 = 0;
                        RO_Total = 0;
                    }

                    TR2.BorderWidth = 1;
                    TR2.BackColor = System.Drawing.Color.White;
                    TR2.BorderColor = System.Drawing.Color.Gray;
                    TBL_TB.Rows.Add(TR2);


                   
                }
            }


            TableRow TR1 = new TableRow();
            TableCell TR1TC1 = new TableCell();

           // TR1TC1 = new TableCell();
            TR1TC1.Text = i.ToString();
            TR1TC1.CssClass = "blackfnt";
            TR1TC1.HorizontalAlign = HorizontalAlign.Center;
            TR1.Cells.Add(TR1TC1);

            if (RPT == "3" || RPT == "4")
            {
                C_LOC = DR["custnm"].ToString();
            }
            else if (RPT == "1" || RPT == "2")
            {
                C_LOC = DR["locname"].ToString();
            }

            if (rpt_SUB == "")
            {
                TR1TC1 = new TableCell();
                if (RPT == "3" || RPT == "4")
                {
                    TR1TC1.Text = DR["custnm"].ToString();
                }
                else if (RPT == "1" || RPT == "2")
                {
                    TR1TC1.Text = DR["locname"].ToString();
                }
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.Wrap = false;
                TR1TC1.HorizontalAlign = HorizontalAlign.Left;
                TR1.Cells.Add(TR1TC1);
            }
            if (rpt_SUB != "")
            {
                
                TR1TC1 = new TableCell();
                TR1TC1.Text = "";
                if (C_LOC != P_LOC)
                {                    
                    TR1TC1.Text = C_LOC.ToString();                    
                }

                TR1TC1.CssClass = "blackfnt";
                TR1TC1.Wrap = false;
                TR1TC1.HorizontalAlign = HorizontalAlign.Left;
                TR1.Cells.Add(TR1TC1);

                TR1TC1 = new TableCell();
                TR1TC1.Text= DR["LOC_CUST"].ToString();                
                TR1TC1.CssClass = "bluefnt";
                TR1TC1.Wrap = false;
                TR1.Cells.Add(TR1TC1);
            }

            if (RPT == "1")
            {
                string abc=" : ";
                if (rpt_SUB != "")
                {
                    string[] strDRILL = DR["LOC_CUST"].ToString().Split(':');
                    abc = strDRILL[0].ToString();
                }
                else
                {
                    abc="";
                }


                string dirlldown = "RO=" + RO + "&LO=" + DR["loccode"].ToString() + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=3&st_cust_vend=" + abc + "&st_cust_vend_name=" + st_cust_vend_name + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&frm_as_dt=" + frm_as_dt + "&to_as_dt=" + to_as_dt + "&CustRPT=1&RMD=N&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["Generated"].ToString();
                TR1TC1.Text = "<a href='Result.aspx?" + dirlldown + "'><u>" + DR["Generated"].ToString() + "</u></a>";
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown = "RO=" + RO + "&LO=" + DR["loccode"].ToString() + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=3&st_cust_vend=" + abc + "&st_cust_vend_name=" + st_cust_vend_name + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&frm_as_dt=" + frm_as_dt + "&to_as_dt=" + to_as_dt + "&CustRPT=2&RMD=N&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["To_BE_Submitted"].ToString();
                TR1TC1.Text = "<a href='Result.aspx?" + dirlldown + "'><u>" + DR["To_BE_Submitted"].ToString() + "</u></a>";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1TC1.CssClass = "blackfnt";
                TR1.Cells.Add(TR1TC1);

                dirlldown = "RO=" + RO + "&LO=" + DR["loccode"].ToString() + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=3&st_cust_vend=" + abc + "&st_cust_vend_name=" + st_cust_vend_name + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&frm_as_dt=" + frm_as_dt + "&to_as_dt=" + to_as_dt + "&CustRPT=3&RMD=N&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["To_BE_Collected"].ToString();
                TR1TC1.Text = "<a href='Result.aspx?" + dirlldown + "'><u>" + DR["To_BE_Collected"].ToString() + "</u></a>";
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                TR1.BorderWidth = 1;
                TR1.BackColor = System.Drawing.Color.White;
                TR1.BorderColor = System.Drawing.Color.Gray;
                TBL_TB.Rows.Add(TR1);

                RO_GEN += Convert.ToDouble(DR["Generated"].ToString());
                RO_SUB += Convert.ToDouble(DR["To_BE_Submitted"].ToString());
                RO_COLL += Convert.ToDouble(DR["To_BE_Collected"].ToString());


                TOT_GEN += Convert.ToDouble(DR["Generated"].ToString());
                TOT_SUB += Convert.ToDouble(DR["To_BE_Submitted"].ToString());
                TOT_COLL += Convert.ToDouble(DR["To_BE_Collected"].ToString());
            }
            if (RPT == "2" || RPT == "3")
            {
                if (RPT == "3")
                {
                    TR1TC1 = new TableCell();
                    TR1TC1.Text = DR["On_AC_balance"].ToString();
                    TR1TC1.CssClass = "blackfnt";
                    TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR1.Cells.Add(TR1TC1);

                    TR1TC1 = new TableCell();
                    TR1TC1.Text = DR["Ledger_balance"].ToString();
                    TR1TC1.CssClass = "blackfnt";
                    TR1TC1.Wrap = false;
                    TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR1.Cells.Add(TR1TC1);
                }
                string lc="", ct="",ctstr="";
                if (RPT == "2")
                {
                    lc = DR["loccode"].ToString();
                    ct = Request.QueryString["st_cust_vend"].ToString();
                    ctstr = Request.QueryString["st_cust_vend_name"].ToString();
                    if (rpt_SUB == "2")
                    {
                        ct = DR["LOC_CUST_cd"].ToString();
                    }
                }
                else if (RPT == "3")
                {
                    ct = DR["custcd"].ToString();
                    lc = Request.QueryString["LO"].ToString();
                    ctstr = DR["custnm"].ToString();
                    if (rpt_SUB == "1")
                    {
                        lc = DR["LOC_CUST_cd"].ToString();
                    }
                }


                if (RTP_DT == "bgndt")
                    RTP_DT = "1";
                else if (RTP_DT == "bcldt")
                    RTP_DT = "2";
                else if (RTP_DT == "bsbdt")
                    RTP_DT = "4";

                string dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=7&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";

                TR1TC1 = new TableCell();
                if (DR["Undue"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue"].ToString() + "</u></a>";
                }
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=8&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                if (DR["Undue_0_30"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue_0_30"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue_0_30"].ToString() + "</u></a>";
                } 
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=9&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";

                TR1TC1 = new TableCell();
                if (DR["Undue_31_60"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue_31_60"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue_31_60"].ToString() + "</u></a>";
                } 
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=10&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                if (DR["Undue_61_90"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue_61_90"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue_61_90"].ToString() + "</u></a>";
                } 
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=11&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                if (DR["Undue_91_180"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue_91_180"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue_91_180"].ToString() + "</u></a>";
                } 
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=12&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                if (DR["Undue_181_365"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue_181_365"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue_181_365"].ToString() + "</u></a>";
                } 
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=13&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                if (DR["Undue_365"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Undue_365"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Undue_365"].ToString() + "</u></a>";
                } 
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown1 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + fromdt + "&todt=" + todt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=14&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";
                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["Generated"].ToString();
                TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown1 + "'><u>" + DR["Generated"].ToString() + "</u></a>";
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.Wrap = false;
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                TR1.BorderWidth = 1;
                TR1.BackColor = System.Drawing.Color.White;
                TR1.BorderColor = System.Drawing.Color.Gray;
                TBL_TB.Rows.Add(TR1);

                RO_UNDUE += Convert.ToDouble(DR["Undue"].ToString()) ;
                RO_0_30 += Convert.ToDouble(DR["Undue_0_30"].ToString());
                RO_31_60 += Convert.ToDouble(DR["Undue_31_60"].ToString());
                RO_61_90 += Convert.ToDouble(DR["Undue_61_90"].ToString());
                RO_91_180 += Convert.ToDouble(DR["Undue_91_180"].ToString());
                RO_180 += Convert.ToDouble(DR["Undue_181_365"].ToString());
                RO_365 += Convert.ToDouble(DR["Undue_365"].ToString());
                RO_Total += Convert.ToDouble(DR["Generated"].ToString());

                TOT_UNDUE += Convert.ToDouble(DR["Undue"].ToString());
                TOT_0_30 += Convert.ToDouble(DR["Undue_0_30"].ToString());
                TOT_31_60 += Convert.ToDouble(DR["Undue_31_60"].ToString());
                TOT_61_90 += Convert.ToDouble(DR["Undue_61_90"].ToString());
                TOT_91_180 += Convert.ToDouble(DR["Undue_91_180"].ToString());
                TOT_180 += Convert.ToDouble(DR["Undue_181_365"].ToString());
                TOT_Total += Convert.ToDouble(DR["Generated"].ToString());
                TOT_365 += Convert.ToDouble(DR["Undue_365"].ToString());
            }
            if (RPT == "4")
            {
                if (RTP_DT == "bgndt")
                    RTP_DT = "1";
                else if (RTP_DT == "bcldt")
                    RTP_DT = "2";
                else if (RTP_DT == "bsbdt")
                    RTP_DT = "4";

                string ct, lc, ctstr;
                ct = DR["custcd"].ToString();
                lc = Request.QueryString["LO"].ToString();
                ctstr = DR["custnm"].ToString();
                if (rpt_SUB == "1")
                {
                    lc = DR["LOC_CUST_cd"].ToString();
                }
                string dirlldown2 = "RO=" + RO + "&LO=" + lc + "&fromdt=01 Jan 00&todt=" + System.DateTime.Today.ToString("dd MMM yy") + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=15&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";

                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["fromason"].ToString();
                if (DR["fromason"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["fromason"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown2 + "'><u>" + DR["fromason"].ToString() + "</u></a>";
                }
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown2 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + frm_as_dt + "&todt=" + to_as_dt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=16&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";

                TR1TC1 = new TableCell();
                
                if (DR["billgenamt"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["billgenamt"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown2 + "'><u>" + DR["billgenamt"].ToString() + "</u></a>";
                }
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);


                dirlldown2 = "RO=" + RO + "&LO=" + lc + "&fromdt=" + frm_as_dt + "&todt=" + to_as_dt + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=17&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";

                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["Recvamt"].ToString();
                if (DR["Recvamt"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["Recvamt"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown2 + "'><u>" + DR["Recvamt"].ToString() + "</u></a>";
                }
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                dirlldown2 = "RO=" + RO + "&LO=" + lc + "&fromdt=01 Jan 00&todt=" + System.DateTime.Today.ToString("dd MMM yy") + "&RPT=B&st_cust_vend=" + ct + "&st_cust_vend_name=" + ctstr + "&rpt_SUB=" + rpt_SUB + "&RTP_DT=" + RTP_DT + "&RTP=B&RTP_DT_str=" + RTP_DT_str + "&BM_TYP=" + BM_TYP + "&BM_STATUS_str=All&BM_STATUS=18&CS_CHQ=All&DKTST=&AMT_G_THAN=0&OV_DYS=0&BILLNO_list=&MANBNOLIST=&DKTSNOLIST=&M_L_TYP=All&Select_list=Billno,manualbillno,BillGenDT,bbrcd,TYp,PARTY,BILL_STATuS,billcolbrcd,BillCollDT,paymode,billsubbrcd,BillSUBDT,BillDueDT,DUE_DYAS,STAX_CESS_HCESS,dbo.FN_MR_FORBILL(BILLNO,1),dbo.FN_MR_FORBILL(BILLNO,2),billamt,CLAMT,PENDAMT,FRT_DED,CLM_DED,TDS_DED,UNE_DED,BCANEMPCD,Bcan_dt,billno&Select_Text=Bill No.,Manual Bill No.,Bill Date,Bill Location,Bill Type,Bill Party,Bill Status,Collection At,Collection Date,Collection BY,Submission At,Submission Date,Due Date,Overdue Days ,Service Tax   Cess   H.Cess,MR No.,MR Date,Amount,Collection Amount,Pending Amount ,Deduction,Claim,TDS,Unadjusted Amount,Cancelled By ,Cancelled On , View&RMD=0&ASONDT=" + frm_as_dt + "&ASONDT_to=" + to_as_dt + "&TYPDET=" + CustRPT + "";

                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["ToASon"].ToString();
                if (DR["ToASon"].ToString() == "0.00")
                {
                    TR1TC1.Text = DR["ToASon"].ToString();
                }
                else
                {
                    TR1TC1.Text = "<a href='../BILL_MR_Register/Result.aspx?" + dirlldown2 + "'><u>" + DR["ToASon"].ToString() + "</u></a>";
                }
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["On_AC_balance"].ToString();
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                TR1TC1 = new TableCell();
                TR1TC1.Text = DR["Ledger_balance"].ToString();
                TR1TC1.Wrap = false;
                TR1TC1.CssClass = "blackfnt";
                TR1TC1.HorizontalAlign = HorizontalAlign.Right;
                TR1.Cells.Add(TR1TC1);

                TR1.BorderWidth = 1;
                TR1.BackColor = System.Drawing.Color.White;
                TR1.BorderColor = System.Drawing.Color.Gray;
                TBL_TB.Rows.Add(TR1);
            }

            if (RPT == "3" || RPT == "4")
            {
                P_LOC = DR["custnm"].ToString();
            }
            else if (RPT == "1" || RPT == "2")
            {
                P_LOC = DR["locname"].ToString();
            }

           
            i += 1;
            if (RPT == "1" || RPT == "2")
            {
                P_RO = DR["report_loc_name"].ToString();
            }

        }
        if (RPT == "1" || RPT == "2")
        {
            TableRow TR3 = new TableRow();
            TableCell TR3TC1 = new TableCell();

            TR3TC1.Text = P_RO.ToString();
            TR3TC1.CssClass = "bluefnt";
            TR3TC1.Font.Bold = true;
            TR3TC1.ColumnSpan = 2;
            if (rpt_SUB != "")
            {
                TR3TC1.ColumnSpan = 3;
            }
            TR3TC1.HorizontalAlign = HorizontalAlign.Center;
            TR3.Cells.Add(TR3TC1);
            if (RPT == "1")
            {
                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_GEN.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);

                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_SUB.ToString("F2");
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3.Cells.Add(TR3TC1);

                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_COLL.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);
            }
            else if (RPT == "2")
            {
                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_UNDUE.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);


                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_0_30.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);


                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_31_60.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);
                
                

                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_61_90.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);


                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_91_180.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);


                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_180.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);

                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_365.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);

                TR3TC1 = new TableCell();
                TR3TC1.Text = RO_Total.ToString("F2");
                TR3TC1.CssClass = "bluefnt";
                TR3TC1.Font.Bold = true;
                TR3TC1.HorizontalAlign = HorizontalAlign.Right;
                TR3.Cells.Add(TR3TC1);
            }

            TR3.BorderWidth = 1;
            TR3.BackColor = System.Drawing.Color.White;
            TR3.BorderColor = System.Drawing.Color.Gray;
            TBL_TB.Rows.Add(TR3);
        }
            TableRow TR4 = new TableRow();
            TableCell TR4TC1 = new TableCell();

            if (RPT != "4")
            {
                TR4TC1.Text = "Total";
                TR4TC1.CssClass = "bluefnt";
                TR4TC1.Font.Bold = true;
                TR4TC1.ColumnSpan = 2;
                if (rpt_SUB != "")
                {
                    TR4TC1.ColumnSpan = 3;
                }
                if (RPT == "3")
                {
                    TR4TC1.ColumnSpan = 4;
                    if (rpt_SUB != "")
                    {
                        TR4TC1.ColumnSpan = 5;
                    }
                }
                TR4TC1.HorizontalAlign = HorizontalAlign.Center;
                TR4.Cells.Add(TR4TC1);
                if (RPT == "1")
                {
                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_GEN.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);

                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_SUB.ToString("F2");
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4.Cells.Add(TR4TC1);

                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_COLL.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);
                }
                else if (RPT == "2" || RPT == "3")
                {
                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_UNDUE.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);

                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_0_30.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);


                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_31_60.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);


                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_61_90.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);


                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_91_180.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);


                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_180.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);

                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_365.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);

                    TR4TC1 = new TableCell();
                    TR4TC1.Text = TOT_Total.ToString("F2");
                    TR4TC1.CssClass = "bluefnt";
                    TR4TC1.Font.Bold = true;
                    TR4TC1.HorizontalAlign = HorizontalAlign.Right;
                    TR4.Cells.Add(TR4TC1);
                }
                TR4.BorderWidth = 1;
                TR4.BackColor = System.Drawing.Color.White;
                TR4.BorderColor = System.Drawing.Color.Gray;
                TBL_TB.Rows.Add(TR4);
            }

        DR.Close();
        Conn.Close();

    }
    public void DWN_XLS()
    {

        TBL_CRI.Border = 1;

        TBL_TB.BorderWidth = 1;
        TBL_TB.BorderColor = System.Drawing.Color.Gray;
        TBL_TB.Font.Name = "verdana";
        TBL_TB.Font.Size = 8;


        //BindGrid();

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Account_Receivable.xls");
        Response.Charset = "";

        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(TBL_TB);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

        protected void btn_csv_Click(object sender, EventArgs e)
        {
            DWN_XLS();
        }
}
