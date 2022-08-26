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
    public string MRSDT,strMRSNo, MRSTYPE, MRSBR, MRBRNNM,DOCKNO, DOCKSF,DOCKDT,DOCKDLYDT,PTCD, PTNAME, PTPIN,PTTEL,bookbr,delbr;
    public string PTADD,ORGNCD,DOCBKNM,DESTCD, DOCDLNM, NOPKGS,CHRGWT,PAYBAS,DELBASD,MRSAMT,paymode,MRSCASH,MRSCHQ;
    public string FrightAmount, TDSRate, SerTad, TDSAmt, OtherDedu, Total, NetAmt, PayMode, CollAmt, Remark;
    public string frt, octamt, octper, clrchg, procper, procchg, othchg, stax, cess, hcess, tot, repno, repdt;
    public string ChequeNo, ChequeDate, BankName;
    public string Ptrinyn = "", boxbg = "boxbg", bluefnt = "bluefnt", bgbluegrey = "bgbluegrey";


    protected void Page_Load(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

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
        else
        {
            imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
        }

        strMRSNo = Request.QueryString["mrsno"];
        string[] Split = strMRSNo.Split(new Char[] { ',' });
        lblMRNo.Text = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);

        //lblMRNo.Text = Request.QueryString["mrsno"];
        //Ptrinyn = Request.QueryString["printyn"].ToString();
        //lblMRNo.Text = "BLR_/MR/0000001";
        boxbg = "boxbg";
        bluefnt = "bluefnt";
        bgbluegrey = "bgbluegrey";
        if (print_yn == "1")
        {
            boxbg = "std";
            bluefnt = "blackfnt";
            bgbluegrey = "bgwhite";
        }

        string MR_Number = lblMRNo.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string Sql = "select convert(varchar,MRSDT,06) as MRSDT,isnull(ded_tds,0) as ded_tds,isnull(ded_oth,0) as ded_oth,isnull(Miscchrg,0) as Mischrg,isnull(tds_rate,0) as tds_rate,isnull(Netamt,0) as Netamt,isnull(mrsamt,0) as mrsamt,orgncd=(select orgncd from webx_master_docket where dockno=a.dockno ),*,(select destcd from webx_master_docket where dockno=a.dockno) as delbr,(select chrgwt from webx_master_docket where dockno=a.dockno) as chrgwt,(select pkgsno from webx_master_docket where dockno=a.dockno) as pkgsno  from webx_mr_hdr a where mrsno='" + MR_Number.Trim() + "'";

       // string Sql = "select * from webx_mr_hdr where mrsno='" + MR_Number + "' union select * from webx_mr_hdr_arch where mrsno='" + MR_Number + "'select * from webx_billchqdetail where docno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        { 
        MR_Number=dr["MRSNO"].ToString();


            MR_Number=dr["MRSNO"].ToString();
            MRSTYPE = "Octroi MR";
                //dr["MRStype"].ToString();
            FrightAmount = dr["Mischrg"].ToString();
            TDSRate = dr["tds_rate"].ToString();
            OtherDedu = dr["ded_oth"].ToString();
            TDSAmt = dr["ded_tds"].ToString();
            NetAmt = dr["Netamt"].ToString();

            CollAmt = dr["Netamt"].ToString();
            PTCD=dr["ptcd"].ToString();
            PTCD += " : "+dr["ptname"].ToString();

            bookbr = dr["orgncd"].ToString();
            bookbr +=" : " + fn.GetLocation(bookbr);
            delbr = dr["delbr"].ToString();
            delbr  +=" : " + fn.GetLocation(delbr); 

            MRSBR=dr["MRSbr"].ToString();
            MRSBR += " : " + fn.GetLocation(MRSBR);

            MRSDT=dr["MRSDT"].ToString();

           





        
        }
        conn.Close();

        conn.Open();
        string Sql2 = "Select remark=(select top 1 h.remark as remark from webx_mr_hdr h where h.MRSNO=d.MRSNO),d.* from webx_mr_det d where d.mrsno='" + MR_Number + "'";

        // string Sql = "select * from webx_mr_hdr where mrsno='" + MR_Number + "' union select * from webx_mr_hdr_arch where mrsno='" + MR_Number + "'select * from webx_billchqdetail where docno='" + MR_Number + "'";
        SqlCommand sqlCommand2 = new SqlCommand(Sql2, conn);

        SqlDataReader dr2;
        dr2 = sqlCommand2.ExecuteReader();

        while (dr2.Read())
        {
            DOCKNO = dr2["dockno"].ToString();
            octamt = dr2["octamt"].ToString();
            octper = dr2["oct_percentage"].ToString();
            clrchg = dr2["clearance_chrg"].ToString();
            procchg = dr2["process_chrg"].ToString();
            procper = dr2["processing_per"].ToString();
            othchg = dr2["otchg"].ToString();
            stax = dr2["oct_svctax"].ToString();
            cess = dr2["oct_cess"].ToString();
            hcess = dr2["oct_high_cess"].ToString();
            Total = dr2["tot"].ToString();
            repdt = Convert.ToDateTime(dr2["recptdt"]).ToString("dd MMM yy");
            repno = dr2["recptno"].ToString();
            Remark = dr2["remark"].ToString();
 


        }
        conn.Close();
        
        conn.Open();
        string Sql1 = "select chqno,convert(varchar,chqdt,06) as chqdt,banknm from webx_billchqdetail where docno='" + MR_Number + "'";
        SqlCommand sqlCommand1 = new SqlCommand(Sql1, conn);

        dr = sqlCommand1.ExecuteReader();

        while (dr.Read())
        {
            ChequeNo = Convert.ToString(dr["chqno"]);
            ChequeDate = Convert.ToString(dr["chqdt"]);
            BankName = Convert.ToString(dr["banknm"]);
        }
        conn.Close();
    }
}
