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
    public static string PTCD, PTNAME, DOCKNO, DOCKSF, DOCKDT, Origin, MRSDT, FrightAmount, SerTad, Remark, OtherDedu, TDSAmt;
    public static string Dedu, paymode, NetAmt, Cess, Hedu_Cess, DKT_Tot, ChequeNo, ChequeDt, ChqueAmt, ChqueAcc, BankName;
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
    string amtword = "";
    double Total_NetAmt = 0, UnExpectedAmt = 0, ClaimAmt = 0, FreightDed = 0, TotTDSAmt = 0, BillAmt = 0;
    int i = 0;
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

        string logo = Session["logofile"].ToString();
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
        else if (Session["Client"].ToString() == "RLL")
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.jpg";
        }
        else
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }


        String MR_Number = lblmrsno.Text;
        String paychqdesc;
        String paymode = paychqdesc = "";
        String paydesc = "Cash";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        //String Sql = "select MRSSF,convert(varchar,mrsdt,106) as mrsdt,mrsbr,mrbrnnm,ptcd,ptname,ptpin,ptadd,MRSAMT,NETAMT,DEDUCTION,MRSCASH,MRSCHQ,MRSCHQNO,MRSCHQDT,MRSBANKBR,MRSBANK, isNULL(mrs_closed,'N') as mrs_closed,paymode,mr_cancel from webx_mr_hdr where mrsno='" + MR_Number + "'";
        string Sql = "select s.THC_VEHNO,m.MRSSF,convert(varchar,m.mrsdt,106) as mrsdt,m.mrsbr,m.mrbrnnm,m.ptcd,m.ptname,m.ptpin,m.ptadd,m.MRSAMT,m.NETAMT,m.DEDUCTION,m.MRSCASH,m.MRSCHQ,m.MRSCHQNO,m.MRSCHQDT,m.MRSBANKBR,m.MRSBANK,m.mrs_closed,m.paymode,mr_cancel from webx_mr_hdr m Left Outer Join webx_trans_docket_status s on s.dockno=m.dockno and s.THC_VEHNO is NOT NULL where m.mrsno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
            lblccode.Text = Convert.ToString((dr["ptcd"]));
            lblbranch.Text = Convert.ToString(Session["brcd"]);
            lbldt.Text = Convert.ToString((dr["mrsdt"]));
            lblpartynm.Text = Convert.ToString((dr["ptname"]));
            paymode = Convert.ToString((dr["paymode"]));

            if (Convert.ToString(dr["mr_cancel"]) == "Y")
            {
                lblStatus.Text = "MR Cancelled";
            }
            else if (Convert.ToString(dr["mrs_closed"]) == "Y")
            {
                lblStatus.Text = "MR Close";
            }
            else if (Convert.ToString(dr["mrs_closed"]) == "N")
            {
                lblStatus.Text = "MR Generated";
            }
            lblVehNo.Text = Convert.ToString(dr["THC_VEHNO"]);

        }
        dr.Close();
        if (paymode.ToUpper() != "CASH")
        {
            Sql = "select chqno,convert(varchar,chqdt,106) as chqdt,chqamt,clamt ,banknm  from  webx_billchqdetail where docno='" + MR_Number + "'";
            sqlCommand = new SqlCommand(Sql, conn);
            dr = sqlCommand.ExecuteReader();
            while (dr.Read())
            {
                if (paychqdesc == "")
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
        Sql = "exec Webx_MR_View_Ver1 '" + MR_Number + "'";
        SqlDataAdapter da = new SqlDataAdapter(Sql, conn);
        DataSet ds = new DataSet();
        da.Fill(ds, "MR");

        GrdPaidFollow.DataSource = ds.Tables["MR"];
        GrdPaidFollow.DataBind();

    }

    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[1].Visible = false;
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Visible = false;
            int cCount = e.Row.Cells.Count;

            for (i = 0; i < cCount; i++)
            {
                if (i > 2)
                {
                    e.Row.Cells[i].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;                    
                }
                if (i == cCount - 1)
                {
                    e.Row.Cells[i].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Left;
                }
            }
            string abc = e.Row.Cells[i - 2].Text.ToString();
            if (e.Row.Cells[i - 2].Text.ToString() == "&nbsp;" || e.Row.Cells[i - 2].Text.ToString() == " ")
            {
                Total_NetAmt = Total_NetAmt + 0.0;
            }
            else
            {
                Total_NetAmt = Total_NetAmt + Convert.ToDouble(e.Row.Cells[i - 2].Text.ToString());
            }

            if (e.Row.Cells[i - 3].Text.ToString() == "&nbsp;" || e.Row.Cells[i - 3].Text.ToString() == " ")
            {
                UnExpectedAmt = UnExpectedAmt + 0.0;
                //e.Row.Cells[i - 3].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            }
            else
            {
                UnExpectedAmt = UnExpectedAmt + Convert.ToDouble(e.Row.Cells[i - 3].Text.ToString());
                //e.Row.Cells[i - 3].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            }
            if (e.Row.Cells[i - 4].Text.ToString() == "&nbsp;" || e.Row.Cells[i - 4].Text.ToString() == " ")
            {
                ClaimAmt = ClaimAmt + 0.0;
                //e.Row.Cells[i - 4].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            }
            else
            {
                ClaimAmt = ClaimAmt + Convert.ToDouble(e.Row.Cells[i - 4].Text.ToString());
                //e.Row.Cells[i - 4].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            }

            if (e.Row.Cells[i - 5].Text.ToString() == "&nbsp;" || e.Row.Cells[i - 5].Text.ToString() == " ")
            {
                FreightDed = FreightDed + 0.0;
                //e.Row.Cells[i - 5].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            }
            else
            {
                FreightDed = FreightDed + Convert.ToDouble(e.Row.Cells[i - 5].Text.ToString());
                //e.Row.Cells[i - 5].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            }

            if (e.Row.Cells[i - 6].Text.ToString() == "&nbsp;" || e.Row.Cells[i - 6].Text.ToString() == " ")
            {
                TotTDSAmt = TotTDSAmt + 0.0;
            }
            else
            {
                TotTDSAmt = TotTDSAmt + Convert.ToDouble(e.Row.Cells[i - 6].Text.ToString());
            }

            if (e.Row.Cells[i - 7].Text.ToString() == "&nbsp;" || e.Row.Cells[i - 7].Text.ToString() == " ")
            {
                BillAmt = BillAmt + 0.0;
            }
            else
            {
                //e.Row.Cells[i - 7].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
                BillAmt = BillAmt + Convert.ToDouble(e.Row.Cells[i - 7].Text.ToString());
            }
            //Total_NetAmt = Total_NetAmt + Convert.ToDouble(e.Row.Cells[i - 1].Text.ToString());
            //UnExpectedAmt = UnExpectedAmt + Convert.ToDouble(e.Row.Cells[i - 2].Text.ToString());
            //ClaimAmt = ClaimAmt + Convert.ToDouble(e.Row.Cells[i - 3].Text.ToString());
            //FreightDed = FreightDed + Convert.ToDouble(e.Row.Cells[i - 4].Text.ToString());
            //TotTDSAmt = TotTDSAmt + Convert.ToDouble(e.Row.Cells[i - 5].Text.ToString());
            //BillAmt = BillAmt + Convert.ToDouble(e.Row.Cells[i - 6].Text.ToString());

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[i - 2].Text = Total_NetAmt.ToString("F2");
            e.Row.Cells[i - 2].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            e.Row.Cells[1].Visible = false;

            e.Row.Cells[i - 3].Text = UnExpectedAmt.ToString("F2");
            e.Row.Cells[i - 3].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            e.Row.Cells[1].Visible = false;

            e.Row.Cells[i - 4].Text = ClaimAmt.ToString("F2");
            e.Row.Cells[i - 4].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            e.Row.Cells[1].Visible = false;

            e.Row.Cells[i - 5].Text = FreightDed.ToString("F2");
            e.Row.Cells[i - 5].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            e.Row.Cells[1].Visible = false;

            e.Row.Cells[i - 6].Text = TotTDSAmt.ToString("F2");
            e.Row.Cells[i - 6].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            e.Row.Cells[1].Visible = false;

            e.Row.Cells[i - 7].Text = BillAmt.ToString("F2");
            e.Row.Cells[i - 7].HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Right;
            e.Row.Cells[1].Visible = false;
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
