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

public partial class GUI_Operation_Singlescreen_docketentry_DocketPrint_PaidMR_MR_Summ_Popup : System.Web.UI.Page
{
    public static SqlDataReader dr;
    public static string PTCD,PTNAME,DOCKNO,DOCKSF,DOCKDT,Origin,MRSDT,FrightAmount,SerTad,Remark,OtherDedu,TDSAmt;
    public static string Dedu,paymode,NetAmt,Cess,Hedu_Cess,DKT_Tot,ChequeNo,ChequeDt,ChqueAmt,ChqueAcc,BankName;
    public static string MRS_Close, BranchCode, CollAmt, MRSTYPE, EnterBy, PrepareBy, UnAdj;
    public static double UnAdjusted, NetAmount, CollAmount;
    decimal netamttotal, tdsded, frtded, clmded, unexpded, totbill;
    string Number;
    string deciml;
    string _number;
    string _deciml;
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword="";
    protected void Page_Load(object sender, EventArgs e)
    {
        netamttotal = tdsded = clmded = unexpded = totbill = frtded = 0.0M;
        Initialize();
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        lblmrsno.Text = Request.QueryString["mrsno"];

        if (Session["Client"].ToString() == "PRRL")
        {
            imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
        }
        if (Session["Client"].ToString() == "TLL")
        {
            imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
        }
        else if (Session["Client"].ToString() == "EXL")
        {
            imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Varuna")
        {
            imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
        }
        else if (Session["Client"].ToString() == "RITCO")
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }
        else if (Session["Client"].ToString() == "RCPL")
        {
            imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
        }
        else if (Session["Client"].ToString() == "Agility")
        {
            imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
        }
        else if (Session["Client"].ToString() == "ASL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
        }
        else if (Session["Client"].ToString() == "UFL")
        {
            imgLogo.ImageUrl = "~/GUI/images/ufl_logo_NEW.gif";
        }
        else if (Session["Client"].ToString() == "VIJAY")
        {
            imgLogo.ImageUrl = "~/GUI/images/Vijay.JPG";
        }
        else
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }

