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
    public static string MRS_Close, BranchCode, CollAmt, MRSTYPE, EnterBy, PrepareBy, UnAdj, EnterAt, PrepareAt;
    public static double UnAdjusted, NetAmount, CollAmount;
    public static System.DateTime righnow = System.DateTime.Today;   
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        lblMRNo.Text = Request.QueryString["mrsno"];
        //lblMRNo.Text = "AMD_/MR/0000011";

        string MR_Number = lblMRNo.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=varuna.net;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string Sql = "select col_stax+col_cess as STAX,(select csgnnm+' ' +csgnaddr from webx_master_docket where dockno=mh.dockno) as empadd,* from webx_mr_hdr mh where mrsno='" + MR_Number + "' union select col_stax+col_cess as STAX,(select csgnnm+' ' +csgnaddr from webx_master_docket where dockno=mha.dockno) as empadd,* from webx_mr_hdr mha where mrsno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
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
            PTCD = dr["PTCD"].ToString();
            PTNAME = dr["PTNAME"].ToString();
            lblAdd.Text = dr["empadd"].ToString();
            DOCKNO = dr["DOCKNO"].ToString();
            DOCKSF = dr["DOCKSF"].ToString();
            if (dr["DOCKDT"] is DBNull)
            {
                DOCKDT = "-";
            }
            else
            {
                DOCKDT = Convert.ToDateTime(dr["DOCKDT"].ToString()).ToString("dd MMM yy");
            }
            if (dr["MRSDT"] is DBNull)
            {
                MRSDT = "-";
            }
            else
            {
                MRSDT = Convert.ToDateTime(dr["MRSDT"].ToString()).ToString("dd MMM yy");
            }
            //DateTime DOCKDT1 = new DateTime();
            //DateTime DOCKDLYDT1 = new DateTime();            
            //if (dr["DOCKDT"].ToString() is DBNull)
            //{
            //    DOCKDT1 = Convert.ToDateTime(dr["DOCKDT"].ToString());
            //    DOCKDT = DOCKDT1.ToString("dd MMM yy");
            //}
            Origin = dr["orgncd"].ToString() + " - " + dr["destcd"].ToString();
            //DateTime MRSDT1 = new DateTime();
            //if (dr["MRSDT"].ToString() is DBNull)
            //{
            //    MRSDT1 = Convert.ToDateTime(dr["MRSDT"].ToString());
            //    MRSDT = MRSDT1.ToString("dd MMM yy");
            //}
            FrightAmount = dr["COL_FRT"].ToString();
            SerTad = dr["col_STAX"].ToString();
            Remark = dr["remark"].ToString();
            OtherDedu = dr["OthChrg_frt"].ToString();
            TDSAmt = dr["ded_tds"].ToString();
            if (dr["MRS_Closed"].ToString().Trim() == "Y")
            {
                MRS_Close = "Close";
                UnAdj = "0.0";
            }
            Dedu = dr["Deduction"].ToString();
            paymode = dr["paymode"].ToString();
            NetAmount = Convert.ToDouble(dr["NETAMT"].ToString());
            NetAmt = dr["NETAMT"].ToString();
            EnterBy = Convert.ToString(dr["entryby"]) + " - " + Convert.ToString(dr["ba_emp_nm"]);
            PrepareBy = Convert.ToString(dr["MRSBR"]) + " : " + Convert.ToString(dr["MRBRNNM"]) + "  " + MRSDT;
                     
            EnterAt = Session["brcd"].ToString() + " - " + righnow.ToString("dd MMM yy");
            PrepareAt = Session["empcd"] + " - " + Session["empnm"];

        }
        dr.Close();

        Sql = "select * from webx_master_docket_charges where dockno='" + DOCKNO + "'";
        sqlCommand = new SqlCommand(Sql, conn);

        SqlDataReader dr1 = sqlCommand.ExecuteReader();
        while (dr1.Read())
        {
            Cess = dr1["CESS"].ToString();
            Hedu_Cess = dr1["HEDU_CESS"].ToString();
            DKT_Tot = dr1["Dkttot"].ToString();
        }
        dr1.Close();
        Sql = "select convert(varchar,chqdt,6) chqdt,* from webx_billchqdetail where docno='" + MR_Number + "'";
        sqlCommand = new SqlCommand(Sql, conn);

        SqlDataReader dr2 = sqlCommand.ExecuteReader();
        while (dr2.Read())
        {
            ChequeNo = Convert.ToString(dr2["CHQNO"]);
            ChequeDt = Convert.ToString(dr2["chqdt"].ToString());
            ChqueAmt = Convert.ToString(dr2["chqamt"].ToString());
            ChqueAcc = Convert.ToString(dr2["chqamt"].ToString());
            BankName = Convert.ToString(dr2["banknm"].ToString());
            BranchCode = Convert.ToString(dr2["bankbrn"].ToString());
        }
        dr2.Close();
        conn.Close();

        conn.Open();
        string Sql1 = "select * from webx_billchqdetail where docno='" + MR_Number + "'";

        SqlCommand sqlCommand1 = new SqlCommand(Sql1, conn);

        dr = sqlCommand1.ExecuteReader();

        while (dr.Read())
        {
            if (MRS_Close.Trim().ToUpper() == "Close".ToUpper())
            {
                UnAdj = "0.0";
            }
            else
            {
                CollAmount = Convert.ToDouble(dr["clamt"].ToString());
                CollAmt = dr["clamt"].ToString();
                UnAdjusted = NetAmount - CollAmount;
                UnAdj = UnAdjusted.ToString();
            }
            //CollAmount = Convert.ToDouble(dr["clamt"].ToString());
            //CollAmt = dr["clamt"].ToString();
        }
        conn.Close();
        
    }
}
