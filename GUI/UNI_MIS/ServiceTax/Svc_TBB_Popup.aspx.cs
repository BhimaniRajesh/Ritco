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

public partial class GUI_UNI_MIS_ServiceTax_Svc_TBB_Popup : System.Web.UI.Page
{
    public static SqlDataReader dr;
    public string BillNo, BillDate, BillAmt, TDS, Freight, Claim, Amount;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        lblMRNO.Text = Request.QueryString["MR_Number"];

        string MR_Number = lblMRNO.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "select MRSSF,mrsdt,mrsbr,mrbrnnm,ptcd,ptname,ptpin,ptadd,MRSAMT,NETAMT,DEDUCTION,MRSCASH,MRSCHQ,MRSCHQNO,MRSCHQDT,MRSBANKBR,MRSBANK, mrs_closed,paymode from webx_mr_hdr where mrsno='" + MR_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
            lblCustNo.Text=dr["ptcd"].ToString();
            lblBranch.Text = dr["mrsbr"].ToString() + " : " + dr["mrbrnnm"].ToString();
            DateTime Date = new DateTime();
            Date = Convert.ToDateTime(dr["mrsdt"]);
            lblDate.Text = Date.ToString("dd/MM/yyyy");
            lblName.Text = dr["ptname"].ToString();
        }
        conn.Close();

        conn.Open();
        string sql1 = "select chqno,chqdt,chqamt,clamt ,banknm  from  webx_billchqdetail where docno='" + MR_Number + "'";
        SqlCommand sqlCommand1 = new SqlCommand(sql1, conn);

        dr = sqlCommand1.ExecuteReader();

        while (dr.Read())
        {
            DateTime Date1 = new DateTime();
            Date1 = Convert.ToDateTime(dr["chqdt"].ToString());
            lblChqueNo.Text = "Cheque/D.D. No." + dr["chqno"].ToString() + " Dated" + Date1.ToString("dd/MM/yyyy") + " on of Rs." + dr["chqamt"].ToString();
        }
        conn.Close();

        conn.Open();
        string sql2 = "select a.totbill,a.netamt,a.tdsded,a.frtded,a.clmded,a.unexpded,a.docno,a.docsf,(select bgndt from Vw_Billmst_details where billno=a.docno) as bgndt from webx_mrdet_bill a,webx_mr_hdr b where b.mrsno='" + MR_Number + "' and a.mrsno=b.mrsno  order by a.mrsno";
        SqlCommand sqlCommand2 = new SqlCommand(sql2, conn);

        dr = sqlCommand2.ExecuteReader();
        double Bill_Amt = 0;
        double TDS_Amt = 0;
        double Fre_Amt = 0;
        double Claim_Amt = 0;
        double Net_Amt = 0;
        while (dr.Read())
        {
            BillNo=dr["docno"].ToString();
            DateTime Date2 = new DateTime();
            Date2 = Convert.ToDateTime(dr["bgndt"]);
            BillDate = Date2.ToString("dd/MM/yyyy");
            BillAmt = dr["totbill"].ToString();
            Bill_Amt += Convert.ToDouble(BillAmt.ToString());
            TDS = dr["tdsded"].ToString();
            TDS_Amt += Convert.ToDouble(TDS.ToString());
            Freight = dr["frtded"].ToString();
            Fre_Amt += Convert.ToDouble(Freight.ToString());
            Claim = dr["clmded"].ToString();
            Claim_Amt += Convert.ToDouble(Claim.ToString());
            Amount = dr["netamt"].ToString();
            Net_Amt += Convert.ToDouble(Amount.ToString());

            lblBillAmt.Text = Bill_Amt.ToString();
            lblTDS.Text = TDS_Amt.ToString();
            lblFreight.Text = Fre_Amt.ToString();
            lblClaim.Text = Claim_Amt.ToString();
            lblAmount.Text = Net_Amt.ToString();
            
        }
        conn.Close();
    }
}
