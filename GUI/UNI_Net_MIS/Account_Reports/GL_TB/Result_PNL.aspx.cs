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


public partial class GUI_UNI_Net_MIS_Account_Reports_GL_TB_Result_PNL : System.Web.UI.Page
{
    SqlConnection Conn;
    string title = "", title1 = "";
    string HDNMSTR = "";
    public static string CLNM1 = "", CLNM2 = "", CLNM3 = "";
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
    public bool isNumeric(string val, System.Globalization.NumberStyles NumberStyle)
    {
        Double result;
        return Double.TryParse(val, NumberStyle,
            System.Globalization.CultureInfo.CurrentCulture, out result);
    }
    public void XLS_DWN()
    {
        int ind = 0;
        int a = 0;
        try
        {
            //GV_Booking.AllowPaging = false;

            // TBL_BS_Det.BorderStyle = BorderStyle.Double;
            // TBL_BS_Det.BorderWidth = 1;


            GRVPNL.AllowPaging = false;
            GRVPNL.BorderWidth = 1;
            //GRVPNL.CssClass = "blackfnt";
            GRVPNL.Font.Size = 10;

             TBLPNL.Border = 1;

            BindGrid();
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=PNL.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);


            frm.Controls.Add(TBLPNL);
            frm.Controls.Add(GRVPNL);


            //frm.Controls.Add(dgDocket);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
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
        // if( isNumeric(Rtyp, System.Globalization.NumberStyles.Integer)==true)
        //  Rtyp = "Location";
        string RPT = Request.QueryString["RPT"].ToString();
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
        string GRPWISE="";
        if (RPTSUB == "1")
            GRPWISE = "Category,Groups";
        else
            GRPWISE = "Category,Groups,Account";

        try
        {
            string SQL_PNL = "exec WEbxNet_ProfitLoss '" + RO + "','" + Cumulative + "','" + fromdt + "','" + todt + "','" + RPT + "','" + GRPWISE + "','CR1-DR1','" + yearSuffix + "'  ";
            SqlCommand sqlcmd12_PNL = new SqlCommand(SQL_PNL, Conn);
           // Response.Write("<BR> SQL_TB : " + SQL_PNL);
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12_PNL);
            DataSet ds = new DataSet();
            da.Fill(ds);
            GRVPNL.DataSource = ds;
            GRVPNL.DataBind();
            GRVPNL.Visible = true;

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
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { string RPTSUB = Request.QueryString["RPTSUB"].ToString();
            int HDID=0;
            if (RPTSUB == "1")
                HDID = 2;
            else
                HDID = 3;
            CLNM1 = e.Row.Cells[0].Text.ToString();
            CLNM2 = e.Row.Cells[1].Text.ToString();
            if (RPTSUB=="2")
                CLNM3 = e.Row.Cells[2].Text.ToString();
            
            

            

            for (int HIC = HDID; HIC < e.Row.Cells.Count; HIC++)
            {
                string[] HDNMSUBSTR = e.Row.Cells[HIC].Text.Split(':');

                if (HDNMSTR == "")
                    HDNMSTR = HDNMSUBSTR[0].ToString().Trim();
                else
                    HDNMSTR = HDNMSTR + "," + HDNMSUBSTR[0].ToString();
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string[] HDNMSTR_STR = HDNMSTR.Split(',');
            int i = 0;
            for (int ic = 0; ic < e.Row.Cells.Count; ic++)
            {
                 
                if (isNumeric(e.Row.Cells[ic].Text.ToString(), System.Globalization.NumberStyles.Number) == true)
                {
                    if (CLNM1 == "Category")
                    {
                        if (e.Row.Cells[0].Text == "EXPENSE" || e.Row.Cells[0].Text == "Total EXPENSE")
                        {
                            if (Convert.ToDouble(e.Row.Cells[ic].Text) > 0)
                            {
                                e.Row.Cells[ic].Text = "(" + Convert.ToDouble(e.Row.Cells[ic].Text).ToString("F2") + ")";
                                e.Row.Cells[ic].CssClass = "redfnt";
                            }
                            else
                                e.Row.Cells[ic].Text = Convert.ToDouble(e.Row.Cells[ic].Text).ToString("F2").Replace("-", "");

                        }
                        else
                        {
                            if (Convert.ToDouble(e.Row.Cells[ic].Text) < 0)
                            {
                                e.Row.Cells[ic].Text = "(" + Convert.ToDouble(e.Row.Cells[ic].Text).ToString("F2").Replace("-", "") + ")";
                                e.Row.Cells[ic].CssClass = "redfnt";
                            }
                            else
                                e.Row.Cells[ic].Text = Convert.ToDouble(e.Row.Cells[ic].Text).ToString("F2");

                        }
                    }
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Right;
                }
                else
                {
                    e.Row.Cells[ic].Text = e.Row.Cells[ic].Text.ToString();
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Left;
                }
                e.Row.Cells[ic].Wrap = false;
                if (CLNM1 == "Category")
                {
                    if (e.Row.Cells[0].Text == null || e.Row.Cells[0].Text == "AAA")
                    {
                        e.Row.Cells[0].Text = "Profit/(Loss)";
                        e.Row.Cells[0].CssClass = "bluefnt";
                        e.Row.Cells[0].Font.Bold = true;
                    }

                }
                if (CLNM2 == "Groups")
                {
                    if (e.Row.Cells[1].Text == null || e.Row.Cells[1].Text == "AAA")
                    {
                        if (e.Row.Cells[0].Text != "Profit/(Loss)")
                            e.Row.Cells[0].Text = "Total " + e.Row.Cells[0].Text;
                        else
                            e.Row.Cells[0].Text = " " + e.Row.Cells[0].Text;

                        e.Row.CssClass = "bluefnt";
                        e.Row.Font.Bold = true;
                        e.Row.Cells[1].Text = "";
                    }
                     
                }
                if (CLNM3 == "Account")
                {
                    if (e.Row.Cells[2].Text == null || e.Row.Cells[2].Text == "AAA")
                    {

                        e.Row.Cells[1].Text = "Total " + e.Row.Cells[1].Text;
                        e.Row.CssClass = "bluefnt";
                        e.Row.Cells[2].Text = "";

                        if (e.Row.Cells[1].Text == "Total ")
                            e.Row.Cells[1].Text = "";
                    }

                    if (ic > 2)
                    {
                        if (e.Row.Cells[2].Text.ToString() != "")
                        {
                            string[] acccd = e.Row.Cells[2].Text.Split('~');
                            string bcd = HDNMSTR_STR[i].ToString();
                            if (bcd.ToUpper().ToString() == "TOTAL")
                                bcd = RO;


                            //string dirlldown1 = "branch=" + bcd.ToString() + "&ACCODE=" + acccd[1].ToString().Trim() + "&dateFrom=" + fromdt + "&dateTo=" + todt + "&Cumlative=N&TYP_CD=&PGNO=1&Psize=50&DWN_XLS=N&Rtyp=1";
                            //e.Row.Cells[ic].Text = "<a href=\"JavaScript:OpenPopupWindow1('" + dirlldown1 + "')\"><u>" + e.Row.Cells[ic].Text + "</u></a>";

                            if (ic.ToString() == "3")
                            {
                                string dirlldown2 = "branch=" + RO.ToString() + "&ACCODE=" + acccd[1].ToString().Trim() + "&dateFrom=" + fromdt + "&dateTo=" + todt + "&Cumlative=" + Request.QueryString["Cumlative"].ToString() + "&TYP_CD=&PGNO=1&Psize=50&DWN_XLS=N&Rtyp=1";
                                e.Row.Cells[3].Text = "<a href=\"JavaScript:OpenPopupWindow1('" + dirlldown2 + "')\"><u>" + e.Row.Cells[3].Text + "</u></a>";
                            }
                            else
                            {
                                string dirlldown1 = "branch=" + bcd.ToString() + "&ACCODE=" + acccd[1].ToString().Trim() + "&dateFrom=" + fromdt + "&dateTo=" + todt + "&Cumlative=N&TYP_CD=&PGNO=1&Psize=50&DWN_XLS=N&Rtyp=1";
                                e.Row.Cells[ic].Text = "<a href=\"JavaScript:OpenPopupWindow1('" + dirlldown1 + "')\"><u>" + e.Row.Cells[ic].Text + "</u></a>";

                            }



                            i += 1;
                        }

                    }

                }

                
            }

            if (CLNM1 == "Category")
            {
                if (title.CompareTo(e.Row.Cells[0].Text) != 0)
                {
                    title = e.Row.Cells[0].Text;
                }
                else
                {
                    e.Row.Cells[0].Text = "";
                }
            }
            if (CLNM2 == "Groups")
            {
                if (title1.CompareTo(e.Row.Cells[1].Text) != 0)
                {
                    title1 = e.Row.Cells[1].Text;
                }
                else
                {
                    e.Row.Cells[1].Text = "";
                }
            }


        }

    }
}

