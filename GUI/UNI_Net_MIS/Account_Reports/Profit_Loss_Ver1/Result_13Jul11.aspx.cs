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

public partial class GUI_UNI_MIS_Account_Reports_Profit_Loss_Ver1_Result : System.Web.UI.Page
{
    SqlConnection conn;
    double st_totinc = 0, st_totexp = 0, st_profit_loss = 0, tot_cashdebit = 0, tot_cashcredit = 0, cashclosedebit = 0, cashclosecredit = 0, tot_bankdebit = 0, tot_bankcredit = 0, bankClosecredit = 0, bankClosedebit = 0;
    public static string strDateRange,RPT_GL_LOC, String_loccode, chkstate, String_accode, rpt_typ, ACCOunts, a_todt, a_frmdt, finyearstart, strCust, strro, AcctOpenTable, AcctTable, ledgerof, strindividual, mFromdt, acccode, partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            string Year = Session["FinYear"].ToString();

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
            strro = Request.QueryString["RO"].ToString();
            chkstate = Request.QueryString["chkstate"].ToString();
            rpt_typ = Request.QueryString["Flowtype"].ToString();
            strDateRange = Request.QueryString["DOCDate"].ToString();
            string[] strDateRange_arr = strDateRange.Split('-');
            a_todt = strDateRange_arr[1].ToString().Trim();
            a_frmdt = strDateRange_arr[0].ToString().Trim();
            lblseldet.Text = strDateRange;
           
            //strro = "HQTR";
            lblro.Text = strro;
           

            string SQL_Closing = "";
            if (rpt_typ == "0")
            {
               // rpt_typ = "Y";
                SQL_Closing = "exec Webx_profitloss_closingbalance_Net_Ver1 '" + mAcctTransTable + "','" + AcctTable + "','" + strro + "','" + a_todt + "','Y','" + a_frmdt + "'";
            }
            else
            {
                //rpt_typ = "N";
                SQL_Closing = "exec Webx_profitloss_closingbalance_Net_Ver1 '" + mAcctTransTable + "','" + AcctTable + "','" + strro + "','" + a_todt + "','N','" + a_frmdt + "'";
            }
          
