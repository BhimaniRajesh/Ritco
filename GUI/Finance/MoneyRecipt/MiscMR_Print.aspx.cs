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

public partial class GUI_Finance_MoneyRecpt_MiscMR_Print : System.Web.UI.Page
{
    public static SqlDataReader dr;
    public string MrsType, PartyCode, PartyName, MrsDate, BranchCode, BranchName, DockNo, DockSf;
    public string DDCharge, DemCharge, WareCharge, MathadiCharge, OtherCharge, SubTot, TDSRate, TDSAmt, OtherDed, NetAmt;
    public string MadeTrans, ChkNo, ChkDate, ChkAmt, OnAcctAmt, AccAmt, BnkBranch, BnkName, CollAmt, TDSType,Remark;
    public string boxbg; 
    public string bgbluegrey ;
    public string strborder;
    public string mode;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();

        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        string mrno = Request.QueryString.Get("mrsno");
        lblMrNo.Text = mrno.ToString();

        mode = Request.QueryString.Get("mode").ToString();
        

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string Sql = "select * from webx_mr_hdr where mrsno='" + mrno + "'";
        //string Sql = "select a.*,b.* from webx_mr_hdr a,webx_chq_det b where a.mrschqno = b.chqno and a.mrsno='"+ mrno +"'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);
        dr = sqlCommand.ExecuteReader();
        while (dr.Read())
        {
            MrsType = dr["mrstype"].ToString();
            PartyCode = dr["ptcd"].ToString();
            PartyName = dr["ptname"].ToString();
            DateTime MRSDT1 = new DateTime();
            MRSDT1 = Convert.ToDateTime(dr["mrsdt"].ToString());
            MrsDate = MRSDT1.ToString("dd MMM yy");
            BranchCode = dr["mrsbr"].ToString();
            BranchName = dr["mrbrnnm"].ToString();
            DockNo = dr["dockno"].ToString();
            DockSf = dr["docksf"].ToString();
            DDCharge = dr["col_door"].ToString();
            DemCharge = dr["col_dem"].ToString();
            WareCharge = dr["col_ware"].ToString();
            MathadiCharge = dr["col_mathadi"].ToString();
            OtherCharge = dr["col_oth"].ToString();
            SubTot = dr["mrsamt"].ToString();
            TDSRate = dr["tds_rate"].ToString();
            TDSAmt = dr["ded_tds"].ToString();
            OtherDed = dr["ded_oth"].ToString(); ;
            NetAmt = dr["netamt"].ToString();
            MadeTrans = dr["paymode"].ToString();
            TDSType = dr["tdsaccdesc"].ToString();
            Remark = dr["remark"].ToString();
            CollAmt = dr["mrscash"].ToString();
            //tblChk.Visible = false;
        }
        dr.Close();

        string Sql1 = "select a.*,b.* from webx_mr_hdr a,webx_chq_det b where a.mrschqno = b.chqno and a.mrsno='"+ mrno +"'";
        SqlCommand sqlCommand1 = new SqlCommand(Sql1, conn);
        SqlDataReader dr1;
        dr1 = sqlCommand1.ExecuteReader();
        while (dr1.Read())
        {
             //tblChk.Visible = true;
            ChkNo = dr1["chqno"].ToString();
            DateTime ChkDate1 = new DateTime();
            ChkDate1 = Convert.ToDateTime(dr1["chqdt"].ToString());
            ChkDate = ChkDate1.ToString("dd MMM yy");
            ChkAmt = dr1["chqamt"].ToString();
            OnAcctAmt = "-";
            AccAmt = dr1["adjustamt"].ToString();
            BnkBranch = dr1["bankbrn"].ToString();
            BnkName = dr1["banknm"].ToString();
            CollAmt = dr1["mrschq"].ToString();

        }
        dr1.Close();
        
    }
}
