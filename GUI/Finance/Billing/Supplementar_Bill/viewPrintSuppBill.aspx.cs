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
    public string Subtot, FromDt, ToDt, BillDt, MRBRNNM, DueDt, partyno, AggrementNo, billcolbrcd, billsubbrcd, ManualBillno;
    public string Commisionchrg, warechrg, vehdetchrg, dischrg, handchrg, rentalcharg, othchrg, hedu_cess, servicetax, cesstax,total, print_yn,SBC,KKC;
    public string Account, billdetNarration, billmstNarration, docdetail;
    public string BillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        double Subtot_d, Commisionchrg_d, warechrg_d, vehdetchrg_d, dischrg_d, handchrg_d, rentalcharg_d, othchrg_d, hedu_cess_d, servicetax_d, cesstax_d, total_d,SBC_d, KKC_d;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        //BillNo = Request.QueryString["billno"];
        //lblMRNo.Text = "BLR_/MR/0000001";
        BillNo = Convert.ToString(Request.QueryString["billno"]);

        string[] Split = BillNo.Split(new Char[] { ',' });
        BillNo = Convert.ToString(Split[0]);
        lblBillno.Text = BillNo;
        string print_yn = Convert.ToString(Split[1]);
        imgLogo.Src = "../../../images/" + Session["logofile"];



        string Bill_Number = lblBillno.Text;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WebXpressForNet;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string Sql_bill = "select a.billno,a.manualbillno,BDATEFROM,BDATETO,BGNDT,BDUEDT,PTMSCD,PTMSNM,AggrementNo,";
        Sql_bill += "billsubbrcd,billcolbrcd,a.Narration as billmstNarration,a.svrcamt,a.cessamt,a.hedu_cess,a.SBCAMT,a.KKCAMT,a.BILLAMT,b.dockno + ':' + b.doctype as docdetail,";
        Sql_bill += "c.Company_Acccode + ' : ' + c.accdesc as Account,a.subtotel,cast(b.totamt as decimal(9,2)) totamt,b.Narration as billdetNarration";
        Sql_bill += " From webx_billmst a,webx_billdet b,webx_acctinfo c";
        Sql_bill += " where a.billno=b.billno  and c.acccode = b.acccode and a.billno='" + BillNo + "'";

        SqlCommand sqlCommand = new SqlCommand(Sql_bill, conn);
        dr = sqlCommand.ExecuteReader();

        while (dr.Read())
        {
            
            ManualBillno = dr["manualbillno"].ToString();

            DateTime FromDt1 = new DateTime();
            FromDt1 = Convert.ToDateTime(dr["BDATEFROM"].ToString());
            FromDt = FromDt1.ToString("dd MMM yy");

            DateTime ToDt1 = new DateTime();
            ToDt1 = Convert.ToDateTime(dr["BDATETO"].ToString());
            ToDt = ToDt1.ToString("dd MMM yy");

            DateTime BillDt1 = new DateTime();
            BillDt1 = Convert.ToDateTime(dr["BGNDT"].ToString());
            BillDt = BillDt1.ToString("dd MMM yy");

            DateTime DueDt1 = new DateTime();
            DueDt1 = Convert.ToDateTime(dr["BDUEDT"].ToString());
            DueDt = DueDt1.ToString("dd MMM yy");

            partyno = dr["PTMSCD"].ToString() + ":" + dr["PTMSNM"].ToString();
            AggrementNo = dr["AggrementNo"].ToString();
            billcolbrcd = dr["billcolbrcd"].ToString();
            billsubbrcd = dr["billsubbrcd"].ToString();
            Account = dr["Account"].ToString();
            billmstNarration = dr["billmstNarration"].ToString();
            billdetNarration = dr["billdetNarration"].ToString();
            docdetail = dr["docdetail"].ToString();
            Subtot_d = Convert.ToDouble(dr["subtotel"].ToString());

            //string bbrcd = dr["bbrcd"].ToString();

            hedu_cess_d = Convert.ToDouble(dr["hedu_cess"].ToString());
            servicetax_d = Convert.ToDouble(dr["svrcamt"].ToString());
            cesstax_d = Convert.ToDouble(dr["cessamt"].ToString());
            SBC_d = Convert.ToDouble(dr["SBCAMT"].ToString());
            KKC_d = Convert.ToDouble(dr["KKCAMT"].ToString()); 
            total_d = Convert.ToDouble(dr["BILLAMT"].ToString());

            hedu_cess = hedu_cess_d.ToString("F2");
            cesstax = cesstax_d.ToString("F2");
            servicetax = servicetax_d.ToString("F2");
            SBC = SBC_d.ToString("F2");
            KKC = KKC_d.ToString("F2");
            total = total_d.ToString("F2");
            Subtot = Subtot_d.ToString("F2");
        }
        conn.Close();

        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(Sql_bill, conn);
        DataTable dt = new DataTable();
        da.Fill(dt);

        Repeater2.DataSource = dt;
        Repeater2.DataBind();
        conn.Close();
    }
}