        String MR_Number = lblmrsno.Text;
        String  paychqdesc;
        String paymode = paychqdesc = "";
        String paydesc = "Cash";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        String Sql = "select MRSSF,convert(varchar,mrsdt,06) as mrsdt,mrsbr,mrbrnnm,ptcd,ptname,ptpin,ptadd,MRSAMT,NETAMT,DEDUCTION,MRSCASH,MRSCHQ,MRSCHQNO,MRSCHQDT,MRSBANKBR,MRSBANK, mrs_closed,paymode from webx_mr_hdr where mrsno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
            lblccode.Text = Convert.ToString((dr["ptcd"]));
            lblbranch.Text = Convert.ToString(Session["brcd"]);
            lbldt.Text = Convert.ToString((dr["mrsdt"]));
            lblpartynm.Text = Convert.ToString((dr["ptname"]));
            paymode = Convert.ToString((dr["paymode"]));
        }
        dr.Close();
        if (paymode.ToUpper() != "CASH")
        {
            Sql = "select chqno,convert(varchar,chqdt,06) as chqdt,chqamt,clamt ,banknm  from  webx_billchqdetail where docno='" + MR_Number + "'";
            sqlCommand = new SqlCommand(Sql, conn);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                if (paychqdesc=="")
                {
                    paychqdesc = "Cheque/D.D. No. " + Convert.ToString(dr["chqno"]) + "  Dated  " + Convert.ToString(dr["chqdt"]) + " on " + Convert.ToString(dr["banknm"]) + " of  Rs. " + Convert.ToString(dr["chqamt"]);
                }
                else
                {
                    paychqdesc = paychqdesc + "Cheque/D.D. No. " + Convert.ToString(dr["chqno"]) + "  Dated  " + Convert.ToString(dr["chqdt"]) + " on " + Convert.ToString(dr["banknm"]) + " of  Rs. " + Convert.ToString(dr["chqamt"]);
                }
            }
            dr.Close(); 
            paydesc = paychqdesc;
        }
        lblmode.Text = paydesc;
        Sql = "select a.totbill,a.netamt,a.tdsded,a.frtded,a.clmded,a.unexpded,a.docno,a.docsf,(select convert(varchar,bgndt,06) from Vw_Billmst_details where billno=a.docno) as bgndt from webx_mrdet_bill a,webx_mr_hdr b where b.mrsno='" + MR_Number + "' and a.mrsno=b.mrsno  order by a.mrsno";
        SqlDataAdapter da = new SqlDataAdapter(Sql, conn);
        DataSet ds = new DataSet();
        da.Fill(ds, "MR");
        GrdPaidFollow.DataSource = ds.Tables["MR"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["MR"].Rows.Count > 0)
        {
            GrdPaidFollow.FooterRow.CssClass = "blackfnt";
            GrdPaidFollow.FooterRow.Cells[0].Text = "Total";
            GrdPaidFollow.FooterRow.Cells[2].Text = Convert.ToString(totbill);
            GrdPaidFollow.FooterRow.Cells[3].Text = Convert.ToString(tdsded);
            GrdPaidFollow.FooterRow.Cells[4].Text = Convert.ToString(frtded);
            GrdPaidFollow.FooterRow.Cells[5].Text = Convert.ToString(clmded);
            GrdPaidFollow.FooterRow.Cells[6].Text = Convert.ToString(unexpded);
            GrdPaidFollow.FooterRow.Cells[7].Text = Convert.ToString(netamttotal);
            amtword = Convert.ToString(netamttotal);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
                //return;
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
                //return;
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }

        }
        
    }
    
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "unexpded")) <= 0)
            {
                ((Label)e.Row.FindControl("lblstar")).Visible = false; 
            }
            totbill = totbill + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "totbill") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "totbill"));
            netamttotal = netamttotal + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "netamt") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "netamt"));
            tdsded = tdsded + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "tdsded") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "tdsded"));
            frtded = frtded + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "frtded") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "frtded"));
            clmded = clmded + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "clmded") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "clmded"));
            unexpded = unexpded + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "unexpded") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "unexpded"));
        }
    }
     public string NameOfNumber(string Number)
    {
        string GroupName = "";
        string OutPut = "";

        if ((Number.Length % 3) != 0)
        {
            Number = Number.PadLeft((Number.Length + (3 - (Number.Length % 3))), '0');
        }
        string[] Array = new string[Number.Length / 3];
        Int16 Element = -1;
        Int32 DisplayCount = -1;
        bool LimitGroupsShowAll = false;
        int LimitGroups = 0;
        bool GroupToWords = true;
        for (Int16 Count = 0; Count <= Number.Length - 3; Count += 3)
        {
            Element += 1;
            Array[Element] = Number.Substring(Count, 3);

        }
        if (LimitGroups == 0)
        {
            LimitGroupsShowAll = true;
        }
        for (Int16 Count = 0; (Count <= ((Number.Length / 3) - 1)); Count++)
        {
            DisplayCount++;
            if (((DisplayCount < LimitGroups) || LimitGroupsShowAll))
            {
                if (Array[Count] == "000") continue;
                {
                    GroupName = US[((Number.Length / 3) - 1) - Count + 1];
                }


                if ((GroupToWords == true))
                {
                    OutPut += Group(Array[Count]).TrimEnd(' ') + " " + GroupName + " ";

                }
                else
                {
                    OutPut += Array[Count].TrimStart('0') + " " + GroupName;

                }
            }

        }
        Array = null;
        return OutPut;

    }


    private string Group(string Argument)
    {
        string Hyphen = "";
        string OutPut = "";
        Int16 d1 = Convert.ToInt16(Argument.Substring(0, 1));
        Int16 d2 = Convert.ToInt16(Argument.Substring(1, 1));
        Int16 d3 = Convert.ToInt16(Argument.Substring(2, 1));
        if ((d1 >= 1))
        {
            OutPut += SNu[d1] + " hundred ";
        }
        if ((double.Parse(Argument.Substring(1, 2)) < 20))
        {
            OutPut += SNu[Convert.ToInt16(Argument.Substring(1, 2))];
        }
        if ((double.Parse(Argument.Substring(1, 2)) >= 20))
        {
            if (Convert.ToInt16(Argument.Substring(2, 1)) == 0)
            {
                Hyphen += " ";
            }
            else
            {
                Hyphen += " ";
            }
            OutPut += SNt[d2] + Hyphen + SNu[d3];
        }
        return OutPut;
    }

    private void Initialize()
    {

        SNu[0] = "";
        SNu[1] = "One";
        SNu[2] = "Two";
        SNu[3] = "Three";
        SNu[4] = "Four";
        SNu[5] = "Five";
        SNu[6] = "Six";
        SNu[7] = "Seven";
        SNu[8] = "Eight";
        SNu[9] = "Nine";
        SNu[10] = "Ten";
        SNu[11] = "Eleven";
        SNu[12] = "Twelve";
        SNu[13] = "Thirteen";
        SNu[14] = "Fourteen";
        SNu[15] = "Fifteen";
        SNu[16] = "Sixteen";
        SNu[17] = "Seventeen";
        SNu[18] = "Eighteen";
        SNu[19] = "Nineteen";
        SNt[2] = "Twenty";
        SNt[3] = "Thirty";
        SNt[4] = "Forty";
        SNt[5] = "Fifty";
        SNt[6] = "Sixty";
        SNt[7] = "Seventy";
        SNt[8] = "Eighty";
        SNt[9] = "Ninety";
        US[1] = "";
        US[2] = "Thousand";
        US[3] = "Million";
        US[4] = "Billion";
        US[5] = "Trillion";
        US[6] = "Quadrillion";
        US[7] = "Quintillion";
        US[8] = "Sextillion";
        US[9] = "Septillion";
        US[10] = "Octillion";
    }
}
