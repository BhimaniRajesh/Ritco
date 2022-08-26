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
using System.Data.SqlClient;
using System.IO;

public partial class GUI_UNI_MIS_Account_Reports_CBS_ver1_Result : System.Web.UI.Page
{
    public int i = 0;
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        string  RMD;
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
        double bank_opndebit = 0, bank_opncredit = 0, cash_opndebit = 0, cash_opncredit = 0;
        double bank_TRdebit = 0, bank_TRcredit = 0, cash_TRdebit = 0, cash_TRcredit = 0;
        double bank_CLdebit = 0, bank_CLcredit = 0, cash_CLdebit = 0, cash_CLcredit = 0;

        double RO_bank_opndebit = 0, RO_bank_opncredit = 0, RO_cash_opndebit = 0, RO_cash_opncredit = 0;
        double RO_bank_TRdebit = 0, RO_bank_TRcredit = 0, RO_cash_TRdebit = 0, RO_cash_TRcredit = 0;
        double RO_bank_CLdebit = 0, RO_bank_CLcredit = 0, RO_cash_CLdebit = 0, RO_cash_CLcredit = 0;

        double TOT_bank_opndebit = 0, TOT_bank_opncredit = 0, TOT_cash_opndebit = 0, TOT_cash_opncredit = 0;
        double TOT_bank_TRdebit = 0, TOT_bank_TRcredit = 0, TOT_cash_TRdebit = 0, TOT_cash_TRcredit = 0;
        double TOT_bank_CLdebit = 0, TOT_bank_CLcredit = 0, TOT_cash_CLdebit = 0, TOT_cash_CLcredit = 0;


        string st_ro, st_lo, dtFrom, RPT, dtTo, st_Acc, Acc,lRO="";
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        RPT = Request.QueryString["RPT"].ToString();
        st_ro = Request.QueryString["RO"].ToString().Trim();
        st_lo = Request.QueryString["LO"].ToString().Trim();
        dtFrom = Request.QueryString["fromdt"].ToString();
        dtTo = Request.QueryString["todt"].ToString();
        st_Acc = Request.QueryString["st_Acc"].ToString().Trim();
        Acc = Request.QueryString["Acc"].ToString().Trim();

        LBLDATE.Text = dtFrom + " - " + dtTo;
        LBLBRANCH.Text = st_ro;
        LBLRPT.Text = st_lo;
        LBLSUBRPT.Text = Acc;
        string stRO = "";
        if (st_ro == "All" || st_ro == "")
            st_ro = "All";
        if (st_lo == "All" || st_lo == "")
            st_lo = "All";
        if (st_Acc == "All" || st_Acc == "")
            st_Acc = "All";
        if (st_ro == "All" || st_ro == "")
            stRO = "All";
        else
            stRO = st_ro;
        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
       
