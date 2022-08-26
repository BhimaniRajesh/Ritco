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
    public string FromDt, ToDt, BillDt, MRBRNNM, DueDt, partyno, AggrementNo, billcolbrcd, billsubbrcd, ManualBillno;
    public string warechrg, vehdetchrg, dischrg, handchrg, rentalcharg, othchrg, hedu_cess, servicetax, cesstax, sbccess,kkccess, total, print_yn;
   
    public string BillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        double warechrg_d, vehdetchrg_d, dischrg_d, handchrg_d, rentalcharg_d, othchrg_d, hedu_cess_d, servicetax_d, cesstax_d, sbccess_d, total_d, kkccess_d;
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
        string Sql = "select * from webx_billmst where billno='" + Bill_Number + "'";
        SqlCommand sqlCommand = new SqlCommand(Sql, conn);

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

            partyno = dr["PTMSCD"].ToString();
            AggrementNo = dr["AggrementNo"].ToString();
            billcolbrcd = dr["billcolbrcd"].ToString();
            billsubbrcd = dr["billsubbrcd"].ToString();
            //string bbrcd = dr["bbrcd"].ToString();

            warechrg_d = Convert.ToDouble(dr["warechrg"].ToString());
            vehdetchrg_d = Convert.ToDouble(dr["vehdetchrg"].ToString());
            dischrg_d = Convert.ToDouble(dr["dischrg"].ToString());
            handchrg_d = Convert.ToDouble(dr["handchrg"].ToString());
            rentalcharg_d = Convert.ToDouble(dr["rentalcharg"].ToString());
            othchrg_d = Convert.ToDouble(dr["othchrg"].ToString());
            hedu_cess_d = Convert.ToDouble(dr["hedu_cess"].ToString());
            servicetax_d = Convert.ToDouble(dr["svrcamt"].ToString());
            cesstax_d = Convert.ToDouble(dr["cessamt"].ToString());
            sbccess_d = Convert.ToDouble(dr["sbcamt"].ToString());
            kkccess_d = Convert.ToDouble(dr["kkcamt"].ToString());
            total_d = Convert.ToDouble(dr["BILLAMT"].ToString());

            warechrg = warechrg_d.ToString("F2");
            vehdetchrg = vehdetchrg_d.ToString("F2");
            dischrg = dischrg_d.ToString("F2");
            handchrg = handchrg_d.ToString("F2");
            rentalcharg = rentalcharg_d.ToString("F2");
            othchrg = othchrg_d.ToString("F2");
            hedu_cess = hedu_cess_d.ToString("F2");

            cesstax = cesstax_d.ToString("F2");
            servicetax = servicetax_d.ToString("F2");
            sbccess = sbccess_d.ToString("F2");
            kkccess = kkccess_d.ToString("F2");
            total = total_d.ToString("F2");

        }
        conn.Close();
       
    }
}
