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
public partial class GUI_UNI_MIS_OPN_Flow_result : System.Web.UI.Page
{
    public static string DateType, dkt_call, fromdt, todt, RO, LO, St_paylist, st_trnlist, st_delist, st_mode, st_status;
    string Doc_type;
    public static string strDateRange;
    public static string strro, strro_val;
    public static string strloc;


    double tot_doc = 0, tot_bookloc = 0, tot_moved = 0, tot_arrived = 0, tot_inTrans = 0, tot_dely = 0, tot_gone4del = 0, tot_withRe = 0, tot_woRe = 0;

    double RO_tot_doc = 0, RO_tot_bookloc = 0, RO_tot_moved = 0, RO_tot_arrived = 0, RO_tot_inTrans = 0, RO_tot_dely = 0, RO_tot_gone4del = 0, RO_tot_withRe = 0, RO_tot_woRe = 0;

    

    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        //St_paylist = Request.QueryString["St_paylist"].ToString();
        //st_trnlist = Request.QueryString["st_trnlist"].ToString();
        //st_delist = Request.QueryString["st_delist"].ToString();


        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateType == "Date")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (DateType == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");



        string sql_st = "exec webx_Opn_Flow_analysis '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();

        SqlDataReader dr = sqlcmd12.ExecuteReader();



        TableRow tr1a = new TableRow();
        TableCell tr1atc1 = new TableCell();
        TableCell tr1atc2 = new TableCell();

        TableCell tr1atc3 = new TableCell();
        TableCell tr1atc4 = new TableCell();
        TableCell tr1atc5 = new TableCell();
        TableCell tr1atc6 = new TableCell();
        TableCell tr1atc7 = new TableCell();
        TableCell tr1atc8 = new TableCell();
        TableCell tr1atc9 = new TableCell();
        TableCell tr1atc10 = new TableCell();
        TableCell tr1atc11 = new TableCell();
        TableCell tr1atc12 = new TableCell();


        tr1atc1.Text = "Sr No.";
        tr1atc1.CssClass = "blackboldfnt";
        tr1atc1.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc1);

        string b1 = "";
            tr1atc2.Text = "Location";
       
        tr1atc2.CssClass = "blackboldfnt";
        tr1atc2.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc2);

        tr1atc3.Text = "Total " + dkt_call + "s Booked";
        tr1atc3.CssClass = "blackboldfnt";
        tr1atc3.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc3);

        tr1atc4.Text = "Total " + dkt_call + "s "+ b1 + "<br> "+ b1 +" At Booking Location";
        tr1atc4.CssClass = "blackboldfnt";
        tr1atc4.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc4);

        tr1atc5.Text = "Total " + dkt_call + "s Moveed";
        tr1atc5.CssClass = "blackboldfnt";
        tr1atc5.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc5);

        tr1atc6.Text = "Total " + dkt_call + "s Arrived" + b1 + "<br> " + b1 + " At Delivery Location";
        tr1atc6.CssClass = "blackboldfnt";
        tr1atc6.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc6);

        tr1atc7.Text = "Total " + dkt_call + "s In Transit";
        tr1atc7.CssClass = "blackboldfnt";
        tr1atc7.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc7);

        tr1atc8.Text = "Total " + dkt_call + "s Delivered";
        tr1atc8.CssClass = "blackboldfnt";
        tr1atc8.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc8);

        tr1atc9.Text = "Total " + dkt_call + "s " + b1 + "<br> " + b1 + "Gone Fore Delivery ";
        tr1atc9.CssClass = "blackboldfnt";
        tr1atc9.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc9);

        tr1atc10.Text = "Total " + dkt_call + "s Delivered" + b1 + "<br> " + b1 + "With Reason";
        tr1atc10.CssClass = "blackboldfnt";
        tr1atc10.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc10);

        tr1atc11.Text = "Total " + dkt_call + "s Delivered" + b1 + "<br> " + b1 + "W/O Reason";
        tr1atc11.CssClass = "blackboldfnt";
        tr1atc11.Wrap = false;
        tr1a.CssClass = "bgbluegrey";
        tr1a.Cells.Add(tr1atc11);

        //tr1atc12.Text = "Total " + dkt_call + " Booked";
        //tr1atc12.CssClass = "blackboldfnt";
        //tr1atc12.Wrap = false;
        //tr1a.CssClass = "bgbluegrey";
        //tr1a.Cells.Add(tr1atc12);


        tr1a.HorizontalAlign = HorizontalAlign.Center;
        TBL_OPNFlow.Rows.Add(tr1a);
        

        int i = 1;
        string CRo = "", PrevRO = "";
        while (dr.Read())
        {

            CRo = dr["report_loc"].ToString();
            if (CRo != PrevRO && PrevRO != "")
            {
                TableRow tr2aa = new TableRow();
                TableCell tr2aatc1 = new TableCell();
                TableCell tr2aatc2 = new TableCell();
                TableCell tr2aatc3 = new TableCell();
                TableCell tr2aatc4 = new TableCell();
                TableCell tr2aatc5 = new TableCell();
                TableCell tr2aatc6 = new TableCell();
                TableCell tr2aatc7 = new TableCell();
                TableCell tr2aatc8 = new TableCell();
                TableCell tr2aatc9 = new TableCell();
                TableCell tr2aatc10 = new TableCell();

                TableCell tr2aatc11 = new TableCell();
            

                tr2aatc2.Text = strro_val;
                tr2aatc2.CssClass = "blackfnt";
                tr2aatc2.Wrap = false;
                tr2aatc2.HorizontalAlign = HorizontalAlign.Center;
                tr2aatc2.ColumnSpan = 2;
                tr2aatc2.Font.Bold = true;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc2);

                tr2aatc3.Text = RO_tot_doc.ToString();
                tr2aatc3.CssClass = "blackfnt";
                tr2aatc3.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc3);

                tr2aatc4.Text = RO_tot_bookloc.ToString();
                tr2aatc4.CssClass = "blackfnt";
                tr2aatc4.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc4);

                tr2aatc5.Text = RO_tot_moved.ToString();
                tr2aatc5.CssClass = "blackfnt";
                tr2aatc5.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc5);

                tr2aatc6.Text = RO_tot_arrived.ToString();
                tr2aatc6.CssClass = "blackfnt";
                tr2aatc6.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc6);

                tr2aatc7.Text = RO_tot_inTrans.ToString();
                tr2aatc7.CssClass = "blackfnt";
                tr2aatc7.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc7);

                tr2aatc8.Text = RO_tot_dely.ToString();
                tr2aatc8.CssClass = "blackfnt";
                tr2aatc8.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc8);

                tr2aatc9.Text = RO_tot_gone4del.ToString();
                tr2aatc9.CssClass = "blackfnt";
                tr2aatc9.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc9);

                tr2aatc10.Text = RO_tot_withRe.ToString();
                tr2aatc10.CssClass = "blackfnt";
                tr2aatc10.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc10);

                tr2aatc11.Text = RO_tot_woRe.ToString();
                tr2aatc11.CssClass = "blackfnt";
                tr2aatc11.Wrap = false;
                tr2aa.CssClass = "blackfnt";
                tr2aa.Cells.Add(tr2aatc11);


                tr2aa.CssClass = "bluefnt";
                tr2aa.BackColor = System.Drawing.Color.White;
                tr2aa.HorizontalAlign = HorizontalAlign.Center;
                TBL_OPNFlow.Rows.Add(tr2aa);


                RO_tot_doc = 0;
                RO_tot_bookloc = 0;
                RO_tot_moved = 0;
                RO_tot_arrived = 0;
                RO_tot_inTrans = 0;
                RO_tot_dely = 0;
                RO_tot_gone4del = 0;
                RO_tot_withRe = 0;
                RO_tot_woRe = 0;


          
            }



            TableRow tr2a = new TableRow();
            TableCell tr2atc1 = new TableCell();
            TableCell tr2atc2 = new TableCell();
            TableCell tr2atc3 = new TableCell();
            TableCell tr2atc4 = new TableCell();
            TableCell tr2atc5 = new TableCell();
            TableCell tr2atc6 = new TableCell();
            TableCell tr2atc7 = new TableCell();
            TableCell tr2atc8 = new TableCell();
            TableCell tr2atc9 = new TableCell();
            TableCell tr2atc10 = new TableCell();

            TableCell tr2atc11 = new TableCell();
       

            tr2atc1.Text = i.ToString();
            tr2atc1.CssClass = "blackfnt";
            tr2atc1.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc1);

            tr2atc2.Text = dr["loccode"].ToString() + " : " + dr["locname"].ToString();
            tr2atc2.CssClass = "blackfnt";
            tr2atc2.Wrap = false;
            tr2atc2.HorizontalAlign = HorizontalAlign.Left;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc2);

            string rptno = "", dirlldown = "";
            rptno = "1";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno ;

            tr2atc3.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_dkts"].ToString() + "</u></a>";
            tr2atc3.Text = dr["tot_dkts"].ToString() ;
            tr2atc3.CssClass = "blackfnt";
            tr2atc3.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc3);
            rptno = "1";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno;

            tr2atc4.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_bookigloc"].ToString() + "</u></a>";
            tr2atc4.Text = dr["tot_bookigloc"].ToString();
            tr2atc4.CssClass = "blackfnt";
            tr2atc4.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc4);

            rptno = "2";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno ;

            tr2atc5.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_moved"].ToString() + "</u></a>";
            tr2atc5.Text = dr["tot_moved"].ToString();
            tr2atc5.CssClass = "blackfnt";
            tr2atc5.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc5);

            rptno = "1";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno;

            tr2atc6.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_Arrived"].ToString() + "</u></a>";
            tr2atc6.Text = dr["tot_Arrived"].ToString();
            tr2atc6.CssClass = "blackfnt";
            tr2atc6.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc6);

            rptno = "3";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno ;

            tr2atc7.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_In_transit"].ToString() + "</u></a>";
            tr2atc7.Text = dr["tot_In_transit"].ToString();
            tr2atc7.CssClass = "blackfnt";
            tr2atc7.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc7);

            rptno = "1";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno;

            tr2atc8.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_deld"].ToString() + "</u></a>";
            tr2atc8.Text = dr["tot_deld"].ToString();
            tr2atc8.CssClass = "blackfnt";
            tr2atc8.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc8);

            rptno = "4";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno ;

            tr2atc9.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_gene4del"].ToString() + "</u></a>";
            tr2atc9.Text = dr["tot_gene4del"].ToString();
            tr2atc9.CssClass = "blackfnt";
            tr2atc9.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc9);

            rptno = "1";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno;

            tr2atc10.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_with_reason"].ToString() + "</u></a>";
            tr2atc10.Text = dr["tot_with_reason"].ToString();
            tr2atc10.CssClass = "blackfnt";
            tr2atc10.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc10);

            rptno = "5";
            dirlldown = "branch=" + dr["loccode"].ToString() + "&fromdt=" + dtFrom + "&todt=" + dtTo + "&RPT_no=" + rptno ;

            tr2atc11.Text = "<a href='results_det.aspx?" + dirlldown + "'><u>" + dr["tot_wo_reason"].ToString() + "</u></a>";
            tr2atc11.Text = dr["tot_wo_reason"].ToString();
            tr2atc11.CssClass = "blackfnt";
            tr2atc11.Wrap = false;
            tr2a.CssClass = "blackfnt";
            tr2a.Cells.Add(tr2atc11);
                       
            tr2a.BackColor = System.Drawing.Color.White;
            tr2a.HorizontalAlign = HorizontalAlign.Center;
            TBL_OPNFlow.Rows.Add(tr2a);

            i = i + 1;



            tot_doc += Convert.ToDouble(dr["tot_dkts"].ToString());
            tot_bookloc += Convert.ToDouble(dr["tot_bookigloc"].ToString());
            tot_moved += Convert.ToDouble(dr["tot_moved"].ToString());
            tot_arrived += Convert.ToDouble(dr["tot_Arrived"].ToString());
            tot_inTrans += Convert.ToDouble(dr["tot_In_transit"].ToString());
            tot_dely += Convert.ToDouble(dr["tot_deld"].ToString());
            tot_gone4del += Convert.ToDouble(dr["tot_gene4del"].ToString());
            tot_withRe += Convert.ToDouble(dr["tot_with_reason"].ToString());
            tot_woRe += Convert.ToDouble(dr["tot_wo_reason"].ToString());

            RO_tot_doc += Convert.ToDouble(dr["tot_dkts"].ToString());
            RO_tot_bookloc += Convert.ToDouble(dr["tot_bookigloc"].ToString());
            RO_tot_moved += Convert.ToDouble(dr["tot_moved"].ToString());
            RO_tot_arrived += Convert.ToDouble(dr["tot_Arrived"].ToString());
            RO_tot_inTrans += Convert.ToDouble(dr["tot_In_transit"].ToString());
            RO_tot_dely += Convert.ToDouble(dr["tot_deld"].ToString());
            RO_tot_gone4del += Convert.ToDouble(dr["tot_gene4del"].ToString());
            RO_tot_withRe += Convert.ToDouble(dr["tot_with_reason"].ToString());
            RO_tot_woRe += Convert.ToDouble(dr["tot_wo_reason"].ToString());
                  

            PrevRO = dr["report_loc"].ToString();
            strro_val = dr["report_locname"].ToString();
        }

        conn.Close();

        TableRow tr2ab = new TableRow();
        TableCell tr2abtc1 = new TableCell();
        TableCell tr2abtc2 = new TableCell();
        TableCell tr2abtc3 = new TableCell();
        TableCell tr2abtc4 = new TableCell();
        TableCell tr2abtc5 = new TableCell();
        TableCell tr2abtc6 = new TableCell();
        TableCell tr2abtc7 = new TableCell();
        TableCell tr2abtc8 = new TableCell();
        TableCell tr2abtc9 = new TableCell();
        TableCell tr2abtc10 = new TableCell();

        TableCell tr2abtc11 = new TableCell();
        

        tr2abtc2.Text = strro_val;
        tr2abtc2.CssClass = "blackfnt";
        tr2abtc2.Wrap = false;
        tr2abtc2.HorizontalAlign = HorizontalAlign.Center;
        tr2abtc2.ColumnSpan = 2;
        tr2abtc2.Font.Bold = true;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc2);

        tr2abtc3.Text = RO_tot_doc.ToString();
        tr2abtc3.CssClass = "blackfnt";
        tr2abtc3.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc3);

        tr2abtc4.Text = RO_tot_bookloc.ToString();
        tr2abtc4.CssClass = "blackfnt";
        tr2abtc4.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc4);

        tr2abtc5.Text = RO_tot_moved.ToString();
        tr2abtc5.CssClass = "blackfnt";
        tr2abtc5.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc5);

        tr2abtc6.Text = RO_tot_arrived.ToString();
        tr2abtc6.CssClass = "blackfnt";
        tr2abtc6.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc6);

        tr2abtc7.Text = RO_tot_inTrans.ToString();
        tr2abtc7.CssClass = "blackfnt";
        tr2abtc7.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc7);

        tr2abtc8.Text = RO_tot_dely.ToString();
        tr2abtc8.CssClass = "blackfnt";
        tr2abtc8.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc8);

        tr2abtc9.Text = RO_tot_gone4del.ToString();
        tr2abtc9.CssClass = "blackfnt";
        tr2abtc9.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc9);

        tr2abtc10.Text = RO_tot_withRe.ToString();
        tr2abtc10.CssClass = "blackfnt";
        tr2abtc10.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc10);

        tr2abtc11.Text = RO_tot_woRe.ToString();
        tr2abtc11.CssClass = "blackfnt";
        tr2abtc11.Wrap = false;
        tr2ab.CssClass = "blackfnt";
        tr2ab.Cells.Add(tr2abtc11);



        tr2ab.CssClass = "bluefnt";
        tr2ab.BackColor = System.Drawing.Color.White;
        tr2ab.HorizontalAlign = HorizontalAlign.Center;
        TBL_OPNFlow.Rows.Add(tr2ab);


        TableRow tr2ac = new TableRow();
        TableCell tr2actc1 = new TableCell();
        TableCell tr2actc2 = new TableCell();
        TableCell tr2actc3 = new TableCell();
        TableCell tr2actc4 = new TableCell();
        TableCell tr2actc5 = new TableCell();
        TableCell tr2actc6 = new TableCell();
        TableCell tr2actc7 = new TableCell();
        TableCell tr2actc8 = new TableCell();
        TableCell tr2actc9 = new TableCell();
        TableCell tr2actc10 = new TableCell();

        TableCell tr2actc11 = new TableCell();
        

        tr2actc2.Text = "Total";
        //tr2actc2.CssClass = "blackfnt";
        tr2actc2.Wrap = false;
        tr2actc2.HorizontalAlign = HorizontalAlign.Center;
        tr2actc2.ColumnSpan = 2;
        tr2actc2.Font.Bold = true;
        //tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc2);

        tr2actc3.Text = tot_doc.ToString();
        //tr2actc3.CssClass = "blackfnt";
        tr2actc3.Wrap = false;
        //tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc3);

        tr2actc4.Text = tot_bookloc.ToString();
        //tr2actc4.CssClass = "blackfnt";
        tr2actc4.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc4);

        tr2actc5.Text = tot_moved.ToString();
        // tr2actc5.CssClass = "blackfnt";
        tr2actc5.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc5);

        tr2actc6.Text = tot_arrived.ToString();
        //tr2actc6.CssClass = "blackfnt";
        tr2actc6.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc6);

        tr2actc7.Text = tot_inTrans.ToString();
        //tr2actc7.CssClass = "blackfnt";
        tr2actc7.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc7);

        tr2actc8.Text = tot_dely.ToString();
        // tr2actc8.CssClass = "blackfnt";
        tr2actc8.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc8);

        tr2actc9.Text = tot_gone4del.ToString();
        //tr2actc9.CssClass = "blackfnt";
        tr2actc9.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc9);

        tr2actc10.Text = tot_withRe.ToString();
        //tr2actc10.CssClass = "blackfnt";
        tr2actc10.Wrap = false;
        //tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc10);

        tr2actc11.Text = tot_woRe.ToString();
        // tr2actc11.CssClass = "blackfnt";
        tr2actc11.Wrap = false;
        // tr2ac.CssClass = "blackfnt";
        tr2ac.Cells.Add(tr2actc11);

   
        tr2ac.CssClass = "bluefnt";
        tr2ac.Font.Bold = true;
        tr2ac.BackColor = System.Drawing.Color.White;
        tr2ac.HorizontalAlign = HorizontalAlign.Center;

        TBL_OPNFlow.Rows.Add(tr2ac);



        conn.Close();
    }



    protected void btn_csv_Click(object sender, EventArgs e)
    {

        //dgDocket.AllowPaging = false;
        TBL_OPNFlow.BorderWidth = 1;
        //dgDocket.CssClass = "blackfnt";
        //dgDocket.Font.Size = 10;



        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=OPN_FLow_report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(TBL_OPNFlow);


        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();





    }
    protected void dgDocket_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