        //if (st_lo != "%%")
        //{
        //    stRO = "All";
        //}
        

        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);


        if (stRO == st_lo)
            stRO = "All";
        SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        string SQL_CBS = "";
        try
        {
           
            if (RPT == "1")
            {

                SQL_CBS = "exec webxNet_CBS_Register '" + dtFrom + "','" + dtTo + "','" + st_lo + "','" + stRO + "','Y','" + st_Acc + "','" + yearSuffix + "'";
              // Response.Write("<BR> SQL_TB : " + SQL_CBS);

                SqlCommand sqlcmd12 = new SqlCommand(SQL_CBS, Conn);
                sqlcmd12.Transaction = trans;
                //SqlDataReader dr;
                //dr = sqlcmd12.ExecuteReader();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
                DataSet ds = new DataSet();
                da.Fill(ds);
                dgDocket.DataSource = ds;
                dgDocket.DataBind();
                dgDocket.Visible = true;
            }
            else
            {
                SQL_CBS = "exec webxNet_CBS_Summary '" + dtFrom + "','" + dtTo + "','" + st_lo + "','" + stRO + "','Y','" + st_Acc + "','" + yearSuffix + "'";
              // Response.Write("<BR> SQL_TB : " + SQL_CBS);
                SqlCommand sqlcmd12 = new SqlCommand(SQL_CBS, Conn);
                sqlcmd12.Transaction = trans;
                SqlDataReader dr = sqlcmd12.ExecuteReader();
                TBL_CBS.Visible = true;

                TableRow TR = new TableRow();
                TableCell TC = new TableCell();

                TC.Text = "Sr no.";
                TC.CssClass = "blackboldfnt";
                TC.RowSpan = 2;
                TC.Wrap = false;
                TR.Cells.Add(TC);

                TC = new TableCell();
                TC.Text = "Location";
                TC.CssClass = "blackboldfnt";
                TC.RowSpan = 2;
                TC.Wrap = false;
                TR.Cells.Add(TC);

                TC = new TableCell();
                TC.Text = "CASH";
                TC.CssClass = "blackboldfnt";
                TC.ColumnSpan = 6;
                TC.Wrap = false;
                TR.Cells.Add(TC);

                TC = new TableCell();
                TC.Text = "BANK";
                TC.CssClass = "blackboldfnt";
                TC.ColumnSpan = 6;
                TC.Wrap = false;
                TR.Cells.Add(TC);

                TR.HorizontalAlign = HorizontalAlign.Center;
                TR.CssClass = "bgbluegrey";
                TBL_CBS.Rows.Add(TR);

                TableRow TR1 = new TableRow();
                TableCell TC1 = new TableCell();

                TC1.Text = "Opening Debit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Opening  Credit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Current Debit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Current Credit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Closing Debit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Closing Credit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Opening Debit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Opening  Credit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Current Debit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Current Credit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Closing Debit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TC1 = new TableCell();
                TC1.Text = "Closing Credit";
                TC1.CssClass = "blackfnt";
                TC1.Wrap = false;
                TR1.Cells.Add(TC1);

                TR.HorizontalAlign = HorizontalAlign.Center;
                TR.CssClass = "bgbluegrey";
                TBL_CBS.Rows.Add(TR);

                TR1.HorizontalAlign = HorizontalAlign.Center;
                TR1.CssClass = "bgbluegrey";
                TBL_CBS.Rows.Add(TR1);

                int i = 1;
                string CRo = "", PrevRO = "";
                while (dr.Read())
                {
                     CRo = dr["report_loc"].ToString();
                     string lrnm = dr["report_loc_nm"].ToString();
                     if (CRo != PrevRO && PrevRO != "")
                     {
                         TableRow TR3 = new TableRow();
                         TableCell TC3 = new TableCell();

                         string dirlldown2 = "";
                         //rptno = "1";
                         //rpttyp = "Booking Stock";
                         dirlldown2 = "RO=" + CRo + "&LO=All&todt=" + dtTo + "&fromdt=" + dtFrom + "&Acc=" + Acc + "&st_Acc=" + Request.QueryString["st_Acc"].ToString().Trim() + "&RPT=1&RMD=N";


                        // TC3.Text = lRO;
                         TC3.Text = "<a href='result.aspx?" + dirlldown2 + "'> <u><font class=bluefnt>" + lRO + "</font></u></a>";
                         
                         //TC3.Text = dr["report_loc_nm"].ToString() ;
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.ColumnSpan = 2;
                         TC3.HorizontalAlign = HorizontalAlign.Left;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         if (RO_cash_opndebit > RO_cash_opncredit)
                         {
                             RO_cash_opndebit = RO_cash_opndebit - RO_cash_opncredit;
                             RO_cash_opncredit = 0;
                         }
                         else
                         {                             
                             RO_cash_opncredit = RO_cash_opncredit - RO_cash_opndebit;
                             RO_cash_opndebit = 0;
                         }

                         if (RO_cash_TRdebit > RO_cash_TRcredit)
                         {
                             RO_cash_TRdebit = RO_cash_TRdebit - RO_cash_TRcredit;
                             RO_cash_TRcredit = 0;
                         }
                         else
                         {                             
                             RO_cash_TRcredit = RO_cash_TRcredit - RO_cash_TRdebit;
                             RO_cash_TRdebit = 0;
                         }


                         RO_cash_CLdebit = RO_cash_opndebit + RO_cash_TRdebit;
                         RO_cash_CLcredit = RO_cash_opncredit + RO_cash_TRcredit;
                         if (RO_cash_CLdebit > RO_cash_CLcredit)
                         {
                             RO_cash_CLdebit = RO_cash_CLdebit - RO_cash_CLcredit;
                             RO_cash_CLcredit = 0;
                         }
                         else
                         {                             
                             RO_cash_CLcredit = RO_cash_CLcredit - RO_cash_CLdebit;
                             RO_cash_CLdebit = 0;
                         }


                         if (RO_bank_opndebit > RO_bank_opncredit)
                         {
                             RO_bank_opndebit = RO_bank_opndebit - RO_bank_opncredit;
                             RO_bank_opncredit = 0;
                         }
                         else
                         {                             
                             RO_bank_opncredit =  RO_bank_opncredit -RO_bank_opndebit ;
                             RO_bank_opndebit = 0;
                         }
                         if (RO_bank_TRdebit > RO_bank_TRcredit)
                         {
                             RO_bank_TRdebit = RO_bank_TRdebit - RO_bank_TRcredit;
                             RO_bank_TRcredit = 0;
                         }
                         else
                         {                             
                             RO_bank_TRcredit = RO_bank_TRcredit - RO_bank_TRdebit;
                             RO_bank_TRdebit = 0;
                         }

                         RO_bank_CLdebit = RO_bank_opndebit + RO_bank_TRdebit;
                         RO_bank_CLcredit = RO_bank_opncredit + RO_bank_TRcredit;
                         if (RO_bank_CLdebit > RO_bank_CLcredit)
                         {
                             RO_bank_CLdebit = RO_bank_CLdebit - RO_bank_CLcredit;
                             RO_bank_CLcredit = 0;
                         }
                         else
                         {                             
                             RO_bank_CLcredit = RO_bank_CLcredit - RO_bank_CLdebit;
                             RO_bank_CLdebit = 0;
                         }

                         TC3 = new TableCell();
                         TC3.Text = RO_cash_opndebit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_cash_opncredit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_cash_TRdebit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_cash_TRcredit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_cash_CLdebit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_cash_CLcredit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_bank_opndebit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);                         

                         TC3 = new TableCell();
                         TC3.Text = RO_bank_opncredit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);


                         TC3 = new TableCell();
                         TC3.Text = RO_bank_TRdebit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_bank_TRcredit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_bank_CLdebit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TC3 = new TableCell();
                         TC3.Text = RO_bank_CLcredit.ToString("F2");
                         TC3.CssClass = "bluefnt";
                         TC3.Font.Bold = true;
                         TC3.HorizontalAlign = HorizontalAlign.Right;
                         TC3.Wrap = false;
                         TR3.Cells.Add(TC3);

                         TR3.HorizontalAlign = HorizontalAlign.Center;
                         TR3.BackColor = System.Drawing.Color.White;
                         TBL_CBS.Rows.Add(TR3);

                         RO_bank_opndebit = 0;
                         RO_bank_opncredit = 0;
                         RO_cash_opndebit = 0;
                         RO_cash_opncredit = 0;

                         RO_bank_TRdebit = 0;
                         RO_bank_TRcredit = 0;
                         RO_cash_TRdebit = 0;
                         RO_cash_TRcredit = 0;


                     }

                    

                    TableRow TR2 = new TableRow();
                    TableCell TC2 = new TableCell();

                    TC2.Text = i.ToString();
                    TC2.CssClass = "blackfnt";
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);


                    string rptno = "", dirlldown = "", rpttyp = "";
                    //rptno = "1";
                    //rpttyp = "Booking Stock";
                    dirlldown = "RO=" + Request.QueryString["RO"].ToString().Trim() + "&LO=" + dr["loccode"].ToString() + "&todt=" + dtTo + "&fromdt=" + dtFrom + "&Acc=" + Acc + "&st_Acc=" + Request.QueryString["st_Acc"].ToString().Trim() + "&RPT=1&RMD=N";
                    
            

                    TC2 = new TableCell();
                    TC2.Text =
                    TC2.Text = "<a href='result.aspx?" + dirlldown + "'><u>" + dr["loccode"].ToString() + " : " + dr["locname"].ToString() +"</u></a>";
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Left;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    

                    if (Convert.ToDouble(dr["CASH_OPNDEBIT"].ToString()) > Convert.ToDouble(dr["CASH_OPNCredit"].ToString()))
                    {
                        cash_opndebit = Convert.ToDouble(dr["CASH_OPNDEBIT"].ToString()) - Convert.ToDouble(dr["CASH_OPNCredit"].ToString());
                        cash_opncredit = 0;
                    }
                    else
                    {                        
                        cash_opncredit = Convert.ToDouble(dr["CASH_OPNCredit"].ToString()) - Convert.ToDouble(dr["CASH_OPNDEBIT"].ToString());
                        cash_opndebit = 0;
                    }

                    if (Convert.ToDouble(dr["CASH_TRDEBIT"].ToString()) > Convert.ToDouble(dr["CASH_TRCredit"].ToString()))
                    {
                        cash_TRdebit = Convert.ToDouble(dr["CASH_TRDEBIT"].ToString()) - Convert.ToDouble(dr["CASH_TRCredit"].ToString());
                        cash_TRcredit = 0;
                    }
                    else
                    {                       
                        cash_TRcredit = Convert.ToDouble(dr["CASH_TRCredit"].ToString()) - Convert.ToDouble(dr["CASH_TRDEBIT"].ToString());
                        cash_TRdebit = 0;
                    }

                    cash_CLdebit = cash_opndebit + cash_TRdebit;
                    cash_CLcredit = cash_opncredit + cash_TRcredit;
                    if (cash_CLdebit > cash_CLcredit)
                    {
                        cash_CLdebit = cash_CLdebit - cash_CLcredit;
                        cash_CLcredit = 0;
                    }
                    else
                    {                        
                        cash_CLcredit =cash_CLcredit- cash_CLdebit  ;
                        cash_CLdebit = 0;
                    }

                    if (Convert.ToDouble(dr["BANK_OPNDEBIT"].ToString()) > Convert.ToDouble(dr["BANK_OPNCredit"].ToString()))
                    {
                        bank_opndebit = Convert.ToDouble(dr["BANK_OPNDEBIT"].ToString()) - Convert.ToDouble(dr["BANK_OPNCredit"].ToString());
                        bank_opncredit = 0;
                    }
                    else
                    {                       
                        bank_opncredit = Convert.ToDouble(dr["BANK_OPNCredit"].ToString()) - Convert.ToDouble(dr["BANK_OPNDEBIT"].ToString());
                        bank_opndebit = 0;
                    }

                    if (Convert.ToDouble(dr["BANK_TRDEBIT"].ToString()) > Convert.ToDouble(dr["BANK_TRCredit"].ToString()))
                    {
                        bank_TRdebit = Convert.ToDouble(dr["BANK_TRDEBIT"].ToString()) - Convert.ToDouble(dr["BANK_TRCredit"].ToString());
                        bank_TRcredit = 0;
                    }
                    else
                    {                        
                        bank_TRcredit = Convert.ToDouble(dr["BANK_TRCredit"].ToString()) - Convert.ToDouble(dr["BANK_TRDEBIT"].ToString());
                        bank_TRdebit = 0;
                    }

                    bank_CLdebit = bank_opndebit + bank_TRdebit;
                    bank_CLcredit = bank_opncredit + bank_TRcredit;
                    if (bank_CLdebit > bank_CLcredit)
                    {
                        bank_CLdebit = bank_CLdebit - bank_CLcredit;
                        bank_CLcredit = 0;
                    }
                    else
                    {
                        bank_CLdebit = 0;
                        bank_CLcredit = bank_CLcredit - bank_CLdebit;
                    }

                    TC2 = new TableCell();
                    TC2.Text = cash_opndebit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = cash_opncredit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = cash_TRdebit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = cash_TRcredit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = cash_CLdebit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = cash_CLcredit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = bank_opndebit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = bank_opncredit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = bank_TRdebit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = bank_TRcredit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = bank_CLdebit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TC2 = new TableCell();
                    TC2.Text = bank_CLcredit.ToString("F2");
                    TC2.CssClass = "blackfnt";
                    TC2.HorizontalAlign = HorizontalAlign.Right;
                    TC2.Wrap = false;
                    TR2.Cells.Add(TC2);

                    TR2.HorizontalAlign = HorizontalAlign.Center;
                    TR2.BackColor = System.Drawing.Color.White;
                    TBL_CBS.Rows.Add(TR2);

                    RO_cash_opndebit += Convert.ToDouble(dr["cash_OPNDEBIT"].ToString());
                    RO_cash_opncredit += Convert.ToDouble(dr["cash_OPNCredit"].ToString());
                    TOT_cash_opndebit += Convert.ToDouble(dr["cash_OPNDEBIT"].ToString());
                    TOT_cash_opncredit += Convert.ToDouble(dr["cash_OPNCredit"].ToString());

                    RO_cash_TRdebit += Convert.ToDouble(dr["cash_TRDEBIT"].ToString());
                    RO_cash_TRcredit += Convert.ToDouble(dr["cash_TRCredit"].ToString());
                    TOT_cash_TRdebit += Convert.ToDouble(dr["cash_TRDEBIT"].ToString());
                    TOT_cash_TRcredit += Convert.ToDouble(dr["cash_TRCredit"].ToString());

                    RO_bank_opndebit += Convert.ToDouble(dr["BANK_OPNDEBIT"].ToString());
                    RO_bank_opncredit += Convert.ToDouble(dr["BANK_OPNCredit"].ToString());
                    TOT_bank_opndebit += Convert.ToDouble(dr["BANK_OPNDEBIT"].ToString());
                    TOT_bank_opncredit += Convert.ToDouble(dr["BANK_OPNCredit"].ToString());

                    RO_bank_TRdebit += Convert.ToDouble(dr["BANK_TRDEBIT"].ToString());
                    RO_bank_TRcredit += Convert.ToDouble(dr["BANK_TRCredit"].ToString());
                    TOT_bank_TRdebit += Convert.ToDouble(dr["BANK_TRDEBIT"].ToString());
                    TOT_bank_TRcredit += Convert.ToDouble(dr["BANK_TRCredit"].ToString());
                   

                    PrevRO = dr["report_loc"].ToString();
                    lRO = dr["report_loc_nm"].ToString();
                    i += 1;
                }

                dr.Close();

                TableRow TR4 = new TableRow();
                TableCell TC4 = new TableCell();
                string dirlldown1 = "";
                //rptno = "1";
                //rpttyp = "Booking Stock";
                dirlldown1 = "RO=" + PrevRO + "&LO=All&todt=" + dtTo + "&fromdt=" + dtFrom + "&Acc=" + Acc + "&st_Acc=" + Request.QueryString["st_Acc"].ToString().Trim() + "&RPT=1&RMD=N";
                  

                TC4.Text = lRO;
                TC4.Text = "<a href='result.aspx?" + dirlldown1 + "'><u><font class=bluefnt>" + lRO + "</font></u></a>";
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.ColumnSpan = 2;
                TC4.HorizontalAlign = HorizontalAlign.Left;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                if (RO_cash_opndebit > RO_cash_opncredit)
                {
                    RO_cash_opndebit = RO_cash_opndebit - RO_cash_opncredit;
                    RO_cash_opncredit = 0;
                }
                else
                {                    
                    RO_cash_opncredit = RO_cash_opncredit - RO_cash_opndebit;
                    RO_cash_opndebit = 0;
                }

                if (RO_cash_TRdebit > RO_cash_TRcredit)
                {
                    RO_cash_TRdebit = RO_cash_TRdebit - RO_cash_TRcredit;
                    RO_cash_TRcredit = 0;
                }
                else
                {                    
                    RO_cash_TRcredit = RO_cash_TRcredit - RO_cash_TRdebit;
                    RO_cash_TRdebit = 0;
                }


                RO_cash_CLdebit = RO_cash_opndebit + RO_cash_TRdebit;
                RO_cash_CLcredit = RO_cash_opncredit + RO_cash_TRcredit;
                if (RO_cash_CLdebit > RO_cash_CLcredit)
                {
                    RO_cash_CLdebit = RO_cash_CLdebit - RO_cash_CLcredit;
                    RO_cash_CLcredit = 0;
                }
                else
                {                    
                    RO_cash_CLcredit = RO_cash_CLcredit - RO_cash_CLdebit;
                    RO_cash_CLdebit = 0;
                }


                if (RO_bank_opndebit > RO_bank_opncredit)
                {
                    RO_bank_opndebit = RO_bank_opndebit - RO_bank_opncredit;
                    RO_bank_opncredit = 0;
                }
                else
                {                    
                    RO_bank_opncredit = RO_bank_opncredit - RO_bank_opndebit;
                    RO_bank_opndebit = 0;
                }
                if (RO_bank_TRdebit > RO_bank_TRcredit)
                {
                    RO_bank_TRdebit = RO_bank_TRdebit - RO_bank_TRcredit;
                    RO_bank_TRcredit = 0;
                }
                else
                {                    
                    RO_bank_TRcredit = RO_bank_TRcredit - RO_bank_TRdebit;
                    RO_bank_TRdebit = 0;
                }

                RO_bank_CLdebit = RO_bank_opndebit + RO_bank_TRdebit;
                RO_bank_CLcredit = RO_bank_opncredit + RO_bank_TRcredit;
                if (RO_bank_CLdebit > RO_bank_CLcredit)
                {
                    RO_bank_CLdebit = RO_bank_CLdebit - RO_bank_CLcredit;
                    RO_bank_CLcredit = 0;
                }
                else
                {
                    RO_bank_CLcredit = RO_bank_CLcredit - RO_bank_CLdebit;
                    RO_bank_CLdebit = 0;
                }

                TC4 = new TableCell();
                TC4.Text = RO_cash_opndebit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_cash_opncredit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_cash_TRdebit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_cash_TRcredit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_cash_CLdebit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_cash_CLcredit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_bank_opndebit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_bank_opncredit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);


                TC4 = new TableCell();
                TC4.Text = RO_bank_TRdebit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_bank_TRcredit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_bank_CLdebit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TC4 = new TableCell();
                TC4.Text = RO_bank_CLcredit.ToString("F2");
                TC4.CssClass = "bluefnt";
                TC4.Font.Bold = true;
                TC4.HorizontalAlign = HorizontalAlign.Right;
                TC4.Wrap = false;
                TR4.Cells.Add(TC4);

                TR4.HorizontalAlign = HorizontalAlign.Center;
                TR4.BackColor = System.Drawing.Color.White;
                TBL_CBS.Rows.Add(TR4);

                TableRow TR5 = new TableRow();
                TableCell TC5 = new TableCell();


                TC5.Text = "Total";
                string dirlldown4 = "";
                //rptno = "1";
                //rpttyp = "Booking Stock";
                dirlldown4 = "RO=" + Request.QueryString["RO"].ToString().Trim() + "&LO=" + Request.QueryString["LO"].ToString().Trim() + "&todt=" + dtTo + "&fromdt=" + dtFrom + "&Acc=" + Acc + "&st_Acc=" + Request.QueryString["st_Acc"].ToString().Trim() + "&RPT=1&RMD=N";

                TC5.Text = "<a href='result.aspx?" + dirlldown4 + "'><u><font class=bluefnt>Total</font></u></a>";
                   
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.ColumnSpan = 2;
                TC5.HorizontalAlign = HorizontalAlign.Left;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                if (TOT_cash_opndebit > TOT_cash_opncredit)
                {
                    TOT_cash_opndebit = TOT_cash_opndebit - TOT_cash_opncredit;
                    TOT_cash_opncredit = 0;
                }
                else
                {                   
                    TOT_cash_opncredit = TOT_cash_opncredit - TOT_cash_opndebit;
                    TOT_cash_opndebit = 0;
                }

                if (TOT_cash_TRdebit > TOT_cash_TRcredit)
                {
                    TOT_cash_TRdebit = TOT_cash_TRdebit - TOT_cash_TRcredit;
                    TOT_cash_TRcredit = 0;
                }
                else
                {                    
                    TOT_cash_TRcredit = TOT_cash_TRcredit - TOT_cash_TRdebit;
                    TOT_cash_TRdebit = 0;
                }


                TOT_cash_CLdebit = TOT_cash_opndebit + TOT_cash_TRdebit;
                TOT_cash_CLcredit = TOT_cash_opncredit + TOT_cash_TRcredit;

                if (TOT_cash_CLdebit > TOT_cash_CLcredit)
                {
                    TOT_cash_CLdebit = TOT_cash_CLdebit - TOT_cash_CLcredit;
                    TOT_cash_CLcredit = 0;
                }
                else
                {                    
                    TOT_cash_CLcredit = TOT_cash_CLcredit - TOT_cash_CLdebit;
                    TOT_cash_CLdebit = 0;
                }


                if (TOT_bank_opndebit > TOT_bank_opncredit)
                {
                    TOT_bank_opndebit = TOT_bank_opndebit - TOT_bank_opncredit;
                    TOT_bank_opncredit = 0;
                }
                else
                {                   
                    TOT_bank_opncredit = TOT_bank_opncredit - TOT_bank_opndebit;
                    TOT_bank_opndebit = 0;
                }
                if (TOT_bank_TRdebit > TOT_bank_TRcredit)
                {
                    TOT_bank_TRdebit = TOT_bank_TRdebit - TOT_bank_TRcredit;
                    TOT_bank_TRcredit = 0;
                }
                else
                {
                    
                    TOT_bank_TRcredit = TOT_bank_TRcredit - TOT_bank_TRdebit;
                    TOT_bank_TRdebit = 0;
                }

                TOT_bank_CLdebit = TOT_bank_opndebit + TOT_bank_TRdebit;
                TOT_bank_CLcredit = TOT_bank_opncredit + TOT_bank_TRcredit;

                if (TOT_bank_CLdebit > TOT_bank_CLcredit)
                {
                    TOT_bank_CLdebit = TOT_bank_CLdebit - TOT_bank_CLcredit;
                    TOT_bank_CLcredit = 0;
                }
                else
                {                    
                    TOT_bank_CLcredit = TOT_bank_CLcredit - TOT_bank_CLdebit;
                    TOT_bank_CLdebit = 0;
                }

                TC5 = new TableCell();
                TC5.Text = TOT_cash_opndebit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_cash_opncredit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_cash_TRdebit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_cash_TRcredit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_cash_CLdebit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_cash_CLcredit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_bank_opndebit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_bank_opncredit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);


                TC5 = new TableCell();
                TC5.Text = TOT_bank_TRdebit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_bank_TRcredit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_bank_CLdebit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TC5 = new TableCell();
                TC5.Text = TOT_bank_CLcredit.ToString("F2");
                TC5.CssClass = "bluefnt";
                TC5.Font.Bold = true;
                TC5.HorizontalAlign = HorizontalAlign.Right;
                TC5.Wrap = false;
                TR5.Cells.Add(TC5);

                TR5.HorizontalAlign = HorizontalAlign.Center;
                TR5.BackColor = System.Drawing.Color.White;
                TBL_CBS.Rows.Add(TR5);

            }


            trans.Commit();

            Conn.Close();

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                //abc = "Insert Susccessfully !!!!!!!";
            }
            Response.Write("<BR><BR> SQL_TB : " + SQL_CBS);
            trans.Rollback();


            Conn.Close();
            Response.End();
        }
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {




        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (e.Row.Cells[0].Text.ToString().Trim() != "Opening Balance B/F" && e.Row.Cells[0].Text.ToString().Trim() != "Total Transaction" && e.Row.Cells[0].Text.ToString().Trim() != "Closing Balance C/F")
            {
                Label lblNarration = (Label)e.Row.FindControl("lblNarration");
                Label lbldocno = (Label)e.Row.FindControl("lbldocno");

                Table table = (Table)this.dgDocket.Controls[0];
                GridView oGridView = (GridView)sender;
                int realindex = table.Rows.GetRowIndex(e.Row);
                GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                TableCell oTableCell1 = new TableCell();
                TableCell oTableCell2 = new TableCell();
                TableCell oTableCell3 = new TableCell();

                TableCell oTableCell4 = new TableCell();
                TableCell oTableCell5 = new TableCell();
                TableCell oTableCell6 = new TableCell();
                TableCell oTableCell7 = new TableCell();

                oTableCell1.Text = "Narration : - ";//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                oTableCell1.CssClass = "bluefnt";
                oTableCell1.Font.Bold = true;
                oTableCell1.HorizontalAlign = HorizontalAlign.Right;
                oGridViewRow.Cells.Add(oTableCell1);
                oTableCell1.Wrap = false;

                oTableCell.Text = lblNarration.Text.ToString();//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                oTableCell.ColumnSpan = 5;
                oTableCell.CssClass = "bluefnt";

                oTableCell.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell);
                oTableCell.Wrap = false;

                oTableCell3.Text = "Doc. No. : - ";//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                oTableCell3.CssClass = "bluefnt";
                oTableCell3.Font.Bold = true;
                oTableCell3.HorizontalAlign = HorizontalAlign.Right;
                oGridViewRow.Cells.Add(oTableCell3);
                oTableCell3.Wrap = false;

                oTableCell2.Text = lbldocno.Text.ToString();//+ Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                oTableCell2.ColumnSpan = 2;
                oTableCell2.CssClass = "bluefnt";
                oTableCell2.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell2);
                oTableCell.Wrap = false;

                oTableCell4.Text = "";
                oTableCell4.CssClass = "bluefnt";
                oTableCell4.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell4);
                oTableCell.Wrap = false;

                oTableCell5.Text = "";
                oTableCell5.CssClass = "bluefnt";
                oTableCell5.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell5);
                oTableCell.Wrap = false;

                oTableCell6.Text = "";
                oTableCell6.CssClass = "bluefnt";
                oTableCell6.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell6);
                oTableCell.Wrap = false;

                oTableCell7.Text = "";
                oTableCell7.CssClass = "bluefnt";
                oTableCell7.HorizontalAlign = HorizontalAlign.Left;
                oGridViewRow.Cells.Add(oTableCell7);
                oTableCell.Wrap = false;
                oGridViewRow.BackColor = System.Drawing.Color.White;
                table.Controls.AddAt(realindex + 1, oGridViewRow);


                
            }

           

            if (e.Row.Cells[0].Text.ToString().Trim() == "Opening Balance B/F")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[9].CssClass = "bluefnt";
                e.Row.Cells[9].Font.Bold = true;
                e.Row.Cells[10].CssClass = "bluefnt";
                e.Row.Cells[10].Font.Bold = true;
                e.Row.Cells[11].CssClass = "bluefnt";
                e.Row.Cells[11].Font.Bold = true;
                e.Row.Cells[12].CssClass = "bluefnt";
                e.Row.Cells[12].Font.Bold = true;
                
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "Total Transaction")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[9].CssClass = "bluefnt";
                e.Row.Cells[9].Font.Bold = true;
                e.Row.Cells[10].CssClass = "bluefnt";
                e.Row.Cells[10].Font.Bold = true;
                e.Row.Cells[11].CssClass = "bluefnt";
                e.Row.Cells[11].Font.Bold = true;
                e.Row.Cells[12].CssClass = "bluefnt";
                e.Row.Cells[12].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "Total for A/C (Dr./Cr.) :")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[4].Font.Bold = true;
                e.Row.Cells[5].Font.Bold = true;
            }
            else if (e.Row.Cells[0].Text.ToString().Trim() == "Closing Balance C/F")
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                e.Row.Cells[9].CssClass = "bluefnt";
                e.Row.Cells[9].Font.Bold = true;
                e.Row.Cells[10].CssClass = "bluefnt";
                e.Row.Cells[10].Font.Bold = true;
                e.Row.Cells[11].CssClass = "bluefnt";
                e.Row.Cells[11].Font.Bold = true;
                e.Row.Cells[12].CssClass = "bluefnt";
                e.Row.Cells[12].Font.Bold = true;
            }
            else
            {
                i += 1;
                e.Row.Cells[0].Text = i.ToString();
                e.Row.Cells[0].Font.Bold = false;
            }


        }

        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView1 = (GridView)sender;

            GridViewRow oGridViewRow2 = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell tc1 = new TableCell();
            tc1 = new TableCell();
            tc1.Text = "Debit ";
            //tc1.Width = 300;
            tc1.HorizontalAlign = HorizontalAlign.Center;
            tc1.CssClass = "blackfnt";
            oGridViewRow2.Cells.Add(tc1);

            tc1 = new TableCell();
            tc1.Text = "Credit ";
            tc1.HorizontalAlign = HorizontalAlign.Center;
            tc1.CssClass = "blackfnt";
            oGridViewRow2.Cells.Add(tc1);

            tc1 = new TableCell();
            tc1.Text = "Debit ";
           // tc1.Width = 300;
            tc1.HorizontalAlign = HorizontalAlign.Center;
            tc1.CssClass = "blackfnt";
            oGridViewRow2.Cells.Add(tc1);

            tc1 = new TableCell();
            tc1.Text = "Credit ";
            tc1.HorizontalAlign = HorizontalAlign.Center;
            tc1.CssClass = "blackfnt";
            oGridViewRow2.Cells.Add(tc1);

            oGridView1.Controls[0].Controls.AddAt(1, oGridViewRow2);
            //oGridView1.Controls[0].Controls.RemoveAt(1);


            GridViewRow oGridViewRow1 = new GridViewRow(1, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTblCell = new TableCell();
            TableCell oTblCell1 = new TableCell();

            oTblCell = new TableCell();
            oTblCell.Text = " ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Voucher No. ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Date ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Party ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Particular ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Location ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Cash/Bank Name ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

          

            oTblCell = new TableCell();
            oTblCell.Text = "Cheque No ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "Cheque Date ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.RowSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "CASH";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oTblCell = new TableCell();
            oTblCell.Text = "BANK ";
            oTblCell.HorizontalAlign = HorizontalAlign.Center;
            oTblCell.CssClass = "blackfnt";
            oTblCell.ColumnSpan = 2;
            oGridViewRow1.Cells.Add(oTblCell);

            oGridView1.Controls[0].Controls.AddAt(0, oGridViewRow1);
             oGridView1.Controls[0].Controls.RemoveAt(1);
                      
             
        }
               
    }

    public void DWN_XLS()
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.Font.Size = 8;
        dgDocket.Font.Name = "verdana";
        //dgDocket.CssClass = "blackfnt";

        //TBL_CRI.AllowPaging = false;
        TBL_CRI.Border = 1;
       
        TBL_CBS.BorderWidth = 1;
        TBL_CBS.BorderColor = System.Drawing.Color.Gray;
        TBL_CBS.Font.Name = "verdana";
        TBL_CBS.Font.Size = 8;
        


        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=CBS.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);


        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(dgDocket);
        frm.Controls.Add(TBL_CBS);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }

}