            SqlCommand cmd3Closing = new SqlCommand(SQL_Closing, conn);
            cmd3Closing.ExecuteNonQuery();
            BindGrid();
            

         

        }

    }
    public void BindGrid()
    {
        strro = Request.QueryString["RO"].ToString();
        chkstate = Request.QueryString["chkstate"].ToString();
        rpt_typ = Request.QueryString["Flowtype"].ToString();
        strDateRange = Request.QueryString["DOCDate"].ToString();
        string CUM = "";
        if (rpt_typ == "0")
            CUM = "N";
        else
            CUM = "Y";
        RPT_GL_LOC = strro;
        if (rpt_typ == "0")
        {
            rpt_typ = "N";
            strro=strro;
            
        }
        else if (rpt_typ == "1")
        {
            rpt_typ = "Y";
            if (Session["HeadOfficeCode"].ToString() == strro)
            {
                strro = "";
            }
            else
            {
                strro = strro;
            }
        }
        else if (rpt_typ == "2")
        {
            rpt_typ = "N";
            strro = "All";

        }



        TableRow tr = new TableRow();
        

        TableCell trtc1 = new TableCell();
        TableCell trtc2 = new TableCell();
        TableCell trtc3 = new TableCell();
        

        if (chkstate == "False")
            chkstate = "N";
        else
            chkstate = "Y";

        trtc1.Text = "Group/Sub Group";
       // trtc1.RowSpan = 2;
        trtc1.CssClass = "blackfnt";
        trtc1.Wrap = false;
        tr.Cells.Add(trtc1);

        //trtc2.Text = "Sub Group";
        ////trtc2.RowSpan = 2;
        //trtc2.CssClass = "blackfnt";
        //trtc2.Wrap = false;
        //tr.Cells.Add(trtc2);

        trtc3.Text = "Total " + RPT_GL_LOC;
        //trtc3.RowSpan = 2;
        trtc3.CssClass = "blackfnt";
        trtc3.Wrap = false;
        tr.Cells.Add(trtc3);

        string str_LOC = "";
        int i = 0;
        if (rpt_typ == "Y")
        {
            string SQL_LOC = "select loccode,loccode+' : '+locname from VW_Location with(NOLOCK) where  Report_loc like '%" + strro + "%' order by Report_loc,loc_level"; ;
            SqlCommand cmd1 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            
            while (dr1.Read())
            {
                TableCell trtc4 = new TableCell();
                trtc4.Text = dr1[1].ToString();
               // trtc4.RowSpan = 2;
                trtc4.CssClass = "blackfnt";
               //trtc4.Wrap = false;
                tr.Cells.Add(trtc4);

                if (str_LOC == "")
                    str_LOC = dr1[0].ToString();
                else
                    str_LOC = str_LOC + "~" + dr1[0].ToString();
                i = +1;
            }
            dr1.Close();
        }
        string[] str_LOC_ARR=null;
        if (str_LOC != "")
        {
             str_LOC_ARR = str_LOC.Split('~');
        }

        tr.HorizontalAlign = HorizontalAlign.Center;
        tr.CssClass = "bgbluegrey";
        tblheadache.Rows.Add(tr);

        string SQL_PNL = "exec webx_ProfitLoss_ver3 '%" + strro + "%','" + chkstate + "','" + rpt_typ + "'";
        SqlCommand cmd = new SqlCommand(SQL_PNL, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        int ik = 1;
        
        while (dr.Read())
        {
            
            TableRow tr1 = new TableRow();
            string str_class = "";

            TableCell tr1tc1 = new TableCell();
            TableCell tr1tc2 = new TableCell();
            TableCell tr1tc3 = new TableCell();


            if (dr["grpdesc"].ToString() == "")
            {
                tr1tc1.Text = dr["grpcd"].ToString();
                tr1tc1.Font.Bold = true;
            }
            else
            {
                ik += 1;
                 str_class = "bobcontent" + ik.ToString();
               // tr1tc1.Text = "<h3 id=\"bobcontent1-title\" class=\"handcursor\">" + dr["grpcd"].ToString() + "</h3>";
                tr1tc1.Text = str_class + "<h3 id='" + str_class + "' class=\"handcursor\"><font class=\"blackfnt\">" + dr["grpcd"].ToString().ToUpper() + " : " + dr["grpdesc"].ToString().ToUpper() + "</font></h3>";
                //tr1tc1.Text =str_class+ "<h3 id='" + str_class + "' class=\"handcursor\"><font class=\"blackfnt\">" + dr["grpcd"].ToString().ToUpper() + " : " + dr["grpdesc"].ToString().ToUpper() + "</font></h3>";
                //tr1tc1.Text = " <a href=\"javascript:switchcontent('" + str_class + "','switchgroup1') \" ><font class=\"blackfnt\">" + dr["grpcd"].ToString().ToUpper() + " : " + dr["grpdesc"].ToString().ToUpper() + "</font></a>";
                tr1tc1.Text =dr["grpcd"].ToString().ToUpper() + " : " + dr["grpdesc"].ToString().ToUpper();
                tr1tc1.Font.Bold = false;
                
            }
            tr1tc1.CssClass = "blackfnt";
            if (dr["grpcd"].ToString() == "")
            {
                str_class = "bobcontent" + ik.ToString();
                tr1tc1.Text =str_class +  "<div id='" + str_class + "'  class=\"switchgroup1\">---" + dr["acccd"].ToString() + " : " + dr["accdesc"].ToString() + "</div>";
                tr1tc1.Text ="---" + dr["acccd"].ToString() + " : " + dr["accdesc"].ToString() ;                         
                tr1tc1.CssClass = "bluefnt";
                tr1tc1.Font.Bold = false;
                
            }
            if (dr["grpcd"].ToString() == "" && dr["acccd"].ToString() == "")
            {
                tr1tc1.Text = "";
            }

           
            // tr1tc1.RowSpan = 2;

            tr1tc1.Wrap = false;
            tr1.Cells.Add(tr1tc1);

            //tr1tc2.Text = dr["acccd"].ToString() + " : " + dr["accdesc"].ToString();
            //if (dr["acccd"].ToString() == "")
            //{
            //    tr1tc2.Text = "";
            //}
            ////tr1tc2.RowSpan = 2;
            //tr1tc2.CssClass = "bluefnt";
            //tr1tc2.Wrap = false;
            //tr1.Cells.Add(tr1tc2);
            double P_N_L =Convert.ToDouble(dr["P_N_L"].ToString());
            string str_P_N_L = "";

            if (P_N_L < 0)
                str_P_N_L = "(" + P_N_L.ToString().Replace("-","") + ")";
            else
                str_P_N_L = P_N_L.ToString();
            

            tr1tc3.Text = dr["P_N_L"].ToString();
            if (dr["grpdesc"].ToString() == "")
            {
                tr1tc3.Text = "";
                tr1tc3.CssClass = "blackfnt";
                tr1tc3.Font.Bold = false;
            }
            else
            {
                tr1tc3.Text = str_P_N_L;
               
                tr1tc3.CssClass = "blackfnt";
                tr1tc3.Font.Bold = false;
            }
            ///tr1tc1.CssClass = "blackfnt";
            if (dr["grpcd"].ToString() == "")
            {
                // tr1tc1.Text = "---" + dr["acccd"].ToString() + " : " + dr["accdesc"].ToString();
                tr1tc3.Text = str_P_N_L;
                string dirlldown1 = "branch=" + RPT_GL_LOC + "&ACCODE=" + dr["acccd1"].ToString() + "&dateFrom=" + a_frmdt + "&dateTo=" + a_todt + "&Cumlative=" + CUM + "&TYP_CD=&DWN_XLS=N&Rtyp=1";
                tr1tc3.Text = "<a href=\"JavaScript:OpenPopupWindow1('" + dirlldown1 + "')\"><font class=\"bluefnt\"><u>" + str_P_N_L + "</u></font></a>";
                tr1tc3.CssClass = "bluefnt";
                tr1tc3.Font.Bold = false;
            }
            if (dr["grpcd"].ToString() == "" && dr["acccd"].ToString() == "")
            {
                tr1tc3.Text = "";
                tr1tc3.Font.Bold = false;
            }

            if (dr["grpcd"].ToString() == "Total INCOME" || dr["grpcd"].ToString() == "Total EXPENSE" || dr["grpcd"].ToString() == "Profit/(Loss)")
            {
                tr1tc3.Text = str_P_N_L;
                tr1tc3.Font.Bold = true;
            }   
            //tr1tc3.RowSpan = 2;
           // tr1tc3.CssClass = "blackfnt";
            tr1tc3.Wrap = false;
            tr1tc3.HorizontalAlign = HorizontalAlign.Right;
            tr1.Cells.Add(tr1tc3);

            if (i > 0)
            {
                for (int j = 0; j < str_LOC_ARR.Length; j++)
                {
                    double P_N_L1 = Convert.ToDouble(dr["" + str_LOC_ARR[j].ToString() + ""].ToString());
                    string str_P_N_L1 = "";

                    if (P_N_L1 < 0)
                        str_P_N_L1 = "(" + P_N_L1.ToString().Replace("-", "") + ")";
                    else
                        str_P_N_L1 = P_N_L1.ToString();

                    TableCell tr1tc4 = new TableCell();
                    if (dr["grpdesc"].ToString() == "")
                    {
                        tr1tc4.Text = "";
                        tr1tc4.CssClass = "blackfnt";
                        tr1tc4.Font.Bold = false;
                    }
                    else
                    {
                        tr1tc4.Text = str_P_N_L1;
                        tr1tc4.CssClass = "blackfnt";
                        tr1tc4.Font.Bold = false;
                    }
                    ///tr1tc1.CssClass = "blackfnt";
                    if (dr["grpcd"].ToString() == "")
                    {
                       // tr1tc1.Text = "---" + dr["acccd"].ToString() + " : " + dr["accdesc"].ToString();
                        string dirlldown = "branch=" + str_LOC_ARR[j].ToString() + "&ACCODE=" + dr["acccd1"].ToString() + "&dateFrom=" + a_frmdt + "&dateTo=" + a_todt + "&Cumlative=" + CUM + "&TYP_CD=&DWN_XLS=N&Rtyp=1";
                        tr1tc4.Text = "<a href=\"JavaScript:OpenPopupWindow1('" + dirlldown + "')\"><font class=\"bluefnt\"><u>" + str_P_N_L1 + "</u></font></a>";
                        tr1tc4.CssClass = "bluefnt";
                        tr1tc4.Font.Bold = false;
                    }
                    if (dr["grpcd"].ToString() == "" && dr["acccd"].ToString() == "")
                    {
                        tr1tc4.Text = "";
                        tr1tc4.Font.Bold = false;
                    }

                    if (dr["grpcd"].ToString() == "Total INCOME" || dr["grpcd"].ToString() == "Total EXPENSE" || dr["grpcd"].ToString() == "Profit/(Loss)")
                    {
                        tr1tc4.Text = str_P_N_L1;
                        tr1tc4.Font.Bold = true;
                    }               
                   
                    // trtc4.RowSpan = 2;
                    
                    tr1tc4.Wrap = false;
                    tr1tc4.HorizontalAlign = HorizontalAlign.Right;
                    tr1.Cells.Add(tr1tc4);
                }
            }


            tr1.BackColor = System.Drawing.Color.White;

            tblheadache.Rows.Add(tr1);

            
        }

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("content-disposition", "attachment; filename=Location_Report.xls");
        //BindGrid();
        tblheadache.BorderStyle = BorderStyle.Double;
        tblheadache.BorderWidth = 1;
        tblheadache.CellSpacing = 2;

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment;Filename=Profit_loss.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        //DipsplayReport();
        BindGrid();
        //GV_Booking.RenderControl(hw);
        tblheadache.RenderControl(hw);
        //TBL_MonthlySales.BorderWidth = 1;
        Response.Write(tw.ToString());
        Response.End();

    }
}
