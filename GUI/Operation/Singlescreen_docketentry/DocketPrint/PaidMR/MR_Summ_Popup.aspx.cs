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
    public static string PTCD, PTNAME, DOCKNO, DOCKSF, DOCKDT, Origin, MRSDT, FrightAmount, SerTad, Remark, OtherDedu, TDSAmt, finclosedt="";
    public static string Dedu, paymode, NetAmt, Cess, Hedu_Cess, DKT_Tot, ChequeNo = "", ChequeDt = "", ChqueAmt = "", ChqueAcc = "", BankName = "";
    public static string MRS_Close, BranchCode, CollAmt, MRSTYPE, EnterBy, PrepareBy, UnAdj;
    public static double UnAdjusted, NetAmount, CollAmount;
    public string MRSNumber;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        MRSNumber = Request.QueryString["mrsno"];
        //lblMRNo.Text = Request.QueryString["mrsno"];
        //lblMRNo.Text = "BLR_/MR/0000006";
        string[] Split = MRSNumber.Split(new Char[] { ',' });
        lblMRNo.Text = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        string MR_Number = lblMRNo.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string Sql = "select isnull(COL_FRT,0) as COL_FRT,isnull(col_STAX,0) as col_STAX,MRS_Closed,isnull(ded_tds,0) as tdsamt , isnull(finclosedt,'') as finclosedt,col_stax+col_cess as STAX,(select csgnnm+' ' +csgnaddr from webx_master_docket where dockno=mh.dockno) as empadd,isnull(Ded_oth,0) as Ded_oth,* from webx_mr_hdr mh where mrsno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
            string MrType = dr["MRSTYPE"].ToString();
            lblManualNo.Text = dr["MANUAL_DOCNO"].ToString();
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
            if (MrType == "6")
            {
                MRSTYPE = "Delivery";
            }
            //PTCD = dr["PTCD"].ToString();
            //PTNAME = dr["PTNAME"].ToString();
            //lblAdd.Text = dr["empadd"].ToString();
            //DOCKNO = dr["DOCKNO"].ToString();
            //DOCKSF = dr["DOCKSF"].ToString();
            //DateTime DOCKDT1 = new DateTime();
            //DateTime DOCKDLYDT1 = new DateTime();            
            
            //if (dr["DOCKDT"].ToString() is DBNull)
            //{
            //    DOCKDT = "-";
            //}
            //else
            //{
            //    DOCKDT1 = Convert.ToDateTime(dr["DOCKDT"].ToString());
            //    DOCKDT = DOCKDT1.ToString("dd MMM yy");
            //    // Response.Write("tst-" + MRSDT);
            //    // Response.End();
            //}
            //Origin = dr["orgncd"].ToString() + " - " + dr["destcd"].ToString();
            //DateTime MRSDT1 = new DateTime();

            //if (dr["MRSDT"].ToString() is DBNull)
            //{
            //    MRSDT = "-";
            //}
            //else
            //{
            //    MRSDT1 = Convert.ToDateTime(dr["MRSDT"].ToString());
            //    MRSDT = MRSDT1.ToString("dd MMM yy");
            //   // Response.Write("tst-" + MRSDT);
            //   // Response.End();
            //}

            //string MrType = dr["MRSTYPE"].ToString();
            PTCD = dr["PTCD"].ToString();
            PTNAME = dr["PTNAME"].ToString();
            if (MrType == "1")
            {
                MRSTYPE = "Paid";
                lblAdd.Text = dr["empadd"].ToString();
            }
            if (MrType == "2")
            {
                MRSTYPE = "TBB";
                lblAdd.Text = dr["empadd"].ToString();
            }
            if (MrType == "3")
            {
                MRSTYPE = "To Pay";
                lblAdd.Text = PTCD + ":" + PTNAME;
            }
            if (MrType == "1")
            {
                partyas.Text = "Consignor";
                lblAdd.Text = dr["empadd"].ToString();
            }
            else if (MrType == "3")
            {
                partyas.Text = "Consignee";
            }
            PTCD = dr["PTCD"].ToString();
            PTNAME = dr["PTNAME"].ToString();
            pasrtyas_code_name.Text = PTCD + ":" + PTNAME;

            DOCKNO = dr["DOCKNO"].ToString();
            DOCKSF = dr["DOCKSF"].ToString();
            DateTime DOCKDT1 = new DateTime();
            DateTime DOCKDLYDT1 = new DateTime();

            if (dr["DOCKDT"].ToString() is DBNull)
            {
                DOCKDT = "-";
            }
            else
            {
                //DOCKDT1 = Convert.ToDateTime(dr["DOCKDT"].ToString());
                //DOCKDT = DOCKDT1.ToString("dd MMM yy");
            }
            Origin = dr["orgncd"].ToString() + " - " + dr["destcd"].ToString();
            DateTime MRSDT1 = new DateTime();

            if (dr["MRSDT"].ToString() is DBNull)
            {
                MRSDT = "-";
            }
            else
            {
                MRSDT1 = Convert.ToDateTime(dr["MRSDT"].ToString());
                MRSDT = MRSDT1.ToString("dd MMM yy");
            }

            DateTime finclosedt1 = new DateTime();

            if (dr["finclosedt"].ToString() == null || dr["finclosedt"].ToString() == "NULL" && dr["finclosedt"].ToString()=="")
            {
                finclosedt = "-";
            }
            else
            {
                finclosedt1 = Convert.ToDateTime(dr["finclosedt"].ToString());
                finclosedt = finclosedt1.ToString("dd MMM yy");//1dr["finclosedt"].ToString();
                if (finclosedt == "01 Jan 00")
                {
                    finclosedt = "-";
                }
                // Response.Write("tst-" + MRSDT);
                // Response.End();
            }
           
            
            FrightAmount = Convert.ToDouble(dr["COL_FRT"].ToString()).ToString("F2");
            SerTad = Convert.ToDouble(dr["col_STAX"].ToString()).ToString("F2");
            Remark = dr["remark"].ToString();
            OtherDedu = Convert.ToDouble(dr["MISCCHRG"].ToString()).ToString("F2");
            TDSAmt = Convert.ToDouble(dr["tdsamt"].ToString()).ToString("F2");
            //Response.Write("tst-" + MRSDT);
           // Response.End();
            if (dr["MRS_Closed"].ToString().Trim() == "Y")
            {
                MRS_Close = "MR Closed";
                UnAdj = "0.0";
                CollAmt = Convert.ToDouble(dr["NETAMT"].ToString()).ToString("F2");
            }
            else
            {
                MRS_Close = "MR Generated";
                CollAmt = "0.00";
            }
            Dedu = Convert.ToDouble(dr["Ded_oth"].ToString()).ToString("F2");
            paymode = dr["paymode"].ToString();
            NetAmount = Convert.ToDouble(dr["NETAMT"].ToString());
           
            NetAmt = Convert.ToDouble(dr["NETAMT"].ToString()).ToString("F2");
            EnterBy = Convert.ToString(dr["entryby"]) + " - " + Convert.ToString(dr["ba_emp_nm"]);
            PrepareBy = Convert.ToString(dr["MRSBR"]) + " : " + Convert.ToString(dr["MRBRNNM"]) + "  " + MRSDT;

        }
        dr.Close();

        Sql = "select * from webx_master_docket_charges where dockno='" + DOCKNO + "'";
        sqlCommand = new SqlCommand(Sql, conn);

        SqlDataReader dr1 = sqlCommand.ExecuteReader();
        while (dr1.Read())
        {
            Cess = Convert.ToDouble(dr1["CESS"].ToString()).ToString("F2");
            Hedu_Cess = Convert.ToDouble(dr1["HEDU_CESS"].ToString()).ToString("F2");
            DKT_Tot = Convert.ToDouble(dr1["Dkttot"].ToString()).ToString("F2");
        }
        dr1.Close();
       // Response.Write("<br>tst-" + paymode);
        //Response.Write("<br>tst-" + MRS_Close);
       //Response.End();
       if (paymode == "Cheque" && MRS_Close == "MR Closed")
        {
            Sql = "select convert(varchar,chqdt,6) chqdt,* from webx_billchqdetail where docno='" + MR_Number + "'";
            sqlCommand = new SqlCommand(Sql, conn);

            SqlDataReader dr2 = sqlCommand.ExecuteReader();
            while (dr2.Read())
            {
                ChequeNo = Convert.ToString(dr2["CHQNO"]);
                ChequeDt = Convert.ToString(dr2["chqdt"].ToString());
                ChqueAmt = Convert.ToDouble(dr2["chqamt"].ToString()).ToString("F2");
                ChqueAcc = Convert.ToDouble(dr2["chqamt"].ToString()).ToString("F2");
                BankName = Convert.ToString(dr2["banknm"].ToString());
                BranchCode = Convert.ToString(dr2["bankbrn"].ToString());
            }
            dr2.Close();
        }
        else
        {
            ChequeNo = "";
            ChequeDt = "";
            ChqueAmt = "";
            ChqueAcc = "";
            BankName = "";
            BranchCode = "";
        }
        conn.Close();

        conn.Open();
        string Sql1 = "select * from webx_billchqdetail where docno='" + MR_Number + "'";

        SqlCommand sqlCommand1 = new SqlCommand(Sql1, conn);

        dr = sqlCommand1.ExecuteReader();

        while (dr.Read())
        {
            if (MRS_Close.Trim().ToUpper() == "Closed".ToUpper())
            {
                UnAdj = "0.0";
            }
            else
            {
                CollAmount = Convert.ToDouble(dr["clamt"].ToString());
                CollAmt = dr["clamt"].ToString();
            }
            //CollAmount = Convert.ToDouble(dr["clamt"].ToString());
            //CollAmt = dr["clamt"].ToString();
        }
        conn.Close();
        //UnAdjusted = NetAmount - CollAmount;
        //UnAdj = UnAdjusted.ToString();
    }
}
