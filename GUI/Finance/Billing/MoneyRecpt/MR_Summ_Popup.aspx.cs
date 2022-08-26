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


public partial class GUI_UNI_MIS_MR_Summary_MR_Summ_Popup : System.Web.UI.Page
{
    public static SqlDataReader dr;
    public string MRSDT, MRSTYPE, MRSBR, MRBRNNM,DOCKNO, DOCKSF,DOCKDT,DOCKDLYDT,PTCD, PTNAME, PTPIN,PTTEL;
    public string PTADD,ORGNCD,DOCBKNM,DESTCD, DOCDLNM, NOPKGS,CHRGWT,PAYBAS,DELBASD,MRSAMT,paymode,MRSCASH,MRSCHQ;
    public string FrightAmount, TDSRate, SerTad, TDSAmt, OtherDedu, Total, NetAmt, PayMode, CollAmt, Remark;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        lblMRNo.Text = Request.QueryString["mrno"];
        //lblMRNo.Text = "BLR_/MR/0000001";

        string MR_Number = lblMRNo.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string Sql = "select * from webx_mr_hdr where mrsno='" + MR_Number + "' union select * from webx_mr_hdr_arch where mrsno='" + MR_Number + "'select * from webx_billchqdetail where docno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
            //MRSNO = dr["MRSNO"].ToString();
            DateTime MRSDT1 = new DateTime();
            MRSDT1 =Convert.ToDateTime(dr["MRSDT"].ToString());
            MRSDT = MRSDT1.ToString("dd MMM yy");
            //MRSTYPE = dr["MRSTYPE"].ToString();
            string MrType = dr["MRSTYPE"].ToString();
            if (MrType == "1")
            {
                MRSTYPE = "Paid";
            }
            if (MrType == "2")
            {
                MRSTYPE = "TBB";
            }
            if (MrType == "3")
            {
                MRSTYPE = "To Pay";
            }   
            MRSBR = dr["MRSBR"].ToString();
            MRBRNNM = dr["MRBRNNM"].ToString();
            DOCKNO = dr["DOCKNO"].ToString();
            DOCKSF = dr["DOCKSF"].ToString();
            DateTime DOCKDT1 = new DateTime();
            DateTime DOCKDLYDT1 = new DateTime();
            DOCKDT1 = Convert.ToDateTime(dr["DOCKDT"].ToString());
            DOCKDT = DOCKDT1.ToString("dd MMM yy");
            DOCKDLYDT1 = Convert.ToDateTime(dr["DOCKDLYDT"]);
            DOCKDLYDT = DOCKDLYDT1.ToString("dd MMM yy");
            PTCD = dr["PTCD"].ToString();
            PTNAME = dr["PTNAME"].ToString();
            PTPIN = dr["PTPIN"].ToString();
            PTTEL = dr["PTTEL"].ToString();
            PTADD = dr["PTADD"].ToString();
            ORGNCD = dr["ORGNCD"].ToString();
            DOCBKNM = dr["DOCBKNM"].ToString();
            DESTCD = dr["DESTCD"].ToString();
            DOCDLNM = dr["DOCDLNM"].ToString();
            NOPKGS = dr["NOPKGS"].ToString();
            CHRGWT = dr["CHRGWT"].ToString();
            PAYBAS = dr["PAYBAS"].ToString();
            DELBASD = dr["DELBASD"].ToString();
            MRSAMT = dr["MRSAMT"].ToString();
            //paymode = dr["paymode"].ToString();
            MRSCASH = dr["MRSCASH"].ToString();
            MRSCHQ = dr["MRSCHQ"].ToString();

            FrightAmount = dr["col_frt"].ToString();
            TDSRate = dr["tds_rate"].ToString();
            SerTad = dr["col_stax"].ToString();
            TDSAmt = dr["ded_tds"].ToString();
            OtherDedu = dr["ded_oth"].ToString();
            double mischarge = Convert.ToDouble(dr["miscchrg"].ToString());
            double col_stax = Convert.ToDouble(dr["col_stax"].ToString());
            double col_frt = Convert.ToDouble(dr["col_frt"].ToString());
            double mis, stax, frt, TotalAmt;
            if (mischarge.ToString() != null && mischarge.ToString() != "")
            {
                mis = mischarge;
            }
            else
            {
                mis = 0;
            }
            if (col_stax.ToString() != null && col_stax.ToString() != "")
            {
                stax = col_stax;
            }
            else
            {
                stax = 0;
            }
            if(col_frt.ToString() != null && col_frt.ToString() !="")
            {
                frt = col_frt;
            }
            else
            {
                frt=0;
            }
            TotalAmt = mis + stax + frt;
            Total = TotalAmt.ToString();

            double ded = Convert.ToDouble(dr["ded_tds"].ToString());
            double ded_oth = Convert.ToDouble(dr["ded_oth"].ToString());
            double DedAmt,DedAmount;
            if(ded.ToString() != null && ded.ToString() !="")
            {
                DedAmt = ded;
            }
            else
            {
                DedAmt = 0;
            }
            if (ded_oth.ToString() != null && ded_oth.ToString() != "")
            {
                DedAmount = ded_oth;
            }
            else
            {
                DedAmount = 0;
            }
            double NetAmt1 = TotalAmt - DedAmt - DedAmount;
            NetAmt = NetAmt1.ToString();
            //PayMode = dr["paymode"].ToString();
            Remark = dr["remark"].ToString();            
        }
        conn.Close();
        
        conn.Open();
        string Sql1 = "select * from webx_billchqdetail where docno='" + MR_Number + "'";
        SqlCommand sqlCommand1 = new SqlCommand(Sql1, conn);

        dr = sqlCommand1.ExecuteReader();

        while (dr.Read())
        {
            CollAmt = dr["chqamt"].ToString();
        }
        conn.Close();
    }
}
